Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268468AbUIQFGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268468AbUIQFGx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 01:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268457AbUIQFGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 01:06:52 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:55976 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268420AbUIQFBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 01:01:43 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 1/3] libps2.patch
Date: Thu, 16 Sep 2004 23:59:44 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200409162358.27678.dtor_core@ameritech.net>
In-Reply-To: <200409162358.27678.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409162359.45766.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1832.46.2, 2004-09-01 01:00:06-05:00, dtor_core@ameritech.net
  Input: pull common code from psmouse and atkbd into libps2 module
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/keyboard/Kconfig     |    1 
 drivers/input/keyboard/atkbd.c     |  290 ++++++-------------------------------
 drivers/input/mouse/Kconfig        |    1 
 drivers/input/mouse/logips2pp.c    |   41 ++---
 drivers/input/mouse/psmouse-base.c |  230 +++++------------------------
 drivers/input/mouse/psmouse.h      |   16 --
 drivers/input/mouse/synaptics.c    |   28 +--
 drivers/input/serio/Kconfig        |   10 +
 drivers/input/serio/Makefile       |    1 
 drivers/input/serio/libps2.c       |  273 ++++++++++++++++++++++++++++++++++
 include/linux/libps2.h             |   50 ++++++
 11 files changed, 474 insertions(+), 467 deletions(-)


===================================================================



diff -Nru a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
--- a/drivers/input/keyboard/Kconfig	2004-09-16 23:30:14 -05:00
+++ b/drivers/input/keyboard/Kconfig	2004-09-16 23:30:14 -05:00
@@ -16,6 +16,7 @@
 	default y
 	depends on INPUT && INPUT_KEYBOARD
 	select SERIO
+	select SERIO_LIBPS2
 	select SERIO_I8042 if PC
 	select SERIO_GSCPS2 if GSC
 	help
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2004-09-16 23:30:14 -05:00
+++ b/drivers/input/keyboard/atkbd.c	2004-09-16 23:30:14 -05:00
@@ -26,6 +26,7 @@
 #include <linux/input.h>
 #include <linux/serio.h>
 #include <linux/workqueue.h>
+#include <linux/libps2.h>
 
 #define DRIVER_DESC	"AT and PS/2 keyboard driver"
 
@@ -170,21 +171,17 @@
 	{ ATKBD_SCR_CLICK, 0x60 },
 };
 
-#define ATKBD_FLAG_ACK		0	/* Waiting for ACK/NAK */
-#define ATKBD_FLAG_CMD		1	/* Waiting for command to finish */
-#define ATKBD_FLAG_CMD1		2	/* First byte of command response */
-#define ATKBD_FLAG_ENABLED	3	/* Waining for init to finish */
-
 /*
  * The atkbd control structure
  */
 
 struct atkbd {
 
+	struct ps2dev	ps2dev;
+
 	/* Written only during init */
 	char name[64];
 	char phys[32];
-	struct serio *serio;
 	struct input_dev dev;
 
 	unsigned char set;
@@ -194,12 +191,7 @@
 	unsigned char extra;
 	unsigned char write;
 
-	/* Protected by FLAG_ACK */
-	unsigned char nak;
-
-	/* Protected by FLAG_CMD */
-	unsigned char cmdbuf[4];
-	unsigned char cmdcnt;
+	unsigned char enabled;
 
 	/* Accessed only from interrupt */
 	unsigned char emul;
@@ -208,26 +200,8 @@
 	unsigned char bat_xl;
 	unsigned int last;
 	unsigned long time;
-
-	/* Ensures that only one command is executing at a time */
-	struct semaphore cmd_sem;
-
-	/* Used to signal completion from interrupt handler */
-	wait_queue_head_t wait;
-
-	/* Flags */
-	unsigned long flags;
 };
 
