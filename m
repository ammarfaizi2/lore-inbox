Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbUJYH77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbUJYH77 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 03:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUJYH5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 03:57:45 -0400
Received: from cantor.suse.de ([195.135.220.2]:20384 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261693AbUJYHZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:25:42 -0400
Date: Mon, 25 Oct 2004 09:23:50 +0200
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 17/17] 4level support for x86_64
Message-ID: <417CAA06.mail4031E2FIL@wotan.suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ak@suse.de (Andreas Kleen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4level support for x86_64

This patch extends x86-64 to use a true 4level VM. This extends
all user address spaces to 47bits (128TB) 

fork/exec performance in lmbench is down by a few percent because they
have to walk more page tables right now. There are plans to recovers
this with future optimizations.

Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux-2.6.10rc1/Documentation/x86_64/mm.txt linux-2.6.10rc1-4level/Documentation/x86_64/mm.txt
--- linux-2.6.10rc1/Documentation/x86_64/mm.txt	2004-03-21 21:12:12.000000000 +0100
+++ linux-2.6.10rc1-4level/Documentation/x86_64/mm.txt	2004-10-25 04:48:09.000000000 +0200
@@ -1,148 +1,24 @@
-The paging design used on the x86-64 linux kernel port in 2.4.x provides:
 
-o	per process virtual address space limit of 512 Gigabytes
-o	top of userspace stack located at address 0x0000007fffffffff
-o	PAGE_OFFSET = 0xffff800000000000
-o	start of the kernel = 0xffffffff800000000
-o	global RAM per system 2^64-PAGE_OFFSET-sizeof(kernel) = 128 Terabytes - 2 Gigabytes
-o	no need of any common code change
-o	no need to use highmem to handle the 128 Terabytes of RAM
+<previous description obsolete, deleted> 
+ 
+Virtual memory map with 4 level page tables: 
+
+0000000000000000 - 00007fffffffffff (=47bits) user space, different per mm
+hole caused by [48:63] sign extension
+ffff800000000000 - ffff80ffffffffff (=40bits) guard hole
+ffff810000000000 - ffffc0ffffffffff (=46bits) direct mapping of phys. memory
+ffffc10000000000 - ffffc1ffffffffff (=40bits) hole
+ffffc20000000000 - ffffe1ffffffffff (=45bits) vmalloc/ioremap space
+... unused hole ... 
+ffffffff80000000 - ffffffff82800000 (=40MB)   kernel text mapping, from phys 0
+... unused hole ...
+ffffffff88000000 - fffffffffff00000 (=1919MB) module mapping space
+
+vmalloc space is lazily synchronized into the different PML4 pages of
+the processes using the page fault handler, with init_level4_pgt as
+reference.
 
-Description:
+Current X86-64 implementations only support 40 bit of address space,
+but we support upto 46bits. This expands into MBZ space in the page tables.
 
-	Userspace is able to modify and it sees only the 3rd/2nd/1st level
-	pagetables (pgd_offset() implicitly walks the 1st slot of the 4th
-	level pagetable and it returns an entry into the 3rd level pagetable).
-	This is where the per-process 512 Gigabytes limit cames from.
-
-	The common code pgd is the PDPE, the pmd is the PDE, the
-	pte is the PTE. The PML4E remains invisible to the common
-	code.
-
-	The kernel uses all the first 47 bits of the negative half
-	of the virtual address space to build the direct mapping using
-	2 Mbytes page size. The kernel virtual	addresses have bit number
-	47 always set to 1 (and in turn also bits 48-63 are set to 1 too,
-	due the sign extension). This is where the 128 Terabytes - 2 Gigabytes global
-	limit of RAM cames from.
-
-	Since the per-process limit is 512 Gigabytes (due to kernel common
-	code 3 level pagetable limitation), the higher virtual address mapped
-	into userspace is 0x7fffffffff and it makes sense to use it
-	as the top of the userspace stack to allow the stack to grow as
-	much as possible.
-
-	Setting the PAGE_OFFSET to 2^39 (after the last userspace
-	virtual address) wouldn't make much difference compared to
-	setting PAGE_OFFSET to 0xffff800000000000 because we have an
-	hole into the virtual address space. The last byte mapped by the
-	255th slot in the 4th level pagetable is at virtual address
-	0x00007fffffffffff and the first byte mapped by the 256th slot in the
-	4th level pagetable is at address 0xffff800000000000. Due to this
-	hole we can't trivially build a direct mapping across all the
-	512 slots of the 4th level pagetable, so we simply use only the
-	second (negative) half of the 4th level pagetable for that purpose
-	(that provides us 128 Terabytes of contigous virtual addresses).
-	Strictly speaking we could build a direct mapping also across the hole
-	using some DISCONTIGMEM trick, but we don't need such a large
-	direct mapping right now.
-
-Future:
-
-	During 2.5.x we can break the 512 Gigabytes per-process limit
-	possibly by removing from the common code any knowledge about the
-	architectural dependent physical layout of the virtual to physical
-	mapping.
-
-	Once the 512 Gigabytes limit will be removed the kernel stack will
-	be moved (most probably to virtual address 0x00007fffffffffff).
-	Nothing	will break in userspace due that move, as nothing breaks
-	in IA32 compiling the kernel with CONFIG_2G.
-
-Linus agreed on not breaking common code and to live with the 512 Gigabytes
-per-process limitation for the 2.4.x timeframe and he has given me and Andi
-some very useful hints... (thanks! :)
-
-Thanks also to H. Peter Anvin for his interesting and useful suggestions on
-the x86-64-discuss lists!
-
-Other memory management related issues follows:
-
-PAGE_SIZE:
-
-	If somebody is wondering why these days we still have a so small
-	4k pagesize (16 or 32 kbytes would be much better for performance
-	of course), the PAGE_SIZE have to remain 4k for 32bit apps to
-	provide 100% backwards compatible IA32 API (we can't allow silent
-	fs corruption or as best a loss of coherency with the page cache
-	by allocating MAP_SHARED areas in MAP_ANONYMOUS memory with a
-	do_mmap_fake). I think it could be possible to have a dynamic page
-	size between 32bit and 64bit apps but it would need extremely
-	intrusive changes in the common code as first for page cache and
-	we sure don't want to depend on them right now even if the
-	hardware would support that.
-
-PAGETABLE SIZE:
-
-	In turn we can't afford to have pagetables larger than 4k because
-	we could not be able to allocate them due physical memory
-	fragmentation, and failing to allocate the kernel stack is a minor
-	issue compared to failing the allocation of a pagetable. If we
-	fail the allocation of a pagetable the only thing we can do is to
-	sched_yield polling the freelist (deadlock prone) or to segfault
-	the task (not even the sighandler would be sure to run).
-
-KERNEL STACK:
-
-	1st stage:
-
-	The kernel stack will be at first allocated with an order 2 allocation
-	(16k) (the utilization of the stack for a 64bit platform really
-	isn't exactly the double of a 32bit platform because the local
-	variables may not be all 64bit wide, but not much less). This will
-	make things even worse than they are right now on IA32 with
-	respect of failing fork/clone due memory fragmentation.
-
-	2nd stage:
-
-	We'll benchmark if reserving one register as task_struct
-	pointer will improve performance of the kernel (instead of
-	recalculating the task_struct pointer starting from the stack
-	pointer each time). My guess is that recalculating will be faster
-	but it worth a try.
-
-		If reserving one register for the task_struct pointer
-		will be faster we can as well split task_struct and kernel
-		stack. task_struct can be a slab allocation or a
-		PAGE_SIZEd allocation, and the kernel stack can then be
-		allocated in a order 1 allocation. Really this is risky,
-		since 8k on a 64bit platform is going to be less than 7k
-		on a 32bit platform but we could try it out. This would
-		reduce the fragmentation problem of an order of magnitude
-		making it equal to the current IA32.
-
-		We must also consider the x86-64 seems to provide in hardware a
-		per-irq stack that could allow us to remove the irq handler
-		footprint from the regular per-process-stack, so it could allow
-		us to live with a smaller kernel stack compared to the other
-		linux architectures.
-
-	3rd stage:
-
-	Before going into production if we still have the order 2
-	allocation we can add a sysctl that allows the kernel stack to be
-	allocated with vmalloc during memory fragmentation. This have to
-	remain turned off during benchmarks :) but it should be ok in real
-	life.
-
-Order of PAGE_CACHE_SIZE and other allocations:
-
-	On the long run we can increase the PAGE_CACHE_SIZE to be
-	an order 2 allocations and also the slab/buffercache etc.ec..
-	could be all done with order 2 allocations. To make the above
-	to work we should change lots of common code thus it can be done
-	only once the basic port will be in a production state. Having
-	a working PAGE_CACHE_SIZE would be a benefit also for
-	IA32 and other architectures of course.
-
-Andrea <andrea@suse.de> SuSE
+-Andi Kleen, Jul 2004
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/x86_64/ia32/syscall32.c linux-2.6.10rc1-4level/arch/x86_64/ia32/syscall32.c
--- linux-2.6.10rc1/arch/x86_64/ia32/syscall32.c	2004-10-19 01:55:08.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/x86_64/ia32/syscall32.c	2004-10-25 04:48:09.000000000 +0200
@@ -40,23 +40,30 @@ static int use_sysenter __initdata = -1;
  */
 int __map_syscall32(struct mm_struct *mm, unsigned long address)
 { 
+	pml4_t *pml4;
+	pgd_t *pgd;
 	pte_t *pte;
 	pmd_t *pmd;
-	int err = 0;
+	int err = -ENOMEM;
 
 	spin_lock(&mm->page_table_lock); 
-	pmd = pmd_alloc(mm, pgd_offset(mm, address), address); 
-	if (pmd && (pte = pte_alloc_map(mm, pmd, address)) != NULL) { 
-		if (pte_none(*pte)) { 
-			set_pte(pte, 
-				mk_pte(virt_to_page(syscall32_page), 
-				       PAGE_KERNEL_VSYSCALL)); 
+ 	pml4 = pml4_offset(mm, address); 
+ 	pgd = pgd_alloc(mm, pml4, address);
+ 	if (pgd) { 
+ 		pmd = pmd_alloc(mm, pgd, address); 
+ 		if (pmd && (pte = pte_alloc_map(mm, pmd, address)) != NULL) { 
+ 			if (pte_none(*pte)) { 
+ 				set_pte(pte, 
+ 					mk_pte(virt_to_page(syscall32_page), 
+ 					       PAGE_KERNEL_VSYSCALL)); 
+ 			}
+ 			/* Flush only the local CPU. Other CPUs taking a fault
+ 			   will just end up here again
+			   This probably not needed and just paranoia. */
+ 			__flush_tlb_one(address); 
+ 			err = 0;
 		}
-		/* Flush only the local CPU. Other CPUs taking a fault
-		   will just end up here again */
-		__flush_tlb_one(address); 
-	} else
-		err = -ENOMEM; 
+	}
 	spin_unlock(&mm->page_table_lock);
 	return err;
 }
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/x86_64/kernel/acpi/sleep.c linux-2.6.10rc1-4level/arch/x86_64/kernel/acpi/sleep.c
--- linux-2.6.10rc1/arch/x86_64/kernel/acpi/sleep.c	2004-06-16 12:22:54.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/x86_64/kernel/acpi/sleep.c	2004-10-25 04:48:09.000000000 +0200
@@ -61,9 +61,13 @@ extern char wakeup_start, wakeup_end;
 
 extern unsigned long FASTCALL(acpi_copy_wakeup_routine(unsigned long));
 
+static pml4_t low_ptr; 
+
 static void init_low_mapping(void)
 {
-	cpu_pda[0].level4_pgt[0] = cpu_pda[0].level4_pgt[pml4_index(PAGE_OFFSET)];
+	pml4_t *slot0 = pml4_offset(current->mm, 0UL);
+	low_ptr = *slot0;
+	set_pml4(slot0, *pml4_offset(current->mm, PAGE_OFFSET)); 
 	flush_tlb_all();
 }
 
@@ -97,7 +101,7 @@ int acpi_save_state_disk (void)
  */
 void acpi_restore_state_mem (void)
 {
-	cpu_pda[0].level4_pgt[0] = 0;
+	set_pml4(pml4_offset(current->mm, 0UL), low_ptr); 
 	flush_tlb_all();
 }
 
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/x86_64/kernel/head.S linux-2.6.10rc1-4level/arch/x86_64/kernel/head.S
--- linux-2.6.10rc1/arch/x86_64/kernel/head.S	1970-01-01 01:12:51.000000000 +0100
+++ linux-2.6.10rc1-4level/arch/x86_64/kernel/head.S	2004-10-25 04:48:09.000000000 +0200
@@ -213,7 +213,6 @@ ENTRY(init_level4_pgt)
 	.quad	0x0000000000103007		/* -> level3_kernel_pgt */
 
 .org 0x2000
-/* Kernel does not "know" about 4-th level of page tables. */
 ENTRY(level3_ident_pgt)
 	.quad	0x0000000000104007
 	.fill	511,8,0
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/x86_64/kernel/init_task.c linux-2.6.10rc1-4level/arch/x86_64/kernel/init_task.c
--- linux-2.6.10rc1/arch/x86_64/kernel/init_task.c	2004-10-19 01:55:08.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/x86_64/kernel/init_task.c	2004-10-25 04:48:10.000000000 +0200
@@ -47,5 +47,3 @@ EXPORT_SYMBOL(init_task);
 DEFINE_PER_CPU(struct tss_struct, init_tss) ____cacheline_maxaligned_in_smp;
 
 #define ALIGN_TO_4K __attribute__((section(".data.init_task")))
-
-pgd_t boot_vmalloc_pgt[512]  ALIGN_TO_4K;
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/x86_64/kernel/setup64.c linux-2.6.10rc1-4level/arch/x86_64/kernel/setup64.c
--- linux-2.6.10rc1/arch/x86_64/kernel/setup64.c	2004-10-25 04:47:15.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/x86_64/kernel/setup64.c	2004-10-25 04:48:10.000000000 +0200
@@ -100,7 +100,6 @@ void __init setup_per_cpu_areas(void)
 
 void pda_init(int cpu)
 { 
-        pml4_t *level4;
 	struct x8664_pda *pda = &cpu_pda[cpu];
 
 	/* Setup up data that may be needed in __get_free_pages early */
@@ -119,22 +118,14 @@ void pda_init(int cpu)
 		/* others are initialized in smpboot.c */
 		pda->pcurrent = &init_task;
 		pda->irqstackptr = boot_cpu_stack; 
-		level4 = init_level4_pgt; 
 	} else {
-		level4 = (pml4_t *)__get_free_pages(GFP_ATOMIC, 0); 
-		if (!level4) 
-			panic("Cannot allocate top level page for cpu %d", cpu); 
 		pda->irqstackptr = (char *)
 			__get_free_pages(GFP_ATOMIC, IRQSTACK_ORDER);
 		if (!pda->irqstackptr)
 			panic("cannot allocate irqstack for cpu %d", cpu); 
 	}
 
-	pda->level4_pgt = (unsigned long *)level4; 
-	if (level4 != init_level4_pgt)
-		memcpy(level4, &init_level4_pgt, PAGE_SIZE); 
-	set_pml4(level4 + 510, mk_kernel_pml4(__pa_symbol(boot_vmalloc_pgt)));
-	asm volatile("movq %0,%%cr3" :: "r" (__pa(level4))); 
+	asm volatile("movq %0,%%cr3" :: "r" (__pa_symbol(&init_level4_pgt)));
 
 	pda->irqstackptr += IRQSTACKSIZE-64;
 } 
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/x86_64/mm/fault.c linux-2.6.10rc1-4level/arch/x86_64/mm/fault.c
--- linux-2.6.10rc1/arch/x86_64/mm/fault.c	2004-10-19 01:55:09.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/x86_64/mm/fault.c	2004-10-25 04:48:10.000000000 +0200
@@ -230,7 +230,53 @@ static noinline void pgtable_bad(unsigne
 	do_exit(SIGKILL);
 }
 
