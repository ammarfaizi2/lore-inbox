Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319024AbSH1XIg>; Wed, 28 Aug 2002 19:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319027AbSH1XIg>; Wed, 28 Aug 2002 19:08:36 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:64267 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S319024AbSH1XIf>; Wed, 28 Aug 2002 19:08:35 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200208282308.g7SN8W7S032115@wildsau.idv.uni.linz.at>
Subject: [path] via-rhine.c
In-Reply-To: <20020828214333.GA18492@k3.hellgate.ch> from Roger Luethi at "Aug 28, 2 11:43:33 pm"
To: rl@hellgate.ch (Roger Luethi)
Date: Thu, 29 Aug 2002 01:08:31 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org (l),
       kernel@wildsau.idv.uni.linz.at (H.Rosmanith (Kernel Mailing List))
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello list,

this patch is agains 1.15 of via-rhine.c
it isn't supposed to be a fix, but a workaround. if you have any
better idea why the error is occuring, you are welcome.

regards,
h.rosmanith


--- via-rhine.c.p9-debug	Thu Aug 29 07:14:12 2002
+++ via-rhine.c	Thu Aug 29 07:12:43 2002
@@ -100,6 +100,15 @@
 	- allow selecting backoff algorithm (module parameter)
 	- cosmetic cleanups, remove 3 unused members of struct netdev_private
 
+	preliminary: (Herbert Rosmanith):
+	- for some yet unknown reason (which seems to be collision-related),
+	 TX DMA is off in via_rhine_interrupt in the ChipCmd register. this
+	 leads to an entry in the ringbuffer which is never processed and
+	 therefore blocks the ringbuffer. the hack provided sets the TxRingPtr
+	 in the chip to the entry blocking the ringbuffer, marking it for
+	 being processed again. this error seems to happen only with the VT6103.
+
 */
 
 #define DRV_NAME	"via-rhine"
@@ -474,6 +483,8 @@
 
 #define MAX_MII_CNT	4
 struct netdev_private {
+	// XXX hack hack hack
+	int intr_cmd;
 	/* Descriptor rings */
 	struct rx_desc *rx_ring;
 	struct tx_desc *tx_ring;
@@ -1294,11 +1305,13 @@
 static void via_rhine_interrupt(int irq, void *dev_instance, struct pt_regs *rgs)
 {
 	struct net_device *dev = dev_instance;
+	struct netdev_private *np=dev->priv;
 	long ioaddr;
 	u32 intr_status;
 	int boguscnt = max_interrupt_work;
 
 	ioaddr = dev->base_addr;
+	np->intr_cmd=readw(ioaddr+ChipCmd); // needed later in via_rhine_tx
 	
 	while ((intr_status = readw(ioaddr + IntrStatus))) {
 		/* Acknowledge all of the current interrupt sources ASAP. */
@@ -1350,8 +1363,12 @@
 		if (debug > 6)
 			printk(KERN_DEBUG " Tx scavenge %d status %8.8x.\n",
 				   entry, txstatus);
-		if (txstatus & DescOwn)
+		if (txstatus & DescOwn) {
+			if ((np->intr_cmd&0x0010)==0) // Gack! DMA is off
+				writel(np->tx_ring_dma + entry * sizeof(struct tx_desc),
+					dev->base_addr+TxRingPtr);
 			break;
+		}
 		if (txstatus & 0x8000) {
 			if (debug > 1)
 				printk(KERN_DEBUG "%s: Transmit error, Tx status %8.8x.\n",
