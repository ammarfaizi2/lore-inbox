Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVADMGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVADMGH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 07:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVADMGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 07:06:07 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:23776 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261391AbVADMFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 07:05:04 -0500
Date: Tue, 4 Jan 2005 23:05:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org, paulus@samba.org,
       anton@samba.org
Subject: [PATCH] PPC64: tidy up the htab_data structure
Message-Id: <20050104230508.13dd0df4.sfr@canb.auug.org.au>
In-Reply-To: <20050104225809.4b265440.sfr@canb.auug.org.au>
References: <20050104145356.4d5333dd.sfr@canb.auug.org.au>
	<20050104150410.199b132e.sfr@canb.auug.org.au>
	<20050104150833.5d3f3722.sfr@canb.auug.org.au>
	<20050104151229.521e8083.sfr@canb.auug.org.au>
	<20050104151906.6e50f1d2.sfr@canb.auug.org.au>
	<20050104152340.67219ccf.sfr@canb.auug.org.au>
	<20050104152705.6030abc5.sfr@canb.auug.org.au>
	<20050104153102.67284491.sfr@canb.auug.org.au>
	<20050104153445.3777e689.sfr@canb.auug.org.au>
	<20050104153740.56622b4f.sfr@canb.auug.org.au>
	<20050104154025.63a1b9fb.sfr@canb.auug.org.au>
	<20050104154319.505b1197.sfr@canb.auug.org.au>
	<20050104225809.4b265440.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__4_Jan_2005_23_05_08_+1100_GqDFz2p5hd6B4.tj"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__4_Jan_2005_23_05_08_+1100_GqDFz2p5hd6B4.tj
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

More tidying up.

The htab_data structure contained 5 fields or which two were completely
unused and one other was just kept for printing at boot time.  I have mode
the remaining two into global variables.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Built and booted on iSeries (which is always lpar) and on pSeries without
partitioning.

Please apply.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk-sfr.12/arch/ppc64/kernel/iSeries_setup.c linus-bk-sfr.13/arch/ppc64/kernel/iSeries_setup.c
--- linus-bk-sfr.12/arch/ppc64/kernel/iSeries_setup.c	2004-12-13 15:31:14.000000000 +1100
+++ linus-bk-sfr.13/arch/ppc64/kernel/iSeries_setup.c	2005-01-04 19:01:54.000000000 +1100
@@ -472,18 +472,16 @@
 	printk("HPT absolute addr = %016lx, size = %dK\n",
 			chunk_to_addr(hptFirstChunk), hptSizeChunks * 256);
 
-	/* Fill in the htab_data structure */
-	/* Fill in size of hashed page table */
+	/* Fill in the hashed page table hash mask */
 	num_ptegs = hptSizePages *
 		(PAGE_SIZE / (sizeof(HPTE) * HPTES_PER_GROUP));
-	htab_data.htab_num_ptegs = num_ptegs;
-	htab_data.htab_hash_mask = num_ptegs - 1;
+	htab_hash_mask = num_ptegs - 1;
 	
 	/*
 	 * The actual hashed page table is in the hypervisor,
 	 * we have no direct access
 	 */
-	htab_data.htab = NULL;
+	htab_address = NULL;
 
 	/*
 	 * Determine if absolute memory has any
diff -ruN linus-bk-sfr.12/arch/ppc64/kernel/pSeries_lpar.c linus-bk-sfr.13/arch/ppc64/kernel/pSeries_lpar.c
--- linus-bk-sfr.12/arch/ppc64/kernel/pSeries_lpar.c	2004-12-31 15:16:48.000000000 +1100
+++ linus-bk-sfr.13/arch/ppc64/kernel/pSeries_lpar.c	2005-01-04 19:00:17.000000000 +1100
@@ -436,7 +436,7 @@
 	hash = hpt_hash(vpn, 0);
 
 	for (j = 0; j < 2; j++) {
-		slot = (hash & htab_data.htab_hash_mask) * HPTES_PER_GROUP;
+		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		for (i = 0; i < HPTES_PER_GROUP; i++) {
 			hpte_dw0.dword0 = pSeries_lpar_hpte_getword0(slot);
 			dw0 = hpte_dw0.dw0;
diff -ruN linus-bk-sfr.12/arch/ppc64/kernel/setup.c linus-bk-sfr.13/arch/ppc64/kernel/setup.c
--- linus-bk-sfr.12/arch/ppc64/kernel/setup.c	2004-12-31 16:24:11.000000000 +1100
+++ linus-bk-sfr.13/arch/ppc64/kernel/setup.c	2005-01-04 18:58:58.000000000 +1100
@@ -55,6 +55,7 @@
 #include <asm/serial.h>
 #include <asm/cache.h>
 #include <asm/page.h>
+#include <asm/mmu.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -90,7 +91,6 @@
 #endif
 
 /* extern void *stab; */
