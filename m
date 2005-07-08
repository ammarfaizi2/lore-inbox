Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbVGHErS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbVGHErS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 00:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVGHErS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 00:47:18 -0400
Received: from ozlabs.org ([203.10.76.45]:62443 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262605AbVGHErO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 00:47:14 -0400
Date: Fri, 8 Jul 2005 14:46:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PPC64] Kill bitfields in ppc64 hash code
Message-ID: <20050708044653.GC30761@localhost.localdomain>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

This patch removes the use of bitfield types from the ppc64 hash table
manipulation code.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

 arch/ppc64/kernel/iSeries_htab.c      |   50 +++++--------
 arch/ppc64/kernel/pSeries_lpar.c      |   49 ++++--------
 arch/ppc64/mm/hash_low.S              |    8 --
 arch/ppc64/mm/hash_native.c           |  129 +++++++++++++++-------------------
 arch/ppc64/mm/hash_utils.c	       |   16 ++--
 arch/ppc64/mm/hugetlbpage.c           |   16 ++--
 arch/ppc64/mm/init.c                  |    7 +
 include/asm-ppc64/iSeries/HvCallHpt.h |   11 +-
 include/asm-ppc64/machdep.h           |    6 -
 include/asm-ppc64/mmu.h               |   83 +++++++--------------
 10 files changed, 157 insertions(+), 218 deletions(-)

