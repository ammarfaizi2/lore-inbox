Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266286AbSL2BGf>; Sat, 28 Dec 2002 20:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbSL2BGf>; Sat, 28 Dec 2002 20:06:35 -0500
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.224]:64737 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266286AbSL2BGa>; Sat, 28 Dec 2002 20:06:30 -0500
Date: Sat, 28 Dec 2002 20:07:18 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@linux-dev
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.53 : drivers/net/pcmcia/3c574_cs.c
Message-ID: <Pine.LNX.4.44.0212282004240.952-100000@linux-dev>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch swaps the save_flags/cli/restore_flags combo 
with a spinlock. Please review.
Regards,
Frank

--- linux/drivers/net/pcmcia/3c574_cs.c.old	Fri Nov 22 23:20:59 2002
+++ linux/drivers/net/pcmcia/3c574_cs.c	Sat Dec 28 19:53:10 2002
@@ -96,9 +96,12 @@
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/bitops.h>
+#include <linux/spinlock.h>
 
 /*====================================================================*/
 
+static spinlock_t 3c574_cs_lock = SPIN_LOCK_UNLOCKED;
+
 /* Module parameters */
 
 MODULE_AUTHOR("David Hinds <dahinds@users.sourceforge.net>");
@@ -1043,13 +1046,12 @@
 		return;
     }
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&3c574_cs_lock, flags);
 	EL3WINDOW(4);
 	media = mdio_read(ioaddr, lp->phys, 1);
 	partner = mdio_read(ioaddr, lp->phys, 5);
 	EL3WINDOW(1);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&3c574_cs_lock, flags);
 
 	if (media != lp->media_status) {
 		if ((media ^ lp->media_status) & 0x0004)
@@ -1232,31 +1234,29 @@
 	case SIOCDEVPRIVATE+1:		/* Read the specified MII register. */
 		{
 			int saved_window;
-                       unsigned long flags;
+                        unsigned long flags;
 
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&3c574_cs_lock, flags);
 			saved_window = inw(ioaddr + EL3_CMD) >> 13;
 			EL3WINDOW(4);
 			data[3] = mdio_read(ioaddr, data[0] & 0x1f, data[1] & 0x1f);
 			EL3WINDOW(saved_window);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&3c574_cs_lock,flags);
 			return 0;
 		}
 	case SIOCDEVPRIVATE+2:		/* Write the specified MII register */
 		{
 			int saved_window;
-                       unsigned long flags;
+                        unsigned long flags;
 
 			if (!capable(CAP_NET_ADMIN))
 				return -EPERM;
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&3c574_cs_lock, flags);
 			saved_window = inw(ioaddr + EL3_CMD) >> 13;
 			EL3WINDOW(4);
 			mdio_write(ioaddr, data[0] & 0x1f, data[1] & 0x1f, data[2]);
 			EL3WINDOW(saved_window);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&3c574_cs_lock, flags);
 			return 0;
 		}
 	default:

