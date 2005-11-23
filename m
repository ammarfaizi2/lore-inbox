Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbVKWWgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbVKWWgc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030443AbVKWWgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:36:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3091 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030439AbVKWWfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:35:45 -0500
Date: Wed, 23 Nov 2005 23:35:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jejb@steeleye.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] remove drivers/mca/mca-proc.c
Message-ID: <20051123223543.GI3963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do we really need an additional proc interface for the few drivers still 
using the obsolete old MCA API?

This patch removes drivers/mca/mca-proc.c and does the cleanups that are 
possible after this removal.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/mca.c          |    2 
 arch/i386/kernel/setup.c        |   12 -
 drivers/block/ps2esdi.c         |    3 
 drivers/mca/Kconfig             |    6 
 drivers/mca/Makefile            |    1 
 drivers/mca/mca-device.c        |   17 --
 drivers/mca/mca-legacy.c        |    2 
 drivers/mca/mca-proc.c          |  249 --------------------------------
 drivers/net/3c523.c             |   34 ----
 drivers/net/eexpress.c          |    1 
 drivers/net/ibmlana.c           |   33 ----
 drivers/net/ne2.c               |   27 ---
 drivers/net/sk_mca.c            |    3 
 drivers/net/tokenring/madgemc.c |   47 ------
 drivers/scsi/aha1542.c          |    1 
 drivers/scsi/ibmmca.c           |   55 -------
 include/asm-i386/bugs.h         |    8 -
 include/asm-i386/processor.h    |    7 
 include/linux/mca.h             |   24 ---

--- linux-2.6.15-rc2-mm1-full/drivers/mca/Kconfig.old	2005-11-23 19:39:38.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/drivers/mca/Kconfig	2005-11-23 19:39:45.000000000 +0100
@@ -6,9 +6,3 @@
 	  have an unconverted MCA driver, you will need to say Y here.  It
 	  is safe to say Y anyway.
 
-config MCA_PROC_FS
-	bool "Support for the mca entry in /proc"
-	depends on MCA_LEGACY && PROC_FS
-	help
-	  If you want the old style /proc/mca directory in addition to the
-	  new style sysfs say Y here.
--- linux-2.6.15-rc2-mm1-full/drivers/mca/Makefile.old	2005-11-23 19:39:53.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/drivers/mca/Makefile	2005-11-23 19:39:56.000000000 +0100
@@ -2,6 +2,5 @@
 
 obj-y	:= mca-bus.o mca-device.o mca-driver.o
 
-obj-$(CONFIG_MCA_PROC_FS)	+= mca-proc.o
 obj-$(CONFIG_MCA_LEGACY)	+= mca-legacy.o
 
--- linux-2.6.15-rc2-mm1-full/include/linux/mca.h.old	2005-11-23 19:40:08.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/include/linux/mca.h	2005-11-23 19:52:58.000000000 +0100
@@ -58,14 +58,6 @@
 	short			pos_register;
 	
 	enum MCA_AdapterStatus	status;
-#ifdef CONFIG_MCA_PROC_FS
-	/* name of the proc/mca file */
-	char			procname[8];
-	/* /proc info callback */
-	MCA_ProcFn		procfn;
-	/* device/context info for proc callback */
-	void			*proc_dev;
-#endif
 	struct device		dev;
 	char			name[32];
 };
@@ -99,7 +91,6 @@
 #define to_mca_driver(mdriver) container_of(mdriver, struct mca_driver, driver)
 
 /* Ongoing supported API functions */
-extern struct mca_device *mca_find_device_by_slot(int slot);
 extern int mca_system_init(void);
 extern struct mca_bus *mca_attach_bus(int);
 
@@ -120,8 +111,6 @@
 	return mca_dev ? mca_dev->name : NULL;
 }
 
-extern enum MCA_AdapterStatus mca_device_status(struct mca_device *mca_dev);
-
 extern struct bus_type mca_bus_type;
 
 extern int mca_register_driver(struct mca_driver *drv);
@@ -130,17 +119,4 @@
 /* WARNING: only called by the boot time device setup */
 extern int mca_register_device(int bus, struct mca_device *mca_dev);
 
-#ifdef CONFIG_MCA_PROC_FS
-extern void mca_do_proc_init(void);
-extern void mca_set_adapter_procfn(int slot, MCA_ProcFn, void* dev);
-#else
-static inline void mca_do_proc_init(void)
-{
-}
-
-static inline void mca_set_adapter_procfn(int slot, MCA_ProcFn fn, void* dev)
-{
-}
-#endif
-
 #endif /* _LINUX_MCA_H */
--- linux-2.6.15-rc2-mm1-full/drivers/mca/mca-legacy.c.old	2005-11-23 19:53:13.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/drivers/mca/mca-legacy.c	2005-11-23 19:53:34.000000000 +0100
@@ -169,7 +169,7 @@
 	return 0;
 }
 
