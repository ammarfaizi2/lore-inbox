Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312687AbSCVGK6>; Fri, 22 Mar 2002 01:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312688AbSCVGKq>; Fri, 22 Mar 2002 01:10:46 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:23827 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S312687AbSCVGKZ>; Fri, 22 Mar 2002 01:10:25 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [PATCH] Trivial request_region check patchset.
Date: Fri, 22 Mar 2002 17:13:45 +1100
Message-Id: <E16oIJ7-0000uW-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	Evgeniy Polyakov <johnpol@2ka.mipt.ru> has been working his
way through the kernel, auditing request_region calls (which as of 2.4
return an int).  Please peruse for your drivers before I send them all
to Linus, and watch out for more mails from Evgeniy!

arch/arm:
	kernel/via82c505.c mach-footbridge/netwinder-hw.c mach-shark/leds.c
arch/i386:
	kernel/pci-pc.c
arch/mips:
	jazz/setup.c
arch/ppc64:
	kernel/chrp_setup.c
arch/sh:
	kernel/hd64465_gpio.c
	kernel/pci-sh7751.c
arch/x86_64:
	kernel/pci-pc.c
drivers/acorn:
	block/mfmhd.c scsi/acornscsi.c scsi/arxescsi.c scsi/cumana_2.c
	scsi/oak.c
drivers/atm:
	horizon.c
drivers/block:
	DAC960.c paride/paride.c ps2esdi.c xd.c
drivers/cdrom:
	cdu31a.c optcd.c sbpcd.c sonycd535.c
drivers/char:
	acquirewdt.c advantechwdt.c cyclades.c dtlk.c epca.c esp.c
	ftape/lowlevel/fdc-io.c h8.c ib700wdt.c ip2main.c isicom.c
	istallion.c ite_gpio.c logibusmouse.c mixcomwd.c msbusmouse.c
	pcwd.c rocket.c rtc.c serial.c

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/arch/arm/kernel/via82c505.c trivial-2.5.7/arch/arm/kernel/via82c505.c
--- linux-2.5.7/arch/arm/kernel/via82c505.c	Fri Mar  8 14:49:10 2002
+++ trivial-2.5.7/arch/arm/kernel/via82c505.c	Fri Mar 22 17:05:55 2002
@@ -79,8 +79,17 @@
 	struct pci_bus *bus;
 
 	printk(KERN_DEBUG "PCI: VIA 82c505\n");
-	request_region(0xA8,2,"via config");
-	request_region(0xCF8,8,"pci config");
+	if (!request_region(0xA8,2,"via config"))
+		{
+		printk(KERN_WARNING"VIA 82c505: Unable to request region 0xA8\n");
+		return;
+		}
+	if (!request_region(0xCF8,8,"pci config"))
+		{
+		printk(KERN_WARNING"VIA 82c505: Unable to request region 0xCF8\n");
+		release_region(0xA8, 2);
+		return;
+		}
 
 	/* Enable compatible Mode */
 	outb(0x96,0xA8);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/arch/arm/mach-footbridge/netwinder-hw.c trivial-2.5.7/arch/arm/mach-footbridge/netwinder-hw.c
--- linux-2.5.7/arch/arm/mach-footbridge/netwinder-hw.c	Fri Mar  8 14:49:10 2002
+++ trivial-2.5.7/arch/arm/mach-footbridge/netwinder-hw.c	Fri Mar 22 17:05:56 2002
@@ -328,7 +328,11 @@
  */
 static void __init wb977_init(void)
 {
-	request_region(0x370, 2, "W83977AF configuration");
+	if (!request_region(0x370, 2, "W83977AF configuration"))
+		{
+		printk(KERN_WARNING"Unable to request region 0x370\n");
+		return;
+		}
 
 	/*
 	 * Open up the SuperIO chip
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/arch/arm/mach-shark/leds.c trivial-2.5.7/arch/arm/mach-shark/leds.c
--- linux-2.5.7/arch/arm/mach-shark/leds.c	Fri Oct 26 06:53:46 2001
+++ trivial-2.5.7/arch/arm/mach-shark/leds.c	Fri Mar 22 17:05:57 2002
@@ -152,7 +152,11 @@
 	leds_event = sequoia_leds_event;
 
 	/* Make LEDs independent of power-state */
-	request_region(0x24,4,"sequoia");
+	if (!request_region(0x24,4,"sequoia"))
+		{
+		printk(KERN_WARNING"arm: Unable to request region 0x24\n");
+		return -EIO;
+		}
 	temp = sequoia_read(0x09);
 	temp |= 1<<10;
 	sequoia_write(temp,0x09);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/arch/i386/kernel/pci-pc.c trivial-2.5.7/arch/i386/kernel/pci-pc.c
--- linux-2.5.7/arch/i386/kernel/pci-pc.c	Thu Mar 21 14:14:38 2002
+++ trivial-2.5.7/arch/i386/kernel/pci-pc.c	Fri Mar 22 17:05:57 2002
@@ -422,7 +422,8 @@
 			outl (tmp, 0xCF8);
 			__restore_flags(flags);
 			printk("PCI: Using configuration type 1\n");
-			request_region(0xCF8, 8, "PCI conf1");
+			if (!request_region(0xCF8, 8, "PCI conf1"))
+				return NULL;
 			return &pci_direct_conf1;
 		}
 		outl (tmp, 0xCF8);
