Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269791AbVBFDb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269791AbVBFDb4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 22:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268758AbVBFDb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 22:31:56 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:56243 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S272703AbVBFD1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 22:27:42 -0500
Date: Sat, 5 Feb 2005 21:26:45 -0600
To: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Cc: paulus@samba.org, anton@samba.org, trini@kernel.crashing.org,
       benh@kernel.crashing.org, hpa@zytor.com, akpm@osdl.org
Subject: Re: [PATCH] PPC/PPC64: Abstract cpu_feature checks.
Message-ID: <20050206032645.GA18845@austin.ibm.com>
References: <20050204072254.GA17565@austin.ibm.com> <20050205184647.GA17417@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205184647.GA17417@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040523i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doh, forgot to do a final refpatch after fixing build error. I blame it
on lack of morning coffee. Here's a proper version:



 
Abstract most manual mask checks of cpu_features with cpu_has_feature()
 
 
Signed-off-by: Olof Johansson <olof@austin.ibm.com>

---

 linux-2.5-olof/arch/ppc/kernel/ppc_htab.c            |    8 +++---
 linux-2.5-olof/arch/ppc/kernel/setup.c               |    4 +--
 linux-2.5-olof/arch/ppc/kernel/temp.c                |    2 -
 linux-2.5-olof/arch/ppc/mm/mmu_decl.h                |    2 -
 linux-2.5-olof/arch/ppc/mm/ppc_mmu.c                 |    4 +--
 linux-2.5-olof/arch/ppc/platforms/pmac_cpufreq.c     |    2 -
 linux-2.5-olof/arch/ppc/platforms/pmac_setup.c       |    2 -
 linux-2.5-olof/arch/ppc/platforms/pmac_smp.c         |    4 +--
 linux-2.5-olof/arch/ppc/platforms/sandpoint.c        |    6 ++---
 linux-2.5-olof/arch/ppc64/kernel/align.c             |    2 -
 linux-2.5-olof/arch/ppc64/kernel/iSeries_setup.c     |    2 -
 linux-2.5-olof/arch/ppc64/kernel/pSeries_lpar.c      |    2 -
 linux-2.5-olof/arch/ppc64/kernel/process.c           |    4 +--
 linux-2.5-olof/arch/ppc64/kernel/setup.c             |    6 ++---
 linux-2.5-olof/arch/ppc64/kernel/smp.c               |    2 -
 linux-2.5-olof/arch/ppc64/kernel/sysfs.c             |   22 +++++++++----------
 linux-2.5-olof/arch/ppc64/mm/hash_native.c           |   14 ++++++------
 linux-2.5-olof/arch/ppc64/mm/hash_utils.c            |    2 -
 linux-2.5-olof/arch/ppc64/mm/hugetlbpage.c           |    2 -
 linux-2.5-olof/arch/ppc64/mm/init.c                  |   10 ++++----
 linux-2.5-olof/arch/ppc64/mm/slb.c                   |    4 +--
 linux-2.5-olof/arch/ppc64/mm/stab.c                  |    2 -
 linux-2.5-olof/arch/ppc64/oprofile/op_model_power4.c |    2 -
 linux-2.5-olof/arch/ppc64/oprofile/op_model_rs64.c   |    2 -
 linux-2.5-olof/arch/ppc64/xmon/xmon.c                |    8 +++---
 linux-2.5-olof/drivers/macintosh/via-pmu.c           |    2 -
 linux-2.5-olof/drivers/md/raid6altivec.uc            |    2 -
 linux-2.5-olof/include/asm-ppc/cputable.h            |    5 ++++
 linux-2.5-olof/include/asm-ppc64/cacheflush.h        |    2 -
 linux-2.5-olof/include/asm-ppc64/cputable.h          |    5 ++++
 linux-2.5-olof/include/asm-ppc64/mmu_context.h       |    4 +--
 linux-2.5-olof/include/asm-ppc64/page.h              |    2 -
 32 files changed, 76 insertions(+), 66 deletions(-)

