Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264800AbSJVS1M>; Tue, 22 Oct 2002 14:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262006AbSJVS1M>; Tue, 22 Oct 2002 14:27:12 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:37643 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264808AbSJVS06>;
	Tue, 22 Oct 2002 14:26:58 -0400
Date: Tue, 22 Oct 2002 11:31:52 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] more pcibios_* removals for 2.5.44
Message-ID: <20021022183152.GG6471@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is a patch for 2.5.44 that removes almost all of the remaining
usages of pcibios_read_config* and pcibios_write_config* calls.  It also
removes them from the pci.h, and drivers/pci/compat.c is gone.

I'll be sending a few of these patches directly to the different
subsystems maintainers, and then eventually sending the removal of the
functions patch to Linus.

If anyone has any major objections to me doing this, please let me know
now.

The diffstat output of the patch:
 arch/alpha/kernel/sys_titan.c      |    5 +----
 arch/m68k/atari/hades-pci.c        |   12 +++++-------
 arch/m68k/kernel/bios32.c          |   34 ++++++++++++----------------------
 arch/ppc/platforms/mcpn765_setup.c |    4 ++--
 arch/ppc/platforms/prep_pci.c      |    5 ++---
 drivers/isdn/hisax/bkm_a8.c        |   23 ++++++++---------------
 drivers/net/tulip/de4x5.c          |   34 ++++++++++++++++------------------
 drivers/pci/compat.c               |   37 -------------------------------------
 drivers/pci/Makefile               |    4 ++--
 drivers/scsi/53c7,8xx.c            |   14 +++++---------
 drivers/scsi/53c7,8xx.h            |    4 ++--
 drivers/scsi/advansys.c            |   34 +++++++++++-----------------------
 include/asm-m68k/pci.h             |    2 +-
 include/linux/pci.h                |   17 -----------------
 14 files changed, 67 insertions(+), 162 deletions(-)

Here's a list of the remaining files that contain pcibios_read_config*
or pcibios_write_config_* calls, and why I didn't change them:

	drivers/scsi/gdth.c
	drivers/scsi/megaraid.c
	drivers/scsi/sym53c8xx_comm.h
	drivers/scsi/tmscsim.c
	drivers/scsi/sym53c8xx.c
	drivers/net/wan/sdladrv.c
	drivers/char/ip2main.c
	include/linux/compatmac.h
		- old compatibility code, does not get built for 2.5

	drivers/video/S3triofb.c
		- ppc specific driver, relies on a call to
		  pci_device_loc() which I can't seem to find in the
		  main kernel tree.

	drivers/net/gt96100eth.c
		- ick, this driver access memory directly, and assumes
		  that it is the only pci device on the system (which is
		  probably is, as it looks to be for a embedded system.)
		  This driver should be converted to use the
		  pci_register_driver() interface, and then these
		  pcibios* calls will disappear.

	drivers/isdn/eicon/lincfg.c
		- still calls older pcibios_* functions that have been
		  removed from the system.  When those calls are fixed
		  up, the pcibios_read* calls will be easy to fix.

	drivers/isdn/hisax/hfc_pci.c
		- still calls cli() and will not build.

	arch/alpha/kernel/sys_nautilus.c
		- I don't know how to fix the following lines that talk
		  directly to the hardware at specific locations:
			pcibios_write_config_byte(0, 0x38, 0x43, t8 | 0x80);
			pcibios_read_config_byte(0, 0x38, 0x43, &t8);
			pcibios_write_config_byte(0, 0x38, 0x43, t8 | 0x80);

	arch/alpha/kernel/sys_sio.c
		- Again, hard coded numbers in the line:
			pcibios_write_config_dword(0, PCI_DEVFN(7, 0), 0x60, alpha_mv.sys.sio.route_tab);
	
If anyone can provide patches for the above files, please let me know.

thanks,

greg k-h


diff -Nru a/arch/alpha/kernel/sys_titan.c b/arch/alpha/kernel/sys_titan.c
--- a/arch/alpha/kernel/sys_titan.c	Tue Oct 22 11:27:55 2002
+++ b/arch/alpha/kernel/sys_titan.c	Tue Oct 22 11:27:55 2002
@@ -306,10 +306,7 @@
 {
 	u8 irq;
 	
-	pcibios_read_config_byte(dev->bus->number,
-				 dev->devfn,
-				 PCI_INTERRUPT_LINE,
-				 &irq);
+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 
 	/* is it routed through ISA? */
 	if ((irq & 0xF0) == 0xE0)
diff -Nru a/arch/m68k/atari/hades-pci.c b/arch/m68k/atari/hades-pci.c
--- a/arch/m68k/atari/hades-pci.c	Tue Oct 22 11:27:55 2002
+++ b/arch/m68k/atari/hades-pci.c	Tue Oct 22 11:27:55 2002
@@ -311,26 +311,24 @@
 			slot = PCI_SLOT(dev->devfn);	/* Determine slot number. */
 			dev->irq = irq_tab[slot];
 			if (pci_modify)
-				pcibios_write_config_byte(dev->bus->number, dev->devfn,
-							  PCI_INTERRUPT_LINE, dev->irq);
+				pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 		}
 	}
 }
 
 /*
- * static void hades_conf_device(unsigned char bus, unsigned char device_fn)
+ * static void hades_conf_device(struct pci_dev *dev)
  *
  * Machine dependent Configure the given device.
  *
  * Parameters:
  *
- * bus		- bus number of the device.
- * device_fn	- device and function number of the device.
+ * dev		- the pci device.
  */
 
