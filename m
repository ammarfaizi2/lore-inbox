Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSEQCys>; Thu, 16 May 2002 22:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSEQCyr>; Thu, 16 May 2002 22:54:47 -0400
Received: from mta9n.bluewin.ch ([195.186.1.215]:33061 "EHLO mta9n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S315370AbSEQCyq>;
	Thu, 16 May 2002 22:54:46 -0400
Date: Fri, 17 May 2002 04:54:36 +0200
From: "'Roger Luethi'" <rl@hellgate.ch>
To: "Ivan G." <ivangurdiev@linuxfreemail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] #3 VIA Rhine stalls: Wait for the chip?
Message-ID: <20020517025436.GA8979@k3.hellgate.ch>
In-Reply-To: <20020516180354.GA9151@k3.hellgate.ch> <Pine.LNX.3.95.1020516141423.993A-100000@chaos.analogic.com> <20020516203159.GA10868@k3.hellgate.ch> <02051610375200.01074@cobra.linux>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.19-pre8 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, 16 May 2002 10:37:52 -0600, Ivan G. wrote:
> > What tickles my curiosity is that my previous patch didn't fix the stalling
> > for Ivan G. on his VT86C100A. Maybe the chip just wasn't ready to be
> > restarted.
> 
> With your patch #2, the chip would actually "wait forever"
> in some cases...it didn't timeout and recover 

What does the log file say? (with debug = 7) The most interesting
information (buffer descriptors and various registers) doesn't get logged,
but the log file may contain a clue that goes beyond "wait forever".

Hanging without timeout seems to indicate that all buffers were
successfully sent (if all frames have been sent, there is no transfer
left to time out). But I'm shooting in the dark here, somebody with
access to such a card needs to look into it.

I have a wonderful unified theory to explain everything but I'm afraid I'm
not looking forward to see it make contact with reality. Anyway, here goes:
On my system, it's almost impossible for the Tx engine to be still on by
the time we enter the error handler. In fact, even checking in
via_rhine_tx() gave me only one instance in hundreds of aborts. If the
VT86C100A (or something else about your setup) is slower, we might turn the
engine back on before the chip is ready. Patch #2 has a faster path to the
point where we set TXON which might explain why things got worse for you.

The problem with this idea is that the VIA driver does the error handling
as soon as it finds an abort, while the LK driver frees the skb first and
returns back to the interrupt handler before it enters the error handler to
finally do something about the error, which should give the chip ample time
to stop the Tx engine meanwhile. I attach a quick hack which will complain
if the driver had to wait for the chip. It will make up to four attempts
before it shrugs and proceeds as it used to. If you have time to give the
patch a spin, I'd be interested if you find any iteration counters in your
log file.

The patch is against the new version Jeff sent out earlier today. Please
note that with the current driver tx underruns are likely to cause a time
out. My patch doesn't even make an attempt at addressing errors other than
aborts.

Roger

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine.c.3.patch"

--- via-rhine.c.org	Thu May 16 21:51:46 2002
+++ via-rhine.c	Fri May 17 04:25:05 2002
@@ -234,7 +234,8 @@ II. Board-specific settings
 Boards with this chip are functional only in a bus-master PCI slot.
 
 Many operational settings are loaded from the EEPROM to the Config word at
-offset 0x78.  This driver assumes that they are correct.
+offset 0x78. For most of these settings, this driver assumes that they are
+correct.
 If this driver is compiled to use PCI memory space operations the EEPROM
 must be configured to enable memory ops.
 
