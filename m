Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263875AbTCUTg2>; Fri, 21 Mar 2003 14:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263872AbTCUTfo>; Fri, 21 Mar 2003 14:35:44 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:64900
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263838AbTCUTeh>; Fri, 21 Mar 2003 14:34:37 -0500
Date: Fri, 21 Mar 2003 20:49:53 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212049.h2LKnrsC026533@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix more proc and other oddments
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/pci/cs5520.c linux-2.5.65-ac2/drivers/ide/pci/cs5520.c
--- linux-2.5.65/drivers/ide/pci/cs5520.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/pci/cs5520.c	2003-03-20 18:18:57.000000000 +0000
@@ -65,6 +65,7 @@
 {
 	char *p = buffer;
 	unsigned long bmiba = pci_resource_start(bmide_dev, 2);
+	int len;
 	u8 c0 = 0, c1 = 0;
 	u16 reg16;
 	u32 reg32;
@@ -94,7 +95,10 @@
 	pci_read_config_dword(bmide_dev, 0x68, &reg32);
 	p += sprintf(p, "16bit Secondary: %08x\n", reg32);
 	
-	return p-buffer;
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 
 #endif
@@ -259,9 +263,9 @@
 {
 	ata_index_t index;
 	ide_pci_device_t *d = &cyrix_chipsets[id->driver_data];
-	
-	ide_setup_pci_noise(dev, d);	
-	
+
+	ide_setup_pci_noise(dev, d);
+
 	/* We must not grab the entire device, it has 'ISA' space in its
 	   BARS too and we will freak out other bits of the kernel */
 	if(pci_enable_device_bars(dev, 1<<2))
@@ -271,15 +275,15 @@
 	}
 	pci_set_master(dev);
 	pci_set_dma_mask(dev, 0xFFFFFFFF);
-	init_chipset_cs5520(dev, d->name);	
-	
+	init_chipset_cs5520(dev, d->name);
+
 	index.all = 0xf0f0;
 
 	/*
 	 *	Now the chipset is configured we can let the core
 	 *	do all the device setup for us
 	 */
-	 	
+
 	ide_pci_setup_ports(dev, d, 1, 14, &index);
 
 	printk("Index.b %d %d\n", index.b.low, index.b.high);
@@ -288,7 +292,7 @@
 		probe_hwif_init(&ide_hwifs[index.b.low]);
 	if((index.b.high & 0xf0) != 0xf0)
 		probe_hwif_init(&ide_hwifs[index.b.high]);
-		
+	MOD_INC_USE_COUNT;
 	return 0;
 }
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/pci/hpt34x.c linux-2.5.65-ac2/drivers/ide/pci/hpt34x.c
--- linux-2.5.65/drivers/ide/pci/hpt34x.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/pci/hpt34x.c	2003-03-06 23:37:34.000000000 +0000
@@ -58,7 +58,7 @@
 static int hpt34x_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p = buffer;
-	int i;
+	int i, len;
 
 	p += sprintf(p, "\n                             "
 			"HPT34X Chipset.\n");
@@ -96,7 +96,11 @@
 	}
 	p += sprintf(p, "\n");
 
-	return p-buffer;	/* => must be less than 4k! */
+	/* p - buffer must be less than 4k! */
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 #endif  /* defined(DISPLAY_HPT34X_TIMINGS) && defined(CONFIG_PROC_FS) */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/pci/hpt366.c linux-2.5.65-ac2/drivers/ide/pci/hpt366.c
--- linux-2.5.65/drivers/ide/pci/hpt366.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/pci/hpt366.c	2003-03-06 23:37:24.000000000 +0000
@@ -85,7 +85,7 @@
 	char *chipset_nums[] = {"366", "366",  "368",
 				"370", "370A", "372",
 				"302", "371",  "374" };
-	int i;
+	int i, len;
 
 	p += sprintf(p, "\n                             "
 		"HighPoint HPT366/368/370/372/374\n");
@@ -153,8 +153,12 @@
 		}
 	}
 	p += sprintf(p, "\n");
+
+	/* p - buffer must be less than 4k! */
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
 	
-	return p-buffer;/* => must be less than 4k! */
+	return len > count ? count : len;
 }
 #endif  /* defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS) */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/pci/pdc202xx_new.c linux-2.5.65-ac2/drivers/ide/pci/pdc202xx_new.c
--- linux-2.5.65/drivers/ide/pci/pdc202xx_new.c	2003-03-06 17:04:26.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/pci/pdc202xx_new.c	2003-03-06 23:37:05.000000000 +0000
@@ -77,13 +77,17 @@
 static int pdcnew_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p = buffer;
-	int i;
+	int i, len;
 
 	for (i = 0; i < n_pdc202_devs; i++) {
 		struct pci_dev *dev	= pdc202_devs[i];
 		p = pdcnew_info(buffer, dev);
 	}
-	return p-buffer;	/* => must be less than 4k! */
+	/* p - buffer must be less than 4k! */
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 #endif  /* defined(DISPLAY_PDC202XX_TIMINGS) && defined(CONFIG_PROC_FS) */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/pci/pdc202xx_old.c linux-2.5.65-ac2/drivers/ide/pci/pdc202xx_old.c
--- linux-2.5.65/drivers/ide/pci/pdc202xx_old.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/pci/pdc202xx_old.c	2003-03-06 23:36:50.000000000 +0000
@@ -177,13 +177,17 @@
 static int pdc202xx_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p = buffer;
-	int i;
+	int i, len;
 
 	for (i = 0; i < n_pdc202_devs; i++) {
 		struct pci_dev *dev	= pdc202_devs[i];
 		p = pdc202xx_info(buffer, dev);
 	}
-	return p-buffer;	/* => must be less than 4k! */
+	/* p - buffer must be less than 4k! */
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 #endif  /* defined(DISPLAY_PDC202XX_TIMINGS) && defined(CONFIG_PROC_FS) */
 
