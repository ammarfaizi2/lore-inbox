Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130689AbRARQqk>; Thu, 18 Jan 2001 11:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131075AbRARQqa>; Thu, 18 Jan 2001 11:46:30 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:23248 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S130689AbRARQqV>; Thu, 18 Jan 2001 11:46:21 -0500
Message-ID: <3A671DD5.51B4DEE@inet.com>
Date: Thu, 18 Jan 2001 10:46:13 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de
CC: eli.carter@inet.com, alan@redhat.com
Subject: [PATCH] pcnet32.c ARM support & AM79C973 improvements
Content-Type: multipart/mixed;
 boundary="------------50B63F5B8B1C9550A01DD46B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------50B63F5B8B1C9550A01DD46B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

Here is a patch that adds the following to the pcnet32.c driver:
- adds dma_cache_*() calls to support ARM processors.  Based on
Russell's changes to the tulip driver.
- add DXSUFLO to the AM79C973
- made DXSUFLO the default
- utilized the internal SRAM of the AM79C973
- added a 32 bit write & reset to the detection code since that was
needed on my system
- tried to improve the readability of the "Ring data dump" slightly
- According to the Am79C973/Am79C975 docs from AMD, The collision bits
are only valid if ENP is set, so I added a check for that.

The patch is against 2.2.18 and should apply cleanly.  I'm sending it as
an attachment since I've had difficulties other ways and I don't have a
handy place to leave it for ftp.

This can probably be done better... I'd like pointers for ways to
improve my changes.  Feedback on testing would be welcomed as well.

Comments?