@@ -388,7 +389,10 @@ enum register_offsets {
 
 /* Bits in ConfigD (select backoff algorithm (Ethernet capture effect)) */
 enum backoff_bits {
-	BackOpt=0x01, BackAMD=0x02, BackDEC=0x04, BackRandom=0x08
+	BackOptional=0x01,
+	BackModify=0x02,
+	BackCaptureEffect=0x04,
+	BackRandom=0x08
 };
 
 #ifdef USE_MEM
@@ -428,24 +432,27 @@ enum mii_status_bits {
 /* The Rx and Tx buffer descriptors. */
 struct rx_desc {
 	s32 rx_status;
-	u32 desc_length;
+	u32 desc_length; /* Chain flag, Buffer/frame length */
 	u32 addr;
 	u32 next_desc;
 };
 struct tx_desc {
 	s32 tx_status;
-	u32 desc_length;
+	u32 desc_length; /* Chain flag, Tx Config, Frame length */
 	u32 addr;
 	u32 next_desc;
 };
 
+/* Initial value for tx_desc.desc_length, Buffer size goes to bits 0-10 */
+#define TXDESC 0x00e08000
+
 enum rx_status_bits {
 	RxOK=0x8000, RxWholePkt=0x0300, RxErr=0x008F
 };
 
-/* Bits in *_desc.status */
+/* Bits in *_desc.*_status */
 enum desc_status_bits {
-	DescOwn=0x80000000, DescEndPacket=0x4000, DescIntr=0x1000,
+	DescOwn=0x80000000
 };
 
 /* Bits in ChipCmd. */
@@ -703,6 +710,9 @@ static int __devinit via_rhine_init_one 
 		writeb(readb(ioaddr + ConfigA) & 0xFE, ioaddr + ConfigA);
 	}
 
+	/* Select backoff algorithm */
+	writeb(readb(ioaddr + ConfigD) & (0xF0 | BackModify), ioaddr + ConfigD);
+
 	dev->irq = pdev->irq;
 
 	np = dev->priv;
@@ -937,7 +947,7 @@ static void alloc_tbufs(struct net_devic
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		np->tx_skbuff[i] = 0;
 		np->tx_ring[i].tx_status = 0;
-		np->tx_ring[i].desc_length = cpu_to_le32(0x00e08000);
+		np->tx_ring[i].desc_length = cpu_to_le32(TXDESC);
 		next += sizeof(struct tx_desc);
 		np->tx_ring[i].next_desc = cpu_to_le32(next);
 		np->tx_buf[i] = &np->tx_bufs[i * PKT_BUF_SZ];
@@ -953,7 +963,7 @@ static void free_tbufs(struct net_device
 
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		np->tx_ring[i].tx_status = 0;
-		np->tx_ring[i].desc_length = cpu_to_le32(0x00e08000);
+		np->tx_ring[i].desc_length = cpu_to_le32(TXDESC);
 		np->tx_ring[i].addr = cpu_to_le32(0xBADF00D0); /* An invalid address. */
 		if (np->tx_skbuff[i]) {
 			if (np->tx_skbuff_dma[i]) {
@@ -978,7 +988,7 @@ static void init_registers(struct net_de
 		writeb(dev->dev_addr[i], ioaddr + StationAddr + i);
 
 	/* Initialize other registers. */
-	writew(0x0006, ioaddr + PCIBusConfig);	/* Store & forward */
+	writew(0x0006, ioaddr + PCIBusConfig);	/* Tune configuration??? */
 	/* Configure initial FIFO thresholds. */
 	writeb(0x20, ioaddr + TxConfig);
 	np->tx_thresh = 0x20;
@@ -1237,7 +1247,7 @@ static int via_rhine_start_tx(struct sk_
 	}
 
 	np->tx_ring[entry].desc_length = 
-		cpu_to_le32(0x00E08000 | (skb->len >= ETH_ZLEN ? skb->len : ETH_ZLEN));
+		cpu_to_le32(TXDESC | (skb->len >= ETH_ZLEN ? skb->len : ETH_ZLEN));
 
 	/* lock eth irq */
 	spin_lock_irq (&np->lock);
@@ -1502,8 +1512,19 @@ static void via_rhine_error(struct net_d
 		clear_tally_counters(ioaddr);
 	}
 	if (intr_status & IntrTxAbort) {
-		/* Stats counted in Tx-done handler, just restart Tx. */
+		int i=0;
+		while ((i!=4) && (readw(dev->base_addr + ChipCmd) & CmdTxOn)) {
+			i++;
+		};
+		if (i) { printk(KERN_ERR "Abort: %d iterations.\n", i); }
+		/* No skipping frames we have no results for! Bad chip! */
+		writel(virt_to_bus(&np->tx_ring[np->dirty_tx % TX_RING_SIZE]),
+			   ioaddr + TxRingPtr);
+		/* Prevent hanging on a full queue */
 		writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
+		if (debug > 1)
+			printk(KERN_INFO "%s: Abort %4.4x, frame dropped.\n",
+				   dev->name, intr_status);
 	}
 	if (intr_status & IntrTxUnderrun) {
 		if (np->tx_thresh < 0xE0)

--tThc/1wpZn/ma/RB--
