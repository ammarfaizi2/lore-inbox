Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbSL0QDz>; Fri, 27 Dec 2002 11:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbSL0QDy>; Fri, 27 Dec 2002 11:03:54 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:61712 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id <S265063AbSL0QDf>; Fri, 27 Dec 2002 11:03:35 -0500
Date: Fri, 27 Dec 2002 17:11:12 +0100
Message-Id: <200212271611.gBRGBCag008041@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k net local_irq*() updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert m68k net drivers to new local_irq*() framework:
  - Amiga A2065 and Ariadne Ethernet
  - Atari Bionet-100 and Pamsnet ACSI Ethernet
  - Atari LANCE Ethernet
  - Mac NC8390, CS89x0, MACE, and Sonic Ethernet
  - Sun-3 i82586 and Sun-3/3x LANCE Ethernet

--- linux-2.5.53/drivers/net/a2065.c	Wed Aug 28 08:33:23 2002
+++ linux-m68k-2.5.53/drivers/net/a2065.c	Thu Nov  7 23:08:48 2002
@@ -573,11 +573,10 @@
 
 	skblen = skb->len;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	if (!TX_BUFFS_AVAIL){
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return -1;
 	}
 
@@ -618,7 +617,7 @@
 	dev->trans_start = jiffies;
 	dev_kfree_skb (skb);
     
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return status;
 }
--- linux-2.5.53/drivers/net/atari_pamsnet.c	Wed Aug 28 08:33:23 2002
+++ linux-m68k-2.5.53/drivers/net/atari_pamsnet.c	Thu Nov  7 23:09:07 2002
@@ -702,11 +702,10 @@
 	/* Block a timer-based transmit from overlapping.  This could better be
 	 * done with atomic_swap(1, dev->tbusy), but set_bit() works as well.
 	 */
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	if (stdma_islocked()) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		lp->stats.tx_errors++;
 	}
 	else {
@@ -717,7 +716,7 @@
 		stdma_lock(pamsnet_intr, NULL);
 		DISABLE_IRQ();
 
-		restore_flags(flags);
+		local_irq_restore(flags);
 		if( !STRAM_ADDR(buf+length-1) ) {
 			memcpy(nic_packet->buffer, skb->data, length);
 			buf = (unsigned long)phys_nic_packet;
@@ -749,20 +748,19 @@
 	struct sk_buff *skb;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	/* ++roman: Take care at locking the ST-DMA... This must be done with ints
 	 * off, since otherwise an int could slip in between the question and the
 	 * locking itself, and then we'd go to sleep... And locking itself is
 	 * necessary to keep the floppy_change timer from working with ST-DMA
 	 * registers. */
 	if (stdma_islocked()) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return;
 	}
 	stdma_lock(pamsnet_intr, NULL);
 	DISABLE_IRQ();
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	boguscount = testpkt(lance_target);
 	if( lp->poll_time < MAX_POLL_TIME ) lp->poll_time++;
--- linux-2.5.53/drivers/net/mac8390.c	Sun Oct 13 10:58:07 2002
+++ linux-m68k-2.5.53/drivers/net/mac8390.c	Thu Nov  7 23:09:13 2002
@@ -195,7 +195,7 @@
 	unsigned long flags;
 	int i, j;
 	
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	/* Check up to 32K in 4K increments */
 	for (i = 0; i < 8; i++) {
 		volatile unsigned short *m = (unsigned short *) (membase + (i * 0x1000));
@@ -218,7 +218,7 @@
 				break;
  		}
  	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 	/* in any case, we stopped once we tried one block too many,
            or once we reached 32K */
  	return i * 0x1000;
--- linux-2.5.53/drivers/net/macsonic.c	Wed Aug 28 08:33:26 2002
+++ linux-m68k-2.5.53/drivers/net/macsonic.c	Thu Nov  7 23:09:33 2002
@@ -333,10 +333,9 @@
 		unsigned long flags;
 		int card_present;
 
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		card_present = hwreg_present((void*)ONBOARD_SONIC_REGISTERS);
-		restore_flags(flags);
+		local_irq_restore(flags);
 
 		if (!card_present) {
 			printk("none.\n");
--- linux-2.5.53/drivers/net/sun3lance.c	Wed Aug 28 09:01:42 2002
+++ linux-m68k-2.5.53/drivers/net/sun3lance.c	Thu Nov  7 23:18:09 2002
@@ -578,7 +578,7 @@
 #endif	
 	/* We're not prepared for the int until the last flags are set/reset.
 	 * And the int may happen already after setting the OWN_CHIP... */
-	save_and_cli(flags);
+	local_irq_save(flags);
 
 	/* Mask to ring buffer boundary. */
 	entry = lp->new_tx;
@@ -614,7 +614,7 @@
 	    TMD1_OWN_HOST) 
 		netif_start_queue(dev);
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return 0;
 }
