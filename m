Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbSJ3XpQ>; Wed, 30 Oct 2002 18:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264965AbSJ3XpQ>; Wed, 30 Oct 2002 18:45:16 -0500
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:43784 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S264963AbSJ3XpO>; Wed, 30 Oct 2002 18:45:14 -0500
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200210302343.g9UNhxW6012759@wildsau.idv.uni.linz.at>
Subject: Re: VIA EPIA problem
In-Reply-To: <1036021926.6756.3.camel@irongate.swansea.linux.org.uk> from Alan Cox at "Oct 30, 2 11:52:06 pm"
Date: Thu, 31 Oct 2002 00:43:59 +0100 (MET)
Cc: kernel@wildsau.idv.uni.linz.at, sergeyssv@mail.ru,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2002-10-30 at 22:13, H.Rosmanith (Kernel Mailing List) wrote:
> > please see my posts to lkml some months (2, 3?) ago. there's a problem
> > which stops the via-rhine. a small two-line patch will solve the problem.
> > search in the archives for "via" and "path", because I made a typo
> > and wrote "path" instead of "patch".
> 
> Can you forward another copy to the list if you have it handy ?

okay. please note it's a workaround. but it worked at least for
my board (and I have a via epia itx 500Mhz). this board seems to
be the only one which had the problems with the vt6103 onboard
ethernet-chip.


--- via-rhine.c.p9-debug      Thu Aug 29 07:14:12 2002
+++ via-rhine.c       Thu Aug 29 07:12:43 2002
@@ -100,6 +100,15 @@
      - allow selecting backoff algorithm (module parameter)
      - cosmetic cleanups, remove 3 unused members of struct netdev_private

+     preliminary: (Herbert Rosmanith):
+     - for some yet unknown reason (which seems to be collision-related),
+      TX DMA is off in via_rhine_interrupt in the ChipCmd register. this
+      leads to an entry in the ringbuffer which is never processed and
+      therefore blocks the ringbuffer. the hack provided sets the TxRingPtr
+      in the chip to the entry blocking the ringbuffer, marking it for
+      being processed again. this error seems to happen only with the VT6103.> +
 */

 #define DRV_NAME     "via-rhine"
@@ -474,6 +483,8 @@

 #define MAX_MII_CNT  4
 struct netdev_private {
+     // XXX hack hack hack
+     int intr_cmd;
      /* Descriptor rings */
      /* Descriptor rings */
      struct rx_desc *rx_ring;
      struct tx_desc *tx_ring;
@@ -1294,11 +1305,13 @@
 static void via_rhine_interrupt(int irq, void *dev_instance, struct pt_regs *rgs)
 {
      struct net_device *dev = dev_instance;
+     struct netdev_private *np=dev->priv;
      long ioaddr;
      u32 intr_status;
      int boguscnt = max_interrupt_work;

      ioaddr = dev->base_addr;
+     np->intr_cmd=readw(ioaddr+ChipCmd); // needed later in via_rhine_tx

      while ((intr_status = readw(ioaddr + IntrStatus))) {
              /* Acknowledge all of the current interrupt sources ASAP. */
@@ -1350,8 +1363,12 @@
              if (debug > 6)
                      printk(KERN_DEBUG " Tx scavenge %d status %8.8x.\n",
                                 entry, txstatus);
-             if (txstatus & DescOwn)
+             if (txstatus & DescOwn) {
+                     if ((np->intr_cmd&0x0010)==0) // Gack! DMA is off
+                             writel(np->tx_ring_dma + entry * sizeof(struct tx_desc),
+                                     dev->base_addr+TxRingPtr);
                      break;
+             }
              if (txstatus & 0x8000) {
                      if (debug > 1)
                              printk(KERN_DEBUG "%s: Transmit error, Tx status %8.8x.\n",

