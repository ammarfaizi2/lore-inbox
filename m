Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287872AbSAMAgh>; Sat, 12 Jan 2002 19:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287875AbSAMAgS>; Sat, 12 Jan 2002 19:36:18 -0500
Received: from [209.250.53.140] ([209.250.53.140]:63757 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S287872AbSAMAf6>; Sat, 12 Jan 2002 19:35:58 -0500
Date: Sat, 12 Jan 2002 18:35:42 -0600
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] unchecked request_region's in drivers/net
Message-ID: <20020112183542.A5557@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 6:32pm  up 4 days,  1:02,  2 users,  load average: 1.10, 1.18, 1.09
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested, I have submitted each patch to its respective maintainer.
Those patches below are those who either didn't respond, or okayed the
patch for inclusion.

Any objection to this being merged in both 2.4 and 2.5?
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns

diff -Nru clean-2.4.17//drivers/net/irda/ali-ircc.c linux/drivers/net/irda/ali-ircc.c
--- clean-2.4.17//drivers/net/irda/ali-ircc.c	Mon Nov  5 19:23:13 2001
+++ linux/drivers/net/irda/ali-ircc.c	Thu Dec 27 14:08:34 2001
@@ -291,15 +291,13 @@
         self->io.fifo_size = 16;		/* SIR: 16, FIR: 32 Benjamin 2000/11/1 */
 	
 	/* Reserve the ioports that we need */
-	ret = check_region(self->io.fir_base, self->io.fir_ext);
-	if (ret < 0) { 
+	if (!request_region(self->io.fir_base, self->io.fir_ext, driver_name)) {
 		WARNING(__FUNCTION__ "(), can't get iobase of 0x%03x\n",
 			self->io.fir_base);
 		dev_self[i] = NULL;
 		kfree(self);
 		return -ENODEV;
 	}
-	request_region(self->io.fir_base, self->io.fir_ext, driver_name);
 
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&self->qos);
diff -Nru clean-2.4.17//drivers/net/hamradio/baycom_ser_fdx.c linux/drivers/net/hamradio/baycom_ser_fdx.c
--- clean-2.4.17//drivers/net/hamradio/baycom_ser_fdx.c	Thu Aug 16 15:50:30 2001
+++ linux/drivers/net/hamradio/baycom_ser_fdx.c	Thu Dec 27 13:58:40 2001
@@ -417,7 +417,8 @@
 		return -ENXIO;
 	if (bc->baud < 300 || bc->baud > 4800)
 		return -EINVAL;
-	if (check_region(dev->base_addr, SER12_EXTENT))
+	if (!request_region(dev->base_addr, SER12_EXTENT,
+				"baycom_ser_fdx"))
 		return -EACCES;
 	memset(&bc->modem, 0, sizeof(bc->modem));
 	bc->hdrv.par.bitrate = bc->baud;
@@ -431,7 +432,6 @@
 	if (request_irq(dev->irq, ser12_interrupt, SA_INTERRUPT | SA_SHIRQ,
 			"baycom_ser_fdx", dev))
 		return -EBUSY;
-	request_region(dev->base_addr, SER12_EXTENT, "baycom_ser_fdx");
 	/*
 	 * set the SIO to 6 Bits/character; during receive,
 	 * the baud rate is set to produce 100 ints/sec
diff -Nru clean-2.4.17//drivers/net/hamradio/baycom_ser_hdx.c linux/drivers/net/hamradio/baycom_ser_hdx.c
--- clean-2.4.17//drivers/net/hamradio/baycom_ser_hdx.c	Thu Aug 16 15:50:30 2001
+++ linux/drivers/net/hamradio/baycom_ser_hdx.c	Thu Dec 27 13:58:08 2001
@@ -476,7 +476,7 @@
 	if (!dev->base_addr || dev->base_addr > 0x1000-SER12_EXTENT ||
 	    dev->irq < 2 || dev->irq > 15)
 		return -ENXIO;
-	if (check_region(dev->base_addr, SER12_EXTENT))
+	if (!request_region(dev->base_addr, SER12_EXTENT, "baycom_ser12"))
 		return -EACCES;
 	memset(&bc->modem, 0, sizeof(bc->modem));
 	bc->hdrv.par.bitrate = 1200;
@@ -488,7 +488,6 @@
 	if (request_irq(dev->irq, ser12_interrupt, SA_INTERRUPT | SA_SHIRQ,
 			"baycom_ser12", dev))
 		return -EBUSY;
-	request_region(dev->base_addr, SER12_EXTENT, "baycom_ser12");
 	/*
 	 * enable transmitter empty interrupt
 	 */