Index: working-2.6/arch/ppc64/kernel/iSeries_htab.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/iSeries_htab.c	2005-06-08 15:37:37.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/iSeries_htab.c	2005-07-08 13:06:14.000000000 +1000
@@ -38,11 +38,12 @@
 }
 
 static long iSeries_hpte_insert(unsigned long hpte_group, unsigned long va,
-			 unsigned long prpn, int secondary,
-			 unsigned long hpteflags, int bolted, int large)
+				unsigned long prpn, unsigned long vflags,
+				unsigned long rflags)
 {
 	long slot;
-	HPTE lhpte;
+	hpte_t lhpte;
+	int secondary = 0;
 
 	/*
 	 * The hypervisor tries both primary and secondary.
@@ -50,13 +51,13 @@
 	 * it means we have already tried both primary and secondary,
 	 * so we return failure immediately.
 	 */
-	if (secondary)
+	if (vflags & HPTE_V_SECONDARY)
 		return -1;
 
 	iSeries_hlock(hpte_group);
 
 	slot = HvCallHpt_findValid(&lhpte, va >> PAGE_SHIFT);
-	BUG_ON(lhpte.dw0.dw0.v);
+	BUG_ON(lhpte.v & HPTE_V_VALID);
 
 	if (slot == -1)	{ /* No available entry found in either group */
 		iSeries_hunlock(hpte_group);
@@ -64,19 +65,13 @@
 	}
 
 	if (slot < 0) {		/* MSB set means secondary group */
+		vflags |= HPTE_V_VALID;
 		secondary = 1;
 		slot &= 0x7fffffffffffffff;
 	}
 
-	lhpte.dw1.dword1      = 0;
-	lhpte.dw1.dw1.rpn     = physRpn_to_absRpn(prpn);
-	lhpte.dw1.flags.flags = hpteflags;
-
-	lhpte.dw0.dword0      = 0;
-	lhpte.dw0.dw0.avpn    = va >> 23;
-	lhpte.dw0.dw0.h       = secondary;
-	lhpte.dw0.dw0.bolted  = bolted;
-	lhpte.dw0.dw0.v       = 1;
+	hpte.v = (va >> 23) << HPTE_V_AVPN_SHIFT | vflags | HPTE_V_VALID;
+	hpte.r = (physRpn_to_absRpn(prpn) << HPTE_R_RPN_SHIFT) | rflags;
 
 	/* Now fill in the actual HPTE */
 	HvCallHpt_addValidate(slot, secondary, &lhpte);
@@ -89,19 +84,17 @@
 static unsigned long iSeries_hpte_getword0(unsigned long slot)
 {
 	unsigned long dword0;
-	HPTE hpte;
+	hpte_t hpte;
 
 	HvCallHpt_get(&hpte, slot);
-	dword0 = hpte.dw0.dword0;
-
-	return dword0;
+	return hpte.v;
 }
 
 static long iSeries_hpte_remove(unsigned long hpte_group)
 {
 	unsigned long slot_offset;
 	int i;
-	HPTE lhpte;
+	unsigned long hpte_v;
 
 	/* Pick a random slot to start at */
 	slot_offset = mftb() & 0x7;
@@ -109,10 +102,9 @@
 	iSeries_hlock(hpte_group);
 
 	for (i = 0; i < HPTES_PER_GROUP; i++) {
-		lhpte.dw0.dword0 = 
-			iSeries_hpte_getword0(hpte_group + slot_offset);
+		hpte_v = iSeries_hpte_getword0(hpte_group + slot_offset);
 
-		if (!lhpte.dw0.dw0.bolted) {
+		if (! (hpte_v & HPTE_V_BOLTED)) {
 			HvCallHpt_invalidateSetSwBitsGet(hpte_group + 
 							 slot_offset, 0, 0);
 			iSeries_hunlock(hpte_group);
@@ -137,13 +129,13 @@
 static long iSeries_hpte_updatepp(unsigned long slot, unsigned long newpp,
 				  unsigned long va, int large, int local)
 {
-	HPTE hpte;
+	hpte_t hpte;
 	unsigned long avpn = va >> 23;
 
 	iSeries_hlock(slot);
 
 	HvCallHpt_get(&hpte, slot);
-	if ((hpte.dw0.dw0.avpn == avpn) && (hpte.dw0.dw0.v)) {
+	if ((HPTE_V_AVPN_VAL(hpte.v) == avpn) && (hpte.v & HPTE_V_VALID)) {
 		/*
 		 * Hypervisor expects bits as NPPP, which is
 		 * different from how they are mapped in our PP.
@@ -167,7 +159,7 @@
  */
 static long iSeries_hpte_find(unsigned long vpn)
 {
-	HPTE hpte;
+	hpte_t hpte;
 	long slot;
 
 	/*
@@ -177,7 +169,7 @@
 	 * 0x80000000xxxxxxxx : Entry found in secondary group, slot x
 	 */
 	slot = HvCallHpt_findValid(&hpte, vpn); 
-	if (hpte.dw0.dw0.v) {
+	if (hpte.v & HPTE_V_VALID) {
 		if (slot < 0) {
 			slot &= 0x7fffffffffffffff;
 			slot = -slot;
@@ -212,7 +204,7 @@
 static void iSeries_hpte_invalidate(unsigned long slot, unsigned long va,
 				    int large, int local)
 {
-	HPTE lhpte;
+	unsigned long hpte_v;
 	unsigned long avpn = va >> 23;
 	unsigned long flags;
 
@@ -220,9 +212,9 @@
 
 	iSeries_hlock(slot);
 
-	lhpte.dw0.dword0 = iSeries_hpte_getword0(slot);
+	hpte_v = iSeries_hpte_getword0(slot);
 	
-	if ((lhpte.dw0.dw0.avpn == avpn) && lhpte.dw0.dw0.v)
+	if ((HPTE_V_AVPN_VAL(hpte_v) == avpn) && (hpte_v & HPTE_V_VALID))
 		HvCallHpt_invalidateSetSwBitsGet(slot, 0, 0);
 
 	iSeries_hunlock(slot);
Index: working-2.6/arch/ppc64/kernel/pSeries_lpar.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/pSeries_lpar.c	2005-06-08 15:37:37.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/pSeries_lpar.c	2005-07-08 13:06:14.000000000 +1000
@@ -277,31 +277,20 @@
 
 long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 			      unsigned long va, unsigned long prpn,
-			      int secondary, unsigned long hpteflags,
-			      int bolted, int large)
+			      unsigned long vflags, unsigned long rflags)
 {
 	unsigned long arpn = physRpn_to_absRpn(prpn);
 	unsigned long lpar_rc;
 	unsigned long flags;
 	unsigned long slot;
-	HPTE lhpte;
+	unsigned long hpte_v, hpte_r;
 	unsigned long dummy0, dummy1;
 
-	/* Fill in the local HPTE with absolute rpn, avpn and flags */
-	lhpte.dw1.dword1      = 0;
-	lhpte.dw1.dw1.rpn     = arpn;
-	lhpte.dw1.flags.flags = hpteflags;
-
-	lhpte.dw0.dword0      = 0;
-	lhpte.dw0.dw0.avpn    = va >> 23;
-	lhpte.dw0.dw0.h       = secondary;
-	lhpte.dw0.dw0.bolted  = bolted;
-	lhpte.dw0.dw0.v       = 1;
-
-	if (large) {
-		lhpte.dw0.dw0.l = 1;
-		lhpte.dw0.dw0.avpn &= ~0x1UL;
-	}
+	hpte_v = ((va >> 23) << HPTE_V_AVPN_SHIFT) | vflags | HPTE_V_VALID;
+	if (vflags & HPTE_V_LARGE)
+		hpte_v &= ~(1UL << HPTE_V_AVPN_SHIFT);
+
+	hpte_r = (arpn << HPTE_R_RPN_SHIFT) | rflags;
 
 	/* Now fill in the actual HPTE */
 	/* Set CEC cookie to 0         */
@@ -312,11 +301,11 @@
 	flags = 0;
 
 	/* XXX why is this here? - Anton */
-	if (hpteflags & (_PAGE_GUARDED|_PAGE_NO_CACHE))
-		lhpte.dw1.flags.flags &= ~_PAGE_COHERENT;
+	if (rflags & (_PAGE_GUARDED|_PAGE_NO_CACHE))
+		hpte_r &= ~_PAGE_COHERENT;
 
-	lpar_rc = plpar_hcall(H_ENTER, flags, hpte_group, lhpte.dw0.dword0,
-			      lhpte.dw1.dword1, &slot, &dummy0, &dummy1);
+	lpar_rc = plpar_hcall(H_ENTER, flags, hpte_group, hpte_v,
+			      hpte_r, &slot, &dummy0, &dummy1);
 
 	if (unlikely(lpar_rc == H_PTEG_Full))
 		return -1;
@@ -332,7 +321,7 @@
 	/* Because of iSeries, we have to pass down the secondary
 	 * bucket bit here as well
 	 */
-	return (slot & 7) | (secondary << 3);
+	return (slot & 7) | (!!(vflags & HPTE_V_SECONDARY) << 3);
 }
 
 static DEFINE_SPINLOCK(pSeries_lpar_tlbie_lock);
@@ -427,22 +416,18 @@
 	unsigned long hash;
 	unsigned long i, j;
 	long slot;
-	union {
-		unsigned long dword0;
-		Hpte_dword0 dw0;
-	} hpte_dw0;
-	Hpte_dword0 dw0;
+	unsigned long hpte_v;
 
 	hash = hpt_hash(vpn, 0);
 
 	for (j = 0; j < 2; j++) {
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		for (i = 0; i < HPTES_PER_GROUP; i++) {
-			hpte_dw0.dword0 = pSeries_lpar_hpte_getword0(slot);
-			dw0 = hpte_dw0.dw0;
+			hpte_v = pSeries_lpar_hpte_getword0(slot);
 
-			if ((dw0.avpn == (vpn >> 11)) && dw0.v &&
-			    (dw0.h == j)) {
+			if ((HPTE_V_AVPN_VAL(hpte_v) == (vpn >> 11))
+			    && (hpte_v & HPTE_V_VALID)
+			    && (!!(hpte_v & HPTE_V_SECONDARY) == j)) {
 				/* HPTE matches */
 				if (j)
 					slot = -slot;
Index: working-2.6/arch/ppc64/mm/hash_low.S
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hash_low.S	2005-06-08 15:46:23.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hash_low.S	2005-07-08 13:06:14.000000000 +1000
@@ -170,9 +170,7 @@
 	/* Call ppc_md.hpte_insert */
 	ld	r7,STK_PARM(r4)(r1)	/* Retreive new pp bits */
 	mr	r4,r29			/* Retreive va */
-	li	r6,0			/* primary slot */
-	li	r8,0			/* not bolted and not large */
-	li	r9,0
+	li	r6,0			/* no vflags */
 _GLOBAL(htab_call_hpte_insert1)
 	bl	.			/* Will be patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -192,9 +190,7 @@
 	/* Call ppc_md.hpte_insert */
 	ld	r7,STK_PARM(r4)(r1)	/* Retreive new pp bits */
 	mr	r4,r29			/* Retreive va */
-	li	r6,1			/* secondary slot */
-	li	r8,0			/* not bolted and not large */
-	li	r9,0
+	li	r6,HPTE_V_SECONDARY@l	/* secondary slot */
 _GLOBAL(htab_call_hpte_insert2)
 	bl	.			/* Will be patched by htab_finish_init() */
 	cmpdi	0,r3,0
Index: working-2.6/arch/ppc64/mm/hash_native.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hash_native.c	2005-07-06 10:30:13.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hash_native.c	2005-07-08 13:43:15.000000000 +1000
@@ -27,9 +27,9 @@
 
 static DEFINE_SPINLOCK(native_tlbie_lock);
 
-static inline void native_lock_hpte(HPTE *hptep)
+static inline void native_lock_hpte(hpte_t *hptep)
 {
-	unsigned long *word = &hptep->dw0.dword0;
+	unsigned long *word = &hptep->v;
 
 	while (1) {
 		if (!test_and_set_bit(HPTE_LOCK_BIT, word))
@@ -39,32 +39,28 @@
 	}
 }
 
-static inline void native_unlock_hpte(HPTE *hptep)
+static inline void native_unlock_hpte(hpte_t *hptep)
 {
-	unsigned long *word = &hptep->dw0.dword0;
+	unsigned long *word = &hptep->v;
 
 	asm volatile("lwsync":::"memory");
 	clear_bit(HPTE_LOCK_BIT, word);
 }
 
 long native_hpte_insert(unsigned long hpte_group, unsigned long va,
-			unsigned long prpn, int secondary,
-			unsigned long hpteflags, int bolted, int large)
+			unsigned long prpn, unsigned long vflags,
+			unsigned long rflags)
 {
 	unsigned long arpn = physRpn_to_absRpn(prpn);
-	HPTE *hptep = htab_address + hpte_group;
-	Hpte_dword0 dw0;
-	HPTE lhpte;
+	hpte_t *hptep = htab_address + hpte_group;
+	unsigned long hpte_v, hpte_r;
 	int i;
 
 	for (i = 0; i < HPTES_PER_GROUP; i++) {
-		dw0 = hptep->dw0.dw0;
-
-		if (!dw0.v) {
+		if (! (hptep->v & HPTE_V_VALID)) {
 			/* retry with lock held */
 			native_lock_hpte(hptep);
-			dw0 = hptep->dw0.dw0;
-			if (!dw0.v)
+			if (! (hptep->v & HPTE_V_VALID))
 				break;
 			native_unlock_hpte(hptep);
 		}
@@ -75,56 +71,45 @@
 	if (i == HPTES_PER_GROUP)
 		return -1;
 
-	lhpte.dw1.dword1      = 0;
-	lhpte.dw1.dw1.rpn     = arpn;
-	lhpte.dw1.flags.flags = hpteflags;
-
-	lhpte.dw0.dword0      = 0;
-	lhpte.dw0.dw0.avpn    = va >> 23;
-	lhpte.dw0.dw0.h       = secondary;
-	lhpte.dw0.dw0.bolted  = bolted;
-	lhpte.dw0.dw0.v       = 1;
-
-	if (large) {
-		lhpte.dw0.dw0.l = 1;
-		lhpte.dw0.dw0.avpn &= ~0x1UL;
-	}
-
-	hptep->dw1.dword1 = lhpte.dw1.dword1;
+	hpte_v = (va >> 23) << HPTE_V_AVPN_SHIFT | vflags | HPTE_V_VALID;
+	if (vflags & HPTE_V_LARGE)
+		va &= ~(1UL << HPTE_V_AVPN_SHIFT);
+	hpte_r = (arpn << HPTE_R_RPN_SHIFT) | rflags;
 
+	hptep->r = hpte_r;
 	/* Guarantee the second dword is visible before the valid bit */
 	__asm__ __volatile__ ("eieio" : : : "memory");
-
 	/*
 	 * Now set the first dword including the valid bit
 	 * NOTE: this also unlocks the hpte
 	 */
-	hptep->dw0.dword0 = lhpte.dw0.dword0;
+	hptep->v = hpte_v;
 
 	__asm__ __volatile__ ("ptesync" : : : "memory");
 
-	return i | (secondary << 3);
+	return i | (!!(vflags & HPTE_V_SECONDARY) << 3);
 }
 
 static long native_hpte_remove(unsigned long hpte_group)
 {
-	HPTE *hptep;
-	Hpte_dword0 dw0;
+	hpte_t *hptep;
 	int i;
 	int slot_offset;
+	unsigned long hpte_v;
 
 	/* pick a random entry to start at */
 	slot_offset = mftb() & 0x7;
 
 	for (i = 0; i < HPTES_PER_GROUP; i++) {
 		hptep = htab_address + hpte_group + slot_offset;
-		dw0 = hptep->dw0.dw0;
+		hpte_v = hptep->v;
 
-		if (dw0.v && !dw0.bolted) {
+		if ((hpte_v & HPTE_V_VALID) && !(hpte_v & HPTE_V_BOLTED)) {
 			/* retry with lock held */
 			native_lock_hpte(hptep);
-			dw0 = hptep->dw0.dw0;
-			if (dw0.v && !dw0.bolted)
+			hpte_v = hptep->v;
+			if ((hpte_v & HPTE_V_VALID)
+			    && !(hpte_v & HPTE_V_BOLTED))
 				break;
 			native_unlock_hpte(hptep);
 		}
@@ -137,15 +122,15 @@
 		return -1;
 
 	/* Invalidate the hpte. NOTE: this also unlocks it */
-	hptep->dw0.dword0 = 0;
+	hptep->v = 0;
 
 	return i;
 }
 
-static inline void set_pp_bit(unsigned long pp, HPTE *addr)
+static inline void set_pp_bit(unsigned long pp, hpte_t *addr)
 {
 	unsigned long old;
-	unsigned long *p = &addr->dw1.dword1;
+	unsigned long *p = &addr->r;
 
 	__asm__ __volatile__(
 	"1:	ldarx	%0,0,%3\n\
@@ -163,11 +148,11 @@
  */
 static long native_hpte_find(unsigned long vpn)
 {
-	HPTE *hptep;
+	hpte_t *hptep;
 	unsigned long hash;
 	unsigned long i, j;
 	long slot;
-	Hpte_dword0 dw0;
+	unsigned long hpte_v;
 
 	hash = hpt_hash(vpn, 0);
 
@@ -175,10 +160,11 @@
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		for (i = 0; i < HPTES_PER_GROUP; i++) {
 			hptep = htab_address + slot;
-			dw0 = hptep->dw0.dw0;
+			hpte_v = hptep->v;
 
-			if ((dw0.avpn == (vpn >> 11)) && dw0.v &&
-			    (dw0.h == j)) {
+			if ((HPTE_V_AVPN_VAL(hpte_v) == (vpn >> 11))
+			    && (hpte_v & HPTE_V_VALID)
+			    && ( !!(hpte_v & HPTE_V_SECONDARY) == j)) {
 				/* HPTE matches */
 				if (j)
 					slot = -slot;
@@ -195,20 +181,21 @@
 static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 				 unsigned long va, int large, int local)
 {
-	HPTE *hptep = htab_address + slot;
-	Hpte_dword0 dw0;
+	hpte_t *hptep = htab_address + slot;
+	unsigned long hpte_v;
 	unsigned long avpn = va >> 23;
 	int ret = 0;
 
 	if (large)
-		avpn &= ~0x1UL;
+		avpn &= ~1;
 
 	native_lock_hpte(hptep);
 
-	dw0 = hptep->dw0.dw0;
+	hpte_v = hptep->v;
 
 	/* Even if we miss, we need to invalidate the TLB */
-	if ((dw0.avpn != avpn) || !dw0.v) {
+	if ((HPTE_V_AVPN_VAL(hpte_v) != avpn)
+	    || !(hpte_v & HPTE_V_VALID)) {
 		native_unlock_hpte(hptep);
 		ret = -1;
 	} else {
@@ -244,7 +231,7 @@
 {
 	unsigned long vsid, va, vpn, flags = 0;
 	long slot;
-	HPTE *hptep;
+	hpte_t *hptep;
 	int lock_tlbie = !cpu_has_feature(CPU_FTR_LOCKLESS_TLBIE);
 
 	vsid = get_kernel_vsid(ea);
@@ -269,26 +256,27 @@
 static void native_hpte_invalidate(unsigned long slot, unsigned long va,
 				    int large, int local)
 {
-	HPTE *hptep = htab_address + slot;
-	Hpte_dword0 dw0;
+	hpte_t *hptep = htab_address + slot;
+	unsigned long hpte_v;
 	unsigned long avpn = va >> 23;
 	unsigned long flags;
 	int lock_tlbie = !cpu_has_feature(CPU_FTR_LOCKLESS_TLBIE);
 
 	if (large)
-		avpn &= ~0x1UL;
+		avpn &= ~1;
 
 	local_irq_save(flags);
 	native_lock_hpte(hptep);
 
-	dw0 = hptep->dw0.dw0;
+	hpte_v = hptep->v;
 
 	/* Even if we miss, we need to invalidate the TLB */
-	if ((dw0.avpn != avpn) || !dw0.v) {
+	if ((HPTE_V_AVPN_VAL(hpte_v) != avpn)
+	    || !(hpte_v & HPTE_V_VALID)) {
 		native_unlock_hpte(hptep);
 	} else {
 		/* Invalidate the hpte. NOTE: this also unlocks it */
-		hptep->dw0.dword0 = 0;
+		hptep->v = 0;
 	}
 
 	/* Invalidate the tlb */
@@ -315,8 +303,8 @@
 static void native_hpte_clear(void)
 {
 	unsigned long slot, slots, flags;
-	HPTE *hptep = htab_address;
-	Hpte_dword0 dw0;
+	hpte_t *hptep = htab_address;
+	unsigned long hpte_v;
 	unsigned long pteg_count;
 
 	pteg_count = htab_hash_mask + 1;
@@ -336,11 +324,11 @@
 		 * running,  right?  and for crash dump, we probably
 		 * don't want to wait for a maybe bad cpu.
 		 */
-		dw0 = hptep->dw0.dw0;
+		hpte_v = hptep->v;
 
-		if (dw0.v) {
-			hptep->dw0.dword0 = 0;
-			tlbie(slot2va(dw0.avpn, dw0.l, dw0.h, slot), dw0.l);
+		if (hpte_v & HPTE_V_VALID) {
+			hptep->v = 0;
+			tlbie(slot2va(hpte_v, slot), hpte_v & HPTE_V_LARGE);
 		}
 	}
 
@@ -353,8 +341,8 @@
 {
 	unsigned long vsid, vpn, va, hash, secondary, slot, flags, avpn;
 	int i, j;
-	HPTE *hptep;
-	Hpte_dword0 dw0;
+	hpte_t *hptep;
+	unsigned long hpte_v;
 	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
 
 	/* XXX fix for large ptes */
@@ -390,14 +378,15 @@
 
 		native_lock_hpte(hptep);
 
-		dw0 = hptep->dw0.dw0;
+		hpte_v = hptep->v;
 
 		/* Even if we miss, we need to invalidate the TLB */
-		if ((dw0.avpn != avpn) || !dw0.v) {
+		if ((HPTE_V_AVPN_VAL(hpte_v) != avpn)
+		    || !(hpte_v & HPTE_V_VALID)) {
 			native_unlock_hpte(hptep);
 		} else {
 			/* Invalidate the hpte. NOTE: this also unlocks it */
-			hptep->dw0.dword0 = 0;
+			hptep->v = 0;
 		}
 
 		j++;
Index: working-2.6/arch/ppc64/mm/hash_utils.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hash_utils.c	2005-07-06 10:30:13.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hash_utils.c	2005-07-08 13:06:14.000000000 +1000
@@ -75,8 +75,8 @@
 extern unsigned long dart_tablebase;
 #endif /* CONFIG_U3_DART */
 
-HPTE		*htab_address;
-unsigned long	htab_hash_mask;
+hpte_t *htab_address;
+unsigned long htab_hash_mask;
 
 extern unsigned long _SDR1;
 
@@ -97,11 +97,15 @@
 	unsigned long addr;
 	unsigned int step;
 	unsigned long tmp_mode;
+	unsigned long vflags;
 
-	if (large)
+	if (large) {
 		step = 16*MB;
-	else
+		vflags = HPTE_V_BOLTED | HPTE_V_LARGE;
+	} else {
 		step = 4*KB;
+		vflags = HPTE_V_BOLTED;
+	}
 
 	for (addr = start; addr < end; addr += step) {
 		unsigned long vpn, hash, hpteg;
@@ -129,12 +133,12 @@
 		if (systemcfg->platform & PLATFORM_LPAR)
 			ret = pSeries_lpar_hpte_insert(hpteg, va,
 				virt_to_abs(addr) >> PAGE_SHIFT,
-				0, tmp_mode, 1, large);
+				vflags, tmp_mode);
 		else
 #endif /* CONFIG_PPC_PSERIES */
 			ret = native_hpte_insert(hpteg, va,
 				virt_to_abs(addr) >> PAGE_SHIFT,
-				0, tmp_mode, 1, large);
+				vflags, tmp_mode);
 
 		if (ret == -1) {
 			ppc64_terminate_msg(0x20, "create_pte_mapping");
Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2005-07-06 10:30:13.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2005-07-08 13:06:14.000000000 +1000
@@ -583,7 +583,7 @@
 	pte_t *ptep;
 	unsigned long va, vpn;
 	pte_t old_pte, new_pte;
-	unsigned long hpteflags, prpn;
+	unsigned long rflags, prpn;
 	long slot;
 	int err = 1;
 
@@ -626,9 +626,9 @@
 	old_pte = *ptep;
 	new_pte = old_pte;
 
-	hpteflags = 0x2 | (! (pte_val(new_pte) & _PAGE_RW));
+	rflags = 0x2 | (! (pte_val(new_pte) & _PAGE_RW));
  	/* _PAGE_EXEC -> HW_NO_EXEC since it's inverted */
-	hpteflags |= ((pte_val(new_pte) & _PAGE_EXEC) ? 0 : HW_NO_EXEC);
+	rflags |= ((pte_val(new_pte) & _PAGE_EXEC) ? 0 : HW_NO_EXEC);
 
 	/* Check if pte already has an hpte (case 2) */
 	if (unlikely(pte_val(old_pte) & _PAGE_HASHPTE)) {
@@ -641,7 +641,7 @@
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += (pte_val(old_pte) & _PAGE_GROUP_IX) >> 12;
 
-		if (ppc_md.hpte_updatepp(slot, hpteflags, va, 1, local) == -1)
+		if (ppc_md.hpte_updatepp(slot, rflags, va, 1, local) == -1)
 			pte_val(old_pte) &= ~_PAGE_HPTEFLAGS;
 	}
 
@@ -661,10 +661,10 @@
 
 		/* Add in WIMG bits */
 		/* XXX We should store these in the pte */
-		hpteflags |= _PAGE_COHERENT;
+		rflags |= _PAGE_COHERENT;
 
-		slot = ppc_md.hpte_insert(hpte_group, va, prpn, 0,
-					  hpteflags, 0, 1);
+		slot = ppc_md.hpte_insert(hpte_group, va, prpn,
+					  HPTE_V_LARGE, rflags);
 
 		/* Primary is full, try the secondary */
 		if (unlikely(slot == -1)) {
@@ -672,7 +672,7 @@
 			hpte_group = ((~hash & htab_hash_mask) *
 				      HPTES_PER_GROUP) & ~0x7UL; 
 			slot = ppc_md.hpte_insert(hpte_group, va, prpn,
-						  1, hpteflags, 0, 1);
+						  HPTE_V_LARGE, rflags);
 			if (slot == -1) {
 				if (mftb() & 0x1)
 					hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
Index: working-2.6/arch/ppc64/mm/init.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/init.c	2005-07-06 10:30:13.000000000 +1000
+++ working-2.6/arch/ppc64/mm/init.c	2005-07-08 13:49:35.000000000 +1000
@@ -180,9 +180,10 @@
 		hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
 
 		/* Panic if a pte grpup is full */
-		if (ppc_md.hpte_insert(hpteg, va, pa >> PAGE_SHIFT, 0,
-				       _PAGE_NO_CACHE|_PAGE_GUARDED|PP_RWXX,
-				       1, 0) == -1) {
+		if (ppc_md.hpte_insert(hpteg, va, pa >> PAGE_SHIFT,
+				       HPTE_V_BOLTED,
+				       _PAGE_NO_CACHE|_PAGE_GUARDED|PP_RWXX)
+		    == -1) {
 			panic("map_io_page: could not insert mapping");
 		}
 	}
Index: working-2.6/include/asm-ppc64/machdep.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/machdep.h	2005-07-06 10:30:53.000000000 +1000
+++ working-2.6/include/asm-ppc64/machdep.h	2005-07-08 13:06:14.000000000 +1000
@@ -53,10 +53,8 @@
 	long		(*hpte_insert)(unsigned long hpte_group,
 				       unsigned long va,
 				       unsigned long prpn,
-				       int secondary, 
-				       unsigned long hpteflags, 
-				       int bolted,
-				       int large);
+				       unsigned long vflags,
+				       unsigned long rflags);
 	long		(*hpte_remove)(unsigned long hpte_group);
 	void		(*flush_hash_range)(unsigned long context,
 					    unsigned long number,
Index: working-2.6/include/asm-ppc64/mmu.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mmu.h	2005-07-06 10:30:53.000000000 +1000
+++ working-2.6/include/asm-ppc64/mmu.h	2005-07-08 13:48:40.000000000 +1000
@@ -60,6 +60,22 @@
 
 #define HPTES_PER_GROUP 8
 
+#define HPTE_V_AVPN_SHIFT	7
+#define HPTE_V_AVPN		ASM_CONST(0xffffffffffffff80)
+#define HPTE_V_AVPN_VAL(x)	(((x) & HPTE_V_AVPN) >> HPTE_V_AVPN_SHIFT)
+#define HPTE_V_BOLTED		ASM_CONST(0x0000000000000010)
+#define HPTE_V_LOCK		ASM_CONST(0x0000000000000008)
+#define HPTE_V_LARGE		ASM_CONST(0x0000000000000004)
+#define HPTE_V_SECONDARY	ASM_CONST(0x0000000000000002)
+#define HPTE_V_VALID		ASM_CONST(0x0000000000000001)
+
+#define HPTE_R_PP0		ASM_CONST(0x8000000000000000)
+#define HPTE_R_TS		ASM_CONST(0x4000000000000000)
+#define HPTE_R_RPN_SHIFT	12
+#define HPTE_R_RPN		ASM_CONST(0x3ffffffffffff000)
+#define HPTE_R_FLAGS		ASM_CONST(0x00000000000003ff)
+#define HPTE_R_PP		ASM_CONST(0x0000000000000003)
+
 /* Values for PP (assumes Ks=0, Kp=1) */
 /* pp0 will always be 0 for linux     */
 #define PP_RWXX	0	/* Supervisor read/write, User none */
@@ -69,54 +85,13 @@
 
 #ifndef __ASSEMBLY__
 
-/* Hardware Page Table Entry */
-typedef struct {
-	unsigned long avpn:57; /* vsid | api == avpn  */
-	unsigned long :     2; /* Software use */
-	unsigned long bolted: 1; /* HPTE is "bolted" */
-	unsigned long lock: 1; /* lock on pSeries SMP */
-	unsigned long l:    1; /* Virtual page is large (L=1) or 4 KB (L=0) */
-	unsigned long h:    1; /* Hash function identifier */
-	unsigned long v:    1; /* Valid (v=1) or invalid (v=0) */
-} Hpte_dword0;
-
-typedef struct {
-	unsigned long pp0:  1; /* Page protection bit 0 */
-	unsigned long ts:   1; /* Tag set bit */
-	unsigned long rpn: 50; /* Real page number */
-	unsigned long :     2; /* Reserved */
-	unsigned long ac:   1; /* Address compare */ 
-	unsigned long r:    1; /* Referenced */
-	unsigned long c:    1; /* Changed */
-	unsigned long w:    1; /* Write-thru cache mode */
-	unsigned long i:    1; /* Cache inhibited */
-	unsigned long m:    1; /* Memory coherence required */
-	unsigned long g:    1; /* Guarded */
-	unsigned long n:    1; /* No-execute */
-	unsigned long pp:   2; /* Page protection bits 1:2 */
-} Hpte_dword1;
-
-typedef struct {
-	char padding[6];	   	/* padding */
-	unsigned long :       6;	/* padding */ 
-	unsigned long flags: 10;	/* HPTE flags */
-} Hpte_dword1_flags;
-
 typedef struct {
-	union {
-		unsigned long dword0;
-		Hpte_dword0   dw0;
-	} dw0;
-
-	union {
-		unsigned long dword1;
-		Hpte_dword1 dw1;
-		Hpte_dword1_flags flags;
-	} dw1;
-} HPTE; 
+	unsigned long v;
+	unsigned long r;
+} hpte_t;
 
-extern HPTE *		htab_address;
-extern unsigned long	htab_hash_mask;
+extern hpte_t *htab_address;
+extern unsigned long htab_hash_mask;
 
 static inline unsigned long hpt_hash(unsigned long vpn, int large)
 {
@@ -181,18 +156,18 @@
 	asm volatile("ptesync": : :"memory");
 }
 
-static inline unsigned long slot2va(unsigned long avpn, unsigned long large,
-		unsigned long secondary, unsigned long slot)
+static inline unsigned long slot2va(unsigned long hpte_v, unsigned long slot)
 {
+	unsigned long avpn = HPTE_V_AVPN_VAL(hpte_v);
 	unsigned long va;
 
 	va = avpn << 23;
 
-	if (!large) {
+	if (! (hpte_v & HPTE_V_LARGE)) {
 		unsigned long vpi, pteg;
 
 		pteg = slot / HPTES_PER_GROUP;
-		if (secondary)
+		if (hpte_v & HPTE_V_SECONDARY)
 			pteg = ~pteg;
 
 		vpi = ((va >> 28) ^ pteg) & htab_hash_mask;
@@ -219,11 +194,11 @@
 
 extern long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 				     unsigned long va, unsigned long prpn,
-				     int secondary, unsigned long hpteflags,
-				     int bolted, int large);
+				     unsigned long vflags,
+				     unsigned long rflags);
 extern long native_hpte_insert(unsigned long hpte_group, unsigned long va,
-			       unsigned long prpn, int secondary,
-			       unsigned long hpteflags, int bolted, int large);
+			       unsigned long prpn,
+			       unsigned long vflags, unsigned long rflags);
 
 #endif /* __ASSEMBLY__ */
 
Index: working-2.6/include/asm-ppc64/iSeries/HvCallHpt.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/iSeries/HvCallHpt.h	2005-07-06 10:30:53.000000000 +1000
+++ working-2.6/include/asm-ppc64/iSeries/HvCallHpt.h	2005-07-08 13:22:29.000000000 +1000
@@ -77,27 +77,26 @@
 	return compressedStatus;
 }
 
-static inline u64 HvCallHpt_findValid(HPTE *hpte, u64 vpn)
+static inline u64 HvCallHpt_findValid(hpte_t *hpte, u64 vpn)
 {
 	return HvCall3Ret16(HvCallHptFindValid, hpte, vpn, 0, 0);
 }
 
-static inline u64 HvCallHpt_findNextValid(HPTE *hpte, u32 hpteIndex,
+static inline u64 HvCallHpt_findNextValid(hpte_t *hpte, u32 hpteIndex,
 		u8 bitson, u8 bitsoff)
 {
 	return HvCall3Ret16(HvCallHptFindNextValid, hpte, hpteIndex,
 			bitson, bitsoff);
 }
 
-static inline void HvCallHpt_get(HPTE *hpte, u32 hpteIndex)
+static inline void HvCallHpt_get(hpte_t *hpte, u32 hpteIndex)
 {
 	HvCall2Ret16(HvCallHptGet, hpte, hpteIndex, 0);
 }
 
-static inline void HvCallHpt_addValidate(u32 hpteIndex, u32 hBit, HPTE *hpte)
+static inline void HvCallHpt_addValidate(u32 hpteIndex, u32 hBit, hpte_t *hpte)
 {
-	HvCall4(HvCallHptAddValidate, hpteIndex, hBit, (*((u64 *)hpte)),
-			(*(((u64 *)hpte)+1)));
+	HvCall4(HvCallHptAddValidate, hpteIndex, hBit, hpte->v, hpte->r);
 }
 
 #endif /* _HVCALLHPT_H */


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