Eli 
--------------------. "To the systems programmer, users and applications
Eli Carter          | serve only to provide a test load."
eli.carter@inet.com `---------------------------------- (random fortune)
--------------50B63F5B8B1C9550A01DD46B
Content-Type: text/plain; charset=us-ascii;
 name="patch-pcnet32-arm"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pcnet32-arm"

--- linux/drivers/net/pcnet32.c	2001/01/17 17:42:48	1.3
+++ linux/drivers/net/pcnet32.c	2001/01/18 16:16:13
@@ -41,6 +41,13 @@
 #include <linux/skbuff.h>
 #include <asm/spinlock.h>
 
+/* try to take care of non-cache-coherant systems */
+#ifndef dma_cache_inv
+#define dma_cache_inv(start, size)
+#define dma_cache_wback(start, size)
+#define dma_cache_wback_inv(start, size)
+#endif
+
 static unsigned int pcnet32_portlist[] __initdata = {0x300, 0x320, 0x340, 0x360, 0};
 
 static int pcnet32_debug = 1;
@@ -166,6 +173,7 @@
  * v1.25kf Added No Interrupt on successful Tx for some Tx's <kaf@fc.hp.com>
  */
 
+#define DO_DXSUFLO
 
 /*
  * Set the number of Tx and Rx buffers, using Log_2(# buffers).
@@ -553,6 +561,10 @@
     if (pcnet32_wio_read_csr (ioaddr, 0) == 4 && pcnet32_wio_check (ioaddr)) {
 	a = &pcnet32_wio;
     } else {
+	/* try to force it to 32bit mode by doing a safe write */
+	pcnet32_dwio_write_csr (ioaddr, 0, 0);
+	/* and a reset */
+	pcnet32_dwio_reset(ioaddr);
 	if (pcnet32_dwio_read_csr (ioaddr, 0) == 4 && pcnet32_dwio_check(ioaddr)) {
 	    a = &pcnet32_dwio;
 	} else
@@ -613,7 +625,21 @@
 	break;
      case 0x2625:
 	chipname = "PCnet/FAST III 79C973";
+	/* To prevent Tx FIFO underflows ... (may increase Tx latency) */
+	/* Set BCR18:NOUFLO to not start Tx until reach Tx start point */
+	/* Looks like EEPROM sets BCR18:5/6 for BurstWrite/Read */
+        a->write_bcr(ioaddr, 18, (a->read_bcr(ioaddr, 18) | 0x0800 | (3<<5) ));
+	/* Set CSR80:XMTSP, Tx start point = 20|64|128|220 bytes or size of frame */
+        i = a->read_csr(ioaddr, 80) & ~0x0C00; /* Clear bits we are touching */
+        a->write_csr(ioaddr, 80, i | (tx_start << 10));
 	fdx = 1; mii = 1;
+#ifdef DO_DXSUFLO
+	dxsuflo = 1;
+#endif
+	ltint = 1;
+	/* Try using the chip's internal SRAM for better performance */
+	a->write_bcr(ioaddr, 25, 20);
+	a->write_bcr(ioaddr, 26, 10 );
 	break;
      case 0x2626:
 	chipname = "PCnet/Home 79C978";
@@ -861,6 +887,8 @@
     if (pcnet32_init_ring(dev))
 	return -ENOMEM;
     
+    dma_cache_wback( &lp->init_block, sizeof(struct pcnet32_init_block) );
+
     /* Re-initialize the PCNET32, and start it when done. */
     lp->a.write_csr (ioaddr, 1, virt_to_bus(&lp->init_block) &0xffff);
     lp->a.write_csr (ioaddr, 2, virt_to_bus(&lp->init_block) >> 16);
@@ -955,6 +983,10 @@
 	lp->init_block.phys_addr[i] = dev->dev_addr[i];
     lp->init_block.rx_ring = (u32)le32_to_cpu(virt_to_bus(lp->rx_ring));
     lp->init_block.tx_ring = (u32)le32_to_cpu(virt_to_bus(lp->tx_ring));
+
+    dma_cache_wback(lp->rx_ring, RX_RING_SIZE * sizeof(struct pcnet32_rx_head));
+    dma_cache_wback(lp->tx_ring, TX_RING_SIZE * sizeof(struct pcnet32_tx_head));
+
     return 0;
 }
 
@@ -1002,12 +1034,14 @@
 	    printk(" Ring data dump: dirty_tx %d cur_tx %d%s cur_rx %d.",
 		   lp->dirty_tx, lp->cur_tx, lp->tx_full ? " (full)" : "",
 		   lp->cur_rx);
+	    printk("\nrx_ring:");
 	    for (i = 0 ; i < RX_RING_SIZE; i++)
-		printk("%s %08x %04x %08x %04x", i & 1 ? "" : "\n ",
+		printk("%s %08x %04x %08x %4.4x", i & 1 ? "" : "\n ",
 		       lp->rx_ring[i].base, -lp->rx_ring[i].buf_length,
 		       lp->rx_ring[i].msg_length, (unsigned)lp->rx_ring[i].status);
+	    printk("\ntx_ring:");
 	    for (i = 0 ; i < TX_RING_SIZE; i++)
-		printk("%s %08x %04x %08x %04x", i & 1 ? "" : "\n ",
+		printk("%s %08x %04x %08x %4.4x", i & 1 ? "" : "\n ",
 		       lp->tx_ring[i].base, -lp->tx_ring[i].length,
 		       lp->tx_ring[i].misc, (unsigned)lp->tx_ring[i].status);
 	    printk("\n");
@@ -1064,10 +1098,14 @@
 
     lp->tx_skbuff[entry] = skb;
     lp->tx_ring[entry].base = (u32)le32_to_cpu(virt_to_bus(skb->data));
+    dma_cache_wback((unsigned long)skb->data, skb->len);
+    dma_cache_wback((unsigned long)&lp->tx_ring[entry], sizeof(&lp->tx_ring[entry]));
 
     lp->tx_ring[entry].status = le16_to_cpu(status);
 
     lp->cur_tx++;
+    dma_cache_wback((unsigned long)&lp->tx_ring[entry].status, sizeof(&lp->tx_ring[entry].status));
+
     lp->stats.tx_bytes += skb->len;
 
     /* Trigger an immediate send poll. */
@@ -1128,7 +1166,11 @@
 
 	    while (dirty_tx < lp->cur_tx) {
 		int entry = dirty_tx & TX_RING_MOD_MASK;
-		int status = (short)le16_to_cpu(lp->tx_ring[entry].status);
+		int status;
+
+		dma_cache_wback_inv((unsigned long)&lp->tx_ring[entry].status, sizeof(&lp->tx_ring[entry].status));
+
+		status = (short)le16_to_cpu(lp->tx_ring[entry].status);
 			
 		if (status < 0)
 		    break;		/* It still hasn't been Txed */
@@ -1164,7 +1206,8 @@
 		    }
 #endif
 		} else {
-		    if (status & 0x1800)
+		    /* MORE and ONE are only valid if ENP is set */
+		    if (status & 0x0040 && status & 0x1800)
 			lp->stats.collisions++;
 		    lp->stats.tx_packets++;
 		}
@@ -1244,6 +1287,7 @@
     int i;
 
     /* If we own the next entry, it's a new packet. Send it up. */
+    dma_cache_inv((unsigned long)&lp->rx_ring[entry],sizeof(&lp->rx_ring[entry]));
     while ((short)le16_to_cpu(lp->rx_ring[entry].status) >= 0) {
 	int status = (short)le16_to_cpu(lp->rx_ring[entry].status) >> 8;
 
@@ -1303,6 +1347,7 @@
 		}
 		skb->dev = dev;
 		if (!rx_in_place) {
+		    dma_cache_inv(bus_to_virt(le32_to_cpu(lp->rx_ring[entry].base)), pkt_len);
 		    skb_reserve(skb,2);	/* 16 byte align */
 		    skb_put(skb,pkt_len);	/* Make room */
 		    eth_copy_and_sum(skb,
@@ -1320,8 +1365,11 @@
 	 * of QNX reports that some revs of the 79C965 clear it.
 	 */
 	lp->rx_ring[entry].buf_length = le16_to_cpu(-PKT_BUF_SZ);
+	dma_cache_wback((unsigned long)&lp->rx_ring[entry], sizeof(&lp->rx_ring[entry]));
 	lp->rx_ring[entry].status |= le16_to_cpu(0x8000);
+	dma_cache_wback((unsigned long)&lp->rx_ring[entry].status, sizeof(&lp->rx_ring[entry].status));
 	entry = (++lp->cur_rx) & RX_RING_MOD_MASK;
+	dma_cache_inv((unsigned long)&lp->rx_ring[entry], sizeof(&lp->rx_ring[entry]));
     }
 
     return 0;
@@ -1357,6 +1405,7 @@
     /* free all allocated skbuffs */
     for (i = 0; i < RX_RING_SIZE; i++) {
 	lp->rx_ring[i].status = 0;	    	    	    
+	dma_cache_wback((unsigned long)&lp->rx_ring[i].status, sizeof(&lp->rx_ring[i].status));
 	if (lp->rx_skbuff[i])
 	    dev_kfree_skb(lp->rx_skbuff[i]);
 	lp->rx_skbuff[i] = NULL;

--------------50B63F5B8B1C9550A01DD46B--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
