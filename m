Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbUJWQgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbUJWQgK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 12:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbUJWQgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 12:36:10 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50959 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261244AbUJWQcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 12:32:52 -0400
Date: Sat, 23 Oct 2004 18:32:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI aic7xxx: kill kernel 2.2 #ifdef's
Message-ID: <20041023163219.GF5110@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below kills kernel 2.2 #ifdef's from the SCSI aic7xxx driver.


diffstat output:
 drivers/scsi/aic7xxx/aic7770_osm.c     |   12 ---
 drivers/scsi/aic7xxx/aic7xxx_osm.h     |    2 
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c |   91 -------------------------
 drivers/scsi/aic7xxx/aic7xxx_pci.c     |    4 -
 4 files changed, 2 insertions(+), 107 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-mm1-full/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c.old	2004-10-23 18:16:44.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2004-10-23 18:23:01.000000000 +0200
@@ -42,12 +42,6 @@
 #include "aic7xxx_osm.h"
 #include "aic7xxx_pci.h"
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-struct pci_device_id
-{
-};
-#endif
-
 static int	ahc_linux_pci_dev_probe(struct pci_dev *pdev,
 					const struct pci_device_id *ent);
 static int	ahc_linux_pci_reserve_io_region(struct ahc_softc *ahc,
@@ -55,7 +49,6 @@
 static int	ahc_linux_pci_reserve_mem_region(struct ahc_softc *ahc,
 						 u_long *bus_addr,
 						 uint8_t __iomem **maddr);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 static void	ahc_linux_pci_dev_remove(struct pci_dev *pdev);
 
 /* Define the macro locally since it's different for different class of chips.
@@ -169,7 +162,6 @@
 	} else
 		ahc_list_unlock(&l);
 }
-#endif /* !LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0) */
 
 static int
 ahc_linux_pci_dev_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -219,7 +211,6 @@
 	ahc = ahc_alloc(NULL, name);
 	if (ahc == NULL)
 		return (-ENOMEM);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	if (pci_enable_device(pdev)) {
 		ahc_free(ahc);
 		return (-ENODEV);
@@ -239,14 +230,12 @@
 		}
 		ahc->platform_data->hw_dma_mask = 0xFFFFFFFF;
 	}
-#endif
 	ahc->dev_softc = pci;
 	error = ahc_pci_config(ahc, entry);
 	if (error != 0) {
 		ahc_free(ahc);
 		return (-error);
 	}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	pci_set_drvdata(pdev, ahc);
 	if (aic7xxx_detect_complete) {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
@@ -257,39 +246,14 @@
 		return (-ENODEV);
 #endif
 	}
-#endif
 	return (0);
 }
 
 int
 ahc_linux_pci_init(void)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	/* Translate error or zero return into zero or one */
 	return pci_module_init(&aic7xxx_pci_driver) ? 0 : 1;
-#else
-	struct pci_dev *pdev;
-	u_int class;
-	int found;
-
-	/* If we don't have a PCI bus, we can't find any adapters. */
-	if (pci_present() == 0)
-		return (0);
-
-	found = 0;
-	pdev = NULL;
-	class = PCI_CLASS_STORAGE_SCSI << 8;
-	while ((pdev = pci_find_class(class, pdev)) != NULL) {
-		ahc_dev_softc_t pci;
-		int error;
-
-		pci = pdev;
-		error = ahc_linux_pci_dev_probe(pdev, /*pci_devid*/NULL);
-		if (error == 0)
-			found++;
-	}
-	return (found);
-#endif
 }
 
 void
@@ -304,22 +268,11 @@
 	if (aic7xxx_allow_memio == 0)
 		return (ENOMEM);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,0)
 	*base = pci_resource_start(ahc->dev_softc, 0);
-#else
-	*base = ahc_pci_read_config(ahc->dev_softc, PCIR_MAPS, 4);
-	*base &= PCI_BASE_ADDRESS_IO_MASK;
-#endif
 	if (*base == 0)
 		return (ENOMEM);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-	if (check_region(*base, 256) != 0)
-		return (ENOMEM);
-	request_region(*base, 256, "aic7xxx");
-#else
 	if (request_region(*base, 256, "aic7xxx") == 0)
 		return (ENOMEM);
-#endif
 	return (0);
 }
 
@@ -335,17 +288,13 @@
 	start = pci_resource_start(ahc->dev_softc, 1);
 	if (start != 0) {
 		*bus_addr = start;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		if (request_mem_region(start, 0x1000, "aic7xxx") == 0)
 			error = ENOMEM;
-#endif
 		if (error == 0) {
 			*maddr = ioremap_nocache(start, 256);
 			if (*maddr == NULL) {
 				error = ENOMEM;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 				release_mem_region(start, 0x1000);
-#endif
 			}
 		}
 	} else