@@ -439,7 +440,8 @@
 		    pci_sanity_check(&pci_direct_conf2)) {
 			__restore_flags(flags);
 			printk("PCI: Using configuration type 2\n");
-			request_region(0xCF8, 4, "PCI conf2");
+			if (!request_region(0xCF8, 4, "PCI conf2"))
+				return NULL;
 			return &pci_direct_conf2;
 		}
 	}
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/arch/mips/jazz/setup.c trivial-2.5.7/arch/mips/jazz/setup.c
--- linux-2.5.7/arch/mips/jazz/setup.c	Mon Sep 10 03:43:01 2001
+++ trivial-2.5.7/arch/mips/jazz/setup.c	Fri Mar 22 17:05:58 2002
@@ -62,6 +62,13 @@
 
 static void __init jazz_irq_setup(void)
 {
+	if (!request_region(0x20, 0x20, "pic1"))
+		return;
+	if (!request_region(0xa0, 0x20, "pic2"))
+		{
+		release_region(0x20, 0x20);
+		return;
+		}
         set_except_vector(0, jazz_handle_int);
 	r4030_write_reg16(JAZZ_IO_IRQ_ENABLE,
 			  JAZZ_IE_ETHERNET |
@@ -75,13 +82,33 @@
 	change_cp0_status(ST0_IM, IE_IRQ4 | IE_IRQ3 | IE_IRQ2 | IE_IRQ1);
 	/* set the clock to 100 Hz */
 	r4030_write_reg32(JAZZ_TIMER_INTERVAL, 9);
-	request_region(0x20, 0x20, "pic1");
-	request_region(0xa0, 0x20, "pic2");
+
 	i8259_setup_irq(2, &irq2);
 }
 
 void __init jazz_setup(void)
 {
+	if (!request_region(0x00,0x20,"dma1"))
+		return;
+	if (!request_region(0x40,0x20,"timer"))
+		{
+		release_region(0x00, 0x20);
+		return;
+		}
+	if (!request_region(0x80,0x10,"dma page reg"))
+		{
+		release_region(0x00, 0x20);
+		release_region(0x40, 0x20);
+		return;
+		}
+	if (!request_region(0xc0,0x20,"dma2"))
+		{
+		release_region(0x00, 0x20);
+		release_region(0x40, 0x20);
+		release_region(0x80, 0x10);
+		return;
+		}
+	
 	add_wired_entry (0x02000017, 0x03c00017, 0xe0000000, PM_64K);
 	add_wired_entry (0x02400017, 0x02440017, 0xe2000000, PM_16M);
 	add_wired_entry (0x01800017, 0x01000017, 0xe4000000, PM_4M);
@@ -91,10 +118,7 @@
 	if (mips_machtype == MACH_MIPS_MAGNUM_4000)
 		EISA_bus = 1;
 	isa_slot_offset = 0xe3000000;
-	request_region(0x00,0x20,"dma1");
-	request_region(0x40,0x20,"timer");
-	request_region(0x80,0x10,"dma page reg");
-	request_region(0xc0,0x20,"dma2");
+
         board_time_init = jazz_time_init;
 	/* The RTC is outside the port address space */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/arch/ppc64/kernel/chrp_setup.c trivial-2.5.7/arch/ppc64/kernel/chrp_setup.c
--- linux-2.5.7/arch/ppc64/kernel/chrp_setup.c	Wed Feb 20 17:57:06 2002
+++ trivial-2.5.7/arch/ppc64/kernel/chrp_setup.c	Fri Mar 22 17:05:58 2002
@@ -119,12 +119,19 @@
 }
 
 void __init chrp_request_regions(void) {
-	request_region(0x20,0x20,"pic1");
-	request_region(0xa0,0x20,"pic2");
-	request_region(0x00,0x20,"dma1");
-	request_region(0x40,0x20,"timer");
-	request_region(0x80,0x10,"dma page reg");
-	request_region(0xc0,0x20,"dma2");
+	if (!request_region(0x20,0x20,"pic1"))
+		panic("chrp: Unable to request region 0x20\n");
+	if (!request_region(0xa0,0x20,"pic2"))
+		panic("chrp: Unable to request region 0xa0\n");
+	if (!request_region(0x00,0x20,"dma1"))
+		panic("chrp: Unable to request region 0x00\n");
+	if (!request_region(0x40,0x20,"timer"))
+		panic("chrp: Unable to request region 0x40\n");
+	if (!request_region(0x80,0x10,"dma page reg"))
+		panic("chrp: Unable to request region 0x80\n");
+	if (!request_region(0xc0,0x20,"dma2"))
+		panic("chrp: Unable to request region 0xc0\n");
+	return;
 }
 
 void __init
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/arch/sh/kernel/hd64465_gpio.c trivial-2.5.7/arch/sh/kernel/hd64465_gpio.c
--- linux-2.5.7/arch/sh/kernel/hd64465_gpio.c	Thu Jun 28 06:55:29 2001
+++ trivial-2.5.7/arch/sh/kernel/hd64465_gpio.c	Fri Mar 22 17:05:58 2002
@@ -165,10 +165,18 @@
 
 static int __init hd64465_gpio_init(void)
 {
-    	/* TODO: check return values */
-    	request_region(HD64465_REG_GPACR, 0x1000, MODNAME);
-	request_irq(HD64465_IRQ_GPIO, hd64465_gpio_interrupt,
+	int err;
+	
+    	if (!request_region(HD64465_REG_GPACR, 0x1000, MODNAME))
+		return -EIO;
+	err=request_irq(HD64465_IRQ_GPIO, hd64465_gpio_interrupt,
 	    SA_INTERRUPT, MODNAME, 0);
+	if (err)
+		{
+		printk(KERN_ERR"HD64465: Unable to get irq %d.\n", HD64465_IRQ_GPIO);
+		release_region(HD64465_REG_GPACR, 0x1000);
+		return err;
+		}
 
     	printk("HD64465 GPIO layer on irq %d\n", HD64465_IRQ_GPIO);
 	return 0;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/arch/sh/kernel/pci-sh7751.c trivial-2.5.7/arch/sh/kernel/pci-sh7751.c
--- linux-2.5.7/arch/sh/kernel/pci-sh7751.c	Mon Nov  5 04:31:58 2001
+++ trivial-2.5.7/arch/sh/kernel/pci-sh7751.c	Fri Mar 22 17:05:58 2002
@@ -216,7 +216,8 @@
 		if (inl (PCI_REG(SH7751_PCIPAR)) == 0x80000000) {
 			outl (tmp, PCI_REG(SH7751_PCIPAR));
 			printk(KERN_INFO "PCI: Using configuration type 1\n");
-			request_region(PCI_REG(SH7751_PCIPAR), 8, "PCI conf1");
+			if (!request_region(PCI_REG(SH7751_PCIPAR), 8, "PCI conf1"))
+				return NULL;
 			return &pci_direct_conf1;
 		}
 		outl (tmp, PCI_REG(SH7751_PCIPAR));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/arch/x86_64/kernel/pci-pc.c trivial-2.5.7/arch/x86_64/kernel/pci-pc.c
--- linux-2.5.7/arch/x86_64/kernel/pci-pc.c	Wed Feb 20 17:57:07 2002
+++ trivial-2.5.7/arch/x86_64/kernel/pci-pc.c	Fri Mar 22 17:05:55 2002
@@ -215,7 +215,8 @@
 			outl (tmp, 0xCF8);
 			__restore_flags(flags);
 			printk("PCI: Using configuration type 1\n");
-			request_region(0xCF8, 8, "PCI conf1");
+			if (!request_region(0xCF8, 8, "PCI conf1"))
+				return NULL;
 			return &pci_direct_conf1;
 		}
 		outl (tmp, 0xCF8);
@@ -232,7 +233,8 @@
 		    pci_sanity_check(&pci_direct_conf2)) {
 			__restore_flags(flags);
 			printk("PCI: Using configuration type 2\n");
-			request_region(0xCF8, 4, "PCI conf2");
+			if (!request_region(0xCF8, 4, "PCI conf2"))
+				return NULL;
 			return &pci_direct_conf2;
 		}
 	}
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/acorn/block/mfmhd.c trivial-2.5.7/drivers/acorn/block/mfmhd.c
--- linux-2.5.7/drivers/acorn/block/mfmhd.c	Fri Mar  8 14:49:12 2002
+++ trivial-2.5.7/drivers/acorn/block/mfmhd.c	Fri Mar 22 17:05:55 2002
@@ -1356,9 +1356,6 @@
  */
 static int mfm_probecontroller (unsigned int mfm_addr)
 {
-	if (check_region (mfm_addr, 10))
-		return 0;
-
 	if (inw (MFM_STATUS) & STAT_BSY) {
 		outw (CMD_ABT, MFM_COMMAND);
 		udelay (50);
@@ -1416,14 +1413,18 @@
 		ecard_claim(ecs);
 	}
 
+	printk("mfm: found at address %08X, interrupt %d\n", mfm_addr, mfm_irq);
+	if (!request_region (mfm_addr, 10, "mfm")) {
+		ecard_release(ecs);
+		return -1;
+	}
+
 	if (register_blkdev(MAJOR_NR, "mfm", &mfm_fops)) {
 		printk("mfm_init: unable to get major number %d\n", MAJOR_NR);
 		ecard_release(ecs);
+		release_region(mfm_addr, 10);
 		return -1;
 	}
-
-	printk("mfm: found at address %08X, interrupt %d\n", mfm_addr, mfm_irq);
-	request_region (mfm_addr, 10, "mfm");
 
 	/* Stuff for the assembler routines to get to */
 	hdc63463_baseaddress	= ioaddr(mfm_addr);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/acorn/scsi/acornscsi.c trivial-2.5.7/drivers/acorn/scsi/acornscsi.c
--- linux-2.5.7/drivers/acorn/scsi/acornscsi.c	Thu Mar 21 14:14:43 2002
+++ trivial-2.5.7/drivers/acorn/scsi/acornscsi.c	Fri Mar 22 17:05:55 2002
@@ -2915,13 +2915,18 @@
 	ecs[count]->irqaddr	= (char *)ioaddr(host->card.io_intr);
 	ecs[count]->irqmask	= 0x0a;
 
-	request_region(instance->io_port + 0x800,  2, "acornscsi(sbic)");
-	request_region(host->card.io_intr,  1, "acornscsi(intr)");
+	if (!request_region(instance->io_port + 0x800,  2, "acornscsi(sbic)"))
+		goto err_1;
+	if (!request_region(host->card.io_intr,  1, "acornscsi(intr)"))
+		goto err_2;
 	request_region(host->card.io_page,  1, "acornscsi(page)");
+		goto err_3;
 #ifdef USE_DMAC
 	request_region(host->dma.io_port, 256, "acornscsi(dmac)");
+		goto err_4;
 #endif
 	request_region(instance->io_port, 2048, "acornscsi(ram)");
+		goto err_5;
 
 	if (request_irq(host->scsi.irq, acornscsi_intr, SA_INTERRUPT, "acornscsi", host)) {
 	    printk(KERN_CRIT "scsi%d: IRQ%d not free, interrupts disabled\n",
@@ -2934,6 +2939,21 @@
 	++count;
     }
     return count;
+    
+err_5:
+    release_region(instance->io_port, 2048);
+#ifdef USE_DMAC
+err_4:
+    release_region(host->dma.io_port, 256);
+#endif
+err_3:
+    release_region(host->card.io_page, 1);
+err_2:
+    release_region(host->card.io_intr, 1);    
+err_1:
+    release_region(instance->io_port + 0x800, 2);
+    scsi_unregister(instance);
+    return 0;
 }
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/acorn/scsi/arxescsi.c trivial-2.5.7/drivers/acorn/scsi/arxescsi.c
--- linux-2.5.7/drivers/acorn/scsi/arxescsi.c	Wed Feb 20 17:55:23 2002
+++ trivial-2.5.7/drivers/acorn/scsi/arxescsi.c	Fri Mar 22 17:05:55 2002
@@ -304,8 +304,18 @@
 		ecs[count]->irqaddr = (unsigned char *)BUS_ADDR(host->io_port);
 		ecs[count]->irqmask = CSTATUS_IRQ;
 
-		request_region(host->io_port      , 120, "arxescsi-fas");
-		request_region(host->io_port + 128, 384, "arxescsi-dma");
+		if (!request_region(host->io_port      , 120, "arxescsi-fas")) {
+			ecard_release(ecs[count]);
+			scsi_unregister(host);
+			break;
+		}
+			
+		if (!request_region(host->io_port + 128, 384, "arxescsi-dma")) {
+			ecard_release(ecs[count]);
+			release_region(host->io_port, 120);
+			scsi_unregister(host);
+			break;
+		}
 
 		printk("scsi%d: Has no interrupts - using polling mode\n",
 		       host->host_no);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/acorn/scsi/cumana_2.c trivial-2.5.7/drivers/acorn/scsi/cumana_2.c
--- linux-2.5.7/drivers/acorn/scsi/cumana_2.c	Wed Feb 20 17:55:23 2002
+++ trivial-2.5.7/drivers/acorn/scsi/cumana_2.c	Fri Mar 22 17:05:55 2002
@@ -382,8 +382,13 @@
 		ecs[count]->irq_data	= (void *)info->alatch;
 		ecs[count]->ops		= (expansioncard_ops_t *)&cumanascsi_2_ops;
 
-		request_region(host->io_port + CUMANASCSI2_FAS216_OFFSET,
-			       16 << CUMANASCSI2_FAS216_SHIFT, "cumanascsi2-fas");
+		if (!request_region(host->io_port + CUMANASCSI2_FAS216_OFFSET,
+			       16 << CUMANASCSI2_FAS216_SHIFT, "cumanascsi2-fas")) {
+			scsi_unregister(host);
+			ecard_release(ecs[count]);
+			break;
+		}
+			
 
 		if (host->irq != NO_IRQ &&
 		    request_irq(host->irq, cumanascsi_2_intr,
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/acorn/scsi/oak.c trivial-2.5.7/drivers/acorn/scsi/oak.c
--- linux-2.5.7/drivers/acorn/scsi/oak.c	Wed Feb 20 17:55:23 2002
+++ trivial-2.5.7/drivers/acorn/scsi/oak.c	Fri Mar 22 17:05:56 2002
@@ -134,7 +134,8 @@
 	ecard_claim(ecs[count]);
 
 	instance->n_io_port = 255;
-	request_region (instance->io_port, instance->n_io_port, "Oak SCSI");
+	if (!request_region (instance->io_port, instance->n_io_port, "Oak SCSI"))
+		break;
 
 	if (instance->irq != IRQ_NONE)
 	    if (request_irq(instance->irq, do_oakscsi_intr, SA_INTERRUPT, "Oak SCSI", NULL)) {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/atm/horizon.c trivial-2.5.7/drivers/atm/horizon.c
--- linux-2.5.7/drivers/atm/horizon.c	Fri Sep 14 08:21:32 2001
+++ trivial-2.5.7/drivers/atm/horizon.c	Fri Mar 22 17:05:56 2002
@@ -2765,15 +2765,13 @@
     u32 * membase = bus_to_virt (pci_resource_start (pci_dev, 1));
     u8 irq = pci_dev->irq;
     
-    // check IO region
-    if (check_region (iobase, HRZ_IO_EXTENT)) {
-      PRINTD (DBG_WARN, "IO range already in use");
-      continue;
-    }
+    /* XXX DEV_LABEL is a guess */
+    if (!request_region (iobase, HRZ_IO_EXTENT, DEV_LABEL))
+  	  continue;
 
     if (pci_enable_device (pci_dev))
       continue;
-
+    
     dev = kmalloc (sizeof(hrz_dev), GFP_KERNEL);
     if (!dev) {
       // perhaps we should be nice: deregister all adapters and abort?
@@ -2807,9 +2805,6 @@
 	dev->atm_dev->dev_data = (void *) dev;
 	dev->pci_dev = pci_dev; 
 	
-	/* XXX DEV_LABEL is a guess */
-	request_region (iobase, HRZ_IO_EXTENT, DEV_LABEL);
-	
 	// enable bus master accesses
 	pci_set_master (pci_dev);
 	
@@ -2901,8 +2896,10 @@
 	atm_dev_deregister (dev->atm_dev);
       } /* atm_dev_register */
       free_irq (irq, dev);
+	
     } /* request_irq */
     kfree (dev);
+    release_region(iobase, HRZ_IO_EXTENT);
   } /* kmalloc and while */
   return devs;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/block/DAC960.c trivial-2.5.7/drivers/block/DAC960.c
--- linux-2.5.7/drivers/block/DAC960.c	Fri Mar  8 14:49:12 2002
+++ trivial-2.5.7/drivers/block/DAC960.c	Fri Mar 22 17:05:58 2002
@@ -2410,8 +2410,12 @@
 	    DAC960_V1_QueueReadWriteCommand;
 	  break;
 	case DAC960_PD_Controller:
-	  request_region(Controller->IO_Address, 0x80,
-			 Controller->FullModelName);
+	  if (!request_region(Controller->IO_Address, 0x80,
+			 Controller->FullModelName))
+	  	{
+	      	DAC960_Error("Unable request region at 0x%x\n", Controller->IO_Address);
+	      	goto Failure;
+		}
 	  DAC960_PD_DisableInterrupts(BaseAddress);
 	  DAC960_PD_AcknowledgeStatus(BaseAddress);
 	  udelay(1000);
@@ -2436,8 +2440,12 @@
 	    DAC960_V1_QueueReadWriteCommand;
 	  break;
 	case DAC960_P_Controller:
-	  request_region(Controller->IO_Address, 0x80,
-			 Controller->FullModelName);
+	  if (!request_region(Controller->IO_Address, 0x80,
+			 Controller->FullModelName))
+	  	{
+	      	DAC960_Error("Unable request region at 0x%x\n", Controller->IO_Address);
+	      	goto Failure;
+		}
 	  DAC960_PD_DisableInterrupts(BaseAddress);
 	  DAC960_PD_AcknowledgeStatus(BaseAddress);
 	  udelay(1000);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/block/paride/paride.c trivial-2.5.7/drivers/block/paride/paride.c
--- linux-2.5.7/drivers/block/paride/paride.c	Fri Oct 12 02:04:57 2001
+++ trivial-2.5.7/drivers/block/paride/paride.c	Fri Mar 22 17:05:56 2002
@@ -276,9 +276,6 @@
 		range = 3;
 		if (pi->mode >= pi->proto->epp_first) range = 8;
 		if ((range == 8) && (pi->port % 8)) return 0;
-#ifndef CONFIG_PARPORT
-		if (check_region(pi->port,range)) return 0;
-#endif /* !CONFIG_PARPORT */
 		pi->reserved = range;
 		return (!pi_test_proto(pi,scratch,verbose));
 	}
@@ -287,9 +284,6 @@
 		range = 3;
 		if (pi->mode >= pi->proto->epp_first) range = 8;
 		if ((range == 8) && (pi->port % 8)) break;
-#ifndef CONFIG_PARPORT
-		if (check_region(pi->port,range)) break;
-#endif /* !CONFIG_PARPORT */
 		pi->reserved = range;
 		if (!pi_test_proto(pi,scratch,verbose)) best = pi->mode;
 	}
