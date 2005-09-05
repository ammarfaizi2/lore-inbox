Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbVIEVMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbVIEVMR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVIEVMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:12:17 -0400
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:18366 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932546AbVIEVMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:12:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change behaviour of psmouse-base.c under error conditions.
Date: Mon, 5 Sep 2005 16:12:13 -0500
User-Agent: KMail/1.8.2
Cc: "Bryan O'Donoghue" <typedef@eircom.net>, vojtech@suse.cz
References: <431CB166.40904@eircom.net>
In-Reply-To: <431CB166.40904@eircom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509051612.14180.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 September 2005 15:58, Bryan O'Donoghue wrote:
> 
> However, the KVM in question invariably ends up sending a packet like this
> 
> packet= 0x0 0xff 0x2 0x8
> 
> Which is completely invalid for PS/2 and IMPS/2, the specification of
> PS/2 defines bit 4 in byte 0 as always being 1.
> 
> My patch validates this bit, generating a PSMOUSE_BAD_DATA result code
> if this bit is not set to 1. This has the effect of changing the flow of
> control in psmouse_interrupt such that serio_reconnect(); gets called,
> which is what's actually needed to fixup the error.

Not all mice folow the protocol unfortunately. PLease try instead the
patch below - I hope it will go in as soon as we sort out ALPS troubles
it causes.

Note that it will give some offsets when applying but shoudl work
nonetheless.

-- 
Dmitry

 drivers/input/mouse/alps.c         |   34 ++++
 drivers/input/mouse/logips2pp.c    |    2 
 drivers/input/mouse/psmouse-base.c |  303 +++++++++++++++++++++++++++++--------
 drivers/input/mouse/psmouse.h      |    7 
 4 files changed, 281 insertions(+), 65 deletions(-)

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

Index: work/drivers/input/mouse/psmouse.h
===================================================================
--- work.orig/drivers/input/mouse/psmouse.h
+++ work/drivers/input/mouse/psmouse.h
@@ -7,7 +7,7 @@
 #define PSMOUSE_CMD_GETINFO	0x03e9
 #define PSMOUSE_CMD_SETSTREAM	0x00ea
 #define PSMOUSE_CMD_SETPOLL	0x00f0
-#define PSMOUSE_CMD_POLL	0x03eb
+#define PSMOUSE_CMD_POLL	0x00eb	/* caller sets number of bytes to receive */
 #define PSMOUSE_CMD_GETID	0x02f2
 #define PSMOUSE_CMD_SETRATE	0x10f3
 #define PSMOUSE_CMD_ENABLE	0x00f4
@@ -23,6 +23,7 @@
 enum psmouse_state {
 	PSMOUSE_IGNORE,
 	PSMOUSE_INITIALIZING,
+	PSMOUSE_RESYNCING,
 	PSMOUSE_CMD_MODE,
 	PSMOUSE_ACTIVATED,
 };
