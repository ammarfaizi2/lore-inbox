Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287924AbSAMG0w>; Sun, 13 Jan 2002 01:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287927AbSAMG0e>; Sun, 13 Jan 2002 01:26:34 -0500
Received: from ohiper1-140.apex.net ([209.250.47.155]:32271 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S287924AbSAMG0V>; Sun, 13 Jan 2002 01:26:21 -0500
Date: Sun, 13 Jan 2002 00:26:10 -0600
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] (3/3) unchecked request_region's in drivers/net
Message-ID: <20020113002610.C26730@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 12:14am  up 4 days,  6:43,  1 user,  load average: 1.02, 1.03, 1.04
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, these are the many patches for drivers that have no maintainer.
Alan and Andrew caught a lot of bugs in these, and I think I fixed all
the problems they pointed out.  But, the more eyes the better.

Have fun
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns

--- linux/drivers/net/hamradio/baycom_ser_fdx.c~	Sat Jan 12 22:23:23 2002
+++ linux/drivers/net/hamradio/baycom_ser_fdx.c	Sat Jan 12 22:24:54 2002
@@ -417,21 +417,25 @@
 		return -ENXIO;
 	if (bc->baud < 300 || bc->baud > 4800)
 		return -EINVAL;
-	if (check_region(dev->base_addr, SER12_EXTENT))
+	if (!request_region(dev->base_addr, SER12_EXTENT,
+				"baycom_ser_fdx"))
 		return -EACCES;
 	memset(&bc->modem, 0, sizeof(bc->modem));
 	bc->hdrv.par.bitrate = bc->baud;
 	bc->baud_us = 1000000/bc->baud;
 	bc->baud_uartdiv = (115200/8)/bc->baud;
-	if ((u = ser12_check_uart(dev->base_addr)) == c_uart_unknown)
+	if ((u = ser12_check_uart(dev->base_addr)) == c_uart_unknown) {
+		release_region(dev->base_addr, SER12_EXTENT);
 		return -EIO;
+	}
 	outb(0, FCR(dev->base_addr));  /* disable FIFOs */
 	outb(0x0d, MCR(dev->base_addr));
 	outb(0, IER(dev->base_addr));
 	if (request_irq(dev->irq, ser12_interrupt, SA_INTERRUPT | SA_SHIRQ,
-			"baycom_ser_fdx", dev))
+			"baycom_ser_fdx", dev)) {
+		release_region(dev->base_addr, SER12_EXTENT);
 		return -EBUSY;
-	request_region(dev->base_addr, SER12_EXTENT, "baycom_ser_fdx");
+	}
 	/*
 	 * set the SIO to 6 Bits/character; during receive,
 	 * the baud rate is set to produce 100 ints/sec
--- linux/drivers/net/hamradio/baycom_ser_hdx.c~	Sat Jan 12 22:17:46 2002
+++ linux/drivers/net/hamradio/baycom_ser_hdx.c	Sat Jan 12 22:21:23 2002
@@ -476,19 +476,22 @@
 	if (!dev->base_addr || dev->base_addr > 0x1000-SER12_EXTENT ||
 	    dev->irq < 2 || dev->irq > 15)
 		return -ENXIO;
-	if (check_region(dev->base_addr, SER12_EXTENT))
+	if (!request_region(dev->base_addr, SER12_EXTENT, "baycom_ser12"))
 		return -EACCES;
 	memset(&bc->modem, 0, sizeof(bc->modem));
 	bc->hdrv.par.bitrate = 1200;
-	if ((u = ser12_check_uart(dev->base_addr)) == c_uart_unknown)
+	if ((u = ser12_check_uart(dev->base_addr)) == c_uart_unknown) {
+		release_region(dev->base_addr, SER12_EXTENT);
 		return -EIO;
+	}
 	outb(0, FCR(dev->base_addr));  /* disable FIFOs */
 	outb(0x0d, MCR(dev->base_addr));
 	outb(0, IER(dev->base_addr));
 	if (request_irq(dev->irq, ser12_interrupt, SA_INTERRUPT | SA_SHIRQ,
-			"baycom_ser12", dev))
+			"baycom_ser12", dev)) {
+		release_region(dev->base_addr, SER12_EXTENT);
 		return -EBUSY;
-	request_region(dev->base_addr, SER12_EXTENT, "baycom_ser12");
+	}
 	/*
 	 * enable transmitter empty interrupt
 	 */
