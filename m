Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbTCWBd4>; Sat, 22 Mar 2003 20:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbTCWBd4>; Sat, 22 Mar 2003 20:33:56 -0500
Received: from dp.samba.org ([66.70.73.150]:38615 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262214AbTCWBdj>;
	Sat, 22 Mar 2003 20:33:39 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15997.4306.248276.653704@nanango.paulus.ozlabs.org>
Date: Sun, 23 Mar 2003 12:41:38 +1100 (EST)
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] MACE ethernet driver update
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the MACE ethernet driver, used on older powermacs,
to remove the uses of save_flags/restore_flags/cli/sti and use a
spinlock instead.

Jeff, please send this on to Linus.

Paul.

diff -urN linux-2.5/drivers/net/mace.c linuxppc-2.5/drivers/net/mace.c
--- linux-2.5/drivers/net/mace.c	2002-11-08 05:18:09.000000000 +1100
+++ linuxppc-2.5/drivers/net/mace.c	2003-02-13 09:07:11.000000000 +1100
@@ -16,6 +16,7 @@
 #include <linux/timer.h>
 #include <linux/init.h>
 #include <linux/crc32.h>
+#include <linux/spinlock.h>
 #include <asm/prom.h>
 #include <asm/dbdma.h>
 #include <asm/io.h>
@@ -63,6 +64,7 @@
     int chipid;
     struct device_node* of_node;
     struct net_device *next_mace;
+    spinlock_t lock;
 };
 
 /*
@@ -203,6 +205,7 @@
 	memset((char *) mp->tx_cmds, 0,
 	       (NCMDS_TX*N_TX_RING + N_RX_RING + 2) * sizeof(struct dbdma_cmd));
 	init_timer(&mp->tx_timeout);
+	spin_lock_init(&mp->lock);
 	mp->timeout_active = 0;
 
 	if (port_aaui >= 0)
@@ -351,14 +354,14 @@
     volatile struct mace *mb = mp->mace;
     unsigned long flags;
 
-    save_flags(flags); cli();
+    spin_lock_irqsave(&mp->lock, flags);
 
     __mace_set_address(dev, addr);
 
     /* note: setting ADDRCHG clears ENRCV */
     out_8(&mb->maccc, mp->maccc);
 
-    restore_flags(flags);
+    spin_unlock_irqrestore(&mp->lock, flags);
     return 0;
 }
 
@@ -473,10 +476,7 @@
 static inline void mace_set_timeout(struct net_device *dev)
 {
     struct mace_data *mp = (struct mace_data *) dev->priv;
-    unsigned long flags;
 
-    save_flags(flags);
-    cli();
     if (mp->timeout_active)
 	del_timer(&mp->tx_timeout);
     mp->tx_timeout.expires = jiffies + TX_TIMEOUT;
@@ -484,7 +484,6 @@
     mp->tx_timeout.data = (unsigned long) dev;
     add_timer(&mp->tx_timeout);
     mp->timeout_active = 1;
-    restore_flags(flags);
 }
 
 static int mace_xmit_start(struct sk_buff *skb, struct net_device *dev)
@@ -496,7 +495,7 @@
     int fill, next, len;
 
     /* see if there's a free slot in the tx ring */
-    save_flags(flags); cli();
+    spin_lock_irqsave(&mp->lock, flags);
     fill = mp->tx_fill;
     next = fill + 1;
     if (next >= N_TX_RING)
@@ -504,10 +503,10 @@
     if (next == mp->tx_empty) {
 	netif_stop_queue(dev);
 	mp->tx_fullup = 1;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&mp->lock, flags);
 	return 1;		/* can't take it at the moment */
     }
-    restore_flags(flags);
+    spin_unlock_irqrestore(&mp->lock, flags);
 
     /* partially fill in the dma command block */
     len = skb->len;
@@ -524,8 +523,7 @@
     out_le16(&np->command, DBDMA_STOP);
 
     /* poke the tx dma channel */
-    save_flags(flags);
-    cli();
+    spin_lock_irqsave(&mp->lock, flags);
     mp->tx_fill = next;
     if (!mp->tx_bad_runt && mp->tx_active < MAX_TX_ACTIVE) {
 	out_le16(&cp->xfer_status, 0);
@@ -538,7 +536,7 @@
 	next = 0;
     if (next == mp->tx_empty)
 	netif_stop_queue(dev);
-    restore_flags(flags);
+    spin_unlock_irqrestore(&mp->lock, flags);
 
     return 0;
 }
@@ -556,7 +554,9 @@
     volatile struct mace *mb = mp->mace;
     int i, j;
     u32 crc;
+    unsigned long flags;
 
+    spin_lock_irqsave(&mp->lock, flags);
     mp->maccc &= ~PROM;
     if (dev->flags & IFF_PROMISC) {
 	mp->maccc |= PROM;
@@ -598,6 +598,7 @@
     }
     /* reset maccc */
     out_8(&mb->maccc, mp->maccc);
+    spin_unlock_irqrestore(&mp->lock, flags);
 }
 
 static void mace_handle_misc_intrs(struct mace_data *mp, int intr)
@@ -630,8 +631,10 @@
     volatile struct dbdma_cmd *cp;
     int intr, fs, i, stat, x;
     int xcount, dstat;
+    unsigned long flags;
     /* static int mace_last_fs, mace_last_xcount; */
 
+    spin_lock_irqsave(&mp->lock, flags);
     intr = in_8(&mb->ir);		/* read interrupt register */
     in_8(&mb->xmtrc);			/* get retries */
     mace_handle_misc_intrs(mp, intr);
@@ -761,6 +764,7 @@
 	out_le32(&td->control, ((RUN|WAKE) << 16) + (RUN|WAKE));
 	mace_set_timeout(dev);
     }
+    spin_unlock_irqrestore(&mp->lock, flags);
 }
 
 static void mace_tx_timeout(unsigned long data)
@@ -774,8 +778,7 @@
     unsigned long flags;
     int i;
 
-    save_flags(flags);
-    cli();
+    spin_lock_irqsave(&mp->lock, flags);
     mp->timeout_active = 0;
     if (mp->tx_active == 0 && !mp->tx_bad_runt)
 	goto out;
@@ -827,7 +830,7 @@
     out_8(&mb->maccc, mp->maccc);
 
 out:
-    restore_flags(flags);
+    spin_unlock_irqrestore(&mp->lock, flags);
 }
 
 static void mace_txdma_intr(int irq, void *dev_id, struct pt_regs *regs)
@@ -845,7 +848,9 @@
     unsigned frame_status;
     static int mace_lost_status;
     unsigned char *data;
+    unsigned long flags;
 
+    spin_lock_irqsave(&mp->lock, flags);
     for (i = mp->rx_empty; i != mp->rx_fill; ) {
 	cp = mp->rx_cmds + i;
 	stat = ld_le16(&cp->xfer_status);
@@ -941,6 +946,7 @@
 	out_le32(&rd->control, ((RUN|WAKE) << 16) | (RUN|WAKE));
 	mp->rx_fill = i;
     }
+    spin_unlock_irqrestore(&mp->lock, flags);
 }
 
 MODULE_AUTHOR("Paul Mackerras");