--- linux-2.5.53/drivers/net/ariadne.c	Wed Aug 28 08:33:23 2002
+++ linux-m68k-2.5.53/drivers/net/ariadne.c	Thu Nov  7 23:09:43 2002
@@ -606,8 +606,7 @@
     printk(" data 0x%08x len %d\n", (int)skb->data, (int)skb->len);
 #endif
 
-    save_flags(flags);
-    cli();
+    local_irq_save(flags);
 
     entry = priv->cur_tx % TX_RING_SIZE;
 
@@ -664,7 +663,7 @@
 	netif_stop_queue(dev);
 	priv->tx_full = 1;
     }
-    restore_flags(flags);
+    local_irq_restore(flags);
 
     return 0;
 }
@@ -767,13 +766,12 @@
     short saved_addr;
     unsigned long flags;
 
-    save_flags(flags);
-    cli();
+    local_irq_save(flags);
     saved_addr = lance->RAP;
     lance->RAP = CSR112;		/* Missed Frame Count */
     priv->stats.rx_missed_errors = swapw(lance->RDP);
     lance->RAP = saved_addr;
-    restore_flags(flags);
+    local_irq_restore(flags);
 
     return &priv->stats;
 }
--- linux-2.5.53/drivers/net/atari_bionet.c	Mon Nov 11 10:19:22 2002
+++ linux-m68k-2.5.53/drivers/net/atari_bionet.c	Mon Nov 11 11:13:33 2002
@@ -235,8 +235,7 @@
 	unsigned long flags;
 
 	DISABLE_IRQ();
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	dma_wd.dma_mode_status		= 0x9a;
 	dma_wd.dma_mode_status		= 0x19a;
@@ -247,7 +246,7 @@
 	dma_wd.dma_md			= (unsigned char)paddr;
 	paddr >>= 8;
 	dma_wd.dma_hi			= (unsigned char)paddr;
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	c = sendcmd(0,0x00,NODE_ADR | C_READ);	/* CMD: READ */
 	if( c < 128 ) goto rend;
@@ -284,8 +283,7 @@
 	unsigned long flags;
 
 	DISABLE_IRQ();
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	dma_wd.dma_mode_status	= 0x19a;
 	dma_wd.dma_mode_status	= 0x9a;
@@ -297,7 +295,7 @@
 	dma_wd.dma_hi		= (unsigned char)paddr;
 
 	dma_wd.fdc_acces_seccount	= 0x4;		/* sector count */
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	c = sendcmd(0,0x100,NODE_ADR | C_WRITE);	/* CMD: WRITE */
 	c = sendcmd(1,0x100,cnt&0xff);
@@ -438,11 +436,10 @@
 	/* Block a timer-based transmit from overlapping.  This could better be
 	 * done with atomic_swap(1, dev->tbusy), but set_bit() works as well.
 	 */
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	if (stdma_islocked()) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		lp->stats.tx_errors++;
 	}
 	else {
@@ -451,7 +448,7 @@
 		int stat;
 
 		stdma_lock(bionet_intr, NULL);
-		restore_flags(flags);
+		local_irq_restore(flags);
 		if( !STRAM_ADDR(buf+length-1) ) {
 			memcpy(nic_packet->buffer, skb->data, length);
 			buf = (unsigned long)&((struct nic_pkt_s *)phys_nic_packet)->buffer;
@@ -504,20 +501,19 @@
 	int pkt_len, status;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	/* ++roman: Take care at locking the ST-DMA... This must be done with ints
 	 * off, since otherwise an int could slip in between the question and the
 	 * locking itself, and then we'd go to sleep... And locking itself is
 	 * necessary to keep the floppy_change timer from working with ST-DMA
 	 * registers. */
 	if (stdma_islocked()) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return;
 	}
 	stdma_lock(bionet_intr, NULL);
 	DISABLE_IRQ();
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	if( lp->poll_time < MAX_POLL_TIME ) lp->poll_time++;
 
--- linux-2.5.53/drivers/net/atarilance.c	Wed Aug 28 08:33:24 2002
+++ linux-m68k-2.5.53/drivers/net/atarilance.c	Thu Nov  7 23:09:10 2002
@@ -405,8 +405,7 @@
 	long	flags;
 	long	*vbr, save_berr;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	__asm__ __volatile__ ( "movec	%/vbr,%0" : "=r" (vbr) : );
 	save_berr = vbr[2];
@@ -443,7 +442,7 @@
 	);
 
 	vbr[2] = save_berr;
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return( ret );
 }
