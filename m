Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265043AbUFRIo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265043AbUFRIo4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 04:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265052AbUFRIoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 04:44:55 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:33621 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265043AbUFRIow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 04:44:52 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/11] psmouse resync for KVM users
Date: Fri, 18 Jun 2004 03:37:15 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       vojtech@ucw.cz
References: <200406180335.52843.dtor_core@ameritech.net>
In-Reply-To: <200406180335.52843.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406180337.17457.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1790, 2004-06-16 18:13:33-05:00, dtor_core@ameritech.net
  Input: psmouse sync. changes
         - when a partial packet is received (more than HZ/2 jiffies
           has passed since last byte was received) increment
           out-of-sync counter. It should help users with KVMs that
           reset mice to bare PS/2 protocol but do not send 0xAA 0x00
           init sequence - after 'resetafter' bad packets psmouse
           will try reconnecting and reestablishing proper protcol.
         - change default value for 'resetafter' parameter from
           0 (never) to 20.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 psmouse-base.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-06-18 03:14:22 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-06-18 03:14:22 -05:00
@@ -43,7 +43,7 @@
 module_param_named(smartscroll, psmouse_smartscroll, bool, 0);
 MODULE_PARM_DESC(smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
 
-static unsigned int psmouse_resetafter;
+static unsigned int psmouse_resetafter = 20;
 module_param_named(resetafter, psmouse_resetafter, uint, 0);
 MODULE_PARM_DESC(resetafter, "Reset device after so many bad packets (0 = never).");
 
@@ -189,6 +189,7 @@
 		printk(KERN_WARNING "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n",
 		       psmouse->name, psmouse->phys, psmouse->pktcnt);
 		psmouse->pktcnt = 0;
+		psmouse->out_of_sync++;
 	}
 
 	psmouse->last = jiffies;
@@ -221,12 +222,7 @@
 			printk(KERN_WARNING "psmouse.c: %s at %s lost sync at byte %d\n",
 				psmouse->name, psmouse->phys, psmouse->pktcnt);
 			psmouse->pktcnt = 0;
-
-			if (++psmouse->out_of_sync == psmouse_resetafter) {
-				psmouse->state = PSMOUSE_IGNORE;
-				printk(KERN_NOTICE "psmouse.c: issuing reconnect request\n");
-				serio_reconnect(psmouse->serio);
-			}
+			psmouse->out_of_sync++;
 			break;
 
 		case PSMOUSE_FULL_PACKET:
@@ -241,6 +237,13 @@
 		case PSMOUSE_GOOD_DATA:
 			break;
 	}
+
+	if (psmouse->out_of_sync && psmouse->out_of_sync == psmouse_resetafter) {
+		psmouse->state = PSMOUSE_IGNORE;
+		printk(KERN_NOTICE "psmouse.c: issuing reconnect request\n");
+		serio_reconnect(psmouse->serio);
+	}
+
 out:
 	return IRQ_HANDLED;
 }
@@ -306,7 +309,7 @@
 	while (test_bit(PSMOUSE_FLAG_CMD, &psmouse->flags) && timeout--) {
 
 		if (!test_bit(PSMOUSE_FLAG_CMD1, &psmouse->flags)) {
-		    
+
 			if (command == PSMOUSE_CMD_RESET_BAT && timeout > 100000)
 				timeout = 100000;
 