-/* Work structure to schedule execution of a command */
-struct atkbd_work {
-	struct work_struct work;
-	struct atkbd *atkbd;
-	int command;
-	unsigned char param[0];
-};
-
-
 static void atkbd_report_key(struct input_dev *dev, struct pt_regs *regs, int code, int value)
 {
 	input_regs(dev, regs);
@@ -268,42 +242,15 @@
 		atkbd->resend = 0;
 #endif
 
-	if (test_bit(ATKBD_FLAG_ACK, &atkbd->flags)) {
-		switch (code) {
-			case ATKBD_RET_ACK:
-				atkbd->nak = 0;
-				if (atkbd->cmdcnt) {
-					set_bit(ATKBD_FLAG_CMD, &atkbd->flags);
-					set_bit(ATKBD_FLAG_CMD1, &atkbd->flags);
-				}
-				clear_bit(ATKBD_FLAG_ACK, &atkbd->flags);
-				wake_up_interruptible(&atkbd->wait);
-				break;
-			case ATKBD_RET_NAK:
-				atkbd->nak = 1;
-				clear_bit(ATKBD_FLAG_ACK, &atkbd->flags);
-				wake_up_interruptible(&atkbd->wait);
-				break;
-		}
-		goto out;
-	}
-
-	if (test_bit(ATKBD_FLAG_CMD, &atkbd->flags)) {
-
-		if (atkbd->cmdcnt)
-			atkbd->cmdbuf[--atkbd->cmdcnt] = code;
-
-		if (test_and_clear_bit(ATKBD_FLAG_CMD1, &atkbd->flags) && atkbd->cmdcnt)
-			wake_up_interruptible(&atkbd->wait);
+	if (unlikely(atkbd->ps2dev.flags & PS2_FLAG_ACK))
+		if  (ps2_handle_ack(&atkbd->ps2dev, data))
+			goto out;
 
-		if (!atkbd->cmdcnt) {
-			clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
-			wake_up_interruptible(&atkbd->wait);
-		}
-		goto out;
-	}
+	if (unlikely(atkbd->ps2dev.flags & PS2_FLAG_CMD))
+		if  (ps2_handle_response(&atkbd->ps2dev, data))
+			goto out;
 
-	if (!test_bit(ATKBD_FLAG_ENABLED, &atkbd->flags))
+	if (!atkbd->enabled)
 		goto out;
 
 	input_event(&atkbd->dev, EV_MSC, MSC_RAW, code);
@@ -326,8 +273,8 @@
 
 	switch (code) {
 		case ATKBD_RET_BAT:
-			clear_bit(ATKBD_FLAG_ENABLED, &atkbd->flags);
-			serio_rescan(atkbd->serio);
+			atkbd->enabled = 0;
+			serio_rescan(atkbd->ps2dev.serio);
 			goto out;
 		case ATKBD_RET_EMUL0:
 			atkbd->emul = 1;
@@ -427,151 +374,6 @@
 	return IRQ_HANDLED;
 }
 
-/*
- * atkbd_sendbyte() sends a byte to the keyboard, and waits for
- * acknowledge. It doesn't handle resends according to the keyboard
- * protocol specs, because if these are needed, the keyboard needs
- * replacement anyway, and they only make a mess in the protocol.
- *
- * atkbd_sendbyte() can only be called from a process context
- */
-
-static int atkbd_sendbyte(struct atkbd *atkbd, unsigned char byte)
-{
-#ifdef ATKBD_DEBUG
-	printk(KERN_DEBUG "atkbd.c: Sent: %02x\n", byte);
-#endif
-	atkbd->nak = 1;
-	set_bit(ATKBD_FLAG_ACK, &atkbd->flags);
-
-	if (serio_write(atkbd->serio, byte) == 0)
-		wait_event_interruptible_timeout(atkbd->wait,
-				!test_bit(ATKBD_FLAG_ACK, &atkbd->flags),
-				msecs_to_jiffies(200));
-
-	clear_bit(ATKBD_FLAG_ACK, &atkbd->flags);
-	return -atkbd->nak;
-}
-
-/*
- * atkbd_command() sends a command, and its parameters to the keyboard,
- * then waits for the response and puts it in the param array.
- *
- * atkbd_command() can only be called from a process context
- */
-
-static int atkbd_command(struct atkbd *atkbd, unsigned char *param, int command)
-{
-	int timeout;
-	int send = (command >> 12) & 0xf;
-	int receive = (command >> 8) & 0xf;
-	int rc = -1;
-	int i;
-
-	timeout = msecs_to_jiffies(command == ATKBD_CMD_RESET_BAT ? 4000 : 500);
-
-	down(&atkbd->cmd_sem);
-	clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
-
-	if (receive && param)
-		for (i = 0; i < receive; i++)
-			atkbd->cmdbuf[(receive - 1) - i] = param[i];
-
-	atkbd->cmdcnt = receive;
-
-	if (command & 0xff)
-		if (atkbd_sendbyte(atkbd, command & 0xff))
-			goto out;
-
-	for (i = 0; i < send; i++)
-		if (atkbd_sendbyte(atkbd, param[i]))
-			goto out;
-
-	timeout = wait_event_interruptible_timeout(atkbd->wait,
-				!test_bit(ATKBD_FLAG_CMD1, &atkbd->flags), timeout);
-
-	if (atkbd->cmdcnt && timeout > 0) {
-		if (command == ATKBD_CMD_RESET_BAT && jiffies_to_msecs(timeout) > 100)
-			timeout = msecs_to_jiffies(100);
-
-		if (command == ATKBD_CMD_GETID &&
-		    atkbd->cmdbuf[receive - 1] != 0xab && atkbd->cmdbuf[receive - 1] != 0xac) {
-			/*
-			 * Device behind the port is not a keyboard
-			 * so we don't need to wait for the 2nd byte
-			 * of ID response.
-			 */
-			clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
-			atkbd->cmdcnt = 0;
-		}
-
-		wait_event_interruptible_timeout(atkbd->wait,
-				!test_bit(ATKBD_FLAG_CMD, &atkbd->flags), timeout);
-	}
-
-	if (param)
-		for (i = 0; i < receive; i++)
-			param[i] = atkbd->cmdbuf[(receive - 1) - i];
-
-	if (atkbd->cmdcnt && (command != ATKBD_CMD_RESET_BAT || atkbd->cmdcnt != 1))
-		goto out;
-
-	rc = 0;
-
-out:
-	clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
-	clear_bit(ATKBD_FLAG_CMD1, &atkbd->flags);
-	up(&atkbd->cmd_sem);
-
-	return rc;
-}
-
-/*
- * atkbd_execute_scheduled_command() sends a command, previously scheduled by
- * atkbd_schedule_command(), to the keyboard.
- */
-
-static void atkbd_execute_scheduled_command(void *data)
-{
-	struct atkbd_work *atkbd_work = data;
-
-	atkbd_command(atkbd_work->atkbd, atkbd_work->param, atkbd_work->command);
-
-	kfree(atkbd_work);
-}
-
-/*
- * atkbd_schedule_command() allows to schedule delayed execution of a keyboard
- * command and can be used to issue a command from an interrupt or softirq
- * context.
- */
-
-static int atkbd_schedule_command(struct atkbd *atkbd, unsigned char *param, int command)
-{
-	struct atkbd_work *atkbd_work;
-	int send = (command >> 12) & 0xf;
-	int receive = (command >> 8) & 0xf;
-
-	if (!test_bit(ATKBD_FLAG_ENABLED, &atkbd->flags))
-		return -1;
-
-	if (!(atkbd_work = kmalloc(sizeof(struct atkbd_work) + max(send, receive), GFP_ATOMIC)))
-		return -1;
-
-	memset(atkbd_work, 0, sizeof(struct atkbd_work));
-	atkbd_work->atkbd = atkbd;
-	atkbd_work->command = command;
-	memcpy(atkbd_work->param, param, send);
-	INIT_WORK(&atkbd_work->work, atkbd_execute_scheduled_command, atkbd_work);
-
-	if (!schedule_work(&atkbd_work->work)) {
-		kfree(atkbd_work);
-		return -1;
-	}
-
-	return 0;
-}
-
 
 /*
  * Event callback from the input module. Events that change the state of
@@ -599,7 +401,7 @@
 			param[0] = (test_bit(LED_SCROLLL, dev->led) ? 1 : 0)
 			         | (test_bit(LED_NUML,    dev->led) ? 2 : 0)
 			         | (test_bit(LED_CAPSL,   dev->led) ? 4 : 0);
-		        atkbd_schedule_command(atkbd, param, ATKBD_CMD_SETLEDS);
+		        ps2_schedule_command(&atkbd->ps2dev, param, ATKBD_CMD_SETLEDS);
 
 			if (atkbd->extra) {
 				param[0] = 0;
@@ -608,7 +410,7 @@
 					 | (test_bit(LED_SUSPEND, dev->led) ? 0x04 : 0)
 				         | (test_bit(LED_MISC,    dev->led) ? 0x10 : 0)
 				         | (test_bit(LED_MUTE,    dev->led) ? 0x20 : 0);
-				atkbd_schedule_command(atkbd, param, ATKBD_CMD_EX_SETLEDS);
+				ps2_schedule_command(&atkbd->ps2dev, param, ATKBD_CMD_EX_SETLEDS);
 			}
 
 			return 0;
@@ -624,7 +426,7 @@
 			dev->rep[REP_PERIOD] = period[i];
 			dev->rep[REP_DELAY] = delay[j];
 			param[0] = i | (j << 5);
-			atkbd_schedule_command(atkbd, param, ATKBD_CMD_SETREP);
+			ps2_schedule_command(&atkbd->ps2dev, param, ATKBD_CMD_SETREP);
 
 			return 0;
 	}
@@ -638,6 +440,7 @@
 
 static int atkbd_probe(struct atkbd *atkbd)
 {
+	struct ps2dev *ps2dev = &atkbd->ps2dev;
 	unsigned char param[2];
 
 /*
@@ -647,8 +450,8 @@
  */
 
 	if (atkbd_reset)
-		if (atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT))
-			printk(KERN_WARNING "atkbd.c: keyboard reset failed on %s\n", atkbd->serio->phys);
+		if (ps2_command(ps2dev, NULL, ATKBD_CMD_RESET_BAT))
+			printk(KERN_WARNING "atkbd.c: keyboard reset failed on %s\n", ps2dev->serio->phys);
 
 /*
  * Then we check the keyboard ID. We should get 0xab83 under normal conditions.
@@ -658,7 +461,7 @@
  */
 
 	param[0] = param[1] = 0xa5;	/* initialize with invalid values */
