Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVJRUx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVJRUx5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 16:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVJRUxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 16:53:51 -0400
Received: from fmr19.intel.com ([134.134.136.18]:40910 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932127AbVJRUxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 16:53:48 -0400
Date: Tue, 18 Oct 2005 13:55:14 -0700
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, bob.picco@hp.com,
       venki <venkatesh.pallipadi@intel.com>
Subject: [PATCH 3/3 -mm] hpet: hpet driver cleanups
Message-Id: <20051018135514.2178637f.randy_d_dunlap@linux.intel.com>
X-Mailer: Sylpheed version 2.0.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
X-Face: "}I"O`t9.W]b]8SycP0Jap#<FU!b:16h{lR\#aFEpEf\3c]wtAL|,'>)%JR<P#Yg.88}`$#
 A#bhRMP(=%<w07"0#EoCxXWD%UDdeU]>,H)Eg(FP)?S1qh0ZJRu|mz*%SKpL7rcKI3(OwmK2@uo\b2
 GB:7w&?a,*<8v[ldN`5)MXFcm'cjwRs5)ui)j
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

- Use kzalloc() instead of kmalloc + memset.
- Clean/fix some printk's.
- Use NULL for pointers instead of 0.
- Combine hpet busy searching locations into a function call.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---

Index: linux-2614-rc4-mm1/drivers/char/hpet.c
===================================================================
--- linux-2614-rc4-mm1.orig/drivers/char/hpet.c
+++ linux-2614-rc4-mm1/drivers/char/hpet.c
@@ -284,7 +284,8 @@ static int hpet_mmap(struct file *file, 
 
 	if (io_remap_pfn_range(vma, vma->vm_start, addr >> PAGE_SHIFT,
 					PAGE_SIZE, vma->vm_page_prot)) {
-		printk(KERN_ERR "remap_pfn_range failed in hpet.c\n");
+		printk(KERN_ERR "%s: io_remap_pfn_range failed\n",
+			__FUNCTION__);
 		return -EAGAIN;
 	}
 
@@ -565,6 +566,17 @@ static struct file_operations hpet_fops 
 	.mmap = hpet_mmap,
 };
 
+static int hpet_is_known(struct hpet_data *hdp)
+{
+	struct hpets *hpetp;
+
+	for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
+		if (hpetp->hp_hpet_phys == hdp->hd_phys_address)
+			return 1;
+
+	return 0;
+}
+
 EXPORT_SYMBOL(hpet_alloc);
 EXPORT_SYMBOL(hpet_register);
 EXPORT_SYMBOL(hpet_unregister);
@@ -730,11 +742,10 @@ static void hpet_register_interpolator(s
 #ifdef	CONFIG_TIME_INTERPOLATION
 	struct time_interpolator *ti;
 
-	ti = kmalloc(sizeof(*ti), GFP_KERNEL);
+	ti = kzalloc(sizeof(*ti), GFP_KERNEL);
 	if (!ti)
 		return;
 
-	memset(ti, 0, sizeof(*ti));
 	ti->source = TIME_SOURCE_MMIO64;
 	ti->shift = 10;
 	ti->addr = &hpetp->hp_hpet->hpet_mc;
@@ -799,32 +810,29 @@ int hpet_alloc(struct hpet_data *hdp)
 	struct hpets *hpetp;
 	size_t siz;
 	struct hpet __iomem *hpet;
-	static struct hpets *last = (struct hpets *)0;
+	static struct hpets *last = NULL;
 	unsigned long period;
 	unsigned long long temp;
 
 	/*
 	 * hpet_alloc can be called by platform dependent code.
-	 * if platform dependent code has allocated the hpet
-	 * ACPI also reports hpet, then we catch it here.
+	 * If platform dependent code has allocated the hpet that
+	 * ACPI has also reported, then we catch it here.
 	 */
-	for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
-		if (hpetp->hp_hpet_phys == hdp->hd_phys_address) {
-			printk(KERN_DEBUG "%s: duplicate HPET ignored\n",
-				__FUNCTION__);
-			return 0;
-		}
+	if (hpet_is_known(hdp)) {
+		printk(KERN_DEBUG "%s: duplicate HPET ignored\n",
+			__FUNCTION__);
+		return 0;
+	}
 
 	siz = sizeof(struct hpets) + ((hdp->hd_nirqs - 1) *
 				      sizeof(struct hpet_dev));
 
-	hpetp = kmalloc(siz, GFP_KERNEL);
+	hpetp = kzalloc(siz, GFP_KERNEL);
 
 	if (!hpetp)
 		return -ENOMEM;
 
-	memset(hpetp, 0, siz);
-
 	hpetp->hp_which = hpet_nhpet++;
 	hpetp->hp_hpet = hdp->hd_address;
 	hpetp->hp_hpet_phys = hdp->hd_phys_address;
@@ -911,7 +919,6 @@ static acpi_status hpet_resources(struct
 	struct hpet_data *hdp;
 	acpi_status status;
 	struct acpi_resource_address64 addr;
-	struct hpets *hpetp;
 
 	hdp = data;
 
@@ -924,13 +931,12 @@ static acpi_status hpet_resources(struct
 		hdp->hd_phys_address = addr.min_address_range;
 		hdp->hd_address = ioremap(addr.min_address_range, size);
 
-		for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
-			if (hpetp->hp_hpet_phys == hdp->hd_phys_address) {
-				printk(KERN_DEBUG "%s: 0x%lx is busy\n",
-					__FUNCTION__, hdp->hd_phys_address);
-				iounmap(hdp->hd_address);
-				return -EBUSY;
-			}
+		if (hpet_is_known(hdp)) {
+			printk(KERN_DEBUG "%s: 0x%lx is busy\n",
+				__FUNCTION__, hdp->hd_phys_address);
+			iounmap(hdp->hd_address);
+			return -EBUSY;
+		}
 	} else if (res->type == ACPI_RSTYPE_FIXED_MEM32) {
 		struct acpi_resource_fixed_mem32 *fixmem32;
 
@@ -942,13 +948,12 @@ static acpi_status hpet_resources(struct
 		hdp->hd_address = ioremap(fixmem32->range_base_address,
 						HPET_RANGE_SIZE);
 
-		for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
-			if (hpetp->hp_hpet_phys == hdp->hd_phys_address) {
-				printk(KERN_DEBUG "%s: 0x%lx is busy\n",
-					__FUNCTION__, hdp->hd_phys_address);
-				iounmap(hdp->hd_address);
-				return -EBUSY;
-			}
+		if (hpet_is_known(hdp)) {
+			printk(KERN_DEBUG "%s: 0x%lx is busy\n",
+				__FUNCTION__, hdp->hd_phys_address);
+			iounmap(hdp->hd_address);
+			return -EBUSY;
+		}
 	} else if (res->type == ACPI_RSTYPE_EXT_IRQ) {
 		struct acpi_resource_ext_irq *irqp;
 		int i;


---
