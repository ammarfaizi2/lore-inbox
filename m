Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266726AbUG0Xl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266726AbUG0Xl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 19:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266730AbUG0Xl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 19:41:26 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:27242 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266726AbUG0XlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 19:41:14 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
Date: Tue, 27 Jul 2004 18:41:09 -0500
User-Agent: KMail/1.6.2
Cc: Ingo Molnar <mingo@elte.hu>, William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, Arjan van de Ven <arjanv@redhat.com>
References: <40F3F0A0.9080100@vision.ee> <20040726204720.GA26561@elte.hu> <20040727162759.GA32548@elte.hu>
In-Reply-To: <20040727162759.GA32548@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407271841.11629.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 July 2004 11:27 am, Ingo Molnar wrote:
> other changes in -L2:
> 
> i've done a softirq lock-break in the atkbd and ps2mouse drivers - this
> should fix the big latencies triggered by NumLock/CapsLock, reported by
> Lee Revell.
> 

Actually the following seems to be working on my laptop and I was thinking
about pushing it to Vojtech. Any reason why this should not be done?

(The patch is on top of Vojtech's tee + my other changes so it won't apply
to anything.)

===== drivers/input/keyboard/atkbd.c 1.66 vs edited =====
--- 1.66/drivers/input/keyboard/atkbd.c	2004-07-26 01:35:39 -05:00
+++ edited/drivers/input/keyboard/atkbd.c	2004-07-26 22:54:41 -05:00
@@ -209,10 +209,25 @@
 	unsigned int last;
 	unsigned long time;
 
+	/* Ensures that only one command is executing at a time */
+	struct semaphore cmd_sem;
+
+	/* Used to signal completion from interrupt handler */
+	wait_queue_head_t wait;
+
 	/* Flags */
 	unsigned long flags;
 };
 
+/* Work structure to schedule execution of a command */
+struct atkbd_work {
+	struct work_struct work;
+	struct atkbd *atkbd;
+	int command;
+	unsigned char param[0];
+};
+
+
 static void atkbd_report_key(struct input_dev *dev, struct pt_regs *regs, int code, int value)
 {
 	input_regs(dev, regs);
@@ -262,10 +277,12 @@
 					set_bit(ATKBD_FLAG_CMD1, &atkbd->flags);
 				}
 				clear_bit(ATKBD_FLAG_ACK, &atkbd->flags);
+				wake_up_interruptible(&atkbd->wait);
 				break;
 			case ATKBD_RET_NAK:
 				atkbd->nak = 1;
 				clear_bit(ATKBD_FLAG_ACK, &atkbd->flags);
+				wake_up_interruptible(&atkbd->wait);
 				break;
 		}
 		goto out;
@@ -276,10 +293,13 @@
 		if (atkbd->cmdcnt)
 			atkbd->cmdbuf[--atkbd->cmdcnt] = code;
 
-		clear_bit(ATKBD_FLAG_CMD1, &atkbd->flags);
-		if (!atkbd->cmdcnt)
-			clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
+		if (test_and_clear_bit(ATKBD_FLAG_CMD1, &atkbd->flags) && atkbd->cmdcnt)
+			wake_up_interruptible(&atkbd->wait);
 
+		if (!atkbd->cmdcnt) {
+			clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
+			wake_up_interruptible(&atkbd->wait);
+		}
 		goto out;
 	}
 
@@ -412,12 +432,12 @@
  * acknowledge. It doesn't handle resends according to the keyboard
  * protocol specs, because if these are needed, the keyboard needs
  * replacement anyway, and they only make a mess in the protocol.