-	if (atkbd_command(atkbd, param, ATKBD_CMD_GETID)) {
+	if (ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
 
 /*
  * If the get ID command failed, we check if we can at least set the LEDs on
@@ -666,7 +469,7 @@
  * the LEDs off, which we want anyway.
  */
 		param[0] = 0;
-		if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
+		if (ps2_command(ps2dev, param, ATKBD_CMD_SETLEDS))
 			return -1;
 		atkbd->id = 0xabba;
 		return 0;
@@ -693,6 +496,7 @@
 
 static int atkbd_set_3(struct atkbd *atkbd)
 {
+	struct ps2dev *ps2dev = &atkbd->ps2dev;
 	unsigned char param[2];
 
 /*
@@ -706,13 +510,13 @@
 
 	if (atkbd->id == 0xaca1) {
 		param[0] = 3;
-		atkbd_command(atkbd, param, ATKBD_CMD_SSCANSET);
+		ps2_command(ps2dev, param, ATKBD_CMD_SSCANSET);
 		return 3;
 	}
 
 	if (atkbd_extra) {
 		param[0] = 0x71;
-		if (!atkbd_command(atkbd, param, ATKBD_CMD_EX_ENABLE)) {
+		if (!ps2_command(ps2dev, param, ATKBD_CMD_EX_ENABLE)) {
 			atkbd->extra = 1;
 			return 2;
 		}
@@ -721,32 +525,33 @@
 	if (atkbd_set != 3)
 		return 2;
 
-	if (!atkbd_command(atkbd, param, ATKBD_CMD_OK_GETID)) {
+	if (!ps2_command(ps2dev, param, ATKBD_CMD_OK_GETID)) {
 		atkbd->id = param[0] << 8 | param[1];
 		return 2;
 	}
 
 	param[0] = 3;
-	if (atkbd_command(atkbd, param, ATKBD_CMD_SSCANSET))
+	if (ps2_command(ps2dev, param, ATKBD_CMD_SSCANSET))
 		return 2;
 
 	param[0] = 0;
-	if (atkbd_command(atkbd, param, ATKBD_CMD_GSCANSET))
+	if (ps2_command(ps2dev, param, ATKBD_CMD_GSCANSET))
 		return 2;
 
 	if (param[0] != 3) {
 		param[0] = 2;
-		if (atkbd_command(atkbd, param, ATKBD_CMD_SSCANSET))
+		if (ps2_command(ps2dev, param, ATKBD_CMD_SSCANSET))
 		return 2;
 	}
 
-	atkbd_command(atkbd, param, ATKBD_CMD_SETALL_MBR);
+	ps2_command(ps2dev, param, ATKBD_CMD_SETALL_MBR);
 
 	return 3;
 }
 
 static int atkbd_enable(struct atkbd *atkbd)
 {
+	struct ps2dev *ps2dev = &atkbd->ps2dev;
 	unsigned char param[1];
 
 /*
@@ -754,7 +559,7 @@
  */
 
 	param[0] = 0;
-	if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
+	if (ps2_command(ps2dev, param, ATKBD_CMD_SETLEDS))
 		return -1;
 
 /*
@@ -762,16 +567,16 @@
  */
 
 	param[0] = 0;
-	if (atkbd_command(atkbd, param, ATKBD_CMD_SETREP))
+	if (ps2_command(ps2dev, param, ATKBD_CMD_SETREP))
 		return -1;
 
 /*
  * Enable the keyboard to receive keystrokes.
  */
 
-	if (atkbd_command(atkbd, NULL, ATKBD_CMD_ENABLE)) {
+	if (ps2_command(ps2dev, NULL, ATKBD_CMD_ENABLE)) {
 		printk(KERN_ERR "atkbd.c: Failed to enable keyboard on %s\n",
-			atkbd->serio->phys);
+			ps2dev->serio->phys);
 		return -1;
 	}
 
@@ -786,7 +591,7 @@
 static void atkbd_cleanup(struct serio *serio)
 {
 	struct atkbd *atkbd = serio->private;
-	atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT);
+	ps2_command(&atkbd->ps2dev, NULL, ATKBD_CMD_RESET_BAT);
 }
 
 /*
@@ -797,7 +602,11 @@
 {
 	struct atkbd *atkbd = serio->private;
 
-	clear_bit(ATKBD_FLAG_ENABLED, &atkbd->flags);
+	serio_pause_rx(serio);
+	atkbd->enabled = 0;
+	serio_continue_rx(serio);
+
+	/* make sure we don't have a command in flight */
 	synchronize_kernel();
 	flush_scheduled_work();
 
@@ -822,8 +631,7 @@
 		return;
 	memset(atkbd, 0, sizeof(struct atkbd));
 
-	init_MUTEX(&atkbd->cmd_sem);
-	init_waitqueue_head(&atkbd->wait);
+	ps2_init(&atkbd->ps2dev, serio);
 
 	switch (serio->type & SERIO_TYPE) {
 
@@ -857,8 +665,6 @@
 		atkbd->dev.rep[REP_PERIOD] = 33;
 	} else atkbd_softraw = 1;
 
-	atkbd->serio = serio;
-
 	init_input_dev(&atkbd->dev);
 
 	atkbd->dev.keycode = atkbd->keycode;
@@ -932,7 +738,9 @@
 
 	input_register_device(&atkbd->dev);
 
-	set_bit(ATKBD_FLAG_ENABLED, &atkbd->flags);
+	serio_pause_rx(serio);
+	atkbd->enabled = 1;
+	serio_continue_rx(serio);
 
 	printk(KERN_INFO "input: %s on %s\n", atkbd->name, serio->phys);
 }
@@ -953,6 +761,10 @@
 		return -1;
 	}
 
+	serio_pause_rx(serio);
+	atkbd->enabled = 0;
+	serio_continue_rx(serio);
+
 	if (atkbd->write) {
 		param[0] = (test_bit(LED_SCROLLL, atkbd->dev.led) ? 1 : 0)
 		         | (test_bit(LED_NUML,    atkbd->dev.led) ? 2 : 0)
@@ -965,11 +777,13 @@
 
 		atkbd_enable(atkbd);
 
-		if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
+		if (ps2_command(&atkbd->ps2dev, param, ATKBD_CMD_SETLEDS))
 			return -1;
 	}
 