-static void __init hades_conf_device(unsigned char bus, unsigned char device_fn)
+static void __init hades_conf_device(struct pci_dev *dev)
 {
-	pcibios_write_config_byte(bus, device_fn, PCI_CACHE_LINE_SIZE, 0);
+	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, 0);
 }
 
 static struct pci_ops hades_pci_ops = {
diff -Nru a/arch/m68k/kernel/bios32.c b/arch/m68k/kernel/bios32.c
--- a/arch/m68k/kernel/bios32.c	Tue Oct 22 11:27:55 2002
+++ b/arch/m68k/kernel/bios32.c	Tue Oct 22 11:27:55 2002
@@ -95,7 +95,6 @@
 
 static void __init disable_dev(struct pci_dev *dev)
 {
-	struct pci_bus *bus;
 	unsigned short cmd;
 
 	if (((dev->class >> 8 == PCI_CLASS_NOT_DEFINED_VGA) ||
@@ -103,11 +102,10 @@
 	     (dev->class >> 8 == PCI_CLASS_DISPLAY_XGA)) && skip_vga)
 		return;
 
-	bus = dev->bus;
-	pcibios_read_config_word(bus->number, dev->devfn, PCI_COMMAND, &cmd);
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 
 	cmd &= (~PCI_COMMAND_IO & ~PCI_COMMAND_MEMORY & ~PCI_COMMAND_MASTER);
-	pcibios_write_config_word(bus->number, dev->devfn, PCI_COMMAND, cmd);
+	pci_write_config_word(dev, PCI_COMMAND, cmd);
 }
 
 /*
@@ -122,7 +120,6 @@
 
 static void __init layout_dev(struct pci_dev *dev)
 {
-	struct pci_bus *bus;
 	unsigned short cmd;
 	unsigned int base, mask, size, reg;
 	unsigned int alignto;
@@ -137,8 +134,7 @@
 	     (dev->class >> 8 == PCI_CLASS_DISPLAY_XGA)) && skip_vga)
 		return;
 
-	bus = dev->bus;
-	pcibios_read_config_word(bus->number, dev->devfn, PCI_COMMAND, &cmd);
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 
 	for (reg = PCI_BASE_ADDRESS_0, i = 0; reg <= PCI_BASE_ADDRESS_5; reg += 4, i++)
 	{
@@ -147,9 +143,8 @@
 		 * device wants.
 		 */
 
-		pcibios_write_config_dword(bus->number, dev->devfn, reg,
-					   0xffffffff);
-		pcibios_read_config_dword(bus->number, dev->devfn, reg, &base);
+		pci_write_config_dword(dev, reg, 0xffffffff);
+		pci_read_config_dword(dev, reg, &base);
 
 		if (!base)
 		{
@@ -184,8 +179,7 @@
 			alignto = MAX(0x040, size) ;
 			base = ALIGN(io_base, alignto);
 			io_base = base + size;
-			pcibios_write_config_dword(bus->number, dev->devfn,
-						   reg, base | PCI_BASE_ADDRESS_SPACE_IO);
+			pci_write_config_dword(dev, reg, base | PCI_BASE_ADDRESS_SPACE_IO);
 
 			dev->resource[i].start = base;
 			dev->resource[i].end = dev->resource[i].start + size - 1;
@@ -228,8 +222,7 @@
 			alignto = MAX(0x1000, size) ;
 			base = ALIGN(mem_base, alignto);
 			mem_base = base + size;
-			pcibios_write_config_dword(bus->number, dev->devfn,
-						   reg, base);
+			pci_write_config_dword(dev, reg, base);
 
 			dev->resource[i].start = base;
 			dev->resource[i].end = dev->resource[i].start + size - 1;
@@ -243,8 +236,7 @@
 				 */
 
 				reg += 4;
-				pcibios_write_config_dword(bus->number, dev->devfn,
-							   reg, 0);
+				pci_write_config_dword(dev, reg, 0);
 
 				i++;
 				dev->resource[i].start = 0;
@@ -272,17 +264,15 @@
 		cmd |= PCI_COMMAND_IO;
 	}
 
-	pcibios_write_config_word(bus->number, dev->devfn, PCI_COMMAND,
-				  cmd | PCI_COMMAND_MASTER);
+	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MASTER);
 