@@ -311,10 +305,6 @@
 	if (!pi_register_parport(pi,verbose))
 	  return 0;
 
-#ifndef CONFIG_PARPORT
-	if (check_region(pi->port,3)) return 0;
-#endif /* !CONFIG_PARPORT */
-
 	if (pi->proto->test_port) {
 		pi_claim(pi);
 		max = pi->proto->test_port(pi);
@@ -404,7 +394,11 @@
 	}
 
 #ifndef CONFIG_PARPORT
-	request_region(pi->port,pi->reserved,pi->device);
+	if (!request_region(pi->port,pi->reserved,pi->device))
+		{
+		printk(KERN_WARNING"paride: Unable to request region 0x%x\n", pi->port);
+		return 0;
+		}
 #endif /* !CONFIG_PARPORT */
 
 	if (pi->parname)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/block/ps2esdi.c trivial-2.5.7/drivers/block/ps2esdi.c
--- linux-2.5.7/drivers/block/ps2esdi.c	Fri Mar  8 14:49:15 2002
+++ trivial-2.5.7/drivers/block/ps2esdi.c	Fri Mar 22 17:05:56 2002
@@ -364,6 +364,12 @@
 	else
 		io_base = PRIMARY_IO_BASE;
 
+	if (!request_region(io_base, 4, "ed"))
+		{
+		printk(KERN_WARNING"Unable to request region 0x%x\n", io_base);
+		free_irq(PS2ESDI_IRQ, &ps2esdi_gendisk);
+		return;
+		}
 	/* get the dma arbitration level */
 	dma_arb_level = (status >> 2) & 0xf;
 