-struct mca_device *mca_find_device_by_slot(int slot)
+static struct mca_device *mca_find_device_by_slot(int slot)
 {
 	struct mca_find_device_by_slot_info info;
 
--- linux-2.6.15-rc2-mm1-full/drivers/mca/mca-device.c.old	2005-11-23 19:52:25.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/drivers/mca/mca-device.c	2005-11-23 19:52:36.000000000 +0100
@@ -187,23 +187,6 @@
 EXPORT_SYMBOL(mca_device_set_claim);
 
 /**
- *	mca_device_status - get the status of the device
- *	@mca_device:	device to get
- *
- *	returns an enumeration of the device status:
- *
- *	MCA_ADAPTER_NORMAL	adapter is OK.
- *	MCA_ADAPTER_NONE	no adapter at device (should never happen).
- *	MCA_ADAPTER_DISABLED	adapter is disabled.
- *	MCA_ADAPTER_ERROR	adapter cannot be initialised.
- */
-enum MCA_AdapterStatus mca_device_status(struct mca_device *mca_dev)
-{
-	return mca_dev->status;
-}
-EXPORT_SYMBOL(mca_device_status);
-
-/**
  *	mca_device_set_name - set the name of the device
  *	@mca_device:	device to set the name of
  *	@name:		name to set
--- linux-2.6.15-rc2-mm1-full/include/asm-i386/processor.h.old	2005-11-23 19:54:01.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/include/asm-i386/processor.h	2005-11-23 19:55:49.000000000 +0100
@@ -301,13 +301,6 @@
 		: :"a" (eax), "c" (ecx));
 }
 
-/* from system description table in BIOS.  Mostly for MCA use, but
-others may find it useful. */
-extern unsigned int machine_id;
-extern unsigned int machine_submodel_id;
-extern unsigned int BIOS_revision;
-extern unsigned int mca_pentium_flag;
-
 /* Boot loader type from the setup header */
 extern int bootloader_type;
 
--- linux-2.6.15-rc2-mm1-full/include/asm-i386/bugs.h.old	2005-11-23 19:56:33.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/include/asm-i386/bugs.h	2005-11-23 19:57:11.000000000 +0100
@@ -44,14 +44,6 @@
 
 __setup("no-hlt", no_halt);
 
-static int __init mca_pentium(char *s)
-{
-	mca_pentium_flag = 1;
-	return 1;
-}
-
-__setup("mca-pentium", mca_pentium);
-
 static int __init no_387(char *s)
 {
 	boot_cpu_data.hard_math = 0;
--- linux-2.6.15-rc2-mm1-full/arch/i386/kernel/mca.c.old	2005-11-23 19:40:46.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/i386/kernel/mca.c	2005-11-23 19:40:52.000000000 +0100
@@ -400,8 +400,6 @@
 	for (i = 0; i < MCA_STANDARD_RESOURCES; i++)
 		request_resource(&ioport_resource, mca_standard_resources + i);
 
-	mca_do_proc_init();
-
 	return 0;
 
  out_unlock_nomem:
--- linux-2.6.15-rc2-mm1-full/arch/i386/kernel/setup.c.old	2005-11-23 19:54:34.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/arch/i386/kernel/setup.c	2005-11-23 19:56:17.000000000 +0100
@@ -99,15 +99,6 @@
 extern acpi_interrupt_flags	acpi_sci_flags;
 #endif
 
-/* for MCA, but anyone else can use it if they want */
-unsigned int machine_id;
-#ifdef CONFIG_MCA
-EXPORT_SYMBOL(machine_id);
-#endif
-unsigned int machine_submodel_id;
-unsigned int BIOS_revision;
-unsigned int mca_pentium_flag;
-
 /* For PCI or other memory-mapped resources */
 unsigned long pci_mem_start = 0x10000000;
 #ifdef CONFIG_PCI
@@ -1519,9 +1510,6 @@
 	saved_videomode = VIDEO_MODE;
 	if( SYS_DESC_TABLE.length != 0 ) {
 		set_mca_bus(SYS_DESC_TABLE.table[3] & 0x2);
-		machine_id = SYS_DESC_TABLE.table[0];
-		machine_submodel_id = SYS_DESC_TABLE.table[1];
-		BIOS_revision = SYS_DESC_TABLE.table[2];
 	}
 	bootloader_type = LOADER_TYPE;
 
--- linux-2.6.15-rc2-mm1-full/drivers/block/ps2esdi.c.old	2005-11-23 19:41:08.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/drivers/block/ps2esdi.c	2005-11-23 19:41:19.000000000 +0100
@@ -205,7 +205,6 @@
 	int i;
 	if(ps2esdi_slot) {
 		mca_mark_as_unused(ps2esdi_slot);
-		mca_set_adapter_procfn(ps2esdi_slot, NULL, NULL);
 	}
 	release_region(io_base, 4);
 	free_dma(dma_arb_level);
@@ -313,7 +312,6 @@
 
 	ps2esdi_slot = slot;
 	mca_mark_as_used(slot);
-	mca_set_adapter_procfn(slot, (MCA_ProcFn) ps2esdi_getinfo, NULL);
 
 	/* Found the slot - read the POS register 2 to get the necessary
 	   configuration and status information.  POS register 2 has the
@@ -444,7 +442,6 @@
 err_out1:
 	if(ps2esdi_slot) {
 		mca_mark_as_unused(ps2esdi_slot);
-		mca_set_adapter_procfn(ps2esdi_slot, NULL, NULL);
 	}
 	return error;
 }
--- linux-2.6.15-rc2-mm1-full/drivers/net/3c523.c.old	2005-11-23 19:41:28.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/drivers/net/3c523.c	2005-11-23 19:45:48.000000000 +0100
@@ -379,37 +379,6 @@
 
 /*****************************************************************/
 
-static int elmc_getinfo(char *buf, int slot, void *d)
-{
-	int len = 0;
-	struct net_device *dev = (struct net_device *) d;
-	int i;
-
-	if (dev == NULL)
-		return len;
-
-	len += sprintf(buf + len, "Revision: 0x%x\n",
-		       inb(dev->base_addr + ELMC_REVISION) & 0xf);
-	len += sprintf(buf + len, "IRQ: %d\n", dev->irq);
-	len += sprintf(buf + len, "IO Address: %#lx-%#lx\n", dev->base_addr,
-		       dev->base_addr + ELMC_IO_EXTENT);
-	len += sprintf(buf + len, "Memory: %#lx-%#lx\n", dev->mem_start,
-		       dev->mem_end - 1);
-	len += sprintf(buf + len, "Transceiver: %s\n", dev->if_port ?
-		       "External" : "Internal");
-	len += sprintf(buf + len, "Device: %s\n", dev->name);
-	len += sprintf(buf + len, "Hardware Address:");
-	for (i = 0; i < 6; i++) {
-		len += sprintf(buf + len, " %02x", dev->dev_addr[i]);
-	}
-	buf[len++] = '\n';
-	buf[len] = 0;
-
-	return len;
-}				/* elmc_getinfo() */
-
-/*****************************************************************/
-
 static int __init do_elmc_probe(struct net_device *dev)
 {
 	static int slot;
@@ -459,7 +428,6 @@
 		return ((base_addr || irq) ? -ENXIO : -ENODEV);
 
 	mca_set_adapter_name(slot, "3Com 3c523 Etherlink/MC");
-	mca_set_adapter_procfn(slot, (MCA_ProcFn) elmc_getinfo, dev);
 
 	/* if we get this far, adapter has been found - carry on */
 	printk(KERN_INFO "%s: 3c523 adapter found in slot %d\n", dev->name, slot + 1);
@@ -578,14 +546,12 @@
 
 	return 0;
 err_out:
-	mca_set_adapter_procfn(slot, NULL, NULL);
 	release_region(dev->base_addr, ELMC_IO_EXTENT);
 	return retval;
 }
  
 static void cleanup_card(struct net_device *dev)
 {
-	mca_set_adapter_procfn(((struct priv *) (dev->priv))->slot, NULL, NULL);
 	release_region(dev->base_addr, ELMC_IO_EXTENT);
 }
 
--- linux-2.6.15-rc2-mm1-full/drivers/net/eexpress.c.old	2005-11-23 19:41:43.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/drivers/net/eexpress.c	2005-11-23 19:41:46.000000000 +0100
@@ -385,7 +385,6 @@
 			}
 
 			mca_set_adapter_name(slot, "Intel EtherExpress 16 MCA");
-			mca_set_adapter_procfn(slot, NULL, dev);
 			mca_mark_as_used(slot);
 
 			break;
--- linux-2.6.15-rc2-mm1-full/drivers/net/ibmlana.c.old	2005-11-23 19:41:53.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/drivers/net/ibmlana.c	2005-11-23 19:49:32.000000000 +0100
@@ -743,36 +743,6 @@
  * driver methods
  * ------------------------------------------------------------------------ */
 
-/* MCA info */
-
-static int ibmlana_getinfo(char *buf, int slot, void *d)
-{
-	int len = 0, i;
-	struct net_device *dev = (struct net_device *) d;
-	ibmlana_priv *priv;
-
-	/* can't say anything about an uninitialized device... */
-
-	if (dev == NULL)
-		return len;
-	priv = netdev_priv(dev);
-
-	/* print info */
-
-	len += sprintf(buf + len, "IRQ: %d\n", priv->realirq);
-	len += sprintf(buf + len, "I/O: %#lx\n", dev->base_addr);
-	len += sprintf(buf + len, "Memory: %#lx-%#lx\n", dev->mem_start, dev->mem_end - 1);
-	len += sprintf(buf + len, "Transceiver: %s\n", MediaNames[priv->medium]);
-	len += sprintf(buf + len, "Device: %s\n", dev->name);
-	len += sprintf(buf + len, "MAC address:");
-	for (i = 0; i < 6; i++)
-		len += sprintf(buf + len, " %02x", dev->dev_addr[i]);
-	buf[len++] = '\n';
-	buf[len] = 0;
-
-	return len;
-}
-
 /* open driver.  Means also initialization and start of LANCE */
 
 static int ibmlana_open(struct net_device *dev)
@@ -971,7 +941,6 @@
 
 	/* make procfs entries */
 	mca_set_adapter_name(slot, "IBM LAN Adapter/A");
-	mca_set_adapter_procfn(slot, (MCA_ProcFn) ibmlana_getinfo, dev);
 
 	mca_mark_as_used(slot);
 
@@ -1049,7 +1018,6 @@
 			release_region(dev->base_addr, IBM_LANA_IORANGE);
 			mca_mark_as_unused(priv->slot);
 			mca_set_adapter_name(priv->slot, "");
-			mca_set_adapter_procfn(priv->slot, NULL, NULL);
 			iounmap(priv->base);
 			free_netdev(dev);
 			break;
@@ -1071,7 +1039,6 @@
 			release_region(dev->base_addr, IBM_LANA_IORANGE);
 			mca_mark_as_unused(priv->slot);
 			mca_set_adapter_name(priv->slot, "");
-			mca_set_adapter_procfn(priv->slot, NULL, NULL);
 			iounmap(priv->base);
 			free_netdev(dev);
 		}
