Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422683AbWAMOKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422683AbWAMOKl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 09:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422684AbWAMOKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 09:10:41 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:7692 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1422683AbWAMOKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 09:10:40 -0500
Message-ID: <43C7B4C8.8060405@tuxrocks.com>
Date: Fri, 13 Jan 2006 07:10:16 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Jesper Juhl <jesper.juhl@gmail.com>,
       LKML List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Mouse stalls (again) with 2.6.15-mm2
References: <9a8748490601091237s57071e57mbd2c4172a0e4dd@mail.gmail.com> <200601130154.47813.dtor_core@ameritech.net>
In-Reply-To: <200601130154.47813.dtor_core@ameritech.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dmitry Torokhov wrote:
> Hi,
> 
> Here is the latest version of psmouse resync patch, it should have all
> the fixes and handle both Jesper's KVM and Frank's touchpad. I would
> appreciate if you give it a spin.
> 
> The patch is against Linus, not -mm; for -mm you will have to revert
> original resync patch.
> 
> Thanks!

For me, the mouse and tapping both continue to work, but it is impossible
to turn on resync (resync_time immediately switches back to 0).  Since
things seem to continue working for me, that's fine by me, but is this
the intended behavior?

For reference, here is a respun (against latest -linus) patch of what I last tested:

diff -Naur linux-2.6.15-fs3-git/drivers/input/mouse/alps.c linux-2.6.15-fs4-mouse/drivers/input/mouse/alps.c
- --- linux-2.6.15-fs3-git/drivers/input/mouse/alps.c	2006-01-13 06:52:37.000000000 -0700
+++ linux-2.6.15-fs4-mouse/drivers/input/mouse/alps.c	2006-01-13 06:57:25.000000000 -0700
@@ -348,6 +348,40 @@
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
+	int poll_failed;
+
+	if (priv->i->flags & ALPS_PASS)
+		alps_passthrough_mode(psmouse, 1);
+
+	poll_failed = ps2_command(&psmouse->ps2dev, buf,
+				  PSMOUSE_CMD_POLL | (psmouse->pktsize << 8)) < 0;
+
+	if (priv->i->flags & ALPS_PASS)
+		alps_passthrough_mode(psmouse, 0);
+
+	if (poll_failed || (buf[0] & priv->i->mask0) != priv->i->byte0)
+		return -1;
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
@@ -451,10 +485,14 @@
 	input_register_device(priv->dev2);
 
 	psmouse->protocol_handler = alps_process_byte;
+	psmouse->poll = alps_poll;
 	psmouse->disconnect = alps_disconnect;
 	psmouse->reconnect = alps_reconnect;
 	psmouse->pktsize = 6;
 
+	/* We are having trouble resyncing ALPS touchpads so disable it for now */
+	psmouse->resync_time = 0;
+
 	return 0;
 
 init_fail:
diff -Naur linux-2.6.15-fs3-git/drivers/input/mouse/logips2pp.c linux-2.6.15-fs4-mouse/drivers/input/mouse/logips2pp.c
- --- linux-2.6.15-fs3-git/drivers/input/mouse/logips2pp.c	2006-01-13 06:52:37.000000000 -0700
+++ linux-2.6.15-fs4-mouse/drivers/input/mouse/logips2pp.c	2006-01-13 06:57:25.000000000 -0700
@@ -117,7 +117,7 @@
 	if (psmouse_sliced_command(psmouse, command))
 		return -1;
 
- -	if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_POLL))
+	if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_POLL | 0x0300))
 		return -1;
 
 	return 0;
