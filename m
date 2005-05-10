Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVEJEEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVEJEEj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 00:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVEJEEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 00:04:39 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:16530 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261436AbVEJEDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 00:03:52 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Mitch <Mitch@0Bits.COM>
Subject: ALPS testers wanted (Was Re: [RFT/PATCH] KVMS, mouse losing sync and going crazy)
Date: Mon, 9 May 2005 23:03:46 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <427F09C1.8010703@0Bits.COM>
In-Reply-To: <427F09C1.8010703@0Bits.COM>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505092303.46898.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 May 2005 01:57, Mitch wrote:
> Hi Dmitry,
> 
> No, no change with the attached patch either. Mouse goes to sleep and 
> need to be re-enabled constantly.
> 

Hi Mitch,

OK, here is an updated patch. Hopefully if we toggle passthrough mode on
Dualpoints we will get an absolute packet in response to POLL command.

Please give it a try. If it does not work please try uncommenting call to
ps2_drain in drivers/input/mouse/alps.c::alps_passthrough_mode().

Thanks!

-- 
Dmitry

http://www.geocities.com/dt_or/input/2_6_11/psmouse-resync-2.6.11-v6.patch.gz

===== drivers/input/mouse/alps.c 1.7 vs edited =====
--- 1.7/drivers/input/mouse/alps.c	2005-02-23 04:47:10 -05:00
+++ edited/drivers/input/mouse/alps.c	2005-05-09 22:46:16 -05:00
@@ -51,6 +51,8 @@
 	{ { 0x63, 0x03, 0xc8 },	ALPS_MODEL_DUALPOINT },
 };
 
+static int model;
+
 /*
  * ALPS abolute Mode
  * byte 0:  1    1    1    1    1  mid0 rig0 lef0
@@ -242,7 +244,6 @@
 static int alps_passthrough_mode(struct psmouse *psmouse, int enable)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	unsigned char param[3];
 	int cmd = enable ? PSMOUSE_CMD_SETSCALE21 : PSMOUSE_CMD_SETSCALE11;
 
 	if (ps2_command(ps2dev, NULL, cmd) ||
@@ -252,7 +253,7 @@
 		return -1;
 
 	/* we may get 3 more bytes, just ignore them */
-	ps2_command(ps2dev, param, 0x0300);
+//	ps2_drain(ps2dev, 3, 30);
 
 	return 0;
 }
@@ -320,9 +321,24 @@
 	return 0;
 }
 