-	pcibios_write_config_byte(bus->number, dev->devfn, PCI_LATENCY_TIMER,
-				  (disable_pci_burst) ? 0 : 32);
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER, (disable_pci_burst) ? 0 : 32);
 
 	if (bus_info != NULL)
-		bus_info->conf_device(bus->number, dev->devfn);	/* Machine dependent configuration. */
+		bus_info->conf_device(dev);	/* Machine dependent configuration. */
 
 	DBG_DEVS(("layout_dev: bus %d  slot 0x%x  VID 0x%x  DID 0x%x  class 0x%x\n",
-		  bus->number, PCI_SLOT(dev->devfn), dev->vendor, dev->device, dev->class));
+		  dev->bus->number, PCI_SLOT(dev->devfn), dev->vendor, dev->device, dev->class));
 }
 
 /*
diff -Nru a/arch/ppc/platforms/mcpn765_setup.c b/arch/ppc/platforms/mcpn765_setup.c
--- a/arch/ppc/platforms/mcpn765_setup.c	Tue Oct 22 11:27:55 2002
+++ b/arch/ppc/platforms/mcpn765_setup.c	Tue Oct 22 11:27:55 2002
@@ -154,9 +154,9 @@
 	 * PPCBug doesn't set the enable bits for the IDE device.
 	 * Turn them on now.
 	 */
-	pcibios_read_config_byte(dev->bus->number, dev->devfn, 0x40, &c);
+	pci_read_config_byte(dev, 0x40, &c);
 	c |= 0x03;
-	pcibios_write_config_byte(dev->bus->number, dev->devfn, 0x40, c);
+	pci_write_config_byte(dev, 0x40, c);
 
 	return;
 }
diff -Nru a/arch/ppc/platforms/prep_pci.c b/arch/ppc/platforms/prep_pci.c
--- a/arch/ppc/platforms/prep_pci.c	Tue Oct 22 11:27:55 2002
+++ b/arch/ppc/platforms/prep_pci.c	Tue Oct 22 11:27:55 2002
@@ -1089,8 +1089,7 @@
 	devnum = PCI_SLOT(tdev->devfn);
 
 	/* Read the interrupt pin of the device and adjust for indexing */
-	pcibios_read_config_byte(dev->bus->number, dev->devfn,
-			PCI_INTERRUPT_PIN, &intpin);
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &intpin);
 
 	/* If device doesn't request an interrupt, return */
 	if ( (intpin < 1) || (intpin > 4) )
@@ -1162,7 +1161,7 @@
 		pci_for_each_dev(dev) {
 			if (dev->bus->number == 0) {
                        		dev->irq = openpic_to_irq(Motherboard_map[PCI_SLOT(dev->devfn)]);
-				pcibios_write_config_byte(dev->bus->number, dev->devfn, PCI_INTERRUPT_LINE, dev->irq);
+				pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 			} else {
 				if (Motherboard_non0 != NULL)
 					Motherboard_non0(dev);
diff -Nru a/drivers/isdn/hisax/bkm_a8.c b/drivers/isdn/hisax/bkm_a8.c
--- a/drivers/isdn/hisax/bkm_a8.c	Tue Oct 22 11:27:55 2002
+++ b/drivers/isdn/hisax/bkm_a8.c	Tue Oct 22 11:27:55 2002
@@ -285,8 +285,6 @@
 static struct pci_dev *dev_a8 __initdata = NULL;
 static u16  sub_vendor_id __initdata = 0;
 static u16  sub_sys_id __initdata = 0;
-static u_char pci_bus __initdata = 0;
-static u_char pci_device_fn __initdata = 0;
 static u_char pci_irq __initdata = 0;
 
 #endif /* CONFIG_PCI */
@@ -335,8 +333,6 @@
 					return(0);
 				pci_ioaddr1 = pci_resource_start(dev_a8, 1);
 				pci_irq = dev_a8->irq;
-				pci_bus = dev_a8->bus->number;
-				pci_device_fn = dev_a8->devfn;
 				found = 1;
 				break;
 			}
@@ -349,20 +345,17 @@
 		}
 #ifdef ATTEMPT_PCI_REMAPPING
 /* HACK: PLX revision 1 bug: PLX address bit 7 must not be set */