@@ -38,9 +39,11 @@ struct psmouse {
 	void *private;
 	struct input_dev dev;
 	struct ps2dev ps2dev;
+	struct work_struct resync_work;
 	char *vendor;
 	char *name;
 	unsigned char packet[8];
+	unsigned char badbyte;
 	unsigned char pktcnt;
 	unsigned char pktsize;
 	unsigned char type;
@@ -54,6 +57,7 @@ struct psmouse {
 	unsigned int rate;
 	unsigned int resolution;
 	unsigned int resetafter;
+	unsigned int resync_time;
 	unsigned int smartscroll;	/* Logitech only */
 
 	psmouse_ret_t (*protocol_handler)(struct psmouse *psmouse, struct pt_regs *regs);
@@ -62,6 +66,7 @@ struct psmouse {
 
 	int (*reconnect)(struct psmouse *psmouse);
 	void (*disconnect)(struct psmouse *psmouse);
+	int (*poll)(struct psmouse *psmouse);
 
 	void (*pt_activate)(struct psmouse *psmouse);
 	void (*pt_deactivate)(struct psmouse *psmouse);
Index: work/drivers/input/mouse/psmouse-base.c
===================================================================
--- work.orig/drivers/input/mouse/psmouse-base.c
+++ work/drivers/input/mouse/psmouse-base.c
@@ -58,10 +58,15 @@ static unsigned int psmouse_resetafter;
 module_param_named(resetafter, psmouse_resetafter, uint, 0644);
 MODULE_PARM_DESC(resetafter, "Reset device after so many bad packets (0 = never).");
 
+static unsigned int psmouse_resync_time = 5;
+module_param_named(resync_time, psmouse_resync_time, uint, 0644);
+MODULE_PARM_DESC(resync_time, "How long can mouse stay idle before forcing resync (in seconds, 0 = never).");
+
 PSMOUSE_DEFINE_ATTR(protocol);
 PSMOUSE_DEFINE_ATTR(rate);
 PSMOUSE_DEFINE_ATTR(resolution);
 PSMOUSE_DEFINE_ATTR(resetafter);
+PSMOUSE_DEFINE_ATTR(resync_time);
 
 __obsolete_setup("psmouse_noext");
 __obsolete_setup("psmouse_resolution=");
@@ -78,6 +83,8 @@ __obsolete_setup("psmouse_rate=");
  */
 static DECLARE_MUTEX(psmouse_sem);
 
+static struct workqueue_struct *kpsmoused_wq;
+
 struct psmouse_protocol {
 	enum psmouse_type type;
 	char *name;
@@ -158,15 +165,79 @@ static psmouse_ret_t psmouse_process_byt
 }
 
 /*
- * psmouse_interrupt() handles incoming characters, either gathering them into
- * packets or passing them to the command routine as command output.
+ * __psmouse_set_state() sets new psmouse state and resets all flags.
+ */
+
+static inline void __psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state)
+{
+	psmouse->state = new_state;
+	psmouse->pktcnt = psmouse->out_of_sync = 0;
+	psmouse->ps2dev.flags = 0;
+	psmouse->last = jiffies;
+}
+
+
+/*
+ * psmouse_set_state() sets new psmouse state and resets all flags and
+ * counters while holding serio lock so fighting with interrupt handler
+ * is not a concern.
+ */
+
+static void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state)
+{
+	serio_pause_rx(psmouse->ps2dev.serio);
+	__psmouse_set_state(psmouse, new_state);
+	serio_continue_rx(psmouse->ps2dev.serio);
+}
+
+/*
+ * psmouse_handle_byte() processes one byte of the input data stream
+ * by calling corresponding protocol handler.
+ */
+
+static int psmouse_handle_byte(struct psmouse *psmouse, struct pt_regs *regs)
+{
+	psmouse_ret_t rc = psmouse->protocol_handler(psmouse, regs);
+
+	switch (rc) {
+		case PSMOUSE_BAD_DATA:
+			if (psmouse->state == PSMOUSE_ACTIVATED) {
+				printk(KERN_WARNING "psmouse.c: %s at %s lost sync at byte %d\n",
+					psmouse->name, psmouse->phys, psmouse->pktcnt);
+				if (++psmouse->out_of_sync == psmouse->resetafter) {
+					__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
+					printk(KERN_NOTICE "psmouse.c: issuing reconnect request\n");
+					serio_reconnect(psmouse->ps2dev.serio);
+					return -1;
+				}
+			}
+			psmouse->pktcnt = 0;
+			break;
+
+		case PSMOUSE_FULL_PACKET:
+			psmouse->pktcnt = 0;
+			if (psmouse->out_of_sync) {
+				psmouse->out_of_sync = 0;
+				printk(KERN_NOTICE "psmouse.c: %s at %s - driver resynched.\n",
+					psmouse->name, psmouse->phys);
+			}
+			break;
+
+		case PSMOUSE_GOOD_DATA:
+			break;
+	}
+	return 0;
+}
+
+/*
+ * psmouse_interrupt() handles incoming characters, either passing them
+ * for normal processing or gathering them as command response.
  */
 
 static irqreturn_t psmouse_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct psmouse *psmouse = serio_get_drvdata(serio);
-	psmouse_ret_t rc;
 
 	if (psmouse->state == PSMOUSE_IGNORE)
 		goto out;
@@ -188,67 +259,58 @@ static irqreturn_t psmouse_interrupt(str
 		if  (ps2_handle_response(&psmouse->ps2dev, data))
 			goto out;
 
-	if (psmouse->state == PSMOUSE_INITIALIZING)
+	if (psmouse->state <= PSMOUSE_RESYNCING)
 		goto out;
 
 	if (psmouse->state == PSMOUSE_ACTIVATED &&
 	    psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/2)) {
-		printk(KERN_WARNING "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n",
+		printk(KERN_INFO "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n",
 		       psmouse->name, psmouse->phys, psmouse->pktcnt);
-		psmouse->pktcnt = 0;
+		psmouse->badbyte = psmouse->packet[0];
+		__psmouse_set_state(psmouse, PSMOUSE_RESYNCING);
+		queue_work(kpsmoused_wq, &psmouse->resync_work);
+		goto out;
 	}
 
-	psmouse->last = jiffies;
 	psmouse->packet[psmouse->pktcnt++] = data;
-
-	if (psmouse->packet[0] == PSMOUSE_RET_BAT) {
+/*
+ * Check if this is a new device announcement (0xAA 0x00)
+ */
+	if (unlikely(psmouse->packet[0] == PSMOUSE_RET_BAT && psmouse->pktcnt <= 2)) {
 		if (psmouse->pktcnt == 1)
 			goto out;
 
-		if (psmouse->pktcnt == 2) {
-			if (psmouse->packet[1] == PSMOUSE_RET_ID) {
-				psmouse->state = PSMOUSE_IGNORE;
-				serio_reconnect(serio);
-				goto out;
-			}
-			if (psmouse->type == PSMOUSE_SYNAPTICS) {
-				/* neither 0xAA nor 0x00 are valid first bytes
-				 * for a packet in absolute mode
-				 */
-				psmouse->pktcnt = 0;
-				goto out;
-			}
+		if (psmouse->packet[1] == PSMOUSE_RET_ID) {
+			__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
+			serio_reconnect(serio);
+			goto out;
 		}
-	}
-
-	rc = psmouse->protocol_handler(psmouse, regs);
+/*
+ * Not a new device, try processing first byte normally
+ */
+		psmouse->pktcnt = 1;
+		if (psmouse_handle_byte(psmouse, regs))
+			goto out;
 
-	switch (rc) {
-		case PSMOUSE_BAD_DATA:
-			printk(KERN_WARNING "psmouse.c: %s at %s lost sync at byte %d\n",
-				psmouse->name, psmouse->phys, psmouse->pktcnt);
-			psmouse->pktcnt = 0;
+		psmouse->packet[psmouse->pktcnt++] = data;
+	}
 
-			if (++psmouse->out_of_sync == psmouse->resetafter) {
-				psmouse->state = PSMOUSE_IGNORE;
-				printk(KERN_NOTICE "psmouse.c: issuing reconnect request\n");
-				serio_reconnect(psmouse->ps2dev.serio);
-			}
-			break;
+/*
+ * See if we need to force resync because mouse was idle for too long
+ */
+	if (psmouse->state == PSMOUSE_ACTIVATED &&
+	    psmouse->pktcnt == 1 && psmouse->resync_time &&
+	    time_after(jiffies, psmouse->last + psmouse->resync_time * HZ)) {
+		psmouse->badbyte = psmouse->packet[0];
+		__psmouse_set_state(psmouse, PSMOUSE_RESYNCING);
+		queue_work(kpsmoused_wq, &psmouse->resync_work);
+		goto out;
+	}
 
-		case PSMOUSE_FULL_PACKET:
-			psmouse->pktcnt = 0;
-			if (psmouse->out_of_sync) {
-				psmouse->out_of_sync = 0;
-				printk(KERN_NOTICE "psmouse.c: %s at %s - driver resynched.\n",
-					psmouse->name, psmouse->phys);
-			}
-			break;
+	psmouse->last = jiffies;
+	psmouse_handle_byte(psmouse, regs);
 
-		case PSMOUSE_GOOD_DATA:
-			break;
-	}
-out:
+ out:
 	return IRQ_HANDLED;
 }
 
@@ -736,21 +798,6 @@ static void psmouse_initialize(struct ps
 }
 
 /*
- * psmouse_set_state() sets new psmouse state and resets all flags and
- * counters while holding serio lock so fighting with interrupt handler
- * is not a concern.
- */
-
-static void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state)
-{
-	serio_pause_rx(psmouse->ps2dev.serio);
-	psmouse->state = new_state;
-	psmouse->pktcnt = psmouse->out_of_sync = 0;
-	psmouse->ps2dev.flags = 0;
-	serio_continue_rx(psmouse->ps2dev.serio);
-}
-
-/*
  * psmouse_activate() enables the mouse so that we get motion reports from it.
  */
 
@@ -778,6 +825,100 @@ static void psmouse_deactivate(struct ps
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 }
 
+/*
+ * psmouse_poll() - default poll hanlder. Everyone except for ALPS uses it.
+ */
+
+static int psmouse_poll(struct psmouse *psmouse)
+{
+	return ps2_command(&psmouse->ps2dev, psmouse->packet,
+			   PSMOUSE_CMD_POLL | (psmouse->pktsize << 8));
+}
+
+
+/*
+ * psmouse_resync() attempts to re-validate current protocol.
+ */
+
+static void psmouse_resync(void *p)
+{
+	struct psmouse *psmouse = p, *parent = NULL;
+	struct serio *serio = psmouse->ps2dev.serio;
+	psmouse_ret_t rc = PSMOUSE_GOOD_DATA;
+	int failed = 0, enabled = 0;
+	int i;
+
+	down(&psmouse_sem);
+
+	if (psmouse->state != PSMOUSE_RESYNCING)
+		goto out;
+
+	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
+		parent = serio_get_drvdata(serio->parent);
+		psmouse_deactivate(parent);
+	}
+
+/*
+ * Some mice don't ACK commands sent while they are in the middle of
+ * transmitting motion packet. To avoid delay we use ps2_sendbyte()
+ * instead of ps2_command() which would wait for 200ms for an ACK
+ * that may never come.
+ */
+	ps2_sendbyte(&psmouse->ps2dev, PSMOUSE_CMD_DISABLE, 20);
+
+/*
+ * Poll the mouse. If it was reset the packet will be shorter than
+ * psmouse->pktsize and ps2_command will fail. We do not expect and
+ * do not handle scenario when mouse "upgrades" its protocol while
+ * disconnected since it would require additional delay. If we ever
+ * see a mouse that does it we'll adjust the code.
+ */
+	if (psmouse->poll(psmouse))
+		failed = 1;
+	else {
+		psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
+		for (i = 0; i < psmouse->pktsize; i++) {
+			psmouse->pktcnt++;
+			rc = psmouse->protocol_handler(psmouse, NULL);
+			if (rc != PSMOUSE_GOOD_DATA)
+				break;
+		}
+		if (rc != PSMOUSE_FULL_PACKET)
+			failed = 1;
+		psmouse_set_state(psmouse, PSMOUSE_RESYNCING);
+	}
+
+/*
+ * Now try to enable mouse. We try to do that even if poll failed and also
+ * repeat our attempts 5 times, otherwise we may be left out with disabled
+ * mouse.
+ */
+	for (i = 0; i < 5; i++) {
+		if (!ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE)) {
+			enabled = 1;
+			break;
+		}
+		msleep(200);
+	}
+
+	if (!enabled) {
+		printk(KERN_WARNING "psmouse.c: failed to re-enable mouse on %s\n",
+			psmouse->ps2dev.serio->phys);
+		failed = 1;
+	}
+
+	if (failed) {
+		psmouse_set_state(psmouse, PSMOUSE_IGNORE);
+		printk(KERN_INFO "psmouse.c: resync failed, issuing reconnect request\n");
+		serio_reconnect(serio);
+	} else
+		psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
+
+	if (parent)
+		psmouse_activate(parent);
+ out:
+	up(&psmouse_sem);
+}
 
 /*
  * psmouse_cleanup() resets the mouse into power-on state.
@@ -804,11 +945,17 @@ static void psmouse_disconnect(struct se
 	device_remove_file(&serio->dev, &psmouse_attr_rate);
 	device_remove_file(&serio->dev, &psmouse_attr_resolution);
 	device_remove_file(&serio->dev, &psmouse_attr_resetafter);
+	device_remove_file(&serio->dev, &psmouse_attr_resync_time);
 
 	down(&psmouse_sem);
 
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
+	/* make sure we don't have a resync in progress */
+	up(&psmouse_sem);
+	flush_workqueue(kpsmoused_wq);
+	down(&psmouse_sem);
+
 	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
 		parent = serio_get_drvdata(serio->parent);
 		psmouse_deactivate(parent);