-	set_bit(ATKBD_FLAG_ENABLED, &atkbd->flags);
+	serio_pause_rx(serio);
+	atkbd->enabled = 1;
+	serio_continue_rx(serio);
 
 	return 0;
 }
diff -Nru a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
--- a/drivers/input/mouse/Kconfig	2004-09-16 23:30:14 -05:00
+++ b/drivers/input/mouse/Kconfig	2004-09-16 23:30:14 -05:00
@@ -16,6 +16,7 @@
 	default y
 	depends on INPUT && INPUT_MOUSE
 	select SERIO
+	select SERIO_LIBPS2
 	select SERIO_I8042 if PC
 	select SERIO_GSCPS2 if GSC
 	---help---
diff -Nru a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
--- a/drivers/input/mouse/logips2pp.c	2004-09-16 23:30:14 -05:00
+++ b/drivers/input/mouse/logips2pp.c	2004-09-16 23:30:14 -05:00
@@ -11,6 +11,7 @@
 
 #include <linux/input.h>
 #include <linux/serio.h>
+#include <linux/libps2.h>
 #include "psmouse.h"
 #include "logips2pp.h"
 
@@ -97,7 +98,7 @@
 	if (psmouse_sliced_command(psmouse, command))
 		return -1;
 
-	if (psmouse_command(psmouse, param, PSMOUSE_CMD_POLL))
+	if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_POLL))
 		return -1;
 
 	return 0;
@@ -113,19 +114,20 @@
 
 static void ps2pp_set_smartscroll(struct psmouse *psmouse)
 {
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[4];
 
 	ps2pp_cmd(psmouse, param, 0x32);
 
 	param[0] = 0;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
 
 	if (psmouse_smartscroll < 2) {
 		/* 0 - disabled, 1 - enabled */
 		param[0] = psmouse_smartscroll;
-		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+		ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
 	}
 }
 
@@ -137,11 +139,13 @@
 
 void ps2pp_set_800dpi(struct psmouse *psmouse)
 {
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param = 3;
-	psmouse_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11);
-	psmouse_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11);
-	psmouse_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11);
-	psmouse_command(psmouse, &param, PSMOUSE_CMD_SETRES);
+
+	ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
+	ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
+	ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
+	ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRES);
 }
 
 static struct ps2pp_info *get_model_info(unsigned char model)
@@ -238,18 +242,19 @@
 
 int ps2pp_init(struct psmouse *psmouse, int set_properties)
 {
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[4];
 	unsigned char protocol = PSMOUSE_PS2;
 	unsigned char model, buttons;
 	struct ps2pp_info *model_info;
 
 	param[0] = 0;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
+	ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11);
+	ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11);
+	ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11);
 	param[1] = 0;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO);
 
 	if (param[1] != 0) {
 		model = ((param[0] >> 4) & 0x07) | ((param[0] << 3) & 0x78);
@@ -263,16 +268,16 @@
 
 			/* Unprotect RAM */
 			param[0] = 0x11; param[1] = 0x04; param[2] = 0x68;
-			psmouse_command(psmouse, param, 0x30d1);
+			ps2_command(ps2dev, param, 0x30d1);
 			/* Enable features */
 			param[0] = 0x11; param[1] = 0x05; param[2] = 0x0b;
-			psmouse_command(psmouse, param, 0x30d1);
+			ps2_command(ps2dev, param, 0x30d1);
 			/* Enable PS2++ */
 			param[0] = 0x11; param[1] = 0x09; param[2] = 0xc3;
-			psmouse_command(psmouse, param, 0x30d1);
+			ps2_command(ps2dev, param, 0x30d1);
 
 			param[0] = 0;
-			if (!psmouse_command(psmouse, param, 0x13d1) &&
+			if (!ps2_command(ps2dev, param, 0x13d1) &&
 			    param[0] == 0x06 && param[1] == 0x00 && param[2] == 0x14) {
 				protocol = PSMOUSE_PS2TPP;
 			}
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-09-16 23:30:14 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-09-16 23:30:14 -05:00
@@ -18,6 +18,7 @@
 #include <linux/input.h>
 #include <linux/serio.h>
 #include <linux/init.h>
+#include <linux/libps2.h>
 #include "psmouse.h"
 #include "synaptics.h"
 #include "logips2pp.h"
@@ -144,63 +145,17 @@
 			printk(KERN_WARNING "psmouse.c: bad data from KBC -%s%s\n",
 				flags & SERIO_TIMEOUT ? " timeout" : "",
 				flags & SERIO_PARITY ? " bad parity" : "");
-		psmouse->nak = 1;
-		clear_bit(PSMOUSE_FLAG_ACK, &psmouse->flags);
-		clear_bit(PSMOUSE_FLAG_CMD,  &psmouse->flags);
-		wake_up_interruptible(&psmouse->wait);
+		ps2_cmd_aborted(&psmouse->ps2dev);
 		goto out;
 	}
 
-	if (test_bit(PSMOUSE_FLAG_ACK, &psmouse->flags)) {
-		switch (data) {
-			case PSMOUSE_RET_ACK:
-				psmouse->nak = 0;
-				break;
-
-			case PSMOUSE_RET_NAK:
-				psmouse->nak = 1;
-				break;
-
-			/*
-			 * Workaround for mice which don't ACK the Get ID command.
-			 * These are valid mouse IDs that we recognize.
-			 */
-			case 0x00:
-			case 0x03:
-			case 0x04:
-				if (test_bit(PSMOUSE_FLAG_WAITID, &psmouse->flags)) {
-					psmouse->nak = 0;
-					break;
-				}
-				/* Fall through */
-			default:
-				goto out;
-		}
-
-		if (!psmouse->nak && psmouse->cmdcnt) {
-			set_bit(PSMOUSE_FLAG_CMD, &psmouse->flags);
-			set_bit(PSMOUSE_FLAG_CMD1, &psmouse->flags);
-		}
-		clear_bit(PSMOUSE_FLAG_ACK, &psmouse->flags);
-		wake_up_interruptible(&psmouse->wait);
-
-		if (data == PSMOUSE_RET_ACK || data == PSMOUSE_RET_NAK)
+	if (unlikely(psmouse->ps2dev.flags & PS2_FLAG_ACK))
+		if  (ps2_handle_ack(&psmouse->ps2dev, data))
 			goto out;
-	}
 
-	if (test_bit(PSMOUSE_FLAG_CMD, &psmouse->flags)) {
-		if (psmouse->cmdcnt)
-			psmouse->cmdbuf[--psmouse->cmdcnt] = data;
-
-		if (test_and_clear_bit(PSMOUSE_FLAG_CMD1, &psmouse->flags) && psmouse->cmdcnt)
-			wake_up_interruptible(&psmouse->wait);
-
-		if (!psmouse->cmdcnt) {
-			clear_bit(PSMOUSE_FLAG_CMD, &psmouse->flags);
-			wake_up_interruptible(&psmouse->wait);
-		}
-		goto out;
-	}
+	if (unlikely(psmouse->ps2dev.flags & PS2_FLAG_CMD))
+		if  (ps2_handle_response(&psmouse->ps2dev, data))
+			goto out;
 
 	if (psmouse->state == PSMOUSE_INITIALIZING)
 		goto out;
@@ -246,7 +201,7 @@
 			if (++psmouse->out_of_sync == psmouse_resetafter) {
 				psmouse->state = PSMOUSE_IGNORE;
 				printk(KERN_NOTICE "psmouse.c: issuing reconnect request\n");
-				serio_reconnect(psmouse->serio);
+				serio_reconnect(psmouse->ps2dev.serio);
 			}
 			break;
 
@@ -266,100 +221,6 @@
 	return IRQ_HANDLED;
 }
 