-extern HTAB htab_data;
 extern unsigned long klimit;
 
 extern void mm_init_ppc64(void);
@@ -672,8 +672,8 @@
 			ppc64_caches.dline_size);
 	printk("ppc64_caches.icache_line_size = 0x%x\n",
 			ppc64_caches.iline_size);
-	printk("htab_data.htab                = 0x%p\n", htab_data.htab);
-	printk("htab_data.num_ptegs           = 0x%lx\n", htab_data.htab_num_ptegs);
+	printk("htab_address                  = 0x%p\n", htab_address);
+	printk("htab_hash_mask                = 0x%lx\n", htab_hash_mask);
 	printk("-----------------------------------------------------\n");
 
 	mm_init_ppc64();
diff -ruN linus-bk-sfr.12/arch/ppc64/mm/hash_low.S linus-bk-sfr.13/arch/ppc64/mm/hash_low.S
--- linus-bk-sfr.12/arch/ppc64/mm/hash_low.S	2004-10-14 18:37:37.000000000 +1000
+++ linus-bk-sfr.13/arch/ppc64/mm/hash_low.S	2005-01-04 19:06:24.000000000 +1100
@@ -139,8 +139,8 @@
 	std	r3,STK_PARM(r4)(r1)
 
 	/* Get htab_hash_mask */
-	ld	r4,htab_data@got(2)
-	ld	r27,16(r4)	/* htab_data.htab_hash_mask -> r27 */
+	ld	r4,htab_hash_mask@got(2)
+	ld	r27,0(r4)	/* htab_hash_mask -> r27 */
 
 	/* Check if we may already be in the hashtable, in this case, we
 	 * go to out-of-line code to try to modify the HPTE
diff -ruN linus-bk-sfr.12/arch/ppc64/mm/hash_native.c linus-bk-sfr.13/arch/ppc64/mm/hash_native.c
--- linus-bk-sfr.12/arch/ppc64/mm/hash_native.c	2004-11-16 16:05:10.000000000 +1100
+++ linus-bk-sfr.13/arch/ppc64/mm/hash_native.c	2005-01-04 19:09:45.000000000 +1100
@@ -52,7 +52,7 @@
 			unsigned long hpteflags, int bolted, int large)
 {
 	unsigned long arpn = physRpn_to_absRpn(prpn);
-	HPTE *hptep = htab_data.htab + hpte_group;
+	HPTE *hptep = htab_address + hpte_group;
 	Hpte_dword0 dw0;
 	HPTE lhpte;
 	int i;
@@ -117,7 +117,7 @@
 	slot_offset = mftb() & 0x7;
 
 	for (i = 0; i < HPTES_PER_GROUP; i++) {
-		hptep = htab_data.htab + hpte_group + slot_offset;
+		hptep = htab_address + hpte_group + slot_offset;
 		dw0 = hptep->dw0.dw0;
 
 		if (dw0.v && !dw0.bolted) {
@@ -172,9 +172,9 @@
 	hash = hpt_hash(vpn, 0);
 
 	for (j = 0; j < 2; j++) {
-		slot = (hash & htab_data.htab_hash_mask) * HPTES_PER_GROUP;
+		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		for (i = 0; i < HPTES_PER_GROUP; i++) {
-			hptep = htab_data.htab + slot;
+			hptep = htab_address + slot;
 			dw0 = hptep->dw0.dw0;
 
 			if ((dw0.avpn == (vpn >> 11)) && dw0.v &&
@@ -195,7 +195,7 @@
 static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 				 unsigned long va, int large, int local)
 {
-	HPTE *hptep = htab_data.htab + slot;
+	HPTE *hptep = htab_address + slot;
 	Hpte_dword0 dw0;
 	unsigned long avpn = va >> 23;
 	int ret = 0;
@@ -254,7 +254,7 @@
 	slot = native_hpte_find(vpn);
 	if (slot == -1)
 		panic("could not find page to bolt\n");
-	hptep = htab_data.htab + slot;
+	hptep = htab_address + slot;
 
 	set_pp_bit(newpp, hptep);
 
@@ -269,7 +269,7 @@
 static void native_hpte_invalidate(unsigned long slot, unsigned long va,
 				    int large, int local)
 {
-	HPTE *hptep = htab_data.htab + slot;
+	HPTE *hptep = htab_address + slot;
 	Hpte_dword0 dw0;
 	unsigned long avpn = va >> 23;
 	unsigned long flags;
@@ -336,10 +336,10 @@
 		secondary = (pte_val(batch->pte[i]) & _PAGE_SECONDARY) >> 15;
 		if (secondary)
 			hash = ~hash;
-		slot = (hash & htab_data.htab_hash_mask) * HPTES_PER_GROUP;
+		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += (pte_val(batch->pte[i]) & _PAGE_GROUP_IX) >> 12;
 
-		hptep = htab_data.htab + slot;
+		hptep = htab_address + slot;
 
 		avpn = va >> 23;
 		if (large)
diff -ruN linus-bk-sfr.12/arch/ppc64/mm/hash_utils.c linus-bk-sfr.13/arch/ppc64/mm/hash_utils.c
--- linus-bk-sfr.12/arch/ppc64/mm/hash_utils.c	2004-12-31 14:52:56.000000000 +1100
+++ linus-bk-sfr.13/arch/ppc64/mm/hash_utils.c	2005-01-04 19:08:37.000000000 +1100
@@ -74,7 +74,8 @@
 extern unsigned long dart_tablebase;
 #endif /* CONFIG_U3_DART */
 
