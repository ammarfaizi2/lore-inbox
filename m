Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVADEqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVADEqi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 23:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVADEqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 23:46:37 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:22472 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262036AbVADEny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 23:43:54 -0500
Date: Tue, 4 Jan 2005 15:08:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/11] PPC64: remove the page table size from the naca
Message-Id: <20050104150833.5d3f3722.sfr@canb.auug.org.au>
In-Reply-To: <20050104150410.199b132e.sfr@canb.auug.org.au>
References: <20050104145356.4d5333dd.sfr@canb.auug.org.au>
	<20050104150410.199b132e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__4_Jan_2005_15_08_33_+1100_krhh3rMOo8D=qyh_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__4_Jan_2005_15_08_33_+1100_krhh3rMOo8D=qyh_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch just removes the page table size field from the naca (and makes
it ppc64_pft_size instead).

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk-naca.1/arch/ppc64/kernel/pSeries_lpar.c linus-bk-naca.2/arch/ppc64/kernel/pSeries_lpar.c
--- linus-bk-naca.1/arch/ppc64/kernel/pSeries_lpar.c	2004-12-14 04:07:06.000000000 +1100
+++ linus-bk-naca.2/arch/ppc64/kernel/pSeries_lpar.c	2004-12-31 15:16:48.000000000 +1100
@@ -33,7 +33,6 @@
 #include <asm/mmu_context.h>
 #include <asm/ppcdebug.h>
 #include <asm/iommu.h>