-		pcibios_read_config_byte(pci_bus, pci_device_fn,
-			PCI_REVISION_ID, &pci_rev_id);
+		pci_read_config_byte(dev_a8, PCI_REVISION_ID, &pci_rev_id);
 		if ((pci_ioaddr1 & 0x80) && (pci_rev_id == 1)) {
 			printk(KERN_WARNING "HiSax: %s (%s): PLX rev 1, remapping required!\n",
 				CardType[card->typ],
 				sct_quadro_subtypes[cs->subtyp]);
 			/* Restart PCI negotiation */
-			pcibios_write_config_dword(pci_bus, pci_device_fn,
-				PCI_BASE_ADDRESS_1, (u_int) - 1);
+			pci_write_config_dword(dev_a8, PCI_BASE_ADDRESS_1, (u_int) - 1);
 			/* Move up by 0x80 byte */
 			pci_ioaddr1 += 0x80;
 			pci_ioaddr1 &= PCI_BASE_ADDRESS_IO_MASK;
-			pcibios_write_config_dword(pci_bus, pci_device_fn,
-				PCI_BASE_ADDRESS_1, pci_ioaddr1);
+			pci_write_config_dword(dev_a8, PCI_BASE_ADDRESS_1, pci_ioaddr1);
 			dev_a8->resource[ 1].start = pci_ioaddr1;
 		}
 #endif /* End HACK */
@@ -373,11 +366,11 @@
 		       sct_quadro_subtypes[cs->subtyp]);
 		return (0);
 	}
-	pcibios_read_config_dword(pci_bus, pci_device_fn, PCI_BASE_ADDRESS_1, &pci_ioaddr1);
-	pcibios_read_config_dword(pci_bus, pci_device_fn, PCI_BASE_ADDRESS_2, &pci_ioaddr2);
-	pcibios_read_config_dword(pci_bus, pci_device_fn, PCI_BASE_ADDRESS_3, &pci_ioaddr3);
-	pcibios_read_config_dword(pci_bus, pci_device_fn, PCI_BASE_ADDRESS_4, &pci_ioaddr4);
-	pcibios_read_config_dword(pci_bus, pci_device_fn, PCI_BASE_ADDRESS_5, &pci_ioaddr5);
+	pci_read_config_dword(dev_a8, PCI_BASE_ADDRESS_1, &pci_ioaddr1);
+	pci_read_config_dword(dev_a8, PCI_BASE_ADDRESS_2, &pci_ioaddr2);
+	pci_read_config_dword(dev_a8, PCI_BASE_ADDRESS_3, &pci_ioaddr3);
+	pci_read_config_dword(dev_a8, PCI_BASE_ADDRESS_4, &pci_ioaddr4);
+	pci_read_config_dword(dev_a8, PCI_BASE_ADDRESS_5, &pci_ioaddr5);
 	if (!pci_ioaddr1 || !pci_ioaddr2 || !pci_ioaddr3 || !pci_ioaddr4 || !pci_ioaddr5) {
 		printk(KERN_WARNING "HiSax: %s (%s): No IO base address(es)\n",
 		       CardType[card->typ],
diff -Nru a/drivers/net/tulip/de4x5.c b/drivers/net/tulip/de4x5.c
--- a/drivers/net/tulip/de4x5.c	Tue Oct 22 11:27:55 2002
+++ b/drivers/net/tulip/de4x5.c	Tue Oct 22 11:27:55 2002
@@ -874,6 +874,7 @@
     struct de4x5_srom srom;
     int autosense;
     int useSROM;
+    struct pci_dev *pdev;
 } bus;
 
 /*
@@ -1151,8 +1152,7 @@
     if (lp->bus == EISA) {
 	outb(WAKEUP, PCI_CFPM);
     } else {
-	pcibios_write_config_byte(lp->bus_num, lp->device << 3, 
-				  PCI_CFDA_PSM, WAKEUP);
+	pci_write_config_byte(lp->pdev, PCI_CFDA_PSM, WAKEUP);
     }
     mdelay(10);
 
@@ -2222,11 +2222,12 @@
 	}
 
 	/* Get the chip configuration revision register */
-	pcibios_read_config_dword(pb, pdev->devfn, PCI_REVISION_ID, &cfrv);
+	pci_read_config_dword(pdev, PCI_REVISION_ID, &cfrv);
 
 	/* Set the device number information */
 	lp->device = dev_num;
 	lp->bus_num = pb;
+	lp->pdev = pdev;
 	    
 	/* Set the chipset information */
 	if (is_DC2114x) {
@@ -2242,27 +2243,27 @@
 	if ((irq == 0) || (irq == 0xff) || ((int)irq == -1)) continue;
 	    
 	/* Check if I/O accesses and Bus Mastering are enabled */
-	pcibios_read_config_word(pb, pdev->devfn, PCI_COMMAND, &status);
+	pci_read_config_word(pdev, PCI_COMMAND, &status);
 #ifdef __powerpc__
 	if (!(status & PCI_COMMAND_IO)) {
 	    status |= PCI_COMMAND_IO;
-	    pcibios_write_config_word(pb, pdev->devfn, PCI_COMMAND, status);
-	    pcibios_read_config_word(pb, pdev->devfn, PCI_COMMAND, &status);
+	    pci_write_config_word(pdev, PCI_COMMAND, status);
+	    pci_read_config_word(pdev, PCI_COMMAND, &status);
 	}
 #endif /* __powerpc__ */
 	if (!(status & PCI_COMMAND_IO)) continue;
 
 	if (!(status & PCI_COMMAND_MASTER)) {
 	    status |= PCI_COMMAND_MASTER;
-	    pcibios_write_config_word(pb, pdev->devfn, PCI_COMMAND, status);
-	    pcibios_read_config_word(pb, pdev->devfn, PCI_COMMAND, &status);
+	    pci_write_config_word(pdev, PCI_COMMAND, status);
+	    pci_read_config_word(pdev, PCI_COMMAND, &status);
 	}
 	if (!(status & PCI_COMMAND_MASTER)) continue;
 
 	/* Check the latency timer for values >= 0x60 */
-	pcibios_read_config_byte(pb, pdev->devfn, PCI_LATENCY_TIMER, &timer);
+	pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &timer);
 	if (timer < 0x60) {
-	    pcibios_write_config_byte(pb, pdev->devfn, PCI_LATENCY_TIMER, 0x60);
+	    pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0x60);
 	}
 
 	DevicePresent(DE4X5_APROM);