--- linux-2.6.15-rc2-mm1-full/drivers/net/ne2.c.old	2005-11-23 19:42:16.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/drivers/net/ne2.c	2005-11-23 19:45:25.000000000 +0100
@@ -281,7 +281,6 @@
 static void cleanup_card(struct net_device *dev)
 {
 	mca_mark_as_unused(ei_status.priv);
-	mca_set_adapter_procfn( ei_status.priv, NULL, NULL);
 	free_irq(dev->irq, dev);
 	release_region(dev->base_addr, NE_IO_EXTENT);
 }
@@ -308,29 +307,6 @@
 }
 #endif
 
-static int ne2_procinfo(char *buf, int slot, struct net_device *dev)
-{
-	int len=0;
-
-	len += sprintf(buf+len, "The NE/2 Ethernet Adapter\n" );
-	len += sprintf(buf+len, "Driver written by Wim Dumon ");
-	len += sprintf(buf+len, "<wimpie@kotnet.org>\n"); 
-	len += sprintf(buf+len, "Modified by ");
-	len += sprintf(buf+len, "David Weinehall <tao@acc.umu.se>\n");
-	len += sprintf(buf+len, "and by Magnus Jonsson <bigfoot@acc.umu.se>\n");
-	len += sprintf(buf+len, "Based on the original NE2000 drivers\n" );
-	len += sprintf(buf+len, "Base IO: %#x\n", (unsigned int)dev->base_addr);
-	len += sprintf(buf+len, "IRQ    : %d\n", dev->irq);
-
-#define HW_ADDR(i) dev->dev_addr[i]
-	len += sprintf(buf+len, "HW addr : %x:%x:%x:%x:%x:%x\n", 
-			HW_ADDR(0), HW_ADDR(1), HW_ADDR(2), 
-			HW_ADDR(3), HW_ADDR(4), HW_ADDR(5) );
-#undef HW_ADDR
-
-	return len;
-}
-
 static int __init ne2_probe1(struct net_device *dev, int slot)
 {
 	int i, base_addr, irq, retval;
@@ -486,8 +462,6 @@
 	printk("\n%s: %s found at %#x, using IRQ %d.\n",
 			dev->name, name, base_addr, dev->irq);
 
-	mca_set_adapter_procfn(slot, (MCA_ProcFn) ne2_procinfo, dev);
-
 	ei_status.name = name;
 	ei_status.tx_start_page = start_page;
 	ei_status.stop_page = stop_page;
@@ -518,7 +492,6 @@
 		goto out1;
 	return 0;
 out1:
-	mca_set_adapter_procfn( ei_status.priv, NULL, NULL);
 	free_irq(dev->irq, dev);
 out:
 	release_region(base_addr, NE_IO_EXTENT);
--- linux-2.6.15-rc2-mm1-full/drivers/net/sk_mca.c.old	2005-11-23 19:42:31.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/drivers/net/sk_mca.c	2005-11-23 19:42:40.000000000 +0100
@@ -1016,7 +1016,6 @@
 		free_irq(dev->irq, dev);
 	iounmap(priv->base);
 	mca_mark_as_unused(priv->slot);
-	mca_set_adapter_procfn(priv->slot, NULL, NULL);
 }
 
 struct net_device * __init skmca_probe(int unit)
