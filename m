Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbTBLKuh>; Wed, 12 Feb 2003 05:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267032AbTBLKuh>; Wed, 12 Feb 2003 05:50:37 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:905 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267030AbTBLKud>;
	Wed, 12 Feb 2003 05:50:33 -0500
Date: Wed, 12 Feb 2003 11:59:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: vojtech@suse.cz
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Update AT+PS/2 mouse and keyboard drivers [1/14]
Message-ID: <20030212115954.A1268@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm resending the last batch of changesets, cleaned up and merged from
37 into just 14. They all are re-applied to current 2.5.60 to avoid any
need of merges.


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1004, 2003-02-12 10:24:25+01:00, vojtech@suse.cz
  input: Update AT+PS/2 mouse and keyboard drivers:
  	- Fix a possible deadlock with 0xfe resend command (atkbd)
  	- Make ->ack variables volatile (they're updated from irq)
  	- Fix the GETID one/two byte command to avoid any races
  	- Fix Logitech PS2++ extended packet detection
  	- Use RESET_BAT on reboot to make notebooks happy


 keyboard/atkbd.c |   56 ++++++++++++++++++++++++++++++++-----------------------
 mouse/psmouse.c  |   36 ++++++++++++++++++++++-------------
 2 files changed, 56 insertions(+), 36 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Wed Feb 12 11:57:28 2003
+++ b/drivers/input/keyboard/atkbd.c	Wed Feb 12 11:57:28 2003
@@ -86,8 +86,7 @@
 #define ATKBD_CMD_SETLEDS	0x10ed
 #define ATKBD_CMD_GSCANSET	0x11f0
 #define ATKBD_CMD_SSCANSET	0x10f0
-#define ATKBD_CMD_GETID		0x01f2
-#define ATKBD_CMD_GETID2	0x0100
+#define ATKBD_CMD_GETID		0x02f2
 #define ATKBD_CMD_ENABLE	0x00f4
 #define ATKBD_CMD_RESET_DIS	0x00f5
 #define ATKBD_CMD_RESET_BAT	0x01ff
@@ -120,12 +119,12 @@
 	unsigned char cmdbuf[4];
 	unsigned char cmdcnt;
 	unsigned char set;
-	unsigned char oldset;
 	unsigned char release;
-	signed char ack;
+	volatile signed char ack;
 	unsigned char emul;
 	unsigned short id;
 	unsigned char write;
+	unsigned char resend;
 };
 
 /*
@@ -142,11 +141,15 @@
 	printk(KERN_DEBUG "atkbd.c: Received %02x flags %02x\n", data, flags);
 #endif
 
-	if ((flags & (SERIO_FRAME | SERIO_PARITY)) && (~flags & SERIO_TIMEOUT) && atkbd->write) {
+	if ((flags & (SERIO_FRAME | SERIO_PARITY)) && (~flags & SERIO_TIMEOUT) && !atkbd->resend && atkbd->write) {
 		printk("atkbd.c: frame/parity error: %02x\n", flags);
 		serio_write(serio, ATKBD_CMD_RESEND);
+		atkbd->resend = 1;
 		return;
 	}
+	
+	if (!flags)
+		atkbd->resend = 0;
 
 	switch (code) {
 		case ATKBD_RET_ACK:
@@ -227,12 +230,15 @@
 
 static int atkbd_command(struct atkbd *atkbd, unsigned char *param, int command)
 {
-	int timeout = 50000; /* 500 msec */
+	int timeout = 500000; /* 500 msec */
 	int send = (command >> 12) & 0xf;
 	int receive = (command >> 8) & 0xf;
 	int i;
 
 	atkbd->cmdcnt = receive;
+
+	if (command == ATKBD_CMD_RESET_BAT)
+		timeout = 2000000; /* 2 sec */
 	
 	if (command & 0xff)
 		if (atkbd_sendbyte(atkbd, command & 0xff))
@@ -242,14 +248,28 @@
 		if (atkbd_sendbyte(atkbd, param[i]))
 			return (atkbd->cmdcnt = 0) - 1;
 
-	while (atkbd->cmdcnt && timeout--) udelay(10);
+	while (atkbd->cmdcnt && timeout--) {
+
+		if (atkbd->cmdcnt == 1 && command == ATKBD_CMD_RESET_BAT)
+			timeout = 100000;
+
+		if (atkbd->cmdcnt == 1 && command == ATKBD_CMD_GETID &&
+		    atkbd->cmdbuf[1] != 0xab && atkbd->cmdbuf[1] != 0xac) {
+			atkbd->cmdcnt = 0;
+			break;
+		}
+	
+		udelay(1);
+	}
 
 	if (param)
 		for (i = 0; i < receive; i++)
 			param[i] = atkbd->cmdbuf[(receive - 1) - i];
 
-	if (atkbd->cmdcnt) 
-		return (atkbd->cmdcnt = 0) - 1;
+	if (atkbd->cmdcnt) {
+		atkbd->cmdcnt = 0;
+		return -1;
+	}
 
 	return 0;
 }
