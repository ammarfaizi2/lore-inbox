Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWCWUIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWCWUIG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWCWUIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:08:05 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:8341 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964915AbWCWUIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:08:02 -0500
Date: Thu, 23 Mar 2006 15:07:44 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       arjan@infradead.org, Maneesh Soni <maneesh@in.ibm.com>,
       Murali <muralim@in.ibm.com>
Subject: [RFC][PATCH 7/10] 64 bit resources drivers others changes
Message-ID: <20060323200744.GK7175@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060323195752.GD7175@in.ibm.com> <20060323195944.GE7175@in.ibm.com> <20060323200119.GF7175@in.ibm.com> <20060323200227.GG7175@in.ibm.com> <20060323200342.GH7175@in.ibm.com> <20060323200451.GI7175@in.ibm.com> <20060323200610.GJ7175@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323200610.GJ7175@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o various drivers/* changes required to support 64 bit resources. This
  excludes the changes to drivers/ide/*, drivers/media/*, drivers/net/*, 
  drivers/pci/* drivers/pcmcia/*, which have been covered in separate patches

Signed-off-by: Dave Jiang <dave.jiang@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 drivers/amba/bus.c                       |    5 +++--
 drivers/atm/ambassador.c                 |    3 ++-
 drivers/atm/firestream.c                 |    5 +++--
 drivers/block/sx8.c                      |    5 +++--
 drivers/char/applicom.c                  |    9 ++++++---
 drivers/ieee1394/ohci1394.c              |   17 +++++++++--------
 drivers/infiniband/hw/mthca/mthca_main.c |    5 +++--
 drivers/input/serio/ct82c710.c           |    6 +++---
 drivers/isdn/hisax/hfc_pci.c             |    2 +-
 drivers/isdn/hisax/telespci.c            |    5 +++--
 drivers/message/i2o/iop.c                |   14 ++++++++------
 drivers/mmc/mmci.c                       |    4 ++--
 drivers/mtd/devices/pmc551.c             |    8 ++++----
 drivers/mtd/maps/amd76xrom.c             |    5 +++--
 drivers/mtd/maps/ichxrom.c               |    5 +++--
 drivers/mtd/maps/scx200_docflash.c       |    5 +++--
 drivers/mtd/maps/sun_uflash.c            |   10 ++++++----
 drivers/pnp/manager.c                    |   14 +++++++++-----
 drivers/pnp/resource.c                   |    8 ++++----
 drivers/scsi/sata_via.c                  |    8 ++++----
 drivers/serial/8250_pci.c                |    4 ++--
 drivers/usb/host/sl811-hcd.c             |   10 +++++++---
 drivers/video/console/vgacon.c           |   12 ++++++------
 include/linux/pnp.h                      |    4 ++--
 24 files changed, 99 insertions(+), 74 deletions(-)

diff -puN drivers/amba/bus.c~64bit-resources-drivers-others-changes drivers/amba/bus.c
--- linux-2.6.16-mm1/drivers/amba/bus.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/amba/bus.c	2006-03-23 11:39:14.000000000 -0500
@@ -180,8 +180,9 @@ static DEVICE_ATTR(name, S_IRUGO, show_#
 amba_attr(id, "%08x\n", dev->periphid);
 amba_attr(irq0, "%u\n", dev->irq[0]);
 amba_attr(irq1, "%u\n", dev->irq[1]);
-amba_attr(resource, "\t%08lx\t%08lx\t%08lx\n",
-	  dev->res.start, dev->res.end, dev->res.flags);
+amba_attr(resource, "\t%016llx\t%016llx\t%016llx\n",
+	 (unsigned long long)dev->res.start, (unsigned long long)dev->res.end,
+	 dev->res.flags);
 
 /**
  *	amba_device_register - register an AMBA device
diff -puN drivers/atm/ambassador.c~64bit-resources-drivers-others-changes drivers/atm/ambassador.c
--- linux-2.6.16-mm1/drivers/atm/ambassador.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/atm/ambassador.c	2006-03-23 11:39:14.000000000 -0500
@@ -2257,7 +2257,8 @@ static int __devinit amb_probe(struct pc
 	}
 
 	PRINTD (DBG_INFO, "found Madge ATM adapter (amb) at"
-		" IO %lx, IRQ %u, MEM %p", pci_resource_start(pci_dev, 1),
+		" IO %llx, IRQ %u, MEM %p",
+		(unsigned long long)pci_resource_start(pci_dev, 1),
 		irq, bus_to_virt(pci_resource_start(pci_dev, 0)));
 
 	// check IO region
diff -puN drivers/atm/firestream.c~64bit-resources-drivers-others-changes drivers/atm/firestream.c
--- linux-2.6.16-mm1/drivers/atm/firestream.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/atm/firestream.c	2006-03-23 11:39:14.000000000 -0500
@@ -1657,9 +1657,10 @@ static int __devinit fs_init (struct fs_
 	func_enter ();
 	pci_dev = dev->pci_dev;
 
-	printk (KERN_INFO "found a FireStream %d card, base %08lx, irq%d.\n", 
+	printk (KERN_INFO "found a FireStream %d card, base %16llx, irq%d.\n",
 		IS_FS50(dev)?50:155,
-		pci_resource_start(pci_dev, 0), dev->pci_dev->irq);
+		(unsigned long long)pci_resource_start(pci_dev, 0),
+		dev->pci_dev->irq);
 
 	if (fs_debug & FS_DEBUG_INIT)
 		my_hd ((unsigned char *) dev, sizeof (*dev));
diff -puN drivers/block/sx8.c~64bit-resources-drivers-others-changes drivers/block/sx8.c
--- linux-2.6.16-mm1/drivers/block/sx8.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/block/sx8.c	2006-03-23 11:39:14.000000000 -0500
@@ -1694,9 +1694,10 @@ static int carm_init_one (struct pci_dev
 	DPRINTK("waiting for probe_comp\n");
 	wait_for_completion(&host->probe_comp);
 
-	printk(KERN_INFO "%s: pci %s, ports %d, io %lx, irq %u, major %d\n",
+	printk(KERN_INFO "%s: pci %s, ports %d, io %llx, irq %u, major %d\n",
 	       host->name, pci_name(pdev), (int) CARM_MAX_PORTS,
-	       pci_resource_start(pdev, 0), pdev->irq, host->major);
+	       (unsigned long long)pci_resource_start(pdev, 0),
+		   pdev->irq, host->major);
 
 	carm_host_id++;
 	pci_set_drvdata(pdev, host);
diff -puN drivers/char/applicom.c~64bit-resources-drivers-others-changes drivers/char/applicom.c
--- linux-2.6.16-mm1/drivers/char/applicom.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/char/applicom.c	2006-03-23 11:39:14.000000000 -0500
@@ -215,13 +215,16 @@ int __init applicom_init(void)
 		RamIO = ioremap(dev->resource[0].start, LEN_RAM_IO);
 
 		if (!RamIO) {
-			printk(KERN_INFO "ac.o: Failed to ioremap PCI memory space at 0x%lx\n", dev->resource[0].start);
+			printk(KERN_INFO "ac.o: Failed to ioremap PCI memory "
+				"space at 0x%llx\n",
+				(unsigned long long)dev->resource[0].start);
 			pci_disable_device(dev);
 			return -EIO;
 		}
 
-		printk(KERN_INFO "Applicom %s found at mem 0x%lx, irq %d\n",
-		       applicom_pci_devnames[dev->device-1], dev->resource[0].start, 
+		printk(KERN_INFO "Applicom %s found at mem 0x%llx, irq %d\n",
+		       applicom_pci_devnames[dev->device-1],
+			   (unsigned long long)dev->resource[0].start,
 		       dev->irq);
 
 		boardno = ac_register_board(dev->resource[0].start, RamIO,0);
diff -puN drivers/ieee1394/ohci1394.c~64bit-resources-drivers-others-changes drivers/ieee1394/ohci1394.c
--- linux-2.6.16-mm1/drivers/ieee1394/ohci1394.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/ieee1394/ohci1394.c	2006-03-23 11:39:14.000000000 -0500
@@ -592,11 +592,11 @@ static void ohci_initialize(struct ti_oh
 	sprintf (irq_buf, "%s", __irq_itoa(ohci->dev->irq));
 #endif
 	PRINT(KERN_INFO, "OHCI-1394 %d.%d (PCI): IRQ=[%s]  "
-	      "MMIO=[%lx-%lx]  Max Packet=[%d]  IR/IT contexts=[%d/%d]",
+	      "MMIO=[%llx-%llx]  Max Packet=[%d]  IR/IT contexts=[%d/%d]",
 	      ((((buf) >> 16) & 0xf) + (((buf) >> 20) & 0xf) * 10),
 	      ((((buf) >> 4) & 0xf) + ((buf) & 0xf) * 10), irq_buf,
-	      pci_resource_start(ohci->dev, 0),
-	      pci_resource_start(ohci->dev, 0) + OHCI1394_REGISTER_SIZE - 1,
+	      (unsigned long long)pci_resource_start(ohci->dev, 0),
+	      (unsigned long long)pci_resource_start(ohci->dev, 0) + OHCI1394_REGISTER_SIZE - 1,
 	      ohci->max_packet_size,
 	      ohci->nb_iso_rcv_ctx, ohci->nb_iso_xmit_ctx);
 
@@ -3210,7 +3210,7 @@ static int __devinit ohci1394_pci_probe(
 {
 	struct hpsb_host *host;
 	struct ti_ohci *ohci;	/* shortcut to currently handled device */
