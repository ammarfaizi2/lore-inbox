Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264766AbTGKRzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264730AbTGKRys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:54:48 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:3716
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264551AbTGKRw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:52:59 -0400
Date: Fri, 11 Jul 2003 19:06:46 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111806.h6BI6kJS017248@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix up nmclan locking and hang on eject at wrong moment
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Not tested as I no longer have the card]
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/drivers/net/pcmcia/nmclan_cs.c linux-2.5.75-ac1/drivers/net/pcmcia/nmclan_cs.c
--- linux-2.5.75/drivers/net/pcmcia/nmclan_cs.c	2003-07-10 21:04:57.000000000 +0100
+++ linux-2.5.75-ac1/drivers/net/pcmcia/nmclan_cs.c	2003-07-11 15:58:34.000000000 +0100
@@ -8,6 +8,7 @@
 
 Written by Roger C. Pao <rpao@paonet.org>
   Copyright 1995 Roger C. Pao
+  Linux 2.5 cleanups Copyright Red Hat 2003
 
   This software may be used and distributed according to the terms of
   the GNU General Public License.
@@ -68,6 +69,10 @@
 History
 -------------------------------------------------------------------------------
 Log: nmclan_cs.c,v
+ * 2.5.75-ac1 2003/07/11 Alan Cox <alan@redhat.com>
+ * Fixed hang on card eject as we probe it
+ * Cleaned up to use new style locking.
+ *
  * Revision 0.16  1995/07/01  06:42:17  rpao
  * Bug fix: nmclan_reset() called CardServices incorrectly.
  *
@@ -369,6 +374,8 @@
 
     char tx_free_frames; /* Number of free transmit frame buffers */
     char tx_irq_disabled; /* MACE TX interrupt disabled */
+    
+    spinlock_t bank_lock; /* Must be held if you step off bank 0 */
 } mace_private;
 
 /* ----------------------------------------------------------------------------
@@ -482,6 +489,7 @@
     link = &lp->link;
     link->priv = dev;
     
+    spin_lock_init(&lp->bank_lock);
     init_timer(&link->release);
     link->release.function = &nmclan_release;
     link->release.data = (u_long)link;
@@ -561,7 +569,7 @@
     if (*linkp == NULL)
 	return;
 
-    del_timer(&link->release);
+    del_timer_sync(&link->release);
     if (link->state & DEV_CONFIG) {
 	nmclan_release((u_long)link);
 	if (link->state & DEV_STALE_CONFIG) {
@@ -588,7 +596,7 @@
 	assuming that during normal operation, the MACE is always in
 	bank 0.
 ---------------------------------------------------------------------------- */
-static int mace_read(ioaddr_t ioaddr, int reg)
+static int mace_read(mace_private *lp, ioaddr_t ioaddr, int reg)
 {
   int data = 0xFF;
   unsigned long flags;
@@ -598,12 +606,11 @@
       data = inb(ioaddr + AM2150_MACE_BASE + reg);
       break;
     case 1: /* register 16-31 */
-      save_flags(flags);
-      cli();
+      spin_lock_irqsave(&lp->bank_lock, flags);
       MACEBANK(1);
       data = inb(ioaddr + AM2150_MACE_BASE + (reg & 0x0F));
       MACEBANK(0);
-      restore_flags(flags);
+      spin_unlock_irqrestore(&lp->bank_lock, flags);
       break;
   }
   return (data & 0xFF);
@@ -616,7 +623,7 @@
 	are assuming that during normal operation, the MACE is always in
 	bank 0.
 ---------------------------------------------------------------------------- */
-static void mace_write(ioaddr_t ioaddr, int reg, int data)
+static void mace_write(mace_private *lp, ioaddr_t ioaddr, int reg, int data)
 {
   unsigned long flags;
 
@@ -625,12 +632,11 @@
       outb(data & 0xFF, ioaddr + AM2150_MACE_BASE + reg);
       break;
     case 1: /* register 16-31 */
-      save_flags(flags);
-      cli();
+      spin_lock_irqsave(&lp->bank_lock, flags);
       MACEBANK(1);
       outb(data & 0xFF, ioaddr + AM2150_MACE_BASE + (reg & 0x0F));
       MACEBANK(0);
-      restore_flags(flags);
+      spin_unlock_irqrestore(&lp->bank_lock, flags);
       break;
   }
 } /* mace_write */
@@ -639,22 +645,29 @@
 mace_init
 	Resets the MACE chip.
 ---------------------------------------------------------------------------- */