@@ -1090,7 +1089,6 @@
 				     "SKNET junior MC2 Ethernet Adapter");
 	else
 		mca_set_adapter_name(slot, "SKNET MC2+ Ethernet Adapter");
-	mca_set_adapter_procfn(slot, (MCA_ProcFn) skmca_getinfo, dev);
 
 	mca_mark_as_used(slot);
 
@@ -1101,7 +1099,6 @@
 	priv = netdev_priv(dev);
 	priv->base = ioremap(base, 0x4000);
 	if (!priv->base) {
-		mca_set_adapter_procfn(slot, NULL, NULL);
 		mca_mark_as_unused(slot);
 		free_netdev(dev);
 		return ERR_PTR(-ENOMEM);
--- linux-2.6.15-rc2-mm1-full/drivers/net/tokenring/madgemc.c.old	2005-11-23 19:42:51.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/drivers/net/tokenring/madgemc.c	2005-11-23 19:45:04.000000000 +0100
@@ -64,8 +64,6 @@
 static unsigned short madgemc_setnselout_pins(struct net_device *dev);
 static void madgemc_setcabletype(struct net_device *dev, int type);
 
-static int madgemc_mcaproc(char *buf, int slot, void *d);
-
 static void madgemc_setregpage(struct net_device *dev, int page);
 static void madgemc_setsifsel(struct net_device *dev, int val);
 static void madgemc_setint(struct net_device *dev, int val);
@@ -322,7 +320,6 @@
 
 	/* Setup MCA structures */
 	mca_device_set_name(mdev, (card->cardtype == 0x08)?MADGEMC16_CARDNAME:MADGEMC32_CARDNAME);
-	mca_set_adapter_procfn(mdev->slot, madgemc_mcaproc, dev);
 
 	printk("%s:     Ring Station Address: ", dev->name);
 	printk("%2.2x", dev->dev_addr[0]);
@@ -685,50 +682,6 @@
 	return 0;
 }
 