@@ -416,7 +422,7 @@
 		ps2esdi_blocksizes[i] = 1024;
 
 	request_dma(dma_arb_level, "ed");
-	request_region(io_base, 4, "ed");
+
 	blksize_size[MAJOR_NR] = ps2esdi_blocksizes;
 	blk_queue_max_sectors(BLK_DEFAULT_QUEUE(MAJOR_NR), 128);
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/block/xd.c trivial-2.5.7/drivers/block/xd.c
--- linux-2.5.7/drivers/block/xd.c	Fri Mar  8 14:49:15 2002
+++ trivial-2.5.7/drivers/block/xd.c	Fri Mar 22 17:05:56 2002
@@ -214,12 +214,12 @@
 
 		printk("Detected a%s controller (type %d) at address %06x\n",
 			xd_sigs[controller].name,controller,address);
-		if (check_region(xd_iobase,4)) {
+		if (!request_region(xd_iobase,4,"xd"))
+			{
 			printk("xd: Ports at 0x%x are not available\n",
 				xd_iobase);
 			return;
-		}
-		request_region(xd_iobase,4,"xd");
+			}
 		if (controller)
 			xd_sigs[controller].init_controller(address);
 		xd_drives = xd_initdrives(xd_sigs[controller].init_drive);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/cdrom/cdu31a.c trivial-2.5.7/drivers/cdrom/cdu31a.c
--- linux-2.5.7/drivers/cdrom/cdu31a.c	Wed Feb 20 17:57:07 2002
+++ trivial-2.5.7/drivers/cdrom/cdu31a.c	Fri Mar 22 17:05:56 2002
@@ -3372,7 +3372,8 @@
 	if (drive_found) {
 		int deficiency = 0;
 
-		request_region(cdu31a_port, 4, "cdu31a");
+		if (!request_region(cdu31a_port, 4, "cdu31a"))
+			goto errout3;
 
 		if (devfs_register_blkdev(MAJOR_NR, "cdu31a", &scd_bdops)) {
 			printk("Unable to get major %d for CDU-31a\n",
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/cdrom/optcd.c trivial-2.5.7/drivers/cdrom/optcd.c
--- linux-2.5.7/drivers/cdrom/optcd.c	Wed Feb 20 17:57:07 2002
+++ trivial-2.5.7/drivers/cdrom/optcd.c	Fri Mar 22 17:05:57 2002
@@ -2032,29 +2032,33 @@
 			"optcd: no Optics Storage CDROM Initialization\n");
 		return -EIO;
 	}
-	if (check_region(optcd_port, 4)) {
-		printk(KERN_ERR "optcd: conflict, I/O port 0x%x already used\n",
-			optcd_port);
+	if (!request_region(optcd_port, 4, "optcd"))
+		{
+		printk(KERN_WARNING"optcd: Unable to request region 0x%x\n", optcd_port);
 		return -EIO;
-	}
+		}
 
 	if (!reset_drive()) {
 		printk(KERN_ERR "optcd: drive at 0x%x not ready\n", optcd_port);
+		release_region(optcd_port, 4);
 		return -EIO;
 	}
 	if (!version_ok()) {
 		printk(KERN_ERR "optcd: unknown drive detected; aborting\n");
+		release_region(optcd_port, 4);
 		return -EIO;
 	}
 	status = exec_cmd(COMINITDOUBLE);
 	if (status < 0) {
 		printk(KERN_ERR "optcd: cannot init double speed mode\n");
 		DEBUG((DEBUG_VFS, "exec_cmd COMINITDOUBLE: %02x", -status));
+		release_region(optcd_port, 4);
 		return -EIO;
 	}
 	if (devfs_register_blkdev(MAJOR_NR, "optcd", &opt_fops) != 0)
 	{
 		printk(KERN_ERR "optcd: unable to get major %d\n", MAJOR_NR);
+		release_region(optcd_port, 4);
 		return -EIO;
 	}
 	devfs_register (NULL, "optcd", DEVFS_FL_DEFAULT, MAJOR_NR, 0,
@@ -2062,7 +2066,7 @@
 	blksize_size[MAJOR_NR] = &blksize;
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,
 		       &optcd_lock);
-	request_region(optcd_port, 4, "optcd");
+
 	register_disk(NULL, mk_kdev(MAJOR_NR,0), 1, &opt_fops, 0);
 
 	printk(KERN_INFO "optcd: DOLPHIN 8000 AT CDROM at 0x%x\n", optcd_port);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/cdrom/sbpcd.c trivial-2.5.7/drivers/cdrom/sbpcd.c
--- linux-2.5.7/drivers/cdrom/sbpcd.c	Wed Feb 20 17:57:07 2002
+++ trivial-2.5.7/drivers/cdrom/sbpcd.c	Fri Mar 22 17:05:58 2002
@@ -5840,6 +5840,12 @@
 		if (i>=0) D_S[j].CD_changed=1;
 	}
 	
+	if (!request_region(CDo_command,4,major_name))
+		{
+		printk(KERN_WARNING "sbpcd: Unable to request region 0x%x\n", CDo_command);
+		return -EIO;
+		}
+	
 	/*
 	 * Turn on the CD audio channels.
 	 * The addresses are obtained from SOUND_BASE (see sbpcd.h).
@@ -5866,8 +5872,7 @@
 #endif
 	read_ahead[MAJOR_NR] = buffers * (CD_FRAMESIZE / 512);
 	
-	request_region(CDo_command,4,major_name);
-	
+
 	devfs_handle = devfs_mk_dir (NULL, "sbp", NULL);
 	for (j=0;j<NR_SBPCD;j++)
 	{
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/cdrom/sonycd535.c trivial-2.5.7/drivers/cdrom/sonycd535.c
--- linux-2.5.7/drivers/cdrom/sonycd535.c	Wed Feb 20 17:57:07 2002
+++ trivial-2.5.7/drivers/cdrom/sonycd535.c	Fri Mar 22 17:05:57 2002
@@ -1487,6 +1487,7 @@
 	int  got_result = 0;
 	int  tmp_irq;
 	int  i;
+	devfs_handle_t sony_devfs_handle;
 
 	/* Setting the base I/O address to 0 will disable it. */
 	if ((sony535_cd_base_io == 0xffff)||(sony535_cd_base_io == 0))
@@ -1510,11 +1511,6 @@
 	printk(KERN_INFO CDU535_MESSAGE_NAME ": probing base address %03X\n",
 			sony535_cd_base_io);
 #endif
-	if (check_region(sony535_cd_base_io,4)) {
-		printk(CDU535_MESSAGE_NAME ": my base address is not free!\n");
-		return -EIO;
-	}
-
 	/* look for the CD-ROM, follows the procedure in the DOS driver */
 	inb(select_unit_reg);
 	/* wait for 40 18 Hz ticks (reverse-engineered from DOS driver) */