@@ -2314,7 +2315,7 @@
 
 	/* Get the chip configuration revision register */
 	pb = this_dev->bus->number;
-	pcibios_read_config_dword(pb, this_dev->devfn, PCI_REVISION_ID, &cfrv);
+	pci_read_config_dword(this_dev, PCI_REVISION_ID, &cfrv);
 
 	/* Set the device number information */
 	lp->device = PCI_SLOT(this_dev->devfn);
@@ -2334,7 +2335,7 @@
 	if ((irq == 0) || (irq == 0xff) || ((int)irq == -1)) continue;
 	    
 	/* Check if I/O accesses are enabled */
-	pcibios_read_config_word(pb, this_dev->devfn, PCI_COMMAND, &status);
+	pci_read_config_word(this_dev, PCI_COMMAND, &status);
 	if (!(status & PCI_COMMAND_IO)) continue;
 
 	/* Search for a valid SROM attached to this DECchip */
@@ -5325,20 +5326,17 @@
     } else {
 	switch(state) {
 	  case WAKEUP:
-	    pcibios_write_config_byte(lp->bus_num, lp->device << 3, 
-				      PCI_CFDA_PSM, WAKEUP);
+	    pci_write_config_byte(lp->pdev, PCI_CFDA_PSM, WAKEUP);
 	    mdelay(10);
 	    break;
 
 	  case SNOOZE:
-	    pcibios_write_config_byte(lp->bus_num, lp->device << 3, 
-				      PCI_CFDA_PSM, SNOOZE);
+	    pci_write_config_byte(lp->pdev, PCI_CFDA_PSM, SNOOZE);
 	    break;
 
 	  case SLEEP:
 	    outl(0, DE4X5_SICR);
-	    pcibios_write_config_byte(lp->bus_num, lp->device << 3, 
-				      PCI_CFDA_PSM, SLEEP);
+	    pci_write_config_byte(lp->pdev, PCI_CFDA_PSM, SLEEP);
 	    break;
 	}
     }
diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Tue Oct 22 11:27:55 2002
+++ b/drivers/pci/Makefile	Tue Oct 22 11:27:55 2002
@@ -3,10 +3,10 @@
 #
 
 export-objs	:= access.o hotplug.o pci-driver.o pci.o pool.o \
-			probe.o proc.o search.o compat.o
+			probe.o proc.o search.o
 
 obj-y		+= access.o probe.o pci.o pool.o quirks.o \
-			compat.o names.o pci-driver.o search.o hotplug.o
+			names.o pci-driver.o search.o hotplug.o
 obj-$(CONFIG_PM)  += power.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