--- linux/drivers/net/arcnet/com90xx.c~	Sat Jan 12 22:27:01 2002
+++ linux/drivers/net/arcnet/com90xx.c	Sat Jan 12 22:33:44 2002
@@ -479,8 +479,12 @@
 	dev->irq = airq;
 
 	/* reserve the I/O and memory regions - guaranteed to work by check_region */
-	request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (90xx)");
-	request_mem_region(dev->mem_start, dev->mem_end - dev->mem_start + 1, "arcnet (90xx)");
+	if (!request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (90xx)"))
+		goto err_region;
+
+	if (!request_mem_region(dev->mem_start, dev->mem_end -
+				dev->mem_start + 1, "arcnet (90xx)"))
+		goto err_mem;
 	dev->base_addr = ioaddr;
 
 	BUGMSG(D_NORMAL, "COM90xx station %02Xh found at %03lXh, IRQ %d, "
@@ -496,9 +500,11 @@
 	return 0;
 
       err_release:
-	free_irq(dev->irq, dev);
-	release_region(dev->base_addr, ARCNET_TOTAL_SIZE);
 	release_mem_region(dev->mem_start, dev->mem_end - dev->mem_start + 1);
+      err_mem:
+	release_region(dev->base_addr, ARCNET_TOTAL_SIZE);
+      err_region:
+	free_irq(dev->irq, dev);
       err_unmap:
 	iounmap(lp->mem_start);
       err_free_dev_priv:
diff -Nru clean-2.4.17//drivers/net/wan/comx-hw-comx.c linux/drivers/net/wan/comx-hw-comx.c
--- clean-2.4.17//drivers/net/wan/comx-hw-comx.c	Mon Nov  5 19:22:12 2001
+++ linux/drivers/net/wan/comx-hw-comx.c	Thu Dec 27 14:21:17 2001
@@ -466,16 +466,16 @@
 	}
 
 	if (!twin_open) {
-		if (check_region(dev->base_addr, hw->io_extent)) {
-			return -EAGAIN;
-		}
 		if (request_irq(dev->irq, COMX_interrupt, 0, dev->name, 
 		   (void *)dev)) {
 			printk(KERN_ERR "comx-hw-comx: unable to obtain irq %d\n", dev->irq);
 			return -EAGAIN;
 		}
+		if (!request_region(dev->base_addr, hw->io_extent, dev->name)) {
+			free_irq(dev->irq, dev);
+			return -EAGAIN;
+		}
 		ch->init_status |= IRQ_ALLOCATED;
-		request_region(dev->base_addr, hw->io_extent, dev->name);
 		if (!ch->HW_load_board || ch->HW_load_board(dev)) {
 			ch->init_status &= ~IRQ_ALLOCATED;
 			retval=-ENODEV;
--- linux/drivers/net/wan/cosa.c~	Sat Jan 12 22:38:21 2002
+++ linux/drivers/net/wan/cosa.c	Sat Jan 12 22:39:29 2002
@@ -547,13 +547,14 @@
 	cosa->usage = 0;
 	cosa->nchannels = 2;	/* FIXME: how to determine this? */
 
-	request_region(base, is_8bit(cosa)?2:4, cosa->type);
+	if (!request_region(base, is_8bit(cosa)?2:4, cosa->type))
+		goto bad2;
 	if (request_irq(cosa->irq, cosa_interrupt, 0, cosa->type, cosa))
 		goto bad1;
 	if (request_dma(cosa->dma, cosa->type)) {
 		free_irq(cosa->irq, cosa);
 bad1:		release_region(cosa->datareg,is_8bit(cosa)?2:4);
-		printk(KERN_NOTICE "cosa%d: allocating resources failed\n",
+bad2:		printk(KERN_NOTICE "cosa%d: allocating resources failed\n",
 			cosa->num);
 		return -1;
 	}
diff -Nru clean-2.4.17//drivers/net/de4x5.c linux/drivers/net/de4x5.c
--- clean-2.4.17//drivers/net/de4x5.c	Mon Nov  5 19:23:11 2001
+++ linux/drivers/net/de4x5.c	Thu Dec 27 13:34:03 2001
@@ -1296,9 +1296,10 @@
 
 	barrier();
 	    
-	request_region(iobase, (lp->bus == PCI ? DE4X5_PCI_TOTAL_SIZE :
+	if (!request_region(iobase, (lp->bus == PCI ? DE4X5_PCI_TOTAL_SIZE :
 				DE4X5_EISA_TOTAL_SIZE), 
-		       lp->adapter_name);
+		       lp->adapter_name))
+		return -EBUSY;
 	    
 	lp->rxRingSize = NUM_RX_DESC;
 	lp->txRingSize = NUM_TX_DESC;
diff -Nru clean-2.4.17//drivers/net/de600.c linux/drivers/net/de600.c
--- clean-2.4.17//drivers/net/de600.c	Mon Nov  5 19:23:11 2001
+++ linux/drivers/net/de600.c	Thu Dec 27 13:34:28 2001
@@ -689,7 +689,8 @@
 		return -EBUSY;
 	}
 #endif
-	request_region(DE600_IO, 3, "de600");
+	if (!request_region(DE600_IO, 3, "de600"))
+		return -EBUSY
 
 	printk(", Ethernet Address: %02X", dev->dev_addr[0]);
 	for (i = 1; i < ETH_ALEN; i++)
--- linux/drivers/net/ewrk3.c~	Sat Jan 12 23:50:12 2002
+++ linux/drivers/net/ewrk3.c	Sat Jan 12 23:55:49 2002
@@ -537,7 +537,10 @@
 								lp->mPage <<= 1;	/* 2 DRAMS on module */
 
 							sprintf(lp->adapter_name, "%s (%s)", name, dev->name);
-							request_region(iobase, EWRK3_TOTAL_SIZE, lp->adapter_name);
+							if (!request_region(iobase, EWRK3_TOTAL_SIZE, lp->adapter_name)) {
+								kfree(dev->priv);
+								return -EBUSY;
+							}
 
 							lp->irq_mask = ICR_TNEM | ICR_TXDM | ICR_RNEM | ICR_RXDM;
 
--- linux/drivers/net/gt96100eth.c~	Sat Jan 12 22:41:43 2002
+++ linux/drivers/net/gt96100eth.c	Sat Jan 12 22:44:03 2002
@@ -493,7 +493,8 @@
 		printk(KERN_INFO "gt96100_probe1: ioaddr 0x%lx, irq %d\n",
 		       ioaddr, irq);
 
-	request_region(ioaddr, GT96100_ETH_IO_SIZE, "GT96100ETH");
+	if (!request_region(ioaddr, GT96100_ETH_IO_SIZE, "GT96100ETH"))
+		goto free_netdev;
 
 	cpuConfig = GT96100_READ(GT96100_CPU_INTERF_CONFIG);
 	if (cpuConfig & (1 << 12)) {
@@ -621,6 +622,7 @@
 
       free_region:
 	release_region(ioaddr, gp->io_size);
+      free_netdev:
 	unregister_netdev(dev);
 	if (dev->priv != NULL)
 		kfree(dev->priv);
--- linux/drivers/net/isa-skeleton.c~	Sat Jan 12 22:47:11 2002
+++ linux/drivers/net/isa-skeleton.c	Sat Jan 12 22:54:08 2002
@@ -232,6 +232,7 @@
 	if (dev->dma == 0) {
 		if (request_dma(dev->dma, cardname)) {
 			printk("DMA %d allocation failed.\n", dev->dma);
+			release_irq(dev->irq, dev);
 			return -EAGAIN;
 		} else
 			printk(", assigned DMA %d.\n", dev->dma);
@@ -281,7 +282,12 @@
 	spin_lock_init(&np->lock);
 
 	/* Grab the region so that no one else tries to probe our ioports. */
-	request_region(ioaddr, NETCARD_IO_EXTENT, cardname);
+	if (!request_region(ioaddr, NETCARD_IO_EXTENT, cardname)) {
+		free_irq(dev->irq, dev);
+		free_dma(dev->dma);
+		kfree(dev->priv);
+		return -EBUSY;
+	}
 
 	dev->open		= net_open;
 	dev->stop		= net_close;
--- linux/drivers/net/wan/lmc/lmc_main.c~	Sat Jan 12 22:55:41 2002
+++ linux/drivers/net/wan/lmc/lmc_main.c	Sat Jan 12 23:03:47 2002
@@ -932,21 +932,15 @@
 
     printk ("%s: detected at %lx, irq %d\n", dev->name, ioaddr, dev->irq);
 
+    if (!request_region (ioaddr, LMC_REG_RANGE, dev->name)) {
+	printk (KERN_ERR "%s: request_region failed.\n", dev->name);
+	goto err_region;
+    }
     if (register_netdev (dev) != 0) {
         printk (KERN_ERR "%s: register_netdev failed.\n", dev->name);
-        lmc_proto_detach(sc);
-        kfree (dev->priv);
-        kfree (dev);
-        return NULL;
+	goto err_netdev;
     }
 
-    /*
-     * Request the region of registers we need, so that
-     * later on, no one else will take our card away from
-     * us.
-     */
-    request_region (ioaddr, LMC_REG_RANGE, dev->name);
-
     sc->lmc_cardtype = LMC_CARDTYPE_UNKNOWN;
     sc->lmc_timing = LMC_CTL_CLOCK_SOURCE_EXT;
 
@@ -1026,6 +1020,13 @@
     lmc_trace(dev, "lmc_probe1 out");
 
     return dev;
+err_netdev:
+    release_region(ioaddr, LMC_REG_RANGE);
+err_region:
+    lmc_proto_detach(sc);
+    kfree (dev->priv);
+    kfree (dev);
+    return NULL;
 }
 
 
--- linux/drivers/net/ni5010.c~	Sat Jan 12 23:08:01 2002
+++ linux/drivers/net/ni5010.c	Sat Jan 12 23:12:24 2002
@@ -308,7 +308,10 @@
 	memset(dev->priv, 0, sizeof(struct ni5010_local));
 
 	/* Grab the region so we can find another board if autoIRQ fails. */
-	request_region(ioaddr, NI5010_IO_EXTENT, boardname);
+	/* Yes, lots of leaks here, but what're ya gonna do? */
+	/* FIXME: figure out what needs to be freed here and free it */
+	if (!request_region(ioaddr, NI5010_IO_EXTENT, boardname))
+		return -EBUSY;
 	
 	dev->open		= ni5010_open;
 	dev->stop		= ni5010_close;
--- linux/drivers/net/ni65.c~	Sat Jan 12 23:14:13 2002
+++ linux/drivers/net/ni65.c	Sat Jan 12 23:21:37 2002
@@ -473,7 +473,11 @@
 	/*
 	 * Grab the region so we can find another board.
 	 */
-	request_region(ioaddr,cards[p->cardno].total_size,cards[p->cardno].cardname);
+	if (!request_region(ioaddr,cards[p->cardno].total_size,cards[p->cardno].cardname)) {
+		ni65_free_buffer(p);
+		free_dma(dev->dma);
+		return -EBUSY;
+	}
 
 	dev->base_addr = ioaddr;
 
--- linux/drivers/net/hamradio/scc.c~	Sat Jan 12 23:58:06 2002
+++ linux/drivers/net/hamradio/scc.c	Sun Jan 13 00:00:27 2002
@@ -1788,7 +1788,6 @@
 #ifndef SCC_DONT_CHECK
 			disable_irq(hwcfg.irq);
 
-			check_region(scc->ctrl, 1);
 			Outb(hwcfg.ctrl_a, 0);
 			OutReg(hwcfg.ctrl_a, R9, FHWRES);
 			udelay(100);
@@ -1842,8 +1841,12 @@
 
 				if (found)
 				{
-					request_region(SCC_Info[2*Nchips+chan].ctrl, 1, "scc ctrl");
-					request_region(SCC_Info[2*Nchips+chan].data, 1, "scc data");
+					if (!request_region(SCC_Info[2*Nchips+chan].ctrl, 1, "scc ctrl"))
+						continue;
+					if (!request_region(SCC_Info[2*Nchips+chan].data, 1, "scc data")) {
+						release_region(SCC_Info[2*Nchips+chan].ctrl, 1);
+						continue;
+					}
 					if (Nchips+chan != 0)
 						scc_net_setup(&SCC_Info[2*Nchips+chan], device_name, 1);
 				}
--- linux/drivers/net/hamradio/yam.c~	Sun Jan 13 00:04:37 2002
+++ linux/drivers/net/hamradio/yam.c	Sun Jan 13 00:04:41 2002
@@ -848,10 +848,6 @@
 		dev->irq < 2 || dev->irq > 15) {
 		return -ENXIO;
 	}
-	if (check_region(dev->base_addr, YAM_EXTENT)) {
-		printk(KERN_ERR "%s: cannot 0x%lx busy\n", dev->name, dev->base_addr);
-		return -EACCES;
-	}
 	if ((u = yam_check_uart(dev->base_addr)) == c_uart_unknown) {
 		printk(KERN_ERR "%s: cannot find uart type\n", dev->name);
 		return -EIO;
@@ -865,7 +861,11 @@
 		printk(KERN_ERR "%s: irq %d busy\n", dev->name, dev->irq);
 		return -EBUSY;
 	}
-	request_region(dev->base_addr, YAM_EXTENT, dev->name);
+	if (!request_region(dev->base_addr, YAM_EXTENT, dev->name)) {
+		printk(KERN_ERR "%s: cannot 0x%lx busy\n", dev->name, dev->base_addr);
+		free_irq(dev->irq, dev);
+		return -EBUSY;
+	}
 
 	yam_set_uart(dev);
 