-	unsigned long ohci_base;
+	u64 ohci_base;
 
         if (pci_enable_device(dev))
 		FAIL(-ENXIO, "Failed to enable OHCI hardware");
@@ -3263,15 +3263,16 @@ static int __devinit ohci1394_pci_probe(
 	 * clearly says it's 2kb, so this shouldn't be a problem. */
 	ohci_base = pci_resource_start(dev, 0);
 	if (pci_resource_len(dev, 0) < OHCI1394_REGISTER_SIZE)
-		PRINT(KERN_WARNING, "PCI resource length of 0x%lx too small!",
-		      pci_resource_len(dev, 0));
+		PRINT(KERN_WARNING, "PCI resource length of 0x%llx too small!",
+		      (unsigned long long)pci_resource_len(dev, 0));
 
 	/* Seems PCMCIA handles this internally. Not sure why. Seems
 	 * pretty bogus to force a driver to special case this.  */
 #ifndef PCMCIA
 	if (!request_mem_region (ohci_base, OHCI1394_REGISTER_SIZE, OHCI1394_DRIVER_NAME))
-		FAIL(-ENOMEM, "MMIO resource (0x%lx - 0x%lx) unavailable",
-		     ohci_base, ohci_base + OHCI1394_REGISTER_SIZE);
+		FAIL(-ENOMEM, "MMIO resource (0x%llx - 0x%llx) unavailable",
+			(unsigned long long)ohci_base,
+			(unsigned long long)ohci_base + OHCI1394_REGISTER_SIZE);
 #endif
 	ohci->init_state = OHCI_INIT_HAVE_MEM_REGION;
 
diff -puN drivers/infiniband/hw/mthca/mthca_main.c~64bit-resources-drivers-others-changes drivers/infiniband/hw/mthca/mthca_main.c
--- linux-2.6.16-mm1/drivers/infiniband/hw/mthca/mthca_main.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/infiniband/hw/mthca/mthca_main.c	2006-03-23 11:39:14.000000000 -0500
@@ -157,8 +157,9 @@ static int __devinit mthca_dev_lim(struc
 
 	if (dev_lim->uar_size > pci_resource_len(mdev->pdev, 2)) {
 		mthca_err(mdev, "HCA reported UAR size of 0x%x bigger than "
-			  "PCI resource 2 size of 0x%lx, aborting.\n",
-			  dev_lim->uar_size, pci_resource_len(mdev->pdev, 2));
+			  "PCI resource 2 size of 0x%llx, aborting.\n",
+			  dev_lim->uar_size,
+			  (unsigned long long)pci_resource_len(mdev->pdev, 2));
 		return -ENODEV;
 	}
 
diff -puN drivers/input/serio/ct82c710.c~64bit-resources-drivers-others-changes drivers/input/serio/ct82c710.c
--- linux-2.6.16-mm1/drivers/input/serio/ct82c710.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/input/serio/ct82c710.c	2006-03-23 11:39:14.000000000 -0500
@@ -189,7 +189,7 @@ static int __devinit ct82c710_probe(stru
 	strlcpy(ct82c710_port->name, "C&T 82c710 mouse port",
 		sizeof(ct82c710_port->name));
 	snprintf(ct82c710_port->phys, sizeof(ct82c710_port->phys),
-		 "isa%04lx/serio0", CT82C710_DATA);
+		 "isa%16llx/serio0", (unsigned long long)CT82C710_DATA);
 
 	serio_register_port(ct82c710_port);
 
@@ -241,8 +241,8 @@ static int __init ct82c710_init(void)
 
 	serio_register_port(ct82c710_port);
 
-	printk(KERN_INFO "serio: C&T 82c710 mouse port at %#lx irq %d\n",
-		CT82C710_DATA, CT82C710_IRQ);
+	printk(KERN_INFO "serio: C&T 82c710 mouse port at %#llx irq %d\n",
+		(unsigned long long)CT82C710_DATA, CT82C710_IRQ);
 
 	return 0;
 
diff -puN drivers/isdn/hisax/hfc_pci.c~64bit-resources-drivers-others-changes drivers/isdn/hisax/hfc_pci.c
--- linux-2.6.16-mm1/drivers/isdn/hisax/hfc_pci.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/isdn/hisax/hfc_pci.c	2006-03-23 11:39:14.000000000 -0500
@@ -1688,7 +1688,7 @@ setup_hfcpci(struct IsdnCard *card)
 				printk(KERN_WARNING "HFC-PCI: No IRQ for PCI card found\n");
 				return (0);
 			}
