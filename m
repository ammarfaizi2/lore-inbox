Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWEIUak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWEIUak (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWEIUak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:30:40 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:33463 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751147AbWEIUai
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:30:38 -0400
Date: Tue, 9 May 2006 15:29:18 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, linux-kernel@vger.kernel.org,
       ak@suse.de, linux-ia64@vger.kernel.org, mulix@mulix.org
Subject: Re: [PATCH 2/3] swiotlb: create __alloc_bootmem_low_nopanic and add support in SWIOTLB
Message-ID: <20060509202918.GC22385@us.ibm.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0670355D@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0670355D@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 04:28:07PM -0700, Luck, Tony wrote:
> Jon,
> 
> Trailing white space added by part2 and part3 annoys "git" (29
> total places between the two parts).

Oops.  I'll fix that with the next release (in the next few hours or
so).

> 
> Generic builds (based on arch/ia64/defconfig or arch/ia64/configs/gensparse_defconfig)
> throws out 3 warnings, one each from arch/ia64/hp/zx1/hpzx1_machvec.c,
> arch/ia64/hp/zx1/hpzx1_swiotlb_machvec.c and arch/ia64/sn/kernel/machvec.c
> 
> include/asm/machvec_init.h:32: warning: initialization from incompatible pointer type
> 
> The problems is "platform_dma_init" which can be defined as
> "machvec_noop()" which returns "void", not "int" at required
> by your change to the ia64_mv_dma_init type.

I "fixed" it with the hack below.  Please let me know if this is not
palatable for you.

> On the plus side it does boot on ia64 Intel Tiger ... but more of
> the fancier bits of this code are used by the zx1 and zx1_swiotlb
> versions which I didn't get time to test today.

Fantastic!  I appreciate you taking the time to look at and test these
patches.  

Thanks,
Jon

> 
> -Tony


diff -r 99976643895a include/asm-ia64/machvec.h
--- a/include/asm-ia64/machvec.h	Tue May  2 23:10:14 2006
+++ b/include/asm-ia64/machvec.h	Tue May  9 14:50:17 2006
@@ -77,9 +77,15 @@
 typedef unsigned int ia64_mv_readl_relaxed_t (const volatile void __iomem *);
 typedef unsigned long ia64_mv_readq_relaxed_t (const volatile void __iomem *);
 
-static inline void
+static inline void 
 machvec_noop (void)
 {
+}
+
+static inline int 
+machvec_noop_dma (void)
+{
+	return 0;
 }
 
 static inline void
diff -r 99976643895a include/asm-ia64/machvec_hpzx1.h
--- a/include/asm-ia64/machvec_hpzx1.h	Tue May  2 23:10:14 2006
+++ b/include/asm-ia64/machvec_hpzx1.h	Tue May  9 14:50:17 2006
@@ -20,7 +20,7 @@
  */
 #define platform_name				"hpzx1"
 #define platform_setup				dig_setup
-#define platform_dma_init			machvec_noop
+#define platform_dma_init			machvec_noop_dma
 #define platform_dma_alloc_coherent		sba_alloc_coherent
 #define platform_dma_free_coherent		sba_free_coherent
 #define platform_dma_map_single			sba_map_single
diff -r 99976643895a include/asm-ia64/machvec_hpzx1_swiotlb.h
--- a/include/asm-ia64/machvec_hpzx1_swiotlb.h	Tue May  2 23:10:14 2006
+++ b/include/asm-ia64/machvec_hpzx1_swiotlb.h	Tue May  9 14:50:17 2006
@@ -25,7 +25,7 @@
 #define platform_name				"hpzx1_swiotlb"
 
 #define platform_setup				dig_setup
-#define platform_dma_init			machvec_noop
+#define platform_dma_init			machvec_noop_dma
 #define platform_dma_alloc_coherent		hwsw_alloc_coherent
 #define platform_dma_free_coherent		hwsw_free_coherent
 #define platform_dma_map_single			hwsw_map_single
diff -r 99976643895a include/asm-ia64/machvec_sn2.h
--- a/include/asm-ia64/machvec_sn2.h	Tue May  2 23:10:14 2006
+++ b/include/asm-ia64/machvec_sn2.h	Tue May  9 14:50:17 2006
@@ -103,7 +103,7 @@
 #define platform_pci_get_legacy_mem	sn_pci_get_legacy_mem
 #define platform_pci_legacy_read	sn_pci_legacy_read
 #define platform_pci_legacy_write	sn_pci_legacy_write
-#define platform_dma_init		machvec_noop
+#define platform_dma_init		machvec_noop_dma
 #define platform_dma_alloc_coherent	sn_dma_alloc_coherent
 #define platform_dma_free_coherent	sn_dma_free_coherent
 #define platform_dma_map_single		sn_dma_map_single