@@ -848,6 +995,7 @@ static int psmouse_switch_protocol(struc
 
 	psmouse->set_rate = psmouse_set_rate;
 	psmouse->set_resolution = psmouse_set_resolution;
+	psmouse->poll = psmouse_poll;
 	psmouse->protocol_handler = psmouse_process_byte;
 	psmouse->pktsize = 3;
 
@@ -902,6 +1050,7 @@ static int psmouse_connect(struct serio 
 	}
 
 	ps2_init(&psmouse->ps2dev, serio);
+	INIT_WORK(&psmouse->resync_work, psmouse_resync, psmouse);
 	sprintf(psmouse->phys, "%s/input0", serio->phys);
 
 	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
@@ -926,6 +1075,7 @@ static int psmouse_connect(struct serio 
 	psmouse->rate = psmouse_rate;
 	psmouse->resolution = psmouse_resolution;
 	psmouse->resetafter = psmouse_resetafter;
+	psmouse->resync_time = parent ? 0 : psmouse_resync_time;
 	psmouse->smartscroll = psmouse_smartscroll;
 
 	psmouse_switch_protocol(psmouse, NULL);
@@ -944,6 +1094,7 @@ static int psmouse_connect(struct serio 
 	device_create_file(&serio->dev, &psmouse_attr_rate);
 	device_create_file(&serio->dev, &psmouse_attr_resolution);
 	device_create_file(&serio->dev, &psmouse_attr_resetafter);
+	device_create_file(&serio->dev, &psmouse_attr_resync_time);
 
 	psmouse_activate(psmouse);
 
@@ -1233,6 +1384,24 @@ static ssize_t psmouse_attr_set_resetaft
 	return count;
 }
 
+static ssize_t psmouse_attr_show_resync_time(struct psmouse *psmouse, char *buf)
+{
+	return sprintf(buf, "%d\n", psmouse->resync_time);
+}
+
+static ssize_t psmouse_attr_set_resync_time(struct psmouse *psmouse, const char *buf, size_t count)
+{
+	unsigned long value;
+	char *rest;
+
+	value = simple_strtoul(buf, &rest, 10);
+	if (*rest)
+		return -EINVAL;
+
+	psmouse->resync_time = value;
+	return count;
+}
+
 static int psmouse_set_maxproto(const char *val, struct kernel_param *kp)
 {
 	struct psmouse_protocol *proto;
@@ -1259,13 +1428,21 @@ static int psmouse_get_maxproto(char *bu
 
 static int __init psmouse_init(void)
 {
+	kpsmoused_wq = create_singlethread_workqueue("kpsmoused");
+	if (!kpsmoused_wq) {
+		printk(KERN_ERR "psmouse: failed to create kpsmoused workqueue\n");
+		return -ENOMEM;
+	}
+
 	serio_register_driver(&psmouse_drv);
+
 	return 0;
 }
 
 static void __exit psmouse_exit(void)
 {
 	serio_unregister_driver(&psmouse_drv);
+	destroy_workqueue(kpsmoused_wq);
 }
 
 module_init(psmouse_init);
Index: work/drivers/input/mouse/logips2pp.c
===================================================================
--- work.orig/drivers/input/mouse/logips2pp.c
+++ work/drivers/input/mouse/logips2pp.c
@@ -117,7 +117,7 @@ static int ps2pp_cmd(struct psmouse *psm
 	if (psmouse_sliced_command(psmouse, command))
 		return -1;
 
-	if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_POLL))
+	if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_POLL | 0x0300))
 		return -1;
 
 	return 0;
Index: work/drivers/input/mouse/alps.c
===================================================================
--- work.orig/drivers/input/mouse/alps.c
+++ work/drivers/input/mouse/alps.c
@@ -347,6 +347,39 @@ static int alps_tap_mode(struct psmouse 
 	return 0;
 }
 
+/*
+ * alps_poll() - poll the touchpad for current motion packet.
+ * Used in resync.
+ */
+static int alps_poll(struct psmouse *psmouse)
+{
+	struct alps_data *priv = psmouse->private;
+	unsigned char buf[6];
+
+	if (priv->i->flags & ALPS_PASS)
+		alps_passthrough_mode(psmouse, 1);
+
+	if (ps2_command(&psmouse->ps2dev, buf, PSMOUSE_CMD_POLL | (psmouse->pktsize << 8)))
+		return -1;
+
+	if ((buf[0] & priv->i->mask0) != priv->i->byte0)
+		return -1;
+
+	if (priv->i->flags & ALPS_PASS)
+		alps_passthrough_mode(psmouse, 0);
+
+	if ((psmouse->badbyte & 0xc8) == 0x08) {
+/*
+ * Poll the track stick ...
+ */
+		if (ps2_command(&psmouse->ps2dev, buf, PSMOUSE_CMD_POLL | (3 << 8)))
+			return -1;
+	}
+
+	memcpy(psmouse->packet, buf, sizeof(buf));
+	return 0;
+}
+
 static int alps_reconnect(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
@@ -448,6 +481,7 @@ int alps_init(struct psmouse *psmouse)
 	printk(KERN_INFO "input: %s on %s\n", priv->dev2.name, psmouse->ps2dev.serio->phys);
 
 	psmouse->protocol_handler = alps_process_byte;
+	psmouse->poll = alps_poll;
 	psmouse->disconnect = alps_disconnect;
 	psmouse->reconnect = alps_reconnect;
 	psmouse->pktsize = 6;