diff -puN include/asm-ppc64/cputable.h~cpu-has-feature include/asm-ppc64/cputable.h
--- linux-2.5/include/asm-ppc64/cputable.h~cpu-has-feature	2005-02-05 11:11:03.478617416 -0600
+++ linux-2.5-olof/include/asm-ppc64/cputable.h	2005-02-05 21:14:05.873057376 -0600
@@ -66,6 +66,11 @@ struct cpu_spec {
 extern struct cpu_spec		cpu_specs[];
 extern struct cpu_spec		*cur_cpu_spec;
 
+static inline unsigned long cpu_has_feature(unsigned long feature)
+{
+	return cur_cpu_spec->cpu_features & feature;
+}
+
 
 /* firmware feature bitmask values */
 #define FIRMWARE_MAX_FEATURES 63
diff -puN arch/ppc64/kernel/align.c~cpu-has-feature arch/ppc64/kernel/align.c
--- linux-2.5/arch/ppc64/kernel/align.c~cpu-has-feature	2005-02-05 11:11:03.521610880 -0600
+++ linux-2.5-olof/arch/ppc64/kernel/align.c	2005-02-05 11:11:04.117520288 -0600
@@ -238,7 +238,7 @@ fix_alignment(struct pt_regs *regs)
 
 	dsisr = regs->dsisr;
 
-	if (cur_cpu_spec->cpu_features & CPU_FTR_NODSISRALIGN) {
+	if (cpu_has_feature(CPU_FTR_NODSISRALIGN)) {
 	    unsigned int real_instr;
 	    if (__get_user(real_instr, (unsigned int __user *)regs->nip))
 		return 0;
diff -puN arch/ppc64/kernel/iSeries_setup.c~cpu-has-feature arch/ppc64/kernel/iSeries_setup.c
--- linux-2.5/arch/ppc64/kernel/iSeries_setup.c~cpu-has-feature	2005-02-05 11:11:03.525610272 -0600
+++ linux-2.5-olof/arch/ppc64/kernel/iSeries_setup.c	2005-02-05 11:11:04.118520136 -0600
@@ -267,7 +267,7 @@ unsigned long iSeries_process_mainstore_
 	unsigned long i;
 	unsigned long mem_blocks = 0;
 
-	if (cur_cpu_spec->cpu_features & CPU_FTR_SLB)
+	if (cpu_has_feature(CPU_FTR_SLB))
 		mem_blocks = iSeries_process_Regatta_mainstore_vpd(mb_array,
 				max_entries);
 	else
diff -puN arch/ppc64/kernel/idle.c~cpu-has-feature arch/ppc64/kernel/idle.c
diff -puN arch/ppc64/kernel/process.c~cpu-has-feature arch/ppc64/kernel/process.c
--- linux-2.5/arch/ppc64/kernel/process.c~cpu-has-feature	2005-02-05 11:11:03.600598872 -0600
+++ linux-2.5-olof/arch/ppc64/kernel/process.c	2005-02-05 11:11:04.119519984 -0600
@@ -388,12 +388,12 @@ copy_thread(int nr, unsigned long clone_
 	kregs = (struct pt_regs *) sp;
 	sp -= STACK_FRAME_OVERHEAD;
 	p->thread.ksp = sp;
-	if (cur_cpu_spec->cpu_features & CPU_FTR_SLB) {
+	if (cpu_has_feature(CPU_FTR_SLB)) {
 		unsigned long sp_vsid = get_kernel_vsid(sp);
 
 		sp_vsid <<= SLB_VSID_SHIFT;
 		sp_vsid |= SLB_VSID_KERNEL;
-		if (cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE)
+		if (cpu_has_feature(CPU_FTR_16M_PAGE))
 			sp_vsid |= SLB_VSID_L;
 
 		p->thread.ksp_vsid = sp_vsid;
diff -puN arch/ppc64/kernel/smp.c~cpu-has-feature arch/ppc64/kernel/smp.c
--- linux-2.5/arch/ppc64/kernel/smp.c~cpu-has-feature	2005-02-05 11:11:03.606597960 -0600
+++ linux-2.5-olof/arch/ppc64/kernel/smp.c	2005-02-05 11:11:04.120519832 -0600
@@ -416,7 +416,7 @@ int __devinit __cpu_up(unsigned int cpu)
 
 	paca[cpu].default_decr = tb_ticks_per_jiffy / decr_overclock;
 
-	if (!(cur_cpu_spec->cpu_features & CPU_FTR_SLB)) {
+	if (!cpu_has_feature(CPU_FTR_SLB)) {
 		void *tmp;
 
 		/* maximum of 48 CPUs on machines with a segment table */
diff -puN arch/ppc64/kernel/sysfs.c~cpu-has-feature arch/ppc64/kernel/sysfs.c
--- linux-2.5/arch/ppc64/kernel/sysfs.c~cpu-has-feature	2005-02-05 11:11:03.609597504 -0600
+++ linux-2.5-olof/arch/ppc64/kernel/sysfs.c	2005-02-05 11:11:04.121519680 -0600
@@ -63,7 +63,7 @@ static int __init smt_setup(void)
 	unsigned int *val;
 	unsigned int cpu;
 
-	if (!cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+	if (!cpu_has_feature(CPU_FTR_SMT))
 		return 1;
 
 	options = find_path_device("/options");
@@ -86,7 +86,7 @@ static int __init setup_smt_snooze_delay
 	unsigned int cpu;
 	int snooze;
 
-	if (!cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+	if (!cpu_has_feature(CPU_FTR_SMT))
 		return 1;
 
 	smt_snooze_cmdline = 1;
@@ -167,7 +167,7 @@ void ppc64_enable_pmcs(void)
 	 * On SMT machines we have to set the run latch in the ctrl register
 	 * in order to make PMC6 spin.
 	 */
-	if (cur_cpu_spec->cpu_features & CPU_FTR_SMT) {
+	if (cpu_has_feature(CPU_FTR_SMT)) {
 		ctrl = mfspr(CTRLF);
 		ctrl |= RUNLATCH;
 		mtspr(CTRLT, ctrl);
@@ -266,7 +266,7 @@ static void register_cpu_online(unsigned
 	struct sys_device *s = &c->sysdev;
 
 #ifndef CONFIG_PPC_ISERIES
-	if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+	if (cpu_has_feature(CPU_FTR_SMT))
 		sysdev_create_file(s, &attr_smt_snooze_delay);
 #endif
 
@@ -275,7 +275,7 @@ static void register_cpu_online(unsigned
 	sysdev_create_file(s, &attr_mmcr0);
 	sysdev_create_file(s, &attr_mmcr1);
 
-	if (cur_cpu_spec->cpu_features & CPU_FTR_MMCRA)
+	if (cpu_has_feature(CPU_FTR_MMCRA))
 		sysdev_create_file(s, &attr_mmcra);
 
 	sysdev_create_file(s, &attr_pmc1);
@@ -285,12 +285,12 @@ static void register_cpu_online(unsigned
 	sysdev_create_file(s, &attr_pmc5);
 	sysdev_create_file(s, &attr_pmc6);
 
-	if (cur_cpu_spec->cpu_features & CPU_FTR_PMC8) {
+	if (cpu_has_feature(CPU_FTR_PMC8)) {
 		sysdev_create_file(s, &attr_pmc7);
 		sysdev_create_file(s, &attr_pmc8);
 	}
 
-	if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+	if (cpu_has_feature(CPU_FTR_SMT))
 		sysdev_create_file(s, &attr_purr);
 }
 
@@ -303,7 +303,7 @@ static void unregister_cpu_online(unsign
 	BUG_ON(c->no_control);
 
 #ifndef CONFIG_PPC_ISERIES
-	if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+	if (cpu_has_feature(CPU_FTR_SMT))
 		sysdev_remove_file(s, &attr_smt_snooze_delay);
 #endif
 
@@ -312,7 +312,7 @@ static void unregister_cpu_online(unsign
 	sysdev_remove_file(s, &attr_mmcr0);
 	sysdev_remove_file(s, &attr_mmcr1);
 
-	if (cur_cpu_spec->cpu_features & CPU_FTR_MMCRA)
+	if (cpu_has_feature(CPU_FTR_MMCRA))
 		sysdev_remove_file(s, &attr_mmcra);
 
 	sysdev_remove_file(s, &attr_pmc1);
@@ -322,12 +322,12 @@ static void unregister_cpu_online(unsign
 	sysdev_remove_file(s, &attr_pmc5);
 	sysdev_remove_file(s, &attr_pmc6);
 
-	if (cur_cpu_spec->cpu_features & CPU_FTR_PMC8) {
+	if (cpu_has_feature(CPU_FTR_PMC8)) {
 		sysdev_remove_file(s, &attr_pmc7);
 		sysdev_remove_file(s, &attr_pmc8);
 	}
 
-	if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+	if (cpu_has_feature(CPU_FTR_SMT))
 		sysdev_remove_file(s, &attr_purr);
 }
 #endif /* CONFIG_HOTPLUG_CPU */
diff -puN arch/ppc64/mm/hash_native.c~cpu-has-feature arch/ppc64/mm/hash_native.c
--- linux-2.5/arch/ppc64/mm/hash_native.c~cpu-has-feature	2005-02-05 11:11:03.653590816 -0600
+++ linux-2.5-olof/arch/ppc64/mm/hash_native.c	2005-02-05 11:11:04.122519528 -0600
@@ -217,10 +217,10 @@ static long native_hpte_updatepp(unsigne
 	}
 
 	/* Ensure it is out of the tlb too */
-	if ((cur_cpu_spec->cpu_features & CPU_FTR_TLBIEL) && !large && local) {
+	if (cpu_has_feature(CPU_FTR_TLBIEL) && !large && local) {
 		tlbiel(va);
 	} else {
-		int lock_tlbie = !(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE);
+		int lock_tlbie = !cpu_has_feature(CPU_FTR_LOCKLESS_TLBIE);
 
 		if (lock_tlbie)
 			spin_lock(&native_tlbie_lock);
@@ -245,7 +245,7 @@ static void native_hpte_updateboltedpp(u
 	unsigned long vsid, va, vpn, flags = 0;
 	long slot;
 	HPTE *hptep;
-	int lock_tlbie = !(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE);
+	int lock_tlbie = !cpu_has_feature(CPU_FTR_LOCKLESS_TLBIE);
 
 	vsid = get_kernel_vsid(ea);
 	va = (vsid << 28) | (ea & 0x0fffffff);
@@ -273,7 +273,7 @@ static void native_hpte_invalidate(unsig
 	Hpte_dword0 dw0;
 	unsigned long avpn = va >> 23;
 	unsigned long flags;
-	int lock_tlbie = !(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE);
+	int lock_tlbie = !cpu_has_feature(CPU_FTR_LOCKLESS_TLBIE);
 
 	if (large)
 		avpn &= ~0x1UL;
@@ -292,7 +292,7 @@ static void native_hpte_invalidate(unsig
 	}
 
 	/* Invalidate the tlb */
-	if ((cur_cpu_spec->cpu_features & CPU_FTR_TLBIEL) && !large && local) {
+	if (cpu_has_feature(CPU_FTR_TLBIEL) && !large && local) {
 		tlbiel(va);
 	} else {
 		if (lock_tlbie)
@@ -360,7 +360,7 @@ static void native_flush_hash_range(unsi
 		j++;
 	}
 
-	if ((cur_cpu_spec->cpu_features & CPU_FTR_TLBIEL) && !large && local) {
+	if (cpu_has_feature(CPU_FTR_TLBIEL) && !large && local) {
 		asm volatile("ptesync":::"memory");
 
 		for (i = 0; i < j; i++)
@@ -368,7 +368,7 @@ static void native_flush_hash_range(unsi
 
 		asm volatile("ptesync":::"memory");
 	} else {
-		int lock_tlbie = !(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE);
+		int lock_tlbie = !cpu_has_feature(CPU_FTR_LOCKLESS_TLBIE);
 
 		if (lock_tlbie)
 			spin_lock(&native_tlbie_lock);
diff -puN arch/ppc64/mm/hash_utils.c~cpu-has-feature arch/ppc64/mm/hash_utils.c
--- linux-2.5/arch/ppc64/mm/hash_utils.c~cpu-has-feature	2005-02-05 11:11:03.656590360 -0600
+++ linux-2.5-olof/arch/ppc64/mm/hash_utils.c	2005-02-05 11:11:04.123519376 -0600
@@ -190,7 +190,7 @@ void __init htab_initialize(void)
 	 * _NOT_ map it to avoid cache paradoxes as it's remapped non
 	 * cacheable later on
 	 */
-	if (cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE)
+	if (cpu_has_feature(CPU_FTR_16M_PAGE))
 		use_largepages = 1;
 
 	/* create bolted the linear mapping in the hash table */
diff -puN arch/ppc64/mm/hugetlbpage.c~cpu-has-feature arch/ppc64/mm/hugetlbpage.c
--- linux-2.5/arch/ppc64/mm/hugetlbpage.c~cpu-has-feature	2005-02-05 11:11:03.674587624 -0600
+++ linux-2.5-olof/arch/ppc64/mm/hugetlbpage.c	2005-02-05 11:11:04.123519376 -0600
@@ -705,7 +705,7 @@ unsigned long hugetlb_get_unmapped_area(
 	if (len & ~HPAGE_MASK)
 		return -EINVAL;
 
-	if (!(cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE))
+	if (!cpu_has_feature(CPU_FTR_16M_PAGE))
 		return -EINVAL;
 
 	if (test_thread_flag(TIF_32BIT)) {
diff -puN arch/ppc64/mm/init.c~cpu-has-feature arch/ppc64/mm/init.c
--- linux-2.5/arch/ppc64/mm/init.c~cpu-has-feature	2005-02-05 11:11:03.680586712 -0600
+++ linux-2.5-olof/arch/ppc64/mm/init.c	2005-02-05 11:11:04.124519224 -0600
@@ -752,7 +752,7 @@ void __init mem_init(void)
  */
 void flush_dcache_page(struct page *page)
 {
-	if (cur_cpu_spec->cpu_features & CPU_FTR_COHERENT_ICACHE)
+	if (cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
 		return;
 	/* avoid an atomic op if possible */
 	if (test_bit(PG_arch_1, &page->flags))
@@ -763,7 +763,7 @@ void clear_user_page(void *page, unsigne
 {
 	clear_page(page);
 
-	if (cur_cpu_spec->cpu_features & CPU_FTR_COHERENT_ICACHE)
+	if (cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
 		return;
 	/*
 	 * We shouldnt have to do this, but some versions of glibc
@@ -796,7 +796,7 @@ void copy_user_page(void *vto, void *vfr
 		return;
 #endif
 
-	if (cur_cpu_spec->cpu_features & CPU_FTR_COHERENT_ICACHE)
+	if (cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
 		return;
 
 	/* avoid an atomic op if possible */
@@ -832,8 +832,8 @@ void update_mmu_cache(struct vm_area_str
 	unsigned long flags;
 
 	/* handle i-cache coherency */
-	if (!(cur_cpu_spec->cpu_features & CPU_FTR_COHERENT_ICACHE) &&
-	    !(cur_cpu_spec->cpu_features & CPU_FTR_NOEXECUTE)) {
+	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE) &&
+	    !cpu_has_feature(CPU_FTR_NOEXECUTE)) {
 		unsigned long pfn = pte_pfn(pte);
 		if (pfn_valid(pfn)) {
 			struct page *page = pfn_to_page(pfn);
diff -puN arch/ppc64/mm/slb.c~cpu-has-feature arch/ppc64/mm/slb.c
--- linux-2.5/arch/ppc64/mm/slb.c~cpu-has-feature	2005-02-05 11:11:03.683586256 -0600
+++ linux-2.5-olof/arch/ppc64/mm/slb.c	2005-02-05 11:11:04.125519072 -0600
@@ -51,7 +51,7 @@ static void slb_flush_and_rebolt(void)
 
 	WARN_ON(!irqs_disabled());
 
-	if (cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE)
+	if (cpu_has_feature(CPU_FTR_16M_PAGE))
 		ksp_flags |= SLB_VSID_L;
 
 	ksp_esid_data = mk_esid_data(get_paca()->kstack, 2);
@@ -139,7 +139,7 @@ void slb_initialize(void)
 	unsigned long flags = SLB_VSID_KERNEL;
 
  	/* Invalidate the entire SLB (even slot 0) & all the ERATS */
- 	if (cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE)
+ 	if (cpu_has_feature(CPU_FTR_16M_PAGE))
  		flags |= SLB_VSID_L;
 
  	asm volatile("isync":::"memory");
diff -puN arch/ppc64/mm/stab.c~cpu-has-feature arch/ppc64/mm/stab.c
--- linux-2.5/arch/ppc64/mm/stab.c~cpu-has-feature	2005-02-05 11:11:03.704583064 -0600
+++ linux-2.5-olof/arch/ppc64/mm/stab.c	2005-02-05 11:11:04.125519072 -0600
@@ -227,7 +227,7 @@ void stab_initialize(unsigned long stab)
 {
 	unsigned long vsid = get_kernel_vsid(KERNELBASE);
 
-	if (cur_cpu_spec->cpu_features & CPU_FTR_SLB) {
+	if (cpu_has_feature(CPU_FTR_SLB)) {
 		slb_initialize();
 	} else {
 		asm volatile("isync; slbia; isync":::"memory");
diff -puN arch/ppc64/oprofile/op_model_power4.c~cpu-has-feature arch/ppc64/oprofile/op_model_power4.c
--- linux-2.5/arch/ppc64/oprofile/op_model_power4.c~cpu-has-feature	2005-02-05 11:11:03.764573944 -0600
+++ linux-2.5-olof/arch/ppc64/oprofile/op_model_power4.c	2005-02-05 11:11:04.126518920 -0600
@@ -54,7 +54,7 @@ static void power4_reg_setup(struct op_c
 	 *
 	 * It has been verified to work on POWER5 so we enable it there.
 	 */
-	if (cur_cpu_spec->cpu_features & CPU_FTR_MMCRA_SIHV)
+	if (cpu_has_feature(CPU_FTR_MMCRA_SIHV))
 		mmcra_has_sihv = 1;
 
 	/*
diff -puN arch/ppc64/oprofile/op_model_rs64.c~cpu-has-feature arch/ppc64/oprofile/op_model_rs64.c
--- linux-2.5/arch/ppc64/oprofile/op_model_rs64.c~cpu-has-feature	2005-02-05 11:11:03.768573336 -0600
+++ linux-2.5-olof/arch/ppc64/oprofile/op_model_rs64.c	2005-02-05 11:11:04.126518920 -0600
@@ -114,7 +114,7 @@ static void rs64_cpu_setup(void *unused)
 	/* reset MMCR1, MMCRA */
 	mtspr(SPRN_MMCR1, 0);
 
-	if (cur_cpu_spec->cpu_features & CPU_FTR_MMCRA)
+	if (cpu_has_feature(CPU_FTR_MMCRA))
 		mtspr(SPRN_MMCRA, 0);
 
 	mmcr0 |= MMCR0_FCM1|MMCR0_PMXE|MMCR0_FCECE;
diff -puN arch/ppc64/xmon/xmon.c~cpu-has-feature arch/ppc64/xmon/xmon.c
--- linux-2.5/arch/ppc64/xmon/xmon.c~cpu-has-feature	2005-02-05 11:11:03.814566344 -0600
+++ linux-2.5-olof/arch/ppc64/xmon/xmon.c	2005-02-05 11:11:04.128518616 -0600
@@ -723,7 +723,7 @@ static void insert_cpu_bpts(void)
 {
 	if (dabr.enabled)
 		set_controlled_dabr(dabr.address | (dabr.enabled & 7));
-	if (iabr && (cur_cpu_spec->cpu_features & CPU_FTR_IABR))
+	if (iabr && cpu_has_feature(CPU_FTR_IABR))
 		set_iabr(iabr->address
 			 | (iabr->enabled & (BP_IABR|BP_IABR_TE)));
 }
@@ -751,7 +751,7 @@ static void remove_bpts(void)
 static void remove_cpu_bpts(void)
 {
 	set_controlled_dabr(0);
-	if ((cur_cpu_spec->cpu_features & CPU_FTR_IABR))
+	if (cpu_has_feature(CPU_FTR_IABR))
 		set_iabr(0);
 }
 
@@ -1098,7 +1098,7 @@ bpt_cmds(void)
 		break;
 
 	case 'i':	/* bi - hardware instr breakpoint */
-		if (!(cur_cpu_spec->cpu_features & CPU_FTR_IABR)) {
+		if (!cpu_has_feature(CPU_FTR_IABR)) {
 			printf("Hardware instruction breakpoint "
 			       "not supported on this cpu\n");
 			break;
@@ -2496,7 +2496,7 @@ void xmon_init(void)
 
 void dump_segments(void)
 {
-	if (cur_cpu_spec->cpu_features & CPU_FTR_SLB)
+	if (cpu_has_feature(CPU_FTR_SLB))
 		dump_slb();
 	else
 		dump_stab();
diff -puN include/asm-ppc64/cacheflush.h~cpu-has-feature include/asm-ppc64/cacheflush.h
--- linux-2.5/include/asm-ppc64/cacheflush.h~cpu-has-feature	2005-02-05 11:11:03.836563000 -0600
+++ linux-2.5-olof/include/asm-ppc64/cacheflush.h	2005-02-05 11:11:04.129518464 -0600
@@ -40,7 +40,7 @@ extern void __flush_dcache_icache(void *
 
 static inline void flush_icache_range(unsigned long start, unsigned long stop)
 {
-	if (!(cur_cpu_spec->cpu_features & CPU_FTR_COHERENT_ICACHE))
+	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
 		__flush_icache_range(start, stop);
 }
 
diff -puN include/asm-ppc64/mmu_context.h~cpu-has-feature include/asm-ppc64/mmu_context.h
--- linux-2.5/include/asm-ppc64/mmu_context.h~cpu-has-feature	2005-02-05 11:11:03.841562240 -0600
+++ linux-2.5-olof/include/asm-ppc64/mmu_context.h	2005-02-05 11:11:04.129518464 -0600
@@ -59,11 +59,11 @@ static inline void switch_mm(struct mm_s
 		return;
 
 #ifdef CONFIG_ALTIVEC
-	if (cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC)
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		asm volatile ("dssall");
 #endif /* CONFIG_ALTIVEC */
 
-	if (cur_cpu_spec->cpu_features & CPU_FTR_SLB)
+	if (cpu_has_feature(CPU_FTR_SLB))
 		switch_slb(tsk, next);
 	else
 		switch_stab(tsk, next);
diff -puN include/asm-ppc64/page.h~cpu-has-feature include/asm-ppc64/page.h
--- linux-2.5/include/asm-ppc64/page.h~cpu-has-feature	2005-02-05 11:11:03.845561632 -0600
+++ linux-2.5-olof/include/asm-ppc64/page.h	2005-02-05 11:11:04.130518312 -0600
@@ -67,7 +67,7 @@
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 
 #define in_hugepage_area(context, addr) \
-	((cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE) && \
+	(cpu_has_feature(CPU_FTR_16M_PAGE) && \
 	 ( (((addr) >= TASK_HPAGE_BASE) && ((addr) < TASK_HPAGE_END)) || \
 	   ( ((addr) < 0x100000000L) && \
 	     ((1 << GET_ESID(addr)) & (context).htlb_segs) ) ) )
diff -puN arch/ppc64/kernel/pSeries_lpar.c~cpu-has-feature arch/ppc64/kernel/pSeries_lpar.c
--- linux-2.5/arch/ppc64/kernel/pSeries_lpar.c~cpu-has-feature	2005-02-05 11:11:03.848561176 -0600
+++ linux-2.5-olof/arch/ppc64/kernel/pSeries_lpar.c	2005-02-05 11:11:04.130518312 -0600
@@ -505,7 +505,7 @@ void pSeries_lpar_flush_hash_range(unsig
 	int i;
 	unsigned long flags = 0;
 	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
-	int lock_tlbie = !(cur_cpu_spec->cpu_features & CPU_FTR_LOCKLESS_TLBIE);
+	int lock_tlbie = !cpu_has_feature(CPU_FTR_LOCKLESS_TLBIE);
 
 	if (lock_tlbie)
 		spin_lock_irqsave(&pSeries_lpar_tlbie_lock, flags);
diff -puN arch/ppc64/kernel/setup.c~cpu-has-feature arch/ppc64/kernel/setup.c
--- linux-2.5/arch/ppc64/kernel/setup.c~cpu-has-feature	2005-02-05 11:11:03.853560416 -0600
+++ linux-2.5-olof/arch/ppc64/kernel/setup.c	2005-02-05 11:11:04.132518008 -0600
@@ -315,7 +315,7 @@ static void __init setup_cpu_maps(void)
 		maxcpus = ireg[num_addr_cell + num_size_cell];
 
 		/* Double maxcpus for processors which have SMT capability */
-		if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+		if (cpu_has_feature(CPU_FTR_SMT))
 			maxcpus *= 2;
 
 		if (maxcpus > NR_CPUS) {
@@ -339,7 +339,7 @@ static void __init setup_cpu_maps(void)
 	 */
 	for_each_cpu(cpu) {
 		cpu_set(cpu, cpu_sibling_map[cpu]);
-		if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+		if (cpu_has_feature(CPU_FTR_SMT))
 			cpu_set(cpu ^ 0x1, cpu_sibling_map[cpu]);
 	}
 
@@ -767,7 +767,7 @@ static int show_cpuinfo(struct seq_file 
 		seq_printf(m, "unknown (%08x)", pvr);
 
 #ifdef CONFIG_ALTIVEC
-	if (cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC)
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		seq_printf(m, ", altivec supported");
 #endif /* CONFIG_ALTIVEC */
 
diff -puN drivers/macintosh/via-pmu.c~cpu-has-feature drivers/macintosh/via-pmu.c
--- linux-2.5/drivers/macintosh/via-pmu.c~cpu-has-feature	2005-02-05 11:11:03.895554032 -0600
+++ linux-2.5-olof/drivers/macintosh/via-pmu.c	2005-02-05 11:11:04.134517704 -0600
@@ -2389,7 +2389,7 @@ pmac_suspend_devices(void)
 	enable_kernel_fp();
 
 #ifdef CONFIG_ALTIVEC
-	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC)
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		enable_kernel_altivec();
 #endif /* CONFIG_ALTIVEC */
 
diff -puN include/asm-ppc/cputable.h~cpu-has-feature include/asm-ppc/cputable.h
--- linux-2.5/include/asm-ppc/cputable.h~cpu-has-feature	2005-02-05 11:11:03.919550384 -0600
+++ linux-2.5-olof/include/asm-ppc/cputable.h	2005-02-05 21:14:25.443082280 -0600
@@ -61,6 +61,11 @@ struct cpu_spec {
 extern struct cpu_spec		cpu_specs[];
 extern struct cpu_spec		*cur_cpu_spec[];
 
+static inline unsigned int cpu_has_feature(unsigned int feature)
+{
+	return cur_cpu_spec[0]->cpu_features & feature;
+}
+
 #endif /* __ASSEMBLY__ */
 
 /* CPU kernel features */
diff -puN arch/ppc/mm/ppc_mmu.c~cpu-has-feature arch/ppc/mm/ppc_mmu.c
--- linux-2.5/arch/ppc/mm/ppc_mmu.c~cpu-has-feature	2005-02-05 11:11:03.976541720 -0600
+++ linux-2.5-olof/arch/ppc/mm/ppc_mmu.c	2005-02-05 11:11:04.136517400 -0600
@@ -138,7 +138,7 @@ void __init setbat(int index, unsigned l
 	union ubat *bat = BATS[index];
 
 	if (((flags & _PAGE_NO_CACHE) == 0) &&
-	    (cur_cpu_spec[0]->cpu_features & CPU_FTR_NEED_COHERENT))
+	    cpu_has_feature(CPU_FTR_NEED_COHERENT))
 		flags |= _PAGE_COHERENT;
 
 	bl = (size >> 17) - 1;
@@ -191,7 +191,7 @@ void __init MMU_init_hw(void)
 	extern unsigned int hash_page[];
 	extern unsigned int flush_hash_patch_A[], flush_hash_patch_B[];
 
-	if ((cur_cpu_spec[0]->cpu_features & CPU_FTR_HPTE_TABLE) == 0) {
+	if (!cpu_has_feature(CPU_FTR_HPTE_TABLE)) {
 		/*
 		 * Put a blr (procedure return) instruction at the
 		 * start of hash_page, since we can still get DSI
diff -puN arch/ppc/mm/mmu_decl.h~cpu-has-feature arch/ppc/mm/mmu_decl.h
--- linux-2.5/arch/ppc/mm/mmu_decl.h~cpu-has-feature	2005-02-05 11:11:03.979541264 -0600
+++ linux-2.5-olof/arch/ppc/mm/mmu_decl.h	2005-02-05 11:11:04.136517400 -0600
@@ -75,7 +75,7 @@ static inline void flush_HPTE(unsigned c
 			      unsigned long pdval)
 {
 	if ((Hash != 0) &&
-	    (cur_cpu_spec[0]->cpu_features & CPU_FTR_HPTE_TABLE))
+	    cpu_has_feature(CPU_FTR_HPTE_TABLE))
 		flush_hash_pages(0, va, pdval, 1);
 	else
 		_tlbie(va);
diff -puN arch/ppc/kernel/setup.c~cpu-has-feature arch/ppc/kernel/setup.c
--- linux-2.5/arch/ppc/kernel/setup.c~cpu-has-feature	2005-02-05 11:11:04.018535336 -0600
+++ linux-2.5-olof/arch/ppc/kernel/setup.c	2005-02-05 11:11:04.137517248 -0600
@@ -619,7 +619,7 @@ machine_init(unsigned long r3, unsigned 
 /* Checks "l2cr=xxxx" command-line option */
 int __init ppc_setup_l2cr(char *str)
 {
-	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_L2CR) {
+	if (cpu_has_feature(CPU_FTR_L2CR)) {
 		unsigned long val = simple_strtoul(str, NULL, 0);
 		printk(KERN_INFO "l2cr set to %lx\n", val);
 		_set_L2CR(0);		/* force invalidate by disable cache */
@@ -720,7 +720,7 @@ void __init setup_arch(char **cmdline_p)
 	 * Systems with OF can look in the properties on the cpu node(s)
 	 * for a possibly more accurate value.
 	 */
-	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_SPLIT_ID_CACHE) {
+	if (cpu_has_feature(CPU_FTR_SPLIT_ID_CACHE)) {
 		dcache_bsize = cur_cpu_spec[0]->dcache_bsize;
 		icache_bsize = cur_cpu_spec[0]->icache_bsize;
 		ucache_bsize = 0;
diff -puN arch/ppc/kernel/temp.c~cpu-has-feature arch/ppc/kernel/temp.c
--- linux-2.5/arch/ppc/kernel/temp.c~cpu-has-feature	2005-02-05 11:11:04.024534424 -0600
+++ linux-2.5-olof/arch/ppc/kernel/temp.c	2005-02-05 11:11:04.137517248 -0600
@@ -223,7 +223,7 @@ int __init TAU_init(void)
 	/* We assume in SMP that if one CPU has TAU support, they
 	 * all have it --BenH
 	 */
-	if (!(cur_cpu_spec[0]->cpu_features & CPU_FTR_TAU)) {
+	if (!cpu_has_feature(CPU_FTR_TAU)) {
 		printk("Thermal assist unit not available\n");
 		tau_initialized = 0;
 		return 1;
diff -puN arch/ppc/platforms/pmac_cpufreq.c~cpu-has-feature arch/ppc/platforms/pmac_cpufreq.c
--- linux-2.5/arch/ppc/platforms/pmac_cpufreq.c~cpu-has-feature	2005-02-05 11:11:04.064528344 -0600
+++ linux-2.5-olof/arch/ppc/platforms/pmac_cpufreq.c	2005-02-05 11:11:04.138517096 -0600
@@ -230,7 +230,7 @@ static int __pmac pmu_set_cpu_speed(int 
 	enable_kernel_fp();
 
 #ifdef CONFIG_ALTIVEC
-	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC)
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		enable_kernel_altivec();
 #endif /* CONFIG_ALTIVEC */
 
diff -puN arch/ppc/platforms/pmac_setup.c~cpu-has-feature arch/ppc/platforms/pmac_setup.c
--- linux-2.5/arch/ppc/platforms/pmac_setup.c~cpu-has-feature	2005-02-05 11:11:04.068527736 -0600
+++ linux-2.5-olof/arch/ppc/platforms/pmac_setup.c	2005-02-05 11:11:04.139516944 -0600
@@ -274,7 +274,7 @@ pmac_setup_arch(void)
 	pmac_find_bridges();
 
 	/* Checks "l2cr-value" property in the registry */
-	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_L2CR) {
+	if (cpu_has_feature(CPU_FTR_L2CR)) {
 		struct device_node *np = find_devices("cpus");
 		if (np == 0)
 			np = find_type_devices("cpu");
diff -puN arch/ppc/platforms/pmac_smp.c~cpu-has-feature arch/ppc/platforms/pmac_smp.c
--- linux-2.5/arch/ppc/platforms/pmac_smp.c~cpu-has-feature	2005-02-05 11:11:04.071527280 -0600
+++ linux-2.5-olof/arch/ppc/platforms/pmac_smp.c	2005-02-05 11:11:04.139516944 -0600
@@ -119,7 +119,7 @@ static volatile int sec_tb_reset = 0;
 
 static void __init core99_init_caches(int cpu)
 {
-	if (!(cur_cpu_spec[0]->cpu_features & CPU_FTR_L2CR))
+	if (!cpu_has_feature(CPU_FTR_L2CR))
 		return;
 
 	if (cpu == 0) {
@@ -132,7 +132,7 @@ static void __init core99_init_caches(in
 		printk("CPU%d: L2CR set to %lx\n", cpu, core99_l2_cache);
 	}
 
-	if (!(cur_cpu_spec[0]->cpu_features & CPU_FTR_L3CR))
+	if (!cpu_has_feature(CPU_FTR_L3CR))
 		return;
 
 	if (cpu == 0){
diff -puN arch/ppc/platforms/sandpoint.c~cpu-has-feature arch/ppc/platforms/sandpoint.c
--- linux-2.5/arch/ppc/platforms/sandpoint.c~cpu-has-feature	2005-02-05 11:11:04.074526824 -0600
+++ linux-2.5-olof/arch/ppc/platforms/sandpoint.c	2005-02-05 11:11:04.140516792 -0600
@@ -319,10 +319,10 @@ sandpoint_setup_arch(void)
 	 * We will do this now with good known values.  Future versions
 	 * of DINK32 are supposed to get this correct.
 	 */
-	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_SPEC7450)
+	if (cpu_has_feature(CPU_FTR_SPEC7450))
 		/* 745x is different.  We only want to pass along enable. */
 		_set_L2CR(L2CR_L2E);
-	else if (cur_cpu_spec[0]->cpu_features & CPU_FTR_L2CR)
+	else if (cpu_has_feature(CPU_FTR_L2CR))
 		/* All modules have 1MB of L2.  We also assume that an
 		 * L2 divisor of 3 will work.
 		 */
@@ -330,7 +330,7 @@ sandpoint_setup_arch(void)
 				| L2CR_L2RAM_PIPE | L2CR_L2OH_1_0 | L2CR_L2DF);
 #if 0
 	/* Untested right now. */
-	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_L3CR) {
+	if (cpu_has_feature(CPU_FTR_L3CR)) {
 		/* Magic value. */
 		_set_L3CR(0x8f032000);
 	}
diff -puN arch/ppc/kernel/ppc_htab.c~cpu-has-feature arch/ppc/kernel/ppc_htab.c
--- linux-2.5/arch/ppc/kernel/ppc_htab.c~cpu-has-feature	2005-02-05 11:11:04.077526368 -0600
+++ linux-2.5-olof/arch/ppc/kernel/ppc_htab.c	2005-02-05 11:11:04.141516640 -0600
@@ -108,7 +108,7 @@ static int ppc_htab_show(struct seq_file
 	PTE *ptr;
 #endif /* CONFIG_PPC_STD_MMU */
 
-	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON) {
+	if (cpu_has_feature(CPU_FTR_604_PERF_MON)) {
 		mmcr0 = mfspr(SPRN_MMCR0);
 		pmc1 = mfspr(SPRN_PMC1);
 		pmc2 = mfspr(SPRN_PMC2);
@@ -209,7 +209,7 @@ static ssize_t ppc_htab_write(struct fil
 
 	if ( !strncmp( buffer, "reset", 5) )
 	{
-		if (cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON) {
+		if (cpu_has_feature(CPU_FTR_604_PERF_MON)) {
 			/* reset PMC1 and PMC2 */
 			mtspr(SPRN_PMC1, 0);
 			mtspr(SPRN_PMC2, 0);
@@ -221,7 +221,7 @@ static ssize_t ppc_htab_write(struct fil
 	}
 
 	/* Everything below here requires the performance monitor feature. */
-	if ( !cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON )
+	if (!cpu_has_feature(CPU_FTR_604_PERF_MON))
 		return count;
 
 	/* turn off performance monitoring */
@@ -339,7 +339,7 @@ int proc_dol2crvec(ctl_table *table, int
 		"0.5", "1.0", "(reserved2)", "(reserved3)"
 	};
 
-	if (!(cur_cpu_spec[0]->cpu_features & CPU_FTR_L2CR))
+	if (!cpu_has_feature(CPU_FTR_L2CR))
 		return -EFAULT;
 
 	if ( /*!table->maxlen ||*/ (*ppos && !write)) {
diff -puN drivers/md/raid6altivec.uc~cpu-has-feature drivers/md/raid6altivec.uc
--- linux-2.5/drivers/md/raid6altivec.uc~cpu-has-feature	2005-02-05 11:11:04.081525760 -0600
+++ linux-2.5-olof/drivers/md/raid6altivec.uc	2005-02-05 11:11:05.007385008 -0600
@@ -108,7 +108,7 @@ int raid6_have_altivec(void);
 int raid6_have_altivec(void)
 {
 	/* This assumes either all CPUs have Altivec or none does */
-	return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;
+	return cpu_has_feature(CPU_FTR_ALTIVEC):
 }
 #endif
 

_