@@ -1586,13 +1582,14 @@
 					printk("IRQ%d, ", tmp_irq);
 				printk("using %d byte buffer\n", sony_buffer_size);
 
-				devfs_register (NULL, CDU535_HANDLE,
-						DEVFS_FL_DEFAULT,
-						MAJOR_NR, 0,
-						S_IFBLK | S_IRUGO | S_IWUGO,
-						&cdu_fops, NULL);
+				sony_devfs_handle = devfs_register (NULL, CDU535_HANDLE,
+								DEVFS_FL_DEFAULT,
+								MAJOR_NR, 0,
+								S_IFBLK | S_IRUGO | S_IWUGO,
+								&cdu_fops, NULL);
 				if (devfs_register_blkdev(MAJOR_NR, CDU535_HANDLE, &cdu_fops)) {
 					printk("Unable to get major %d for %s\n",
+					devfs_unregister(sony_devfs_handle);
 							MAJOR_NR, CDU535_MESSAGE_NAME);
 					return -EIO;
 				}
@@ -1603,6 +1600,8 @@
 					kmalloc(sizeof *sony_toc, GFP_KERNEL);
 				if (sony_toc == NULL) {
 					blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
+					devfs_unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
+					devfs_unregister(sony_devfs_handle);
 					return -ENOMEM;
 				}
 				last_sony_subcode = (struct s535_sony_subcode *)
@@ -1610,6 +1609,8 @@
 				if (last_sony_subcode == NULL) {
 					blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 					kfree(sony_toc);
+					devfs_unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
+					devfs_unregister(sony_devfs_handle);
 					return -ENOMEM;
 				}
 				sony_buffer = (Byte **)
@@ -1618,6 +1619,8 @@
 					blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 					kfree(sony_toc);
 					kfree(last_sony_subcode);
+					devfs_unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
+					devfs_unregister(sony_devfs_handle);
 					return -ENOMEM;
 				}
 				for (i = 0; i < sony_buffer_sectors; i++) {
@@ -1630,6 +1633,8 @@
 						kfree(sony_buffer);
 						kfree(sony_toc);
 						kfree(last_sony_subcode);
+						devfs_unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
+						devfs_unregister(sony_devfs_handle);
 						return -ENOMEM;
 					}
 				}
@@ -1642,7 +1647,25 @@
 		printk("Did not find a " CDU535_MESSAGE_NAME " drive\n");
 		return -EIO;
 	}
-	request_region(sony535_cd_base_io, 4, CDU535_HANDLE);
+	if (request_region(sony535_cd_base_io, 4, CDU535_HANDLE))
+		{
+		printk(KERN_WARNING"sonycd535: Unable to request region 0x%x\n",
+			sony535_cd_base_io);
+		for (i = 0; i < sony_buffer_sectors; i++)
+			if (sony_buffer[i]) 
+				kfree(sony_buffer[i]);
+		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
+		kfree(sony_buffer);
+		kfree(sony_toc);
+		kfree(last_sony_subcode);
+		devfs_unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
+		devfs_unregister(sony_devfs_handle);
+		if (sony535_irq_used)
+			free_irq(sony535_irq_used, NULL);
+		}
+	
+		return -EIO;
+		}
 	register_disk(NULL, mk_kdev(MAJOR_NR,0), 1, &cdu_fops, 0);
 	return 0;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/acquirewdt.c trivial-2.5.7/drivers/char/acquirewdt.c
--- linux-2.5.7/drivers/char/acquirewdt.c	Fri Mar  8 14:49:15 2002
+++ trivial-2.5.7/drivers/char/acquirewdt.c	Fri Mar 22 17:05:57 2002
@@ -209,8 +209,18 @@
 	spin_lock_init(&acq_lock);
 	if (misc_register(&acq_miscdev))
 		return -ENODEV;
-	request_region(WDT_STOP, 1, "Acquire WDT");
-	request_region(WDT_START, 1, "Acquire WDT");
+	if (!request_region(WDT_STOP, 1, "Acquire WDT"))
+		{
+		misc_deregister(&acq_miscdev);
+		return -EIO;
+		}
+	if (!request_region(WDT_START, 1, "Acquire WDT"))
+		{
+		release_region(WDT_STOP, 1);
+		misc_deregister(&acq_miscdev);
+		return -EIO;
+		}
+
 	register_reboot_notifier(&acq_notifier);
 	return 0;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/advantechwdt.c trivial-2.5.7/drivers/char/advantechwdt.c
--- linux-2.5.7/drivers/char/advantechwdt.c	Wed Feb 20 17:55:23 2002
+++ trivial-2.5.7/drivers/char/advantechwdt.c	Fri Mar 22 17:05:57 2002
@@ -213,11 +213,22 @@
 	printk("WDT driver for Advantech single board computer initialising.\n");
 
 	spin_lock_init(&advwdt_lock);
-	misc_register(&advwdt_miscdev);
+	if (misc_register(&advwdt_miscdev))
+		return -ENODEV;
 #if WDT_START != WDT_STOP
-	request_region(WDT_STOP, 1, "Advantech WDT");
+	if (!request_region(WDT_STOP, 1, "Advantech WDT"))
+		{
+		misc_deregister(&advwdt_miscdev);
+		return -EIO;
+		}
 #endif
-	request_region(WDT_START, 1, "Advantech WDT");
+	if (!request_region(WDT_START, 1, "Advantech WDT")) {
+		misc_deregister(&advwdt_miscdev);
+#if WDT_START != WDT_STOP
+		release_region(WDT_STOP, 1);
+#endif
+		return -EIO;
+	}
 	register_reboot_notifier(&advwdt_notifier);
 	return 0;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/cyclades.c trivial-2.5.7/drivers/char/cyclades.c
--- linux-2.5.7/drivers/char/cyclades.c	Wed Feb 20 17:55:23 2002
+++ trivial-2.5.7/drivers/char/cyclades.c	Fri Mar 22 17:05:57 2002
@@ -5012,7 +5012,8 @@
 		/* Although we don't use this I/O region, we should
 		   request it from the kernel anyway, to avoid problems
 		   with other drivers accessing it. */
-		request_region(cy_pci_phys1, CyPCI_Yctl, "Cyclom-Y");
+		if (!request_region(cy_pci_phys1, CyPCI_Yctl, "Cyclom-Y"))
+			continue;
 
 #if defined(__alpha__)
                 if (device_id  == PCI_DEVICE_ID_CYCLOM_Y_Lo) { /* below 1M? */
@@ -5162,7 +5163,8 @@
 		/* Although we don't use this I/O region, we should
 		   request it from the kernel anyway, to avoid problems
 		   with other drivers accessing it. */
-		request_region(cy_pci_phys1, CyPCI_Zctl, "Cyclades-Z");
+		if (!request_region(cy_pci_phys1, CyPCI_Zctl, "Cyclades-Z"))
+			continue;
 
 		if (mailbox == ZE_V1) {
 		    cy_pci_addr2 = (ulong)ioremap(cy_pci_phys2, CyPCI_Ze_win);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/dtlk.c trivial-2.5.7/drivers/char/dtlk.c
--- linux-2.5.7/drivers/char/dtlk.c	Wed Feb 20 17:55:23 2002
+++ trivial-2.5.7/drivers/char/dtlk.c	Fri Mar 22 17:05:58 2002
@@ -418,12 +418,11 @@
 		       dtlk_portlist[i], (testval = inw_p(dtlk_portlist[i])));
 #endif
 
-		if (check_region(dtlk_portlist[i], DTLK_IO_EXTENT))
+		if (!request_region(dtlk_portlist[i], DTLK_IO_EXTENT, 
+			       "dtlk"))
 			continue;
 		testval = inw_p(dtlk_portlist[i]);
 		if ((testval &= 0xfbff) == 0x107f) {
-			request_region(dtlk_portlist[i], DTLK_IO_EXTENT, 
-				       "dtlk");
 			dtlk_port_lpc = dtlk_portlist[i];
 			dtlk_port_tts = dtlk_port_lpc + 1;
 
@@ -508,6 +507,7 @@
 
 			return 0;
 		}
+		release_region(dtlk_portlist[i], DTLK_IO_EXTENT);
 	}
 
 	printk(KERN_INFO "\nDoubleTalk PC - not found\n");
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/epca.c trivial-2.5.7/drivers/char/epca.c
--- linux-2.5.7/drivers/char/epca.c	Wed Feb 20 17:55:23 2002
+++ trivial-2.5.7/drivers/char/epca.c	Fri Mar 22 17:05:58 2002
@@ -2020,7 +2020,8 @@
 	    (*(ushort *)((ulong)memaddr + XEPORTS) < 3))
 		shrinkmem = 1;
 	if (bd->type < PCIXEM)
