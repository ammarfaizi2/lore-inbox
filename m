Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbVCQAy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbVCQAy5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbVCQAxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:53:05 -0500
Received: from mail0.lsil.com ([147.145.40.20]:31407 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262930AbVCQAj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 19:39:29 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570366276A@exa-atlanta>
From: "Ju, Seokmann" <sju@lsil.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Cc: "Ju, Seokmann" <sju@lsil.com>
Subject: [ANNOUNCE][PATCH] drivers/scsi/megaraid/megaraid_{mm,mbox}
Date: Wed, 16 Mar 2005 19:39:19 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a patch for megaraid_mm/megaraid_mbox driver which makes it
2.20.4.6.
Following is brief on the changes:
1. Added compat_ioctl
2. Reordered inputs on memset
3. Convert pci_module_iit to pci_register_driver 
4. Added DMA_{32,64}BIT_MASK 5. Modified PCI PnP ID table

Signed-off-by: Seokmann Ju <sju@lsil.com>

---
diff -Naur old/Documentation/scsi/ChangeLog.megaraid
new/Documentation/scsi/ChangeLog.megaraid
--- old/Documentation/scsi/ChangeLog.megaraid	2005-03-16
13:34:15.839275224 -0500
+++ new/Documentation/scsi/ChangeLog.megaraid	2005-03-16
10:24:47.999449560 -0500
@@ -1,3 +1,38 @@
+Release Date	: Mon Mar 07 12:27:22 EST 2005 - Seokmann Ju <sju@lsil.com>
+Current Version	: 2.20.4.6 (scsi module), 2.20.2.6 (cmm module)
+Older Version	: 2.20.4.5 (scsi module), 2.20.2.5 (cmm module)
+
+1.	Added IOCTL backward compatibility.
+	Convert megaraid_mm driver to new compat_ioctl entry points.
+	I don't have easy access to hardware, so only compile tested.
+		- Signed-off-by:Andi Kleen <ak@muc.de>
+
+2.	megaraid_mbox fix: wrong order of arguments in memset()
+	That, BTW, shows why cross-builds are useful-the only indication of
+	problem had been a new warning showing up in sparse output on alpha
+	build (number of exceeding 256 got truncated).
+		- Signed-off-by: Al Viro
+		<viro@parcelfarce.linux.theplanet.co.uk>
+
+3.	Convert pci_module_init to pci_register_driver
+	Convert from pci_module_init to pci_register_driver
+	(from:http://kerneljanitors.org/TODO)
+		- Signed-off-by: Domen Puncer <domen@coderock.org>
+
+4.	Use the pre defined DMA mask constants from dma-mapping.h
+	Use the DMA_{64,32}BIT_MASK constants from dma-mapping.h when
calling
+	pci_set_dma_mask() or pci_set_consistend_dma_mask(). See
+	http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for more
+	details.
+		Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
+		Signed-off-by: Domen Puncer <domen@coderock.org>
+
+5.	Remove SSID checking for Dobson, Lindsay, and Verde based products.
+	Checking the SSVID/SSID for controllers which have Dobson, Lindsay,
+	and Verde is unnecessary because device ID has been assigned by LSI
+	and it is unique value. So, all controllers with these IOPs have to
be
+	supported by the driver regardless SSVID/SSID.
+
 Release Date	: Thu Feb 03 12:27:22 EST 2005 - Seokmann Ju <sju@lsil.com>
 Current Version	: 2.20.4.5 (scsi module), 2.20.2.5 (cmm module)
 Older Version	: 2.20.4.4 (scsi module), 2.20.2.4 (cmm module)
diff -Naur old/drivers/scsi/megaraid/mega_common.h
new/drivers/scsi/megaraid/mega_common.h
--- old/drivers/scsi/megaraid/mega_common.h	2005-03-16
10:20:16.034794472 -0500
+++ new/drivers/scsi/megaraid/mega_common.h	2005-03-16
14:11:35.110854200 -0500
@@ -27,6 +27,7 @@
 #include <linux/list.h>
 #include <linux/version.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <asm/semaphore.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
diff -Naur old/drivers/scsi/megaraid/megaraid_mbox.c
new/drivers/scsi/megaraid/megaraid_mbox.c
--- old/drivers/scsi/megaraid/megaraid_mbox.c	2005-03-16
10:20:16.043793104 -0500
+++ new/drivers/scsi/megaraid/megaraid_mbox.c	2005-03-16
14:11:35.119852832 -0500
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mbox.c
- * Version	: v2.20.4.5 (Feb 03 2005)
+ * Version	: v2.20.4.6 (Mar 07 2005)
  *
  * Authors:
  * 	Atul Mukker		<Atul.Mukker@lsil.com>
@@ -202,7 +202,7 @@
  * ### global data ###
  */
 static uint8_t megaraid_mbox_version[8] =
-	{ 0x02, 0x20, 0x04, 0x05, 2, 3, 20, 5 };
+	{ 0x02, 0x20, 0x04, 0x06, 3, 7, 20, 5 };
 
 
 /*
@@ -229,9 +229,9 @@
 	},
 	{
 		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_PERC4_QC,
-		PCI_VENDOR_ID_DELL,
-		PCI_SUBSYS_ID_PERC4_QC,
+		PCI_DEVICE_ID_VERDE,
+		PCI_ANY_ID,
+		PCI_ANY_ID,
 	},
 	{
 		PCI_VENDOR_ID_DELL,
@@ -271,15 +271,9 @@
 	},
 	{
 		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_PERC4E_DC_320_2E,
-		PCI_VENDOR_ID_DELL,
-		PCI_SUBSYS_ID_PERC4E_DC_320_2E,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_PERC4E_SC_320_1E,
-		PCI_VENDOR_ID_DELL,
-		PCI_SUBSYS_ID_PERC4E_SC_320_1E,
+		PCI_DEVICE_ID_DOBSON,
+		PCI_ANY_ID,
+		PCI_ANY_ID,
 	},
 	{
 		PCI_VENDOR_ID_AMI,
@@ -331,36 +325,6 @@
 	},
 	{
 		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_SCSI_320_0x,
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_SUBSYS_ID_MEGARAID_SCSI_320_0x,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_SCSI_320_2x,
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_SUBSYS_ID_MEGARAID_SCSI_320_2x,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_SCSI_320_4x,
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_SUBSYS_ID_MEGARAID_SCSI_320_4x,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_SCSI_320_1E,
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_SUBSYS_ID_MEGARAID_SCSI_320_1E,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_SCSI_320_2E,
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_SUBSYS_ID_MEGARAID_SCSI_320_2E,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
 		PCI_DEVICE_ID_MEGARAID_I4_133_RAID,
 		PCI_VENDOR_ID_LSI_LOGIC,
 		PCI_SUBSYS_ID_MEGARAID_I4_133_RAID,
@@ -379,21 +343,9 @@
 	},
 	{
 		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_SATA_300_4x,
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_SUBSYS_ID_MEGARAID_SATA_300_4x,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_SATA_300_8x,
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_SUBSYS_ID_MEGARAID_SATA_300_8x,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_INTEL_RAID_SRCU42X,
-		PCI_VENDOR_ID_INTEL,
-		PCI_SUBSYS_ID_INTEL_RAID_SRCU42X,
+		PCI_DEVICE_ID_LINDSAY,
+		PCI_ANY_ID,
+		PCI_ANY_ID,
 	},
 	{
 		PCI_VENDOR_ID_LSI_LOGIC,
@@ -403,58 +355,10 @@
 	},
 	{
 		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_INTEL_RAID_SRCU42E,
-		PCI_VENDOR_ID_INTEL,
-		PCI_SUBSYS_ID_INTEL_RAID_SRCU42E,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_INTEL_RAID_SRCZCRX,
-		PCI_VENDOR_ID_INTEL,
-		PCI_SUBSYS_ID_INTEL_RAID_SRCZCRX,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_INTEL_RAID_SRCS28X,
-		PCI_VENDOR_ID_INTEL,
-		PCI_SUBSYS_ID_INTEL_RAID_SRCS28X,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_INTEL_RAID_SROMBU42E_ALIEF,
-		PCI_VENDOR_ID_INTEL,
-		PCI_SUBSYS_ID_INTEL_RAID_SROMBU42E_ALIEF,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_INTEL_RAID_SROMBU42E_HARWICH,
-		PCI_VENDOR_ID_INTEL,
-		PCI_SUBSYS_ID_INTEL_RAID_SROMBU42E_HARWICH,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
 		PCI_DEVICE_ID_INTEL_RAID_SRCU41L_LAKE_SHETEK,
 		PCI_VENDOR_ID_INTEL,
 		PCI_SUBSYS_ID_INTEL_RAID_SRCU41L_LAKE_SHETEK,
 	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_FSC_MEGARAID_PCI_EXPRESS_ROMB,
-		PCI_SUBSYS_ID_FSC,
-		PCI_SUBSYS_ID_FSC_MEGARAID_PCI_EXPRESS_ROMB,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_ACER_ROMB_2E,
-		PCI_VENDOR_ID_AI,
-		PCI_SUBSYS_ID_MEGARAID_ACER_ROMB_2E,
-	},
-	{
-		PCI_VENDOR_ID_LSI_LOGIC,
-		PCI_DEVICE_ID_MEGARAID_NEC_ROMB_2E,
-		PCI_VENDOR_ID_NEC,
-		PCI_SUBSYS_ID_MEGARAID_NEC_ROMB_2E,
-	},
 	{0}	/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(pci, pci_id_table_g);
@@ -539,7 +443,8 @@
 
 
 	// register as a PCI hot-plug driver module
-	if ((rval = pci_module_init(&megaraid_pci_driver_g))) {
+	rval = pci_register_driver(&megaraid_pci_driver_g);
+	if (rval < 0) {
 		con_log(CL_ANN, (KERN_WARNING
 			"megaraid: could not register hotplug support.\n"));
 	}
@@ -619,7 +524,7 @@
 
 	// Setup the default DMA mask. This would be changed later on
 	// depending on hardware capabilities
-	if (pci_set_dma_mask(adapter->pdev, 0xFFFFFFFF) != 0) {
+	if (pci_set_dma_mask(adapter->pdev, DMA_32BIT_MASK) != 0) {
 
 		con_log(CL_ANN, (KERN_WARNING
 			"megaraid: pci_set_dma_mask failed:%d\n",
__LINE__));
@@ -1031,7 +936,7 @@
 
 	// Set the DMA mask to 64-bit. All supported controllers as capable
of
 	// DMA in this range
-	if (pci_set_dma_mask(adapter->pdev, 0xFFFFFFFFFFFFFFFFULL) != 0) {
+	if (pci_set_dma_mask(adapter->pdev, DMA_64BIT_MASK) != 0) {
 
 		con_log(CL_ANN, (KERN_WARNING
 			"megaraid: could not set DMA mask for 64-bit.\n"));
@@ -4100,9 +4005,9 @@
 	mbox64	= raid_dev->sysfs_mbox64;
 	ldmap	= raid_dev->sysfs_buffer;
 
-	memset(uioc, sizeof(uioc_t), 0);
-	memset(mbox64, sizeof(mbox64_t), 0);
-	memset(ldmap, sizeof(raid_dev->curr_ldmap), 0);
+	memset(uioc, 0, sizeof(uioc_t));
+	memset(mbox64, 0, sizeof(mbox64_t));
+	memset(ldmap, 0, sizeof(raid_dev->curr_ldmap));
 
 	mbox		= &mbox64->mbox32;
 	raw_mbox	= (char *)mbox;
diff -Naur old/drivers/scsi/megaraid/megaraid_mbox.h
new/drivers/scsi/megaraid/megaraid_mbox.h
--- old/drivers/scsi/megaraid/megaraid_mbox.h	2005-03-16
10:20:16.044792952 -0500
+++ new/drivers/scsi/megaraid/megaraid_mbox.h	2005-03-16
14:11:35.120852680 -0500
@@ -21,8 +21,8 @@
 #include "megaraid_ioctl.h"
 
 
-#define MEGARAID_VERSION	"2.20.4.5"
-#define MEGARAID_EXT_VERSION	"(Release Date: Thu Feb 03 12:27:22 EST
2005)"
+#define MEGARAID_VERSION	"2.20.4.6"
+#define MEGARAID_EXT_VERSION	"(Release Date: Mon Mar 07 12:27:22 EST
2005)"
 
 
 /*
@@ -37,8 +37,7 @@
 #define PCI_DEVICE_ID_PERC4_DC				0x1960
 #define PCI_SUBSYS_ID_PERC4_DC				0x0518
 
-#define PCI_DEVICE_ID_PERC4_QC				0x0407
-#define PCI_SUBSYS_ID_PERC4_QC				0x0531
+#define PCI_DEVICE_ID_VERDE				0x0407
 
 #define PCI_DEVICE_ID_PERC4_DI_EVERGLADES		0x000F
 #define PCI_SUBSYS_ID_PERC4_DI_EVERGLADES		0x014A
@@ -58,11 +57,7 @@
 #define PCI_DEVICE_ID_PERC4E_DI_GUADALUPE		0x0013
 #define PCI_SUBSYS_ID_PERC4E_DI_GUADALUPE		0x0170
 
-#define PCI_DEVICE_ID_PERC4E_DC_320_2E			0x0408
-#define PCI_SUBSYS_ID_PERC4E_DC_320_2E			0x0002
-
-#define PCI_DEVICE_ID_PERC4E_SC_320_1E			0x0408
-#define PCI_SUBSYS_ID_PERC4E_SC_320_1E			0x0001
+#define PCI_DEVICE_ID_DOBSON				0x0408
 
 #define PCI_DEVICE_ID_MEGARAID_SCSI_320_0		0x1960
 #define PCI_SUBSYS_ID_MEGARAID_SCSI_320_0		0xA520
@@ -73,21 +68,6 @@
 #define PCI_DEVICE_ID_MEGARAID_SCSI_320_2		0x1960
 #define PCI_SUBSYS_ID_MEGARAID_SCSI_320_2		0x0518
 
-#define PCI_DEVICE_ID_MEGARAID_SCSI_320_0x		0x0407
-#define PCI_SUBSYS_ID_MEGARAID_SCSI_320_0x		0x0530
-
-#define PCI_DEVICE_ID_MEGARAID_SCSI_320_2x		0x0407
-#define PCI_SUBSYS_ID_MEGARAID_SCSI_320_2x		0x0532
-
-#define PCI_DEVICE_ID_MEGARAID_SCSI_320_4x		0x0407
-#define PCI_SUBSYS_ID_MEGARAID_SCSI_320_4x		0x0531
-
-#define PCI_DEVICE_ID_MEGARAID_SCSI_320_1E		0x0408
-#define PCI_SUBSYS_ID_MEGARAID_SCSI_320_1E		0x0001
-
-#define PCI_DEVICE_ID_MEGARAID_SCSI_320_2E		0x0408
-#define PCI_SUBSYS_ID_MEGARAID_SCSI_320_2E		0x0002
-
 #define PCI_DEVICE_ID_MEGARAID_I4_133_RAID		0x1960
 #define PCI_SUBSYS_ID_MEGARAID_I4_133_RAID		0x0522
 
@@ -97,52 +77,18 @@
 #define PCI_DEVICE_ID_MEGARAID_SATA_150_6		0x1960
 #define PCI_SUBSYS_ID_MEGARAID_SATA_150_6		0x0523
 
-#define PCI_DEVICE_ID_MEGARAID_SATA_300_4x		0x0409
-#define PCI_SUBSYS_ID_MEGARAID_SATA_300_4x		0x3004
-
-#define PCI_DEVICE_ID_MEGARAID_SATA_300_8x		0x0409
-#define PCI_SUBSYS_ID_MEGARAID_SATA_300_8x		0x3008
-
-#define PCI_DEVICE_ID_INTEL_RAID_SRCU42X		0x0407
-#define PCI_SUBSYS_ID_INTEL_RAID_SRCU42X		0x0532
+#define PCI_DEVICE_ID_LINDSAY				0x0409
 
 #define PCI_DEVICE_ID_INTEL_RAID_SRCS16			0x1960
 #define PCI_SUBSYS_ID_INTEL_RAID_SRCS16			0x0523
 
-#define PCI_DEVICE_ID_INTEL_RAID_SRCU42E		0x0408
-#define PCI_SUBSYS_ID_INTEL_RAID_SRCU42E		0x0002
-
-#define PCI_DEVICE_ID_INTEL_RAID_SRCZCRX		0x0407
-#define PCI_SUBSYS_ID_INTEL_RAID_SRCZCRX		0x0530
-
-#define PCI_DEVICE_ID_INTEL_RAID_SRCS28X		0x0409
-#define PCI_SUBSYS_ID_INTEL_RAID_SRCS28X		0x3008
-
-#define PCI_DEVICE_ID_INTEL_RAID_SROMBU42E_ALIEF	0x0408
-#define PCI_SUBSYS_ID_INTEL_RAID_SROMBU42E_ALIEF	0x3431
-
-#define PCI_DEVICE_ID_INTEL_RAID_SROMBU42E_HARWICH	0x0408
-#define PCI_SUBSYS_ID_INTEL_RAID_SROMBU42E_HARWICH	0x3499
-
 #define PCI_DEVICE_ID_INTEL_RAID_SRCU41L_LAKE_SHETEK	0x1960
 #define PCI_SUBSYS_ID_INTEL_RAID_SRCU41L_LAKE_SHETEK	0x0520
 
-#define PCI_DEVICE_ID_FSC_MEGARAID_PCI_EXPRESS_ROMB	0x0408
-#define PCI_SUBSYS_ID_FSC_MEGARAID_PCI_EXPRESS_ROMB	0x1065
-
-#define PCI_DEVICE_ID_MEGARAID_ACER_ROMB_2E		0x0408
-#define PCI_SUBSYS_ID_MEGARAID_ACER_ROMB_2E		0x004D
-
 #define PCI_SUBSYS_ID_PERC3_QC				0x0471
 #define PCI_SUBSYS_ID_PERC3_DC				0x0493
 #define PCI_SUBSYS_ID_PERC3_SC				0x0475
 
-#define PCI_DEVICE_ID_MEGARAID_NEC_ROMB_2E		0x0408
-#define PCI_SUBSYS_ID_MEGARAID_NEC_ROMB_2E		0x8287
-
-#ifndef PCI_SUBSYS_ID_FSC
-#define PCI_SUBSYS_ID_FSC				0x1734
-#endif
 
 #define MBOX_MAX_SCSI_CMDS	128	// number of cmds reserved for
kernel
 #define MBOX_MAX_USER_CMDS	32	// number of cmds for applications
diff -Naur old/drivers/scsi/megaraid/megaraid_mm.c
new/drivers/scsi/megaraid/megaraid_mm.c
--- old/drivers/scsi/megaraid/megaraid_mm.c	2005-03-16
10:20:16.047792496 -0500
+++ new/drivers/scsi/megaraid/megaraid_mm.c	2005-03-16
14:11:35.122852376 -0500
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mm.c
- * Version	: v2.20.2.5 (Jan 21 2005)
+ * Version	: v2.20.2.6 (Mar 7 2005)
  *
  * Common management module
  */
@@ -43,8 +43,7 @@
 static void mraid_mm_teardown_dma_pools(mraid_mmadp_t *);
 
 #ifdef CONFIG_COMPAT
-static int mraid_mm_compat_ioctl(unsigned int, unsigned int, unsigned long,
-		struct file *);
+static long mraid_mm_compat_ioctl(struct file *, unsigned int, unsigned
long);
 #endif
 
 MODULE_AUTHOR("LSI Logic Corporation");
@@ -61,7 +60,7 @@
 EXPORT_SYMBOL(mraid_mm_adapter_app_handle);
 
 static int majorno;
-static uint32_t drvr_ver	= 0x02200201;
+static uint32_t drvr_ver	= 0x02200206;
 
 static int adapters_count_g;
 static struct list_head adapters_list_g;
@@ -69,9 +68,12 @@
 static wait_queue_head_t wait_q;
 
 static struct file_operations lsi_fops = {
-	.open	= mraid_mm_open,
-	.ioctl	= mraid_mm_ioctl,
-	.owner	= THIS_MODULE,
+	.open		= mraid_mm_open,
+	.ioctl		= mraid_mm_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= mraid_mm_compat_ioctl, 
+#endif
+	.owner		= THIS_MODULE,
 };
 
 /**
@@ -1215,8 +1217,6 @@
 
 	INIT_LIST_HEAD(&adapters_list_g);
 
-	register_ioctl32_conversion(MEGAIOCCMD, mraid_mm_compat_ioctl);
-
 	return 0;
 }
 
@@ -1225,13 +1225,14 @@
  * mraid_mm_compat_ioctl	: 32bit to 64bit ioctl conversion routine
  */
 #ifdef CONFIG_COMPAT
-static int
-mraid_mm_compat_ioctl(unsigned int fd, unsigned int cmd,
-			unsigned long arg, struct file *filep)
+static long
+mraid_mm_compat_ioctl(struct file *filep, unsigned int cmd, unsigned long
arg)
 {
-	struct inode *inode = filep->f_dentry->d_inode;
+	int err;
+
+	err = mraid_mm_ioctl(NULL, filep, cmd, arg);
 
-	return mraid_mm_ioctl(inode, filep, cmd, arg);
+	return err;
 }
 #endif
 
@@ -1244,7 +1245,6 @@
 	con_log(CL_DLEVEL1 , ("exiting common mod\n"));
 
 	unregister_chrdev(majorno, "megadev");
-	unregister_ioctl32_conversion(MEGAIOCCMD);
 }
 
 module_init(mraid_mm_init);
diff -Naur old/drivers/scsi/megaraid/megaraid_mm.h
new/drivers/scsi/megaraid/megaraid_mm.h
--- old/drivers/scsi/megaraid/megaraid_mm.h	2005-03-16
10:20:16.047792496 -0500
+++ new/drivers/scsi/megaraid/megaraid_mm.h	2005-03-16
14:11:35.122852376 -0500
@@ -29,9 +29,9 @@
 #include "megaraid_ioctl.h"
 
 
-#define LSI_COMMON_MOD_VERSION	"2.20.2.5"
+#define LSI_COMMON_MOD_VERSION	"2.20.2.6"
 #define LSI_COMMON_MOD_EXT_VERSION	\
-		"(Release Date: Fri Jan 21 00:01:03 EST 2005)"
+		"(Release Date: Mon Mar 7 00:01:03 EST 2005)"
 
 
 #define LSI_DBGLVL			dbglevel
---
