Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932700AbWFMAiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbWFMAiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 20:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbWFMAif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 20:38:35 -0400
Received: from mail.suse.de ([195.135.220.2]:44750 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932694AbWFMAe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 20:34:26 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/16] 64bit resource: fix up printks for resources in misc drivers
Reply-To: Greg KH <greg@kroah.com>
Date: Mon, 12 Jun 2006 17:31:12 -0700
Message-Id: <11501587122736-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11501587082203-git-send-email-greg@kroah.com>
References: <20060613003033.GA10717@kroah.com> <11501586781628-git-send-email-greg@kroah.com> <1150158683636-git-send-email-greg@kroah.com> <11501586871870-git-send-email-greg@kroah.com> <11501586902008-git-send-email-greg@kroah.com> <11501586942938-git-send-email-greg@kroah.com> <11501586982289-git-send-email-greg@kroah.com> <11501587011194-git-send-email-greg@kroah.com> <11501587043722-git-send-email-greg@kroah.com> <11501587082203-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This is needed if we wish to change the size of the resource structures.

Based on an original patch from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/amba/bus.c                         |    5 +++--
 drivers/atm/ambassador.c                   |    3 ++-
 drivers/atm/firestream.c                   |    5 +++--
 drivers/block/sx8.c                        |    5 +++--
 drivers/char/applicom.c                    |    9 ++++++---
 drivers/ieee1394/ohci1394.c                |   15 ++++++++-------
 drivers/infiniband/hw/ipath/ipath_driver.c |    8 ++++----
 drivers/infiniband/hw/mthca/mthca_main.c   |    5 +++--
 drivers/input/serio/ct82c710.c             |    6 +++---
 drivers/isdn/hisax/telespci.c              |    5 +++--
 drivers/macintosh/macio_asic.c             |    4 ++--
 drivers/message/i2o/iop.c                  |   14 ++++++++------
 drivers/mmc/mmci.c                         |    4 ++--
 drivers/scsi/sata_via.c                    |    8 ++++----
 14 files changed, 54 insertions(+), 42 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 889855d..9e3e2a6 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -180,8 +180,9 @@ static DEVICE_ATTR(name, S_IRUGO, show_#
 amba_attr(id, "%08x\n", dev->periphid);
 amba_attr(irq0, "%u\n", dev->irq[0]);
 amba_attr(irq1, "%u\n", dev->irq[1]);
-amba_attr(resource, "\t%08lx\t%08lx\t%08lx\n",
-	  dev->res.start, dev->res.end, dev->res.flags);
+amba_attr(resource, "\t%016llx\t%016llx\t%016lx\n",
+	 (unsigned long long)dev->res.start, (unsigned long long)dev->res.end,
+	 dev->res.flags);
 
 /**
  *	amba_device_register - register an AMBA device
diff --git a/drivers/atm/ambassador.c b/drivers/atm/ambassador.c
index 4b6bf19..4048681 100644
--- a/drivers/atm/ambassador.c
+++ b/drivers/atm/ambassador.c
@@ -2257,7 +2257,8 @@ static int __devinit amb_probe(struct pc
 	}
 
 	PRINTD (DBG_INFO, "found Madge ATM adapter (amb) at"
-		" IO %lx, IRQ %u, MEM %p", pci_resource_start(pci_dev, 1),
+		" IO %llx, IRQ %u, MEM %p",
+		(unsigned long long)pci_resource_start(pci_dev, 1),
 		irq, bus_to_virt(pci_resource_start(pci_dev, 0)));
 
 	// check IO region
diff --git a/drivers/atm/firestream.c b/drivers/atm/firestream.c
index 7f7ec28..be42ce9 100644
--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
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
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 2ae08b3..8144ce9 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1694,9 +1694,10 @@ #endif
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
diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
index a370e7a..1f48cce 100644
--- a/drivers/char/applicom.c
+++ b/drivers/char/applicom.c
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
diff --git a/drivers/ieee1394/ohci1394.c b/drivers/ieee1394/ohci1394.c
index 11f1377..744b66c 100644
--- a/drivers/ieee1394/ohci1394.c
+++ b/drivers/ieee1394/ohci1394.c
@@ -592,11 +592,11 @@ #else
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
 
@@ -3263,15 +3263,16 @@ #endif
 	 * clearly says it's 2kb, so this shouldn't be a problem. */
 	ohci_base = pci_resource_start(dev, 0);
 	if (pci_resource_len(dev, 0) < OHCI1394_REGISTER_SIZE)
-		PRINT(KERN_WARNING, "PCI resource length of %lx too small!",
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
 
diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
index dddcdae..e4b897f 100644
--- a/drivers/infiniband/hw/ipath/ipath_driver.c
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c
@@ -460,10 +460,10 @@ static int __devinit ipath_init_one(stru
 	for (j = 0; j < 6; j++) {
 		if (!pdev->resource[j].start)
 			continue;
-		ipath_cdbg(VERBOSE, "BAR %d start %lx, end %lx, len %lx\n",
-			   j, pdev->resource[j].start,
-			   pdev->resource[j].end,
-			   pci_resource_len(pdev, j));
+		ipath_cdbg(VERBOSE, "BAR %d start %llx, end %llx, len %llx\n",
+			   j, (unsigned long long)pdev->resource[j].start,
+			   (unsigned long long)pdev->resource[j].end,
+			   (unsigned long long)pci_resource_len(pdev, j));
 	}
 
 	if (!addr) {
diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index 9b9ff7b..465fd22 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -172,8 +172,9 @@ static int __devinit mthca_dev_lim(struc
 
 	if (dev_lim->uar_size > pci_resource_len(mdev->pdev, 2)) {
 		mthca_err(mdev, "HCA reported UAR size of 0x%x bigger than "
-			  "PCI resource 2 size of 0x%lx, aborting.\n",
-			  dev_lim->uar_size, pci_resource_len(mdev->pdev, 2));
+			  "PCI resource 2 size of 0x%llx, aborting.\n",
+			  dev_lim->uar_size,
+			  (unsigned long long)pci_resource_len(mdev->pdev, 2));
 		return -ENODEV;
 	}
 
diff --git a/drivers/input/serio/ct82c710.c b/drivers/input/serio/ct82c710.c
index 096b6a0..1ac739e 100644
--- a/drivers/input/serio/ct82c710.c
+++ b/drivers/input/serio/ct82c710.c
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
 
diff --git a/drivers/isdn/hisax/telespci.c b/drivers/isdn/hisax/telespci.c
index e2bb4fd..e82ab22 100644
--- a/drivers/isdn/hisax/telespci.c
+++ b/drivers/isdn/hisax/telespci.c
@@ -311,8 +311,9 @@ #ifdef CONFIG_PCI
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
diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 431bd37..c687ac7 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -428,10 +428,10 @@ #endif
 
 	/* MacIO itself has a different reg, we use it's PCI base */
 	if (np == chip->of_node) {
-		sprintf(dev->ofdev.dev.bus_id, "%1d.%08lx:%.*s",
+		sprintf(dev->ofdev.dev.bus_id, "%1d.%016llx:%.*s",
 			chip->lbus.index,
 #ifdef CONFIG_PCI
-			pci_resource_start(chip->lbus.pdev, 0),
+			(unsigned long long)pci_resource_start(chip->lbus.pdev, 0),
 #else
 			0, /* NuBus may want to do something better here */
 #endif
diff --git a/drivers/message/i2o/iop.c b/drivers/message/i2o/iop.c
index febbdd4..64cc925 100644
--- a/drivers/message/i2o/iop.c
+++ b/drivers/message/i2o/iop.c
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
 
diff --git a/drivers/mmc/mmci.c b/drivers/mmc/mmci.c
index da8e4d7..8576a65 100644
--- a/drivers/mmc/mmci.c
+++ b/drivers/mmc/mmci.c
@@ -546,9 +546,9 @@ static int mmci_probe(struct amba_device
 
 	mmc_add_host(mmc);
 
-	printk(KERN_INFO "%s: MMCI rev %x cfg %02x at 0x%08lx irq %d,%d\n",
+	printk(KERN_INFO "%s: MMCI rev %x cfg %02x at 0x%016llx irq %d,%d\n",
 		mmc_hostname(mmc), amba_rev(dev), amba_config(dev),
-		dev->res.start, dev->irq[0], dev->irq[1]);
+		(unsigned long long)dev->res.start, dev->irq[0], dev->irq[1]);
 
 	init_timer(&host->timer);
 	host->timer.data = (unsigned long)host;
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index 9e7ae4e..11ce2b6 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -333,10 +333,10 @@ static int svia_init_one (struct pci_dev
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
-- 
1.4.0

