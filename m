Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVJLTCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVJLTCZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 15:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVJLTCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 15:02:25 -0400
Received: from fmr20.intel.com ([134.134.136.19]:14001 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932386AbVJLTCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 15:02:24 -0400
Date: Wed, 12 Oct 2005 12:01:28 -0700
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Cc: venki <venkatesh.pallipadi@intel.com>, bob.picco@hp.com
Subject: [PATCH 3/3] hpet: cleanups and common code-to-function
Message-Id: <20051012120128.7b995c8b.randy_d_dunlap@linux.intel.com>
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

 drivers/char/hpet.c     |   65 ++++++++++++++++++++------------------
 1 files changed, 35 insertions(+), 30 deletions(-)

diff -Naurp linux-2614-rc4/drivers/char/hpet.c~hpet_cleanups linux-2614-rc4/drivers/char/hpet.c
--- linux-2614-rc4/drivers/char/hpet.c~hpet_cleanups	2005-10-12 10:02:33.000000000 -0700
+++ linux-2614-rc4/drivers/char/hpet.c	2005-10-12 10:35:42.000000000 -0700
@@ -278,7 +278,8 @@ static int hpet_mmap(struct file *file, 
 
 	if (io_remap_pfn_range(vma, vma->vm_start, addr >> PAGE_SHIFT,
 					PAGE_SIZE, vma->vm_page_prot)) {
-		printk(KERN_ERR "remap_pfn_range failed in hpet.c\n");
+		printk(KERN_ERR "%s: io_remap_pfn_range failed\n",
+			__FUNCTION__);
 		return -EAGAIN;
 	}
 
@@ -541,6 +542,17 @@ static struct file_operations hpet_fops 
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
@@ -704,11 +716,10 @@ static void hpet_register_interpolator(s
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
@@ -773,31 +784,28 @@ int hpet_alloc(struct hpet_data *hdp)
 	struct hpets *hpetp;
 	size_t siz;
 	struct hpet __iomem *hpet;
-	static struct hpets *last = (struct hpets *)0;
+	static struct hpets *last = NULL;
 	unsigned long ns;
 
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
@@ -885,7 +893,6 @@ static acpi_status hpet_resources(struct
 	struct hpet_data *hdp;
 	acpi_status status;
 	struct acpi_resource_address64 addr;
-	struct hpets *hpetp;
 
 	hdp = data;
 
@@ -898,13 +905,12 @@ static acpi_status hpet_resources(struct
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
 	} else if (res->id == ACPI_RSTYPE_FIXED_MEM32) {
 		struct acpi_resource_fixed_mem32 *fixmem32;
 
@@ -916,13 +922,12 @@ static acpi_status hpet_resources(struct
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
 	} else if (res->id == ACPI_RSTYPE_EXT_IRQ) {
 		struct acpi_resource_ext_irq *irqp;
 		int i;


---