diff -Nru a/drivers/pci/compat.c b/drivers/pci/compat.c
--- a/drivers/pci/compat.c	Tue Oct 22 11:27:55 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,37 +0,0 @@
-/*
- *	$Id: compat.c,v 1.1 1998/02/16 10:35:50 mj Exp $
- *
- *	PCI Bus Services -- Function For Backward Compatibility
- *
- *	Copyright 1998--2000 Martin Mares <mj@ucw.cz>
- */
-
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-
-/* Obsolete functions, these will be going away... */
-
-#define PCI_OP(rw,size,type)							\
-int pcibios_##rw##_config_##size (unsigned char bus, unsigned char dev_fn,	\
-				  unsigned char where, unsigned type val)	\
-{										\
-	struct pci_dev *dev = pci_find_slot(bus, dev_fn);			\
-	if (!dev) return PCIBIOS_DEVICE_NOT_FOUND;				\
-	return pci_##rw##_config_##size(dev, where, val);			\
-}
-
-PCI_OP(read, byte, char *)
-PCI_OP(read, word, short *)
-PCI_OP(read, dword, int *)
-PCI_OP(write, byte, char)
-PCI_OP(write, word, short)
-PCI_OP(write, dword, int)
-
-EXPORT_SYMBOL(pcibios_read_config_byte);
-EXPORT_SYMBOL(pcibios_read_config_word);
-EXPORT_SYMBOL(pcibios_read_config_dword);
-EXPORT_SYMBOL(pcibios_write_config_byte);
-EXPORT_SYMBOL(pcibios_write_config_word);
-EXPORT_SYMBOL(pcibios_write_config_dword);
diff -Nru a/drivers/scsi/53c7,8xx.c b/drivers/scsi/53c7,8xx.c
--- a/drivers/scsi/53c7,8xx.c	Tue Oct 22 11:27:55 2002
+++ b/drivers/scsi/53c7,8xx.c	Tue Oct 22 11:27:55 2002
@@ -1153,7 +1153,6 @@
 /* 
  * Function : static int normal_init(Scsi_Host_Template *tpnt, int board, 
  *	int chip, u32 base, int io_port, int irq, int dma, int pcivalid,
- *	unsigned char pci_bus, unsigned char pci_device_fn,
  *      struct pci_dev *pci_dev, long long options);
  *
  * Purpose : initializes a NCR53c7,8x0 based on base addresses,
@@ -1161,7 +1160,7 @@
  *	
  *	Useful where a new NCR chip is backwards compatible with
  *	a supported chip, but the DEVICE ID has changed so it 
- *	doesn't show up when the autoprobe does a pcibios_find_device.
+ *	doesn't show up when the autoprobe does a pci_find_device.
  *
  * Inputs : tpnt - Template for this SCSI adapter, board - board level
  *	product, chip - 810, 820, or 825, bus - PCI bus, device_fn -
@@ -1174,7 +1173,6 @@
 static int  __init 
 normal_init (Scsi_Host_Template *tpnt, int board, int chip, 
     u32 base, int io_port, int irq, int dma, int pci_valid, 
-    unsigned char pci_bus, unsigned char pci_device_fn,
     struct pci_dev *pci_dev, long long options)
 {
     struct Scsi_Host *instance;
@@ -1275,8 +1273,7 @@
     hostdata->board = board;
     hostdata->chip = chip;
     if ((hostdata->pci_valid = pci_valid)) {
-	hostdata->pci_bus = pci_bus;
-	hostdata->pci_device_fn = pci_device_fn;
+	hostdata->pci_dev = pci_dev;
     }
 
     /*
@@ -1377,7 +1374,7 @@
  *	
  *	Useful where a new NCR chip is backwards compatible with
  *	a supported chip, but the DEVICE ID has changed so it 
- *	doesn't show up when the autoprobe does a pcibios_find_device.
+ *	doesn't show up when the autoprobe does a pci_find_device.
  *
  * Inputs : tpnt - Template for this SCSI adapter, board - board level
  *	product, chip - 810, 820, or 825, bus - PCI bus, device_fn -
@@ -1511,7 +1508,7 @@
     }
 
     return normal_init (tpnt, board, chip, (int) base, io_port, 
-	(int) irq, DMA_NONE, 1, bus, device_fn, pdev, options);
+	(int) irq, DMA_NONE, 1, pdev, options);
 }
 
 
@@ -5085,8 +5082,7 @@
     if ((hostdata->chip / 100) == 8) {
 	save_flags (flags);
 	cli();
-	tmp = pcibios_read_config_word (hostdata->pci_bus, 
-	    hostdata->pci_device_fn, PCI_STATUS, &pci_status);
+	tmp = pci_read_config_word (hostdata->pcidev, PCI_STATUS, &pci_status);
 	restore_flags (flags);
 	if (tmp == PCIBIOS_SUCCESSFUL) {
 	    if (pci_status & PCI_STATUS_REC_TARGET_ABORT) {
diff -Nru a/drivers/scsi/53c7,8xx.h b/drivers/scsi/53c7,8xx.h
--- a/drivers/scsi/53c7,8xx.h	Tue Oct 22 11:27:55 2002
+++ b/drivers/scsi/53c7,8xx.h	Tue Oct 22 11:27:55 2002
@@ -1159,12 +1159,12 @@
 					   700-66, rest are last three
 					   digits of part number */
     /*
-     * PCI bus, device, function, only for NCR53c8x0 chips.
+     * PCI device, only for NCR53c8x0 chips.
      * pci_valid indicates that the PCI configuration information
      * is valid, and we can twiddle MAX_LAT, etc. as recommended
      * for maximum performance in the NCR documentation.
      */