-/*
- * psmouse_sendbyte() sends a byte to the mouse, and waits for acknowledge.
- * It doesn't handle retransmission, though it could - because when there would
- * be need for retransmissions, the mouse has to be replaced anyway.
- *
- * psmouse_sendbyte() can only be called from a process context
- */
-
-static int psmouse_sendbyte(struct psmouse *psmouse, unsigned char byte)
-{
-	psmouse->nak = 1;
-	set_bit(PSMOUSE_FLAG_ACK, &psmouse->flags);
-
-	if (serio_write(psmouse->serio, byte) == 0)
-		wait_event_interruptible_timeout(psmouse->wait,
-				!test_bit(PSMOUSE_FLAG_ACK, &psmouse->flags),
-				msecs_to_jiffies(200));
-
-	clear_bit(PSMOUSE_FLAG_ACK, &psmouse->flags);
-	return -psmouse->nak;
-}
-
-/*
- * psmouse_command() sends a command and its parameters to the mouse,
- * then waits for the response and puts it in the param array.
- *
- * psmouse_command() can only be called from a process context
- */
-
-int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command)
-{
-	int timeout;
-	int send = (command >> 12) & 0xf;
-	int receive = (command >> 8) & 0xf;
-	int rc = -1;
-	int i;
-
-	timeout = msecs_to_jiffies(command == PSMOUSE_CMD_RESET_BAT ? 4000 : 500);
-
-	clear_bit(PSMOUSE_FLAG_CMD, &psmouse->flags);
-	if (command == PSMOUSE_CMD_GETID)
-		set_bit(PSMOUSE_FLAG_WAITID, &psmouse->flags);
-
-	if (receive && param)
-		for (i = 0; i < receive; i++)
-			psmouse->cmdbuf[(receive - 1) - i] = param[i];
-
-	psmouse->cmdcnt = receive;
-
-	if (command & 0xff)
-		if (psmouse_sendbyte(psmouse, command & 0xff))
-			goto out;
-
-	for (i = 0; i < send; i++)
-		if (psmouse_sendbyte(psmouse, param[i]))
-			goto out;
-
-	timeout = wait_event_interruptible_timeout(psmouse->wait,
-				!test_bit(PSMOUSE_FLAG_CMD1, &psmouse->flags), timeout);
-
-	if (psmouse->cmdcnt && timeout > 0) {
-		if (command == PSMOUSE_CMD_RESET_BAT && jiffies_to_msecs(timeout) > 100)
-			timeout = msecs_to_jiffies(100);
-
-		if (command == PSMOUSE_CMD_GETID &&
-		    psmouse->cmdbuf[receive - 1] != 0xab && psmouse->cmdbuf[receive - 1] != 0xac) {
-			/*
-			 * Device behind the port is not a keyboard
-			 * so we don't need to wait for the 2nd byte
-			 * of ID response.
-			 */
-			clear_bit(PSMOUSE_FLAG_CMD, &psmouse->flags);
-			psmouse->cmdcnt = 0;
-		}
-
-		wait_event_interruptible_timeout(psmouse->wait,
-				!test_bit(PSMOUSE_FLAG_CMD, &psmouse->flags), timeout);
-	}
-
-	if (param)
-		for (i = 0; i < receive; i++)
-			param[i] = psmouse->cmdbuf[(receive - 1) - i];
-
-	if (psmouse->cmdcnt && (command != PSMOUSE_CMD_RESET_BAT || psmouse->cmdcnt != 1))
-		goto out;
-
-	rc = 0;
-
-out:
-	clear_bit(PSMOUSE_FLAG_CMD, &psmouse->flags);
-	clear_bit(PSMOUSE_FLAG_CMD1, &psmouse->flags);
-	clear_bit(PSMOUSE_FLAG_WAITID, &psmouse->flags);
-	return rc;
-}
 
 /*
  * psmouse_sliced_command() sends an extended PS/2 command to the mouse
@@ -372,12 +233,12 @@
 {
 	int i;
 
-	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11))
+	if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11))
 		return -1;
 
 	for (i = 6; i >= 0; i -= 2) {
 		unsigned char d = (command >> i) & 3;
-		if (psmouse_command(psmouse, &d, PSMOUSE_CMD_SETRES))
+		if (ps2_command(&psmouse->ps2dev, &d, PSMOUSE_CMD_SETRES))
 			return -1;
 	}
 
@@ -392,7 +253,7 @@
 {
 	unsigned char param[2];
 
-	if (psmouse_command(psmouse, param, PSMOUSE_CMD_RESET_BAT))
+	if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_RESET_BAT))
 		return -1;
 
 	if (param[0] != PSMOUSE_RET_BAT && param[1] != PSMOUSE_RET_ID)
@@ -407,14 +268,15 @@
  */
 static int genius_detect(struct psmouse *psmouse)
 {
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[4];
 
 	param[0] = 3;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
-	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
+	ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11);
+	ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11);
+	ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO);
 
 	return param[0] == 0x00 && param[1] == 0x33 && param[2] == 0x55;
 }
@@ -424,15 +286,16 @@
  */
 static int intellimouse_detect(struct psmouse *psmouse)
 {
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[2];
 
 	param[0] = 200;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
 	param[0] = 100;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
 	param[0] =  80;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
-	psmouse_command(psmouse, param, PSMOUSE_CMD_GETID);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
 
 	return param[0] == 3;
 }
@@ -442,17 +305,18 @@
  */
 static int im_explorer_detect(struct psmouse *psmouse)
 {
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[2];
 
 	intellimouse_detect(psmouse);
 
 	param[0] = 200;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
 	param[0] = 200;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
 	param[0] =  80;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
-	psmouse_command(psmouse, param, PSMOUSE_CMD_GETID);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
 
 	return param[0] == 4;
 }
@@ -549,7 +413,7 @@
  * extensions.
  */
 		psmouse_reset(psmouse);
-		psmouse_command(psmouse, NULL, PSMOUSE_CMD_RESET_DIS);
+		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
 	}
 
 	return PSMOUSE_PS2;