+static int alps_poll(struct psmouse *psmouse)
+{
+	int rc;
+
+	if (model == ALPS_MODEL_DUALPOINT)
+		alps_passthrough_mode(psmouse, 1);
+
+	rc = ps2_command(&psmouse->ps2dev, psmouse->packet,
+			PSMOUSE_CMD_POLL | (psmouse->pktcnt << 8));
+
+	if (model == ALPS_MODEL_DUALPOINT)
+		alps_passthrough_mode(psmouse, 1);
+
+	return rc;
+}
+
 static int alps_reconnect(struct psmouse *psmouse)
 {
-	int model;
 	unsigned char param[4];
 
 	if ((model = alps_get_model(psmouse)) < 0)
@@ -356,7 +372,6 @@
 int alps_init(struct psmouse *psmouse)
 {
 	unsigned char param[4];
-	int model;
 
 	if ((model = alps_get_model(psmouse)) < 0)
 		return -1;
@@ -403,6 +418,7 @@
 	psmouse->dev.keybit[LONG(BTN_BACK)] |= BIT(BTN_BACK);
 
 	psmouse->protocol_handler = alps_process_byte;
+	psmouse->poll = alps_poll;
 	psmouse->disconnect = alps_disconnect;
 	psmouse->reconnect = alps_reconnect;
 	psmouse->pktsize = 6;
===== drivers/input/mouse/psmouse-base.c 1.82 vs edited =====
--- 1.82/drivers/input/mouse/psmouse-base.c	2005-01-07 16:51:45 -05:00
+++ edited/drivers/input/mouse/psmouse-base.c	2005-05-09 22:49:50 -05:00
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
 
@@ -627,6 +646,101 @@
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
+/*
+ * psmouse_poll() - default poll hanlder. Everyone except for ALPS uses it.
+ */
+static int psmouse_poll(struct psmouse *psmouse)
+{
+	return ps2_command(&psmouse->ps2dev, psmouse->packet,
+			   PSMOUSE_CMD_POLL | (psmouse->pktsize << 8));
+}
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
+	if (psmouse->poll(psmouse))
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
@@ -654,6 +768,9 @@
 	psmouse = serio->private;
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
+	/* make sure we don't have a resync in progress */
+	flush_workqueue(kpsmoused_wq);
+
 	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
 		parent = serio->parent->private;
 		if (parent->pt_deactivate)
@@ -691,12 +808,11 @@
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
@@ -724,6 +840,7 @@
 	psmouse->smartscroll = psmouse_smartscroll;
 	psmouse->set_rate = psmouse_set_rate;
 	psmouse->set_resolution = psmouse_set_resolution;
+	psmouse->poll = psmouse_poll;
 	psmouse->protocol_handler = psmouse_process_byte;
 	psmouse->pktsize = 3;
 
@@ -959,13 +1076,22 @@
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
+++ edited/drivers/input/mouse/psmouse.h	2005-05-09 22:39:58 -05:00
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
@@ -59,6 +61,7 @@
 	psmouse_ret_t (*protocol_handler)(struct psmouse *psmouse, struct pt_regs *regs);
 	void (*set_rate)(struct psmouse *psmouse, unsigned int rate);
 	void (*set_resolution)(struct psmouse *psmouse, unsigned int resolution);
+	int (*poll)(struct psmouse *psmouse);
 
 	int (*reconnect)(struct psmouse *psmouse);
 	void (*disconnect)(struct psmouse *psmouse);
===== drivers/input/serio/libps2.c 1.4 vs edited =====
--- 1.4/drivers/input/serio/libps2.c	2005-01-28 02:01:26 -05:00
+++ edited/drivers/input/serio/libps2.c	2005-05-09 22:37:59 -05:00
@@ -29,6 +29,7 @@
 
 EXPORT_SYMBOL(ps2_init);
 EXPORT_SYMBOL(ps2_sendbyte);
+EXPORT_SYMBOL(ps2_drain);
 EXPORT_SYMBOL(ps2_command);
 EXPORT_SYMBOL(ps2_schedule_command);
 EXPORT_SYMBOL(ps2_handle_ack);
@@ -72,6 +73,66 @@
 }
 
 /*
+ * ps2_drain()
+ */
+void ps2_drain(struct ps2dev *ps2dev, int maxbytes, int timeout)
+{
+	down(&ps2dev->cmd_sem);
+
+	serio_pause_rx(ps2dev->serio);
+	ps2dev->flags = PS2_FLAG_CMD;
+	ps2dev->cmdcnt = maxbytes;
+	serio_continue_rx(ps2dev->serio);
+
+	wait_event_timeout(ps2dev->wait,
+			   !(ps2dev->flags & PS2_FLAG_CMD),
+			   msecs_to_jiffies(timeout));
+
+	up(&ps2dev->cmd_sem);
+}
+
+static int ps2_is_keyboard_id(char id_byte)
+{
+	static char keyboard_ids[] = {
+		0xab,	/* Regular keyboards */
+		0xac,	/* NCD Sun keyboard */
+		0x2b,	/* Trust keyboard, translated */
+		0x5d,	/* Trust keyboard */
+		0x60,	/* NMB SGI keyboard, translated */
+		0x47,	/* NMB SGI keyboard */
+	};
+
+	return memchr(keyboard_ids, id_byte, sizeof(keyboard_ids)) != NULL;
+}
+
+static int ps2_adjust_timeout(struct ps2dev *ps2dev, int command, int timeout)
+{
+	if (command == PS2_CMD_RESET_BAT) {
+		/*
+		 * Device has sent the first response byte after a reset
+		 * command, reset is thus done, Shorten the timeout.
+		 * The next byte will come soon (keyboard) or not at all
+		 * (mouse).
+		 */
+		if (timeout > msecs_to_jiffies(100))
+			timeout = msecs_to_jiffies(100);
+	} else if (command == PS2_CMD_GETID) {
+		/*
+		 * If device behind the port is not a keyboard there
+		 * won't be 2nd byte of ID response.
+		 */
+		if (!ps2_is_keyboard_id(ps2dev->cmdbuf[1])) {
+			serio_pause_rx(ps2dev->serio);
+			ps2dev->flags = ps2dev->cmdcnt = 0;
+			serio_continue_rx(ps2dev->serio);
+			timeout = 0;
+		}
+	}
+
+	return timeout;
+}
+
+/*
  * ps2_command() sends a command and its parameters to the mouse,
  * then waits for the response and puts it in the param array.
  *
@@ -101,10 +162,9 @@
 	 * ACKing the reset command, and so it can take a long
 	 * time before the ACK arrrives.
 	 */
-	if (command & 0xff)
-		if (ps2_sendbyte(ps2dev, command & 0xff,
-			command == PS2_CMD_RESET_BAT ? 1000 : 200))
-			goto out;
+	if (ps2_sendbyte(ps2dev, command & 0xff,
+			 command == PS2_CMD_RESET_BAT ? 1000 : 200))
+		goto out;
 
 	for (i = 0; i < send; i++)
 		if (ps2_sendbyte(ps2dev, param[i], 200))
@@ -120,33 +180,7 @@
 
 	if (ps2dev->cmdcnt && timeout > 0) {
 
-		if (command == PS2_CMD_RESET_BAT && timeout > msecs_to_jiffies(100)) {
-			/*
-			 * Device has sent the first response byte
-			 * after a reset command, reset is thus done,
-			 * shorten the timeout. The next byte will come
-			 * soon (keyboard) or not at all (mouse).
-			 */
-			timeout = msecs_to_jiffies(100);
-		}
-
-		if (command == PS2_CMD_GETID &&
-		    ps2dev->cmdbuf[receive - 1] != 0xab && /* Regular keyboards */
-		    ps2dev->cmdbuf[receive - 1] != 0xac && /* NCD Sun keyboard */
-		    ps2dev->cmdbuf[receive - 1] != 0x2b && /* Trust keyboard, translated */
-		    ps2dev->cmdbuf[receive - 1] != 0x5d && /* Trust keyboard */
-		    ps2dev->cmdbuf[receive - 1] != 0x60 && /* NMB SGI keyboard, translated */
-		    ps2dev->cmdbuf[receive - 1] != 0x47) { /* NMB SGI keyboard */
-			/*
-			 * Device behind the port is not a keyboard
-			 * so we don't need to wait for the 2nd byte
-			 * of ID response.
-			 */
-			serio_pause_rx(ps2dev->serio);
-			ps2dev->flags = ps2dev->cmdcnt = 0;
-			serio_continue_rx(ps2dev->serio);
-		}
-
+		timeout = ps2_adjust_timeout(ps2dev, command, timeout);
 		wait_event_timeout(ps2dev->wait,
 				   !(ps2dev->flags & PS2_FLAG_CMD), timeout);
 	}
===== include/linux/libps2.h 1.2 vs edited =====
--- 1.2/include/linux/libps2.h	2004-10-20 03:13:08 -05:00
+++ edited/include/linux/libps2.h	2005-05-09 22:38:14 -05:00
@@ -41,6 +41,7 @@
 
 void ps2_init(struct ps2dev *ps2dev, struct serio *serio);
 int ps2_sendbyte(struct ps2dev *ps2dev, unsigned char byte, int timeout);
+void ps2_drain(struct ps2dev *ps2dev, int maxbytes, int timeout);
 int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command);
 int ps2_schedule_command(struct ps2dev *ps2dev, unsigned char *param, int command);
 int ps2_handle_ack(struct ps2dev *ps2dev, unsigned char data);