-    unsigned char pci_bus, pci_device_fn;
+    struct pci_dev *pci_dev;
     unsigned pci_valid:1;
 
     u32 *dsp;				/* dsp to restart with after
diff -Nru a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
--- a/drivers/scsi/advansys.c	Tue Oct 22 11:27:55 2002
+++ b/drivers/scsi/advansys.c	Tue Oct 22 11:27:55 2002
@@ -1570,7 +1570,6 @@
     uchar               isa_dma_speed;
     uchar               isa_dma_channel;
     uchar               chip_version;
-    ushort              pci_device_id;
     ushort              lib_serial_no;
     ushort              lib_version;
     ushort              mcode_date;
@@ -1580,6 +1579,7 @@
     uchar               sdtr_period_offset[ASC_MAX_TID + 1];
     ushort              pci_slot_info;
     uchar               adapter_info[6];
+    struct pci_dev	*pci_dev;
 } ASC_DVC_CFG;
 
 #define ASC_DEF_DVC_CNTL       0xFFFF
@@ -3075,7 +3075,6 @@
   ushort disc_enable;       /* enable disconnection */
   uchar  chip_version;      /* chip version */
   uchar  termination;       /* Term. Ctrl. bits 6-5 of SCSI_CFG1 register */
-  ushort pci_device_id;     /* PCI device code number */
   ushort lib_version;       /* Adv Library version number */
   ushort control_flag;      /* Microcode Control Flag */
   ushort mcode_date;        /* Microcode date */
@@ -3086,6 +3085,7 @@
   ushort serial1;           /* EEPROM serial number word 1 */
   ushort serial2;           /* EEPROM serial number word 2 */
   ushort serial3;           /* EEPROM serial number word 3 */
+  struct pci_dev *pci_dev;  /* pointer to the pci dev structure for this board */
 } ADV_DVC_CFG;
 
 struct adv_dvc_var;
@@ -4957,7 +4957,7 @@
 #ifdef CONFIG_PCI
                 case ASC_IS_PCI:
                     shp->irq = asc_dvc_varp->irq_no = pci_devp->irq;
