Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbUDRRyK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 13:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbUDRRyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 13:54:10 -0400
Received: from witte.sonytel.be ([80.88.33.193]:3063 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262273AbUDRRx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 13:53:58 -0400
Date: Sun, 18 Apr 2004 19:52:52 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH 437] Amiga eth%d
In-Reply-To: <407C164F.1090501@pobox.com>
Message-ID: <Pine.GSO.4.58.0404181952050.17347@waterleaf.sonytel.be>
References: <200404130838.i3D8cI26018497@callisto.of.borg> <407C164F.1090501@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2004, Jeff Garzik wrote:
> As a further change, can you please add KERN_xxx prefixes to those printk's?

Do these look OK?

To: akpm, linus, jeff
Cc: lkml
Subject: [PATCH] Amiga A2065 Ethernet KERN_*

Amiga A2065 Ethernet: Add KERN_* prefixes to printk() messages

--- linux-2.6.6-rc1/drivers/net/a2065.c	2004-04-16 13:38:47.000000000 +0200
+++ linux-m68k-2.6.6-rc1/drivers/net/a2065.c	2004-04-16 13:37:55.000000000 +0200
@@ -190,7 +190,7 @@
 	ib->phys_addr [5] = dev->dev_addr [4];

 	if (ZERO)
-		printk ("TX rings:\n");
+		printk(KERN_DEBUG "TX rings:\n");

 	/* Setup the Tx ring entries */
 	for (i = 0; i <= (1<<lp->lance_log_tx_bufs); i++) {
@@ -200,13 +200,13 @@
 		ib->btx_ring [i].tmd1_bits = 0;
 		ib->btx_ring [i].length    = 0xf000; /* The ones required by tmd2 */
 		ib->btx_ring [i].misc      = 0;
-		if (i < 3)
-			if (ZERO) printk ("%d: 0x%8.8x\n", i, leptr);
+		if (i < 3 && ZERO)
+			printk(KERN_DEBUG "%d: 0x%8.8x\n", i, leptr);
 	}

 	/* Setup the Rx ring entries */
 	if (ZERO)
-		printk ("RX rings:\n");
+		printk(KERN_DEBUG "RX rings:\n");
 	for (i = 0; i < (1<<lp->lance_log_rx_bufs); i++) {
 		leptr = LANCE_ADDR(&aib->rx_buf[i][0]);

@@ -216,7 +216,7 @@
 		ib->brx_ring [i].length    = -RX_BUFF_SIZE | 0xf000;
 		ib->brx_ring [i].mblength  = 0;
 		if (i < 3 && ZERO)
-			printk ("%d: 0x%8.8x\n", i, leptr);
+			printk(KERN_DEBUG "%d: 0x%8.8x\n", i, leptr);
 	}

 	/* Setup the initialization block */
@@ -226,14 +226,14 @@
 	ib->rx_len = (lp->lance_log_rx_bufs << 13) | (leptr >> 16);
 	ib->rx_ptr = leptr;
 	if (ZERO)
-		printk ("RX ptr: %8.8x\n", leptr);
+		printk(KERN_DEBUG "RX ptr: %8.8x\n", leptr);

 	/* Setup tx descriptor pointer */
 	leptr = LANCE_ADDR(&aib->btx_ring);
 	ib->tx_len = (lp->lance_log_tx_bufs << 13) | (leptr >> 16);
 	ib->tx_ptr = leptr;
 	if (ZERO)
-		printk ("TX ptr: %8.8x\n", leptr);
+		printk(KERN_DEBUG "TX ptr: %8.8x\n", leptr);

 	/* Clear the multicast filter */
 	ib->filter [0] = 0;
@@ -252,7 +252,8 @@
 	for (i = 0; (i < 100) && !(ll->rdp & (LE_C0_ERR | LE_C0_IDON)); i++)
 		barrier();
 	if ((i == 100) || (ll->rdp & LE_C0_ERR)) {
-		printk ("LANCE unopened after %d ticks, csr0=%4.4x.\n", i, ll->rdp);
+		printk(KERN_ERR "LANCE unopened after %d ticks, csr0=%4.4x.\n",
+		       i, ll->rdp);
 		return -EIO;
 	}