-int page_fault_trace; 
+/* 
+ * Handle a fault on the vmalloc or module mapping area 
+ */
+static int vmalloc_fault(unsigned long address)
+{
+	pml4_t *pml4, *pml4_ref;
+	pgd_t *pgd, *pgd_ref;
+	pmd_t *pmd, *pmd_ref;
+	pte_t *pte, *pte_ref; 
+	
+	/* Copy kernel mappings over when needed. This can also
+	   happen within a race in page table update. In the later
+	   case just flush. */
+	
+	pml4 = pml4_offset(current->mm ?: &init_mm, address); 
+	pml4_ref = pml4_offset_k(address); 
+	if (pml4_none(*pml4_ref))
+		return -1;
+	if (pml4_none(*pml4))
+		set_pml4(pml4, *pml4_ref); 		
+	
+	/* Below here mismatches are bugs because these lower tables
+	   are shared */
+	
+	pgd = pml4_pgd_offset(pml4, address);
+	pgd_ref = pml4_pgd_offset(pml4_ref, address); 		
+	if (pgd_none(*pgd_ref))
+		return -1;
+	if (pgd_none(*pgd) || pgd_page(*pgd) != pgd_page(*pgd_ref))
+		BUG();
+	pmd = pmd_offset(pgd, address);
+	pmd_ref = pmd_offset(pgd_ref, address);
+	if (pmd_none(*pmd_ref))
+		return -1;
+	if (pmd_none(*pmd) || pmd_page(*pmd) != pmd_page(*pmd_ref))
+		BUG(); 
+	pte_ref = pte_offset_kernel(pmd_ref, address);
+	if (!pte_present(*pte_ref))
+		return -1;
+	pte = pte_offset_kernel(pmd, address);
+	if (!pte_present(*pte) || pte_page(*pte) != pte_page(*pte_ref))
+		BUG();
+	__flush_tlb_all();
+	return 0;
+}
+
+int page_fault_trace = 0; 
 int exception_trace = 1;
 
 /*
@@ -295,8 +341,11 @@ asmlinkage void do_page_fault(struct pt_
 	 * protection error (error_code & 1) == 0.
 	 */
 	if (unlikely(address >= TASK_SIZE)) {
-		if (!(error_code & 5))
-			goto vmalloc_fault;
+		if (!(error_code & 5)) {
+			if (vmalloc_fault(address) < 0) 
+				goto bad_area_nosemaphore;
+			return;
+		}
 		/*
 		 * Don't take the mm semaphore here. If we fixup a prefetch
 		 * fault we could otherwise deadlock.
@@ -305,7 +354,7 @@ asmlinkage void do_page_fault(struct pt_
 	}
 
 	if (unlikely(error_code & (1 << 3)))
-		goto page_table_corruption;
+		pgtable_bad(address, regs, error_code);
 
 	/*
 	 * If we're in an interrupt or have no user
@@ -519,34 +568,4 @@ do_sigbus:
 	info.si_addr = (void __user *)address;
 	force_sig_info(SIGBUS, &info, tsk);
 	return;
-
-vmalloc_fault:
-	{
-		pgd_t *pgd;
-		pmd_t *pmd;
-		pte_t *pte; 
-
-		/*
-		 * x86-64 has the same kernel 3rd level pages for all CPUs.
-		 * But for vmalloc/modules the TLB synchronization works lazily,
-		 * so it can happen that we get a page fault for something
-		 * that is really already in the page table. Just check if it
-		 * is really there and when yes flush the local TLB. 
-		 */
-		pgd = pgd_offset_k(address);
-		if (!pgd_present(*pgd))
-			goto bad_area_nosemaphore;
-		pmd = pmd_offset(pgd, address);
-		if (!pmd_present(*pmd))
-			goto bad_area_nosemaphore;
-		pte = pte_offset_kernel(pmd, address); 
-		if (!pte_present(*pte))
-			goto bad_area_nosemaphore;
-
-		__flush_tlb_all();		
-		return;
-	}
-
-page_table_corruption:
-	pgtable_bad(address, regs, error_code);
 }
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/x86_64/mm/init.c linux-2.6.10rc1-4level/arch/x86_64/mm/init.c
--- linux-2.6.10rc1/arch/x86_64/mm/init.c	2004-10-19 01:55:09.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/x86_64/mm/init.c	2004-10-25 04:48:10.000000000 +0200
@@ -120,7 +120,7 @@ static void set_pte_phys(unsigned long v
 		printk("PML4 FIXMAP MISSING, it should be setup in head.S!\n");
 		return;
 	}
