Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264526AbUFGL6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbUFGL6e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 07:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUFGLz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 07:55:59 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:63872 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264432AbUFGLzZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:55:25 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <1086609353132@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093532158@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:53 +0200
Subject: [PATCH 7/39] input: Soften ACK warning in atkbd
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.753.14, 2004-04-23 02:37:43-05:00, dtor_core@ameritech.net
  Input: Change spurious ACK warning in atkbd to soften accusation
         against XFree86


 atkbd.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2004-06-07 13:13:15 +02:00
+++ b/drivers/input/keyboard/atkbd.c	2004-06-07 13:13:15 +02:00
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