-		request_region((int)bd->port, 4, board_desc[bd->type]);
+		if (!request_region((int)bd->port, 4, board_desc[bd->type]))
+			return;		
 
 	memwinon(bd, 0);
 
@@ -2184,9 +2185,13 @@
 		if (!(ch->tmp_buf))
 		{
 			printk(KERN_ERR "POST FEP INIT : kmalloc failed for port 0x%x\n",i);
-
+			release_region((int)bd->port, 4);
+			while(i-- > 0)
+				kfree((ch--)->tmp_buf);
+			return;
 		}
-		memset((void *)ch->tmp_buf,0,ch->txbufsize);
+		else 
+			memset((void *)ch->tmp_buf,0,ch->txbufsize);
 	} /* End for each port */
 
 	printk(KERN_INFO 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/esp.c trivial-2.5.7/drivers/char/esp.c
--- linux-2.5.7/drivers/char/esp.c	Wed Feb 20 17:56:33 2002
+++ trivial-2.5.7/drivers/char/esp.c	Fri Mar 22 17:05:57 2002
@@ -2476,9 +2476,13 @@
 			} else
 				*region_start = info->port;
 
-			request_region(*region_start,
+			if (!request_region(*region_start,
 				       info->port - *region_start + 8,
-				       "esp serial");
+				       "esp serial"))
+				{
+				restore_flags(flags);
+				return -EIO;
+				}
 
 			/* put card in enhanced mode */
 			/* this prevents access through */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/ftape/lowlevel/fdc-io.c trivial-2.5.7/drivers/char/ftape/lowlevel/fdc-io.c
--- linux-2.5.7/drivers/char/ftape/lowlevel/fdc-io.c	Wed Feb 20 17:57:07 2002
+++ trivial-2.5.7/drivers/char/ftape/lowlevel/fdc-io.c	Fri Mar 22 17:05:58 2002
@@ -1209,27 +1209,35 @@
 	TRACE_FUN(ft_t_flow);
 
 	if (ft_mach2 || ft_probe_fc10) {
-		if (check_region(fdc.sra, 8) < 0) {
+		if (!request_region(fdc.sra, 8, "fdc (ft)")) 
+			{
 #ifndef BROKEN_FLOPPY_DRIVER
 			TRACE_EXIT -EBUSY;
 #else
-			TRACE(ft_t_warn,
-"address 0x%03x occupied (by floppy driver?), using it anyway", fdc.sra);
+			TRACE(ft_t_warn, "address 0x%03x occupied (by floppy driver?), using it anyway", fdc.sra);
 #endif
-		}
-		request_region(fdc.sra, 8, "fdc (ft)");
-	} else {
-		if (check_region(fdc.sra, 6) < 0 || 
-		    check_region(fdc.dir, 1) < 0) {
+			}
+		
+		if (!request_region(fdc.sra, 6, "fdc (ft)"))
+			{
+			release_region(fdc.sra, 8);
 #ifndef BROKEN_FLOPPY_DRIVER
 			TRACE_EXIT -EBUSY;
 #else
-			TRACE(ft_t_warn,
-"address 0x%03x occupied (by floppy driver?), using it anyway", fdc.sra);
+			TRACE(ft_t_warn, "address 0x%03x occupied (by floppy driver?), using it anyway", fdc.sra);
 #endif
-		}
-		request_region(fdc.sra, 6, "fdc (ft)");
-		request_region(fdc.sra + 7, 1, "fdc (ft)");
+			}
+	
+		if (!request_region(fdc.sra+7, 1, "fdc (ft)"))
+			{
+			release_region(fdc.sra, 8);
+			release_region(fdc.sra, 6);
+#ifndef BROKEN_FLOPPY_DRIVER
+			TRACE_EXIT -EBUSY;
+#else
+			TRACE(ft_t_warn, "address 0x%03x occupied (by floppy driver?), using it anyway", fdc.sra);
+#endif
+			}
 	}
 	TRACE_EXIT 0;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/h8.c trivial-2.5.7/drivers/char/h8.c
--- linux-2.5.7/drivers/char/h8.c	Wed Feb 20 17:55:24 2002
+++ trivial-2.5.7/drivers/char/h8.c	Fri Mar 22 17:05:57 2002
@@ -299,9 +299,13 @@
         }
         printk(KERN_INFO "H8 at 0x%x IRQ %d\n", h8_base, h8_irq);
 
-        create_proc_info_entry("driver/h8", 0, NULL, h8_get_info);
+        if (!request_region(h8_base, 8, "h8"))
+		{
+		free_irq(h8_irq, NULL);
+		return -EIO;
+		}
 
-        request_region(h8_base, 8, "h8");
+        create_proc_info_entry("driver/h8", 0, NULL, h8_get_info);
 
 	h8_alloc_queues();
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/ib700wdt.c trivial-2.5.7/drivers/char/ib700wdt.c
--- linux-2.5.7/drivers/char/ib700wdt.c	Wed Feb 20 17:55:24 2002
+++ trivial-2.5.7/drivers/char/ib700wdt.c	Fri Mar 22 17:05:57 2002
@@ -242,11 +242,23 @@
 	printk("WDT driver for IB700 single board computer initialising.\n");
 
 	spin_lock_init(&ibwdt_lock);
-	misc_register(&ibwdt_miscdev);
+	if (misc_register(&ibwdt_miscdev))
+		return -ENODEV;
 #if WDT_START != WDT_STOP
-	request_region(WDT_STOP, 1, "IB700 WDT");
+	if (!request_region(WDT_STOP, 1, "IB700 WDT"))
+		{
+		misc_deregister(&ibwdt_miscdev);
+		return -EIO;
+		}
 #endif
-	request_region(WDT_START, 1, "IB700 WDT");
+	if (!request_region(WDT_START, 1, "IB700 WDT"))
+		{
+#if WDT_START != WDT_STOP
+		release_region(WDT_STOP, 1);
+#endif
+		misc_deregister(&ibwdt_miscdev);
+		return -EIO;
+		}
 	register_reboot_notifier(&ibwdt_notifier);
 	return 0;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/ip2main.c trivial-2.5.7/drivers/char/ip2main.c
--- linux-2.5.7/drivers/char/ip2main.c	Wed Feb 20 17:55:24 2002
+++ trivial-2.5.7/drivers/char/ip2main.c	Fri Mar 22 17:05:57 2002
@@ -1000,12 +1000,10 @@
 	printk(KERN_INFO "IP2: Board %d: addr=0x%x irq=%d\n", boardnum + 1,
 	       ip2config.addr[boardnum], ip2config.irq[boardnum] );
 
