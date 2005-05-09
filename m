Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263046AbVEIFDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263046AbVEIFDS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 01:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263047AbVEIFDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 01:03:18 -0400
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:60826 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263046AbVEIFCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 01:02:20 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: zhilla <zhilla@spymac.com>
Subject: Re: [RFT/PATCH] KVMS, mouse losing sync and going crazy
Date: Mon, 9 May 2005 00:02:03 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200505080226.43168.dtor_core@ameritech.net> <427E9E6A.9050500@spymac.com>
In-Reply-To: <427E9E6A.9050500@spymac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505090002.04162.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 May 2005 18:19, zhilla wrote:
> hi dmitrty, i am now testing psmouse-resync-2.6.11.patch.gz on ms-600, 
> with no problems so far... should i start testing 
> psmouse-resync-2.6.11-v4.patch.gz or?
> 

Actually, if you could try v5 I would appreciate it (v5 is a simplified
version of v4, should be more reliable for the common case too):

http://www.geocities.com/dt_or/input/2_6_11/psmouse-resync-2.6.11-v5.patch.gz

If you see a problem with v5 please try v4.

Thanks!

> btw, cursed ms600 seems to be working properly for now, unfortunately i 
> don't know if its because of the patch (no dmesg messages yet) or 
> because  i opened it up and cleaned it :) oh yeah, it also fell to the 
> floor couple of times, perhaps that's it :)
> 

;)

-- 
Dmitry

===== drivers/input/mouse/psmouse-base.c 1.82 vs edited =====
--- 1.82/drivers/input/mouse/psmouse-base.c	2005-01-07 16:51:45 -05:00
+++ edited/drivers/input/mouse/psmouse-base.c	2005-05-08 23:38:28 -05:00
@@ -62,6 +62,8 @@
 __obsolete_setup("psmouse_resetafter=");
 __obsolete_setup("psmouse_rate=");
 
+static struct workqueue_struct *kpsmoused_wq;
+
 static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "ThinkPS/2", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2", "AlpsPS/2" };
 
 /*
@@ -135,6 +137,33 @@
 }
 
 /*
+ * psmouse_set_state() sets new psmouse state and resets all flags.
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
+
+/*
  * psmouse_interrupt() handles incoming characters, either gathering them into
  * packets or passing them to the command routine as command output.
  */
@@ -144,6 +173,7 @@
 {
 	struct psmouse *psmouse = serio->private;
 	psmouse_ret_t rc;
+	int tmo;
 
 	if (psmouse->state == PSMOUSE_IGNORE)
 		goto out;
@@ -165,14 +195,18 @@
 		if  (ps2_handle_response(&psmouse->ps2dev, data))
 			goto out;
 
-	if (psmouse->state == PSMOUSE_INITIALIZING)
+	if (psmouse->state <= PSMOUSE_RESYNCING)
 		goto out;
 
+	tmo = psmouse->pktcnt ? HZ / 2 : 5 * HZ;
 	if (psmouse->state == PSMOUSE_ACTIVATED &&
-	    psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/2)) {
-		printk(KERN_WARNING "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n",
-		       psmouse->name, psmouse->phys, psmouse->pktcnt);
-		psmouse->pktcnt = 0;
+	    time_after(jiffies, psmouse->last + tmo)) {
+		if (psmouse->pktcnt)
+			printk(KERN_WARNING "psmouse.c: %s at %s lost synchronization, "
+			       "throwing %d bytes away.\n",
+			       psmouse->name, psmouse->phys, psmouse->pktcnt);
+		__psmouse_set_state(psmouse, PSMOUSE_RESYNCING);
+		queue_work(kpsmoused_wq, &psmouse->resync_work);
 	}
 
 	psmouse->last = jiffies;
@@ -184,7 +218,7 @@
 
 		if (psmouse->pktcnt == 2) {
 			if (psmouse->packet[1] == PSMOUSE_RET_ID) {
-				psmouse->state = PSMOUSE_IGNORE;
+				__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
 				serio_reconnect(serio);
 				goto out;
 			}
@@ -207,7 +241,7 @@
 			psmouse->pktcnt = 0;
 
 			if (++psmouse->out_of_sync == psmouse->resetafter) {
-				psmouse->state = PSMOUSE_IGNORE;
+				__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
 				printk(KERN_NOTICE "psmouse.c: issuing reconnect request\n");
 				serio_reconnect(psmouse->ps2dev.serio);
 			}
@@ -585,21 +619,6 @@
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
 
@@ -627,6 +646,94 @@
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 }
 