-#include <asm/naca.h>
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <asm/prom.h>
@@ -368,7 +367,7 @@
 
 static void pSeries_lpar_hptab_clear(void)
 {
-	unsigned long size_bytes = 1UL << naca->pftSize;
+	unsigned long size_bytes = 1UL << ppc64_pft_size;
 	unsigned long hpte_count = size_bytes >> 4;
 	unsigned long dummy1, dummy2;
 	int i;
diff -ruN linus-bk-naca.1/arch/ppc64/kernel/prom.c linus-bk-naca.2/arch/ppc64/kernel/prom.c
--- linus-bk-naca.1/arch/ppc64/kernel/prom.c	2004-11-26 12:08:51.000000000 +1100
+++ linus-bk-naca.2/arch/ppc64/kernel/prom.c	2004-12-31 14:52:56.000000000 +1100
@@ -844,12 +844,12 @@
 
 	/* On LPAR, look for the first ibm,pft-size property for the  hash table size
 	 */
-	if (systemcfg->platform == PLATFORM_PSERIES_LPAR && naca->pftSize == 0) {
+	if (systemcfg->platform == PLATFORM_PSERIES_LPAR && ppc64_pft_size == 0) {
 		u32 *pft_size;
 		pft_size = (u32 *)get_flat_dt_prop(node, "ibm,pft-size", NULL);
 		if (pft_size != NULL) {
 			/* pft_size[0] is the NUMA CEC cookie */
-			naca->pftSize = pft_size[1];
+			ppc64_pft_size = pft_size[1];
 		}
 	}
 
@@ -1018,7 +1018,7 @@
 	initial_boot_params = params;
 
 	/* By default, hash size is not set */
-	naca->pftSize = 0;
+	ppc64_pft_size = 0;
 
 	/* Retreive various informations from the /chosen node of the
 	 * device-tree, including the platform type, initrd location and
@@ -1047,7 +1047,7 @@
 	/* If hash size wasn't obtained above, we calculate it now based on
 	 * the total RAM size
 	 */
-	if (naca->pftSize == 0) {
+	if (ppc64_pft_size == 0) {
 		unsigned long rnd_mem_size, pteg_count;
 
 		/* round mem_size up to next power of 2 */
@@ -1058,10 +1058,10 @@
 		/* # pages / 2 */
 		pteg_count = (rnd_mem_size >> (12 + 1));
 
-		naca->pftSize = __ilog2(pteg_count << 7);
+		ppc64_pft_size = __ilog2(pteg_count << 7);
 	}
 
-	DBG("Hash pftSize: %x\n", (int)naca->pftSize);
+	DBG("Hash pftSize: %x\n", (int)ppc64_pft_size);
 	DBG(" <- early_init_devtree()\n");
 }
 
diff -ruN linus-bk-naca.1/arch/ppc64/kernel/setup.c linus-bk-naca.2/arch/ppc64/kernel/setup.c
--- linus-bk-naca.1/arch/ppc64/kernel/setup.c	2004-12-31 16:22:00.000000000 +1100
+++ linus-bk-naca.2/arch/ppc64/kernel/setup.c	2004-12-31 16:22:49.000000000 +1100
@@ -55,6 +55,7 @@
 #include <asm/iommu.h>
 #include <asm/serial.h>
 #include <asm/cache.h>
+#include <asm/page.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -111,6 +112,7 @@
 int boot_cpuid = 0;
 int boot_cpuid_phys = 0;
 dev_t boot_dev;
+u64 ppc64_pft_size;
 
 struct ppc64_caches ppc64_caches;
 
@@ -660,7 +662,7 @@
 
 	printk("-----------------------------------------------------\n");
 	printk("naca                          = 0x%p\n", naca);
-	printk("naca->pftSize                 = 0x%lx\n", naca->pftSize);
+	printk("ppc64_pft_size                = 0x%lx\n", ppc64_pft_size);
 	printk("naca->debug_switch            = 0x%lx\n", naca->debug_switch);
 	printk("naca->interrupt_controller    = 0x%ld\n", naca->interrupt_controller);
 	printk("systemcfg                     = 0x%p\n", systemcfg);
diff -ruN linus-bk-naca.1/arch/ppc64/mm/hash_utils.c linus-bk-naca.2/arch/ppc64/mm/hash_utils.c
--- linus-bk-naca.1/arch/ppc64/mm/hash_utils.c	2004-10-29 07:03:21.000000000 +1000
+++ linus-bk-naca.2/arch/ppc64/mm/hash_utils.c	2004-12-31 14:52:56.000000000 +1100
@@ -41,7 +41,6 @@
 #include <asm/types.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
-#include <asm/naca.h>
 #include <asm/machdep.h>
 #include <asm/lmb.h>
 #include <asm/abs_addr.h>
@@ -147,7 +146,7 @@
 	 * Calculate the required size of the htab.  We want the number of
 	 * PTEGs to equal one half the number of real pages.
 	 */ 
-	htab_size_bytes = 1UL << naca->pftSize;
+	htab_size_bytes = 1UL << ppc64_pft_size;
 	pteg_count = htab_size_bytes >> 7;
 
 	/* For debug, make the HTAB 1/8 as big as it normally would be. */
diff -ruN linus-bk-naca.1/include/asm-ppc64/naca.h linus-bk-naca.2/include/asm-ppc64/naca.h
--- linus-bk-naca.1/include/asm-ppc64/naca.h	2004-12-31 14:52:14.000000000 +1100
+++ linus-bk-naca.2/include/asm-ppc64/naca.h	2004-12-31 14:52:56.000000000 +1100
@@ -26,8 +26,6 @@
 	u64 log;                        /* Ptr to log buffer         0x30 */
 	u64 serialPortAddr;		/* Phy addr of serial port   0x38 */
 	u64 interrupt_controller;	/* Type of int controller    0x40 */ 
-	u64 unused1;			/* was SLB size in entries   0x48 */
-	u64 pftSize;			/* Log 2 of page table size  0x50 */
 };
 
 extern struct naca_struct *naca;
diff -ruN linus-bk-naca.1/include/asm-ppc64/page.h linus-bk-naca.2/include/asm-ppc64/page.h
--- linus-bk-naca.1/include/asm-ppc64/page.h	2004-12-31 14:52:14.000000000 +1100
+++ linus-bk-naca.2/include/asm-ppc64/page.h	2004-12-31 14:52:56.000000000 +1100
@@ -183,6 +183,8 @@
 
 extern int page_is_ram(unsigned long pfn);
 
+extern u64 ppc64_pft_size;		/* Log 2 of page table size */
+
 #endif /* __ASSEMBLY__ */
 
 #ifdef MODULE

--Signature=_Tue__4_Jan_2005_15_08_33_+1100_krhh3rMOo8D=qyh_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2hbB4CJfqux9a+8RAmUnAKCFHIPEJZoYFmyqlvPBrcZ+enqKpgCeK+jX
beij9WKMtjEV/NCsSQkp9qk=
=M2Wg
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Jan_2005_15_08_33_+1100_krhh3rMOo8D=qyh_--