-static void mace_init(ioaddr_t ioaddr, char *enet_addr)
+static int mace_init(mace_private *lp, ioaddr_t ioaddr, char *enet_addr)
 {
   int i;
+  int ct = 0;
 
   /* MACE Software reset */
-  mace_write(ioaddr, MACE_BIUCC, 1);
-  while (mace_read(ioaddr, MACE_BIUCC) & 0x01) {
+  mace_write(lp, ioaddr, MACE_BIUCC, 1);
+  while (mace_read(lp, ioaddr, MACE_BIUCC) & 0x01) {
     /* Wait for reset bit to be cleared automatically after <= 200ns */;
+    if(++ct > 500)
+    {
+    	printk(KERN_ERR "mace: reset failed, card removed ?\n");
+    	return -1;
+    }
+    udelay(1);
   }
-  mace_write(ioaddr, MACE_BIUCC, 0);
+  mace_write(lp, ioaddr, MACE_BIUCC, 0);
 
   /* The Am2150 requires that the MACE FIFOs operate in burst mode. */
-  mace_write(ioaddr, MACE_FIFOCC, 0x0F);
+  mace_write(lp, ioaddr, MACE_FIFOCC, 0x0F);
 
-  mace_write(ioaddr, MACE_RCVFC, 0); /* Disable Auto Strip Receive */
-  mace_write(ioaddr, MACE_IMR, 0xFF); /* Disable all interrupts until _open */
+  mace_write(lp,ioaddr, MACE_RCVFC, 0); /* Disable Auto Strip Receive */
+  mace_write(lp, ioaddr, MACE_IMR, 0xFF); /* Disable all interrupts until _open */
 
   /*
    * Bit 2-1 PORTSEL[1-0] Port Select.
@@ -670,31 +683,39 @@
    */
   switch (if_port) {
     case 1:
-      mace_write(ioaddr, MACE_PLSCC, 0x02);
+      mace_write(lp, ioaddr, MACE_PLSCC, 0x02);
       break;
     case 2:
-      mace_write(ioaddr, MACE_PLSCC, 0x00);
+      mace_write(lp, ioaddr, MACE_PLSCC, 0x00);
       break;
     default:
-      mace_write(ioaddr, MACE_PHYCC, /* ASEL */ 4);
+      mace_write(lp, ioaddr, MACE_PHYCC, /* ASEL */ 4);
       /* ASEL Auto Select.  When set, the PORTSEL[1-0] bits are overridden,
 	 and the MACE device will automatically select the operating media
 	 interface port. */
       break;
   }
 
-  mace_write(ioaddr, MACE_IAC, MACE_IAC_ADDRCHG | MACE_IAC_PHYADDR);
+  mace_write(lp, ioaddr, MACE_IAC, MACE_IAC_ADDRCHG | MACE_IAC_PHYADDR);
   /* Poll ADDRCHG bit */
-  while (mace_read(ioaddr, MACE_IAC) & MACE_IAC_ADDRCHG)
-    ;
+  ct = 0;
+  while (mace_read(lp, ioaddr, MACE_IAC) & MACE_IAC_ADDRCHG)
+  {
+  	if(++ ct > 500)
+  	{
+  		printk(KERN_ERR "mace: ADDRCHG timeout, card removed ?\n");
+  		return -1;
+  	}
+  }
   /* Set PADR register */
   for (i = 0; i < ETHER_ADDR_LEN; i++)
-    mace_write(ioaddr, MACE_PADR, enet_addr[i]);
+    mace_write(lp, ioaddr, MACE_PADR, enet_addr[i]);
 
   /* MAC Configuration Control Register should be written last */
   /* Let set_multicast_list set this. */
-  /* mace_write(ioaddr, MACE_MACCC, MACE_MACCC_ENXMT | MACE_MACCC_ENRCV); */
-  mace_write(ioaddr, MACE_MACCC, 0x00);
+  /* mace_write(lp, ioaddr, MACE_MACCC, MACE_MACCC_ENXMT | MACE_MACCC_ENRCV); */
+  mace_write(lp, ioaddr, MACE_MACCC, 0x00);
+  return 0;
 } /* mace_init */
 
 /* ----------------------------------------------------------------------------
@@ -759,8 +780,8 @@
   {
     char sig[2];
 
-    sig[0] = mace_read(ioaddr, MACE_CHIPIDL);
-    sig[1] = mace_read(ioaddr, MACE_CHIPIDH);
+    sig[0] = mace_read(lp, ioaddr, MACE_CHIPIDL);
+    sig[1] = mace_read(lp, ioaddr, MACE_CHIPIDH);
     if ((sig[0] == 0x40) && ((sig[1] & 0x0F) == 0x09)) {
       DEBUG(0, "nmclan_cs configured: mace id=%x %x\n",
 	    sig[0], sig[1]);
@@ -772,7 +793,8 @@
     }
   }
 
-  mace_init(ioaddr, dev->dev_addr);
+  if(mace_init(lp, ioaddr, dev->dev_addr) == -1)
+  	goto failed;
 
   /* The if_port symbol can be set when the module is loaded */
   if (if_port <= 2)
@@ -923,8 +945,8 @@
   lp->tx_free_frames=AM2150_MAX_TX_FRAMES;
 
   /* Reinitialize the MACE chip for operation. */
-  mace_init(dev->base_addr, dev->dev_addr);
-  mace_write(dev->base_addr, MACE_IMR, MACE_IMR_DEFAULT);
+  mace_init(lp, dev->base_addr, dev->dev_addr);
+  mace_write(lp, dev->base_addr, MACE_IMR, MACE_IMR_DEFAULT);
 
   /* Restore the multicast list and enable TX and RX. */
   restore_multicast_list(dev);
@@ -1456,9 +1478,9 @@
 {
   mace_private *lp = (mace_private *)dev->priv;
 
-  lp->mace_stats.rcvcc += mace_read(ioaddr, MACE_RCVCC);
-  lp->mace_stats.rntpc += mace_read(ioaddr, MACE_RNTPC);
-  lp->mace_stats.mpc += mace_read(ioaddr, MACE_MPC);
+  lp->mace_stats.rcvcc += mace_read(lp, ioaddr, MACE_RCVCC);
+  lp->mace_stats.rntpc += mace_read(lp, ioaddr, MACE_RNTPC);
+  lp->mace_stats.mpc += mace_read(lp, ioaddr, MACE_MPC);
   /* At this point, mace_stats is fully updated for this call.
      We may now update the linux_stats. */
 
@@ -1608,30 +1630,30 @@
 
     DEBUG(1, "Attempt to restore multicast list detected.\n");
 
-    mace_write(ioaddr, MACE_IAC, MACE_IAC_ADDRCHG | MACE_IAC_LOGADDR);
+    mace_write(lp, ioaddr, MACE_IAC, MACE_IAC_ADDRCHG | MACE_IAC_LOGADDR);
     /* Poll ADDRCHG bit */
-    while (mace_read(ioaddr, MACE_IAC) & MACE_IAC_ADDRCHG)
+    while (mace_read(lp, ioaddr, MACE_IAC) & MACE_IAC_ADDRCHG)
       ;
     /* Set LADRF register */
     for (i = 0; i < MACE_LADRF_LEN; i++)
-      mace_write(ioaddr, MACE_LADRF, ladrf[i]);
+      mace_write(lp, ioaddr, MACE_LADRF, ladrf[i]);
 
-    mace_write(ioaddr, MACE_UTR, MACE_UTR_RCVFCSE | MACE_UTR_LOOP_EXTERNAL);
-    mace_write(ioaddr, MACE_MACCC, MACE_MACCC_ENXMT | MACE_MACCC_ENRCV);
+    mace_write(lp, ioaddr, MACE_UTR, MACE_UTR_RCVFCSE | MACE_UTR_LOOP_EXTERNAL);
+    mace_write(lp, ioaddr, MACE_MACCC, MACE_MACCC_ENXMT | MACE_MACCC_ENRCV);
 
   } else if (num_addrs < 0) {
 
     /* Promiscuous mode: receive all packets */
-    mace_write(ioaddr, MACE_UTR, MACE_UTR_LOOP_EXTERNAL);
-    mace_write(ioaddr, MACE_MACCC,
+    mace_write(lp, ioaddr, MACE_UTR, MACE_UTR_LOOP_EXTERNAL);
+    mace_write(lp, ioaddr, MACE_MACCC,
       MACE_MACCC_PROM | MACE_MACCC_ENXMT | MACE_MACCC_ENRCV
     );
 
   } else {
 
     /* Normal mode */
-    mace_write(ioaddr, MACE_UTR, MACE_UTR_LOOP_EXTERNAL);
-    mace_write(ioaddr, MACE_MACCC, MACE_MACCC_ENXMT | MACE_MACCC_ENRCV);
+    mace_write(lp, ioaddr, MACE_UTR, MACE_UTR_LOOP_EXTERNAL);
+    mace_write(lp, ioaddr, MACE_MACCC, MACE_MACCC_ENXMT | MACE_MACCC_ENRCV);
 
   }
 } /* restore_multicast_list */
@@ -1691,20 +1713,21 @@
 static void restore_multicast_list(struct net_device *dev)
 {
   ioaddr_t ioaddr = dev->base_addr;
+  mace_private *lp = (mace_private *)dev->priv;
 
   DEBUG(2, "%s: restoring Rx mode to %d addresses.\n", dev->name,
 	((mace_private *)(dev->priv))->multicast_num_addrs);
 
   if (dev->flags & IFF_PROMISC) {
     /* Promiscuous mode: receive all packets */
-    mace_write(ioaddr, MACE_UTR, MACE_UTR_LOOP_EXTERNAL);
-    mace_write(ioaddr, MACE_MACCC,
+    mace_write(lp,ioaddr, MACE_UTR, MACE_UTR_LOOP_EXTERNAL);
+    mace_write(lp, ioaddr, MACE_MACCC,
       MACE_MACCC_PROM | MACE_MACCC_ENXMT | MACE_MACCC_ENRCV
     );
   } else {
     /* Normal mode */
-    mace_write(ioaddr, MACE_UTR, MACE_UTR_LOOP_EXTERNAL);
-    mace_write(ioaddr, MACE_MACCC, MACE_MACCC_ENXMT | MACE_MACCC_ENRCV);
+    mace_write(lp, ioaddr, MACE_UTR, MACE_UTR_LOOP_EXTERNAL);
+    mace_write(lp, ioaddr, MACE_MACCC, MACE_MACCC_ENXMT | MACE_MACCC_ENRCV);
   }
 } /* restore_multicast_list */
 