@@ -303,13 +323,6 @@
 	unsigned char param[2];
 
 /*
- * Remember original scancode set value, so that we can restore it on exit.
- */
-
-	if (atkbd_command(atkbd, &atkbd->oldset, ATKBD_CMD_GSCANSET))
-		atkbd->oldset = 2;
-
-/*
  * For known special keyboards we can go ahead and set the correct set.
  * We check for NCD PS/2 Sun, NorthGate OmniKey 101 and
  * IBM RapidAccess / IBM EzButton / Chicony KBP-8993 keyboards.
@@ -376,8 +389,8 @@
  */
 
 	if (atkbd_reset)
-		if (atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT))
-			printk(KERN_WARNING "atkbd.c: keyboard reset failed\n");
+		if (atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT)) 
+			printk(KERN_WARNING "atkbd.c: keyboard reset failed on %s\n", atkbd->serio->phys);
 
 /*
  * Then we check the keyboard ID. We should get 0xab83 under normal conditions.
@@ -401,10 +414,7 @@
 
 	if (param[0] != 0xab && param[0] != 0xac)
 		return -1;
-	atkbd->id = param[0] << 8;
-	if (atkbd_command(atkbd, param, ATKBD_CMD_GETID2))
-		return -1;
-	atkbd->id |= param[0];
+	atkbd->id = (param[0] << 8) | param[1];
 
 /*
  * Set the LEDs to a defined state.
@@ -442,7 +452,7 @@
 static void atkbd_cleanup(struct serio *serio)
 {
 	struct atkbd *atkbd = serio->private;
-	atkbd_command(atkbd, &atkbd->oldset, ATKBD_CMD_SSCANSET);
+	atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT);
 }
 
 /*
diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Wed Feb 12 11:57:28 2003
+++ b/drivers/input/mouse/psmouse.c	Wed Feb 12 11:57:28 2003
@@ -30,8 +30,7 @@
 #define PSMOUSE_CMD_GETINFO	0x03e9
 #define PSMOUSE_CMD_SETSTREAM	0x00ea
 #define PSMOUSE_CMD_POLL	0x03eb	
-#define PSMOUSE_CMD_GETID	0x01f2
-#define PSMOUSE_CMD_GETID2	0x0100
+#define PSMOUSE_CMD_GETID	0x02f2
 #define PSMOUSE_CMD_SETRATE	0x10f3
 #define PSMOUSE_CMD_ENABLE	0x00f4
 #define PSMOUSE_CMD_RESET_DIS	0x00f6
@@ -54,7 +53,7 @@
 	unsigned char model;
 	unsigned long last;
 	char acking;
-	char ack;
+	volatile char ack;
 	char error;
 	char devname[64];
 	char phys[32];
@@ -85,9 +84,9 @@
 
 	if (psmouse->type == PSMOUSE_PS2PP || psmouse->type == PSMOUSE_PS2TPP) {
 
-		if ((packet[0] & 0x40) == 0x40 && (int) packet[1] - (int) ((packet[0] & 0x10) << 4) > 191 ) {
+		if ((packet[0] & 0x40) == 0x40 && abs((int)packet[1] - (((int)packet[0] & 0x10) << 4)) > 191 ) {
 
-			switch (((packet[1] >> 4) & 0x03) | ((packet[0] >> 2) & 0xc0)) {
+			switch (((packet[1] >> 4) & 0x03) | ((packet[0] >> 2) & 0x0c)) {
 
 			case 1: /* Mouse extra info */
 
@@ -106,10 +105,11 @@
 
 				break;
 
+#ifdef DEBUG
 			default:
-
 				printk(KERN_WARNING "psmouse.c: Received PS2++ packet #%x, but don't know how to handle.\n",
-					((packet[1] >> 4) & 0x03) | ((packet[0] >> 2) & 0xc0));
+					((packet[1] >> 4) & 0x03) | ((packet[0] >> 2) & 0x0c));
+#endif
 
 			}
 
@@ -248,6 +248,9 @@
 
 	psmouse->cmdcnt = receive;
 
+	if (command == PSMOUSE_CMD_RESET_BAT)
+                timeout = 2000000; /* 2 sec */
+
 	if (command & 0xff)
 		if (psmouse_sendbyte(psmouse, command & 0xff))
 			return (psmouse->cmdcnt = 0) - 1;
@@ -256,7 +259,19 @@
 		if (psmouse_sendbyte(psmouse, param[i]))
 			return (psmouse->cmdcnt = 0) - 1;
 
-	while (psmouse->cmdcnt && timeout--) udelay(1);
+	while (psmouse->cmdcnt && timeout--) {
+	
+		if (psmouse->cmdcnt == 1 && command == PSMOUSE_CMD_RESET_BAT)
+			timeout = 100000;
+
+		if (psmouse->cmdcnt == 1 && command == PSMOUSE_CMD_GETID &&
+		    psmouse->cmdbuf[1] != 0xab && psmouse->cmdbuf[1] != 0xac) {
+			psmouse->cmdcnt = 0;
+			break;
+		}
+
+		udelay(1);
+	}
 
 	for (i = 0; i < receive; i++)
 		param[i] = psmouse->cmdbuf[(receive - 1) - i];
@@ -497,11 +512,6 @@
 
 	if (psmouse_command(psmouse, param, PSMOUSE_CMD_GETID))
 		return -1;
-
-	if (param[0] == 0xab || param[0] == 0xac) {
-		psmouse_command(psmouse, param, PSMOUSE_CMD_GETID2);
-		return -1;
-	}
 
 	if (param[0] != 0x00 && param[0] != 0x03 && param[0] != 0x04)
 		return -1;
