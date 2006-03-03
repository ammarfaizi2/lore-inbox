Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752128AbWCCBtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbWCCBtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbWCCBsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:48:51 -0500
Received: from smtp-2.llnl.gov ([128.115.3.82]:25325 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S1752125AbWCCBsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:48:11 -0500
From: Dave Peterson <dsp@llnl.gov>
To: alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: [PATCH 2/15] EDAC: printk() cleanup
Date: Thu, 2 Mar 2006 17:47:49 -0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021747.49762.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the following idea:

On Monday 30 January 2006 19:22, Eric W. Biederman wrote:
> One piece missing from this conversation is the issue that we need errors
> in a uniform format.  That is why edac_mc has helper functions.
>
> However there will always be errors that don't fit any particular model.
> Could we add a edac_printk(dev, );  That is similar to dev_printk but
> prints out an EDAC header and the device on which the error was found?
> Letting the rest of the string be user specified.
>
> For actual control that interface may be to blunt, but at least for people
> looking in the logs it allows all of the errors to be detected and
> harvested.

Signed-Off-By: David S. Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>
---

Index: linux-2.6.16-rc5-edac/drivers/edac/amd76x_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/amd76x_edac.c	2006-02-27 15:13:54.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/amd76x_edac.c	2006-02-27 16:58:41.000000000 -0800
@@ -25,6 +25,14 @@
 #include "edac_mc.h"
 
 
+#define amd76x_printk(level, fmt, arg...) \
+    edac_printk(level, "amd76x", fmt, ##arg)
+
+
+#define amd76x_mc_printk(mci, level, fmt, arg...) \
+    edac_mc_chipset_printk(mci, level, "amd76x", fmt, ##arg)
+
+
 #define AMD76X_NR_CSROWS 8
 #define AMD76X_NR_CHANS  1
 #define AMD76X_NR_DIMMS  4
@@ -174,7 +182,7 @@ static int amd76x_process_error_info (st
 static void amd76x_check(struct mem_ctl_info *mci)
 {
 	struct amd76x_error_info info;
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 	amd76x_get_error_info(mci, &info);
 	amd76x_process_error_info(mci, &info, 1);
 }
@@ -204,7 +212,7 @@ static int amd76x_probe1(struct pci_dev 
 	u32 ems;
 	u32 ems_mode;
 
-	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 	pci_read_config_dword(pdev, AMD76X_ECC_MODE_STATUS, &ems);
 	ems_mode = (ems >> 10) & 0x3;
@@ -216,7 +224,7 @@ static int amd76x_probe1(struct pci_dev 
 		goto fail;
 	}
 
-	debugf0("MC: " __FILE__ ": %s(): mci = %p\n", __func__, mci);
+	debugf0("%s(): mci = %p\n", __func__, mci);
 
 	mci->pdev = pci_dev_get(pdev);
 	mci->mtype_cap = MEM_FLAG_RDDR;
@@ -267,13 +275,12 @@ static int amd76x_probe1(struct pci_dev 
 			 (u32) (0x3 << 8));
 
 	if (edac_mc_add_mc(mci)) {
-		debugf3("MC: " __FILE__
-			": %s(): failed edac_mc_add_mc()\n", __func__);
+		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
 		goto fail;
 	}
 
 	/* get this far and it's successful */
-	debugf3("MC: " __FILE__ ": %s(): success\n", __func__);
+	debugf3("%s(): success\n", __func__);
 	return 0;
 
 fail:
@@ -289,7 +296,7 @@ fail:
 static int __devinit amd76x_init_one(struct pci_dev *pdev,
 				     const struct pci_device_id *ent)
 {
-	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 	/* don't need to call pci_device_enable() */
 	return amd76x_probe1(pdev, ent->driver_data);
@@ -309,7 +316,7 @@ static void __devexit amd76x_remove_one(
 {
 	struct mem_ctl_info *mci;
 
-	debugf0(__FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 	if ((mci = edac_mc_find_mci_by_pdev(pdev)) == NULL)
 		return;
Index: linux-2.6.16-rc5-edac/drivers/edac/e752x_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/e752x_edac.c	2006-02-27 15:13:54.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/e752x_edac.c	2006-02-27 16:58:41.000000000 -0800
@@ -30,6 +30,14 @@
 #include "edac_mc.h"
 
 
+#define e752x_printk(level, fmt, arg...) \
+    edac_printk(level, "e752x", fmt, ##arg)
+
+
+#define e752x_mc_printk(mci, level, fmt, arg...) \
+    edac_mc_chipset_printk(mci, level, "e752x", fmt, ##arg)
+
+
 #ifndef PCI_DEVICE_ID_INTEL_7520_0
 #define PCI_DEVICE_ID_INTEL_7520_0      0x3590
 #endif				/* PCI_DEVICE_ID_INTEL_7520_0      */
@@ -215,7 +223,7 @@ static unsigned long ctl_page_to_phys(st
 	u32 remap;
 	struct e752x_pvt *pvt = (struct e752x_pvt *) mci->pvt_info;
 
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 
 	if (page < pvt->tolm)
 		return page;
@@ -224,7 +232,7 @@ static unsigned long ctl_page_to_phys(st
 	remap = (page - pvt->tolm) + pvt->remapbase;
 	if (remap < pvt->remaplimit)
 		return remap;
-	printk(KERN_ERR "Invalid page %lx - out of range\n", page);
+	e752x_printk(KERN_ERR, "Invalid page %lx - out of range\n", page);
 	return pvt->tolm - 1;
 }
 
@@ -237,7 +245,7 @@ static void do_process_ce(struct mem_ctl
 	int i;
 	struct e752x_pvt *pvt = (struct e752x_pvt *) mci->pvt_info;
 
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 
 	/* convert the addr to 4k page */
 	page = sec1_add >> (PAGE_SHIFT - 4);
@@ -246,24 +254,23 @@ static void do_process_ce(struct mem_ctl
 	if (pvt->mc_symmetric) {
 		/* chip select are bits 14 & 13 */
 		row = ((page >> 1) & 3);
-		printk(KERN_WARNING
-		       "Test row %d Table %d %d %d %d %d %d %d %d\n",
-		       row, pvt->map[0], pvt->map[1], pvt->map[2],
-		       pvt->map[3], pvt->map[4], pvt->map[5],
-		       pvt->map[6], pvt->map[7]);
+		e752x_printk(KERN_WARNING,
+			     "Test row %d Table %d %d %d %d %d %d %d %d\n",
+			     row, pvt->map[0], pvt->map[1], pvt->map[2],
+			     pvt->map[3], pvt->map[4], pvt->map[5],
+			     pvt->map[6], pvt->map[7]);
 
 		/* test for channel remapping */
 		for (i = 0; i < 8; i++) {
 			if (pvt->map[i] == row)
 				break;
 		}
-		printk(KERN_WARNING "Test computed row %d\n", i);
+		e752x_printk(KERN_WARNING, "Test computed row %d\n", i);
 		if (i < 8)
 			row = i;
 		else
-			printk(KERN_WARNING
-			       "MC%d: row %d not found in remap table\n",
-			       mci->mc_idx, row);
+			e752x_mc_printk(mci, KERN_WARNING,
+			    "row %d not found in remap table\n", row);
 	} else
 		row = edac_mc_find_csrow_by_page(mci, page);
 	/* 0 = channel A, 1 = channel B */
@@ -293,7 +300,7 @@ static void do_process_ue(struct mem_ctl
 	int row;
 	struct e752x_pvt *pvt = (struct e752x_pvt *) mci->pvt_info;
 
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 
 	if (error_one & 0x0202) {
 		error_2b = ded_add;
@@ -336,7 +343,7 @@ static inline void process_ue_no_info_wr
 	if (!handle_error)
 		return;
 
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 	edac_mc_handle_ue_no_info(mci, "e752x UE log memory write");
 }
 
@@ -352,9 +359,9 @@ static void do_process_ded_retry(struct 
 	row = pvt->mc_symmetric ?
 	    ((page >> 1) & 3) :	/* chip select are bits 14 & 13 */
 	    edac_mc_find_csrow_by_page(mci, page);
-	printk(KERN_WARNING
-	       "MC%d: CE page 0x%lx, row %d : Memory read retry\n",
-	       mci->mc_idx, (long unsigned int) page, row);
+	e752x_mc_printk(mci, KERN_WARNING,
+	    "CE page 0x%lx, row %d : Memory read retry\n",
+	    (long unsigned int) page, row);
 }
 
 static inline void process_ded_retry(struct mem_ctl_info *mci, u16 error,
@@ -372,8 +379,7 @@ static inline void process_threshold_ce(
 	*error_found = 1;
 
 	if (handle_error)
-		printk(KERN_WARNING "MC%d: Memory threshold CE\n",
-		       mci->mc_idx);
+		e752x_mc_printk(mci, KERN_WARNING, "Memory threshold CE\n");
 }
 
 static char *global_message[11] = {
@@ -391,7 +397,7 @@ static void do_global_error(int fatal, u
 
 	for (i = 0; i < 11; i++) {
 		if (errors & (1 << i))
-			printk(KERN_WARNING "%sError %s\n",
+			e752x_printk(KERN_WARNING, "%sError %s\n",
 			       fatal_message[fatal], global_message[i]);
 	}
 }
@@ -418,7 +424,7 @@ static void do_hub_error(int fatal, u8 e
 
 	for (i = 0; i < 7; i++) {
 		if (errors & (1 << i))
-			printk(KERN_WARNING "%sError %s\n",
+			e752x_printk(KERN_WARNING, "%sError %s\n",
 			       fatal_message[fatal], hub_message[i]);
 	}
 }
@@ -445,7 +451,7 @@ static void do_membuf_error(u8 errors)
 
 	for (i = 0; i < 4; i++) {
 		if (errors & (1 << i))
-			printk(KERN_WARNING "Non-Fatal Error %s\n",
+			e752x_printk(KERN_WARNING, "Non-Fatal Error %s\n",
 			       membuf_message[i]);
 	}
 }
@@ -478,7 +484,7 @@ static void do_sysbus_error(int fatal, u
 
 	for (i = 0; i < 10; i++) {
 		if (errors & (1 << i))
-			printk(KERN_WARNING "%sError System Bus %s\n",
+			e752x_printk(KERN_WARNING, "%sError System Bus %s\n",
 			       fatal_message[fatal], global_message[i]);
 	}
 }
@@ -727,7 +733,7 @@ static int e752x_process_error_info (str
 static void e752x_check(struct mem_ctl_info *mci)
 {
 	struct e752x_error_info info;
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 	e752x_get_error_info(mci, &info);
 	e752x_process_error_info(mci, &info, 1);
 }
@@ -752,7 +758,7 @@ static int e752x_probe1(struct pci_dev *
 	struct pci_dev *pres_dev;
 	struct pci_dev *dev = NULL;
 
-	debugf0("MC: " __FILE__ ": %s(): mci\n", __func__);
+	debugf0("%s(): mci\n", __func__);
 	debugf0("Starting Probe1\n");
 
 	/* enable device 0 function 1 */
@@ -776,7 +782,7 @@ static int e752x_probe1(struct pci_dev *
 		goto fail;
 	}
 
-	debugf3("MC: " __FILE__ ": %s(): init mci\n", __func__);
+	debugf3("%s(): init mci\n", __func__);
 
 	mci->mtype_cap = MEM_FLAG_RDDR;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED |
@@ -786,7 +792,7 @@ static int e752x_probe1(struct pci_dev *
 	mci->mod_ver = "$Revision: 1.5.2.11 $";
 	mci->pdev = pdev;
 
-	debugf3("MC: " __FILE__ ": %s(): init pvt\n", __func__);
+	debugf3("%s(): init pvt\n", __func__);
 	pvt = (struct e752x_pvt *) mci->pvt_info;
 	pvt->dev_info = &e752x_devs[dev_idx];
 	pvt->bridge_ck = pci_get_device(PCI_VENDOR_ID_INTEL,
@@ -796,14 +802,14 @@ static int e752x_probe1(struct pci_dev *
 		pvt->bridge_ck = pci_scan_single_device(pdev->bus,
 							PCI_DEVFN(0, 1));
 	if (pvt->bridge_ck == NULL) {
-		printk(KERN_ERR "MC: error reporting device not found:"
+		e752x_printk(KERN_ERR, "error reporting device not found:"
 		       "vendor %x device 0x%x (broken BIOS?)\n",
 		       PCI_VENDOR_ID_INTEL, e752x_devs[dev_idx].err_dev);
 		goto fail;
 	}
 	pvt->mc_symmetric = ((ddrcsr & 0x10) != 0);
 
-	debugf3("MC: " __FILE__ ": %s(): more mci init\n", __func__);
+	debugf3("%s(): more mci init\n", __func__);
 	mci->ctl_name = pvt->dev_info->ctl_name;
 	mci->edac_check = e752x_check;
 	mci->ctl_page_to_phys = ctl_page_to_phys;
@@ -828,8 +834,8 @@ static int e752x_probe1(struct pci_dev *
 		pci_read_config_byte(mci->pdev, E752X_DRB + index, &value);
 		/* convert a 128 or 64 MiB DRB to a page size. */
 		cumul_size = value << (25 + drc_drbg - PAGE_SHIFT);
-		debugf3("MC: " __FILE__ ": %s(): (%d) cumul_size 0x%x\n",
-			__func__, index, cumul_size);
+		debugf3("%s(): (%d) cumul_size 0x%x\n", __func__, index,
+			cumul_size);
 		if (cumul_size == last_cumul_size)
 			continue;	/* not populated */
 
@@ -897,8 +903,7 @@ static int e752x_probe1(struct pci_dev *
 
 	mci->edac_cap |= EDAC_FLAG_NONE;
 
-	debugf3("MC: " __FILE__ ": %s(): tolm, remapbase, remaplimit\n",
-		__func__);
+	debugf3("%s(): tolm, remapbase, remaplimit\n", __func__);
 	/* load the top of low memory, remap base, and remap limit vars */
 	pci_read_config_word(mci->pdev, E752X_TOLM, &pci_data);
 	pvt->tolm = ((u32) pci_data) << 4;
@@ -906,13 +911,12 @@ static int e752x_probe1(struct pci_dev *
 	pvt->remapbase = ((u32) pci_data) << 14;
 	pci_read_config_word(mci->pdev, E752X_REMAPLIMIT, &pci_data);
 	pvt->remaplimit = ((u32) pci_data) << 14;
-	printk("tolm = %x, remapbase = %x, remaplimit = %x\n", pvt->tolm,
-	       pvt->remapbase, pvt->remaplimit);
+	e752x_printk(KERN_INFO,
+		     "tolm = %x, remapbase = %x, remaplimit = %x\n",
+		     pvt->tolm, pvt->remapbase, pvt->remaplimit);
 
 	if (edac_mc_add_mc(mci)) {
-		debugf3("MC: " __FILE__
-			": %s(): failed edac_mc_add_mc()\n",
-			__func__);
+		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
 		goto fail;
 	}
 
@@ -975,7 +979,7 @@ static int e752x_probe1(struct pci_dev *
 	pci_write_config_word(dev, E752X_DRAM_NERR, stat16);
 
 	/* get this far and it's successful */
-	debugf3("MC: " __FILE__ ": %s(): success\n", __func__);
+	debugf3("%s(): success\n", __func__);
 	return 0;
 
 fail:
@@ -995,7 +999,7 @@ fail:
 static int __devinit e752x_init_one(struct pci_dev *pdev,
 				    const struct pci_device_id *ent)
 {
-	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 	/* wake up and enable device */
 	if(pci_enable_device(pdev) < 0)
@@ -1009,7 +1013,7 @@ static void __devexit e752x_remove_one(s
 	struct mem_ctl_info *mci;
 	struct e752x_pvt *pvt;
 
-	debugf0(__FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 	if ((mci = edac_mc_find_mci_by_pdev(pdev)) == NULL)
 		return;
@@ -1050,7 +1054,7 @@ static int __init e752x_init(void)
 {
 	int pci_rc;
 
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 	pci_rc = pci_register_driver(&e752x_driver);
 	return (pci_rc < 0) ? pci_rc : 0;
 }
@@ -1058,7 +1062,7 @@ static int __init e752x_init(void)
 
 static void __exit e752x_exit(void)
 {
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 	pci_unregister_driver(&e752x_driver);
 }
 
Index: linux-2.6.16-rc5-edac/drivers/edac/e7xxx_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/e7xxx_edac.c	2006-02-27 15:13:54.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/e7xxx_edac.c	2006-02-27 16:58:41.000000000 -0800
@@ -32,6 +32,14 @@
 #include "edac_mc.h"
 
 
+#define e7xxx_printk(level, fmt, arg...) \
+    edac_printk(level, "e7xxx", fmt, ##arg)
+
+
+#define e7xxx_mc_printk(mci, level, fmt, arg...) \
+    edac_mc_chipset_printk(mci, level, "e7xxx", fmt, ##arg)
+
+
 #ifndef PCI_DEVICE_ID_INTEL_7205_0
 #define PCI_DEVICE_ID_INTEL_7205_0	0x255d
 #endif				/* PCI_DEVICE_ID_INTEL_7205_0 */
@@ -161,7 +169,7 @@ static const struct e7xxx_dev_info e7xxx
 /* FIXME - is this valid for both SECDED and S4ECD4ED? */
 static inline int e7xxx_find_channel(u16 syndrome)
 {
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 
 	if ((syndrome & 0xff00) == 0)
 		return 0;
@@ -179,7 +187,7 @@ ctl_page_to_phys(struct mem_ctl_info *mc
 	u32 remap;
 	struct e7xxx_pvt *pvt = (struct e7xxx_pvt *) mci->pvt_info;
 
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 
 	if ((page < pvt->tolm) ||
 	    ((page >= 0x100000) && (page < pvt->remapbase)))
@@ -187,7 +195,7 @@ ctl_page_to_phys(struct mem_ctl_info *mc
 	remap = (page - pvt->tolm) + pvt->remapbase;
 	if (remap < pvt->remaplimit)
 		return remap;
-	printk(KERN_ERR "Invalid page %lx - out of range\n", page);
+	e7xxx_printk(KERN_ERR, "Invalid page %lx - out of range\n", page);
 	return pvt->tolm - 1;
 }
 
@@ -199,7 +207,7 @@ static void process_ce(struct mem_ctl_in
 	int row;
 	int channel;
 
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 
 	/* read the error address */
 	error_1b = info->dram_celog_add;
@@ -218,7 +226,7 @@ static void process_ce(struct mem_ctl_in
 
 static void process_ce_no_info(struct mem_ctl_info *mci)
 {
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 	edac_mc_handle_ce_no_info(mci, "e7xxx CE log register overflow");
 }
 
@@ -228,7 +236,7 @@ static void process_ue(struct mem_ctl_in
 	u32 error_2b, block_page;
 	int row;
 
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 
 	/* read the error address */
 	error_2b = info->dram_uelog_add;
@@ -241,7 +249,7 @@ static void process_ue(struct mem_ctl_in
 
 static void process_ue_no_info(struct mem_ctl_info *mci)
 {
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 	edac_mc_handle_ue_no_info(mci, "e7xxx UE log register overflow");
 }
 
@@ -330,7 +338,7 @@ static void e7xxx_check(struct mem_ctl_i
 {
 	struct e7xxx_error_info info;
 
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 	e7xxx_get_error_info(mci, &info);
 	e7xxx_process_error_info(mci, &info, 1);
 }
@@ -351,7 +359,7 @@ static int e7xxx_probe1(struct pci_dev *
 	unsigned long last_cumul_size;
 
 
-	debugf0("MC: " __FILE__ ": %s(): mci\n", __func__);
+	debugf0("%s(): mci\n", __func__);
 
 	/* need to find out the number of channels */
 	pci_read_config_dword(pdev, E7XXX_DRC, &drc);
@@ -369,7 +377,7 @@ static int e7xxx_probe1(struct pci_dev *
 		goto fail;
 	}
 
-	debugf3("MC: " __FILE__ ": %s(): init mci\n", __func__);
+	debugf3("%s(): init mci\n", __func__);
 
 	mci->mtype_cap = MEM_FLAG_RDDR;
 	mci->edac_ctl_cap =
@@ -379,21 +387,21 @@ static int e7xxx_probe1(struct pci_dev *
 	mci->mod_ver = "$Revision: 1.5.2.9 $";
 	mci->pdev = pdev;
 
-	debugf3("MC: " __FILE__ ": %s(): init pvt\n", __func__);
+	debugf3("%s(): init pvt\n", __func__);
 	pvt = (struct e7xxx_pvt *) mci->pvt_info;
 	pvt->dev_info = &e7xxx_devs[dev_idx];
 	pvt->bridge_ck = pci_get_device(PCI_VENDOR_ID_INTEL,
 					 pvt->dev_info->err_dev,
 					 pvt->bridge_ck);
 	if (!pvt->bridge_ck) {
-		printk(KERN_ERR
-		       "MC: error reporting device not found:"
-		       "vendor %x device 0x%x (broken BIOS?)\n",
-		       PCI_VENDOR_ID_INTEL, e7xxx_devs[dev_idx].err_dev);
+		e7xxx_printk(KERN_ERR, "error reporting device not found:"
+			     "vendor %x device 0x%x (broken BIOS?)\n",
+			     PCI_VENDOR_ID_INTEL,
+			     e7xxx_devs[dev_idx].err_dev);
 		goto fail;
 	}
 
-	debugf3("MC: " __FILE__ ": %s(): more mci init\n", __func__);
+	debugf3("%s(): more mci init\n", __func__);
 	mci->ctl_name = pvt->dev_info->ctl_name;
 
 	mci->edac_check = e7xxx_check;
@@ -418,8 +426,8 @@ static int e7xxx_probe1(struct pci_dev *
 		pci_read_config_byte(mci->pdev, E7XXX_DRB + index, &value);
 		/* convert a 64 or 32 MiB DRB to a page size. */
 		cumul_size = value << (25 + drc_drbg - PAGE_SHIFT);
-		debugf3("MC: " __FILE__ ": %s(): (%d) cumul_size 0x%x\n",
-			__func__, index, cumul_size);
+		debugf3("%s(): (%d) cumul_size 0x%x\n", __func__, index,
+			cumul_size);
 		if (cumul_size == last_cumul_size)
 			continue;	/* not populated */
 
@@ -449,8 +457,7 @@ static int e7xxx_probe1(struct pci_dev *
 
 	mci->edac_cap |= EDAC_FLAG_NONE;
 
-	debugf3("MC: " __FILE__ ": %s(): tolm, remapbase, remaplimit\n",
-		__func__);
+	debugf3("%s(): tolm, remapbase, remaplimit\n", __func__);
 	/* load the top of low memory, remap base, and remap limit vars */
 	pci_read_config_word(mci->pdev, E7XXX_TOLM, &pci_data);
 	pvt->tolm = ((u32) pci_data) << 4;
@@ -458,22 +465,21 @@ static int e7xxx_probe1(struct pci_dev *
 	pvt->remapbase = ((u32) pci_data) << 14;
 	pci_read_config_word(mci->pdev, E7XXX_REMAPLIMIT, &pci_data);
 	pvt->remaplimit = ((u32) pci_data) << 14;
-	printk("tolm = %x, remapbase = %x, remaplimit = %x\n", pvt->tolm,
-	       pvt->remapbase, pvt->remaplimit);
+	e7xxx_printk(KERN_INFO,
+		     "tolm = %x, remapbase = %x, remaplimit = %x\n",
+		     pvt->tolm, pvt->remapbase, pvt->remaplimit);
 
 	/* clear any pending errors, or initial state bits */
 	pci_write_bits8(pvt->bridge_ck, E7XXX_DRAM_FERR, 0x03, 0x03);
 	pci_write_bits8(pvt->bridge_ck, E7XXX_DRAM_NERR, 0x03, 0x03);
 
 	if (edac_mc_add_mc(mci) != 0) {
-		debugf3("MC: " __FILE__
-			": %s(): failed edac_mc_add_mc()\n",
-			__func__);
+		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
 		goto fail;
 	}
 
 	/* get this far and it's successful */
-	debugf3("MC: " __FILE__ ": %s(): success\n", __func__);
+	debugf3("%s(): success\n", __func__);
 	return 0;
 
 fail:
@@ -490,7 +496,7 @@ fail:
 static int __devinit
 e7xxx_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 	/* wake up and enable device */
 	return pci_enable_device(pdev) ?
@@ -503,7 +509,7 @@ static void __devexit e7xxx_remove_one(s
 	struct mem_ctl_info *mci;
 	struct e7xxx_pvt *pvt;
 
-	debugf0(__FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 	if (((mci = edac_mc_find_mci_by_pdev(pdev)) != 0) &&
 	    edac_mc_del_mc(mci)) {
Index: linux-2.6.16-rc5-edac/drivers/edac/edac_mc.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/edac_mc.c	2006-02-27 16:58:40.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/edac_mc.c	2006-02-27 16:58:41.000000000 -0800
@@ -37,7 +37,7 @@
 
 #include "edac_mc.h"
 
-#define	EDAC_MC_VERSION	"edac_mc  Ver: 2.0.0 " __DATE__
+#define	EDAC_MC_VERSION	"Ver: 2.0.0 " __DATE__
 
 #ifdef CONFIG_EDAC_DEBUG
 /* Values of 0 to 4 will generate output */
@@ -232,7 +232,7 @@ static struct memctrl_dev_attribute *mem
 /* Main MC kobject release() function */
 static void edac_memctrl_master_release(struct kobject *kobj)
 {
-	debugf1("EDAC MC: " __FILE__ ": %s()\n", __func__);
+	debugf1("%s()\n", __func__);
 }
 
 static struct kobj_type ktype_memctrl = {
@@ -254,7 +254,7 @@ static int edac_sysfs_memctrl_setup(void
 {
 	int err=0;
 
-	debugf1("MC: " __FILE__ ": %s()\n", __func__);
+	debugf1("%s()\n", __func__);
 
 	/* create the /sys/devices/system/edac directory */
 	err = sysdev_class_register(&edac_class);
@@ -278,7 +278,7 @@ static int edac_sysfs_memctrl_setup(void
 			}
 		}
 	} else {
-		debugf1(KERN_WARNING "__FILE__ %s() error=%d\n", __func__,err);
+		debugf1("%s() error=%d\n", __func__, err);
 	}
 
 	return err;
@@ -290,7 +290,7 @@ static int edac_sysfs_memctrl_setup(void
  */
 static void edac_sysfs_memctrl_teardown(void)
 {
-	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 	/* Unregister the MC's kobject */
 	kobject_unregister(&edac_memctrl_kobj);
@@ -542,7 +542,7 @@ static struct edac_pci_dev_attribute *ed
 /* No memory to release */
 static void edac_pci_release(struct kobject *kobj)
 {
-	debugf1("EDAC PCI: " __FILE__ ": %s()\n", __func__);
+	debugf1("%s()\n", __func__);
 }
 
 static struct kobj_type ktype_edac_pci = {
@@ -559,7 +559,7 @@ static int edac_sysfs_pci_setup(void)
 {
 	int err;
 
-	debugf1("MC: " __FILE__ ": %s()\n", __func__);
+	debugf1("%s()\n", __func__);
 
 	memset(&edac_pci_kobj, 0, sizeof(edac_pci_kobj));
 
@@ -583,7 +583,7 @@ static int edac_sysfs_pci_setup(void)
 
 static void edac_sysfs_pci_teardown(void)
 {
-	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 	kobject_unregister(&edac_pci_kobj);
 	kobject_put(&edac_pci_kobj);
@@ -772,7 +772,7 @@ static struct csrowdev_attribute *csrow_
 /* No memory to release */
 static void edac_csrow_instance_release(struct kobject *kobj)
 {
-	debugf1("EDAC MC: " __FILE__ ": %s()\n", __func__);
+	debugf1("%s()\n", __func__);
 }
 
 static struct kobj_type ktype_csrow = {
@@ -787,7 +787,7 @@ static int edac_create_csrow_object(stru
 {
 	int err = 0;
 
-	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 	memset(&csrow->kobj, 0, sizeof(csrow->kobj));
 
@@ -1030,8 +1030,7 @@ static void edac_mci_instance_release(st
 	struct mem_ctl_info *mci;
 	mci = container_of(kobj,struct mem_ctl_info,edac_mci_kobj);
 
-	debugf0("MC: " __FILE__ ": %s() idx=%d calling kfree\n",
-		__func__, mci->mc_idx);
+	debugf0("%s() idx=%d calling kfree\n", __func__, mci->mc_idx);
 
 	kfree(mci);
 }
@@ -1059,7 +1058,7 @@ static int edac_create_sysfs_mci_device(
 	struct csrow_info *csrow;
 	struct kobject *edac_mci_kobj=&mci->edac_mci_kobj;
 
-	debugf0("MC: " __FILE__ ": %s() idx=%d\n", __func__, mci->mc_idx);
+	debugf0("%s() idx=%d\n", __func__, mci->mc_idx);
 
 	memset(edac_mci_kobj, 0, sizeof(*edac_mci_kobj));
 	kobject_init(edac_mci_kobj);
@@ -1129,7 +1128,7 @@ static void edac_remove_sysfs_mci_device
 {
 	int i;
 
-	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 	/* remove all csrow kobjects */
 	for (i = 0; i < mci->nr_csrows; i++) {
@@ -1350,7 +1349,7 @@ struct mem_ctl_info *edac_mc_find_mci_by
 	struct mem_ctl_info *mci;
 	struct list_head *item;
 
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 
 	list_for_each(item, &mc_devices) {
 		mci = list_entry(item, struct mem_ctl_info, link);
@@ -1373,10 +1372,11 @@ static int add_mc_to_global_list (struct
 		insert_before = &mc_devices;
 	} else {
 		if (edac_mc_find_mci_by_pdev(mci->pdev)) {
-			printk(KERN_WARNING
-				"EDAC MC: %s (%s) %s %s already assigned %d\n",
-				mci->pdev->dev.bus_id, pci_name(mci->pdev),
-				mci->mod_name, mci->ctl_name, mci->mc_idx);
+			edac_printk(KERN_WARNING, EDAC_MC,
+				    "%s (%s) %s %s already assigned %d\n",
+				    mci->pdev->dev.bus_id,
+				    pci_name(mci->pdev), mci->mod_name,
+				    mci->ctl_name, mci->mc_idx);
 			return 1;
 		}
 
@@ -1422,7 +1422,7 @@ int edac_mc_add_mc(struct mem_ctl_info *
 {
 	int rc = 1;
 
-	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 #ifdef CONFIG_EDAC_DEBUG
 	if (edac_debug_level >= 3)
 		edac_mc_dump_mci(mci);
@@ -1447,18 +1447,15 @@ int edac_mc_add_mc(struct mem_ctl_info *
 	mci->start_time = jiffies;
 
         if (edac_create_sysfs_mci_device(mci)) {
-                printk(KERN_WARNING
-                       "EDAC MC%d: failed to create sysfs device\n",
-                       mci->mc_idx);
+                edac_mc_printk(mci, KERN_WARNING,
+			       "failed to create sysfs device\n");
 		/* FIXME - should there be an error code and unwind? */
                 goto finish;
         }
 
 	/* Report action taken */
-	printk(KERN_INFO
-	       "EDAC MC%d: Giving out device to %s %s: PCI %s\n",
-	       mci->mc_idx, mci->mod_name, mci->ctl_name,
-	       pci_name(mci->pdev));
+	edac_mc_printk(mci, KERN_INFO, "Giving out device to %s %s: PCI %s\n",
+		       mci->mod_name, mci->ctl_name, pci_name(mci->pdev));
 
 
 	rc = 0;
@@ -1501,13 +1498,12 @@ int edac_mc_del_mc(struct mem_ctl_info *
 {
 	int rc = 1;
 
-	debugf0("MC%d: " __FILE__ ": %s()\n", mci->mc_idx, __func__);
+	debugf0("MC%d: %s()\n", mci->mc_idx, __func__);
 	down(&mem_ctls_mutex);
 	del_mc_from_global_list(mci);
-	printk(KERN_INFO
-	       "EDAC MC%d: Removed device %d for %s %s: PCI %s\n",
-	       mci->mc_idx, mci->mc_idx, mci->mod_name, mci->ctl_name,
-	       pci_name(mci->pdev));
+	edac_printk(KERN_INFO, EDAC_MC,
+		    "Removed device %d for %s %s: PCI %s\n", mci->mc_idx,
+		    mci->mod_name, mci->ctl_name, pci_name(mci->pdev));
 	rc = 0;
 	up(&mem_ctls_mutex);
 
@@ -1524,7 +1520,7 @@ void edac_mc_scrub_block(unsigned long p
 	void *virt_addr;
 	unsigned long flags = 0;
 
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 
 	/* ECC error page was not in our memory. Ignore it. */
 	if(!pfn_valid(page))
@@ -1558,8 +1554,7 @@ int edac_mc_find_csrow_by_page(struct me
 	struct csrow_info *csrows = mci->csrows;
 	int row, i;
 
-	debugf1("MC%d: " __FILE__ ": %s(): 0x%lx\n", mci->mc_idx, __func__,
-		page);
+	debugf1("MC%d: %s(): 0x%lx\n", mci->mc_idx, __func__, page);
 	row = -1;
 
 	for (i = 0; i < mci->nr_csrows; i++) {
@@ -1568,11 +1563,10 @@ int edac_mc_find_csrow_by_page(struct me
 		if (csrow->nr_pages == 0)
 			continue;
 
-		debugf3("MC%d: " __FILE__
-			": %s(): first(0x%lx) page(0x%lx)"
-			" last(0x%lx) mask(0x%lx)\n", mci->mc_idx,
-			__func__, csrow->first_page, page,
-			csrow->last_page, csrow->page_mask);
+		debugf3("MC%d: %s(): first(0x%lx) page(0x%lx) last(0x%lx) "
+			"mask(0x%lx)\n", mci->mc_idx, __func__,
+			csrow->first_page, page, csrow->last_page,
+			csrow->page_mask);
 
 		if ((page >= csrow->first_page) &&
 		    (page <= csrow->last_page) &&
@@ -1584,9 +1578,9 @@ int edac_mc_find_csrow_by_page(struct me
 	}
 
 	if (row == -1)
-		printk(KERN_ERR
-		       "EDAC MC%d: could not look up page error address %lx\n",
-		       mci->mc_idx, (unsigned long) page);
+		edac_mc_printk(mci, KERN_ERR,
+			       "could not look up page error address %lx\n",
+			       (unsigned long) page);
 
 	return row;
 }
@@ -1604,36 +1598,36 @@ void edac_mc_handle_ce(struct mem_ctl_in
 {
 	unsigned long remapped_page;
 
-	debugf3("MC%d: " __FILE__ ": %s()\n", mci->mc_idx, __func__);
+	debugf3("MC%d: %s()\n", mci->mc_idx, __func__);
 
 	/* FIXME - maybe make panic on INTERNAL ERROR an option */
 	if (row >= mci->nr_csrows || row < 0) {
 		/* something is wrong */
-		printk(KERN_ERR
-		       "EDAC MC%d: INTERNAL ERROR: row out of range (%d >= %d)\n",
-		       mci->mc_idx, row, mci->nr_csrows);
+		edac_mc_printk(mci, KERN_ERR,
+			       "INTERNAL ERROR: row out of range "
+			       "(%d >= %d)\n", row, mci->nr_csrows);
 		edac_mc_handle_ce_no_info(mci, "INTERNAL ERROR");
 		return;
 	}
 	if (channel >= mci->csrows[row].nr_channels || channel < 0) {
 		/* something is wrong */
-		printk(KERN_ERR
-		       "EDAC MC%d: INTERNAL ERROR: channel out of range "
-		       "(%d >= %d)\n",
-		       mci->mc_idx, channel, mci->csrows[row].nr_channels);
+		edac_mc_printk(mci, KERN_ERR,
+			       "INTERNAL ERROR: channel out of range "
+			       "(%d >= %d)\n", channel,
+			       mci->csrows[row].nr_channels);
 		edac_mc_handle_ce_no_info(mci, "INTERNAL ERROR");
 		return;
 	}
 
 	if (log_ce)
 		/* FIXME - put in DIMM location */
-		printk(KERN_WARNING
-		       "EDAC MC%d: CE page 0x%lx, offset 0x%lx,"
-		       " grain %d, syndrome 0x%lx, row %d, channel %d,"
-		       " label \"%s\": %s\n", mci->mc_idx,
-		       page_frame_number, offset_in_page,
-		       mci->csrows[row].grain, syndrome, row, channel,
-		       mci->csrows[row].channels[channel].label, msg);
+		edac_mc_printk(mci, KERN_WARNING,
+			       "CE page 0x%lx, offset 0x%lx, grain %d, "
+			       "syndrome 0x%lx, row %d, channel %d, "
+			       "label \"%s\": %s\n", page_frame_number,
+			       offset_in_page, mci->csrows[row].grain,
+			       syndrome, row, channel,
+			       mci->csrows[row].channels[channel].label, msg);
 
 	mci->ce_count++;
 	mci->csrows[row].ce_count++;
@@ -1665,9 +1659,8 @@ void edac_mc_handle_ce_no_info(struct me
 				    const char *msg)
 {
 	if (log_ce)
-		printk(KERN_WARNING
-		       "EDAC MC%d: CE - no information available: %s\n",
-		       mci->mc_idx, msg);
+		edac_mc_printk(mci, KERN_WARNING,
+			       "CE - no information available: %s\n", msg);
 	mci->ce_noinfo_count++;
 	mci->ce_count++;
 }
@@ -1686,14 +1679,14 @@ void edac_mc_handle_ue(struct mem_ctl_in
 	int chan;
 	int chars;
 
-	debugf3("MC%d: " __FILE__ ": %s()\n", mci->mc_idx, __func__);
+	debugf3("MC%d: %s()\n", mci->mc_idx, __func__);
 
 	/* FIXME - maybe make panic on INTERNAL ERROR an option */
 	if (row >= mci->nr_csrows || row < 0) {
 		/* something is wrong */
-		printk(KERN_ERR
-		       "EDAC MC%d: INTERNAL ERROR: row out of range (%d >= %d)\n",
-		       mci->mc_idx, row, mci->nr_csrows);
+		edac_mc_printk(mci, KERN_ERR,
+			       "INTERNAL ERROR: row out of range "
+			       "(%d >= %d)\n", row, mci->nr_csrows);
 		edac_mc_handle_ue_no_info(mci, "INTERNAL ERROR");
 		return;
 	}
@@ -1711,11 +1704,11 @@ void edac_mc_handle_ue(struct mem_ctl_in
 	}
 
 	if (log_ue)
-		printk(KERN_EMERG
-		       "EDAC MC%d: UE page 0x%lx, offset 0x%lx, grain %d, row %d,"
-		       " labels \"%s\": %s\n", mci->mc_idx,
-		       page_frame_number, offset_in_page,
-		       mci->csrows[row].grain, row, labels, msg);
+		edac_mc_printk(mci, KERN_EMERG,
+			       "UE page 0x%lx, offset 0x%lx, grain %d, "
+			       "row %d, labels \"%s\": %s\n",
+			       page_frame_number, offset_in_page,
+			       mci->csrows[row].grain, row, labels, msg);
 
 	if (panic_on_ue)
 		panic
@@ -1738,9 +1731,8 @@ void edac_mc_handle_ue_no_info(struct me
 		panic("EDAC MC%d: Uncorrected Error", mci->mc_idx);
 
 	if (log_ue)
-		printk(KERN_WARNING
-		       "EDAC MC%d: UE - no information available: %s\n",
-		       mci->mc_idx, msg);
+		edac_mc_printk(mci, KERN_WARNING,
+		       "UE - no information available: %s\n", msg);
 	mci->ue_noinfo_count++;
 	mci->ue_count++;
 }
@@ -1810,25 +1802,22 @@ static void edac_pci_dev_parity_test(str
 	/* check the status reg for errors */
 	if (status) {
 		if (status & (PCI_STATUS_SIG_SYSTEM_ERROR))
-			printk(KERN_CRIT
-			   	"EDAC PCI- "
-				"Signaled System Error on %s\n",
-				pci_name (dev));
+			edac_printk(KERN_CRIT, EDAC_PCI,
+				    "Signaled System Error on %s\n",
+				    pci_name(dev));
 
 		if (status & (PCI_STATUS_PARITY)) {
-			printk(KERN_CRIT
-			   	"EDAC PCI- "
-				"Master Data Parity Error on %s\n",
-				pci_name (dev));
+			edac_printk(KERN_CRIT, EDAC_PCI,
+				    "Master Data Parity Error on %s\n",
+				    pci_name(dev));
 
 			atomic_inc(&pci_parity_count);
 		}
 
 		if (status & (PCI_STATUS_DETECTED_PARITY)) {
-			printk(KERN_CRIT
-			   	"EDAC PCI- "
-				"Detected Parity Error on %s\n",
-				pci_name (dev));
+			edac_printk(KERN_CRIT, EDAC_PCI,
+				    "Detected Parity Error on %s\n",
+				    pci_name(dev));
 
 			atomic_inc(&pci_parity_count);
 		}
@@ -1849,25 +1838,22 @@ static void edac_pci_dev_parity_test(str
 		/* check the secondary status reg for errors */
 		if (status) {
 			if (status & (PCI_STATUS_SIG_SYSTEM_ERROR))
-				printk(KERN_CRIT
-					"EDAC PCI-Bridge- "
-					"Signaled System Error on %s\n",
-					pci_name (dev));
+				edac_printk(KERN_CRIT, EDAC_PCI, "Bridge "
+					    "Signaled System Error on %s\n",
+					    pci_name(dev));
 
 			if (status & (PCI_STATUS_PARITY)) {
-				printk(KERN_CRIT
-					"EDAC PCI-Bridge- "
-					"Master Data Parity Error on %s\n",
-					pci_name (dev));
+				edac_printk(KERN_CRIT, EDAC_PCI, "Bridge "
+					    "Master Data Parity Error on "
+					    "%s\n", pci_name(dev));
 
 				atomic_inc(&pci_parity_count);
 			}
 
 			if (status & (PCI_STATUS_DETECTED_PARITY)) {
-				printk(KERN_CRIT
-					"EDAC PCI-Bridge- "
-					"Detected Parity Error on %s\n",
-					pci_name (dev));
+				edac_printk(KERN_CRIT, EDAC_PCI, "Bridge "
+					    "Detected Parity Error on %s\n",
+					    pci_name(dev));
 
 				atomic_inc(&pci_parity_count);
 			}
@@ -1946,7 +1932,7 @@ static void do_pci_parity_check(void)
 	unsigned long flags;
 	int before_count;
 
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 
 	if (!check_pci_parity)
 		return;
@@ -2004,7 +1990,7 @@ static inline void check_mc_devices (voi
 	struct list_head *item;
 	struct mem_ctl_info *mci;
 
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 
 	/* during poll, have interrupts off */
 	local_irq_save(flags);
@@ -2030,10 +2016,8 @@ static inline void check_mc_devices (voi
  */
 static void do_edac_check(void)
 {
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
-
+	debugf3("%s()\n", __func__);
 	check_mc_devices();
-
 	do_pci_parity_check();
 }
 
@@ -2060,7 +2044,7 @@ static int edac_kernel_thread(void *arg)
  */
 static int __init edac_mc_init(void)
 {
-	printk(KERN_INFO "MC: " __FILE__ " version " EDAC_MC_VERSION "\n");
+	edac_printk(KERN_INFO, EDAC_MC, EDAC_MC_VERSION "\n");
 
 	/*
 	 * Harvest and clear any boot/initialization PCI parity errors
@@ -2076,14 +2060,16 @@ static int __init edac_mc_init(void)
 
 	/* Create the MC sysfs entires */
 	if (edac_sysfs_memctrl_setup()) {
-		printk(KERN_ERR "EDAC MC: Error initializing sysfs code\n");
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Error initializing sysfs code\n");
 		return -ENODEV;
 	}
 
 	/* Create the PCI parity sysfs entries */
 	if (edac_sysfs_pci_setup()) {
 		edac_sysfs_memctrl_teardown();
-		printk(KERN_ERR "EDAC PCI: Error initializing sysfs code\n");
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "EDAC PCI: Error initializing sysfs code\n");
 		return -ENODEV;
 	}
 
@@ -2106,7 +2092,7 @@ static int __init edac_mc_init(void)
  */
 static void __exit edac_mc_exit(void)
 {
-	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 	kthread_stop(edac_thread);
 
Index: linux-2.6.16-rc5-edac/drivers/edac/edac_mc.h
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/edac_mc.h	2006-02-27 15:13:54.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/edac_mc.h	2006-02-27 16:58:41.000000000 -0800
@@ -43,10 +43,29 @@
 #define PAGES_TO_MiB( pages )	( ( pages ) << ( PAGE_SHIFT - 20 ) )
 #endif
 
+#define edac_printk(level, prefix, fmt, arg...) \
+    printk(level "EDAC " prefix ": " fmt, ##arg)
+
+#define edac_mc_printk(mci, level, fmt, arg...) \
+    printk(level "EDAC MC%d: " fmt, mci->mc_idx, ##arg)
+
+#define edac_mc_chipset_printk(mci, level, prefix, fmt, arg...) \
+    printk(level "EDAC " prefix " MC%d: " fmt, mci->mc_idx, ##arg)
+
+/* prefixes for edac_printk() and edac_mc_printk() */
+#define EDAC_MC "MC"
+#define EDAC_PCI "PCI"
+#define EDAC_DEBUG "DEBUG"
+
 #ifdef CONFIG_EDAC_DEBUG
 extern int edac_debug_level;
-#define edac_debug_printk(level, fmt, args...) \
-do { if (level <= edac_debug_level) printk(KERN_DEBUG fmt, ##args); } while(0)
+
+#define edac_debug_printk(level, fmt, arg...)                            \
+	do {                                                             \
+		if (level <= edac_debug_level)                           \
+			edac_printk(KERN_DEBUG, EDAC_DEBUG, fmt, ##arg); \
+	} while(0)
+
 #define debugf0( ... ) edac_debug_printk(0, __VA_ARGS__ )
 #define debugf1( ... ) edac_debug_printk(1, __VA_ARGS__ )
 #define debugf2( ... ) edac_debug_printk(2, __VA_ARGS__ )
Index: linux-2.6.16-rc5-edac/drivers/edac/i82860_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/i82860_edac.c	2006-02-27 15:13:54.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/i82860_edac.c	2006-02-27 16:58:41.000000000 -0800
@@ -19,6 +19,14 @@
 #include "edac_mc.h"
 
 
+#define i82860_printk(level, fmt, arg...) \
+    edac_printk(level, "i82860", fmt, ##arg)
+
+
+#define i82860_mc_printk(mci, level, fmt, arg...) \
+    edac_mc_chipset_printk(mci, level, "i82860", fmt, ##arg)
+
+
 #ifndef PCI_DEVICE_ID_INTEL_82860_0
 #define PCI_DEVICE_ID_INTEL_82860_0	0x2531
 #endif				/* PCI_DEVICE_ID_INTEL_82860_0 */
@@ -117,7 +125,7 @@ static void i82860_check(struct mem_ctl_
 {
 	struct i82860_error_info info;
 
-	debugf1("MC%d: " __FILE__ ": %s()\n", mci->mc_idx, __func__);
+	debugf1("MC%d: %s()\n", mci->mc_idx, __func__);
 	i82860_get_error_info(mci, &info);
 	i82860_process_error_info(mci, &info, 1);
 }
@@ -143,7 +151,7 @@ static int i82860_probe1(struct pci_dev 
 	if (!mci)
 		return -ENOMEM;
 
-	debugf3("MC: " __FILE__ ": %s(): init mci\n", __func__);
+	debugf3("%s(): init mci\n", __func__);
 
 	mci->pdev = pdev;
 	mci->mtype_cap = MEM_FLAG_DDR;
@@ -179,8 +187,8 @@ static int i82860_probe1(struct pci_dev 
 
 		cumul_size = (value & I82860_GBA_MASK) <<
 		    (I82860_GBA_SHIFT - PAGE_SHIFT);
-		debugf3("MC: " __FILE__ ": %s(): (%d) cumul_size 0x%x\n",
-			__func__, index, cumul_size);
+		debugf3("%s(): (%d) cumul_size 0x%x\n", __func__, index,
+			cumul_size);
 		if (cumul_size == last_cumul_size)
 			continue;	/* not populated */
 
@@ -198,13 +206,11 @@ static int i82860_probe1(struct pci_dev 
 	pci_write_bits16(mci->pdev, I82860_ERRSTS, 0x0003, 0x0003);
 
 	if (edac_mc_add_mc(mci)) {
-		debugf3("MC: " __FILE__
-			": %s(): failed edac_mc_add_mc()\n",
-			__func__);
+		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
 		edac_mc_free(mci);
 	} else {
 		/* get this far and it's successful */
-		debugf3("MC: " __FILE__ ": %s(): success\n", __func__);
+		debugf3("%s(): success\n", __func__);
 		rc = 0;
 	}
 	return rc;
@@ -216,9 +222,9 @@ static int __devinit i82860_init_one(str
 {
 	int rc;
 
-	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
-	printk(KERN_INFO "i82860 init one\n");
+	i82860_printk(KERN_INFO, "i82860 init one\n");
 	if(pci_enable_device(pdev) < 0)
 		return -EIO;
 	rc = i82860_probe1(pdev, ent->driver_data);
@@ -231,7 +237,7 @@ static void __devexit i82860_remove_one(
 {
 	struct mem_ctl_info *mci;
 
-	debugf0(__FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 	mci = edac_mc_find_mci_by_pdev(pdev);
 	if ((mci != NULL) && (edac_mc_del_mc(mci) == 0))
@@ -257,7 +263,7 @@ static int __init i82860_init(void)
 {
 	int pci_rc;
 
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 	if ((pci_rc = pci_register_driver(&i82860_driver)) < 0)
 		return pci_rc;
 
@@ -281,7 +287,7 @@ static int __init i82860_init(void)
 
 static void __exit i82860_exit(void)
 {
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 
 	pci_unregister_driver(&i82860_driver);
 	if (!i82860_registered) {
Index: linux-2.6.16-rc5-edac/drivers/edac/i82875p_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/i82875p_edac.c	2006-02-27 15:13:54.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/i82875p_edac.c	2006-02-27 16:58:41.000000000 -0800
@@ -26,6 +26,14 @@
 #include "edac_mc.h"
 
 
+#define i82875p_printk(level, fmt, arg...) \
+    edac_printk(level, "i82875p", fmt, ##arg)
+
+
+#define i82875p_mc_printk(mci, level, fmt, arg...) \
+    edac_mc_chipset_printk(mci, level, "i82875p", fmt, ##arg)
+
+
 #ifndef PCI_DEVICE_ID_INTEL_82875_0
 #define PCI_DEVICE_ID_INTEL_82875_0	0x2578
 #endif				/* PCI_DEVICE_ID_INTEL_82875_0 */
@@ -254,7 +262,7 @@ static void i82875p_check(struct mem_ctl
 {
 	struct i82875p_error_info info;
 
-	debugf1("MC%d: " __FILE__ ": %s()\n", mci->mc_idx, __func__);
+	debugf1("MC%d: %s()\n", mci->mc_idx, __func__);
 	i82875p_get_error_info(mci, &info);
 	i82875p_process_error_info(mci, &info, 1);
 }
@@ -279,7 +287,7 @@ static int i82875p_probe1(struct pci_dev
 	u32 nr_chans;
 	u32 drc_ddim;		/* DRAM Data Integrity Mode 0=none,2=edac */
 
-	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 	ovrfl_pdev = pci_find_device(PCI_VEND_DEV(INTEL, 82875_6), NULL);
 
@@ -298,16 +306,16 @@ static int i82875p_probe1(struct pci_dev
 	}
 #ifdef CONFIG_PROC_FS
 	if (!ovrfl_pdev->procent && pci_proc_attach_device(ovrfl_pdev)) {
-		printk(KERN_ERR "MC: " __FILE__
-		       ": %s(): Failed to attach overflow device\n",
-		       __func__);
+		i82875p_printk(KERN_ERR,
+			       "%s(): Failed to attach overflow device\n",
+			       __func__);
 		goto fail;
 	}
 #endif				/* CONFIG_PROC_FS */
 	if (pci_enable_device(ovrfl_pdev)) {
-		printk(KERN_ERR "MC: " __FILE__
-		       ": %s(): Failed to enable overflow device\n",
-		       __func__);
+		i82875p_printk(KERN_ERR,
+			       "%s(): Failed to enable overflow device\n",
+			       __func__);
 		goto fail;
 	}
 
@@ -321,8 +329,8 @@ static int i82875p_probe1(struct pci_dev
 				       pci_resource_len(ovrfl_pdev, 0));
 
 	if (!ovrfl_window) {
-		printk(KERN_ERR "MC: " __FILE__
-		       ": %s(): Failed to ioremap bar6\n", __func__);
+		i82875p_printk(KERN_ERR, "%s(): Failed to ioremap bar6\n",
+			       __func__);
 		goto fail;
 	}
 
@@ -340,7 +348,7 @@ static int i82875p_probe1(struct pci_dev
 		goto fail;
 	}
 
-	debugf3("MC: " __FILE__ ": %s(): init mci\n", __func__);
+	debugf3("%s(): init mci\n", __func__);
 
 	mci->pdev = pdev;
 	mci->mtype_cap = MEM_FLAG_DDR;
@@ -355,7 +363,7 @@ static int i82875p_probe1(struct pci_dev
 	mci->edac_check = i82875p_check;
 	mci->ctl_page_to_phys = NULL;
 
-	debugf3("MC: " __FILE__ ": %s(): init pvt\n", __func__);
+	debugf3("%s(): init pvt\n", __func__);
 
 	pvt = (struct i82875p_pvt *) mci->pvt_info;
 	pvt->ovrfl_pdev = ovrfl_pdev;
@@ -374,8 +382,8 @@ static int i82875p_probe1(struct pci_dev
 
 		value = readb(ovrfl_window + I82875P_DRB + index);
 		cumul_size = value << (I82875P_DRB_SHIFT - PAGE_SHIFT);
-		debugf3("MC: " __FILE__ ": %s(): (%d) cumul_size 0x%x\n",
-			__func__, index, cumul_size);
+		debugf3("%s(): (%d) cumul_size 0x%x\n", __func__, index,
+			cumul_size);
 		if (cumul_size == last_cumul_size)
 			continue;	/* not populated */
 
@@ -393,13 +401,12 @@ static int i82875p_probe1(struct pci_dev
 	pci_write_bits16(mci->pdev, I82875P_ERRSTS, 0x0081, 0x0081);
 
 	if (edac_mc_add_mc(mci)) {
-		debugf3("MC: " __FILE__
-			": %s(): failed edac_mc_add_mc()\n", __func__);
+		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
 		goto fail;
 	}
 
 	/* get this far and it's successful */
-	debugf3("MC: " __FILE__ ": %s(): success\n", __func__);
+	debugf3("%s(): success\n", __func__);
 	return 0;
 
       fail:
@@ -425,9 +432,9 @@ static int __devinit i82875p_init_one(st
 {
 	int rc;
 
-	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
-	printk(KERN_INFO "i82875p init one\n");
+	i82875p_printk(KERN_INFO, "i82875p init one\n");
 	if(pci_enable_device(pdev) < 0)
 		return -EIO;
 	rc = i82875p_probe1(pdev, ent->driver_data);
@@ -442,7 +449,7 @@ static void __devexit i82875p_remove_one
 	struct mem_ctl_info *mci;
 	struct i82875p_pvt *pvt = NULL;
 
-	debugf0(__FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 	if ((mci = edac_mc_find_mci_by_pdev(pdev)) == NULL)
 		return;
@@ -487,7 +494,7 @@ static int __init i82875p_init(void)
 {
 	int pci_rc;
 
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 	pci_rc = pci_register_driver(&i82875p_driver);
 	if (pci_rc < 0)
 		return pci_rc;
@@ -513,7 +520,7 @@ static int __init i82875p_init(void)
 
 static void __exit i82875p_exit(void)
 {
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	debugf3("%s()\n", __func__);
 
 	pci_unregister_driver(&i82875p_driver);
 	if (!i82875p_registered) {
Index: linux-2.6.16-rc5-edac/drivers/edac/r82600_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/r82600_edac.c	2006-02-27 15:13:54.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/r82600_edac.c	2006-02-27 16:58:41.000000000 -0800
@@ -26,6 +26,12 @@
 
 #include "edac_mc.h"
 
+#define r82600_printk(level, fmt, arg...) \
+    edac_printk(level, "r82600", fmt, ##arg)
+
+#define r82600_mc_printk(mci, level, fmt, arg...) \
+    edac_mc_chipset_printk(mci, level, "r82600", fmt, ##arg)
+
 /* Radisys say "The 82600 integrates a main memory SDRAM controller that
  * supports up to four banks of memory. The four banks can support a mix of
  * sizes of 64 bit wide (72 bits with ECC) Synchronous DRAM (SDRAM) DIMMs,
@@ -196,7 +202,7 @@ static void r82600_check(struct mem_ctl_
 {
 	struct r82600_error_info info;
 
-	debugf1("MC%d: " __FILE__ ": %s()\n", mci->mc_idx, __func__);
+	debugf1("MC%d: %s()\n", mci->mc_idx, __func__);
 	r82600_get_error_info(mci, &info);
 	r82600_process_error_info(mci, &info, 1);
 }
@@ -215,7 +221,7 @@ static int r82600_probe1(struct pci_dev 
 	u32 row_high_limit_last = 0;
 	u32 eap_init_bits;
 
-	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 
 	pci_read_config_byte(pdev, R82600_DRAMC, &dramcr);
@@ -226,11 +232,10 @@ static int r82600_probe1(struct pci_dev 
 	scrub_disabled = eapr & BIT(31);
 	sdram_refresh_rate = dramcr & (BIT(0) | BIT(1));
 
-	debugf2("MC: " __FILE__ ": %s(): sdram refresh rate = %#0x\n",
-		__func__, sdram_refresh_rate);
+	debugf2("%s(): sdram refresh rate = %#0x\n", __func__,
+		sdram_refresh_rate);
 
-	debugf2("MC: " __FILE__ ": %s(): DRAMC register = %#0x\n", __func__,
-		dramcr);
+	debugf2("%s(): DRAMC register = %#0x\n", __func__, dramcr);
 
 	mci = edac_mc_alloc(0, R82600_NR_CSROWS, R82600_NR_CHANS);
 
@@ -239,7 +244,7 @@ static int r82600_probe1(struct pci_dev 
 		goto fail;
 	}
 
-	debugf0("MC: " __FILE__ ": %s(): mci = %p\n", __func__, mci);
+	debugf0("%s(): mci = %p\n", __func__, mci);
 
 	mci->pdev = pdev;
 	mci->mtype_cap = MEM_FLAG_RDDR | MEM_FLAG_DDR;
@@ -255,9 +260,8 @@ static int r82600_probe1(struct pci_dev 
 	mci->edac_cap = EDAC_FLAG_NONE | EDAC_FLAG_EC | EDAC_FLAG_SECDED;
 	if (ecc_on) {
 		if (scrub_disabled)
-			debugf3("MC: " __FILE__ ": %s(): mci = %p - "
-				"Scrubbing disabled! EAP: %#0x\n", __func__,
-				mci, eapr);
+			debugf3("%s(): mci = %p - Scrubbing disabled! EAP: "
+				"%#0x\n", __func__, mci, eapr);
 	} else
 		mci->edac_cap = EDAC_FLAG_NONE;
 
@@ -276,16 +280,15 @@ static int r82600_probe1(struct pci_dev 
 		/* find the DRAM Chip Select Base address and mask */
 		pci_read_config_byte(mci->pdev, R82600_DRBA + index, &drbar);
 
-		debugf1("MC%d: " __FILE__ ": %s() Row=%d DRBA = %#0x\n",
-			mci->mc_idx, __func__, index, drbar);
+		debugf1("MC%d: %s() Row=%d DRBA = %#0x\n", mci->mc_idx,
+			__func__, index, drbar);
 
 		row_high_limit = ((u32) drbar << 24);
 /*		row_high_limit = ((u32)drbar << 24) | 0xffffffUL; */
 
-		debugf1("MC%d: " __FILE__ ": %s() Row=%d, "
-			"Boundry Address=%#0x, Last = %#0x \n",
-			mci->mc_idx, __func__, index, row_high_limit,
-			row_high_limit_last);
+		debugf1("MC%d: %s() Row=%d, Boundry Address=%#0x, Last = "
+			"%#0x \n", mci->mc_idx, __func__, index,
+			row_high_limit, row_high_limit_last);
 
 		/* Empty row [p.57] */
 		if (row_high_limit == row_high_limit_last)
@@ -312,8 +315,7 @@ static int r82600_probe1(struct pci_dev 
 	/* FIXME should we? */
 
 	if (edac_mc_add_mc(mci)) {
-		debugf3("MC: " __FILE__
-			": %s(): failed edac_mc_add_mc()\n", __func__);
+		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
 		goto fail;
 	}
 
@@ -325,14 +327,14 @@ static int r82600_probe1(struct pci_dev 
 	eap_init_bits = BIT(0) & BIT(1);
 	if (disable_hardware_scrub) {
 		eap_init_bits |= BIT(31);
-		debugf3("MC: " __FILE__ ": %s(): Disabling Hardware Scrub "
-			"(scrub on error)\n", __func__);
+		debugf3("%s(): Disabling Hardware Scrub (scrub on error)\n",
+			__func__);
 	}
 
 	pci_write_bits32(mci->pdev, R82600_EAP, eap_init_bits,
 			 eap_init_bits);
 
-	debugf3("MC: " __FILE__ ": %s(): success\n", __func__);
+	debugf3("%s(): success\n", __func__);
 	return 0;
 
 fail:
@@ -346,7 +348,7 @@ fail:
 static int __devinit r82600_init_one(struct pci_dev *pdev,
 				     const struct pci_device_id *ent)
 {
-	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 	/* don't need to call pci_device_enable() */
 	return r82600_probe1(pdev, ent->driver_data);
@@ -357,7 +359,7 @@ static void __devexit r82600_remove_one(
 {
 	struct mem_ctl_info *mci;
 
-	debugf0(__FILE__ ": %s()\n", __func__);
+	debugf0("%s()\n", __func__);
 
 	if (((mci = edac_mc_find_mci_by_pdev(pdev)) != NULL) &&
 	    !edac_mc_del_mc(mci))
