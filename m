Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbSL2BE5>; Sat, 28 Dec 2002 20:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbSL2BE4>; Sat, 28 Dec 2002 20:04:56 -0500
Received: from msg.vodafone.pt ([212.18.167.162]:21154 "EHLO msg.vodafone.pt")
	by vger.kernel.org with ESMTP id <S265725AbSL2BEy>;
	Sat, 28 Dec 2002 20:04:54 -0500
Date: Sun, 29 Dec 2002 01:13:02 +0000
From: "Paulo Andre'" <fscked@netvisao.pt>
To: dahinds@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 3c574_cs.c locking fixes
Message-Id: <20021229011302.3a4cc200.fscked@netvisao.pt>
Organization: Orion Enterprises
X-Mailer: Sylpheed version 0.8.6claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Dec 2002 01:12:31.0828 (UTC) FILETIME=[5CD24140:01C2AED7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds proper locking to the 3c574 pcmcia driver.

	Paulo Andre'

---


--- 3c574_cs.c.orig     2002-12-28 23:55:58.000000000 +0000
+++ 3c574_cs.c  2002-12-29 01:00:44.000000000 +0000
@@ -221,6 +221,7 @@
        u_short media_status;
        u_short fast_poll;
        u_long last_irq;
+       spinlock_t lock;
 }; 
 
 /* Set iff a MII transceiver on any interface requires mdio preamble.
@@ -1020,9 +1021,11 @@
 {   
     struct el3_private *lp = (struct el3_private *)arg;
     struct net_device *dev = &lp->dev;
+    unsigned long flags;
+    
     ioaddr_t ioaddr = dev->base_addr;
-    u_long flags;
-       u_short /* cable, */ media, partner;
+
+       u_short /* cable, */ media, partner;
                
        if (!netif_device_present(dev))
                goto reschedule;
@@ -1043,13 +1046,12 @@
                return;
     }

-       save_flags(flags);
-       cli();
+       spin_lock_irqsave(&lp->lock, flags);
        EL3WINDOW(4);
        media = mdio_read(ioaddr, lp->phys, 1);
        partner = mdio_read(ioaddr, lp->phys, 5);
        EL3WINDOW(1);
-       restore_flags(flags);
+       spin_unlock_irqrestore(&lp->lock, flags);

        if (media != lp->media_status) {
                if ((media ^ lp->media_status) & 0x0004)
@@ -1232,31 +1234,29 @@
        case SIOCDEVPRIVATE+1:          /* Read the specified MII register. */
                {
                        int saved_window;
-                       unsigned long flags;
+                       unsigned long flags;

-                       save_flags(flags);
-                       cli();
+                       spin_lock_irqsave(&lp->lock, flags);
                        saved_window = inw(ioaddr + EL3_CMD) >> 13;
                        EL3WINDOW(4);
                        data[3] = mdio_read(ioaddr, data[0] & 0x1f, data[1] &
0x1f);                        EL3WINDOW(saved_window);
-                       restore_flags(flags);
+                       spin_unlock_irqrestore(&lp->lock, flags);
                        return 0;
                }
        case SIOCDEVPRIVATE+2:          /* Write the specified MII register */
                {
                        int saved_window;
-                       unsigned long flags;
+                        unsigned long flags;

                        if (!capable(CAP_NET_ADMIN))
                                return -EPERM;
-                       save_flags(flags);
-                       cli();
+                       spin_lock_irqsave(&lp->lock, flags);
                        saved_window = inw(ioaddr + EL3_CMD) >> 13;
                        EL3WINDOW(4);
                        mdio_write(ioaddr, data[0] & 0x1f, data[1] & 0x1f,
data[2]);                        EL3WINDOW(saved_window);
-                       restore_flags(flags);
+                       spin_unlock_irqrestore(&lp->lock, flags);
                        return 0;
                }
        default:
