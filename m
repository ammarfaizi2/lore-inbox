Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264798AbUFLN7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264798AbUFLN7R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 09:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264801AbUFLN7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 09:59:17 -0400
Received: from zero.aec.at ([193.170.194.10]:16389 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264798AbUFLN6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 09:58:22 -0400
To: David Ford <david+challenge-response@blue-labs.org>
cc: akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [culprit found] Re: [boot hang] 2.6.7-rc2, VIA VT8237
References: <23tuk-7Os-7@gated-at.bofh.it> <23tDX-7UV-17@gated-at.bofh.it>
	<23tNH-834-27@gated-at.bofh.it> <23wix-1FP-19@gated-at.bofh.it>
	<2652y-760-19@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 12 Jun 2004 15:58:17 +0200
In-Reply-To: <2652y-760-19@gated-at.bofh.it> (David Ford's message of "Sat,
 12 Jun 2004 03:00:18 +0200")
Message-ID: <m34qpgzxmu.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford <david+challenge-response@blue-labs.org> writes:

> Culprit found.  If CONFIG_IOMMU_DEBUG is enabled, the machine will
> hang on boot at the partition check when using the VIA driver.

The real culprit is buggy VIA silicon. Use this patch.

-Andi

---------------------------------------------------------------
Enable VIA softmmu workaround for iommu=force/IOMMU_DEBUG too

diff -u linux-2.6.7rc3-bk3/arch/x86_64/kernel/io_apic.c-o linux-2.6.7rc3-bk3/arch/x86_64/kernel/io_apic.c
--- linux-2.6.7rc3-bk3/arch/x86_64/kernel/io_apic.c-o	2004-06-11 03:02:42.000000000 +0200
+++ linux-2.6.7rc3-bk3/arch/x86_64/kernel/io_apic.c	2004-06-12 15:46:35.000000000 +0200
@@ -252,7 +252,8 @@
 				switch (vendor) { 
 				case PCI_VENDOR_ID_VIA:
 #ifdef CONFIG_GART_IOMMU
-					if (end_pfn >= (0xffffffff>>PAGE_SHIFT) &&
+					if ((end_pfn >= (0xffffffff>>PAGE_SHIFT) ||
+					     force_iommu) &&
 					    !iommu_aperture_allowed) {
 						printk(KERN_INFO
     "Looks like a VIA chipset. Disabling IOMMU. Overwrite with \"iommu=allowed\"\n");