diff -Naur linux-2.6.15-fs3-git/drivers/input/mouse/psmouse-base.c linux-2.6.15-fs4-mouse/drivers/input/mouse/psmouse-base.c
- --- linux-2.6.15-fs3-git/drivers/input/mouse/psmouse-base.c	2006-01-13 06:52:37.000000000 -0700
+++ linux-2.6.15-fs4-mouse/drivers/input/mouse/psmouse-base.c	2006-01-13 06:57:25.000000000 -0700
@@ -54,10 +54,14 @@
 module_param_named(smartscroll, psmouse_smartscroll, bool, 0644);
 MODULE_PARM_DESC(smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
 
- -static unsigned int psmouse_resetafter;
+static unsigned int psmouse_resetafter = 5;
 module_param_named(resetafter, psmouse_resetafter, uint, 0644);
 MODULE_PARM_DESC(resetafter, "Reset device after so many bad packets (0 = never).");
 
+static unsigned int psmouse_resync_time = 5;
+module_param_named(resync_time, psmouse_resync_time, uint, 0644);
+MODULE_PARM_DESC(resync_time, "How long can mouse stay idle before forcing resync (in seconds, 0 = never).");
+
 PSMOUSE_DEFINE_ATTR(protocol, S_IWUSR | S_IRUGO,
 			NULL,
 			psmouse_attr_show_protocol, psmouse_attr_set_protocol);
@@ -70,12 +74,16 @@
 PSMOUSE_DEFINE_ATTR(resetafter, S_IWUSR | S_IRUGO,
 			(void *) offsetof(struct psmouse, resetafter),
 			psmouse_show_int_attr, psmouse_set_int_attr);
+PSMOUSE_DEFINE_ATTR(resync_time, S_IWUSR | S_IRUGO,
+			(void *) offsetof(struct psmouse, resync_time),
+			psmouse_show_int_attr, psmouse_set_int_attr);
 
 static struct attribute *psmouse_attributes[] = {
 	&psmouse_attr_protocol.dattr.attr,
 	&psmouse_attr_rate.dattr.attr,
 	&psmouse_attr_resolution.dattr.attr,
 	&psmouse_attr_resetafter.dattr.attr,
+	&psmouse_attr_resync_time.dattr.attr,
 	NULL
 };
 
@@ -98,6 +106,8 @@
  */
 static DECLARE_MUTEX(psmouse_sem);
 
+static struct workqueue_struct *kpsmoused_wq;
+
 struct psmouse_protocol {
 	enum psmouse_type type;
 	char *name;
@@ -178,15 +188,79 @@
 }
 
 /*
- - * psmouse_interrupt() handles incoming characters, either gathering them into
- - * packets or passing them to the command routine as command output.
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
- -	psmouse_ret_t rc;
 
 	if (psmouse->state == PSMOUSE_IGNORE)
 		goto out;
@@ -208,67 +282,58 @@
 		if  (ps2_handle_response(&psmouse->ps2dev, data))
 			goto out;
 
- -	if (psmouse->state == PSMOUSE_INITIALIZING)
+	if (psmouse->state <= PSMOUSE_RESYNCING)
 		goto out;
 
 	if (psmouse->state == PSMOUSE_ACTIVATED &&
 	    psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/2)) {
- -		printk(KERN_WARNING "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n",
+		printk(KERN_INFO "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n",
 		       psmouse->name, psmouse->phys, psmouse->pktcnt);
- -		psmouse->pktcnt = 0;
+		psmouse->badbyte = psmouse->packet[0];
+		__psmouse_set_state(psmouse, PSMOUSE_RESYNCING);
+		queue_work(kpsmoused_wq, &psmouse->resync_work);
+		goto out;
 	}
 
- -	psmouse->last = jiffies;
 	psmouse->packet[psmouse->pktcnt++] = data;
- -
- -	if (psmouse->packet[0] == PSMOUSE_RET_BAT) {
+/*
+ * Check if this is a new device announcement (0xAA 0x00)
+ */
+	if (unlikely(psmouse->packet[0] == PSMOUSE_RET_BAT && psmouse->pktcnt <= 2)) {
 		if (psmouse->pktcnt == 1)
 			goto out;
 
- -		if (psmouse->pktcnt == 2) {
- -			if (psmouse->packet[1] == PSMOUSE_RET_ID) {
- -				psmouse->state = PSMOUSE_IGNORE;
- -				serio_reconnect(serio);
- -				goto out;
- -			}
- -			if (psmouse->type == PSMOUSE_SYNAPTICS) {
- -				/* neither 0xAA nor 0x00 are valid first bytes
- -				 * for a packet in absolute mode
- -				 */
- -				psmouse->pktcnt = 0;
- -				goto out;
- -			}
+		if (psmouse->packet[1] == PSMOUSE_RET_ID) {
+			__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
+			serio_reconnect(serio);
+			goto out;
 		}
- -	}
- -
- -	rc = psmouse->protocol_handler(psmouse, regs);
+/*
+ * Not a new device, try processing first byte normally
+ */
+		psmouse->pktcnt = 1;
+		if (psmouse_handle_byte(psmouse, regs))
+			goto out;
 
- -	switch (rc) {
- -		case PSMOUSE_BAD_DATA:
- -			printk(KERN_WARNING "psmouse.c: %s at %s lost sync at byte %d\n",
- -				psmouse->name, psmouse->phys, psmouse->pktcnt);
- -			psmouse->pktcnt = 0;
+		psmouse->packet[psmouse->pktcnt++] = data;
+	}
 
- -			if (++psmouse->out_of_sync == psmouse->resetafter) {
- -				psmouse->state = PSMOUSE_IGNORE;
- -				printk(KERN_NOTICE "psmouse.c: issuing reconnect request\n");
- -				serio_reconnect(psmouse->ps2dev.serio);
- -			}
- -			break;
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
 
- -		case PSMOUSE_FULL_PACKET:
- -			psmouse->pktcnt = 0;
- -			if (psmouse->out_of_sync) {
- -				psmouse->out_of_sync = 0;
- -				printk(KERN_NOTICE "psmouse.c: %s at %s - driver resynched.\n",
- -					psmouse->name, psmouse->phys);
- -			}
- -			break;
+	psmouse->last = jiffies;
+	psmouse_handle_byte(psmouse, regs);
 
- -		case PSMOUSE_GOOD_DATA:
- -			break;
- -	}
- -out:
+ out:
 	return IRQ_HANDLED;
 }
 