@@ -275,7 +276,7 @@

 #ifdef TEST_HITS
 	int i;
-	printk ("[");
+	printk(KERN_DEBUG "[");
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		if (i == lp->rx_new)
 			printk ("%s",
@@ -284,7 +285,7 @@
 			printk ("%s",
 				ib->brx_ring [i].rmd1_bits & LE_R1_OWN ? "." : "1");
 	}
-	printk ("]");
+	printk ("]\n");
 #endif

 	ll->rdp = LE_C0_RINT|LE_C0_INEA;
@@ -311,8 +312,8 @@
 			skb = dev_alloc_skb (len+2);

 			if (skb == 0) {
-				printk ("%s: Memory squeeze, deferring packet.\n",
-					dev->name);
+				printk(KERN_WARNING "%s: Memory squeeze, "
+				       "deferring packet.\n", dev->name);
 				lp->stats.rx_dropped++;
 				rd->mblength = 0;
 				rd->rmd1_bits = LE_R1_OWN;
@@ -373,8 +374,9 @@
 				lp->stats.tx_carrier_errors++;
 				if (lp->auto_select) {
 					lp->tpe = 1 - lp->tpe;
-					printk("%s: Carrier Lost, trying %s\n",
-					       dev->name, lp->tpe?"TPE":"AUI");
+					printk(KERN_ERR "%s: Carrier Lost, "
+					       "trying %s\n", dev->name,
+					       lp->tpe?"TPE":"AUI");
 					/* Stop the lance */
 					ll->rap = LE_CSR0;
 					ll->rdp = LE_C0_STOP;
@@ -390,8 +392,8 @@
 			if (status & (LE_T3_BUF|LE_T3_UFL)) {
 				lp->stats.tx_fifo_errors++;

-				printk ("%s: Tx: ERR_BUF|ERR_UFL, restarting\n",
-					dev->name);
+				printk(KERN_ERR "%s: Tx: ERR_BUF|ERR_UFL, "
+				       "restarting\n", dev->name);
 				/* Stop the lance */
 				ll->rap = LE_CSR0;
 				ll->rdp = LE_C0_STOP;
@@ -464,7 +466,8 @@
 	if (csr0 & LE_C0_MISS)
 		lp->stats.rx_errors++;       /* Missed a Rx frame. */
 	if (csr0 & LE_C0_MERR) {
-		printk("%s: Bus master arbitration failure, status %4.4x.\n", dev->name, csr0);
+		printk(KERN_ERR "%s: Bus master arbitration failure, status "
+		       "%4.4x.\n", dev->name, csr0);
 		/* Restart the chip. */
 		ll->rdp = LE_C0_STRT;
 	}
@@ -539,7 +542,7 @@

 	status = init_restart_lance (lp);
 #ifdef DEBUG_DRIVER
-	printk ("Lance restart=%d\n", status);
+	printk(KERN_DEBUG "Lance restart=%d\n", status);
 #endif
 	return status;
 }
@@ -589,9 +592,10 @@

 		for (i = 0; i < 64; i++) {
 			if ((i % 16) == 0)
-				printk ("\n");
+				printk("\n" KERN_DEBUG);
 			printk ("%2.2x ", skb->data [i]);
 		}
+		printk("\n");
 	}
 #endif
 	entry = lp->tx_new & lp->tx_ring_mod_mask;
@@ -803,7 +807,7 @@
 	}
 	zorro_set_drvdata(z, dev);

-	printk("%s: A2065 at 0x%08lx, Ethernet Address "
+	printk(KERN_INFO "%s: A2065 at 0x%08lx, Ethernet Address "
 	       "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name, board,
 	       dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
 	       dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