-/*
- * Give some details available from /proc/mca/slotX
- */
-static int madgemc_mcaproc(char *buf, int slot, void *d) 
-{	
-	struct net_device *dev = (struct net_device *)d;
-	struct net_local *tp = dev->priv;
-	struct card_info *curcard = tp->tmspriv;
-	int len = 0;
-	
-	len += sprintf(buf+len, "-------\n");
-	if (curcard) {
-		struct net_local *tp = netdev_priv(dev);
-		int i;
-		
-		len += sprintf(buf+len, "Card Revision: %d\n", curcard->cardrev);
-		len += sprintf(buf+len, "RAM Size: %dkb\n", curcard->ramsize);
-		len += sprintf(buf+len, "Cable type: %s\n", (curcard->cabletype)?"STP/DB9":"UTP/RJ-45");
-		len += sprintf(buf+len, "Configured ring speed: %dMb/sec\n", (curcard->ringspeed)?16:4);
-		len += sprintf(buf+len, "Running ring speed: %dMb/sec\n", (tp->DataRate==SPEED_16)?16:4);
-		len += sprintf(buf+len, "Device: %s\n", dev->name);
-		len += sprintf(buf+len, "IO Port: 0x%04lx\n", dev->base_addr);
-		len += sprintf(buf+len, "IRQ: %d\n", dev->irq);
-		len += sprintf(buf+len, "Arbitration Level: %d\n", curcard->arblevel);
-		len += sprintf(buf+len, "Burst Mode: ");
-		switch(curcard->burstmode) {
-		case 0: len += sprintf(buf+len, "Cycle steal"); break;
-		case 1: len += sprintf(buf+len, "Limited burst"); break;
-		case 2: len += sprintf(buf+len, "Delayed release"); break;
-		case 3: len += sprintf(buf+len, "Immediate release"); break;
-		}
-		len += sprintf(buf+len, " (%s)\n", (curcard->fairness)?"Unfair":"Fair");
-		
-		len += sprintf(buf+len, "Ring Station Address: ");
-		len += sprintf(buf+len, "%2.2x", dev->dev_addr[0]);
-		for (i = 1; i < 6; i++)
-			len += sprintf(buf+len, " %2.2x", dev->dev_addr[i]);
-		len += sprintf(buf+len, "\n");
-	} else 
-		len += sprintf(buf+len, "Card not configured\n");
-
-	return len;
-}
-
 static int __devexit madgemc_remove(struct device *device)
 {
 	struct net_device *dev = dev_get_drvdata(device);
--- linux-2.6.15-rc2-mm1-full/drivers/scsi/aha1542.c.old	2005-11-23 19:43:03.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/drivers/scsi/aha1542.c	2005-11-23 19:43:08.000000000 +0100
@@ -1116,7 +1116,6 @@
 			printk(KERN_INFO "Found an AHA-1640 in MCA slot %d, I/O 0x%04x\n", slot, bases[indx]);
 
 			mca_set_adapter_name(slot, "Adapter AHA-1640");
-			mca_set_adapter_procfn(slot, NULL, NULL);
 			mca_mark_as_used(slot);
 			
 			/* Go on */
--- linux-2.6.15-rc2-mm1-full/drivers/scsi/ibmmca.c.old	2005-11-23 19:43:18.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/drivers/scsi/ibmmca.c	2005-11-23 19:47:00.000000000 +0100
@@ -1432,57 +1432,6 @@
 	return;
 }
 