@@ -752,21 +817,6 @@
 }
 
 /*
- - * psmouse_set_state() sets new psmouse state and resets all flags and
- - * counters while holding serio lock so fighting with interrupt handler
- - * is not a concern.
- - */
- -
- -static void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state)
- -{
- -	serio_pause_rx(psmouse->ps2dev.serio);
- -	psmouse->state = new_state;
- -	psmouse->pktcnt = psmouse->out_of_sync = 0;
- -	psmouse->ps2dev.flags = 0;
- -	serio_continue_rx(psmouse->ps2dev.serio);
- -}
- -
- -/*
  * psmouse_activate() enables the mouse so that we get motion reports from it.
  */
 
@@ -794,6 +844,111 @@
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
+ * As an additional quirk ALPS touchpads may not only forget to ACK
+ * disable command but will stop reporting taps, so if we see that
+ * mouse at least once ACKs disable we will do full reconnect if ACK
+ * is missing.
+ */
+	psmouse->num_resyncs++;
+
+	if (ps2_sendbyte(&psmouse->ps2dev, PSMOUSE_CMD_DISABLE, 20)) {
+		if (psmouse->num_resyncs < 3 || psmouse->acks_disable_command)
+			failed = 1;
+	} else
+		psmouse->acks_disable_command = 1;
+
+/*
+ * Poll the mouse. If it was reset the packet will be shorter than
+ * psmouse->pktsize and ps2_command will fail. We do not expect and
+ * do not handle scenario when mouse "upgrades" its protocol while
+ * disconnected since it would require additional delay. If we ever
+ * see a mouse that does it we'll adjust the code.
+ */
+	if (!failed) {
+		if (psmouse->poll(psmouse))
+			failed = 1;
+		else {
+			psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
+			for (i = 0; i < psmouse->pktsize; i++) {
+				psmouse->pktcnt++;
+				rc = psmouse->protocol_handler(psmouse, NULL);
+				if (rc != PSMOUSE_GOOD_DATA)
+					break;
+			}
+			if (rc != PSMOUSE_FULL_PACKET)
+				failed = 1;
+			psmouse_set_state(psmouse, PSMOUSE_RESYNCING);
+		}
+	}
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
@@ -822,6 +977,11 @@
 
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
+	/* make sure we don't have a resync in progress */
+	up(&psmouse_sem);
+	flush_workqueue(kpsmoused_wq);
+	down(&psmouse_sem);
+
 	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
 		parent = serio_get_drvdata(serio->parent);
 		psmouse_deactivate(parent);
@@ -859,6 +1019,7 @@
 
 	psmouse->set_rate = psmouse_set_rate;
 	psmouse->set_resolution = psmouse_set_resolution;
+	psmouse->poll = psmouse_poll;
 	psmouse->protocol_handler = psmouse_process_byte;
 	psmouse->pktsize = 3;
 
@@ -874,6 +1035,23 @@
 	else
 		psmouse->type = psmouse_extensions(psmouse, psmouse_max_proto, 1);
 
