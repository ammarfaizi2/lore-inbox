Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264782AbUG2PAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbUG2PAE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267856AbUG2PAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:00:03 -0400
Received: from styx.suse.cz ([82.119.242.94]:8598 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264782AbUG2OIJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:09 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 6/47] Explicit variable access rules for psmouse.c
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:54 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101942431@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101943135@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.63.1, 2004-05-31 15:11:41+02:00, vojtech@suse.cz
  input: Explicit variable access rules for psmouse.c, using bitops.


 keyboard/atkbd.c     |    2 
 mouse/psmouse-base.c |  129 +++++++++++++++++++++++++++++++--------------------
 mouse/psmouse.h      |    9 ++-
 3 files changed, 87 insertions(+), 53 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Thu Jul 29 14:42:04 2004
+++ b/drivers/input/keyboard/atkbd.c	Thu Jul 29 14:42:04 2004
@@ -435,7 +435,7 @@
 	atkbd->cmdcnt = receive;
 
 	if (command == ATKBD_CMD_RESET_BAT)
-		timeout = 2000000; /* 2 sec */
+		timeout = 4000000; /* 4 sec */
 
 	if (receive && param)
 		for (i = 0; i < receive; i++)
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Thu Jul 29 14:42:04 2004
+++ b/drivers/input/mouse/psmouse-base.c	Thu Jul 29 14:42:04 2004
@@ -142,34 +142,45 @@
 			printk(KERN_WARNING "psmouse.c: bad data from KBC -%s%s\n",
 				flags & SERIO_TIMEOUT ? " timeout" : "",
 				flags & SERIO_PARITY ? " bad parity" : "");
-		if (psmouse->acking) {
-			psmouse->ack = -1;
-			psmouse->acking = 0;
-		}
-		psmouse->pktcnt = 0;
+		psmouse->nak = 1;
+		clear_bit(PSMOUSE_FLAG_ACK, &psmouse->flags);
+		clear_bit(PSMOUSE_FLAG_CMD,  &psmouse->flags);
 		goto out;
 	}
 
-	if (psmouse->acking) {
+	if (test_bit(PSMOUSE_FLAG_ACK, &psmouse->flags))
 		switch (data) {
 			case PSMOUSE_RET_ACK:
-				psmouse->ack = 1;
+				psmouse->nak = 0;
+				clear_bit(PSMOUSE_FLAG_ACK, &psmouse->flags);
+				goto out;
 				break;
 			case PSMOUSE_RET_NAK:
-				psmouse->ack = -1;
-				break;
+				psmouse->nak = 1;
+				clear_bit(PSMOUSE_FLAG_ACK, &psmouse->flags);
+				goto out;
 			default:
-				psmouse->ack = 1;	/* Workaround for mice which don't ACK the Get ID command */
-				if (psmouse->cmdcnt)
-					psmouse->cmdbuf[--psmouse->cmdcnt] = data;
-				break;
+				psmouse->nak = 0;	/* Workaround for mice which don't ACK the Get ID command */
+				clear_bit(PSMOUSE_FLAG_ACK, &psmouse->flags);
+				if (!test_bit(PSMOUSE_FLAG_CMD, &psmouse->flags))
+					goto out;
+
 		}
-		psmouse->acking = 0;
-		goto out;
-	}
 