@@ -388,10 +337,8 @@
 			       ahc_get_pci_slot(ahc->dev_softc),
 			       ahc_get_pci_function(ahc->dev_softc));
 			iounmap(maddr);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 			release_mem_region(ahc->platform_data->mem_busaddr,
 					   0x1000);
-#endif
 			ahc->bsh.maddr = NULL;
 			maddr = NULL;
 		} else
@@ -441,41 +388,3 @@
 	return (-error);
 }
 
-void
-ahc_power_state_change(struct ahc_softc *ahc, ahc_power_state new_state)
-{
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-	pci_set_power_state(ahc->dev_softc, new_state);
-#else
-	uint32_t cap;
-	u_int cap_offset;
-
-	/*
-	 * Traverse the capability list looking for
-	 * the power management capability.
-	 */
-	cap = 0;
-	cap_offset = ahc_pci_read_config(ahc->dev_softc,
-					 PCIR_CAP_PTR, /*bytes*/1);
-	while (cap_offset != 0) {
-
-		cap = ahc_pci_read_config(ahc->dev_softc,
-					  cap_offset, /*bytes*/4);
-		if ((cap & 0xFF) == 1
-		 && ((cap >> 16) & 0x3) > 0) {
-			uint32_t pm_control;
-
-			pm_control = ahc_pci_read_config(ahc->dev_softc,
-							 cap_offset + 4,
-							 /*bytes*/4);
-			pm_control &= ~0x3;
-			pm_control |= new_state;
-			ahc_pci_write_config(ahc->dev_softc,
-					     cap_offset + 4,
-					     pm_control, /*bytes*/2);
-			break;
-		}
-		cap_offset = (cap >> 8) & 0xFF;
-	}
-#endif 
-}
--- linux-2.6.9-mm1-full/drivers/scsi/aic7xxx/aic7xxx_osm.h.old	2004-10-23 18:19:48.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/scsi/aic7xxx/aic7xxx_osm.h	2004-10-23 18:20:20.000000000 +0200
@@ -831,8 +831,6 @@
 
 /******************************* PCI Routines *********************************/
 #ifdef CONFIG_PCI
-void			 ahc_power_state_change(struct ahc_softc *ahc,
-						ahc_power_state new_state);
 int			 ahc_linux_pci_init(void);
 void			 ahc_linux_pci_exit(void);
 int			 ahc_pci_map_registers(struct ahc_softc *ahc);
--- linux-2.6.9-mm1-full/drivers/scsi/aic7xxx/aic7770_osm.c.old	2004-10-23 18:24:17.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/scsi/aic7xxx/aic7770_osm.c	2004-10-23 18:24:48.000000000 +0200
@@ -125,14 +125,8 @@
 		uint32_t eisa_id;
 		size_t	 id_size;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-		if (check_region(eisaBase, AHC_EISA_IOSIZE) != 0)
-			continue;
-		request_region(eisaBase, AHC_EISA_IOSIZE, "aic7xxx");
-#else
 		if (request_region(eisaBase, AHC_EISA_IOSIZE, "aic7xxx") == 0)
 			continue;
-#endif
 
 		eisa_id = 0;
 		id_size = sizeof(eisa_id);
@@ -207,14 +201,8 @@
 	/*
 	 * Lock out other contenders for our i/o space.
 	 */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-	if (check_region(port, AHC_EISA_IOSIZE) != 0)
-		return (ENOMEM);
-	request_region(port, AHC_EISA_IOSIZE, "aic7xxx");
-#else
 	if (request_region(port, AHC_EISA_IOSIZE, "aic7xxx") == 0)
 		return (ENOMEM);
-#endif
 	ahc->tag = BUS_SPACE_PIO;
 	ahc->bsh.ioport = port;
 	return (0);
--- linux-2.6.9-mm1-full/drivers/scsi/aic7xxx/aic7xxx_pci.c.old	2004-10-23 18:20:38.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/scsi/aic7xxx/aic7xxx_pci.c	2004-10-23 18:22:15.000000000 +0200
@@ -721,7 +721,7 @@
 	ahc->chip |= AHC_PCI;
 	ahc->description = entry->name;
 
-	ahc_power_state_change(ahc, AHC_POWER_STATE_D0);
+	pci_set_power_state(ahc->dev_softc, AHC_POWER_STATE_D0);
 
 	error = ahc_pci_map_registers(ahc);
 	if (error != 0)
@@ -2016,7 +2016,7 @@
 ahc_pci_resume(struct ahc_softc *ahc)
 {
 
-	ahc_power_state_change(ahc, AHC_POWER_STATE_D0);
+	pci_set_power_state(ahc->dev_softc, AHC_POWER_STATE_D0);
 
 	/*
 	 * We assume that the OS has restored our register