-                    asc_dvc_varp->cfg->pci_device_id = pci_devp->device;
+                    asc_dvc_varp->cfg->pci_dev = pci_devp;
                     asc_dvc_varp->cfg->pci_slot_info =
                         ASC_PCI_MKID(pci_devp->bus->number,
                             PCI_SLOT(pci_devp->devfn),
@@ -4981,7 +4981,7 @@
                  */
 #ifdef CONFIG_PCI
                 shp->irq = adv_dvc_varp->irq_no = pci_devp->irq;
-                adv_dvc_varp->cfg->pci_device_id = pci_devp->device;
+                adv_dvc_varp->cfg->pci_dev = pci_devp;
                 adv_dvc_varp->cfg->pci_slot_info =
                     ASC_PCI_MKID(pci_devp->bus->number,
                         PCI_SLOT(pci_devp->devfn),
@@ -9040,10 +9040,7 @@
 {
 #ifdef CONFIG_PCI
     uchar byte_data;
-    pcibios_read_config_byte(ASC_PCI_ID2BUS(asc_dvc->cfg->pci_slot_info),
-        PCI_DEVFN(ASC_PCI_ID2DEV(asc_dvc->cfg->pci_slot_info),
-            ASC_PCI_ID2FUNC(asc_dvc->cfg->pci_slot_info)),
-        offset, &byte_data);
+    pci_read_config_byte(asc_dvc->cfg->pci_dev, offset, &byte_data);
     return byte_data;
 #else /* !defined(CONFIG_PCI) */
     return 0;
@@ -9062,10 +9059,7 @@
 )
 {
 #ifdef CONFIG_PCI
-    pcibios_write_config_byte(ASC_PCI_ID2BUS(asc_dvc->cfg->pci_slot_info),
-        PCI_DEVFN(ASC_PCI_ID2DEV(asc_dvc->cfg->pci_slot_info),
-            ASC_PCI_ID2FUNC(asc_dvc->cfg->pci_slot_info)),
-        offset, byte_data);
+    pci_write_config_byte(asc_dvc->cfg->pci_dev, offset, byte_data);
 #endif /* CONFIG_PCI */
 }
 
@@ -9163,10 +9157,7 @@
 {
 #ifdef CONFIG_PCI
     uchar byte_data;
-    pcibios_read_config_byte(ASC_PCI_ID2BUS(asc_dvc->cfg->pci_slot_info),
-        PCI_DEVFN(ASC_PCI_ID2DEV(asc_dvc->cfg->pci_slot_info),
-            ASC_PCI_ID2FUNC(asc_dvc->cfg->pci_slot_info)),
-        offset, &byte_data);
+    pci_read_config_byte(asc_dvc->cfg->pci_dev, offset, &byte_data);
     return byte_data;
 #else /* CONFIG_PCI */
     return 0;
@@ -9185,10 +9176,7 @@
 )
 {
 #ifdef CONFIG_PCI
-    pcibios_write_config_byte(ASC_PCI_ID2BUS(asc_dvc->cfg->pci_slot_info),
-        PCI_DEVFN(ASC_PCI_ID2DEV(asc_dvc->cfg->pci_slot_info),
-            ASC_PCI_ID2FUNC(asc_dvc->cfg->pci_slot_info)),
-        offset, byte_data);
+    pci_write_config_byte(asc_dvc->cfg->pci_dev, offset, byte_data);
 #else /* CONFIG_PCI */
     return 0;
 #endif /* CONFIG_PCI */
@@ -9548,7 +9536,7 @@
 
     printk(
 " pci_device_id %d, lib_serial_no %u, lib_version %u, mcode_date 0x%x,\n",
-          h->pci_device_id, h->lib_serial_no, h->lib_version, h->mcode_date);
+          h->pci_dev->device, h->lib_serial_no, h->lib_version, h->mcode_date);
 
     printk(
 " mcode_version %d, overrun_buf 0x%lx\n",
@@ -9673,7 +9661,7 @@
 
     printk(
 "  mcode_version 0x%x, pci_device_id 0x%x, lib_version %u\n",
-       h->mcode_version, h->pci_device_id, h->lib_version);
+       h->mcode_version, h->pci_dev->device, h->lib_version);
 
     printk(
 "  control_flag 0x%x, pci_slot_info 0x%x\n",
@@ -12342,7 +12330,7 @@
     ushort              pci_device_id;
 
     iop_base = asc_dvc->iop_base;
-    pci_device_id = asc_dvc->cfg->pci_device_id;
+    pci_device_id = asc_dvc->cfg->pci_dev->device;
     warn_code = 0;
     cfg_msw = AscGetChipCfgMsw(iop_base);
     if ((cfg_msw & ASC_CFG_MSW_CLR_MASK) != 0) {
diff -Nru a/include/asm-m68k/pci.h b/include/asm-m68k/pci.h
--- a/include/asm-m68k/pci.h	Tue Oct 22 11:27:55 2002
+++ b/include/asm-m68k/pci.h	Tue Oct 22 11:27:55 2002
@@ -30,7 +30,7 @@
 	struct pci_ops *m68k_pci_ops;
 
 	void (*fixup)(int pci_modify);
-	void (*conf_device)(unsigned char bus, unsigned char device_fn);
+	void (*conf_device)(struct pci_dev *dev);
 };
 
 #define pcibios_assign_all_busses()	0
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Tue Oct 22 11:27:55 2002
+++ b/include/linux/pci.h	Tue Oct 22 11:27:55 2002
@@ -518,21 +518,6 @@
 void pcibios_update_irq(struct pci_dev *, int irq);
 void pcibios_fixup_pbus_ranges(struct pci_bus *, struct pbus_set_ranges_data *);
 
-/* Backward compatibility, don't use in new code! */
-
-int pcibios_read_config_byte (unsigned char bus, unsigned char dev_fn,
-			      unsigned char where, unsigned char *val);
-int pcibios_read_config_word (unsigned char bus, unsigned char dev_fn,
-			      unsigned char where, unsigned short *val);
-int pcibios_read_config_dword (unsigned char bus, unsigned char dev_fn,
-			       unsigned char where, unsigned int *val);
-int pcibios_write_config_byte (unsigned char bus, unsigned char dev_fn,
-			       unsigned char where, unsigned char val);
-int pcibios_write_config_word (unsigned char bus, unsigned char dev_fn,
-			       unsigned char where, unsigned short val);
-int pcibios_write_config_dword (unsigned char bus, unsigned char dev_fn,
-				unsigned char where, unsigned int val);
-
 /* Generic PCI functions used internally */
 
 int pci_bus_exists(const struct list_head *list, int nr);
@@ -658,8 +643,6 @@
 static inline int pci_present(void) { return 0; }
 
 #define _PCI_NOP(o,s,t) \
-	static inline int pcibios_##o##_config_##s (u8 bus, u8 dfn, u8 where, t val) \
-		{ return PCIBIOS_FUNC_NOT_SUPPORTED; } \
 	static inline int pci_##o##_config_##s (struct pci_dev *dev, int where, t val) \
 		{ return PCIBIOS_FUNC_NOT_SUPPORTED; }
 #define _PCI_NOP_ALL(o,x)	_PCI_NOP(o,byte,u8 x) \