-static int ibmmca_getinfo(char *buf, int slot, void *dev_id)
-{
-	struct Scsi_Host *shpnt;
-	int len, speciale, connectore, k;
-	unsigned int pos[8];
-	unsigned long flags;
-	struct Scsi_Host *dev = dev_id;
-
-	spin_lock_irqsave(dev->host_lock, flags);
-	
-	shpnt = dev;		/* assign host-structure to local pointer */
-	len = 0;		/* set filled text-buffer index to 0 */
-	/* get the _special contents of the hostdata structure */
-	speciale = ((struct ibmmca_hostdata *) shpnt->hostdata)->_special;
-	connectore = ((struct ibmmca_hostdata *) shpnt->hostdata)->_connector_size;
-	for (k = 2; k < 4; k++)
-		pos[k] = ((struct ibmmca_hostdata *) shpnt->hostdata)->_pos[k];
-	if (speciale == FORCED_DETECTION) {	/* forced detection */
-		len += sprintf(buf + len,
-			       "Adapter category: forced detected\n" "***************************************\n" "***  Forced detected SCSI Adapter   ***\n" "***  No chip-information available  ***\n" "***************************************\n");
-	} else if (speciale == INTEGRATED_SCSI) {
-		/* if the integrated subsystem has been found automatically: */
-		len += sprintf(buf + len,
-			       "Adapter category: integrated\n" "Chip revision level: %d\n" "Chip status: %s\n" "8 kByte NVRAM status: %s\n", ((pos[2] & 0xf0) >> 4), (pos[2] & 1) ? "enabled" : "disabled", (pos[2] & 2) ? "locked" : "accessible");
-	} else if ((speciale >= 0) && (speciale < (sizeof(subsys_list) / sizeof(struct subsys_list_struct)))) {
-		/* if the subsystem is a slot adapter */
-		len += sprintf(buf + len, "Adapter category: slot-card\n" "ROM Segment Address: ");
-		if ((pos[2] & 0xf0) == 0xf0)
-			len += sprintf(buf + len, "off\n");
-		else
-			len += sprintf(buf + len, "0x%x\n", ((pos[2] & 0xf0) << 13) + 0xc0000);
-		len += sprintf(buf + len, "Chip status: %s\n", (pos[2] & 1) ? "enabled" : "disabled");
-		len += sprintf(buf + len, "Adapter I/O Offset: 0x%x\n", ((pos[2] & 0x0e) << 2));
-	} else {
-		len += sprintf(buf + len, "Adapter category: unknown\n");
-	}
-	/* common subsystem information to write to the slotn file */
-	len += sprintf(buf + len, "Subsystem PUN: %d\n", shpnt->this_id);
-	len += sprintf(buf + len, "I/O base address range: 0x%x-0x%x\n", (unsigned int) (shpnt->io_port), (unsigned int) (shpnt->io_port + 7));
-	len += sprintf(buf + len, "MCA-slot size: %d bits", connectore);
-	/* Now make sure, the bufferlength is devidable by 4 to avoid
-	 * paging problems of the buffer. */
-	while (len % sizeof(int) != (sizeof(int) - 1))
-		len += sprintf(buf + len, " ");
-	len += sprintf(buf + len, "\n");
-	
-	spin_unlock_irqrestore(shpnt->host_lock, flags);
-	
-	return len;
-}
-
 int ibmmca_detect(struct scsi_host_template * scsi_template)
 {
 	struct Scsi_Host *shpnt;
@@ -1526,7 +1475,6 @@
 					((struct ibmmca_hostdata *) shpnt->hostdata)->_pos[k] = 0;
 				((struct ibmmca_hostdata *) shpnt->hostdata)->_special = FORCED_DETECTION;
 				mca_set_adapter_name(MCA_INTEGSCSI, "forced detected SCSI Adapter");
-				mca_set_adapter_procfn(MCA_INTEGSCSI, (MCA_ProcFn) ibmmca_getinfo, shpnt);
 				mca_mark_as_used(MCA_INTEGSCSI);
 				devices_on_irq_14++;
 			}
@@ -1594,7 +1542,6 @@
 				((struct ibmmca_hostdata *) shpnt->hostdata)->_pos[k] = pos[k];
 			((struct ibmmca_hostdata *) shpnt->hostdata)->_special = INTEGRATED_SCSI;
 			mca_set_adapter_name(MCA_INTEGSCSI, "IBM Integrated SCSI Controller");
-			mca_set_adapter_procfn(MCA_INTEGSCSI, (MCA_ProcFn) ibmmca_getinfo, shpnt);
 			mca_mark_as_used(MCA_INTEGSCSI);
 			devices_on_irq_14++;
 		}
@@ -1655,7 +1602,6 @@
 					((struct ibmmca_hostdata *) shpnt->hostdata)->_pos[k] = pos[k];
 				((struct ibmmca_hostdata *) shpnt->hostdata)->_special = i;
 				mca_set_adapter_name(slot, subsys_list[i].description);
