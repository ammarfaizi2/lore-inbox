Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265710AbUAKCd7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 21:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265711AbUAKCd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 21:33:59 -0500
Received: from [193.138.115.2] ([193.138.115.2]:64272 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265710AbUAKCdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 21:33:32 -0500
Date: Sun, 11 Jan 2004 03:30:31 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Ingo Molnar <mingo@redhat.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH(s)][RFC] variable size and signedness issues in ldt.c -
 potential problem?
In-Reply-To: <Pine.LNX.4.58.0401090440180.27298@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.56.0401110300080.13633@jju_lnx.backbone.dif.dk>
References: <8A43C34093B3D5119F7D0004AC56F4BC074AFBC9@difpst1a.dif.dk>
 <Pine.LNX.4.58.0401090440180.27298@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Jan 2004, Ingo Molnar wrote:

>
> On Thu, 8 Jan 2004, Jesper Juhl wrote:
>
> > I'm hunting the kernel source for any potential problem I can find (and
> > hopefully fix), and I've come across something that looks like a
> > possible problem in arch/i386/kernel/ldt.c
> >
> > First thing that looks suspicious is this bit in read_ldt() :
> >
> >         for (i = 0; i < size; i += PAGE_SIZE) {
> > 		...
> > 	}
> >
> > 'i' is a plain int while 'size' is an 'unsigned long' leaving the
> > possibility that if size contains a value greater than what a signed int
> > can hold then this code won't do the right thing, either 'i' will wrap
> > around to zero and the loop will never exit or something "unknown" will
> > happen (as far as I know, what happens when an int overflows is
> > implementation defined). [...]
>
> but the user does not control 'newsize'. Can you outline a scenario in
> where the value could overflow?
>

No, I cannot present a scenario where that can actually happen.
I'm not intimately familiar with this code, so I can't say for certain
that I've been down all the possible roads though.
It simply looked suspicious, and the change I suggested ensures with 100%
certainty that it can never happen - I thought that was a good thing and
that's the reason for the proposed patch. If you feel certain that an
overflow can never happen, then I trust that completely and the patch is
thus not needed.


> > The second thing is that in the body of the 'for' loop there is this
> > comparison :
> >
> > if (bytes > PAGE_SIZE)
>
> no, the value of bytes is really limited. Again, can you suggest a
> scenario in where this could overflow?
>
My answer here will have to be a repetition of the one above for the
previous code snippet.


> > I know that the only user of read_ldt() and write_ldt() is
> > sys_modify_ldt() , and the arguments for read_ldt and write_ldt thus
> > have to match sys_modify_ldt, but why is the 'bytecount' argument for
> > sys_modify_ldt an 'unsigned long' and the return type an 'int' ? The
> > signedness of the return type makes sense given that it't supposed to
> > return -1 on error. But on success, in the case where it calls read_ldt,
> > it's supposed to return the actual number of bytes read. But if the
> > number of bytes to read is given as an unsigned long, and the number
> > actually read exceeds the size of a signed int then the return value
> > will get truncated upon return - how can that be right? [...]
>
> LDT size is limited by LDT_ENTRY_SIZE*LDT_ENTRIES. We explicitly truncate
> bytecount to this range so unsigned vs. signed makes no difference.
>
Ok, that's allright then. Thank you for the explanation.


> > [...] And if the return value can never exceed what a signed int can
> > hold, then why is it possible to request an unsigned long amount of
> > bytes to read in the first place?
>
> that's quite common for the interface definitions. Since we are on x86
> unsigned long == unsigned int.
>
Again, thank you for clarifying. I'm learning a lot here and I'm grateful
for your time in answering these basic questions.

One additional thing I noticed in the ldt code is that it seems to me that
there could be some bennefit to moving the declaration of 'bytes' in the
for() loop in read_ldt() outside the loop. It gets initialized by
'bytes = size - i;' every time through the loop before it's used, so I se
no reason to re-create the variable every time through the loop.
If that makes sense, then here's a patch to make this change (it's against
2.6.1-mm1) :

--- linux-2.6.1-mm1-orig/arch/i386/kernel/ldt.c	2004-01-09 19:04:23.000000000 +0100
+++ linux-2.6.1-mm1-juhl/arch/i386/kernel/ldt.c	2004-01-11 03:36:02.000000000 +0100
@@ -118,10 +118,11 @@ void destroy_context(struct mm_struct *m
 	mm->context.size = 0;
 }