@@ -561,6 +425,7 @@
 
 static int psmouse_probe(struct psmouse *psmouse)
 {
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[2];
 
 /*
@@ -569,8 +434,7 @@
  */
 
 	param[0] = 0xa5;
-
-	if (psmouse_command(psmouse, param, PSMOUSE_CMD_GETID))
+	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETID))
 		return -1;
 
 	if (param[0] != 0x00 && param[0] != 0x03 && param[0] != 0x04)
@@ -580,8 +444,8 @@
  * Then we reset and disable the mouse so that it doesn't generate events.
  */
 
-	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_RESET_DIS))
-		printk(KERN_WARNING "psmouse.c: Failed to reset mouse on %s\n", psmouse->serio->phys);
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_DIS))
+		printk(KERN_WARNING "psmouse.c: Failed to reset mouse on %s\n", ps2dev->serio->phys);
 
 	return 0;
 }
@@ -608,7 +472,7 @@
 	else if (psmouse_resolution)
 		param[0] = 0;
 
-        psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+        ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_SETRES);
 }
 
 /*
@@ -621,7 +485,7 @@
 	int i = 0;
 
 	while (rates[i] > psmouse_rate) i++;
-	psmouse_command(psmouse, rates + i, PSMOUSE_CMD_SETRATE);
+	ps2_command(&psmouse->ps2dev, rates + i, PSMOUSE_CMD_SETRATE);
 }
 
 /*
@@ -639,14 +503,14 @@
 	if (psmouse_max_proto != PSMOUSE_PS2) {
 		psmouse_set_rate(psmouse);
 		psmouse_set_resolution(psmouse);
-		psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
+		ps2_command(&psmouse->ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11);
 	}
 
 /*
  * We set the mouse into streaming mode.
  */
 
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETSTREAM);
+	ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_SETSTREAM);
 }
 
 /*
@@ -657,11 +521,11 @@
 
 static void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state)
 {
-	serio_pause_rx(psmouse->serio);
+	serio_pause_rx(psmouse->ps2dev.serio);
 	psmouse->state = new_state;
-	psmouse->pktcnt = psmouse->cmdcnt = psmouse->out_of_sync = 0;
-	psmouse->flags = 0;
-	serio_continue_rx(psmouse->serio);
+	psmouse->pktcnt = psmouse->out_of_sync = 0;
+	psmouse->ps2dev.flags = 0;
+	serio_continue_rx(psmouse->ps2dev.serio);
 }
 
 /*
@@ -670,8 +534,9 @@
 
 static void psmouse_activate(struct psmouse *psmouse)
 {
-	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE))
-		printk(KERN_WARNING "psmouse.c: Failed to enable mouse on %s\n", psmouse->serio->phys);
+	if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE))
+		printk(KERN_WARNING "psmouse.c: Failed to enable mouse on %s\n",
+			psmouse->ps2dev.serio->phys);
 
 	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
 }
@@ -684,8 +549,9 @@
 
 static void psmouse_deactivate(struct psmouse *psmouse)
 {
-	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_DISABLE))
-		printk(KERN_WARNING "psmouse.c: Failed to deactivate mouse on %s\n", psmouse->serio->phys);
+	if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_DISABLE))
+		printk(KERN_WARNING "psmouse.c: Failed to deactivate mouse on %s\n",
+			psmouse->ps2dev.serio->phys);
 
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 }
@@ -755,12 +621,10 @@
 
 	memset(psmouse, 0, sizeof(struct psmouse));
 
-	init_waitqueue_head(&psmouse->wait);
-	init_input_dev(&psmouse->dev);
+	ps2_init(&psmouse->ps2dev, serio);
 	psmouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
 	psmouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
 	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
-	psmouse->serio = serio;
 	psmouse->dev.private = psmouse;
 	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
 
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	2004-09-16 23:30:14 -05:00
+++ b/drivers/input/mouse/psmouse.h	2004-09-16 23:30:14 -05:00
@@ -18,11 +18,6 @@
 #define PSMOUSE_RET_ACK		0xfa
 #define PSMOUSE_RET_NAK		0xfe
 
-#define PSMOUSE_FLAG_ACK	0	/* Waiting for ACK/NAK */
-#define PSMOUSE_FLAG_CMD	1	/* Waiting for command to finish */
-#define PSMOUSE_FLAG_CMD1	2	/* Waiting for the first byte of command response */
-#define PSMOUSE_FLAG_WAITID	3	/* Command execiting is GET ID */
-
 enum psmouse_state {
 	PSMOUSE_IGNORE,
 	PSMOUSE_INITIALIZING,
@@ -40,26 +35,18 @@
 struct psmouse {
 	void *private;
 	struct input_dev dev;
-	struct serio *serio;
+	struct ps2dev ps2dev;
 	char *vendor;
 	char *name;
-	unsigned char cmdbuf[8];
 	unsigned char packet[8];
-	unsigned char cmdcnt;
 	unsigned char pktcnt;
 	unsigned char type;
 	unsigned char model;
 	unsigned long last;
 	unsigned long out_of_sync;
 	enum psmouse_state state;
-	unsigned char nak;
-	char error;
 	char devname[64];
 	char phys[32];
-	unsigned long flags;
-
-	/* Used to signal completion from interrupt handler */
-	wait_queue_head_t wait;
 
 	psmouse_ret_t (*protocol_handler)(struct psmouse *psmouse, struct pt_regs *regs);
 	int (*reconnect)(struct psmouse *psmouse);
@@ -77,7 +64,6 @@
 #define PSMOUSE_IMEX		6
 #define PSMOUSE_SYNAPTICS 	7
 
-int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command);
 int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);
 int psmouse_reset(struct psmouse *psmouse);
 
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-09-16 23:30:14 -05:00
+++ b/drivers/input/mouse/synaptics.c	2004-09-16 23:30:14 -05:00
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/input.h>
 #include <linux/serio.h>
+#include <linux/libps2.h>
 #include "psmouse.h"
 #include "synaptics.h"
 
@@ -50,7 +51,7 @@
 {
 	if (psmouse_sliced_command(psmouse, c))
 		return -1;
-	if (psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO))
+	if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_GETINFO))
 		return -1;
 	return 0;
 }
@@ -65,7 +66,7 @@
 	if (psmouse_sliced_command(psmouse, mode))
 		return -1;
 	param[0] = SYN_PS_SET_MODE2;
-	if (psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE))
+	if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_SETRATE))
 		return -1;
 	return 0;
 }
@@ -219,7 +220,7 @@
 
 	if (psmouse_sliced_command(parent, c))
 		return -1;
-	if (psmouse_command(parent, &rate_param, PSMOUSE_CMD_SETRATE))
+	if (ps2_command(&parent->ps2dev, &rate_param, PSMOUSE_CMD_SETRATE))
 		return -1;
 	return 0;
 }