-HTAB htab_data = {NULL, 0, 0, 0, 0};
+HPTE		*htab_address;
+unsigned long	htab_hash_mask;
 
 extern unsigned long _SDR1;
 
@@ -113,7 +114,7 @@
 
 		hash = hpt_hash(vpn, large);
 
-		hpteg = ((hash & htab_data.htab_hash_mask)*HPTES_PER_GROUP);
+		hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
 
 #ifdef CONFIG_PPC_PSERIES
 		if (systemcfg->platform & PLATFORM_LPAR)
@@ -155,12 +156,11 @@
 		htab_size_bytes = pteg_count << 7;
 	}
 
-	htab_data.htab_num_ptegs = pteg_count;
-	htab_data.htab_hash_mask = pteg_count - 1;
+	htab_hash_mask = pteg_count - 1;
 
 	if (systemcfg->platform & PLATFORM_LPAR) {
 		/* Using a hypervisor which owns the htab */
-		htab_data.htab = NULL;
+		htab_address = NULL;
 		_SDR1 = 0; 
 	} else {
 		/* Find storage for the HPT.  Must be contiguous in
@@ -175,7 +175,7 @@
 			ppc64_terminate_msg(0x20, "hpt space");
 			loop_forever();
 		}
-		htab_data.htab = abs_to_virt(table);
+		htab_address = abs_to_virt(table);
 
 		/* htab absolute addr + encoded htabsize */
 		_SDR1 = table + __ilog2(pteg_count) - 11;
@@ -356,7 +356,7 @@
 	secondary = (pte_val(pte) & _PAGE_SECONDARY) >> 15;
 	if (secondary)
 		hash = ~hash;
-	slot = (hash & htab_data.htab_hash_mask) * HPTES_PER_GROUP;
+	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 	slot += (pte_val(pte) & _PAGE_GROUP_IX) >> 12;
 
 	ppc_md.hpte_invalidate(slot, va, huge, local);
diff -ruN linus-bk-sfr.12/arch/ppc64/mm/hugetlbpage.c linus-bk-sfr.13/arch/ppc64/mm/hugetlbpage.c
--- linus-bk-sfr.12/arch/ppc64/mm/hugetlbpage.c	2004-10-29 07:03:21.000000000 +1000
+++ linus-bk-sfr.13/arch/ppc64/mm/hugetlbpage.c	2005-01-04 19:02:45.000000000 +1100
@@ -832,7 +832,7 @@
 		hash = hpt_hash(vpn, 1);
 		if (pte_val(old_pte) & _PAGE_SECONDARY)
 			hash = ~hash;
-		slot = (hash & htab_data.htab_hash_mask) * HPTES_PER_GROUP;
+		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += (pte_val(old_pte) & _PAGE_GROUP_IX) >> 12;
 
 		if (ppc_md.hpte_updatepp(slot, hpteflags, va, 1, local) == -1)
@@ -846,7 +846,7 @@
 		prpn = pte_pfn(old_pte);
 
 repeat:
-		hpte_group = ((hash & htab_data.htab_hash_mask) *
+		hpte_group = ((hash & htab_hash_mask) *
 			      HPTES_PER_GROUP) & ~0x7UL;
 
 		/* Update the linux pte with the HPTE slot */
@@ -863,13 +863,13 @@
 		/* Primary is full, try the secondary */
 		if (unlikely(slot == -1)) {
 			pte_val(new_pte) |= _PAGE_SECONDARY;
-			hpte_group = ((~hash & htab_data.htab_hash_mask) *
+			hpte_group = ((~hash & htab_hash_mask) *
 				      HPTES_PER_GROUP) & ~0x7UL; 
 			slot = ppc_md.hpte_insert(hpte_group, va, prpn,
 						  1, hpteflags, 0, 1);
 			if (slot == -1) {
 				if (mftb() & 0x1)
-					hpte_group = ((hash & htab_data.htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+					hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
 
 				ppc_md.hpte_remove(hpte_group);
 				goto repeat;
diff -ruN linus-bk-sfr.12/arch/ppc64/mm/init.c linus-bk-sfr.13/arch/ppc64/mm/init.c
--- linus-bk-sfr.12/arch/ppc64/mm/init.c	2004-12-10 16:26:54.000000000 +1100
+++ linus-bk-sfr.13/arch/ppc64/mm/init.c	2005-01-04 19:03:14.000000000 +1100
@@ -168,7 +168,7 @@
 
 		hash = hpt_hash(vpn, 0);
 
-		hpteg = ((hash & htab_data.htab_hash_mask)*HPTES_PER_GROUP);
+		hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
 
 		/* Panic if a pte grpup is full */
 		if (ppc_md.hpte_insert(hpteg, va, pa >> PAGE_SHIFT, 0,
diff -ruN linus-bk-sfr.12/include/asm-ppc64/mmu.h linus-bk-sfr.13/include/asm-ppc64/mmu.h
--- linus-bk-sfr.12/include/asm-ppc64/mmu.h	2004-10-29 07:03:22.000000000 +1000
+++ linus-bk-sfr.13/include/asm-ppc64/mmu.h	2005-01-04 19:10:32.000000000 +1100
@@ -98,15 +98,8 @@
 #define PP_RXRX 3	/* Supervisor read,       User read */
 
 
-typedef struct {
-	HPTE *		htab;
-	unsigned long	htab_num_ptegs;
-	unsigned long	htab_hash_mask;
-	unsigned long	next_round_robin;
-	unsigned long   last_kernel_address;
-} HTAB;
-
-extern HTAB htab_data;
+extern HPTE *		htab_address;
+extern unsigned long	htab_hash_mask;
 
 static inline unsigned long hpt_hash(unsigned long vpn, int large)
 {

--Signature=_Tue__4_Jan_2005_23_05_08_+1100_GqDFz2p5hd6B4.tj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2oZ04CJfqux9a+8RAobZAJkBBPZm/AIEqNVktpmp5cRmh6DRHwCfYTjx
rVdP+02irXTJSSQMCrije+I=
=vp8I
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Jan_2005_23_05_08_+1100_GqDFz2p5hd6B4.tj--
