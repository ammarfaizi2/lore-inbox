Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264985AbUDUGVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264985AbUDUGVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUDUGIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:08:10 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:37548 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264986AbUDUGFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:05:44 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 6/15] New set of input patches: atkbd soften accusation
Date: Wed, 21 Apr 2004 00:54:21 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net>
In-Reply-To: <200404210049.17139.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210054.23583.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1907, 2004-04-20 22:27:51-05:00, dtor_core@ameritech.net
  Input: Change spurious ACK warning in atkbd to soften accusation
         against XFree86


 atkbd.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)


===================================================================



diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Apr 20 23:04:41 2004
+++ b/drivers/input/keyboard/atkbd.c	Tue Apr 20 23:04:41 2004
@@ -300,15 +300,20 @@
 		case ATKBD_KEY_NULL:
 			break;
 		case ATKBD_KEY_UNKNOWN:
-			printk(KERN_WARNING "atkbd.c: Unknown key %s (%s set %d, code %#x on %s).\n",
-				atkbd->release ? "released" : "pressed",
-				atkbd->translated ? "translated" : "raw",
-				atkbd->set, code, serio->phys);
-			if (atkbd->translated && atkbd->set == 2 && code == 0x7a)
-				printk(KERN_WARNING "atkbd.c: This is an XFree86 bug. It shouldn't access"
-					" hardware directly.\n");
-			else
-				printk(KERN_WARNING "atkbd.c: Use 'setkeycodes %s%02x <keycode>' to make it known.\n",						code & 0x80 ? "e0" : "", code & 0x7f);
+			if (data == ATKBD_RET_ACK || data == ATKBD_RET_NAK) {
+				printk(KERN_WARNING "atkbd.c: Spurious %s on %s. Some program, "
+				       "like XFree86, might be trying access hardware directly.\n",
+				       data == ATKBD_RET_ACK ? "ACK" : "NAK", serio->phys);
+			} else {
+				printk(KERN_WARNING "atkbd.c: Unknown key %s "
+				       "(%s set %d, code %#x on %s).\n",
+				       atkbd->release ? "released" : "pressed",
+				       atkbd->translated ? "translated" : "raw",
+				       atkbd->set, code, serio->phys);
+				printk(KERN_WARNING "atkbd.c: Use 'setkeycodes %s%02x <keycode>' "
+				       "to make it known.\n",
+				       code & 0x80 ? "e0" : "", code & 0x7f);
+			}
 			break;
 		case ATKBD_SCR_1:
 			scroll = 1 - atkbd->release * 2;
