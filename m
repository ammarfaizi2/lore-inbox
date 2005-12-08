Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030452AbVLHEPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbVLHEPR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 23:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbVLHEPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 23:15:16 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:53976 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030452AbVLHEPP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 23:15:15 -0500
Date: Thu, 8 Dec 2005 09:45:09 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>, len.brown@intel.com
Subject: [PATCH] x86_64: acpi map table fix
Message-ID: <20051208041509.GA4841@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Memory till end_pfn_map has been directly mapped. So all the memory
  references to the last page (represented by end_pfn_map) should be
  valid.

o I run into problem with kdump when I use memmap=exactmap option and also
  pass memmap=X#Y to directly map acpi tables. ACPI initialization in second
  kernel fails because some of the valid ACPI memory is not accessible.

o /proc/iomem shows ACPI tables at c7fcb940-c7fcf7ff : ACPI Tables. Here
  end_pfn_map is set to c7fcf000. But c7fcf700 should also be a valid access.  

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---


diff -puN arch/i386/kernel/acpi/boot.c~acpi-map-address-fix arch/i386/kernel/acpi/boot.c
--- linux-2.6.15-rc5-mm1-16M/arch/i386/kernel/acpi/boot.c~acpi-map-address-fix	2005-12-07 15:56:33.000000000 +0530
+++ linux-2.6.15-rc5-mm1-16M-root/arch/i386/kernel/acpi/boot.c	2005-12-07 15:58:04.000000000 +0530
@@ -108,7 +108,7 @@ char *__acpi_map_table(unsigned long phy
 	if (!phys_addr || !size)
 		return NULL;
 
-	if (phys_addr < (end_pfn_map << PAGE_SHIFT))
+	if (phys_addr < ((end_pfn_map << PAGE_SHIFT) + PAGE_SIZE))
 		return __va(phys_addr);
 
 	return NULL;
_
