Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVJLTCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVJLTCZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 15:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVJLTCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 15:02:24 -0400
Received: from fmr17.intel.com ([134.134.136.16]:36066 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932350AbVJLTCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 15:02:24 -0400
Date: Wed, 12 Oct 2005 11:58:14 -0700
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Cc: venki <venkatesh.pallipadi@intel.com>, bob.picco@hp.com
Subject: [PATCH 1/3] hpet: allow fixed_mem32 ACPI resource type
Message-Id: <20051012115814.1d367a94.randy_d_dunlap@linux.intel.com>
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

Allow the ACPI HPET description table to use a resource type
of FIXED_MEM32 for the HPET reource.  Use the fixed resoure
size of 1 KB for the HPET resource as per the HPET spec.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Acked-by: Bob Picco <bob.picco@hp.com>
---

 drivers/char/hpet.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)

diff -Naurp linux-2614-rc4/drivers/char/hpet.c~hpet_fixmem32 linux-2614-rc4/drivers/char/hpet.c
--- linux-2614-rc4/drivers/char/hpet.c~hpet_fixmem32	2005-10-12 09:40:24.000000000 -0700
+++ linux-2614-rc4/drivers/char/hpet.c	2005-10-12 09:47:20.000000000 -0700
@@ -49,6 +49,8 @@
 #define	HPET_USER_FREQ	(64)
 #define	HPET_DRIFT	(500)
 
+#define HPET_RANGE_SIZE		1024	/* from HPET spec */
+
 static u32 hpet_ntimer, hpet_nhpet, hpet_max_freq = HPET_USER_FREQ;
 
 /* A lock for concurrent access by app and isr hpet activity. */
@@ -896,6 +898,21 @@ static acpi_status hpet_resources(struct
 		for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
 			if (hpetp->hp_hpet == hdp->hd_address)
 				return -EBUSY;
+	} else if (res->id == ACPI_RSTYPE_FIXED_MEM32) {
+		struct acpi_resource_fixed_mem32 *fixmem32;
+
+		fixmem32 = &res->data.fixed_memory32;
+		if (!fixmem32)
+			return -EINVAL;
+
+		hdp->hd_phys_address = fixmem32->range_base_address;
+		hdp->hd_address = ioremap(fixmem32->range_base_address,
+						HPET_RANGE_SIZE);
+
+		for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
+			if (hpetp->hp_hpet == hdp->hd_address) {
+				return -EBUSY;
+			}
 	} else if (res->id == ACPI_RSTYPE_EXT_IRQ) {
 		struct acpi_resource_ext_irq *irqp;
 		int i;


---