-	if (psmouse->cmdcnt) {
-		psmouse->cmdbuf[--psmouse->cmdcnt] = data;
+	if (test_bit(PSMOUSE_FLAG_CMD, &psmouse->flags)) {
+
+		psmouse->cmdcnt--;
+		psmouse->cmdbuf[psmouse->cmdcnt] = data;
+
+		if (psmouse->cmdcnt == 1) {
+			if (data != 0xab && data != 0xac)
+				clear_bit(PSMOUSE_FLAG_ID, &psmouse->flags);
+			clear_bit(PSMOUSE_FLAG_CMD1, &psmouse->flags);
+		}
+
+		if (!psmouse->cmdcnt)
+			clear_bit(PSMOUSE_FLAG_CMD, &psmouse->flags);
+
 		goto out;
 	}
 
@@ -242,18 +253,15 @@
 
 static int psmouse_sendbyte(struct psmouse *psmouse, unsigned char byte)
 {
-	int timeout = 10000; /* 100 msec */
-	psmouse->ack = 0;
-	psmouse->acking = 1;
+	int timeout = 200000; /* 200 msec */
 
-	if (serio_write(psmouse->serio, byte)) {
-		psmouse->acking = 0;
+	set_bit(PSMOUSE_FLAG_ACK, &psmouse->flags);
+	if (serio_write(psmouse->serio, byte))
 		return -1;
-	}
-
-	while (!psmouse->ack && timeout--) udelay(10);
+	while (test_bit(PSMOUSE_FLAG_ACK, &psmouse->flags) && timeout--) udelay(1);
+	clear_bit(PSMOUSE_FLAG_ACK, &psmouse->flags);
 
-	return -(psmouse->ack <= 0);
+	return -psmouse->nak;
 }
 
 /*
@@ -271,46 +279,62 @@
 	psmouse->cmdcnt = receive;
 
 	if (command == PSMOUSE_CMD_RESET_BAT)
-                timeout = 4000000; /* 4 sec */
+		timeout = 4000000; /* 4 sec */
 
-	/* initialize cmdbuf with preset values from param */
-	if (receive)
-	   for (i = 0; i < receive; i++)
-		psmouse->cmdbuf[(receive - 1) - i] = param[i];
+	if (receive && param)
+		for (i = 0; i < receive; i++)
+			psmouse->cmdbuf[(receive - 1) - i] = param[i];
+
+	if (receive) {
+		set_bit(PSMOUSE_FLAG_CMD, &psmouse->flags);
+		set_bit(PSMOUSE_FLAG_CMD1, &psmouse->flags);
+		set_bit(PSMOUSE_FLAG_ID, &psmouse->flags);
+	}
 
 	if (command & 0xff)
-		if (psmouse_sendbyte(psmouse, command & 0xff))
-			return (psmouse->cmdcnt = 0) - 1;
+		if (psmouse_sendbyte(psmouse, command & 0xff)) {
+			clear_bit(PSMOUSE_FLAG_CMD, &psmouse->flags);
+			return -1;
+		}
 
 	for (i = 0; i < send; i++)
-		if (psmouse_sendbyte(psmouse, param[i]))
-			return (psmouse->cmdcnt = 0) - 1;
+		if (psmouse_sendbyte(psmouse, param[i])) {
+			clear_bit(PSMOUSE_FLAG_CMD, &psmouse->flags);
+			return -1;
+		}
 
-	while (psmouse->cmdcnt && timeout--) {
+	while (test_bit(PSMOUSE_FLAG_CMD, &psmouse->flags) && timeout--) {
 
-		if (psmouse->cmdcnt == 1 && command == PSMOUSE_CMD_RESET_BAT &&
-				timeout > 100000) /* do not run in a endless loop */
-			timeout = 100000; /* 1 sec */
-
-		if (psmouse->cmdcnt == 1 && command == PSMOUSE_CMD_GETID &&
-		    psmouse->cmdbuf[1] != 0xab && psmouse->cmdbuf[1] != 0xac) {
-			psmouse->cmdcnt = 0;
-			break;
+		if (!test_bit(PSMOUSE_FLAG_CMD1, &psmouse->flags)) {
+		    
+			if (command == PSMOUSE_CMD_RESET_BAT && timeout > 100000)
+				timeout = 100000;
+
+			if (command == PSMOUSE_CMD_GETID && !test_bit(PSMOUSE_FLAG_ID, &psmouse->flags)) {
+				clear_bit(PSMOUSE_FLAG_CMD, &psmouse->flags);
+				psmouse->cmdcnt = 0;
+				break;
+			}
 		}
 
 		udelay(1);
 	}
 
-	for (i = 0; i < receive; i++)
-		param[i] = psmouse->cmdbuf[(receive - 1) - i];
+	clear_bit(PSMOUSE_FLAG_CMD, &psmouse->flags);
+
+	if (param)
+		for (i = 0; i < receive; i++)
+			param[i] = psmouse->cmdbuf[(receive - 1) - i];
+
+	if (command == PSMOUSE_CMD_RESET_BAT && psmouse->cmdcnt == 1)
+		return 0;
 
 	if (psmouse->cmdcnt)
-		return (psmouse->cmdcnt = 0) - 1;
+		return -1;
 
 	return 0;
 }
 
-
 /*
  * psmouse_sliced_command() sends an extended PS/2 command to the mouse
  * using sliced syntax, understood by advanced devices, such as Logitech
@@ -735,7 +759,12 @@
 	}
 
 	psmouse->state = PSMOUSE_CMD_MODE;
-	psmouse->acking = psmouse->cmdcnt = psmouse->pktcnt = psmouse->out_of_sync = 0;
+
+	clear_bit(PSMOUSE_FLAG_ACK, &psmouse->flags);
+	clear_bit(PSMOUSE_FLAG_CMD,  &psmouse->flags);
+
+	psmouse->pktcnt = psmouse->out_of_sync = 0;
+
 	if (psmouse->reconnect) {
 	       if (psmouse->reconnect(psmouse))
 			return -1;
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	Thu Jul 29 14:42:04 2004
+++ b/drivers/input/mouse/psmouse.h	Thu Jul 29 14:42:04 2004
@@ -22,6 +22,11 @@
 #define PSMOUSE_ACTIVATED	1
 #define PSMOUSE_IGNORE		2
 
+#define PSMOUSE_FLAG_ACK	0	/* Waiting for ACK/NAK */
+#define PSMOUSE_FLAG_CMD	1	/* Waiting for command to finish */
+#define PSMOUSE_FLAG_CMD1	2	/* First byte of command response */
+#define PSMOUSE_FLAG_ID		3	/* First byte is not keyboard ID */
+
 /* psmouse protocol handler return codes */
 typedef enum {
 	PSMOUSE_BAD_DATA,
@@ -54,11 +59,11 @@
 	unsigned long last;
 	unsigned long out_of_sync;
 	unsigned char state;
-	char acking;
-	volatile char ack;
+	unsigned char nak;
 	char error;
 	char devname[64];
 	char phys[32];
+	unsigned long flags;
 
 	psmouse_ret_t (*protocol_handler)(struct psmouse *psmouse, struct pt_regs *regs); 
 	int (*reconnect)(struct psmouse *psmouse);