-	if (0 != ( rc = check_region( ip2config.addr[boardnum], 8))) {
-		printk(KERN_ERR "IP2: bad addr=0x%x rc = %d\n",
-				ip2config.addr[boardnum], rc );
+	if (!request_region( ip2config.addr[boardnum], 8, pcName )) {
+		printk(KERN_ERR "IP2: bad addr=0x%x\n", ip2config.addr[boardnum]);
 		goto err_initialize;
 	}
-	request_region( ip2config.addr[boardnum], 8, pcName );
 
 	if ( iiDownloadAll ( pB, (loadHdrStrPtr)Fip_firmware, 1, Fip_firmware_size )
 	    != II_DOWN_GOOD ) {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/isicom.c trivial-2.5.7/drivers/char/isicom.c
--- linux-2.5.7/drivers/char/isicom.c	Wed Feb 20 17:55:24 2002
+++ trivial-2.5.7/drivers/char/isicom.c	Fri Mar 22 17:05:58 2002
@@ -1680,20 +1680,13 @@
 {
 	int count, done=0;
 	for (count=0; count < BOARD_COUNT; count++ ) {
-		if (isi_card[count].base) {
-			if (check_region(isi_card[count].base,16)) {
+		if (isi_card[count].base)
+			if (!request_region(isi_card[count].base,16,ISICOM_NAME)) {
 				printk(KERN_DEBUG "ISICOM: I/O Region 0x%x-0x%x is busy. Card%d will be disabled.\n",
 					isi_card[count].base,isi_card[count].base+15,count+1);
 				isi_card[count].base=0;
-			}
-			else {
-				request_region(isi_card[count].base,16,ISICOM_NAME);
-#ifdef ISICOM_DEBUG				
-				printk(KERN_DEBUG "ISICOM: I/O Region 0x%x-0x%x requested for Card%d.\n",isi_card[count].base,isi_card[count].base+15,count+1);
-#endif				
 				done++;
 			}
-		}	
 	}
 	return done;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/istallion.c trivial-2.5.7/drivers/char/istallion.c
--- linux-2.5.7/drivers/char/istallion.c	Wed Feb 20 17:55:24 2002
+++ trivial-2.5.7/drivers/char/istallion.c	Fri Mar 22 17:05:57 2002
@@ -3971,17 +3971,16 @@
 	printk(KERN_DEBUG "stli_initecp(brdp=%x)\n", (int) brdp);
 #endif
 
-/*
- *	Do a basic sanity check on the IO and memory addresses.
- */
+	if (!request_region(brdp->iobase, brdp->iosize, name))
+		return -EIO;
+	
 	if ((brdp->iobase == 0) || (brdp->memaddr == 0))
+		{
+		release_region(brdp->iobase, brdp->iosize);
 		return(-ENODEV);
+		}
 
 	brdp->iosize = ECP_IOSIZE;
-	if (check_region(brdp->iobase, brdp->iosize))
-		printk(KERN_ERR "STALLION: Warning, board %d I/O address %x "
-				"conflicts with another device\n",
-				brdp->brdnr, brdp->iobase);
 
 /*
  *	Based on the specific board type setup the common vars to access
@@ -4046,6 +4045,7 @@
 		break;
 
 	default:
+		release_region(brdp->iobase, brdp->iosize);
 		return(-EINVAL);
 	}
 
@@ -4059,7 +4059,10 @@
 
 	brdp->membase = ioremap(brdp->memaddr, brdp->memsize);
 	if (brdp->membase == (void *) NULL)
+		{
+		release_region(brdp->iobase, brdp->iosize);
 		return(-ENOMEM);
+		}
 
 /*
  *	Now that all specific code is set up, enable the shared memory and
@@ -4081,7 +4084,10 @@
 #endif
 
 	if (sig.magic != ECP_MAGIC)
+		{
+		release_region(brdp->iobase, brdp->iosize);
 		return(-ENODEV);
+		}
 
 /*
  *	Scan through the signature looking at the panels connected to the
@@ -4102,7 +4108,7 @@
 		brdp->nrpanels++;
 	}
 
-	request_region(brdp->iobase, brdp->iosize, name);
+
 	brdp->state |= BST_FOUND;
 	return(0);
 }
@@ -4132,10 +4138,9 @@
 		return(-ENODEV);
 
 	brdp->iosize = ONB_IOSIZE;
-	if (check_region(brdp->iobase, brdp->iosize))
-		printk(KERN_ERR "STALLION: Warning, board %d I/O address %x "
-				"conflicts with another device\n",
-				brdp->brdnr, brdp->iobase);
+	
+	if (!request_region(brdp->iobase, brdp->iosize, name))
+		return -EIO;
 
 /*
  *	Based on the specific board type setup the common vars to access
@@ -4210,6 +4215,7 @@
 		break;
 
 	default:
+		release_region(brdp->iobase, brdp->iosize);
 		return(-EINVAL);
 	}
 
@@ -4223,7 +4229,10 @@
 
 	brdp->membase = ioremap(brdp->memaddr, brdp->memsize);
 	if (brdp->membase == (void *) NULL)
+		{
+		release_region(brdp->iobase, brdp->iosize);
 		return(-ENOMEM);
+		}
 
 /*
  *	Now that all specific code is set up, enable the shared memory and
@@ -4243,7 +4252,10 @@
 
 	if ((sig.magic0 != ONB_MAGIC0) || (sig.magic1 != ONB_MAGIC1) ||
 	    (sig.magic2 != ONB_MAGIC2) || (sig.magic3 != ONB_MAGIC3))
+		{
+		release_region(brdp->iobase, brdp->iosize);
 		return(-ENODEV);
+		}
 
 /*
  *	Scan through the signature alive mask and calculate how many ports
@@ -4261,7 +4273,7 @@
 	}
 	brdp->panels[0] = brdp->nrports;
 
-	request_region(brdp->iobase, brdp->iosize, name);
+
 	brdp->state |= BST_FOUND;
 	return(0);
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/ite_gpio.c trivial-2.5.7/drivers/char/ite_gpio.c
--- linux-2.5.7/drivers/char/ite_gpio.c	Wed Feb 20 17:55:24 2002
+++ trivial-2.5.7/drivers/char/ite_gpio.c	Fri Mar 22 17:05:58 2002
@@ -391,13 +391,14 @@
 {
 	int i;
 
-	misc_register(&ite_gpio_miscdev);
+	if (misc_register(&ite_gpio_miscdev))
+		return -ENODEV;
 
-	if (check_region(ite_gpio_base, 0x1c) < 0 ) {
-           return -ENODEV;
-        } else {
-           request_region(ite_gpio_base, 0x1c, "ITE GPIO");
-        }     
+	if (!request_region(ite_gpio_base, 0x1c, "ITE GPIO"))
+		{
+		misc_deregister(&ite_gpio_miscdev);
+		return -EIO;
+		}
 
 	/* initialize registers */
         ITE_GPACR = 0xffff;
@@ -407,13 +408,18 @@
         ITE_GPBICR = 0x00ff;
         ITE_GPCICR = 0x00ff;
         ITE_GCR = 0;
-
+	
 	for (i = 0; i < MAX_GPIO_LINE; i++) {
 		ite_gpio_irq_pending[i]=0;	
 		init_waitqueue_head(&ite_gpio_wait[i]);
 	}
-	if (request_irq(ite_gpio_irq, ite_gpio_irq_handler, SA_SHIRQ, "gpio", 0) < 0)
+
+	if (request_irq(ite_gpio_irq, ite_gpio_irq_handler, SA_SHIRQ, "gpio", 0) < 0) {
+		misc_deregister(&ite_gpio_miscdev);
+		release_region(ite_gpio_base, 0x1c);
 		return 0;
+	}
+
 	printk("GPIO at 0x%x (irq = %d)\n", ite_gpio_base, ite_gpio_irq);
 
 	return 0;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/logibusmouse.c trivial-2.5.7/drivers/char/logibusmouse.c
--- linux-2.5.7/drivers/char/logibusmouse.c	Fri Sep 14 08:21:32 2001
+++ trivial-2.5.7/drivers/char/logibusmouse.c	Fri Mar 22 17:05:58 2002
@@ -128,25 +128,28 @@
 
 static int __init logi_busmouse_init(void)
 {
-	if (check_region(LOGIBM_BASE, LOGIBM_EXTENT))
+	if (!request_region(LOGIBM_BASE, LOGIBM_EXTENT, "busmouse"))
 		return -EIO;
 
 	outb(MSE_CONFIG_BYTE, MSE_CONFIG_PORT);
 	outb(MSE_SIGNATURE_BYTE, MSE_SIGNATURE_PORT);
 	udelay(100L);	/* wait for reply from mouse */
-	if (inb(MSE_SIGNATURE_PORT) != MSE_SIGNATURE_BYTE)
+	if (inb(MSE_SIGNATURE_PORT) != MSE_SIGNATURE_BYTE) {
+		release_region(LOGIBM_BASE, LOGIBM_EXTENT);
 		return -EIO;
+	}
 
 	outb(MSE_DEFAULT_MODE, MSE_CONFIG_PORT);
 	MSE_INT_OFF();
 	
-	request_region(LOGIBM_BASE, LOGIBM_EXTENT, "busmouse");
-
 	msedev = register_busmouse(&busmouse);
-	if (msedev < 0)
+	if (msedev < 0) {
+		release_region(LOGIBM_BASE, LOGIBM_EXTENT);
 		printk(KERN_WARNING "Unable to register busmouse driver.\n");
+	} 
 	else
 		printk(KERN_INFO "Logitech busmouse installed.\n");
+	
 	return msedev < 0 ? msedev : 0;
 }
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/mixcomwd.c trivial-2.5.7/drivers/char/mixcomwd.c
--- linux-2.5.7/drivers/char/mixcomwd.c	Wed Feb 20 17:55:08 2002
+++ trivial-2.5.7/drivers/char/mixcomwd.c	Fri Mar 22 17:05:58 2002
@@ -239,11 +239,15 @@
 		return -ENODEV;
 	}
 
-	request_region(watchdog_port,1,"MixCOM watchdog");
+	if (!request_region(watchdog_port,1,"MixCOM watchdog"))
+		return -EIO;
 		
 	ret = misc_register(&mixcomwd_miscdev);
 	if (ret)
+		{
+		release_region(watchdog_port, 1);
 		return ret;
+		}
 	
 	printk(KERN_INFO "MixCOM watchdog driver v%s, watchdog port at 0x%3x\n",VERSION,watchdog_port);
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/msbusmouse.c trivial-2.5.7/drivers/char/msbusmouse.c
--- linux-2.5.7/drivers/char/msbusmouse.c	Fri Sep 14 08:21:32 2001
+++ trivial-2.5.7/drivers/char/msbusmouse.c	Fri Mar 22 17:05:58 2002
@@ -149,11 +149,15 @@
 	}
 	if (present == 0)
 		return -EIO;
+	if (!request_region(MS_MSE_CONTROL_PORT, 0x04, "MS Busmouse"))
+		return -EIO;
+	
 	MS_MSE_INT_OFF();
-	request_region(MS_MSE_CONTROL_PORT, 0x04, "MS Busmouse");
 	msedev = register_busmouse(&msbusmouse);
-	if (msedev < 0)
+	if (msedev < 0) {
 		printk(KERN_WARNING "Unable to register msbusmouse driver.\n");
+		release_region(MS_MSE_CONTROL_PORT, 0x04);
+	}
 	else
 		printk(KERN_INFO "Microsoft BusMouse detected and installed.\n");
 	return msedev < 0 ? msedev : 0;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/pcwd.c trivial-2.5.7/drivers/char/pcwd.c
--- linux-2.5.7/drivers/char/pcwd.c	Wed Feb 20 17:57:07 2002
+++ trivial-2.5.7/drivers/char/pcwd.c	Fri Mar 22 17:05:58 2002
@@ -114,12 +114,6 @@
 {
 	int card_dat, prev_card_dat, found = 0, count = 0, done = 0;
 
-	/* As suggested by Alan Cox - this is a safety measure. */
-	if (check_region(current_readport, 4)) {
-		printk("pcwd: Port 0x%x unavailable.\n", current_readport);
-		return 0;
-	}
-
 	card_dat = 0x00;
 	prev_card_dat = 0x00;
 
@@ -628,15 +622,31 @@
 		outb_p(0xA5, current_readport + 3);
 	}
 
-	if (revision == PCWD_REVISION_A)
-		request_region(current_readport, 2, "PCWD Rev.A (Berkshire)");
-	else
-		request_region(current_readport, 4, "PCWD Rev.C (Berkshire)");
+	if (misc_register(&pcwd_miscdev))
+		return -ENODEV;
+	
+	if (supports_temp)
+		if (misc_register(&temp_miscdev)) {
+			misc_deregister(&pcwd_miscdev);
+			return -ENODEV;		
+		}
 
-	misc_register(&pcwd_miscdev);
 
-	if (supports_temp)
-		misc_register(&temp_miscdev);
+	if (revision == PCWD_REVISION_A) {
+		if (!request_region(current_readport, 2, "PCWD Rev.A (Berkshire)")) {
+			misc_deregister(&pcwd_miscdev);
+			if (supports_temp)
+				misc_deregister(&pcwd_miscdev);
+			return -EIO;		
+		}
+	}
+	else 
+		if (!request_region(current_readport, 4, "PCWD Rev.C (Berkshire)")) {
+			misc_deregister(&pcwd_miscdev);
+			if (supports_temp)
+				misc_deregister(&pcwd_miscdev);
+			return -EIO;
+		}
 
 	return 0;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/rocket.c trivial-2.5.7/drivers/char/rocket.c
--- linux-2.5.7/drivers/char/rocket.c	Thu Mar 21 14:14:44 2002
+++ trivial-2.5.7/drivers/char/rocket.c	Fri Mar 22 17:05:58 2002
@@ -2086,11 +2086,13 @@
 	       num_aiops);
 	if (rcktpt_io_addr[i] + 0x40 == controller) {
 		*reserved_controller = 1;
-		request_region(rcktpt_io_addr[i], 68,
-				       "Comtrol Rocketport");
+		if (!request_region(rcktpt_io_addr[i], 68,
+				       "Comtrol Rocketport"))
+			return 0;
 	} else {
-		request_region(rcktpt_io_addr[i], 64,
-			       "Comtrol Rocketport");
+		if (!request_region(rcktpt_io_addr[i], 64,
+			       "Comtrol Rocketport"))
+			return 0;
 	}
 	return(1);
 }
