Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265201AbUG2SWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbUG2SWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267754AbUG2O4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:56:32 -0400
Received: from styx.suse.cz ([82.119.242.94]:62101 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264774AbUG2OIH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:07 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 4/47] Ensure exclusive access to variables in atkbd.c
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:54 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <1091110194564@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101944159@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.54.2, 2004-05-30 16:57:22+02:00, vojtech@suse.cz
  input: Make atomicity and exclusive access to variables explicit
  in atkbd.c, using bitops.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 atkbd.c |  133 ++++++++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 89 insertions(+), 44 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Thu Jul 29 14:42:14 2004
+++ b/drivers/input/keyboard/atkbd.c	Thu Jul 29 14:42:14 2004
@@ -164,34 +164,48 @@
 	{ ATKBD_SCR_CLICK, 0x60 },
 };
 
+#define ATKBD_FLAG_ACK		0	/* Waiting for ACK/NAK */
+#define ATKBD_FLAG_CMD		1	/* Waiting for command to finish */
+#define ATKBD_FLAG_CMD1		2	/* First byte of command response */
+#define ATKBD_FLAG_ID		3	/* First byte is not keyboard ID */
+#define ATKBD_FLAG_ENABLED	4	/* Waining for init to finish */
+
 /*
  * The atkbd control structure
  */
 
 struct atkbd {
-	unsigned char keycode[512];
-	struct input_dev dev;
-	struct serio *serio;
 
+	/* Written only during init */
 	char name[64];
 	char phys[32];
-	unsigned short id;
+	struct serio *serio;
+	struct input_dev dev;
+
 	unsigned char set;
-	unsigned int translated:1;
-	unsigned int extra:1;
-	unsigned int write:1;
+	unsigned short id;
+	unsigned char keycode[512];
+	unsigned char translated;
+	unsigned char extra;
+	unsigned char write;
+
+	/* Protected by FLAG_ACK */
+	unsigned char nak;
 
+	/* Protected by FLAG_CMD */
 	unsigned char cmdbuf[4];
 	unsigned char cmdcnt;
-	volatile signed char ack;
-	unsigned char emul;
-	unsigned int resend:1;
-	unsigned int release:1;
-	unsigned int bat_xl:1;
-	unsigned int enabled:1;
 
+	/* Accessed only from interrupt */
+	unsigned char emul;
+	unsigned char resend;
+	unsigned char release;
+	unsigned char bat_xl;
 	unsigned int last;
 	unsigned long time;
+
+	/* Flags */
+	unsigned long flags;
 };
 
 static void atkbd_report_key(struct input_dev *dev, struct pt_regs *regs, int code, int value)