+/*
+ * psmouse_set_stream_mode() puts the mouse into stream mode so we get motion
+ * reports from it. It does 5 attempts before giving up because if it fails we
+ * risk being left with a dead mouse.
+ */
+
+static int psmouse_set_stream_mode(struct psmouse *psmouse)
+{
+	int attempt;
+
+	for (attempt = 0; attempt < 5; attempt++) {
+		if (!ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSTREAM))
+			return 0;
+		msleep(200);
+	}
+
+	printk(KERN_WARNING "psmouse.c: failed to enable streaming mode\n");
+	return -1;
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
+	int failed = 0;
+	int i;
+
+	if (serio_pin_driver(serio))
+		return;
+
+	if (psmouse->state != PSMOUSE_RESYNCING)
+		goto out;
+
+	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
+		parent = serio->parent->private;
+		psmouse_deactivate(parent);
+	}
+/*
+ * Some mice don't ACK commands sent while mouse is in the middle of
+ * transmitting motion packet, so we use ps2_sendbyte() instead of
+ * ps2_command() to avoid delay.
+ */
+	ps2_sendbyte(&psmouse->ps2dev, PSMOUSE_CMD_SETPOLL, 20);
+
+/*
+ * Poll the mouse. If it was reset the packet will be shorter than
+ * psmouse->pktsize and ps2_command will fail. We do not expect and
+ * do not handle scenario when mouse "upgrades" its protocol while
+ * disconnected since it would require additional delay. If we ever
+ * see a mouse that does it we'll adjust the code.
+ */
+	if (ps2_command(&psmouse->ps2dev, psmouse->packet,
+			PSMOUSE_CMD_POLL | (psmouse->pktsize << 8)))
+		failed = 1;
+	else {
+		psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
+		for (i = 0; i < psmouse->pktsize; i++) {
+			psmouse->pktcnt++;
+			if (psmouse->protocol_handler(psmouse, NULL) == PSMOUSE_BAD_DATA) {
+				failed = 1;
+				break;
+			}
+		}
+		psmouse_set_state(psmouse, PSMOUSE_RESYNCING);
+	}
+
+	if (!failed)
+		psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
+
+	if (psmouse_set_stream_mode(psmouse))
+		failed = 1;
+
+	if (failed) {
+		psmouse_set_state(psmouse, PSMOUSE_IGNORE);
+		printk(KERN_INFO "psmouse.c: resync failed, issuing reconnect request\n");
+		serio_reconnect(serio);
+	}
+
+	if (parent)
+		psmouse_activate(parent);
+ out:
+	serio_unpin_driver(serio);
+}
 
 /*
  * psmouse_cleanup() resets the mouse into power-on state.
@@ -654,6 +761,9 @@
 	psmouse = serio->private;
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
+	/* make sure we don't have a resync in progress */
+	flush_workqueue(kpsmoused_wq);
+
 	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
 		parent = serio->parent->private;
 		if (parent->pt_deactivate)
@@ -691,12 +801,11 @@
 		psmouse_deactivate(parent);
 	}
 
-	if (!(psmouse = kmalloc(sizeof(struct psmouse), GFP_KERNEL)))
+	if (!(psmouse = kcalloc(1, sizeof(struct psmouse), GFP_KERNEL)))
 		goto out;
 
-	memset(psmouse, 0, sizeof(struct psmouse));
-
 	ps2_init(&psmouse->ps2dev, serio);
+	INIT_WORK(&psmouse->resync_work, psmouse_resync, psmouse);
 	psmouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
 	psmouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
 	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
@@ -959,13 +1068,22 @@
 int __init psmouse_init(void)
 {
 	psmouse_parse_proto();
+
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
 
 void __exit psmouse_exit(void)
 {
 	serio_unregister_driver(&psmouse_drv);
+	destroy_workqueue(kpsmoused_wq);
 }
 
 module_init(psmouse_init);
===== drivers/input/mouse/psmouse.h 1.25 vs edited =====
--- 1.25/drivers/input/mouse/psmouse.h	2004-10-16 06:15:31 -05:00
+++ edited/drivers/input/mouse/psmouse.h	2005-05-08 23:37:09 -05:00
@@ -7,7 +7,7 @@
 #define PSMOUSE_CMD_GETINFO	0x03e9
 #define PSMOUSE_CMD_SETSTREAM	0x00ea
 #define PSMOUSE_CMD_SETPOLL	0x00f0
-#define PSMOUSE_CMD_POLL	0x03eb
+#define PSMOUSE_CMD_POLL	0x00eb
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
@@ -38,6 +39,7 @@
 	void *private;
 	struct input_dev dev;
 	struct ps2dev ps2dev;
+	struct work_struct resync_work;
 	char *vendor;
 	char *name;
 	unsigned char packet[8];
