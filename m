Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbUCMBRe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 20:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbUCMBRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 20:17:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24705 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262917AbUCMBRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 20:17:31 -0500
Date: Fri, 12 Mar 2004 20:17:26 -0500 (EST)
From: Matthew Galgoci <mgalgoci@redhat.com>
X-X-Sender: mgalgoci@lacrosse.corp.redhat.com
To: akpm@osdl.org, <tytso@mit.edu>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH - take 3] atkbd shaddup
In-Reply-To: <20040312183738.GA3233@thunk.org>
Message-ID: <Pine.LNX.4.44.0403122015400.2910-100000@lacrosse.corp.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Andrew,
> > 
> > I can't be the only person to be annoyed by the "too many keys
> > pressed" error message that often gets spewed across the console
> > when I am typing fast. This patch turns that error message (and
> > others) into info message. Also, one debug message was turned into
> > info, and a couple of warnings were turned into info where I thought
> > it made sense.
> 
> I'd go even further.  Do we need to print the "too many keys pressed"
> message at *all*?  Why would anyone care?

atkbd shaddup - Take 3 - I suck again.

--- linux-2.6.4/drivers/input/keyboard/atkbd.c.orig	2004-03-12 20:13:30.000000000 -0500
+++ linux-2.6.4/drivers/input/keyboard/atkbd.c	2004-03-12 20:13:49.000000000 -0500
@@ -257,9 +257,11 @@
 		case ATKBD_RET_HANJA:
 			atkbd_report_key(&atkbd->dev, regs, KEY_HANJA, 3);
 			goto out;
+#ifdef ATKBD_DEBUG
 		case ATKBD_RET_ERR:
-			printk(KERN_WARNING "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
+			printk(KERN_DEBUG "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
 			goto out;
+#endif /* ATKBD_DEBUG */
 	}
 
 	if (atkbd->set != 3)
@@ -274,15 +276,15 @@
 		case ATKBD_KEY_NULL:
 			break;
 		case ATKBD_KEY_UNKNOWN:
-			printk(KERN_WARNING "atkbd.c: Unknown key %s (%s set %d, code %#x on %s).\n",
+			printk(KERN_INFO "atkbd.c: Unknown key %s (%s set %d, code %#x on %s).\n",
 				atkbd->release ? "released" : "pressed",
 				atkbd->translated ? "translated" : "raw", 
 				atkbd->set, code, serio->phys);
 			if (atkbd->translated && atkbd->set == 2 && code == 0x7a)
-				printk(KERN_WARNING "atkbd.c: This is an XFree86 bug. It shouldn't access"
+				printk(KERN_INFO "atkbd.c: This is an XFree86 bug. It shouldn't access"
 					" hardware directly.\n");
 			else
-				printk(KERN_WARNING "atkbd.c: Use 'setkeycodes %s%02x <keycode>' to make it known.\n",						code & 0x80 ? "e0" : "", code & 0x7f);
+				printk(KERN_INFO "atkbd.c: Use 'setkeycodes %s%02x <keycode>' to make it known.\n",						code & 0x80 ? "e0" : "", code & 0x7f);
 			break;
 		default:
 			value = atkbd->release ? 0 :
@@ -496,8 +498,8 @@
 	atkbd->id = (param[0] << 8) | param[1];
 
 	if (atkbd->id == 0xaca1 && atkbd->translated) {
-		printk(KERN_ERR "atkbd.c: NCD terminal keyboards are only supported on non-translating\n");
-		printk(KERN_ERR "atkbd.c: controllers. Use i8042.direct=1 to disable translation.\n");
+		printk(KERN_INFO "atkbd.c: NCD terminal keyboards are only supported on non-translating\n");
+		printk(KERN_INFO "atkbd.c: controllers. Use i8042.direct=1 to disable translation.\n");
 		return -1;
 	}
 
@@ -588,7 +590,7 @@
  */
 
 	if (atkbd_command(atkbd, NULL, ATKBD_CMD_ENABLE)) {
-		printk(KERN_ERR "atkbd.c: Failed to enable keyboard on %s\n",
+		printk(KERN_WARNING "atkbd.c: Failed to enable keyboard on %s\n",
 			atkbd->serio->phys);
 		return -1;
 	}
@@ -744,7 +746,7 @@
 	int i;
 
         if (!dev) {
-                printk(KERN_DEBUG "atkbd: reconnect request, but serio is disconnected, ignoring...\n");
+                printk(KERN_INFO "atkbd.c: reconnect request, but serio is disconnected, ignoring...\n");
                 return -1;
         }
 