@@ -245,7 +246,7 @@
 
 static void synaptics_pt_activate(struct psmouse *psmouse)
 {
-	struct psmouse *child = psmouse->serio->child->private;
+	struct psmouse *child = psmouse->ps2dev.serio->child->private;
 
 	/* adjust the touchpad to child's choice of protocol */
 	if (child && child->type >= PSMOUSE_GENPS) {
@@ -270,11 +271,11 @@
 	strlcpy(serio->name, "Synaptics pass-through", sizeof(serio->name));
 	strlcpy(serio->phys, "synaptics-pt/serio0", sizeof(serio->name));
 	serio->write = synaptics_pt_write;
-	serio->parent = psmouse->serio;
+	serio->parent = psmouse->ps2dev.serio;
 
 	psmouse->pt_activate = synaptics_pt_activate;
 
-	psmouse->serio->child = serio;
+	psmouse->ps2dev.serio->child = serio;
 }
 
 /*****************************************************************************
@@ -470,8 +471,8 @@
 			priv->pkt_type = synaptics_detect_pkt_type(psmouse);
 
 		if (SYN_CAP_PASS_THROUGH(priv->capabilities) && synaptics_is_pt_packet(psmouse->packet)) {
-			if (psmouse->serio->child)
-				synaptics_pass_pt_packet(psmouse->serio->child, psmouse->packet);
+			if (psmouse->ps2dev.serio->child)
+				synaptics_pass_pt_packet(psmouse->ps2dev.serio->child, psmouse->packet);
 		} else
 			synaptics_process_packet(psmouse);
 
@@ -561,15 +562,16 @@
 
 int synaptics_detect(struct psmouse *psmouse)
 {
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[4];
 
 	param[0] = 0;
 
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO);
 
 	return param[1] == 0x47;
 }
diff -Nru a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
--- a/drivers/input/serio/Kconfig	2004-09-16 23:30:14 -05:00
+++ b/drivers/input/serio/Kconfig	2004-09-16 23:30:14 -05:00
@@ -131,6 +131,16 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called maceps2.
 
+config SERIO_LIBPS2
+	tristate "PS/2 driver library"
+	depends on SERIO
+	help
+	  Say Y here if you are using a driver for device connected
+	  to a PS/2 port, such as PS/2 mouse or standard AT keyboard.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called libps2.
+
 config SERIO_RAW
 	tristate "Raw access to serio ports"
 	depends on SERIO
diff -Nru a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
--- a/drivers/input/serio/Makefile	2004-09-16 23:30:14 -05:00
+++ b/drivers/input/serio/Makefile	2004-09-16 23:30:14 -05:00
@@ -17,4 +17,5 @@
 obj-$(CONFIG_SERIO_GSCPS2)	+= gscps2.o
 obj-$(CONFIG_SERIO_PCIPS2)	+= pcips2.o
 obj-$(CONFIG_SERIO_MACEPS2)	+= maceps2.o
+obj-$(CONFIG_SERIO_LIBPS2)	+= libps2.o
 obj-$(CONFIG_SERIO_RAW)		+= serio_raw.o
diff -Nru a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/input/serio/libps2.c	2004-09-16 23:30:14 -05:00
@@ -0,0 +1,273 @@
+/*
+ * PS/2 driver library
+ *
+ * Copyright (c) 1999-2002 Vojtech Pavlik
+ * Copyright (c) 2004 Dmitry Torokhov
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/serio.h>
+#include <linux/init.h>
+#include <linux/libps2.h>
+
+#define DRIVER_DESC	"PS/2 driver library"
+
+MODULE_AUTHOR("Dmitry Torokhov <dtor@mail.ru>");
+MODULE_DESCRIPTION("PS/2 driver library");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(ps2_init);
+EXPORT_SYMBOL(ps2_sendbyte);
+EXPORT_SYMBOL(ps2_command);
+EXPORT_SYMBOL(ps2_schedule_command);
+EXPORT_SYMBOL(ps2_handle_ack);
+EXPORT_SYMBOL(ps2_handle_response);
+EXPORT_SYMBOL(ps2_cmd_aborted);
+
+/* Work structure to schedule execution of a command */
+struct ps2work {
+	struct work_struct work;
+	struct ps2dev *ps2dev;
+	int command;
+	unsigned char param[0];
+};
+
+
+/*
+ * ps2_sendbyte() sends a byte to the mouse, and waits for acknowledge.
+ * It doesn't handle retransmission, though it could - because when there would
+ * be need for retransmissions, the mouse has to be replaced anyway.
+ *
+ * ps2_sendbyte() can only be called from a process context
+ */
+
+int ps2_sendbyte(struct ps2dev *ps2dev, unsigned char byte)
+{
+	serio_pause_rx(ps2dev->serio);
+	ps2dev->nak = 1;
+	ps2dev->flags |= PS2_FLAG_ACK;
+	serio_continue_rx(ps2dev->serio);
+
+	if (serio_write(ps2dev->serio, byte) == 0)
+		wait_event_interruptible_timeout(ps2dev->wait,
+					!(ps2dev->flags & PS2_FLAG_ACK),
+					msecs_to_jiffies(200));
+
+	serio_pause_rx(ps2dev->serio);
+	ps2dev->flags &= ~PS2_FLAG_ACK;
+	serio_continue_rx(ps2dev->serio);
+
+	return -ps2dev->nak;
+}
+
+/*
+ * ps2_command() sends a command and its parameters to the mouse,
+ * then waits for the response and puts it in the param array.
+ *
+ * ps2_command() can only be called from a process context
+ */
+
+int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command)
+{
+	int timeout;
+	int send = (command >> 12) & 0xf;
+	int receive = (command >> 8) & 0xf;
+	int rc = -1;
+	int i;
+
+	down(&ps2dev->cmd_sem);
+
+	timeout = msecs_to_jiffies(command == PS2_CMD_RESET_BAT ? 4000 : 500);
+
+	serio_pause_rx(ps2dev->serio);
+	ps2dev->flags = command == PS2_CMD_GETID ? PS2_FLAG_WAITID : 0;
+	ps2dev->cmdcnt = receive;
+	if (receive && param)
+		for (i = 0; i < receive; i++)
+			ps2dev->cmdbuf[(receive - 1) - i] = param[i];
+	serio_continue_rx(ps2dev->serio);
+
+	if (command & 0xff)
+		if (ps2_sendbyte(ps2dev, command & 0xff))
+			goto out;
+
+	for (i = 0; i < send; i++)
+		if (ps2_sendbyte(ps2dev, param[i]))
+			goto out;
+
+	timeout = wait_event_interruptible_timeout(ps2dev->wait,
+				!(ps2dev->flags & PS2_FLAG_CMD1), timeout);
+
+	if (ps2dev->cmdcnt && timeout > 0) {
+		if (command == PS2_CMD_RESET_BAT && jiffies_to_msecs(timeout) > 100)
+			timeout = msecs_to_jiffies(100);
+
+		if (command == PS2_CMD_GETID &&
+		    ps2dev->cmdbuf[receive - 1] != 0xab && ps2dev->cmdbuf[receive - 1] != 0xac) {
+			/*
+			 * Device behind the port is not a keyboard
+			 * so we don't need to wait for the 2nd byte
+			 * of ID response.
+			 */
+			serio_pause_rx(ps2dev->serio);
+			ps2dev->flags = ps2dev->cmdcnt = 0;
+			serio_continue_rx(ps2dev->serio);
+		}
+
+		wait_event_interruptible_timeout(ps2dev->wait,
+				!(ps2dev->flags & PS2_FLAG_CMD), timeout);
+	}
+
+	if (param)
+		for (i = 0; i < receive; i++)
+			param[i] = ps2dev->cmdbuf[(receive - 1) - i];
+
+	if (ps2dev->cmdcnt && (command != PS2_CMD_RESET_BAT || ps2dev->cmdcnt != 1))
+		goto out;
+
+	rc = 0;
+
+out:
+	serio_pause_rx(ps2dev->serio);
+	ps2dev->flags = 0;
+	serio_continue_rx(ps2dev->serio);
+
+	up(&ps2dev->cmd_sem);
+	return rc;
+}
+
+/*
+ * ps2_execute_scheduled_command() sends a command, previously scheduled by
+ * ps2_schedule_command(), to a PS/2 device (keyboard, mouse, etc.)
+ */
+
+static void ps2_execute_scheduled_command(void *data)
+{
+	struct ps2work *ps2work = data;
+
+	ps2_command(ps2work->ps2dev, ps2work->param, ps2work->command);
+	kfree(ps2work);
+}
+
+/*
+ * ps2_schedule_command() allows to schedule delayed execution of a PS/2
+ * command and can be used to issue a command from an interrupt or softirq
+ * context.
+ */
+
+int ps2_schedule_command(struct ps2dev *ps2dev, unsigned char *param, int command)
+{
+	struct ps2work *ps2work;
+	int send = (command >> 12) & 0xf;
+	int receive = (command >> 8) & 0xf;
+
+	if (!(ps2work = kmalloc(sizeof(struct ps2work) + max(send, receive), GFP_ATOMIC)))
+		return -1;
+
+	memset(ps2work, 0, sizeof(struct ps2work));
+	ps2work->ps2dev = ps2dev;
+	ps2work->command = command;
+	memcpy(ps2work->param, param, send);
+	INIT_WORK(&ps2work->work, ps2_execute_scheduled_command, ps2work);
+
+	if (!schedule_work(&ps2work->work)) {
+		kfree(ps2work);
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * ps2_init() initializes ps2dev structure
+ */
+
+void ps2_init(struct ps2dev *ps2dev, struct serio *serio)
+{
+	init_MUTEX(&ps2dev->cmd_sem);
+	init_waitqueue_head(&ps2dev->wait);
+	ps2dev->serio = serio;
+}
+
+/*
+ * ps2_handle_ack()
+ */
+
+int ps2_handle_ack(struct ps2dev *ps2dev, unsigned char data)
+{
+	switch (data) {
+		case PS2_RET_ACK:
+			ps2dev->nak = 0;
+			break;
+
+		case PS2_RET_NAK:
+			ps2dev->nak = 1;
+			break;
+
+		/*
+		 * Workaround for mice which don't ACK the Get ID command.
+		 * These are valid mouse IDs that we recognize.
+		 */
+		case 0x00:
+		case 0x03:
+		case 0x04:
+			if (ps2dev->flags & PS2_FLAG_WAITID) {
+				ps2dev->nak = 0;
+				break;
+			}
+			/* Fall through */
+		default:
+			return 1;
+	}
+
+	if (!ps2dev->nak && ps2dev->cmdcnt)
+		ps2dev->flags |= PS2_FLAG_CMD | PS2_FLAG_CMD1;
+
+	ps2dev->flags &= ~PS2_FLAG_ACK;
+	wake_up_interruptible(&ps2dev->wait);
+
+	return data == PS2_RET_ACK || data == PS2_RET_NAK;
+}
+
+
+int ps2_handle_response(struct ps2dev *ps2dev, unsigned char data)
+{
+	if (ps2dev->cmdcnt)
+		ps2dev->cmdbuf[--ps2dev->cmdcnt] = data;
+
+	if (ps2dev->flags & PS2_FLAG_CMD1) {
+		ps2dev->flags &= ~PS2_FLAG_CMD1;
+		if (ps2dev->cmdcnt)
+			wake_up_interruptible(&ps2dev->wait);
+	}
+
+	if (!ps2dev->cmdcnt) {
+		ps2dev->flags &= ~PS2_FLAG_CMD;
+		wake_up_interruptible(&ps2dev->wait);
+	}
+
+	return 1;
+}
+
+void ps2_cmd_aborted(struct ps2dev *ps2dev)
+{
+	if (ps2dev->flags & PS2_FLAG_ACK)
+		ps2dev->nak = 1;
+
+	if (ps2dev->flags & (PS2_FLAG_ACK | PS2_FLAG_CMD))
+		wake_up_interruptible(&ps2dev->wait);
+
+	ps2dev->flags = 0;
+}
+
diff -Nru a/include/linux/libps2.h b/include/linux/libps2.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/libps2.h	2004-09-16 23:30:14 -05:00
@@ -0,0 +1,50 @@
+#ifndef _LIBPS2_H
+#define _LIBPS2_H
+
+/*
+ * Copyright (C) 1999-2002 Vojtech Pavlik
+ * Copyright (C) 2004 Dmitry Torokhov
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+
+#define PS2_CMD_GETID		0x02f2
+#define PS2_CMD_RESET_BAT	0x02ff
+
+#define PS2_RET_BAT		0xaa
+#define PS2_RET_ID		0x00
+#define PS2_RET_ACK		0xfa
+#define PS2_RET_NAK		0xfe
+
+#define PS2_FLAG_ACK		1	/* Waiting for ACK/NAK */
+#define PS2_FLAG_CMD		2	/* Waiting for command to finish */
+#define PS2_FLAG_CMD1		4	/* Waiting for the first byte of command response */
+#define PS2_FLAG_WAITID		8	/* Command execiting is GET ID */
+
+struct ps2dev {
+	struct serio *serio;
+
+	/* Ensures that only one command is executing at a time */
+	struct semaphore cmd_sem;
+
+	/* Used to signal completion from interrupt handler */
+	wait_queue_head_t wait;
+
+	unsigned long flags;
+	unsigned char cmdbuf[6];
+	unsigned char cmdcnt;
+	unsigned char nak;
+};
+
+void ps2_init(struct ps2dev *ps2dev, struct serio *serio);
+int ps2_sendbyte(struct ps2dev *ps2dev, unsigned char byte);
+int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command);
+int ps2_schedule_command(struct ps2dev *ps2dev, unsigned char *param, int command);
+int ps2_handle_ack(struct ps2dev *ps2dev, unsigned char data);
+int ps2_handle_response(struct ps2dev *ps2dev, unsigned char data);
+void ps2_cmd_aborted(struct ps2dev *ps2dev);
+
+#endif /* _LIBPS2_H */