-			cs->hw.hfcpci.pci_io = (char *) dev_hfcpci->resource[ 1].start;
+			cs->hw.hfcpci.pci_io = (char *)(unsigned long)dev_hfcpci->resource[1].start;
 			printk(KERN_INFO "HiSax: HFC-PCI card manufacturer: %s card name: %s\n", id_list[i].vendor_name, id_list[i].card_name);
 		} else {
 			printk(KERN_WARNING "HFC-PCI: No PCI card found\n");
diff -puN drivers/isdn/hisax/telespci.c~64bit-resources-drivers-others-changes drivers/isdn/hisax/telespci.c
--- linux-2.6.16-mm1/drivers/isdn/hisax/telespci.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/isdn/hisax/telespci.c	2006-03-23 11:39:14.000000000 -0500
@@ -311,8 +311,9 @@ setup_telespci(struct IsdnCard *card)
 		}
 		cs->hw.teles0.membase = ioremap(pci_resource_start(dev_tel, 0),
 			PAGE_SIZE);
-		printk(KERN_INFO "Found: Zoran, base-address: 0x%lx, irq: 0x%x\n",
-			pci_resource_start(dev_tel, 0), dev_tel->irq);
+		printk(KERN_INFO "Found: Zoran, base-address: 0x%llx, irq: 0x%x\n",
+			(unsigned long long)pci_resource_start(dev_tel, 0),
+			dev_tel->irq);
 	} else {
 		printk(KERN_WARNING "TelesPCI: No PCI card found\n");
 		return(0);
diff -puN drivers/message/i2o/iop.c~64bit-resources-drivers-others-changes drivers/message/i2o/iop.c
--- linux-2.6.16-mm1/drivers/message/i2o/iop.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/message/i2o/iop.c	2006-03-23 11:39:14.000000000 -0500
@@ -683,9 +683,10 @@ static int i2o_iop_systab_set(struct i2o
 			c->mem_alloc = 1;
 			sb->current_mem_size = 1 + res->end - res->start;
 			sb->current_mem_base = res->start;
-			osm_info("%s: allocated %ld bytes of PCI memory at "
-				 "0x%08lX.\n", c->name,
-				 1 + res->end - res->start, res->start);
+			osm_info("%s: allocated %llu bytes of PCI memory at "
+				"0x%016llX.\n", c->name,
+				(unsigned long long)(1 + res->end - res->start),
+				(unsigned long long)res->start);
 		}
 	}
 
