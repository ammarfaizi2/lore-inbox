Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVJLTCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVJLTCu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 15:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVJLTCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 15:02:50 -0400
Received: from fmr19.intel.com ([134.134.136.18]:54944 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932417AbVJLTC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 15:02:26 -0400
Date: Wed, 12 Oct 2005 11:59:35 -0700
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Cc: venki <venkatesh.pallipadi@intel.com>, bob.picco@hp.com
Subject: [PATCH 2/3] hpet: use physical addresses for dup. checking
Message-Id: <20051012115935.5ac8ab3a.randy_d_dunlap@linux.intel.com>
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

- Use HPET physical address to detect duplicates, not logical addresses.
  Using logical (mapped) addresses fails to detect duplicates
  because ioremap() returns a new mapped address each time.
- iounmap() regions when duplicate/busy areas are found.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---

 drivers/char/hpet.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff -Naurp linux-2614-rc4/drivers/char/hpet.c~hpet_phys_addr linux-2614-rc4/drivers/char/hpet.c
--- linux-2614-rc4/drivers/char/hpet.c~hpet_phys_addr	2005-10-12 09:47:20.000000000 -0700
+++ linux-2614-rc4/drivers/char/hpet.c	2005-10-12 10:02:33.000000000 -0700
@@ -782,8 +782,11 @@ int hpet_alloc(struct hpet_data *hdp)
 	 * ACPI also reports hpet, then we catch it here.
 	 */
 	for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
-		if (hpetp->hp_hpet == hdp->hd_address)
+		if (hpetp->hp_hpet_phys == hdp->hd_phys_address) {
+			printk(KERN_DEBUG "%s: duplicate HPET ignored\n",
+				__FUNCTION__);
 			return 0;
+		}
 
 	siz = sizeof(struct hpets) + ((hdp->hd_nirqs - 1) *
 				      sizeof(struct hpet_dev));
@@ -827,8 +830,8 @@ int hpet_alloc(struct hpet_data *hdp)
 	hpetp->hp_period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
 	    HPET_COUNTER_CLK_PERIOD_SHIFT;
 
-	printk(KERN_INFO "hpet%d: at MMIO 0x%lx, IRQ%s",
-		hpetp->hp_which, hdp->hd_phys_address,
+	printk(KERN_INFO "hpet%d: at MMIO 0x%lx (virtual 0x%p), IRQ%s",
+		hpetp->hp_which, hdp->hd_phys_address, hdp->hd_address,
 		hpetp->hp_ntimer > 1 ? "s" : "");
 	for (i = 0; i < hpetp->hp_ntimer; i++)
 		printk("%s %d", i > 0 ? "," : "", hdp->hd_irq[i]);
@@ -896,8 +899,12 @@ static acpi_status hpet_resources(struct
 		hdp->hd_address = ioremap(addr.min_address_range, size);
 
 		for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
-			if (hpetp->hp_hpet == hdp->hd_address)
+			if (hpetp->hp_hpet_phys == hdp->hd_phys_address) {
+				printk(KERN_DEBUG "%s: 0x%lx is busy\n",
+					__FUNCTION__, hdp->hd_phys_address);
+				iounmap(hdp->hd_address);
 				return -EBUSY;
+			}
 	} else if (res->id == ACPI_RSTYPE_FIXED_MEM32) {
 		struct acpi_resource_fixed_mem32 *fixmem32;
 
@@ -910,7 +917,10 @@ static acpi_status hpet_resources(struct
 						HPET_RANGE_SIZE);
 
 		for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
-			if (hpetp->hp_hpet == hdp->hd_address) {
+			if (hpetp->hp_hpet_phys == hdp->hd_phys_address) {
+				printk(KERN_DEBUG "%s: 0x%lx is busy\n",
+					__FUNCTION__, hdp->hd_phys_address);
+				iounmap(hdp->hd_address);
 				return -EBUSY;
 			}
 	} else if (res->id == ACPI_RSTYPE_EXT_IRQ) {


---