--- linux-2.5.53/drivers/net/mac89x0.c	Wed Aug 28 08:33:26 2002
+++ linux-m68k-2.5.53/drivers/net/mac89x0.c	Thu Nov  7 23:09:19 2002
@@ -52,7 +52,8 @@
   Arnaldo Carvalho de Melo <acme@conectiva.com.br> - 11/01/2001
   check kmalloc and release the allocated memory on failure in
   mac89x0_probe and in init_module
-  use save_flags/restore_flags in net_get_stat, not just cli/sti
+  use local_irq_{save,restore}(flags) in net_get_stat, not just
+  local_irq_{dis,en}able()
 */
 
 static char *version =
@@ -199,11 +200,10 @@
 		unsigned long flags;
 		int card_present;
 		
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		card_present = hwreg_present((void*) ioaddr+4)
 		  && hwreg_present((void*) ioaddr + DATA_PORT);
-		restore_flags(flags);
+		local_irq_restore(flags);
 
 		if (!card_present)
 			return -ENODEV;
@@ -397,8 +397,7 @@
 		/* keep the upload from being interrupted, since we
                    ask the chip to start transmitting before the
                    whole packet has been completely uploaded. */
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 
 		/* initiate a transmit sequence */
 		writereg(dev, PP_TxCMD, lp->send_cmd);
@@ -408,14 +407,14 @@
 		if ((readreg(dev, PP_BusST) & READY_FOR_TX_NOW) == 0) {
 			/* Gasp!  It hasn't.  But that shouldn't happen since
 			   we're waiting for TxOk, so return 1 and requeue this packet. */
-			restore_flags(flags);
+			local_irq_restore(flags);
 			return 1;
 		}
 
 		/* Write the contents of the packet */
 		memcpy_toio(dev->mem_start + PP_TxFrame, skb->data, skb->len+1);
 
-		restore_flags(flags);
+		local_irq_restore(flags);
 		dev->trans_start = jiffies;
 	}
 	dev_kfree_skb (skb);
@@ -568,12 +567,11 @@
 	struct net_local *lp = (struct net_local *)dev->priv;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	/* Update the statistics from the device registers. */
 	lp->stats.rx_missed_errors += (readreg(dev, PP_RxMiss) >> 6);
 	lp->stats.collisions += (readreg(dev, PP_TxCol) >> 6);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return &lp->stats;
 }
--- linux-2.5.53/drivers/net/macmace.c	Tue Jun 25 20:50:37 2002
+++ linux-m68k-2.5.53/drivers/net/macmace.c	Thu Nov  7 23:09:29 2002
@@ -256,8 +256,7 @@
 	unsigned long flags;
 	u8 maccc;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	maccc = mb->maccc;
 
@@ -270,7 +269,7 @@
 	}
 
 	mb->maccc = maccc;
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return 0;
 }
--- linux-2.5.53/drivers/net/sun3_82586.c	Sun Apr  7 10:56:19 2002
+++ linux-m68k-2.5.53/drivers/net/sun3_82586.c	Thu Nov  7 23:09:36 2002
@@ -1078,12 +1078,11 @@
 
 		{
 			unsigned long flags;
-			save_flags(flags);
-			cli();
+			local_irq_save(flags);
 			if(p->xmit_count != p->xmit_last)
 				netif_wake_queue(dev);
 			p->lock = 0;
-			restore_flags(flags);
+			local_irq_restore(flags);
 		}
 		dev_kfree_skb(skb);
 #endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