@@ -224,7 +238,7 @@
 
 #if !defined(__i386__) && !defined (__x86_64__)
 	if ((flags & (SERIO_FRAME | SERIO_PARITY)) && (~flags & SERIO_TIMEOUT) && !atkbd->resend && atkbd->write) {
-		printk("atkbd.c: frame/parity error: %02x\n", flags);
+		printk(KERN_WARNING "atkbd.c: frame/parity error: %02x\n", flags);
 		serio_write(serio, ATKBD_CMD_RESEND);
 		atkbd->resend = 1;
 		goto out;
@@ -234,22 +248,36 @@
 		atkbd->resend = 0;
 #endif
 
-	if (!atkbd->ack)
+	if (test_bit(ATKBD_FLAG_ACK, &atkbd->flags))
 		switch (code) {
 			case ATKBD_RET_ACK:
-				atkbd->ack = 1;
+				atkbd->nak = 0;
+				clear_bit(ATKBD_FLAG_ACK, &atkbd->flags);
 				goto out;
 			case ATKBD_RET_NAK:
-				atkbd->ack = -1;
+				atkbd->nak = 1;
+				clear_bit(ATKBD_FLAG_ACK, &atkbd->flags);
 				goto out;
 		}
 
-	if (atkbd->cmdcnt) {
-		atkbd->cmdbuf[--atkbd->cmdcnt] = code;
+	if (test_bit(ATKBD_FLAG_CMD, &atkbd->flags)) {
+
+		atkbd->cmdcnt--;
+		atkbd->cmdbuf[atkbd->cmdcnt] = code;
+
+		if (atkbd->cmdcnt == 1) {
+		    	if (code != 0xab && code != 0xac)
+				clear_bit(ATKBD_FLAG_ID, &atkbd->flags);
+			clear_bit(ATKBD_FLAG_CMD1, &atkbd->flags);
+		}
+
+		if (!atkbd->cmdcnt)
+			clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
+
 		goto out;
 	}
 
-	if (!atkbd->enabled)
+	if (!test_bit(ATKBD_FLAG_ENABLED, &atkbd->flags))
 		goto out;
 
 	if (atkbd->translated) {
@@ -270,6 +298,7 @@
 
 	switch (code) {
 		case ATKBD_RET_BAT:
+			clear_bit(ATKBD_FLAG_ENABLED, &atkbd->flags);
 			serio_rescan(atkbd->serio);
 			goto out;
 		case ATKBD_RET_EMUL0:
@@ -376,18 +405,19 @@
 
 static int atkbd_sendbyte(struct atkbd *atkbd, unsigned char byte)
 {
-	int timeout = 20000; /* 200 msec */
-	atkbd->ack = 0;
+	int timeout = 200000; /* 200 msec */
 
 #ifdef ATKBD_DEBUG
 	printk(KERN_DEBUG "atkbd.c: Sent: %02x\n", byte);
 #endif
+
+	set_bit(ATKBD_FLAG_ACK, &atkbd->flags);
 	if (serio_write(atkbd->serio, byte))
 		return -1;
+	while (test_bit(ATKBD_FLAG_ACK, &atkbd->flags) && timeout--) udelay(1);
+	clear_bit(ATKBD_FLAG_ACK, &atkbd->flags);
 
-	while (!atkbd->ack && timeout--) udelay(10);
-
-	return -(atkbd->ack <= 0);
+	return -atkbd->nak;
 }
 
 /*
@@ -411,40 +441,52 @@
 		for (i = 0; i < receive; i++)
 			atkbd->cmdbuf[(receive - 1) - i] = param[i];
 
+	if (receive) {
+		set_bit(ATKBD_FLAG_CMD, &atkbd->flags);
+		set_bit(ATKBD_FLAG_CMD1, &atkbd->flags);
+		set_bit(ATKBD_FLAG_ID, &atkbd->flags);
+	}
+
 	if (command & 0xff)
-		if (atkbd_sendbyte(atkbd, command & 0xff))
-			return (atkbd->cmdcnt = 0) - 1;
+		if (atkbd_sendbyte(atkbd, command & 0xff)) {
+			clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
+			return -1;
+		}
 
 	for (i = 0; i < send; i++)
-		if (atkbd_sendbyte(atkbd, param[i]))
-			return (atkbd->cmdcnt = 0) - 1;
+		if (atkbd_sendbyte(atkbd, param[i])) {
+			clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
+			return -1;
+		}
 
-	while (atkbd->cmdcnt && timeout--) {
+	while (test_bit(ATKBD_FLAG_CMD, &atkbd->flags) && timeout--) {
 
-		if (atkbd->cmdcnt == 1 &&
-		    command == ATKBD_CMD_RESET_BAT && timeout > 100000)
-			timeout = 100000;
-
-		if (atkbd->cmdcnt == 1 && command == ATKBD_CMD_GETID &&
-		    atkbd->cmdbuf[1] != 0xab && atkbd->cmdbuf[1] != 0xac) {
-			atkbd->cmdcnt = 0;
-			break;
+		if (!test_bit(ATKBD_FLAG_CMD1, &atkbd->flags)) {
+		    
+			if (command == ATKBD_CMD_RESET_BAT && timeout > 100000)
+				timeout = 100000;
+
+			if (command == ATKBD_CMD_GETID && !test_bit(ATKBD_FLAG_ID, &atkbd->flags)) {
+				clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
+				atkbd->cmdcnt = 0;
+				break;
+			}
 		}
 
 		udelay(1);
 	}
 
+	clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
+
 	if (param)
 		for (i = 0; i < receive; i++)
 			param[i] = atkbd->cmdbuf[(receive - 1) - i];
 
 	if (command == ATKBD_CMD_RESET_BAT && atkbd->cmdcnt == 1)
-		atkbd->cmdcnt = 0;
+		return 0;
 
-	if (atkbd->cmdcnt) {
-		atkbd->cmdcnt = 0;
+	if (atkbd->cmdcnt)
 		return -1;
-	}
 
 	return 0;
 }
@@ -672,6 +714,7 @@
 static void atkbd_disconnect(struct serio *serio)
 {
 	struct atkbd *atkbd = serio->private;
+	clear_bit(ATKBD_FLAG_ENABLED, &atkbd->flags);
 	input_unregister_device(&atkbd->dev);
 	serio_close(serio);
 	kfree(atkbd);
@@ -719,7 +762,6 @@
 		atkbd->dev.rep[REP_PERIOD] = 33;
 	}
 
-	atkbd->ack = 1;
 	atkbd->serio = serio;
 
 	init_input_dev(&atkbd->dev);
@@ -754,7 +796,6 @@
 		atkbd->id = 0xab00;
 	}
 
-	atkbd->enabled = 1;
 
 	if (atkbd->extra) {
 		atkbd->dev.ledbit[0] |= BIT(LED_COMPOSE) | BIT(LED_SUSPEND) | BIT(LED_SLEEP) | BIT(LED_MUTE) | BIT(LED_MISC);
@@ -797,6 +838,8 @@
 
 	input_register_device(&atkbd->dev);
 
+	set_bit(ATKBD_FLAG_ENABLED, &atkbd->flags);
+
 	printk(KERN_INFO "input: %s on %s\n", atkbd->name, serio->phys);
 }
 
@@ -831,6 +874,8 @@
 		if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
 			return -1;
 	}
+
+	set_bit(ATKBD_FLAG_ENABLED, &atkbd->flags);
 
 	return 0;
 }

