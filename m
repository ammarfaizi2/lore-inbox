Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262586AbSJBUEQ>; Wed, 2 Oct 2002 16:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262588AbSJBUEP>; Wed, 2 Oct 2002 16:04:15 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12051 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262586AbSJBUEO>; Wed, 2 Oct 2002 16:04:14 -0400
Message-Id: <200210022004.g92K4qp31813@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cli()/sti() fix for drivers/net/3c515.c
Date: Wed, 2 Oct 2002 22:58:45 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Jeff Garzik <jgarzik@mandrakesoft.com>,
       "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are my first patches for network drivers.
Please comment if I'm doing something wrong.
Compile tested. Testers with hw wanted.
--
vda

diff -u --recursive linux-2.5.38orig/drivers/net/3c515.c linux-2.5.38/drivers/net/3c515.c
--- linux-2.5.38orig/drivers/net/3c515.c	Sun Sep 22 04:25:01 2002
+++ linux-2.5.38/drivers/net/3c515.c	Wed Oct  2 00:49:25 2002
@@ -422,6 +422,8 @@
 /* Note: this is the only limit on the number of cards supported!! */
 static int options[8] = { -1, -1, -1, -1, -1, -1, -1, -1, };

+static spinlock_t lock=SPIN_LOCK_UNLOCKED;
+
 #ifdef MODULE
 static int debug = -1;
 /* A list of all installed Vortex devices, for removing the driver module. */
@@ -917,8 +919,7 @@
 		printk("%s: Media selection timer tick happened, %s.\n",
 		       dev->name, media_tbl[dev->if_port].name);

-	save_flags(flags);
-	cli(); {
+	spin_lock_irqsave(&lock, flags); {
 		int old_window = inw(ioaddr + EL3_CMD) >> 13;
 		int media_status;
 		EL3WINDOW(4);
@@ -986,7 +987,7 @@
 		}
 		EL3WINDOW(old_window);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 	if (corkscrew_debug > 1)
 		printk("%s: Media selection timer finished, %s.\n",
 		       dev->name, media_tbl[dev->if_port].name);
@@ -1069,8 +1070,7 @@
 		vp->tx_ring[entry].length = skb->len | 0x80000000;
 		vp->tx_ring[entry].status = skb->len | 0x80000000;

-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&lock, flags);
 		outw(DownStall, ioaddr + EL3_CMD);
 		/* Wait for the stall to complete. */
 		for (i = 20; i >= 0; i--)
@@ -1085,7 +1085,7 @@
 			queued_packet++;
 		}
 		outw(DownUnstall, ioaddr + EL3_CMD);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&lock,flags);

 		vp->cur_tx++;
 		if (vp->cur_tx - vp->dirty_tx > TX_RING_SIZE - 1)
@@ -1534,10 +1534,9 @@
 	unsigned long flags;

 	if (netif_running(dev)) {
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&lock, flags);
 		update_stats(dev->base_addr, dev);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&lock,flags);
 	}
 	return &vp->stats;
 }