@@ -704,9 +705,10 @@ static int i2o_iop_systab_set(struct i2o
 			c->io_alloc = 1;
 			sb->current_io_size = 1 + res->end - res->start;
 			sb->current_mem_base = res->start;
-			osm_info("%s: allocated %ld bytes of PCI I/O at 0x%08lX"
-				 ".\n", c->name, 1 + res->end - res->start,
-				 res->start);
+			osm_info("%s: allocated %llu bytes of PCI I/O at "
+				"0x%016llX.\n", c->name,
+				(unsigned long long)(1 + res->end - res->start),
+				(unsigned long long)res->start);
 		}
 	}
 
diff -puN drivers/mmc/mmci.c~64bit-resources-drivers-others-changes drivers/mmc/mmci.c
--- linux-2.6.16-mm1/drivers/mmc/mmci.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/mmc/mmci.c	2006-03-23 11:39:14.000000000 -0500
@@ -553,9 +553,9 @@ static int mmci_probe(struct amba_device
 
 	mmc_add_host(mmc);
 
-	printk(KERN_INFO "%s: MMCI rev %x cfg %02x at 0x%08lx irq %d,%d\n",
+	printk(KERN_INFO "%s: MMCI rev %x cfg %02x at 0x%016llx irq %d,%d\n",
 		mmc_hostname(mmc), amba_rev(dev), amba_config(dev),
-		dev->res.start, dev->irq[0], dev->irq[1]);
+		(unsigned long long)dev->res.start, dev->irq[0], dev->irq[1]);
 
 	init_timer(&host->timer);
 	host->timer.data = (unsigned long)host;
diff -puN drivers/mtd/devices/pmc551.c~64bit-resources-drivers-others-changes drivers/mtd/devices/pmc551.c
--- linux-2.6.16-mm1/drivers/mtd/devices/pmc551.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/mtd/devices/pmc551.c	2006-03-23 11:39:14.000000000 -0500
@@ -551,11 +551,11 @@ static u32 fixup_pmc551 (struct pci_dev 
         /*
          * Some screen fun
          */
-        printk(KERN_DEBUG "pmc551: %d%c (0x%x) of %sprefetchable memory at 0x%lx\n",
+        printk(KERN_DEBUG "pmc551: %d%c (0x%x) of %sprefetchable memory at 0x%llx\n",
 	       (size<1024)?size:(size<1048576)?size>>10:size>>20,
                (size<1024)?'B':(size<1048576)?'K':'M',
 	       size, ((dcmd&(0x1<<3)) == 0)?"non-":"",
-               (dev->resource[0].start)&PCI_BASE_ADDRESS_MEM_MASK );
+               (unsigned long long)((dev->resource[0].start)&PCI_BASE_ADDRESS_MEM_MASK));
 
         /*
          * Check to see the state of the memory
@@ -685,8 +685,8 @@ static int __init init_pmc551(void)
                         break;
                 }
 
-                printk(KERN_NOTICE "pmc551: Found PCI V370PDC at 0x%lX\n",
-				    PCI_Device->resource[0].start);
+                printk(KERN_NOTICE "pmc551: Found PCI V370PDC at 0x%llx\n",
+				    (unsigned long long)PCI_Device->resource[0].start);
 
                 /*
                  * The PMC551 device acts VERY weird if you don't init it
diff -puN drivers/mtd/maps/amd76xrom.c~64bit-resources-drivers-others-changes drivers/mtd/maps/amd76xrom.c
--- linux-2.6.16-mm1/drivers/mtd/maps/amd76xrom.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/mtd/maps/amd76xrom.c	2006-03-23 11:39:14.000000000 -0500
@@ -123,9 +123,10 @@ static int __devinit amd76xrom_init_one 
 		window->rsrc.parent = NULL;
 		printk(KERN_ERR MOD_NAME
 			" %s(): Unable to register resource"
-			" 0x%.08lx-0x%.08lx - kernel bug?\n",
+			" 0x%.16llx-0x%.16llx - kernel bug?\n",
 			__func__,
-			window->rsrc.start, window->rsrc.end);
+			(unsigned long long)window->rsrc.start,
+			(unsigned long long)window->rsrc.end);
 	}
 
 #if 0
diff -puN drivers/mtd/maps/ichxrom.c~64bit-resources-drivers-others-changes drivers/mtd/maps/ichxrom.c
--- linux-2.6.16-mm1/drivers/mtd/maps/ichxrom.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/mtd/maps/ichxrom.c	2006-03-23 11:39:14.000000000 -0500
@@ -177,9 +177,10 @@ static int __devinit ichxrom_init_one (s
 		window->rsrc.parent = NULL;
 		printk(KERN_DEBUG MOD_NAME
 			": %s(): Unable to register resource"
-			" 0x%.08lx-0x%.08lx - kernel bug?\n",
+			" 0x%.16llx-0x%.16llx - kernel bug?\n",
 			__func__,
-			window->rsrc.start, window->rsrc.end);
+			(unsigned long long)window->rsrc.start,
+			(unsigned long long)window->rsrc.end);
 	}
 
 	/* Map the firmware hub into my address space. */
diff -puN drivers/mtd/maps/scx200_docflash.c~64bit-resources-drivers-others-changes drivers/mtd/maps/scx200_docflash.c
--- linux-2.6.16-mm1/drivers/mtd/maps/scx200_docflash.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/mtd/maps/scx200_docflash.c	2006-03-23 11:39:14.000000000 -0500
@@ -164,8 +164,9 @@ static int __init init_scx200_docflash(v
 		outl(pmr, scx200_cb_base + SCx200_PMR);
 	}
 
-       	printk(KERN_INFO NAME ": DOCCS mapped at 0x%lx-0x%lx, width %d\n",
-	       docmem.start, docmem.end, width);
+       	printk(KERN_INFO NAME ": DOCCS mapped at 0x%llx-0x%llx, width %d\n",
+			(unsigned long long)docmem.start,
+			(unsigned long long)docmem.end, width);
 
 	scx200_docflash_map.size = size;
 	if (width == 8)
diff -puN drivers/mtd/maps/sun_uflash.c~64bit-resources-drivers-others-changes drivers/mtd/maps/sun_uflash.c
--- linux-2.6.16-mm1/drivers/mtd/maps/sun_uflash.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/mtd/maps/sun_uflash.c	2006-03-23 11:39:14.000000000 -0500
@@ -74,9 +74,10 @@ int uflash_devinit(struct linux_ebus_dev
 		/* Non-CFI userflash device-- once I find one we
 		 * can work on supporting it.
 		 */
-		printk("%s: unsupported device at 0x%lx (%d regs): " \
+		printk("%s: unsupported device at 0x%llx (%d regs): " \
 			"email ebrower@usa.net\n",
-			UFLASH_DEVNAME, edev->resource[0].start, nregs);
+			UFLASH_DEVNAME,
+			(unsigned long long)edev->resource[0].start, nregs);
 		return -ENODEV;
 	}
 
@@ -132,8 +133,9 @@ static int __init uflash_init(void)
 		for_each_ebusdev(edev, ebus) {
 			if (!strcmp(edev->prom_name, UFLASH_OBPNAME)) {
 				if(0 > prom_getproplen(edev->prom_node, "user")) {
-					DEBUG(2, "%s: ignoring device at 0x%lx\n",
-							UFLASH_DEVNAME, edev->resource[0].start);
+					DEBUG(2, "%s: ignoring device at 0x%llx\n",
+						UFLASH_DEVNAME,
+						(unsigned long long)edev->resource[0].start);
 				} else {
 					uflash_devinit(edev);
 				}
diff -puN drivers/pnp/manager.c~64bit-resources-drivers-others-changes drivers/pnp/manager.c
--- linux-2.6.16-mm1/drivers/pnp/manager.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/pnp/manager.c	2006-03-23 11:39:14.000000000 -0500
@@ -20,7 +20,8 @@ DECLARE_MUTEX(pnp_res_mutex);
 
 static int pnp_assign_port(struct pnp_dev *dev, struct pnp_port *rule, int idx)
 {
-	unsigned long *start, *end, *flags;
+	u64 *start, *end;
+	unsigned long *flags;
 
 	if (!dev || !rule)
 		return -EINVAL;
@@ -63,7 +64,8 @@ static int pnp_assign_port(struct pnp_de
 
 static int pnp_assign_mem(struct pnp_dev *dev, struct pnp_mem *rule, int idx)
 {
-	unsigned long *start, *end, *flags;
+	u64 *start, *end;
+	unsigned long *flags;
 
 	if (!dev || !rule)
 		return -EINVAL;
@@ -116,7 +118,8 @@ static int pnp_assign_mem(struct pnp_dev
 
 static int pnp_assign_irq(struct pnp_dev * dev, struct pnp_irq *rule, int idx)
 {
-	unsigned long *start, *end, *flags;
+	u64 *start, *end;
+	unsigned long *flags;
 	int i;
 
 	/* IRQ priority: this table is good for i386 */
@@ -168,7 +171,8 @@ static int pnp_assign_irq(struct pnp_dev
 
 static int pnp_assign_dma(struct pnp_dev *dev, struct pnp_dma *rule, int idx)
 {
-	unsigned long *start, *end, *flags;
+	u64 *start, *end;
+	unsigned long *flags;
 	int i;
 
 	/* DMA priority: this table is good for i386 */
@@ -582,7 +586,7 @@ int pnp_disable_dev(struct pnp_dev *dev)
  * @size: size of region
  *
  */
-void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size)
+void pnp_resource_change(struct resource *resource, u64 start, u64 size)
 {
 	if (resource == NULL)
 		return;
diff -puN drivers/pnp/resource.c~64bit-resources-drivers-others-changes drivers/pnp/resource.c
--- linux-2.6.16-mm1/drivers/pnp/resource.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/pnp/resource.c	2006-03-23 11:39:14.000000000 -0500
@@ -241,7 +241,7 @@ int pnp_check_port(struct pnp_dev * dev,
 {
 	int tmp;
 	struct pnp_dev *tdev;
-	unsigned long *port, *end, *tport, *tend;
+	u64 *port, *end, *tport, *tend;
 	port = &dev->res.port_resource[idx].start;
 	end = &dev->res.port_resource[idx].end;
 
@@ -297,7 +297,7 @@ int pnp_check_mem(struct pnp_dev * dev, 
 {
 	int tmp;
 	struct pnp_dev *tdev;
-	unsigned long *addr, *end, *taddr, *tend;
+	u64 *addr, *end, *taddr, *tend;
 	addr = &dev->res.mem_resource[idx].start;
 	end = &dev->res.mem_resource[idx].end;
 
@@ -358,7 +358,7 @@ int pnp_check_irq(struct pnp_dev * dev, 
 {
 	int tmp;
 	struct pnp_dev *tdev;
-	unsigned long * irq = &dev->res.irq_resource[idx].start;
+	u64 * irq = &dev->res.irq_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
 	if (cannot_compare(dev->res.irq_resource[idx].flags))
@@ -423,7 +423,7 @@ int pnp_check_dma(struct pnp_dev * dev, 
 #ifndef CONFIG_IA64
 	int tmp;
 	struct pnp_dev *tdev;
-	unsigned long * dma = &dev->res.dma_resource[idx].start;
+	u64 * dma = &dev->res.dma_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
 	if (cannot_compare(dev->res.dma_resource[idx].flags))
diff -puN drivers/scsi/sata_via.c~64bit-resources-drivers-others-changes drivers/scsi/sata_via.c
--- linux-2.6.16-mm1/drivers/scsi/sata_via.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/scsi/sata_via.c	2006-03-23 11:39:14.000000000 -0500
@@ -334,10 +334,10 @@ static int svia_init_one (struct pci_dev
 		if ((pci_resource_start(pdev, i) == 0) ||
 		    (pci_resource_len(pdev, i) < bar_sizes[i])) {
 			dev_printk(KERN_ERR, &pdev->dev,
-				   "invalid PCI BAR %u (sz 0x%lx, val 0x%lx)\n",
-				   i,
-			           pci_resource_start(pdev, i),
-			           pci_resource_len(pdev, i));
+				"invalid PCI BAR %u (sz 0x%llx, val 0x%llx)\n",
+				i,
+			        (unsigned long long)pci_resource_start(pdev, i),
+			        (unsigned long long)pci_resource_len(pdev, i));
 			rc = -ENODEV;
 			goto err_out_regions;
 		}
diff -puN drivers/serial/8250_pci.c~64bit-resources-drivers-others-changes drivers/serial/8250_pci.c
--- linux-2.6.16-mm1/drivers/serial/8250_pci.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/serial/8250_pci.c	2006-03-23 11:39:14.000000000 -0500
@@ -594,8 +594,8 @@ pci_default_setup(struct serial_private 
 	else
 		offset += idx * board->uart_offset;
 
-	maxnr = (pci_resource_len(priv->dev, bar) - board->first_offset) /
-		(8 << board->reg_shift);
+	maxnr = (pci_resource_len(priv->dev, bar) - board->first_offset) >>
+		(board->reg_shift + 3);
 
 	if (board->flags & FL_REGION_SZ_CAP && idx >= maxnr)
 		return 1;
diff -puN drivers/usb/host/sl811-hcd.c~64bit-resources-drivers-others-changes drivers/usb/host/sl811-hcd.c
--- linux-2.6.16-mm1/drivers/usb/host/sl811-hcd.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/usb/host/sl811-hcd.c	2006-03-23 11:39:14.000000000 -0500
@@ -1684,9 +1684,13 @@ sl811h_probe(struct platform_device *dev
 		if (!addr || !data)
 			return -ENODEV;
 		ioaddr = 1;
-
-		addr_reg = (void __iomem *) addr->start;
-		data_reg = (void __iomem *) data->start;
+		/*
+		 * NOTE: 64-bit resource->start is getting truncated
+		 * to avoid compiler warning, assuming that ->start
+		 * is always 32-bit for this case
+		 */
+		addr_reg = (void __iomem *) (unsigned long) addr->start;
+		data_reg = (void __iomem *) (unsigned long) data->start;
 	} else {
 		addr_reg = ioremap(addr->start, 1);
 		if (addr_reg == NULL) {
diff -puN drivers/video/console/vgacon.c~64bit-resources-drivers-others-changes drivers/video/console/vgacon.c
--- linux-2.6.16-mm1/drivers/video/console/vgacon.c~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/video/console/vgacon.c	2006-03-23 11:39:14.000000000 -0500
@@ -389,7 +389,7 @@ static const char __init *vgacon_startup
 		vga_video_port_val = VGA_CRT_DM;
 		if ((ORIG_VIDEO_EGA_BX & 0xff) != 0x10) {
 			static struct resource ega_console_resource =
-			    { "ega", 0x3B0, 0x3BF };
+			    { .name = "ega", .start = 0x3B0, .end = 0x3BF };
 			vga_video_type = VIDEO_TYPE_EGAM;
 			vga_vram_end = 0xb8000;
 			display_desc = "EGA+";
@@ -397,9 +397,9 @@ static const char __init *vgacon_startup
 					 &ega_console_resource);
 		} else {
 			static struct resource mda1_console_resource =
-			    { "mda", 0x3B0, 0x3BB };
+			    { .name = "mda", .start = 0x3B0, .end = 0x3BB };
 			static struct resource mda2_console_resource =
-			    { "mda", 0x3BF, 0x3BF };
+			    { .name = "mda", .start = 0x3BF, .end = 0x3BF };
 			vga_video_type = VIDEO_TYPE_MDA;
 			vga_vram_end = 0xb2000;
 			display_desc = "*MDA";
@@ -422,14 +422,14 @@ static const char __init *vgacon_startup
 
 			if (!ORIG_VIDEO_ISVGA) {
 				static struct resource ega_console_resource
-				    = { "ega", 0x3C0, 0x3DF };
+				    = { .name = "ega", .start = 0x3C0, .end = 0x3DF };
 				vga_video_type = VIDEO_TYPE_EGAC;
 				display_desc = "EGA";
 				request_resource(&ioport_resource,
 						 &ega_console_resource);
 			} else {
 				static struct resource vga_console_resource
-				    = { "vga+", 0x3C0, 0x3DF };
+				    = { .name = "vga+", .start = 0x3C0, .end = 0x3DF };
 				vga_video_type = VIDEO_TYPE_VGAC;
 				display_desc = "VGA+";
 				request_resource(&ioport_resource,
@@ -473,7 +473,7 @@ static const char __init *vgacon_startup
 			}
 		} else {
 			static struct resource cga_console_resource =
-			    { "cga", 0x3D4, 0x3D5 };
+			    { .name = "cga", .start = 0x3D4, .end = 0x3D5 };
 			vga_video_type = VIDEO_TYPE_CGA;
 			vga_vram_end = 0xba000;
 			display_desc = "*CGA";
diff -puN include/linux/pnp.h~64bit-resources-drivers-others-changes include/linux/pnp.h
--- linux-2.6.16-mm1/include/linux/pnp.h~64bit-resources-drivers-others-changes	2006-03-23 11:39:14.000000000 -0500
+++ linux-2.6.16-mm1-root/include/linux/pnp.h	2006-03-23 11:39:14.000000000 -0500
@@ -389,7 +389,7 @@ int pnp_start_dev(struct pnp_dev *dev);
 int pnp_stop_dev(struct pnp_dev *dev);
 int pnp_activate_dev(struct pnp_dev *dev);
 int pnp_disable_dev(struct pnp_dev *dev);
-void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size);
+void pnp_resource_change(struct resource *resource, u64 start, u64 size);
 
 /* protocol helpers */
 int pnp_is_active(struct pnp_dev * dev);
@@ -434,7 +434,7 @@ static inline int pnp_start_dev(struct p
 static inline int pnp_stop_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
-static inline void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size) { }
+static inline void pnp_resource_change(struct resource *resource, u64 start, u64 size) { }
 
 /* protocol helpers */
 static inline int pnp_is_active(struct pnp_dev * dev) { return 0; }
_