+	/*
+	 * If mouse's packet size is 3 there is no point in polling the
+	 * device in hopes to detect protocol reset - we won't get less
+	 * than 3 bytes response anyhow.
+	 */
+	if (psmouse->pktsize == 3)
+		psmouse->resync_time = 0;
+
+	/*
+	 * Some smart KVMs fake response to POLL command returning just
+	 * 3 bytes and messing up our resync logic, so if initial poll
+	 * fails we won't try polling the device anymore. Hopefully
+	 * such KVM will maintain initially selected protocol.
+	 */
+	if (psmouse->resync_time && psmouse->poll(psmouse))
+		psmouse->resync_time = 0;
+
 	sprintf(psmouse->devname, "%s %s %s",
 		psmouse_protocol_by_type(psmouse->type)->name, psmouse->vendor, psmouse->name);
 
@@ -914,6 +1092,7 @@
 		goto out;
 
 	ps2_init(&psmouse->ps2dev, serio);
+	INIT_WORK(&psmouse->resync_work, psmouse_resync, psmouse);
 	psmouse->dev = input_dev;
 	sprintf(psmouse->phys, "%s/input0", serio->phys);
 
@@ -934,6 +1113,7 @@
 	psmouse->rate = psmouse_rate;
 	psmouse->resolution = psmouse_resolution;
 	psmouse->resetafter = psmouse_resetafter;
+	psmouse->resync_time = parent ? 0 : psmouse_resync_time;
 	psmouse->smartscroll = psmouse_smartscroll;
 
 	psmouse_switch_protocol(psmouse, NULL);
@@ -1278,13 +1458,21 @@
 
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
diff -Naur linux-2.6.15-fs3-git/drivers/input/mouse/psmouse.h linux-2.6.15-fs4-mouse/drivers/input/mouse/psmouse.h
- --- linux-2.6.15-fs3-git/drivers/input/mouse/psmouse.h	2006-01-13 06:52:37.000000000 -0700
+++ linux-2.6.15-fs4-mouse/drivers/input/mouse/psmouse.h	2006-01-13 06:57:25.000000000 -0700
@@ -7,7 +7,7 @@
 #define PSMOUSE_CMD_GETINFO	0x03e9
 #define PSMOUSE_CMD_SETSTREAM	0x00ea
 #define PSMOUSE_CMD_SETPOLL	0x00f0
- -#define PSMOUSE_CMD_POLL	0x03eb
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
@@ -38,15 +39,19 @@
 	void *private;
 	struct input_dev *dev;
 	struct ps2dev ps2dev;
+	struct work_struct resync_work;
 	char *vendor;
 	char *name;
 	unsigned char packet[8];
+	unsigned char badbyte;
 	unsigned char pktcnt;
 	unsigned char pktsize;
 	unsigned char type;
+	unsigned char acks_disable_command;
 	unsigned int model;
 	unsigned long last;
 	unsigned long out_of_sync;
+	unsigned long num_resyncs;
 	enum psmouse_state state;
 	char devname[64];
 	char phys[32];
@@ -54,6 +59,7 @@
 	unsigned int rate;
 	unsigned int resolution;
 	unsigned int resetafter;
+	unsigned int resync_time;
 	unsigned int smartscroll;	/* Logitech only */
 
 	psmouse_ret_t (*protocol_handler)(struct psmouse *psmouse, struct pt_regs *regs);
@@ -62,6 +68,7 @@
 
 	int (*reconnect)(struct psmouse *psmouse);
 	void (*disconnect)(struct psmouse *psmouse);
+	int (*poll)(struct psmouse *psmouse);
 
 	void (*pt_activate)(struct psmouse *psmouse);
 	void (*pt_deactivate)(struct psmouse *psmouse);
diff -Naur linux-2.6.15-fs3-git/drivers/input/mouse/synaptics.c linux-2.6.15-fs4-mouse/drivers/input/mouse/synaptics.c
- --- linux-2.6.15-fs3-git/drivers/input/mouse/synaptics.c	2006-01-13 06:52:37.000000000 -0700
+++ linux-2.6.15-fs4-mouse/drivers/input/mouse/synaptics.c	2006-01-13 06:57:25.000000000 -0700
@@ -652,6 +652,8 @@
 	psmouse->disconnect = synaptics_disconnect;
 	psmouse->reconnect = synaptics_reconnect;
 	psmouse->pktsize = 6;
+	/* Synaptics can usually stay in sync without extra help */
+	psmouse->resync_time = 0;
 
 	if (SYN_CAP_PASS_THROUGH(priv->capabilities))
 		synaptics_pt_create(psmouse);


Thanks,
Frank
- -- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDx7TGaI0dwg4A47wRAtRbAJwK4HvGw63cJW0moHI7gEoaWE5V8QCcDlwb
HKKxF2M3sSx6wgMlV1S35Vk=
=wGqd
-----END PGP SIGNATURE-----
