Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275906AbSIUMBG>; Sat, 21 Sep 2002 08:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275907AbSIUMBG>; Sat, 21 Sep 2002 08:01:06 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:22288 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S275906AbSIUMBE>; Sat, 21 Sep 2002 08:01:04 -0400
Date: Sat, 21 Sep 2002 08:04:09 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5.37] smc91c92_cs cli fix
Message-ID: <Pine.LNX.4.44.0209210801090.1602-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to make smc useable (tested), although looking around the driver 
(and pcmcia cs in general) needs a bit more to be smp safe anyway.

	Zwane

Index: linux-2.5.37/drivers/net/pcmcia/smc91c92_cs.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.37/drivers/net/pcmcia/smc91c92_cs.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smc91c92_cs.c
--- linux-2.5.37/drivers/net/pcmcia/smc91c92_cs.c	20 Sep 2002 18:13:10 -0000	1.1.1.1
+++ linux-2.5.37/drivers/net/pcmcia/smc91c92_cs.c	21 Sep 2002 01:16:31 -0000
@@ -109,6 +109,7 @@
 struct smc_private {
     dev_link_t			link;
     struct net_device		dev;
+    spinlock_t			lock;
     u_short			manfid;
     u_short			cardid;
     struct net_device_stats	stats;
@@ -346,7 +347,7 @@
     if (!smc) return NULL;
     memset(smc, 0, sizeof(struct smc_private));
     link = &smc->link; dev = &smc->dev;
-
+    spin_lock_init(&smc->lock);
     link->release.function = &smc91c92_release;
     link->release.data = (u_long)link;
     link->io.NumPorts1 = 16;
@@ -1777,6 +1778,7 @@
 static void set_rx_mode(struct net_device *dev)
 {
     ioaddr_t ioaddr = dev->base_addr;
+    struct smc_private *smc = dev->priv;
     u_int multicast_table[ 2 ] = { 0, };
     unsigned long flags;
     u_short rx_cfg_setting;
@@ -1795,16 +1797,15 @@
     }
     
     /* Load MC table and Rx setting into the chip without interrupts. */
-    save_flags(flags);
-    cli();
+    spin_lock_irqsave(&smc->lock, flags);
     SMC_SELECT_BANK(3);
     outl(multicast_table[0], ioaddr + MULTICAST0);
     outl(multicast_table[1], ioaddr + MULTICAST4);
     SMC_SELECT_BANK(0);
     outw(rx_cfg_setting, ioaddr + RCR);
     SMC_SELECT_BANK(2);
-    restore_flags(flags);
-    
+    spin_unlock_irqrestore(&smc->lock, flags);
+ 
     return;
 }
 

-- 
function.linuxpower.ca