-				mca_set_adapter_procfn(slot, (MCA_ProcFn) ibmmca_getinfo, shpnt);
 				mca_mark_as_used(slot);
 				if ((i == IBM_SCSI2_FW) && (pos[4] & 0x01) && (pos[6] == 0))
 					devices_on_irq_11++;
@@ -1717,7 +1663,6 @@
 					((struct ibmmca_hostdata *) shpnt->hostdata)->_pos[k] = pos[k];
 				((struct ibmmca_hostdata *) shpnt->hostdata)->_special = i;
 				mca_set_adapter_name(slot, subsys_list[i].description);
-				mca_set_adapter_procfn(slot, (MCA_ProcFn) ibmmca_getinfo, shpnt);
 				mca_mark_as_used(slot);
 				if ((i == IBM_SCSI2_FW) && (pos[4] & 0x01) && (pos[6] == 0))
 					devices_on_irq_11++;
--- linux-2.6.15-rc2-mm1-full/drivers/mca/mca-proc.c	2005-10-28 02:02:08.000000000 +0200
+++ /dev/null	2005-11-08 19:07:57.000000000 +0100
@@ -1,249 +0,0 @@
-/* -*- mode: c; c-basic-offset: 8 -*- */
-
-/*
- * MCA bus support functions for the proc fs.
- *
- * NOTE: this code *requires* the legacy MCA api.
- *
- * Legacy API means the API that operates in terms of MCA slot number
- *
- * (C) 2002 James Bottomley <James.Bottomley@HansenPartnership.com>
- *
-**-----------------------------------------------------------------------------
-**  
-**  This program is free software; you can redistribute it and/or modify
-**  it under the terms of the GNU General Public License as published by
-**  the Free Software Foundation; either version 2 of the License, or
-**  (at your option) any later version.
-**
-**  This program is distributed in the hope that it will be useful,
-**  but WITHOUT ANY WARRANTY; without even the implied warranty of
-**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-**  GNU General Public License for more details.
-**
-**  You should have received a copy of the GNU General Public License
-**  along with this program; if not, write to the Free Software
-**  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-**
-**-----------------------------------------------------------------------------
- */
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/proc_fs.h>
-#include <linux/mca.h>
-
-static int get_mca_info_helper(struct mca_device *mca_dev, char *page, int len)
-{
-	int j;
-
-	for(j=0; j<8; j++)
-		len += sprintf(page+len, "%02x ",
-			       mca_dev ? mca_dev->pos[j] : 0xff);
-	len += sprintf(page+len, " %s\n", mca_dev ? mca_dev->name : "");
-	return len;
-}
-
-static int get_mca_info(char *page, char **start, off_t off,
-			int count, int *eof, void *data)
-{
-	int i, len = 0;
-
-	if(MCA_bus) {
-		struct mca_device *mca_dev;
-		/* Format POS registers of eight MCA slots */
-
-		for(i=0; i<MCA_MAX_SLOT_NR; i++) {
-			mca_dev = mca_find_device_by_slot(i);
-
-			len += sprintf(page+len, "Slot %d: ", i+1);
-			len = get_mca_info_helper(mca_dev, page, len);
-		}
-
-		/* Format POS registers of integrated video subsystem */
-
-		mca_dev = mca_find_device_by_slot(MCA_INTEGVIDEO);
-		len += sprintf(page+len, "Video : ");
-		len = get_mca_info_helper(mca_dev, page, len);
-
-		/* Format POS registers of integrated SCSI subsystem */
-
-		mca_dev = mca_find_device_by_slot(MCA_INTEGSCSI);
-		len += sprintf(page+len, "SCSI  : ");
-		len = get_mca_info_helper(mca_dev, page, len);
-
-		/* Format POS registers of motherboard */
-
-		mca_dev = mca_find_device_by_slot(MCA_MOTHERBOARD);
-		len += sprintf(page+len, "Planar: ");
-		len = get_mca_info_helper(mca_dev, page, len);
-	} else {
-		/* Leave it empty if MCA not detected - this should *never*
-		 * happen!
-		 */
-	}
-
-	if (len <= off+count) *eof = 1;
-	*start = page + off;
-	len -= off;
-	if (len>count) len = count;
-	if (len<0) len = 0;
-	return len;
-}
-
-/*--------------------------------------------------------------------*/
-
-static int mca_default_procfn(char* buf, struct mca_device *mca_dev)
-{
-	int len = 0, i;
-	int slot = mca_dev->slot;
-
-	/* Print out the basic information */
-
-	if(slot < MCA_MAX_SLOT_NR) {
-		len += sprintf(buf+len, "Slot: %d\n", slot+1);
-	} else if(slot == MCA_INTEGSCSI) {
-		len += sprintf(buf+len, "Integrated SCSI Adapter\n");
-	} else if(slot == MCA_INTEGVIDEO) {
-		len += sprintf(buf+len, "Integrated Video Adapter\n");
-	} else if(slot == MCA_MOTHERBOARD) {
-		len += sprintf(buf+len, "Motherboard\n");
-	}
-	if (mca_dev->name[0]) {
-
-		/* Drivers might register a name without /proc handler... */
-
-		len += sprintf(buf+len, "Adapter Name: %s\n",
-			       mca_dev->name);
-	} else {
-		len += sprintf(buf+len, "Adapter Name: Unknown\n");
-	}
-	len += sprintf(buf+len, "Id: %02x%02x\n",
-		mca_dev->pos[1], mca_dev->pos[0]);
-	len += sprintf(buf+len, "Enabled: %s\nPOS: ",
-		mca_device_status(mca_dev) == MCA_ADAPTER_NORMAL ?
-			"Yes" : "No");
-	for(i=0; i<8; i++) {
-		len += sprintf(buf+len, "%02x ", mca_dev->pos[i]);
-	}
-	len += sprintf(buf+len, "\nDriver Installed: %s",
-		mca_device_claimed(mca_dev) ? "Yes" : "No");
-	buf[len++] = '\n';
-	buf[len] = 0;
-
-	return len;
-} /* mca_default_procfn() */
-
-static int get_mca_machine_info(char* page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	int len = 0;
-
-	len += sprintf(page+len, "Model Id: 0x%x\n", machine_id);
-	len += sprintf(page+len, "Submodel Id: 0x%x\n", machine_submodel_id);
-	len += sprintf(page+len, "BIOS Revision: 0x%x\n", BIOS_revision);
-
-	if (len <= off+count) *eof = 1;
-	*start = page + off;
-	len -= off;
-	if (len>count) len = count;
-	if (len<0) len = 0;
-	return len;
-}
-
-static int mca_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	struct mca_device *mca_dev = (struct mca_device *)data;
-	int len = 0;
-
-	/* Get the standard info */
-
-	len = mca_default_procfn(page, mca_dev);
-
-	/* Do any device-specific processing, if there is any */
-
-	if(mca_dev->procfn) {
-		len += mca_dev->procfn(page+len, mca_dev->slot,
-				       mca_dev->proc_dev);
-	}
-	if (len <= off+count) *eof = 1;
-	*start = page + off;
-	len -= off;
-	if (len>count) len = count;
-	if (len<0) len = 0;
-	return len;
-} /* mca_read_proc() */
-
-/*--------------------------------------------------------------------*/
-
-void __init mca_do_proc_init(void)
-{
-	int i;
-	struct proc_dir_entry *proc_mca;
-	struct proc_dir_entry* node = NULL;
-	struct mca_device *mca_dev;
-
-	proc_mca = proc_mkdir("mca", &proc_root);
-	create_proc_read_entry("pos",0,proc_mca,get_mca_info,NULL);
-	create_proc_read_entry("machine",0,proc_mca,get_mca_machine_info,NULL);
-
-	/* Initialize /proc/mca entries for existing adapters */
-
-	for(i = 0; i < MCA_NUMADAPTERS; i++) {
-		enum MCA_AdapterStatus status;
-		mca_dev = mca_find_device_by_slot(i);
-		if(!mca_dev)
-			continue;
-
-		mca_dev->procfn = NULL;
-
-		if(i < MCA_MAX_SLOT_NR) sprintf(mca_dev->procname,"slot%d", i+1);
-		else if(i == MCA_INTEGVIDEO) sprintf(mca_dev->procname,"video");
-		else if(i == MCA_INTEGSCSI) sprintf(mca_dev->procname,"scsi");
-		else if(i == MCA_MOTHERBOARD) sprintf(mca_dev->procname,"planar");
-
-		status = mca_device_status(mca_dev);
-		if (status != MCA_ADAPTER_NORMAL &&
-		    status != MCA_ADAPTER_DISABLED)
-			continue;
-
-		node = create_proc_read_entry(mca_dev->procname, 0, proc_mca,
-					      mca_read_proc, (void *)mca_dev);
-
-		if(node == NULL) {
-			printk("Failed to allocate memory for MCA proc-entries!");
-			return;
-		}
-	}
-
-} /* mca_do_proc_init() */
-
-/**
- *	mca_set_adapter_procfn - Set the /proc callback
- *	@slot: slot to configure
- *	@procfn: callback function to call for /proc
- *	@dev: device information passed to the callback
- *
- *	This sets up an information callback for /proc/mca/slot?.  The
- *	function is called with the buffer, slot, and device pointer (or
- *	some equally informative context information, or nothing, if you
- *	prefer), and is expected to put useful information into the
- *	buffer.  The adapter name, ID, and POS registers get printed
- *	before this is called though, so don't do it again.
- *
- *	This should be called with a %NULL @procfn when a module
- *	unregisters, thus preventing kernel crashes and other such
- *	nastiness.
- */
-
-void mca_set_adapter_procfn(int slot, MCA_ProcFn procfn, void* proc_dev)
-{
-	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
-
-	if(!mca_dev)
-		return;
-
-	mca_dev->procfn = procfn;
-	mca_dev->proc_dev = proc_dev;
-}
-EXPORT_SYMBOL(mca_set_adapter_procfn);