-	pgd = level3_offset_k(level4, vaddr);
+	pgd = pml4_pgd_offset(level4, vaddr);
 	if (pgd_none(*pgd)) {
 		pmd = (pmd_t *) spp_getpage(); 
 		set_pgd(pgd, __pgd(__pa(pmd) | _KERNPG_TABLE | _PAGE_USER));
@@ -306,25 +306,12 @@ void __init init_memory_mapping(void) 
 
 extern struct x8664_pda cpu_pda[NR_CPUS];
 
-static unsigned long low_pml4[NR_CPUS];
-
-void swap_low_mappings(void)
-{
-	int i;
-	for (i = 0; i < NR_CPUS; i++) {
-	        unsigned long t;
-		if (!cpu_pda[i].level4_pgt) 
-			continue;
-		t = cpu_pda[i].level4_pgt[0];
-		cpu_pda[i].level4_pgt[0] = low_pml4[i];
-		low_pml4[i] = t;
-	}
-	flush_tlb_all();
-}
-
+/* Assumes all CPUs still execute in init_mm */
 void zap_low_mappings(void)
 {
-	swap_low_mappings();
+	pml4_t *pml4 = pml4_offset_k(0UL); 
+	pml4_clear(pml4); 
+	flush_tlb_all();
 }
 
 #ifndef CONFIG_DISCONTIGMEM
@@ -360,11 +347,15 @@ void __init clear_kernel_mapping(unsigne
 	BUG_ON(size & ~LARGE_PAGE_MASK); 
 	
 	for (; address < end; address += LARGE_PAGE_SIZE) { 
-		pgd_t *pgd = pgd_offset_k(address);
-               pmd_t *pmd;
-		if (!pgd || pgd_none(*pgd))
+		pml4_t *pml4 = pml4_offset_k(address);
+		pgd_t *pgd;
+		pmd_t *pmd;
+		if (pml4_none(*pml4))
+			continue; 
+		pgd = pml4_pgd_offset(pml4, address); 
+		if (pgd_none(*pgd))
 			continue; 
-               pmd = pmd_offset(pgd, address);
+		pmd = pmd_offset(pgd, address);
 		if (!pmd || pmd_none(*pmd))
 			continue; 
 		if (0 == (pmd_val(*pmd) & _PAGE_PSE)) { 
@@ -538,21 +529,21 @@ int kern_addr_valid(unsigned long addr) 
 	if (above != 0 && above != -1UL)
 		return 0; 
 	
-       pml4 = pml4_offset_k(addr);
+	pml4 = pml4_offset_k(addr);
 	if (pml4_none(*pml4))
 		return 0;
 
-       pgd = pgd_offset_k(addr);
+	pgd = pml4_pgd_offset(pml4, addr);
 	if (pgd_none(*pgd))
 		return 0; 
 
-       pmd = pmd_offset(pgd, addr);
+	pmd = pmd_offset(pgd, addr);
 	if (pmd_none(*pmd))
 		return 0;
 	if (pmd_large(*pmd))
 		return pfn_valid(pmd_pfn(*pmd));
 
-       pte = pte_offset_kernel(pmd, addr);
+	pte = pte_offset_kernel(pmd, addr);
 	if (pte_none(*pte))
 		return 0;
 	return pfn_valid(pte_pfn(*pte));
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/x86_64/mm/ioremap.c linux-2.6.10rc1-4level/arch/x86_64/mm/ioremap.c
--- linux-2.6.10rc1/arch/x86_64/mm/ioremap.c	2004-10-25 04:47:15.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/x86_64/mm/ioremap.c	2004-10-25 04:48:10.000000000 +0200
@@ -67,31 +67,54 @@ static inline int remap_area_pmd(pmd_t *
 	return 0;
 }
 
+static inline int remap_area_pgd(pgd_t * pgd, unsigned long address, unsigned long size,
+	unsigned long phys_addr, unsigned long flags)
+{
+	unsigned long end;
+
+	address &= ~PML4_MASK;
+	end = address + size;
+	if (end > PML4_SIZE)
+		end = PML4_SIZE;
+	phys_addr -= address;
+	if (address >= end)
+		BUG();
+	do {
+		pmd_t * pmd = pmd_alloc(&init_mm, pgd, address);
+		if (!pmd)
+			return -ENOMEM;
+		remap_area_pmd(pmd, address, end - address, address + phys_addr, flags);
+		address = (address + PGDIR_SIZE) & PGDIR_MASK;
+		pmd++;
+	} while (address && (address < end));
+	return 0;
+}
+
 static int remap_area_pages(unsigned long address, unsigned long phys_addr,
 				 unsigned long size, unsigned long flags)
 {
 	int error;
-	pgd_t * dir;
+	pml4_t *pml4;
 	unsigned long end = address + size;
 
 	phys_addr -= address;
-	dir = pgd_offset_k(address);
+	pml4 = pml4_offset_k(address); 
 	flush_cache_all();
 	if (address >= end)
 		BUG();
 	spin_lock(&init_mm.page_table_lock);
 	do {
-		pmd_t *pmd;
-		pmd = pmd_alloc(&init_mm, dir, address);
+		pgd_t *pgd;
+		pgd = pgd_alloc(&init_mm, pml4, address);
 		error = -ENOMEM;
-		if (!pmd)
+		if (!pgd)
 			break;
-		if (remap_area_pmd(pmd, address, end - address,
+		if (remap_area_pgd(pgd, address, end - address,
 					 phys_addr + address, flags))
 			break;
 		error = 0;
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
+		address = (address + PML4_SIZE) & PML4_MASK;
+		pml4++;
 	} while (address && (address < end));
 	spin_unlock(&init_mm.page_table_lock);
 	flush_tlb_all();
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/x86_64/mm/pageattr.c linux-2.6.10rc1-4level/arch/x86_64/mm/pageattr.c
--- linux-2.6.10rc1/arch/x86_64/mm/pageattr.c	2004-08-15 19:45:14.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/x86_64/mm/pageattr.c	2004-10-25 04:48:10.000000000 +0200
@@ -16,10 +16,14 @@
 
 static inline pte_t *lookup_address(unsigned long address) 
 { 
-	pgd_t *pgd = pgd_offset_k(address); 
+	pml4_t *pml4 = pml4_offset_k(address);
+	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
-	if (!pgd || !pgd_present(*pgd))
+	if (pml4_none(*pml4))
+		return NULL; 
+	pgd = pml4_pgd_offset(pml4, address);
+	if (!pgd_present(*pgd))
 		return NULL; 
 	pmd = pmd_offset(pgd, address); 	       
 	if (!pmd_present(*pmd))
@@ -98,16 +102,20 @@ static inline void save_page(unsigned lo
  */
 static void revert_page(unsigned long address, pgprot_t ref_prot)
 {
-       pgd_t *pgd;
-       pmd_t *pmd; 
-       pte_t large_pte; 
-       
-       pgd = pgd_offset_k(address); 
-       pmd = pmd_offset(pgd, address);
-       BUG_ON(pmd_val(*pmd) & _PAGE_PSE); 
-       pgprot_val(ref_prot) |= _PAGE_PSE;
-       large_pte = mk_pte_phys(__pa(address) & LARGE_PAGE_MASK, ref_prot);
-       set_pte((pte_t *)pmd, large_pte);
+	pml4_t *pml4; 
+	pgd_t *pgd;
+	pmd_t *pmd; 
+	pte_t large_pte; 
+	
+	pml4 = pml4_offset_k(address);
+	BUG_ON(pml4_none(*pml4));
+	pgd = pml4_pgd_offset(pml4,address); 
+	BUG_ON(pgd_none(*pgd)); 
+	pmd = pmd_offset(pgd, address);
+	BUG_ON(pmd_val(*pmd) & _PAGE_PSE); 
+	pgprot_val(ref_prot) |= _PAGE_PSE;
+	large_pte = mk_pte_phys(__pa(address) & LARGE_PAGE_MASK, ref_prot);
+	set_pte((pte_t *)pmd, large_pte);
 }      
 
 static int
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-x86_64/e820.h linux-2.6.10rc1-4level/include/asm-x86_64/e820.h
--- linux-2.6.10rc1/include/asm-x86_64/e820.h	2004-03-21 21:11:54.000000000 +0100
+++ linux-2.6.10rc1-4level/include/asm-x86_64/e820.h	2004-10-25 04:48:10.000000000 +0200
@@ -26,9 +26,6 @@
 
 #define LOWMEMSIZE()	(0x9f000)
 
-#define MAXMEM		(120UL * 1024 * 1024 * 1024 * 1024)  /* 120TB */ 
-
-
 #ifndef __ASSEMBLY__
 struct e820entry {
 	u64 addr;	/* start of memory segment */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-x86_64/mmu_context.h linux-2.6.10rc1-4level/include/asm-x86_64/mmu_context.h
--- linux-2.6.10rc1/include/asm-x86_64/mmu_context.h	2004-03-21 21:11:54.000000000 +0100
+++ linux-2.6.10rc1-4level/include/asm-x86_64/mmu_context.h	2004-10-25 04:48:10.000000000 +0200
@@ -40,10 +40,7 @@ static inline void switch_mm(struct mm_s
 		write_pda(active_mm, next);
 #endif
 		set_bit(cpu, &next->cpu_vm_mask);
-		/* Re-load page tables */
-		*read_pda(level4_pgt) = __pa(next->pgd) | _PAGE_TABLE;
-		__flush_tlb();
-
+		asm volatile("movq %0,%%cr3" :: "r" (__pa(next->pml4)) : "memory");
 		if (unlikely(next->context.ldt != prev->context.ldt)) 
 			load_LDT_nolock(&next->context, cpu);
 	}
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-x86_64/page.h linux-2.6.10rc1-4level/include/asm-x86_64/page.h
--- linux-2.6.10rc1/include/asm-x86_64/page.h	2004-10-25 04:47:37.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-x86_64/page.h	2004-10-25 04:48:10.000000000 +0200
@@ -67,19 +67,19 @@ extern unsigned long vm_force_exec32;
 
 #define __START_KERNEL		0xffffffff80100000UL
 #define __START_KERNEL_map	0xffffffff80000000UL
-#define __PAGE_OFFSET           0x0000010000000000UL	/* 1 << 40 */
+#define __PAGE_OFFSET           0xffff810000000000UL
 
 #else
 #define __START_KERNEL		0xffffffff80100000
 #define __START_KERNEL_map	0xffffffff80000000
-#define __PAGE_OFFSET           0x0000010000000000	/* 1 << 40 */
+#define __PAGE_OFFSET           0xffff810000000000
 #endif /* !__ASSEMBLY__ */
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
 /* See Documentation/x86_64/mm.txt for a description of the memory map. */
-#define __PHYSICAL_MASK_SHIFT	40
+#define __PHYSICAL_MASK_SHIFT	46
 #define __PHYSICAL_MASK		((1UL << __PHYSICAL_MASK_SHIFT) - 1)
 #define __VIRTUAL_MASK_SHIFT	48
 #define __VIRTUAL_MASK		((1UL << __VIRTUAL_MASK_SHIFT) - 1)
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-x86_64/pda.h linux-2.6.10rc1-4level/include/asm-x86_64/pda.h
--- linux-2.6.10rc1/include/asm-x86_64/pda.h	2004-03-21 21:11:54.000000000 +0100
+++ linux-2.6.10rc1-4level/include/asm-x86_64/pda.h	2004-10-25 04:48:10.000000000 +0200
@@ -17,7 +17,6 @@ struct x8664_pda {
         int irqcount;		    /* Irq nesting counter. Starts with -1 */  	
 	int cpunumber;		    /* Logical CPU number */
 	char *irqstackptr;	/* top of irqstack */
-	unsigned long volatile *level4_pgt; /* Per CPU top level page table */
 	unsigned int __softirq_pending;
 	unsigned int __nmi_count;	/* number of NMI on this CPUs */
 	struct mm_struct *active_mm;
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-x86_64/pgalloc.h linux-2.6.10rc1-4level/include/asm-x86_64/pgalloc.h
--- linux-2.6.10rc1/include/asm-x86_64/pgalloc.h	2004-03-21 21:11:54.000000000 +0100
+++ linux-2.6.10rc1-4level/include/asm-x86_64/pgalloc.h	2004-10-25 04:48:10.000000000 +0200
@@ -11,6 +11,8 @@
 		set_pmd(pmd, __pmd(_PAGE_TABLE | __pa(pte)))
 #define pgd_populate(mm, pgd, pmd) \
 		set_pgd(pgd, __pgd(_PAGE_TABLE | __pa(pmd)))
+#define pml4_populate(mm, pml4, pgd) \
+		set_pml4(pml4, __pml4(_PAGE_TABLE | __pa(pgd)))
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
 {
@@ -33,7 +35,7 @@ static inline pmd_t *pmd_alloc_one (stru
 	return (pmd_t *)get_zeroed_page(GFP_KERNEL|__GFP_REPEAT);
 }
 
-static inline pgd_t *pgd_alloc (struct mm_struct *mm)
+static inline pgd_t *pgd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	return (pgd_t *)get_zeroed_page(GFP_KERNEL|__GFP_REPEAT);
 }
@@ -44,6 +46,31 @@ static inline void pgd_free (pgd_t *pgd)
 	free_page((unsigned long)pgd);
 }
 
+static inline pml4_t *pml4_alloc(struct mm_struct *mm) 
+{ 
+	unsigned boundary;
+	pml4_t *pml4 = (pml4_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
+	if (!pml4)
+		return NULL;
+	/*
+	 * Copy kernel pointers in from init.
+	 * Could keep a freelist or slab cache of those because the kernel 
+	 * part never changes.
+	 */
+	boundary = pml4_index(__PAGE_OFFSET);
+	memset(pml4, 0, boundary * sizeof(pml4_t)); 
+	memcpy(pml4 + boundary, 
+	       init_level4_pgt + boundary,
+	       (PTRS_PER_PML4 - boundary) * sizeof(pml4_t));
+	return pml4; 
+} 
+
+static inline void pml4_free(pml4_t *pml4)
+{ 
+	BUG_ON((unsigned long)pml4 & (PAGE_SIZE-1)); 
+	free_page((unsigned long)pml4);
+} 
+
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
 	return (pte_t *)get_zeroed_page(GFP_KERNEL|__GFP_REPEAT);
@@ -73,5 +100,6 @@ extern inline void pte_free(struct page 
 
 #define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
 #define __pmd_free_tlb(tlb,x)   pmd_free(x)
+#define __pgd_free_tlb(tlb,x)   pgd_free(x)
 
 #endif /* _X86_64_PGALLOC_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-x86_64/pgtable.h linux-2.6.10rc1-4level/include/asm-x86_64/pgtable.h
--- linux-2.6.10rc1/include/asm-x86_64/pgtable.h	2004-10-25 04:47:37.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-x86_64/pgtable.h	2004-10-25 04:48:10.000000000 +0200
@@ -4,12 +4,6 @@
 /*
  * This file contains the functions and defines necessary to modify and use
  * the x86-64 page table tree.
- * 
- * x86-64 has a 4 level table setup. Generic linux MM only supports
- * three levels. The fourth level is currently a single static page that
- * is shared by everybody and just contains a pointer to the current
- * three level page setup on the beginning and some kernel mappings at 
- * the end. For more details see Documentation/x86_64/mm.txt
  */
 #include <asm/processor.h>
 #include <asm/fixmap.h>
@@ -22,10 +16,9 @@ extern pgd_t level3_physmem_pgt[512];
 extern pgd_t level3_ident_pgt[512];
 extern pmd_t level2_kernel_pgt[512];
 extern pml4_t init_level4_pgt[];
-extern pgd_t boot_vmalloc_pgt[];
 extern unsigned long __supported_pte_mask;
 
-#define swapper_pg_dir NULL
+#define swapper_pml4 init_level4_pgt
 
 extern void paging_init(void);
 extern void clear_kernel_mapping(unsigned long addr, unsigned long size);
@@ -39,6 +32,9 @@ extern unsigned long pgkern_mask;
 extern unsigned long empty_zero_page[PAGE_SIZE/sizeof(unsigned long)];
 #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
 
+/* 
+ * 4th top level page 
+ */
 #define PML4_SHIFT	39
 #define PTRS_PER_PML4	512
 
@@ -66,7 +62,8 @@ extern unsigned long empty_zero_page[PAG
 	printk("%s:%d: bad pmd %p(%016lx).\n", __FILE__, __LINE__, &(e), pmd_val(e))
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %p(%016lx).\n", __FILE__, __LINE__, &(e), pgd_val(e))
-
+#define pml4_ERROR(e) \
+	printk("%s:%d: bad pml4 %p(%016lx).\n", __FILE__, __LINE__, &(e), pml4_val(e))
 
 #define pml4_none(x)	(!pml4_val(x))
 #define pgd_none(x)	(!pgd_val(x))
@@ -98,6 +95,11 @@ static inline void set_pml4(pml4_t *dst,
 	pml4_val(*dst) = pml4_val(val); 
 }
 
+extern inline void pml4_clear (pml4_t * pgd)
+{
+	set_pml4(pgd, __pml4(0));
+}
+
 #define pgd_page(pgd) \
 ((unsigned long) __va(pgd_val(pgd) & PHYSICAL_PAGE_MASK))
 
@@ -111,27 +113,18 @@ static inline void set_pml4(pml4_t *dst,
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-#define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PML4	(TASK_SIZE/PML4_SIZE)
+#define USER_PGDS_IN_LAST_PML4  0
 #define FIRST_USER_PGD_NR	0
 
-#define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
-#define KERNEL_PGD_PTRS (PTRS_PER_PGD-USER_PGD_PTRS)
-
-#define TWOLEVEL_PGDIR_SHIFT	20
-#define BOOT_USER_L4_PTRS 1
-#define BOOT_KERNEL_L4_PTRS 511	/* But we will do it in 4rd level */
-
-
-
 #ifndef __ASSEMBLY__
-#define VMALLOC_START    0xffffff0000000000UL
-#define VMALLOC_END      0xffffff7fffffffffUL
-#define MODULES_VADDR    0xffffffffa0000000UL
-#define MODULES_END      0xffffffffafffffffUL
+#define MAXMEM		 0x3fffffffffffUL
+#define VMALLOC_START    0xffffc20000000000UL
+#define VMALLOC_END      0xffffe1ffffffffffUL
+#define MODULES_VADDR    0xffffffff88000000
+#define MODULES_END      0xfffffffffff00000
 #define MODULES_LEN   (MODULES_END - MODULES_VADDR)
 
-#define IOMAP_START      0xfffffe8000000000UL
-
 #define _PAGE_BIT_PRESENT	0
 #define _PAGE_BIT_RW		1
 #define _PAGE_BIT_USER		2
@@ -222,6 +215,14 @@ static inline unsigned long pgd_bad(pgd_
        return val & ~(_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED);      
 } 
 
+static inline unsigned long pml4_bad(pml4_t pgd) 
+{ 
+       unsigned long val = pml4_val(pgd);
+       val &= ~PTE_MASK; 
+       val &= ~(_PAGE_USER | _PAGE_DIRTY); 
+       return val & ~(_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED);      
+} 
+
 #define pte_none(x)	(!pte_val(x))
 #define pte_present(x)	(pte_val(x) & (_PAGE_PRESENT | _PAGE_PROTNONE))
 #define pte_clear(xp)	do { set_pte(xp, __pte(0)); } while (0)
@@ -300,48 +301,25 @@ static inline int pmd_large(pmd_t pte) {
 
 /*
  * Level 4 access.
- * Never use these in the common code.
  */
-#define pml4_page(pml4) ((unsigned long) __va(pml4_val(pml4) & PTE_MASK))
-#define pml4_index(address) ((address >> PML4_SHIFT) & (PTRS_PER_PML4-1))
+#define __HAVE_4LEVEL_PAGETABLES 1
+#define pml4_page(pml4) ((unsigned long) __va((unsigned long)pml4_val(pml4) & PTE_MASK))
+#define pml4_index(address) (((address) >> PML4_SHIFT) & (PTRS_PER_PML4-1))
+#define pml4_offset(mm, addr) ((mm)->pml4 + pml4_index(addr))
 #define pml4_offset_k(address) (init_level4_pgt + pml4_index(address))
 #define pml4_present(pml4) (pml4_val(pml4) & _PAGE_PRESENT)
 #define mk_kernel_pml4(address) ((pml4_t){ (address) | _KERNPG_TABLE })
-#define level3_offset_k(dir, address) ((pgd_t *) pml4_page(*(dir)) + pgd_index(address))
+#define pml4_pgd_offset(pml4, address) ((pgd_t *) pml4_page(*(pml4)) + pgd_index(address))
+#define pml4_pgd_offset_k(pml4, addr) pml4_pgd_offset(pml4, addr)
 
 /* PGD - Level3 access */
 /* to find an entry in a page-table-directory. */
-#define pgd_index(address) ((address >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
+#define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 static inline pgd_t *__pgd_offset_k(pgd_t *pgd, unsigned long address)
 { 
 	return pgd + pgd_index(address);
 } 
 
-/* Find correct pgd via the hidden fourth level page level: */
-
-/* This accesses the reference page table of the boot cpu. 
-   Other CPUs get synced lazily via the page fault handler. */
-static inline pgd_t *pgd_offset_k(unsigned long address)
-{
-	unsigned long addr;
-
-	addr = pml4_val(init_level4_pgt[pml4_index(address)]);
-	addr &= PHYSICAL_PAGE_MASK;
-	return __pgd_offset_k((pgd_t *)__va(addr), address);
-}
-
-/* Access the pgd of the page table as seen by the current CPU. */ 
-static inline pgd_t *current_pgd_offset_k(unsigned long address)
-{
-	unsigned long addr;
-
-	addr = read_pda(level4_pgt)[pml4_index(address)];
-	addr &= PHYSICAL_PAGE_MASK;
-	return __pgd_offset_k((pgd_t *)__va(addr), address);
-}
-
-#define pgd_offset(mm, address) ((mm)->pgd+pgd_index(address))
-
 /* PMD  - Level 2 access */
 #define pmd_page_kernel(pmd) ((unsigned long) __va(pmd_val(pmd) & PTE_MASK))
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-x86_64/processor.h linux-2.6.10rc1-4level/include/asm-x86_64/processor.h
--- linux-2.6.10rc1/include/asm-x86_64/processor.h	2004-10-25 04:47:37.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-x86_64/processor.h	2004-10-25 04:48:10.000000000 +0200
@@ -165,9 +165,9 @@ static inline void clear_in_cr4 (unsigne
 
 
 /*
- * User space process size: 512GB - 1GB (default).
+ * User space process size. 47bits. 
  */
-#define TASK_SIZE	(0x0000007fc0000000UL)
+#define TASK_SIZE	0x800000000000
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