+ *
+ * atkbd_sendbyte() can only be called from a process context
  */
 
 static int atkbd_sendbyte(struct atkbd *atkbd, unsigned char byte)
 {
-	int timeout = 200000; /* 200 msec */
-
 #ifdef ATKBD_DEBUG
 	printk(KERN_DEBUG "atkbd.c: Sent: %02x\n", byte);
 #endif
@@ -425,8 +445,9 @@
 	set_bit(ATKBD_FLAG_ACK, &atkbd->flags);
 
 	if (serio_write(atkbd->serio, byte) == 0)
-		while (test_bit(ATKBD_FLAG_ACK, &atkbd->flags) && timeout--)
-			udelay(1);
+		wait_event_interruptible_timeout(atkbd->wait,
+				!test_bit(ATKBD_FLAG_ACK, &atkbd->flags),
+				msecs_to_jiffies(200));
 
 	clear_bit(ATKBD_FLAG_ACK, &atkbd->flags);
 	return -atkbd->nak;
@@ -435,19 +456,21 @@
 /*
  * atkbd_command() sends a command, and its parameters to the keyboard,
  * then waits for the response and puts it in the param array.
+ *
+ * atkbd_command() can only be called from a process context
  */
 
 static int atkbd_command(struct atkbd *atkbd, unsigned char *param, int command)
 {
-	int timeout = 500000; /* 500 msec */
+	int timeout;
 	int send = (command >> 12) & 0xf;
 	int receive = (command >> 8) & 0xf;
 	int rc = -1;
 	int i;
 
-	if (command == ATKBD_CMD_RESET_BAT)
-		timeout = 4000000; /* 4 sec */
+	timeout = msecs_to_jiffies(command == ATKBD_CMD_RESET_BAT ? 4000 : 500);
 
+	down(&atkbd->cmd_sem);
 	clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
 
 	if (receive && param)
@@ -464,27 +487,26 @@
 		if (atkbd_sendbyte(atkbd, param[i]))
 			goto out;
 
-	while (test_bit(ATKBD_FLAG_CMD, &atkbd->flags) && timeout--) {
-
-		if (!test_bit(ATKBD_FLAG_CMD1, &atkbd->flags)) {
-
-			if (command == ATKBD_CMD_RESET_BAT && timeout > 100000)
-				timeout = 100000;
+	timeout = wait_event_interruptible_timeout(atkbd->wait,
+				!test_bit(ATKBD_FLAG_CMD1, &atkbd->flags), timeout);
 
-			if (command == ATKBD_CMD_GETID &&
-			    atkbd->cmdbuf[receive - 1] != 0xab && atkbd->cmdbuf[receive - 1] != 0xac) {
-				/*
-				 * Device behind the port is not a keyboard
-				 * so we don't need to wait for the 2nd byte
-				 * of ID response.
-				 */
-				clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
-				atkbd->cmdcnt = 0;
-				break;
-			}
+	if (atkbd->cmdcnt && timeout > 0) {
+		if (command == ATKBD_CMD_RESET_BAT && jiffies_to_msecs(timeout) > 100)
+			timeout = msecs_to_jiffies(100);
+
+		if (command == ATKBD_CMD_GETID &&
+		    atkbd->cmdbuf[receive - 1] != 0xab && atkbd->cmdbuf[receive - 1] != 0xac) {
+			/*
+			 * Device behind the port is not a keyboard
+			 * so we don't need to wait for the 2nd byte
+			 * of ID response.
+			 */
+			clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
+			atkbd->cmdcnt = 0;
 		}
 
-		udelay(1);
+		wait_event_interruptible_timeout(atkbd->wait,
+				!test_bit(ATKBD_FLAG_CMD, &atkbd->flags), timeout);
 	}
 
 	if (param)
@@ -499,11 +521,59 @@
 out:
 	clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
 	clear_bit(ATKBD_FLAG_CMD1, &atkbd->flags);
+	up(&atkbd->cmd_sem);
 
 	return rc;
 }
 
 /*
+ * atkbd_execute_scheduled_command() sends a command, previously scheduled by
+ * atkbd_schedule_command(), to the keyboard.
+ */
+
+static void atkbd_execute_scheduled_command(void *data)
+{
+	struct atkbd_work *atkbd_work = data;
+
+	atkbd_command(atkbd_work->atkbd, atkbd_work->param, atkbd_work->command);
+
+	kfree(atkbd_work);
+}
+
+/*
+ * atkbd_schedule_command() allows to schedule delayed execution of a keyboard
+ * command and can be used to issue a command from an interrupt or softirq
+ * context.
+ */
+
+static int atkbd_schedule_command(struct atkbd *atkbd, unsigned char *param, int command)
+{
+	struct atkbd_work *atkbd_work;
+	int send = (command >> 12) & 0xf;
+	int receive = (command >> 8) & 0xf;
+
+	if (!test_bit(ATKBD_FLAG_ENABLED, &atkbd->flags))
+		return -1;
+
+	if (!(atkbd_work = kmalloc(sizeof(struct atkbd_work) + max(send, receive), GFP_ATOMIC)))
+		return -1;
+
+	memset(atkbd_work, 0, sizeof(struct atkbd_work));
+	atkbd_work->atkbd = atkbd;
+	atkbd_work->command = command;
+	memcpy(atkbd_work->param, param, send);
+	INIT_WORK(&atkbd_work->work, atkbd_execute_scheduled_command, atkbd_work);
+
+	if (!schedule_work(&atkbd_work->work)) {
+		kfree(atkbd_work);
+		return -1;
+	}
+
+	return 0;
+}
+
+
+/*
  * Event callback from the input module. Events that change the state of
  * the hardware are processed here.
  */
@@ -529,7 +599,7 @@
 			param[0] = (test_bit(LED_SCROLLL, dev->led) ? 1 : 0)
 			         | (test_bit(LED_NUML,    dev->led) ? 2 : 0)
 			         | (test_bit(LED_CAPSL,   dev->led) ? 4 : 0);
-		        atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS);
+		        atkbd_schedule_command(atkbd, param, ATKBD_CMD_SETLEDS);
 
 			if (atkbd->extra) {
 				param[0] = 0;
@@ -538,7 +608,7 @@
 					 | (test_bit(LED_SUSPEND, dev->led) ? 0x04 : 0)
 				         | (test_bit(LED_MISC,    dev->led) ? 0x10 : 0)
 				         | (test_bit(LED_MUTE,    dev->led) ? 0x20 : 0);
-				atkbd_command(atkbd, param, ATKBD_CMD_EX_SETLEDS);
+				atkbd_schedule_command(atkbd, param, ATKBD_CMD_EX_SETLEDS);
 			}
 
 			return 0;
@@ -554,7 +624,7 @@
 			dev->rep[REP_PERIOD] = period[i];
 			dev->rep[REP_DELAY] = delay[j];
 			param[0] = i | (j << 5);
-			atkbd_command(atkbd, param, ATKBD_CMD_SETREP);
+			atkbd_schedule_command(atkbd, param, ATKBD_CMD_SETREP);
 
 			return 0;
 	}
@@ -726,7 +796,11 @@
 static void atkbd_disconnect(struct serio *serio)
 {
 	struct atkbd *atkbd = serio->private;
+
 	clear_bit(ATKBD_FLAG_ENABLED, &atkbd->flags);
+	synchronize_kernel();
+	flush_scheduled_work();
+
 	input_unregister_device(&atkbd->dev);
 	serio_close(serio);
 	kfree(atkbd);
@@ -747,6 +821,9 @@
 	if (!(atkbd = kmalloc(sizeof(struct atkbd), GFP_KERNEL)))
 		return;
 	memset(atkbd, 0, sizeof(struct atkbd));
+
+	init_MUTEX(&atkbd->cmd_sem);
+	init_waitqueue_head(&atkbd->wait);
 
 	switch (serio->type & SERIO_TYPE) {
 
