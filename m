Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbTF0Ps2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 11:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTF0Ps2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 11:48:28 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:49308 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S264455AbTF0PsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 11:48:25 -0400
Message-ID: <3EFC6A9E.28E47F4@hp.com>
Date: Fri, 27 Jun 2003 10:02:38 -0600
From: Alex Williamson <alex_williamson@hp.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.21-rc8-aw-ob500 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Disable sba_iommu bypass to be compatible with bio-level block 
 merging
Content-Type: multipart/mixed;
 boundary="------------760F202770F566054DA87E2F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------760F202770F566054DA87E2F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


   This patch works around a problem that David Mosberger
discovered prior to his 2.5.72 ia64 patch release.  The
zx1 iommu driver has an optimization to allow devices that
can DMA directly to a memory address to completely bypass
the iommu.  For sg mappings, we skip the coalescing and
everything.  Effectively, this looks like a mixed bus system
and I don't see how to handle that with the current bio code.
IMHO, this really doesn't seem like an extraordinary
situation and I'm sure there are other platforms that might
hit it as well.

  For now it seems like the best way to make things happy is
to disable the bypass feature and force all DMA to be mapped
through the iommu.  The attached patch is against David's
last 2.5.72 ia64 patch.  Much thanks to Grant Grundler for
really diving into this and discovering what was happening.
Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab
--------------760F202770F566054DA87E2F
Content-Type: text/plain; charset=us-ascii;
 name="sba_iommu-bypass-disable.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sba_iommu-bypass-disable.diff"

--- linux-2.5.72-orig/include/asm-ia64/io.h	2003-06-20 14:40:35.000000000 -0600
+++ linux-2.5.72/include/asm-ia64/io.h	2003-06-27 09:12:44.000000000 -0600
@@ -424,6 +424,6 @@
  * which is precisely what we want.
  */
 extern unsigned long ia64_max_iommu_merge_mask;
-#define BIO_VMERGE_BOUNDARY	(0UL)//(ia64_max_iommu_merge_mask + 1)
+#define BIO_VMERGE_BOUNDARY	(ia64_max_iommu_merge_mask + 1)
 
 #endif /* _ASM_IA64_IO_H */
--- linux-2.5.72-orig/arch/ia64/hp/common/sba_iommu.c	2003-06-20 14:40:31.000000000 -0600
+++ linux-2.5.72/arch/ia64/hp/common/sba_iommu.c	2003-06-27 09:09:50.000000000 -0600
@@ -47,8 +47,11 @@
 /*
 ** This option allows cards capable of 64bit DMA to bypass the IOMMU.  If
 ** not defined, all DMA will be 32bit and go through the TLB.
+** The bio merge code currently expects that if we tweak that vmerge
+** boundary that we will alway coalesce blocks on that boundary.  Enabling
+** this optimization is therefore incompatible with tuning the boundary.
 */
-#define ALLOW_IOV_BYPASS
+#undef ALLOW_IOV_BYPASS
 
 /*
 ** If a device prefetches beyond the end of a valid pdir entry, it will cause

--------------760F202770F566054DA87E2F--