@@ -2178,7 +2180,11 @@
 	}
 
 	if (reserved_controller == 0)
-		request_region(controller, 4, "Comtrol Rocketport");
+		if (!request_region(controller, 4, "Comtrol Rocketport"))
+			{
+			rocket_timer.function = 0;
+			return -EIO;
+			}
 
 	/*
 	 * Set up the tty driver structure and then register this
@@ -2245,6 +2251,7 @@
 	if (retval < 0) {
 		printk("Couldn't install Rocketport callout driver "
 		       "(error %d)\n", -retval);
+		release_region(controller, 4);
 		return -1;
 	}
 
@@ -2252,6 +2259,7 @@
 	if (retval < 0) {
 		printk("Couldn't install tty Rocketport driver "
 		       "(error %d)\n", -retval);
+		release_region(controller, 4);
 		return -1;
 	}
 #ifdef ROCKET_DEBUG_OPEN
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/rtc.c trivial-2.5.7/drivers/char/rtc.c
--- linux-2.5.7/drivers/char/rtc.c	Fri Mar  8 14:49:15 2002
+++ trivial-2.5.7/drivers/char/rtc.c	Fri Mar 22 17:05:58 2002
@@ -830,10 +830,19 @@
 	}
 #endif
 
-	request_region(RTC_PORT(0), RTC_IO_EXTENT, "rtc");
+	if (!request_region(RTC_PORT(0), RTC_IO_EXTENT, "rtc"))
+		{
+		free_irq(RTC_IRQ, NULL);
+		return -EIO;
+		}
 #endif /* __sparc__ vs. others */
 
-	misc_register(&rtc_dev);
+	if (misc_register(&rtc_dev))
+		{
+		free_irq(RTC_IRQ, NULL);
+		release_region(RTC_PORT(0), RTC_IO_EXTENT);
+		return -ENODEV;
+		}
 	create_proc_read_entry ("driver/rtc", 0, 0, rtc_read_proc, NULL);
 
 #if defined(__alpha__) || defined(__mips__)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7/drivers/char/serial.c trivial-2.5.7/drivers/char/serial.c
--- linux-2.5.7/drivers/char/serial.c	Wed Feb 20 17:57:07 2002
+++ trivial-2.5.7/drivers/char/serial.c	Fri Mar 22 17:05:58 2002
@@ -2186,11 +2186,15 @@
 	if ((state->type != PORT_UNKNOWN) && state->port) {
 #ifdef CONFIG_SERIAL_RSA
 		if (state->type == PORT_RSA)
-			request_region(state->port + UART_RSA_BASE,
-				       16, "serial_rsa(set)");
+			{
+			if (!request_region(state->port + UART_RSA_BASE,
+				       16, "serial_rsa(set)"))
+				return -EIO;
+			}
 		else
 #endif
-			request_region(state->port,8,"serial(set)");
+			if (!request_region(state->port,8,"serial(set)"))
+				return -EIO;
 	}
 
 	