diff -Nru clean-2.4.17//drivers/net/arcnet/com90xx.c linux/drivers/net/arcnet/com90xx.c
--- clean-2.4.17//drivers/net/arcnet/com90xx.c	Mon Nov  5 19:24:25 2001
+++ linux/drivers/net/arcnet/com90xx.c	Thu Dec 27 13:32:25 2001
@@ -479,7 +479,9 @@
 	dev->irq = airq;
 
 	/* reserve the I/O and memory regions - guaranteed to work by check_region */
-	request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (90xx)");
+	if (!request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (90xx)"))
+		goto err_release;
+
 	request_mem_region(dev->mem_start, dev->mem_end - dev->mem_start + 1, "arcnet (90xx)");
 	dev->base_addr = ioaddr;
 
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
diff -Nru clean-2.4.17//drivers/net/wan/comx-hw-locomx.c linux/drivers/net/wan/comx-hw-locomx.c
--- clean-2.4.17//drivers/net/wan/comx-hw-locomx.c	Mon Nov  5 19:22:12 2001
+++ linux/drivers/net/wan/comx-hw-locomx.c	Thu Dec 27 14:20:11 2001
@@ -154,11 +154,9 @@
 		return -ENODEV;
 	}
 
-	if (check_region(dev->base_addr, hw->io_extent)) {
+	if (!request_region(dev->base_addr, hw->io_extent, dev->name)) {
 		return -EAGAIN;
 	}
-
-	request_region(dev->base_addr, hw->io_extent, dev->name);
 
 	hw->board.chanA.ctrlio=dev->base_addr + 5;
 	hw->board.chanA.dataio=dev->base_addr + 7;
diff -Nru clean-2.4.17//drivers/net/wan/cosa.c linux/drivers/net/wan/cosa.c
--- clean-2.4.17//drivers/net/wan/cosa.c	Mon Nov  5 19:22:12 2001
+++ linux/drivers/net/wan/cosa.c	Thu Dec 27 14:16:43 2001
@@ -547,7 +547,8 @@
 	cosa->usage = 0;
 	cosa->nchannels = 2;	/* FIXME: how to determine this? */
 
-	request_region(base, is_8bit(cosa)?2:4, cosa->type);
+	if (!request_region(base, is_8bit(cosa)?2:4, cosa->type))
+		goto bad1;
 	if (request_irq(cosa->irq, cosa_interrupt, 0, cosa->type, cosa))
 		goto bad1;
 	if (request_dma(cosa->dma, cosa->type)) {
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
diff -Nru clean-2.4.17//drivers/net/ewrk3.c linux/drivers/net/ewrk3.c
--- clean-2.4.17//drivers/net/ewrk3.c	Mon Nov  5 19:23:12 2001
+++ linux/drivers/net/ewrk3.c	Thu Dec 27 13:40:31 2001
@@ -537,7 +537,6 @@
 								lp->mPage <<= 1;	/* 2 DRAMS on module */
 
 							sprintf(lp->adapter_name, "%s (%s)", name, dev->name);
-							request_region(iobase, EWRK3_TOTAL_SIZE, lp->adapter_name);
 
 							lp->irq_mask = ICR_TNEM | ICR_TXDM | ICR_RNEM | ICR_RXDM;
 
@@ -1271,7 +1270,7 @@
 	}
 
 	for (; (i < maxSlots) && (dev != NULL); iobase += EWRK3_IOP_INC, i++) {
-		if (!check_region(iobase, EWRK3_TOTAL_SIZE)) {
+		if (request_region(iobase, EWRK3_TOTAL_SIZE, dev->name)) {
 			if (DevicePresent(iobase) == 0) {
 				if ((dev = alloc_device(dev, iobase)) != NULL) {
 					if (ewrk3_hw_init(dev, iobase) == 0) {
@@ -1315,7 +1314,7 @@
 
 	for (i = 1; (i < maxSlots) && (dev != NULL); i++, iobase += EISA_SLOT_INC) {
 		if (EISA_signature(name, EISA_ID) == 0) {
-			if (!check_region(iobase, EWRK3_TOTAL_SIZE)) {
+			if (request_region(iobase, EWRK3_TOTAL_SIZE, dev->name)) {
 				if (DevicePresent(iobase) == 0) {
 					if ((dev = alloc_device(dev, iobase)) != NULL) {
 						if (ewrk3_hw_init(dev, iobase) == 0) {
diff -Nru clean-2.4.17//drivers/net/gt96100eth.c linux/drivers/net/gt96100eth.c
--- clean-2.4.17//drivers/net/gt96100eth.c	Mon Nov  5 19:24:01 2001
+++ linux/drivers/net/gt96100eth.c	Thu Dec 27 13:55:39 2001
@@ -493,7 +493,8 @@
 		printk(KERN_INFO "gt96100_probe1: ioaddr 0x%lx, irq %d\n",
 		       ioaddr, irq);
 
-	request_region(ioaddr, GT96100_ETH_IO_SIZE, "GT96100ETH");
+	if (!request_region(ioaddr, GT96100_ETH_IO_SIZE, "GT96100ETH"))
+		return -EBUSY;
 
 	cpuConfig = GT96100_READ(GT96100_CPU_INTERF_CONFIG);
 	if (cpuConfig & (1 << 12)) {
diff -Nru clean-2.4.17//drivers/net/irda/irport.c linux/drivers/net/irda/irport.c
--- clean-2.4.17//drivers/net/irda/irport.c	Mon Nov  5 19:23:13 2001
+++ linux/drivers/net/irda/irport.c	Thu Dec 27 14:06:16 2001
@@ -169,13 +169,11 @@
         self->io.fifo_size = 16;
 
 	/* Lock the port that we need */
-	ret = check_region(self->io.sir_base, self->io.sir_ext);
-	if (ret < 0) { 
+	if (!request_region(self->io.sir_base, self->io.sir_ext, driver_name)) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), can't get iobase of 0x%03x\n",
 			   self->io.sir_base);
 		return NULL;
 	}
-	request_region(self->io.sir_base, self->io.sir_ext, driver_name);
 
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&self->qos);
diff -Nru clean-2.4.17//drivers/net/isa-skeleton.c linux/drivers/net/isa-skeleton.c
--- clean-2.4.17//drivers/net/isa-skeleton.c	Mon Nov  5 19:24:01 2001
+++ linux/drivers/net/isa-skeleton.c	Thu Dec 27 14:09:17 2001
@@ -281,7 +281,8 @@
 	spin_lock_init(&np->lock);
 
 	/* Grab the region so that no one else tries to probe our ioports. */
-	request_region(ioaddr, NETCARD_IO_EXTENT, cardname);
+	if (!request_region(ioaddr, NETCARD_IO_EXTENT, cardname))
+		return -EBUSY;
 
 	dev->open		= net_open;
 	dev->stop		= net_close;
diff -Nru clean-2.4.17//drivers/net/wan/lmc/lmc_main.c linux/drivers/net/wan/lmc/lmc_main.c
--- clean-2.4.17//drivers/net/wan/lmc/lmc_main.c	Mon Nov  5 19:22:13 2001
+++ linux/drivers/net/wan/lmc/lmc_main.c	Thu Dec 27 14:22:37 2001
@@ -945,7 +945,13 @@
      * later on, no one else will take our card away from
      * us.
      */
-    request_region (ioaddr, LMC_REG_RANGE, dev->name);
+    if (!request_region (ioaddr, LMC_REG_RANGE, dev->name)) {
+	    printk(KERN_ERR "%s: request_region failed.\n", dev->name);
+	    lmc_proto_detach(sc);
+	    kfree(dev->priv);
+	    kfree(dev);
+	    return NULL;
+    }
 
     sc->lmc_cardtype = LMC_CARDTYPE_UNKNOWN;
     sc->lmc_timing = LMC_CTL_CLOCK_SOURCE_EXT;
diff -Nru clean-2.4.17//drivers/net/ni5010.c linux/drivers/net/ni5010.c
--- clean-2.4.17//drivers/net/ni5010.c	Mon Nov  5 19:23:13 2001
+++ linux/drivers/net/ni5010.c	Thu Dec 27 14:10:35 2001
@@ -308,7 +308,8 @@
 	memset(dev->priv, 0, sizeof(struct ni5010_local));
 
 	/* Grab the region so we can find another board if autoIRQ fails. */
-	request_region(ioaddr, NI5010_IO_EXTENT, boardname);
+	if (!request_region(ioaddr, NI5010_IO_EXTENT, boardname))
+		return -EBUSY;
 	
 	dev->open		= ni5010_open;
 	dev->stop		= ni5010_close;
diff -Nru clean-2.4.17//drivers/net/ni65.c linux/drivers/net/ni65.c
--- clean-2.4.17//drivers/net/ni65.c	Mon Nov  5 19:23:13 2001
+++ linux/drivers/net/ni65.c	Thu Dec 27 14:11:21 2001
@@ -473,7 +473,8 @@
 	/*
 	 * Grab the region so we can find another board.
 	 */
-	request_region(ioaddr,cards[p->cardno].total_size,cards[p->cardno].cardname);
+	if (!request_region(ioaddr,cards[p->cardno].total_size,cards[p->cardno].cardname))
+		return -EBUSY;
 
 	dev->base_addr = ioaddr;
 
diff -Nru clean-2.4.17//drivers/net/irda/nsc-ircc.c linux/drivers/net/irda/nsc-ircc.c
--- clean-2.4.17//drivers/net/irda/nsc-ircc.c	Mon Nov  5 19:23:13 2001
+++ linux/drivers/net/irda/nsc-ircc.c	Thu Dec 27 14:08:03 2001
@@ -282,15 +282,13 @@
         self->io.fifo_size = 32;
 	
 	/* Reserve the ioports that we need */
-	ret = check_region(self->io.fir_base, self->io.fir_ext);
-	if (ret < 0) { 
+	if (!request_region(self->io.fir_base, self->io.fir_ext, driver_name)) {
 		WARNING(__FUNCTION__ "(), can't get iobase of 0x%03x\n",
 			self->io.fir_base);
 		dev_self[i] = NULL;
 		kfree(self);
 		return -ENODEV;
 	}
-	request_region(self->io.fir_base, self->io.fir_ext, driver_name);
 
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&self->qos);
diff -Nru clean-2.4.17//drivers/net/hamradio/scc.c linux/drivers/net/hamradio/scc.c
--- clean-2.4.17//drivers/net/hamradio/scc.c	Mon Nov  5 19:24:25 2001
+++ linux/drivers/net/hamradio/scc.c	Thu Dec 27 14:00:34 2001
@@ -1788,7 +1788,6 @@
 #ifndef SCC_DONT_CHECK
 			disable_irq(hwcfg.irq);
 
-			check_region(scc->ctrl, 1);
 			Outb(hwcfg.ctrl_a, 0);
 			OutReg(hwcfg.ctrl_a, R9, FHWRES);
 			udelay(100);
@@ -1842,8 +1841,9 @@
 
 				if (found)
 				{
-					request_region(SCC_Info[2*Nchips+chan].ctrl, 1, "scc ctrl");
-					request_region(SCC_Info[2*Nchips+chan].data, 1, "scc data");
+					if (!request_region(SCC_Info[2*Nchips+chan].ctrl, 1, "scc ctrl") ||
+					!request_region(SCC_Info[2*Nchips+chan].data, 1, "scc data"))
+						continue;
 					if (Nchips+chan != 0)
 						scc_net_setup(&SCC_Info[2*Nchips+chan], device_name, 1);
 				}
diff -Nru clean-2.4.17//drivers/net/irda/w83977af_ir.c linux/drivers/net/irda/w83977af_ir.c
--- clean-2.4.17//drivers/net/irda/w83977af_ir.c	Mon Nov  5 19:23:13 2001
+++ linux/drivers/net/irda/w83977af_ir.c	Thu Dec 27 14:07:23 2001
@@ -190,14 +190,12 @@
         self->io.fifo_size = 32;
 
 	/* Lock the port that we need */
-	ret = check_region(self->io.fir_base, self->io.fir_ext);
-	if (ret < 0) { 
+	if (!request_region(self->io.fir_base, self->io.fir_ext, driver_name)) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), can't get iobase of 0x%03x\n",
 		      self->io.fir_base);
 		/* w83977af_cleanup( self);  */
 		return -ENODEV;
 	}
-	request_region(self->io.fir_base, self->io.fir_ext, driver_name);
 
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&self->qos);
diff -Nru clean-2.4.17//drivers/net/hamradio/yam.c linux/drivers/net/hamradio/yam.c
--- clean-2.4.17//drivers/net/hamradio/yam.c	Mon Nov  5 19:23:12 2001
+++ linux/drivers/net/hamradio/yam.c	Thu Dec 27 14:02:40 2001
@@ -848,7 +848,7 @@
 		dev->irq < 2 || dev->irq > 15) {
 		return -ENXIO;
 	}
-	if (check_region(dev->base_addr, YAM_EXTENT)) {
+	if (!request_region(dev->base_addr, YAM_EXTENT), dev->name) {
 		printk(KERN_ERR "%s: cannot 0x%lx busy\n", dev->name, dev->base_addr);
 		return -EACCES;
 	}
@@ -865,7 +865,6 @@
 		printk(KERN_ERR "%s: irq %d busy\n", dev->name, dev->irq);
 		return -EBUSY;
 	}
-	request_region(dev->base_addr, YAM_EXTENT, dev->name);
 
 	yam_set_uart(dev);
 
diff -Nru clean-2.4.17//drivers/net/arcnet/com90io.c linux/drivers/net/arcnet/com90io.c
--- clean-2.4.17//drivers/net/arcnet/com90io.c	Mon Nov  5 19:24:25 2001
+++ linux/drivers/net/arcnet/com90io.c	Thu Dec 27 13:30:57 2001
@@ -241,7 +241,8 @@
 		return -ENODEV;
 	}
 	/* Reserve the I/O region - guaranteed to work by check_region */
-	request_region(dev->base_addr, ARCNET_TOTAL_SIZE, "arcnet (COM90xx-IO)");
+	if (!request_region(dev->base_addr, ARCNET_TOTAL_SIZE, "arcnet (COM90xx-IO)"))
+		return -EBUSY;
 
 	/* Initialize the rest of the device structure. */
 	dev->priv = kmalloc(sizeof(struct arcnet_local), GFP_KERNEL);
diff -Nru clean-2.4.17//drivers/net/sb1000.c linux/drivers/net/sb1000.c
--- clean-2.4.17//drivers/net/sb1000.c	Mon Nov  5 19:23:13 2001
+++ linux/drivers/net/sb1000.c	Thu Dec 27 14:13:18 2001
@@ -262,8 +262,9 @@
 
 		/* Lock resources */
 
-		request_region(ioaddr[0], 16, dev->name);
-		request_region(ioaddr[1], 16, dev->name);
+		if (!request_region(ioaddr[0], 16, dev->name) ||
+	  	    !request_region(ioaddr[1], 16, dev->name))
+			return -EBUSY;
 
 		return 0;
 	}
@@ -962,8 +963,9 @@
 	/* rmem_end holds the second I/O address - fv */
 	ioaddr[1] = dev->rmem_end;
 	name = dev->name;
-	request_region(ioaddr[0], SB1000_IO_EXTENT, "sb1000");
-	request_region(ioaddr[1], SB1000_IO_EXTENT, "sb1000");
+	if (!request_region(ioaddr[0], SB1000_IO_EXTENT, "sb1000") ||
+	    !request_region(ioaddr[1], SB1000_IO_EXTENT, "sb1000"))
+		return -EBUSY;
 
 	/* initialize sb1000 */
 	if ((status = sb1000_reset(ioaddr, name)))
diff -Nru clean-2.4.17//drivers/net/wan/sealevel.c linux/drivers/net/wan/sealevel.c
--- clean-2.4.17//drivers/net/wan/sealevel.c	Mon Nov  5 19:23:14 2001
+++ linux/drivers/net/wan/sealevel.c	Thu Dec 27 14:18:21 2001
@@ -219,12 +219,11 @@
 	 *	Get the needed I/O space
 	 */
 	 
-	if(check_region(iobase, 8))
+	if(!request_region(iobase, 8, "Sealevel 4021"))
 	{	
 		printk(KERN_WARNING "sealevel: I/O 0x%X already in use.\n", iobase);
 		return NULL;
 	}
-	request_region(iobase, 8, "Sealevel 4021");
 	
 	b=(struct slvl_board *)kmalloc(sizeof(struct slvl_board), GFP_KERNEL);
 	if(!b)
