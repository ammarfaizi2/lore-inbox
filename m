Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265879AbUGHHCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUGHHCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 03:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbUGHHBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 03:01:36 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:52354 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265833AbUGHG7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 02:59:19 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 6/8] New set of input patches
Date: Thu, 8 Jul 2004 01:58:04 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200407080155.07827.dtor_core@ameritech.net> <200407080157.17205.dtor_core@ameritech.net> <200407080157.38459.dtor_core@ameritech.net>
In-Reply-To: <200407080157.38459.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407080158.05735.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1825, 2004-07-08 00:26:24-05:00, dtor_core@ameritech.net
  Input: do not call protocol handler in psmouse unless mouse is
         filly initialized - helps when USB Legacy emulation gets
         in our way and starts generating junk data stream while
         psmouse is detecting hardware
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 psmouse-base.c |   13 ++++++++++---
 psmouse.h      |   14 ++++++++------
 2 files changed, 18 insertions(+), 9 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-07-08 01:35:32 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-07-08 01:35:32 -05:00
@@ -186,6 +186,9 @@
 		goto out;
 	}
 
+	if (psmouse->state == PSMOUSE_INITIALIZING)
+		goto out;
+
 	if (psmouse->state == PSMOUSE_ACTIVATED &&
 	    psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/2)) {
 		printk(KERN_WARNING "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n",
@@ -631,7 +634,7 @@
  * is not a concern.
  */
 
-static void psmouse_set_state(struct psmouse *psmouse, unsigned char new_state)
+static void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state)
 {
 	serio_pause_rx(psmouse->serio);
 	psmouse->state = new_state;
@@ -716,7 +719,7 @@
 	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
 	psmouse->serio = serio;
 	psmouse->dev.private = psmouse;
-	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
+	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
 
 	serio->private = psmouse;
 	if (serio_open(serio, drv)) {
@@ -756,6 +759,8 @@
 
 	printk(KERN_INFO "input: %s on %s\n", psmouse->devname, serio->phys);
 
+	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
+
 	psmouse_initialize(psmouse);
 
 	if (parent && parent->pt_activate)
@@ -795,7 +800,7 @@
 		return -1;
 	}
 
-	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
+	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
 
 	if (psmouse->reconnect) {
 	       if (psmouse->reconnect(psmouse))
@@ -807,6 +812,8 @@
 	/* ok, the device type (and capabilities) match the old one,
 	 * we can continue using it, complete intialization
 	 */
+	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
+
 	psmouse_initialize(psmouse);
 
 	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU)
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	2004-07-08 01:35:32 -05:00
+++ b/drivers/input/mouse/psmouse.h	2004-07-08 01:35:32 -05:00
@@ -17,16 +17,18 @@
 #define PSMOUSE_RET_ACK		0xfa
 #define PSMOUSE_RET_NAK		0xfe
 
-/* psmouse states */
-#define PSMOUSE_CMD_MODE	0
-#define PSMOUSE_ACTIVATED	1
-#define PSMOUSE_IGNORE		2
-
 #define PSMOUSE_FLAG_ACK	0	/* Waiting for ACK/NAK */
 #define PSMOUSE_FLAG_CMD	1	/* Waiting for command to finish */
 #define PSMOUSE_FLAG_CMD1	2	/* First byte of command response */
 #define PSMOUSE_FLAG_ID		3	/* First byte is not keyboard ID */
 
+enum psmouse_state {
+	PSMOUSE_IGNORE,
+	PSMOUSE_INITIALIZING,
+	PSMOUSE_CMD_MODE,
+	PSMOUSE_ACTIVATED,
+};
+
 /* psmouse protocol handler return codes */
 typedef enum {
 	PSMOUSE_BAD_DATA,
@@ -48,7 +50,7 @@
 	unsigned char model;
 	unsigned long last;
 	unsigned long out_of_sync;
-	unsigned char state;
+	enum psmouse_state state;
 	unsigned char nak;
 	char error;
 	char devname[64];