-static int read_ldt(void __user * ptr, unsigned long bytecount)
+static int read_ldt(void __user *ptr, unsigned long bytecount)
 {
 	int err, i;
 	unsigned long size;
+	unsigned long bytes;
 	struct mm_struct * mm = current->mm;

 	if (!mm->context.size)
@@ -144,7 +145,7 @@ static int read_ldt(void __user * ptr, u
 	__flush_tlb_global();

 	for (i = 0; i < size; i += PAGE_SIZE) {
-		int nr = i / PAGE_SIZE, bytes;
+		int nr = i / PAGE_SIZE;
 		char *kaddr = kmap(mm->context.ldt_pages[nr]);

 		bytes = size - i;



> > and finally a purely style related thing (sure, call me pedantic); in both
> > read_ldt() and write_ldt() 'mm' is declared as
> >
> > struct mm_struct * mm = current->mm;
>
> yep, you are right, this is the wrong style.
>

Ok, thank you for confirming that.

Since this /is/ incorrect style I've created a patch to clean it up, as
well as a bunch of other instances of the same style issue I found nearby.
I certainly haven't cleaned up *all* instances of this inccorect style,
but I have nailed 26 files with such instances, and I believe I've nailed
all occourances of this style issue in those files.

Patch is below against 2.6.1-mm1 - please consider applying (I've added
Andrew to the CC since this patch is against his tree and you have
confirmed this to be a valid issue).
The patch makes no functional changes - it's purely a coding-style cleanup.



diff -urdp linux-2.6.1-mm1-orig/arch/alpha/kernel/smp.c linux-2.6.1-mm1-juhl/arch/alpha/kernel/smp.c
--- linux-2.6.1-mm1-orig/arch/alpha/kernel/smp.c	2004-01-09 07:59:19.000000000 +0100
+++ linux-2.6.1-mm1-juhl/arch/alpha/kernel/smp.c	2004-01-11 02:02:36.000000000 +0100
@@ -972,7 +972,7 @@ static void
 ipi_flush_tlb_page(void *x)
 {
 	struct flush_tlb_page_struct *data = (struct flush_tlb_page_struct *)x;
-	struct mm_struct * mm = data->mm;
+	struct mm_struct *mm = data->mm;

 	if (mm == current->active_mm && !asn_locked())
 		flush_tlb_current_page(mm, data->vma, data->addr);
diff -urdp linux-2.6.1-mm1-orig/arch/cris/arch-v10/README.mm linux-2.6.1-mm1-juhl/arch/cris/arch-v10/README.mm
--- linux-2.6.1-mm1-orig/arch/cris/arch-v10/README.mm	2004-01-09 08:00:12.000000000 +0100
+++ linux-2.6.1-mm1-juhl/arch/cris/arch-v10/README.mm	2004-01-11 02:01:30.000000000 +0100
@@ -177,7 +177,7 @@ The example address is 0xd004000c; in bi
 Given the top-level Page Directory, the offset in that directory is calculated
 using the upper 8 bits:

-extern inline pgd_t * pgd_offset(struct mm_struct * mm, unsigned long address)
+extern inline pgd_t * pgd_offset(struct mm_struct *mm, unsigned long address)
 {
 	return mm->pgd + (address >> PGDIR_SHIFT);
 }
diff -urdp linux-2.6.1-mm1-orig/arch/i386/kernel/ldt.c linux-2.6.1-mm1-juhl/arch/i386/kernel/ldt.c
--- linux-2.6.1-mm1-orig/arch/i386/kernel/ldt.c	2004-01-09 19:04:23.000000000 +0100
+++ linux-2.6.1-mm1-juhl/arch/i386/kernel/ldt.c	2004-01-11 02:31:16.000000000 +0100
@@ -118,11 +118,11 @@ void destroy_context(struct mm_struct *m
 	mm->context.size = 0;
 }

-static int read_ldt(void __user * ptr, unsigned long bytecount)
+static int read_ldt(void __user *ptr, unsigned long bytecount)
 {
 	int err, i;
 	unsigned long size;
-	struct mm_struct * mm = current->mm;
+	struct mm_struct *mm = current->mm;

 	if (!mm->context.size)
 		return 0;
@@ -164,7 +164,7 @@ static int read_ldt(void __user * ptr, u
 	return bytecount;
 }

-static int read_default_ldt(void __user * ptr, unsigned long bytecount)
+static int read_default_ldt(void __user *ptr, unsigned long bytecount)
 {
 	int err;
 	unsigned long size;
@@ -183,9 +183,9 @@ static int read_default_ldt(void __user
 	return err;
 }

-static int write_ldt(void __user * ptr, unsigned long bytecount, int oldmode)
+static int write_ldt(void __user *ptr, unsigned long bytecount, int oldmode)
 {
-	struct mm_struct * mm = current->mm;
+	struct mm_struct *mm = current->mm;
 	__u32 entry_1, entry_2, *lp;
 	int error;
 	struct user_desc ldt_info;
diff -urdp linux-2.6.1-mm1-orig/arch/i386/kernel/smp.c linux-2.6.1-mm1-juhl/arch/i386/kernel/smp.c
--- linux-2.6.1-mm1-orig/arch/i386/kernel/smp.c	2004-01-09 19:04:24.000000000 +0100
+++ linux-2.6.1-mm1-juhl/arch/i386/kernel/smp.c	2004-01-11 02:00:48.000000000 +0100
@@ -398,7 +398,7 @@ static void flush_tlb_others(cpumask_t c
 	spin_unlock(&tlbstate_lock);
 }

-void flush_tlb_mm (struct mm_struct * mm)
+void flush_tlb_mm(struct mm_struct *mm)
 {
 	cpumask_t cpu_mask;

diff -urdp linux-2.6.1-mm1-orig/arch/i386/mach-voyager/voyager_smp.c linux-2.6.1-mm1-juhl/arch/i386/mach-voyager/voyager_smp.c
--- linux-2.6.1-mm1-orig/arch/i386/mach-voyager/voyager_smp.c	2004-01-09 19:04:24.000000000 +0100
+++ linux-2.6.1-mm1-juhl/arch/i386/mach-voyager/voyager_smp.c	2004-01-11 01:58:46.000000000 +0100
@@ -846,7 +846,7 @@ smp_reschedule_interrupt(void)
 	/* do nothing */
 }

-static struct mm_struct * flush_mm;
+static struct mm_struct *flush_mm;
 static unsigned long flush_va;
 static spinlock_t tlbstate_lock = SPIN_LOCK_UNLOCKED;
 #define FLUSH_ALL	0xffffffff
@@ -963,7 +963,7 @@ flush_tlb_current_task(void)


 void
-flush_tlb_mm (struct mm_struct * mm)
+flush_tlb_mm (struct mm_struct *mm)
 {
 	unsigned long cpu_mask;

diff -urdp linux-2.6.1-mm1-orig/arch/ppc64/xmon/xmon.c linux-2.6.1-mm1-juhl/arch/ppc64/xmon/xmon.c
--- linux-2.6.1-mm1-orig/arch/ppc64/xmon/xmon.c	2004-01-09 07:59:56.000000000 +0100
+++ linux-2.6.1-mm1-juhl/arch/ppc64/xmon/xmon.c	2004-01-11 02:03:11.000000000 +0100
@@ -1909,7 +1909,7 @@ mem_translate()
 	int c;
 	unsigned long ea, va, vsid, vpn, page, hpteg_slot_primary, hpteg_slot_secondary, primary_hash, i, *steg, esid, stabl;
 	HPTE *  hpte;
-	struct mm_struct * mm;
+	struct mm_struct *mm;
 	pte_t  *ptep = NULL;
 	void * pgdir;

diff -urdp linux-2.6.1-mm1-orig/arch/x86_64/kernel/smp.c linux-2.6.1-mm1-juhl/arch/x86_64/kernel/smp.c
--- linux-2.6.1-mm1-orig/arch/x86_64/kernel/smp.c	2004-01-09 19:04:26.000000000 +0100
+++ linux-2.6.1-mm1-juhl/arch/x86_64/kernel/smp.c	2004-01-11 02:04:23.000000000 +0100
@@ -290,7 +290,7 @@ void flush_tlb_current_task(void)
 	preempt_enable();
 }

-void flush_tlb_mm (struct mm_struct * mm)
+void flush_tlb_mm (struct mm_struct *mm)
 {
 	cpumask_t cpu_mask;

diff -urdp linux-2.6.1-mm1-orig/drivers/oprofile/buffer_sync.c linux-2.6.1-mm1-juhl/drivers/oprofile/buffer_sync.c
--- linux-2.6.1-mm1-orig/drivers/oprofile/buffer_sync.c	2004-01-09 07:59:19.000000000 +0100
+++ linux-2.6.1-mm1-juhl/drivers/oprofile/buffer_sync.c	2004-01-11 02:05:14.000000000 +0100
@@ -202,7 +202,7 @@ static inline unsigned long fast_get_dco
  * not strictly necessary but allows oprofile to associate
  * shared-library samples with particular applications
  */
-static unsigned long get_exec_dcookie(struct mm_struct * mm)
+static unsigned long get_exec_dcookie(struct mm_struct *mm)
 {
 	unsigned long cookie = 0;
 	struct vm_area_struct * vma;
@@ -230,7 +230,7 @@ out:
  * sure to do this lookup before a mm->mmap modification happens so
  * we don't lose track.
  */
-static unsigned long lookup_dcookie(struct mm_struct * mm, unsigned long addr, off_t * offset)
+static unsigned long lookup_dcookie(struct mm_struct *mm, unsigned long addr, off_t * offset)
 {
 	unsigned long cookie = 0;
 	struct vm_area_struct * vma;
@@ -301,7 +301,7 @@ static void add_sample_entry(unsigned lo
 }


-static void add_us_sample(struct mm_struct * mm, struct op_sample * s)
+static void add_us_sample(struct mm_struct *mm, struct op_sample * s)
 {
 	unsigned long cookie;
 	off_t offset;
@@ -326,7 +326,7 @@ static void add_us_sample(struct mm_stru
  * sample is converted into a persistent dentry/offset pair
  * for later lookup from userspace.
  */
-static void add_sample(struct mm_struct * mm, struct op_sample * s, int in_kernel)
+static void add_sample(struct mm_struct *mm, struct op_sample * s, int in_kernel)
 {
 	if (in_kernel) {
 		add_sample_entry(s->eip, s->event);
@@ -338,7 +338,7 @@ static void add_sample(struct mm_struct
 }


-static void release_mm(struct mm_struct * mm)
+static void release_mm(struct mm_struct *mm)
 {
 	if (mm)
 		up_read(&mm->mmap_sem);
@@ -350,7 +350,7 @@ static void release_mm(struct mm_struct
  */
 static struct mm_struct * take_tasks_mm(struct task_struct * task)
 {
-	struct mm_struct * mm;
+	struct mm_struct *mm;

 	/* Subtle. We don't need to keep a reference to this task's mm,
 	 * because, for the mm to be freed on another CPU, that would have
@@ -425,8 +425,8 @@ static void increment_tail(struct oprofi
  */
 static void sync_buffer(struct oprofile_cpu_buffer * cpu_buf)
 {
-	struct mm_struct * mm = 0;
-	struct task_struct * new;
+	struct mm_struct *mm = 0;
+	struct task_struct *new;
 	unsigned long cookie = 0;
 	int in_kernel = 1;
 	unsigned int i;
diff -urdp linux-2.6.1-mm1-orig/fs/proc/base.c linux-2.6.1-mm1-juhl/fs/proc/base.c
--- linux-2.6.1-mm1-orig/fs/proc/base.c	2004-01-09 19:04:31.000000000 +0100
+++ linux-2.6.1-mm1-juhl/fs/proc/base.c	2004-01-11 01:52:10.000000000 +0100
@@ -215,7 +215,7 @@ static int proc_exe_link(struct inode *i
 	struct vm_area_struct * vma;
 	int result = -ENOENT;
 	struct task_struct *task = proc_task(inode);
-	struct mm_struct * mm = get_task_mm(task);
+	struct mm_struct *mm = get_task_mm(task);

 	if (!mm)
 		goto out;
diff -urdp linux-2.6.1-mm1-orig/include/asm-alpha/mmu_context.h linux-2.6.1-mm1-juhl/include/asm-alpha/mmu_context.h
--- linux-2.6.1-mm1-orig/include/asm-alpha/mmu_context.h	2004-01-09 07:59:34.000000000 +0100
+++ linux-2.6.1-mm1-juhl/include/asm-alpha/mmu_context.h	2004-01-11 02:10:28.000000000 +0100
@@ -187,7 +187,7 @@ do {								\
 	cpu_data[cpu].asn_lock = 0;				\
 	barrier();						\
 	if (cpu_data[cpu].need_new_asn) {			\
-		struct mm_struct * mm = current->active_mm;	\
+		struct mm_struct *mm = current->active_mm;	\
 		cpu_data[cpu].need_new_asn = 0;			\
 		if (!mm->context[cpu])			\
 			__load_new_mm_context(mm);		\
diff -urdp linux-2.6.1-mm1-orig/include/asm-alpha/tlbflush.h linux-2.6.1-mm1-juhl/include/asm-alpha/tlbflush.h
--- linux-2.6.1-mm1-orig/include/asm-alpha/tlbflush.h	2004-01-09 07:59:02.000000000 +0100
+++ linux-2.6.1-mm1-juhl/include/asm-alpha/tlbflush.h	2004-01-11 02:10:59.000000000 +0100
@@ -33,7 +33,7 @@ ev5_flush_tlb_current(struct mm_struct *
    specific icache page.  */

 __EXTERN_INLINE void
-ev4_flush_tlb_current_page(struct mm_struct * mm,
+ev4_flush_tlb_current_page(struct mm_struct *mm,
 			   struct vm_area_struct *vma,
 			   unsigned long addr)
 {
@@ -46,7 +46,7 @@ ev4_flush_tlb_current_page(struct mm_str
 }

 __EXTERN_INLINE void
-ev5_flush_tlb_current_page(struct mm_struct * mm,
+ev5_flush_tlb_current_page(struct mm_struct *mm,
 			   struct vm_area_struct *vma,
 			   unsigned long addr)
 {
diff -urdp linux-2.6.1-mm1-orig/include/asm-arm26/rmap.h linux-2.6.1-mm1-juhl/include/asm-arm26/rmap.h
--- linux-2.6.1-mm1-orig/include/asm-arm26/rmap.h	2004-01-09 07:59:26.000000000 +0100
+++ linux-2.6.1-mm1-juhl/include/asm-arm26/rmap.h	2004-01-11 02:12:00.000000000 +0100
@@ -12,7 +12,7 @@
  * page tables and the last 2 kB are the software page tables.
  */

-static inline void pgtable_add_rmap(struct page *page, struct mm_struct * mm, unsigned long address)
+static inline void pgtable_add_rmap(struct page *page, struct mm_struct *mm, unsigned long address)
 {
         page->mapping = (void *)mm;
         page->index = address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
@@ -28,16 +28,16 @@ static inline void pgtable_remove_rmap(s

 static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
 {
-	struct page * page = virt_to_page(ptep);
+	struct page *page = virt_to_page(ptep);
         return (struct mm_struct *)page->mapping;
 }

 /* The page table takes half of the page */
 #define PTE_MASK  ((PAGE_SIZE / 2) - 1)

-static inline unsigned long ptep_to_address(pte_t * ptep)
+static inline unsigned long ptep_to_address(pte_t *ptep)
 {
-        struct page * page = virt_to_page(ptep);
+        struct page *page = virt_to_page(ptep);
         unsigned long low_bits;

         low_bits = ((unsigned long)ptep & PTE_MASK) * PTRS_PER_PTE;
diff -urdp linux-2.6.1-mm1-orig/include/asm-cris/pgtable.h linux-2.6.1-mm1-juhl/include/asm-cris/pgtable.h
--- linux-2.6.1-mm1-orig/include/asm-cris/pgtable.h	2004-01-09 07:59:05.000000000 +0100
+++ linux-2.6.1-mm1-juhl/include/asm-cris/pgtable.h	2004-01-11 02:38:27.000000000 +0100
@@ -257,7 +257,7 @@ extern inline unsigned long __pte_page(p
  * don't need the __pa and __va transformations.
  */

-extern inline void pmd_set(pmd_t * pmdp, pte_t * ptep)
+extern inline void pmd_set(pmd_t *pmdp, pte_t *ptep)
 { pmd_val(*pmdp) = _PAGE_TABLE | (unsigned long) ptep; }

 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
@@ -267,7 +267,7 @@ extern inline void pmd_set(pmd_t * pmdp,
 #define pgd_index(address) ((address >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))

 /* to find an entry in a page-table-directory */
-extern inline pgd_t * pgd_offset(struct mm_struct * mm, unsigned long address)
+extern inline pgd_t *pgd_offset(struct mm_struct *mm, unsigned long address)
 {
 	return mm->pgd + pgd_index(address);
 }
@@ -276,7 +276,7 @@ extern inline pgd_t * pgd_offset(struct
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)

 /* Find an entry in the second-level page table.. */
-extern inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
+extern inline pmd_t *pmd_offset(pgd_t *dir, unsigned long address)
 {
 	return (pmd_t *) dir;
 }
diff -urdp linux-2.6.1-mm1-orig/include/asm-generic/rmap.h linux-2.6.1-mm1-juhl/include/asm-generic/rmap.h
--- linux-2.6.1-mm1-orig/include/asm-generic/rmap.h	2004-01-09 07:59:44.000000000 +0100
+++ linux-2.6.1-mm1-juhl/include/asm-generic/rmap.h	2004-01-11 02:40:01.000000000 +0100
@@ -26,7 +26,7 @@
  */
 #include <linux/mm.h>

-static inline void pgtable_add_rmap(struct page * page, struct mm_struct * mm, unsigned long address)
+static inline void pgtable_add_rmap(struct page *page, struct mm_struct *mm, unsigned long address)
 {
 #ifdef BROKEN_PPC_PTE_ALLOC_ONE
 	/* OK, so PPC calls pte_alloc() before mem_map[] is setup ... ;( */
@@ -40,22 +40,22 @@ static inline void pgtable_add_rmap(stru
 	inc_page_state(nr_page_table_pages);
 }

-static inline void pgtable_remove_rmap(struct page * page)
+static inline void pgtable_remove_rmap(struct page *page)
 {
 	page->mapping = NULL;
 	page->index = 0;
 	dec_page_state(nr_page_table_pages);
 }

-static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
+static inline struct mm_struct *ptep_to_mm(pte_t *ptep)
 {
-	struct page * page = kmap_atomic_to_page(ptep);
+	struct page *page = kmap_atomic_to_page(ptep);
 	return (struct mm_struct *) page->mapping;
 }

-static inline unsigned long ptep_to_address(pte_t * ptep)
+static inline unsigned long ptep_to_address(pte_t *ptep)
 {
-	struct page * page = kmap_atomic_to_page(ptep);
+	struct page *page = kmap_atomic_to_page(ptep);
 	unsigned long low_bits;
 	low_bits = ((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE;
 	return page->index + low_bits;
diff -urdp linux-2.6.1-mm1-orig/include/linux/mm.h linux-2.6.1-mm1-juhl/include/linux/mm.h
--- linux-2.6.1-mm1-orig/include/linux/mm.h	2004-01-09 19:04:32.000000000 +0100
+++ linux-2.6.1-mm1-juhl/include/linux/mm.h	2004-01-11 02:40:53.000000000 +0100
@@ -608,17 +608,17 @@ unsigned long max_sane_readahead(unsigne
 extern int expand_stack(struct vm_area_struct * vma, unsigned long address);

 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
-extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr);
-extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsigned long addr,
+extern struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr);
+extern struct vm_area_struct *find_vma_prev(struct mm_struct *mm, unsigned long addr,
 					     struct vm_area_struct **pprev);
-extern int split_vma(struct mm_struct * mm, struct vm_area_struct * vma,
+extern int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 		     unsigned long addr, int new_below);

 /* Look up the first VMA which intersects the interval start_addr..end_addr-1,
    NULL if none.  Assume start_addr < end_addr. */
-static inline struct vm_area_struct * find_vma_intersection(struct mm_struct * mm, unsigned long start_addr, unsigned long end_addr)
+static inline struct vm_area_struct *find_vma_intersection(struct mm_struct *mm, unsigned long start_addr, unsigned long end_addr)
 {
-	struct vm_area_struct * vma = find_vma(mm,start_addr);
+	struct vm_area_struct *vma = find_vma(mm,start_addr);

 	if (vma && end_addr <= vma->vm_start)
 		vma = NULL;
@@ -629,8 +629,8 @@ extern struct vm_area_struct *find_exten

 extern unsigned int nr_used_zone_pages(void);

-extern struct page * vmalloc_to_page(void *addr);
-extern struct page * follow_page(struct mm_struct *mm, unsigned long address,
+extern struct page *vmalloc_to_page(void *addr);
+extern struct page *follow_page(struct mm_struct *mm, unsigned long address,
 		int write);
 extern int remap_page_range(struct vm_area_struct *vma, unsigned long from,
 		unsigned long to, unsigned long size, pgprot_t prot);
diff -urdp linux-2.6.1-mm1-orig/include/linux/profile.h linux-2.6.1-mm1-juhl/include/linux/profile.h
--- linux-2.6.1-mm1-orig/include/linux/profile.h	2004-01-09 07:59:33.000000000 +0100
+++ linux-2.6.1-mm1-juhl/include/linux/profile.h	2004-01-11 02:09:08.000000000 +0100
@@ -33,34 +33,34 @@ struct task_struct;
 struct mm_struct;

 /* task is in do_exit() */
-void profile_exit_task(struct task_struct * task);
+void profile_exit_task(struct task_struct *task);

 /* change of vma mappings */
-void profile_exec_unmap(struct mm_struct * mm);
+void profile_exec_unmap(struct mm_struct *mm);

 /* exit of all vmas for a task */
-void profile_exit_mmap(struct mm_struct * mm);
+void profile_exit_mmap(struct mm_struct *mm);

-int profile_event_register(enum profile_type, struct notifier_block * n);
+int profile_event_register(enum profile_type, struct notifier_block *n);

-int profile_event_unregister(enum profile_type, struct notifier_block * n);
+int profile_event_unregister(enum profile_type, struct notifier_block *n);

-int register_profile_notifier(struct notifier_block * nb);
-int unregister_profile_notifier(struct notifier_block * nb);
+int register_profile_notifier(struct notifier_block *nb);
+int unregister_profile_notifier(struct notifier_block *nb);

 struct pt_regs;

 /* profiling hook activated on each timer interrupt */
-void profile_hook(struct pt_regs * regs);
+void profile_hook(struct pt_regs *regs);

 #else

-static inline int profile_event_register(enum profile_type t, struct notifier_block * n)
+static inline int profile_event_register(enum profile_type t, struct notifier_block *n)
 {
 	return -ENOSYS;
 }

-static inline int profile_event_unregister(enum profile_type t, struct notifier_block * n)
+static inline int profile_event_unregister(enum profile_type t, struct notifier_block *n)
 {
 	return -ENOSYS;
 }
@@ -69,12 +69,12 @@ static inline int profile_event_unregist
 #define profile_exec_unmap(a) do { } while (0)
 #define profile_exit_mmap(a) do { } while (0)

-static inline int register_profile_notifier(struct notifier_block * nb)
+static inline int register_profile_notifier(struct notifier_block *nb)
 {
 	return -ENOSYS;
 }

-static inline int unregister_profile_notifier(struct notifier_block * nb)
+static inline int unregister_profile_notifier(struct notifier_block *nb)
 {
 	return -ENOSYS;
 }
diff -urdp linux-2.6.1-mm1-orig/include/linux/sched.h linux-2.6.1-mm1-juhl/include/linux/sched.h
--- linux-2.6.1-mm1-orig/include/linux/sched.h	2004-01-09 19:04:32.000000000 +0100
+++ linux-2.6.1-mm1-juhl/include/linux/sched.h	2004-01-11 02:43:04.000000000 +0100
@@ -184,11 +184,11 @@ struct namespace;
 #include <linux/aio.h>

 struct mm_struct {
-	struct vm_area_struct * mmap;		/* list of VMAs */
+	struct vm_area_struct *mmap;		/* list of VMAs */
 	struct rb_root mm_rb;
-	struct vm_area_struct * mmap_cache;	/* last find_vma result */
+	struct vm_area_struct *mmap_cache;	/* last find_vma result */
 	unsigned long free_area_cache;		/* first hole */
-	pgd_t * pgd;
+	pgd_t *pgd;
 	atomic_t mm_users;			/* How many users with user space? */
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
 	int map_count;				/* number of VMAs */
@@ -675,11 +675,11 @@ static inline int capable(int cap)
 /*
  * Routines for handling mm_structs
  */
-extern struct mm_struct * mm_alloc(void);
+extern struct mm_struct *mm_alloc(void);

 /* mmdrop drops the mm and the page tables */
 extern inline void FASTCALL(__mmdrop(struct mm_struct *));
-static inline void mmdrop(struct mm_struct * mm)
+static inline void mmdrop(struct mm_struct *mm)
 {
 	if (atomic_dec_and_test(&mm->mm_count))
 		__mmdrop(mm);
@@ -717,7 +717,7 @@ extern long do_fork(unsigned long, unsig
 extern struct task_struct * copy_process(unsigned long, unsigned long, struct pt_regs *, unsigned long, int __user *, int __user *);

 #ifdef CONFIG_SMP
-extern void wait_task_inactive(task_t * p);
+extern void wait_task_inactive(task_t *p);
 #else
 #define wait_task_inactive(p)	do { } while (0)
 #endif
@@ -790,9 +790,9 @@ static inline void task_unlock(struct ta
  * Returns %NULL if the task has no mm. User must release
  * the mm via mmput() after use.
  */
-static inline struct mm_struct * get_task_mm(struct task_struct * task)
+static inline struct mm_struct *get_task_mm(struct task_struct *task)
 {
-	struct mm_struct * mm;
+	struct mm_struct *mm;

 	task_lock(task);
 	mm = task->mm;
diff -urdp linux-2.6.1-mm1-orig/kernel/fork.c linux-2.6.1-mm1-juhl/kernel/fork.c
--- linux-2.6.1-mm1-orig/kernel/fork.c	2004-01-09 19:04:32.000000000 +0100
+++ linux-2.6.1-mm1-juhl/kernel/fork.c	2004-01-11 02:45:12.000000000 +0100
@@ -270,9 +270,9 @@ static struct task_struct *dup_task_stru
 }

 #ifdef CONFIG_MMU
-static inline int dup_mmap(struct mm_struct * mm, struct mm_struct * oldmm)
+static inline int dup_mmap(struct mm_struct *mm, struct mm_struct * oldmm)
 {
-	struct vm_area_struct * mpnt, *tmp, **pprev;
+	struct vm_area_struct *mpnt, *tmp, **pprev;
 	int retval;
 	unsigned long charge = 0;

@@ -360,7 +360,7 @@ fail:
 	vm_unacct_memory(charge);
 	goto out;
 }
-static inline int mm_alloc_pgd(struct mm_struct * mm)
+static inline int mm_alloc_pgd(struct mm_struct *mm)
 {
 	mm->pgd = pgd_alloc(mm);
 	if (unlikely(!mm->pgd))
@@ -368,7 +368,7 @@ static inline int mm_alloc_pgd(struct mm
 	return 0;
 }

-static inline void mm_free_pgd(struct mm_struct * mm)
+static inline void mm_free_pgd(struct mm_struct *mm)
 {
 	pgd_free(mm->pgd);
 }
@@ -386,7 +386,7 @@ int mmlist_nr;

 #include <linux/init_task.h>

-static struct mm_struct * mm_init(struct mm_struct * mm)
+static struct mm_struct *mm_init(struct mm_struct *mm)
 {
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
@@ -409,9 +409,9 @@ static struct mm_struct * mm_init(struct
 /*
  * Allocate and initialize an mm_struct.
  */
-struct mm_struct * mm_alloc(void)
+struct mm_struct *mm_alloc(void)
 {
-	struct mm_struct * mm;
+	struct mm_struct *mm;

 	mm = allocate_mm();
 	if (mm) {
@@ -504,9 +504,9 @@ void mm_release(struct task_struct *tsk,
 	}
 }

-static int copy_mm(unsigned long clone_flags, struct task_struct * tsk)
+static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 {
-	struct mm_struct * mm, *oldmm;
+	struct mm_struct *mm, *oldmm;
 	int retval;

 	tsk->min_flt = tsk->maj_flt = 0;
@@ -608,7 +608,7 @@ struct fs_struct *copy_fs_struct(struct

 EXPORT_SYMBOL_GPL(copy_fs_struct);

-static inline int copy_fs(unsigned long clone_flags, struct task_struct * tsk)
+static inline int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 {
 	if (clone_flags & CLONE_FS) {
 		atomic_inc(&current->fs->count);
@@ -633,7 +633,7 @@ static int count_open_files(struct files
 	return i;
 }

-static int copy_files(unsigned long clone_flags, struct task_struct * tsk)
+static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 {
 	struct files_struct *oldf, *newf;
 	struct file **old_fds, **new_fds;
@@ -774,7 +774,7 @@ int unshare_files(void)

 EXPORT_SYMBOL(unshare_files);

-static inline int copy_sighand(unsigned long clone_flags, struct task_struct * tsk)
+static inline int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
 {
 	struct sighand_struct *sig;

@@ -792,7 +792,7 @@ static inline int copy_sighand(unsigned
 	return 0;
 }

-static inline int copy_signal(unsigned long clone_flags, struct task_struct * tsk)
+static inline int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 {
 	struct signal_struct *sig;

diff -urdp linux-2.6.1-mm1-orig/kernel/profile.c linux-2.6.1-mm1-juhl/kernel/profile.c
--- linux-2.6.1-mm1-orig/kernel/profile.c	2004-01-09 08:00:03.000000000 +0100
+++ linux-2.6.1-mm1-juhl/kernel/profile.c	2004-01-11 02:06:35.000000000 +0100
@@ -58,14 +58,14 @@ void profile_exit_task(struct task_struc
 	up_read(&profile_rwsem);
 }

-void profile_exit_mmap(struct mm_struct * mm)
+void profile_exit_mmap(struct mm_struct *mm)
 {
 	down_read(&profile_rwsem);
 	notifier_call_chain(&exit_mmap_notifier, 0, mm);
 	up_read(&profile_rwsem);
 }

-void profile_exec_unmap(struct mm_struct * mm)
+void profile_exec_unmap(struct mm_struct *mm)
 {
 	down_read(&profile_rwsem);
 	notifier_call_chain(&exec_unmap_notifier, 0, mm);
diff -urdp linux-2.6.1-mm1-orig/mm/madvise.c linux-2.6.1-mm1-juhl/mm/madvise.c
--- linux-2.6.1-mm1-orig/mm/madvise.c	2004-01-09 19:04:32.000000000 +0100
+++ linux-2.6.1-mm1-juhl/mm/madvise.c	2004-01-11 01:52:52.000000000 +0100
@@ -16,7 +16,7 @@
 static long madvise_behavior(struct vm_area_struct * vma, unsigned long start,
 			     unsigned long end, int behavior)
 {
-	struct mm_struct * mm = vma->vm_mm;
+	struct mm_struct *mm = vma->vm_mm;
 	int error;

 	if (start != vma->vm_start) {
diff -urdp linux-2.6.1-mm1-orig/mm/mlock.c linux-2.6.1-mm1-juhl/mm/mlock.c
--- linux-2.6.1-mm1-orig/mm/mlock.c	2004-01-09 07:59:07.000000000 +0100
+++ linux-2.6.1-mm1-juhl/mm/mlock.c	2004-01-11 01:53:16.000000000 +0100
@@ -12,7 +12,7 @@
 static int mlock_fixup(struct vm_area_struct * vma,
 	unsigned long start, unsigned long end, unsigned int newflags)
 {
-	struct mm_struct * mm = vma->vm_mm;
+	struct mm_struct *mm = vma->vm_mm;
 	int pages;
 	int ret = 0;

diff -urdp linux-2.6.1-mm1-orig/mm/mmap.c linux-2.6.1-mm1-juhl/mm/mmap.c
--- linux-2.6.1-mm1-orig/mm/mmap.c	2004-01-09 19:04:32.000000000 +0100
+++ linux-2.6.1-mm1-juhl/mm/mmap.c	2004-01-11 02:49:25.000000000 +0100
@@ -147,7 +147,7 @@ static int browse_rb(struct rb_node * rb
 	return i;
 }

-static void validate_mm(struct mm_struct * mm) {
+static void validate_mm(struct mm_struct *mm) {
 	int bug = 0;
 	int i = 0;
 	struct vm_area_struct * tmp = mm->mmap;
@@ -284,7 +284,7 @@ static void vma_link(struct mm_struct *m
  * ->f_mappping->i_shared_sem if vm_file is non-NULL.
  */
 static void
-__insert_vm_struct(struct mm_struct * mm, struct vm_area_struct * vma)
+__insert_vm_struct(struct mm_struct *mm, struct vm_area_struct * vma)
 {
 	struct vm_area_struct * __vma, * prev;
 	struct rb_node ** rb_link, * rb_parent;
@@ -464,13 +464,13 @@ unsigned long do_mmap_pgoff(struct file
 			unsigned long len, unsigned long prot,
 			unsigned long flags, unsigned long pgoff)
 {
-	struct mm_struct * mm = current->mm;
-	struct vm_area_struct * vma, * prev;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma, *prev;
 	struct inode *inode;
 	unsigned int vm_flags;
 	int correct_wcount = 0;
 	int error;
-	struct rb_node ** rb_link, * rb_parent;
+	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged = 0;

 	if (file) {
@@ -815,7 +815,7 @@ get_unmapped_area(struct file *file, uns
 EXPORT_SYMBOL(get_unmapped_area);

 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
-struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr)
+struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
 	struct vm_area_struct *vma = NULL;

@@ -858,7 +858,7 @@ find_vma_prev(struct mm_struct *mm, unsi
 			struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *vma = NULL, *prev = NULL;
-	struct rb_node * rb_node;
+	struct rb_node *rb_node;
 	if (!mm)
 		goto out;

@@ -985,9 +985,9 @@ int expand_stack(struct vm_area_struct *
 }

 struct vm_area_struct *
-find_extend_vma(struct mm_struct * mm, unsigned long addr)
+find_extend_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct vm_area_struct * vma;
+	struct vm_area_struct *vma;
 	unsigned long start;

 	addr &= PAGE_MASK;
@@ -1173,7 +1173,7 @@ detach_vmas_to_be_unmapped(struct mm_str
  * Split a vma into two pieces at address 'addr', a new vma is allocated
  * either for the first part or the the tail.
  */
-int split_vma(struct mm_struct * mm, struct vm_area_struct * vma,
+int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	      unsigned long addr, int new_below)
 {
 	struct vm_area_struct *new;
@@ -1319,10 +1319,10 @@ asmlinkage long sys_munmap(unsigned long
  */
 unsigned long do_brk(unsigned long addr, unsigned long len)
 {
-	struct mm_struct * mm = current->mm;
-	struct vm_area_struct * vma, * prev;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma, *prev;
 	unsigned long flags;
-	struct rb_node ** rb_link, * rb_parent;
+	struct rb_node ** rb_link, *rb_parent;

 	len = PAGE_ALIGN(len);
 	if (!len)
@@ -1404,10 +1404,10 @@ out:
 EXPORT_SYMBOL(do_brk);

 /* Build the RB tree corresponding to the VMA list. */
-void build_mmap_rb(struct mm_struct * mm)
+void build_mmap_rb(struct mm_struct *mm)
 {
-	struct vm_area_struct * vma;
-	struct rb_node ** rb_link, * rb_parent;
+	struct vm_area_struct *vma;
+	struct rb_node **rb_link, *rb_parent;

 	mm->mm_rb = RB_ROOT;
 	rb_link = &mm->mm_rb.rb_node;
@@ -1473,10 +1473,10 @@ void exit_mmap(struct mm_struct *mm)
  * and into the inode's i_mmap ring.  If vm_file is non-NULL
  * then i_shared_sem is taken here.
  */
-void insert_vm_struct(struct mm_struct * mm, struct vm_area_struct * vma)
+void insert_vm_struct(struct mm_struct *mm, struct vm_area_struct * vma)
 {
-	struct vm_area_struct * __vma, * prev;
-	struct rb_node ** rb_link, * rb_parent;
+	struct vm_area_struct *__vma, *prev;
+	struct rb_node **rb_link, *rb_parent;

 	__vma = find_vma_prepare(mm,vma->vm_start,&prev,&rb_link,&rb_parent);
 	if (__vma && __vma->vm_start < vma->vm_end)
diff -urdp linux-2.6.1-mm1-orig/mm/mprotect.c linux-2.6.1-mm1-juhl/mm/mprotect.c
--- linux-2.6.1-mm1-orig/mm/mprotect.c	2004-01-09 07:59:26.000000000 +0100
+++ linux-2.6.1-mm1-juhl/mm/mprotect.c	2004-01-11 01:53:41.000000000 +0100
@@ -114,7 +114,7 @@ static int
 mprotect_attempt_merge(struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long end, int newflags)
 {
-	struct mm_struct * mm = vma->vm_mm;
+	struct mm_struct *mm = vma->vm_mm;

 	if (!prev || !vma)
 		return 0;
@@ -154,7 +154,7 @@ static int
 mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	unsigned long start, unsigned long end, unsigned int newflags)
 {
-	struct mm_struct * mm = vma->vm_mm;
+	struct mm_struct *mm = vma->vm_mm;
 	unsigned long charged = 0;
 	pgprot_t newprot;
 	int error;
diff -urdp linux-2.6.1-mm1-orig/mm/nommu.c linux-2.6.1-mm1-juhl/mm/nommu.c
--- linux-2.6.1-mm1-orig/mm/nommu.c	2004-01-09 19:04:32.000000000 +0100
+++ linux-2.6.1-mm1-juhl/mm/nommu.c	2004-01-11 01:56:15.000000000 +0100
@@ -436,9 +436,9 @@ unsigned long do_mmap_pgoff(
 	return (unsigned long)result;
 }

-int do_munmap(struct mm_struct * mm, unsigned long addr, size_t len)
+int do_munmap(struct mm_struct *mm, unsigned long addr, size_t len)
 {
-	struct mm_tblock_struct * tblock, *tmp;
+	struct mm_tblock_struct *tblock, *tmp;

 #ifdef MAGIC_ROM_PTR
 	/*
@@ -489,7 +489,7 @@ int do_munmap(struct mm_struct * mm, uns
 }

 /* Release all mmaps. */
-void exit_mmap(struct mm_struct * mm)
+void exit_mmap(struct mm_struct *mm)
 {
 	struct mm_tblock_struct *tmp;

@@ -541,7 +541,7 @@ unsigned long do_brk(unsigned long addr,
 	return -ENOMEM;
 }

-struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr)
+struct vm_area_struct * find_vma(struct mm_struct *mm, unsigned long addr)
 {
 	return NULL;
 }
diff -urdp linux-2.6.1-mm1-orig/mm/rmap.c linux-2.6.1-mm1-juhl/mm/rmap.c
--- linux-2.6.1-mm1-orig/mm/rmap.c	2004-01-09 19:04:32.000000000 +0100
+++ linux-2.6.1-mm1-juhl/mm/rmap.c	2004-01-11 01:56:39.000000000 +0100
@@ -297,7 +297,7 @@ static int try_to_unmap_one(struct page
 {
 	pte_t *ptep = rmap_ptep_map(paddr);
 	unsigned long address = ptep_to_address(ptep);
-	struct mm_struct * mm = ptep_to_mm(ptep);
+	struct mm_struct *mm = ptep_to_mm(ptep);
 	struct vm_area_struct * vma;
 	pte_t pte;
 	int ret;
diff -urdp linux-2.6.1-mm1-orig/mm/swapfile.c linux-2.6.1-mm1-juhl/mm/swapfile.c
--- linux-2.6.1-mm1-orig/mm/swapfile.c	2004-01-09 19:04:32.000000000 +0100
+++ linux-2.6.1-mm1-juhl/mm/swapfile.c	2004-01-11 01:57:01.000000000 +0100
@@ -485,7 +485,7 @@ static int unuse_vma(struct vm_area_stru
 	return 0;
 }

-static int unuse_process(struct mm_struct * mm,
+static int unuse_process(struct mm_struct *mm,
 			swp_entry_t entry, struct page* page)
 {
 	struct vm_area_struct* vma;




Kind regards,

Jesper Juhl


