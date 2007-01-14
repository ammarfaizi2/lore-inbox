Return-Path: <linux-kernel-owner+w=401wt.eu-S1751145AbXANHgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbXANHgC (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 02:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbXANHgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 02:36:01 -0500
Received: from www.osadl.org ([213.239.205.134]:57896 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751142AbXANHfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 02:35:36 -0500
Message-Id: <20070114081926.967534281@inhelltoy.tec.linutronix.de>
References: <20070114081905.135797900@inhelltoy.tec.linutronix.de>
User-Agent: quilt/0.46-1
Date: Sun, 14 Jan 2007 08:33:46 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [patch 2/3] Scheduled removal of SA_xxx interrupt flags fixups
Content-Disposition: inline;
	filename=sa-irqflags-scheduled-feature-removal-fix-users.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The obsolete SA_xxx interrupt flags have been used despite the scheduled
removal. Fixup the remaining users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index: linux-2.6.20-rc5/kernel/irq/manage.c
===================================================================
--- linux-2.6.20-rc5.orig/kernel/irq/manage.c
+++ linux-2.6.20-rc5/kernel/irq/manage.c
@@ -442,7 +442,7 @@ int request_irq(unsigned int irq, irq_ha
 	/*
 	 * Lockdep wants atomic interrupt handlers:
 	 */
-	irqflags |= SA_INTERRUPT;
+	irqflags |= IRQF_DISABLED;
 #endif
 	/*
 	 * Sanity-check: shared interrupts must pass in a real dev-ID,
Index: linux-2.6.20-rc5/drivers/usb/host/ohci-ep93xx.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/usb/host/ohci-ep93xx.c
+++ linux-2.6.20-rc5/drivers/usb/host/ohci-ep93xx.c
@@ -78,7 +78,7 @@ static int usb_hcd_ep93xx_probe(const st
 
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
-	retval = usb_add_hcd(hcd, pdev->resource[1].start, SA_INTERRUPT);
+	retval = usb_add_hcd(hcd, pdev->resource[1].start, IRQF_DISABLED);
 	if (retval == 0)
 		return retval;
 
Index: linux-2.6.20-rc5/drivers/usb/host/ohci-pnx4008.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/usb/host/ohci-pnx4008.c
+++ linux-2.6.20-rc5/drivers/usb/host/ohci-pnx4008.c
@@ -421,7 +421,7 @@ static int __devinit usb_hcd_pnx4008_pro
 	ohci_hcd_init(ohci);
 
 	dev_info(&pdev->dev, "at 0x%p, irq %d\n", hcd->regs, hcd->irq);
-	ret = usb_add_hcd(hcd, irq, SA_INTERRUPT);
+	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED);
 	if (ret == 0)
 		return ret;
 
Index: linux-2.6.20-rc5/drivers/usb/host/ohci-pnx8550.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/usb/host/ohci-pnx8550.c
+++ linux-2.6.20-rc5/drivers/usb/host/ohci-pnx8550.c
@@ -107,7 +107,7 @@ int usb_hcd_pnx8550_probe (const struct 
 
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
-	retval = usb_add_hcd(hcd, dev->resource[1].start, SA_INTERRUPT);
+	retval = usb_add_hcd(hcd, dev->resource[1].start, IRQF_DISABLED);
 	if (retval == 0)
 		return retval;
 
Index: linux-2.6.20-rc5/drivers/usb/gadget/pxa2xx_udc.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/usb/gadget/pxa2xx_udc.c
+++ linux-2.6.20-rc5/drivers/usb/gadget/pxa2xx_udc.c
@@ -2614,7 +2614,7 @@ lubbock_fail0:
 #endif
 	if (vbus_irq) {
 		retval = request_irq(vbus_irq, udc_vbus_irq,
-				SA_INTERRUPT | SA_SAMPLE_RANDOM,
+				IRQF_DISABLED | IRQF_SAMPLE_RANDOM,
 				driver_name, dev);
 		if (retval != 0) {
 			printk(KERN_ERR "%s: can't get irq %i, err %d\n",
Index: linux-2.6.20-rc5/drivers/net/qla3xxx.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/net/qla3xxx.c
+++ linux-2.6.20-rc5/drivers/net/qla3xxx.c
@@ -2999,7 +2999,7 @@ static int ql_adapter_up(struct ql3_adap
 {
 	struct net_device *ndev = qdev->ndev;
 	int err;
-	unsigned long irq_flags = SA_SAMPLE_RANDOM | SA_SHIRQ;
+	unsigned long irq_flags = IRQF_SAMPLE_RANDOM | IRQF_SHARED;
 	unsigned long hw_flags;
 
 	if (ql_alloc_mem_resources(qdev)) {
@@ -3018,7 +3018,7 @@ static int ql_adapter_up(struct ql3_adap
 		} else {
 			printk(KERN_INFO PFX "%s: MSI Enabled...\n", qdev->ndev->name);
 			set_bit(QL_MSI_ENABLED,&qdev->flags);
-			irq_flags &= ~SA_SHIRQ;
+			irq_flags &= ~IRQF_SHARED;
 		}
 	}
 
Index: linux-2.6.20-rc5/drivers/scsi/aic94xx/aic94xx_init.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/scsi/aic94xx/aic94xx_init.c
+++ linux-2.6.20-rc5/drivers/scsi/aic94xx/aic94xx_init.c
@@ -646,7 +646,7 @@ static int __devinit asd_pci_probe(struc
 	if (use_msi)
 		pci_enable_msi(asd_ha->pcidev);
 
-	err = request_irq(asd_ha->pcidev->irq, asd_hw_isr, SA_SHIRQ,
+	err = request_irq(asd_ha->pcidev->irq, asd_hw_isr, IRQF_SHARED,
 			  ASD_DRIVER_NAME, asd_ha);
 	if (err) {
 		asd_printk("couldn't get irq %d for %s\n",
Index: linux-2.6.20-rc5/drivers/net/netxen/netxen_nic_main.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/net/netxen/netxen_nic_main.c
+++ linux-2.6.20-rc5/drivers/net/netxen/netxen_nic_main.c
@@ -619,8 +619,8 @@ static int netxen_nic_open(struct net_de
 		}
 		adapter->irq = adapter->ahw.pdev->irq;
 		err = request_irq(adapter->ahw.pdev->irq, &netxen_intr,
-				  SA_SHIRQ | SA_SAMPLE_RANDOM, netdev->name,
-				  adapter);
+				  IRQF_SHARED | IRQF_SAMPLE_RANDOM,
+				  netdev->name, adapter);
 		if (err) {
 			printk(KERN_ERR "request_irq failed with: %d\n", err);
 			netxen_free_hw_resources(adapter);
Index: linux-2.6.20-rc5/drivers/misc/tifm_7xx1.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/misc/tifm_7xx1.c
+++ linux-2.6.20-rc5/drivers/misc/tifm_7xx1.c
@@ -340,7 +340,7 @@ static int tifm_7xx1_probe(struct pci_de
 	if (!fm->addr)
 		goto err_out_free;
 
-	rc = request_irq(dev->irq, tifm_7xx1_isr, SA_SHIRQ, DRIVER_NAME, fm);
+	rc = request_irq(dev->irq, tifm_7xx1_isr, IRQF_SHARED, DRIVER_NAME, fm);
 	if (rc)
 		goto err_out_unmap;
 
Index: linux-2.6.20-rc5/arch/ia64/kernel/irq_ia64.c
===================================================================
--- linux-2.6.20-rc5.orig/arch/ia64/kernel/irq_ia64.c
+++ linux-2.6.20-rc5/arch/ia64/kernel/irq_ia64.c
@@ -275,7 +275,7 @@ static struct irqaction ipi_irqaction = 
 
 static struct irqaction resched_irqaction = {
 	.handler =	dummy_handler,
-	.flags =	SA_INTERRUPT,
+	.flags =	IRQF_DISABLED,
 	.name =		"resched"
 };
 #endif
Index: linux-2.6.20-rc5/arch/m68k/atari/stdma.c
===================================================================
--- linux-2.6.20-rc5.orig/arch/m68k/atari/stdma.c
+++ linux-2.6.20-rc5/arch/m68k/atari/stdma.c
@@ -174,7 +174,7 @@ int stdma_islocked(void)
 void __init stdma_init(void)
 {
 	stdma_isr = NULL;
-	request_irq(IRQ_MFP_FDC, stdma_int, IRQ_TYPE_SLOW | SA_SHIRQ,
+	request_irq(IRQ_MFP_FDC, stdma_int, IRQ_TYPE_SLOW | IRQF_SHARED,
 	            "ST-DMA: floppy/ACSI/IDE/Falcon-SCSI", stdma_int);
 }
 
Index: linux-2.6.20-rc5/arch/ppc/syslib/i8259.c
===================================================================
--- linux-2.6.20-rc5.orig/arch/ppc/syslib/i8259.c
+++ linux-2.6.20-rc5/arch/ppc/syslib/i8259.c
@@ -154,7 +154,7 @@ static struct resource pic_edgectrl_iore
 
 static struct irqaction i8259_irqaction = {
 	.handler = no_action,
-	.flags = SA_INTERRUPT,
+	.flags = IRQF_DISABLED,
 	.mask = CPU_MASK_NONE,
 	.name = "82c59 secondary cascade",
 };
Index: linux-2.6.20-rc5/drivers/ata/pata_mpiix.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/ata/pata_mpiix.c
+++ linux-2.6.20-rc5/drivers/ata/pata_mpiix.c
@@ -229,7 +229,7 @@ static int mpiix_init_one(struct pci_dev
 	probe[0].sht = &mpiix_sht;
 	probe[0].pio_mask = 0x1F;
 	probe[0].irq = 14;
-	probe[0].irq_flags = SA_SHIRQ;
+	probe[0].irq_flags = IRQF_SHARED;
 	probe[0].port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
 	probe[0].n_ports = 1;
 	probe[0].port[0].cmd_addr = 0x1F0;
Index: linux-2.6.20-rc5/drivers/ata/pata_pcmcia.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/ata/pata_pcmcia.c
+++ linux-2.6.20-rc5/drivers/ata/pata_pcmcia.c
@@ -256,7 +256,7 @@ next_entry:
 	ae.n_ports = 1;
 	ae.pio_mask = 1;		/* ISA so PIO 0 cycles */
 	ae.irq = pdev->irq.AssignedIRQ;
-	ae.irq_flags = SA_SHIRQ;
+	ae.irq_flags = IRQF_SHARED;
 	ae.port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
 	ae.port[0].cmd_addr = io_base;
 	ae.port[0].altstatus_addr = ctl_base;
Index: linux-2.6.20-rc5/drivers/ata/pata_pdc2027x.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/ata/pata_pdc2027x.c
+++ linux-2.6.20-rc5/drivers/ata/pata_pdc2027x.c
@@ -804,8 +804,8 @@ static int __devinit pdc2027x_init_one(s
 	probe_ent->udma_mask	= pdc2027x_port_info[board_idx].udma_mask;
 	probe_ent->port_ops	= pdc2027x_port_info[board_idx].port_ops;
 
-       	probe_ent->irq = pdev->irq;
-       	probe_ent->irq_flags = SA_SHIRQ;
+	probe_ent->irq = pdev->irq;
+	probe_ent->irq_flags = IRQF_SHARED;
 	probe_ent->mmio_base = mmio_base;
 
 	pdc_ata_setup_port(&probe_ent->port[0], base + 0x17c0);
Index: linux-2.6.20-rc5/drivers/char/watchdog/rm9k_wdt.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/char/watchdog/rm9k_wdt.c
+++ linux-2.6.20-rc5/drivers/char/watchdog/rm9k_wdt.c
@@ -192,7 +192,7 @@ static int wdt_gpi_open(struct inode *in
 		locked = 0;
 	}
 
-	res = request_irq(wd_irq, wdt_gpi_irqhdl, SA_SHIRQ | SA_INTERRUPT,
+	res = request_irq(wd_irq, wdt_gpi_irqhdl, IRQF_SHARED | IRQF_DISABLED,
 			  wdt_gpi_name, &miscdev);
 	if (unlikely(res))
 		return res;
Index: linux-2.6.20-rc5/drivers/infiniband/hw/amso1100/c2.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/infiniband/hw/amso1100/c2.c
+++ linux-2.6.20-rc5/drivers/infiniband/hw/amso1100/c2.c
@@ -1073,7 +1073,7 @@ static int __devinit c2_probe(struct pci
 	     0xffffc000) / sizeof(struct c2_rxp_desc);
 
 	/* Request an interrupt line for the driver */
-	ret = request_irq(pcidev->irq, c2_interrupt, SA_SHIRQ, DRV_NAME, c2dev);
+	ret = request_irq(pcidev->irq, c2_interrupt, IRQF_SHARED, DRV_NAME, c2dev);
 	if (ret) {
 		printk(KERN_ERR PFX "%s: requested IRQ %u is busy\n",
 			pci_name(pcidev), pcidev->irq);
Index: linux-2.6.20-rc5/drivers/infiniband/hw/ehca/ehca_eq.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/infiniband/hw/ehca/ehca_eq.c
+++ linux-2.6.20-rc5/drivers/infiniband/hw/ehca/ehca_eq.c
@@ -122,7 +122,7 @@ int ehca_create_eq(struct ehca_shca *shc
 	/* register interrupt handlers and initialize work queues */
 	if (type == EHCA_EQ) {
 		ret = ibmebus_request_irq(NULL, eq->ist, ehca_interrupt_eq,
-					  SA_INTERRUPT, "ehca_eq",
+					  IRQF_DISABLED, "ehca_eq",
 					  (void *)shca);
 		if (ret < 0)
 			ehca_err(ib_dev, "Can't map interrupt handler.");
@@ -130,7 +130,7 @@ int ehca_create_eq(struct ehca_shca *shc
 		tasklet_init(&eq->interrupt_task, ehca_tasklet_eq, (long)shca);
 	} else if (type == EHCA_NEQ) {
 		ret = ibmebus_request_irq(NULL, eq->ist, ehca_interrupt_neq,
-					  SA_INTERRUPT, "ehca_neq",
+					  IRQF_DISABLED, "ehca_neq",
 					  (void *)shca);
 		if (ret < 0)
 			ehca_err(ib_dev, "Can't map interrupt handler.");
Index: linux-2.6.20-rc5/drivers/net/7990.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/net/7990.c
+++ linux-2.6.20-rc5/drivers/net/7990.c
@@ -500,7 +500,7 @@ int lance_open (struct net_device *dev)
 	int res;
 
         /* Install the Interrupt handler. Or we could shunt this out to specific drivers? */
-        if (request_irq(lp->irq, lance_interrupt, SA_SHIRQ, lp->name, dev))
+        if (request_irq(lp->irq, lance_interrupt, IRQF_SHARED, lp->name, dev))
                 return -EAGAIN;
 
         res = lance_reset(dev);
Index: linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/net/ehea/ehea_main.c
+++ linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c
@@ -882,7 +882,7 @@ static int ehea_reg_interrupts(struct ne
 			 , "%s-recv%d", dev->name, i);
 		ret = ibmebus_request_irq(NULL, pr->recv_eq->attr.ist1,
 					  ehea_recv_irq_handler,
-					  SA_INTERRUPT, pr->int_recv_name, pr);
+					  IRQF_DISABLED, pr->int_recv_name, pr);
 		if (ret) {
 			ehea_error("failed registering irq for ehea_recv_int:"
 				   "port_res_nr:%d, ist=%X", i,
@@ -899,7 +899,7 @@ static int ehea_reg_interrupts(struct ne
 
 	ret = ibmebus_request_irq(NULL, port->qp_eq->attr.ist1,
 				  ehea_qp_aff_irq_handler,
-				  SA_INTERRUPT, port->int_aff_name, port);
+				  IRQF_DISABLED, port->int_aff_name, port);
 	if (ret) {
 		ehea_error("failed registering irq for qp_aff_irq_handler:"
 			   "ist=%X", port->qp_eq->attr.ist1);
@@ -916,7 +916,7 @@ static int ehea_reg_interrupts(struct ne
 			 "%s-send%d", dev->name, i);
 		ret = ibmebus_request_irq(NULL, pr->send_eq->attr.ist1,
 					  ehea_send_irq_handler,
-					  SA_INTERRUPT, pr->int_send_name,
+					  IRQF_DISABLED, pr->int_send_name,
 					  pr);
 		if (ret) {
 			ehea_error("failed registering irq for ehea_send "
@@ -2509,7 +2509,7 @@ static int __devinit ehea_probe(struct i
 		     (unsigned long)adapter);
 
 	ret = ibmebus_request_irq(NULL, adapter->neq->attr.ist1,
-				  ehea_interrupt_neq, SA_INTERRUPT,
+				  ehea_interrupt_neq, IRQF_DISABLED,
 				  "ehea_neq", adapter);
 	if (ret) {
 		dev_err(&dev->ofdev.dev, "requesting NEQ IRQ failed");
Index: linux-2.6.20-rc5/drivers/net/macb.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/net/macb.c
+++ linux-2.6.20-rc5/drivers/net/macb.c
@@ -1068,7 +1068,7 @@ static int __devinit macb_probe(struct p
 	}
 
 	dev->irq = platform_get_irq(pdev, 0);
-	err = request_irq(dev->irq, macb_interrupt, SA_SAMPLE_RANDOM,
+	err = request_irq(dev->irq, macb_interrupt, IRQF_SAMPLE_RANDOM,
 			  dev->name, dev);
 	if (err) {
 		printk(KERN_ERR
Index: linux-2.6.20-rc5/drivers/net/ucc_geth.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/net/ucc_geth.c
+++ linux-2.6.20-rc5/drivers/net/ucc_geth.c
@@ -4001,8 +4001,8 @@ static void ugeth_phy_startup_timer(unsi
 	/* Grab the PHY interrupt, if necessary/possible */
 	if (ugeth->ug_info->board_flags & FSL_UGETH_BRD_HAS_PHY_INTR) {
 		if (request_irq(ugeth->ug_info->phy_interrupt,
-				phy_interrupt,
-				SA_SHIRQ, "phy_interrupt", mii_info->dev) < 0) {
+				phy_interrupt, IRQF_SHARED,
+				"phy_interrupt", mii_info->dev) < 0) {
 			ugeth_err("%s: Can't get IRQ %d (PHY)",
 				  mii_info->dev->name,
 				  ugeth->ug_info->phy_interrupt);
Index: linux-2.6.20-rc5/drivers/pci/pcie/aer/aerdrv.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/pci/pcie/aer/aerdrv.c
+++ linux-2.6.20-rc5/drivers/pci/pcie/aer/aerdrv.c
@@ -220,7 +220,7 @@ static int __devinit aer_probe (struct p
 	}
 
 	/* Request IRQ ISR */
-	if ((status = request_irq(dev->irq, aer_irq, SA_SHIRQ, "aerdrv",
+	if ((status = request_irq(dev->irq, aer_irq, IRQF_SHARED, "aerdrv",
 				dev))) {
 		printk(KERN_DEBUG "%s: Request ISR fails on PCIE device[%s]\n",
 			__FUNCTION__, device->bus_id);
Index: linux-2.6.20-rc5/drivers/rtc/rtc-omap.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/rtc/rtc-omap.c
+++ linux-2.6.20-rc5/drivers/rtc/rtc-omap.c
@@ -417,13 +417,13 @@ static int __devinit omap_rtc_probe(stru
 		rtc_write(OMAP_RTC_STATUS_ALARM, OMAP_RTC_STATUS_REG);
 
 	/* handle periodic and alarm irqs */
-	if (request_irq(omap_rtc_timer, rtc_irq, SA_INTERRUPT,
+	if (request_irq(omap_rtc_timer, rtc_irq, IRQF_DISABLED,
 			rtc->class_dev.class_id, &rtc->class_dev)) {
 		pr_debug("%s: RTC timer interrupt IRQ%d already claimed\n",
 			pdev->name, omap_rtc_timer);
 		goto fail0;
 	}
-	if (request_irq(omap_rtc_alarm, rtc_irq, SA_INTERRUPT,
+	if (request_irq(omap_rtc_alarm, rtc_irq, IRQF_DISABLED,
 			rtc->class_dev.class_id, &rtc->class_dev)) {
 		pr_debug("%s: RTC alarm interrupt IRQ%d already claimed\n",
 			pdev->name, omap_rtc_alarm);
Index: linux-2.6.20-rc5/drivers/rtc/rtc-s3c.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/rtc/rtc-s3c.c
+++ linux-2.6.20-rc5/drivers/rtc/rtc-s3c.c
@@ -350,7 +350,7 @@ static int s3c_rtc_open(struct device *d
 	int ret;
 
 	ret = request_irq(s3c_rtc_alarmno, s3c_rtc_alarmirq,
-			  SA_INTERRUPT,  "s3c2410-rtc alarm", rtc_dev);
+			  IRQF_DISABLED,  "s3c2410-rtc alarm", rtc_dev);
 
 	if (ret) {
 		dev_err(dev, "IRQ%d error %d\n", s3c_rtc_alarmno, ret);
@@ -358,7 +358,7 @@ static int s3c_rtc_open(struct device *d
 	}
 
 	ret = request_irq(s3c_rtc_tickno, s3c_rtc_tickirq,
-			  SA_INTERRUPT,  "s3c2410-rtc tick", rtc_dev);
+			  IRQF_DISABLED,  "s3c2410-rtc tick", rtc_dev);
 
 	if (ret) {
 		dev_err(dev, "IRQ%d error %d\n", s3c_rtc_tickno, ret);
Index: linux-2.6.20-rc5/drivers/scsi/arcmsr/arcmsr_hba.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/scsi/arcmsr/arcmsr_hba.c
+++ linux-2.6.20-rc5/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -322,7 +322,7 @@ static int arcmsr_probe(struct pci_dev *
 		goto out_iounmap;
 
 	error = request_irq(pdev->irq, arcmsr_do_interrupt,
-			SA_INTERRUPT | SA_SHIRQ, "arcmsr", acb);
+			IRQF_DISABLED | IRQF_SHARED, "arcmsr", acb);
 	if (error)
 		goto out_free_ccb_pool;
 
Index: linux-2.6.20-rc5/drivers/scsi/ibmvscsi/ibmvstgt.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/scsi/ibmvscsi/ibmvstgt.c
+++ linux-2.6.20-rc5/drivers/scsi/ibmvscsi/ibmvstgt.c
@@ -580,7 +580,7 @@ static int crq_queue_create(struct crq_q
 	}
 
 	err = request_irq(vport->dma_dev->irq, &ibmvstgt_interrupt,
-			  SA_INTERRUPT, "ibmvstgt", target);
+			  IRQF_DISABLED, "ibmvstgt", target);
 	if (err)
 		goto req_irq_failed;
 
Index: linux-2.6.20-rc5/drivers/scsi/qla4xxx/ql4_os.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/scsi/qla4xxx/ql4_os.c
+++ linux-2.6.20-rc5/drivers/scsi/qla4xxx/ql4_os.c
@@ -1257,7 +1257,7 @@ static int __devinit qla4xxx_probe_adapt
 	INIT_WORK(&ha->dpc_work, qla4xxx_do_dpc);
 
 	ret = request_irq(pdev->irq, qla4xxx_intr_handler,
-			  SA_INTERRUPT|SA_SHIRQ, "qla4xxx", ha);
+			  IRQF_DISABLED | IRQF_SHARED, "qla4xxx", ha);
 	if (ret) {
 		dev_warn(&ha->pdev->dev, "Failed to reserve interrupt %d"
 			" already in use.\n", pdev->irq);
Index: linux-2.6.20-rc5/drivers/video/intelfb/intelfbhw.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/video/intelfb/intelfbhw.c
+++ linux-2.6.20-rc5/drivers/video/intelfb/intelfbhw.c
@@ -1990,7 +1990,8 @@ int
 intelfbhw_enable_irq(struct intelfb_info *dinfo, int reenable) {
 
 	if (!test_and_set_bit(0, &dinfo->irq_flags)) {
-		if (request_irq(dinfo->pdev->irq, intelfbhw_irq, SA_SHIRQ, "intelfb", dinfo)) {
+		if (request_irq(dinfo->pdev->irq, intelfbhw_irq, IRQF_SHARED,
+		     "intelfb", dinfo)) {
 			clear_bit(0, &dinfo->irq_flags);
 			return -EINVAL;
 		}

-- 

