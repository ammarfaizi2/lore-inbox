Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S157076AbPJLR6z>; Tue, 12 Oct 1999 13:58:55 -0400
Received: by vger.rutgers.edu id <S156790AbPJLR4K>; Tue, 12 Oct 1999 13:56:10 -0400
Received: from colorfullife.com ([216.156.138.34]:4303 "EHLO colorfullife.com") by vger.rutgers.edu with ESMTP id <S157085AbPJLRuP>; Tue, 12 Oct 1999 13:50:15 -0400
Date: Tue, 12 Oct 1999 19:50:07 +0200 (CEST)
From: manfreds <manfreds@colorfullife.com>
To: viro@math.psu.edu
Cc: linux-kernel@vger.rutgers.edu, linux-mm@kvack.org
Subject: vma_list_sem
Message-ID: <Pine.LNX.4.10.9910121943300.17128-100000@clmsdevli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

I've merged your patch and my patch, the result is below.
It still contains the complete debugging code, and I've not
yet performed any low-memory testing.

I found one more find_vma() caller which performs no locking:
fs/super.c: copy_mount_options().

Unfortunately, I found no clean solution for this function, but
I think my fix is acceptable. [there is an obscure race possible,
a multi-threaded application could fail with -EFAULT although
all parameters are valid].


--
	Manfred
<<<<<<<<<<<<<<<<<<<<<<<<<<<
// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 3
//  SUBLEVEL = 20
//  EXTRAVERSION =
diff -r -u 2.3/arch/i386/mm/fault.c build-2.3/arch/i386/mm/fault.c
--- 2.3/arch/i386/mm/fault.c	Tue Aug 10 09:53:55 1999
+++ build-2.3/arch/i386/mm/fault.c	Tue Oct 12 19:39:39 1999
@@ -35,6 +35,7 @@
 	if (!size)
 		return 1;
 
+	down(&current->mm->mmap_sem);
 	vma = find_vma(current->mm, start);
 	if (!vma)
 		goto bad_area;
@@ -64,6 +65,7 @@
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;;
 	}
+	up(&current->mm->mmap_sem);
 	return 1;
 
 check_stack:
@@ -73,6 +75,7 @@
 		goto good_area;
 
 bad_area:
+	up(&current->mm->mmap_sem);
 	return 0;
 }
 
diff -r -u 2.3/arch/m68k/kernel/sys_m68k.c build-2.3/arch/m68k/kernel/sys_m68k.c
--- 2.3/arch/m68k/kernel/sys_m68k.c	Tue Jan 19 19:58:34 1999
+++ build-2.3/arch/m68k/kernel/sys_m68k.c	Tue Oct 12 18:31:36 1999
@@ -535,6 +535,7 @@
 	int ret = -EINVAL;
 
 	lock_kernel();
+	down(&current->mm->mmap_sem);
 	if (scope < FLUSH_SCOPE_LINE || scope > FLUSH_SCOPE_ALL ||
 	    cache & ~FLUSH_CACHE_BOTH)
 		goto out;
@@ -591,6 +592,7 @@
 		ret = cache_flush_060 (addr, scope, cache, len);
 	}
 out:
+	up(&current->mm->mmap_sem);
 	unlock_kernel();
 	return ret;
 }
diff -r -u 2.3/arch/mips/kernel/sysirix.c build-2.3/arch/mips/kernel/sysirix.c
--- 2.3/arch/mips/kernel/sysirix.c	Thu Jul  1 15:05:14 1999
+++ build-2.3/arch/mips/kernel/sysirix.c	Tue Oct 12 18:31:36 1999
@@ -534,6 +534,7 @@
 	int ret;
 
 	lock_kernel();
+	down(&current->mm->mmap_sem);
 	if (brk < current->mm->end_code) {
 		ret = -ENOMEM;
 		goto out;
@@ -591,6 +592,7 @@
 	ret = 0;
 
 out:
+	up(&current->mm->mmap_sem);
 	unlock_kernel();
 	return ret;
 }
diff -r -u 2.3/arch/sh/mm/fault.c build-2.3/arch/sh/mm/fault.c
--- 2.3/arch/sh/mm/fault.c	Tue Sep  7 23:35:59 1999
+++ build-2.3/arch/sh/mm/fault.c	Tue Oct 12 18:31:36 1999
@@ -38,6 +38,7 @@
 	if (!size)
 		return 1;
 
+	down(&current->mm->mmap_sem);
 	vma = find_vma(current->mm, start);
 	if (!vma)
 		goto bad_area;
@@ -67,6 +68,7 @@
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;;
 	}
+	up(&current->mm->mmap_sem);
 	return 1;
 
 check_stack:
@@ -76,6 +78,7 @@
 		goto good_area;
 
 bad_area:
+	up(&current->mm->mmap_sem);
 	return 0;
 }
 
diff -r -u 2.3/fs/binfmt_aout.c build-2.3/fs/binfmt_aout.c
--- 2.3/fs/binfmt_aout.c	Wed Sep  1 18:22:44 1999
+++ build-2.3/fs/binfmt_aout.c	Tue Oct 12 19:33:17 1999
@@ -45,7 +45,9 @@
 	end = PAGE_ALIGN(end);
 	if (end <= start)
 		return;
+	down(&current->mm->mmap_sem);
 	do_brk(start, end - start);
+	up(&current->mm->mmap_sem);
 }
 
 /*
@@ -383,12 +385,14 @@
 			goto beyond_if;
 		}
 
+		down(&current->mm->mmap_sem);
 		error = do_mmap(file, N_TXTADDR(ex), ex.a_text,
 			PROT_READ | PROT_EXEC,
 			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
 			fd_offset);
 
 		if (error != N_TXTADDR(ex)) {
+			up(&current->mm->mmap_sem);
 			fput(file);
 			sys_close(fd);
 			send_sig(SIGKILL, current, 0);
@@ -399,6 +403,7 @@
 				PROT_READ | PROT_WRITE | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
 				fd_offset + ex.a_text);
+		up(&current->mm->mmap_sem);
 		fput(file);
 		sys_close(fd);
 		if (error != N_DATADDR(ex)) {
@@ -504,9 +509,11 @@
 		       file->f_dentry->d_name.name
 		       );
 		
+		down(&current->mm->mmap_sem);
 		do_mmap(NULL, start_addr & PAGE_MASK, ex.a_text + ex.a_data + ex.a_bss,
 			PROT_READ | PROT_WRITE | PROT_EXEC,
 			MAP_FIXED| MAP_PRIVATE, 0);
+		up(&current->mm->mmap_sem);
 		
 		read_exec(file->f_dentry, N_TXTOFF(ex),
 			  (char *)start_addr, ex.a_text + ex.a_data, 0);
@@ -517,10 +524,12 @@
 		goto out_putf;
 	}
 	/* Now use mmap to map the library into memory. */
+	down(&current->mm->mmap_sem);
 	error = do_mmap(file, start_addr, ex.a_text + ex.a_data,
 			PROT_READ | PROT_WRITE | PROT_EXEC,
 			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
 			N_TXTOFF(ex));
+	up(&current->mm->mmap_sem);
 	retval = error;
 	if (error != start_addr)
 		goto out_putf;
diff -r -u 2.3/fs/binfmt_elf.c build-2.3/fs/binfmt_elf.c
--- 2.3/fs/binfmt_elf.c	Tue Aug 10 09:54:23 1999
+++ build-2.3/fs/binfmt_elf.c	Tue Oct 12 19:33:04 1999
@@ -73,7 +73,9 @@
 	end = ELF_PAGEALIGN(end);
 	if (end <= start)
 		return;
+	down(&current->mm->mmap_sem);
 	do_brk(start, end - start);
+	up(&current->mm->mmap_sem);
 }
 
 
@@ -277,12 +279,14 @@
 #endif
 	    }
 
+	    down(&current->mm->mmap_sem);
 	    map_addr = do_mmap(file,
 			    load_addr + ELF_PAGESTART(vaddr),
 			    eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr),
 			    elf_prot,
 			    elf_type,
 			    eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
+	    up(&current->mm->mmap_sem);
 	    if (map_addr > -1024UL) /* Real error */
 		goto out_close;
 
@@ -626,12 +630,13 @@
 			elf_flags |= MAP_FIXED;
 		}
 
+		down(&current->mm->mmap_sem);
 		error = do_mmap(file, ELF_PAGESTART(load_bias + vaddr),
 		                (elf_ppnt->p_filesz +
 		                ELF_PAGEOFFSET(elf_ppnt->p_vaddr)),
 		                elf_prot, elf_flags, (elf_ppnt->p_offset -
 		                ELF_PAGEOFFSET(elf_ppnt->p_vaddr)));
-
+		up(&current->mm->mmap_sem);
 		if (!load_addr_set) {
 			load_addr_set = 1;
 			load_addr = (elf_ppnt->p_vaddr - elf_ppnt->p_offset);
@@ -745,8 +750,10 @@
 		   Since we do not have the power to recompile these, we
 		   emulate the SVr4 behavior.  Sigh.  */
 		/* N.B. Shouldn't the size here be PAGE_SIZE?? */
+		down(&current->mm->mmap_sem);
 		error = do_mmap(NULL, 0, 4096, PROT_READ | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE, 0);
+		up(&current->mm->mmap_sem);
 	}
 
 #ifdef ELF_PLAT_INIT
@@ -857,6 +864,7 @@
 	while (elf_phdata->p_type != PT_LOAD) elf_phdata++;
 
 	/* Now use mmap to map the library into memory. */
+	down(&current->mm->mmap_sem);
 	error = do_mmap(file,
 			ELF_PAGESTART(elf_phdata->p_vaddr),
 			(elf_phdata->p_filesz +
@@ -865,6 +873,7 @@
 			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
 			(elf_phdata->p_offset -
 			 ELF_PAGEOFFSET(elf_phdata->p_vaddr)));
+	up(&current->mm->mmap_sem);
 	if (error != ELF_PAGESTART(elf_phdata->p_vaddr))
 		goto out_free_ph;
 
diff -r -u 2.3/fs/exec.c build-2.3/fs/exec.c
--- 2.3/fs/exec.c	Tue Oct 12 18:02:40 1999
+++ build-2.3/fs/exec.c	Tue Oct 12 19:10:17 1999
@@ -265,6 +265,7 @@
 	if (!mpnt) 
 		return -ENOMEM; 
 	
+	down(&current->mm->mmap_sem);
 	{
 		mpnt->vm_mm = current->mm;
 		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
@@ -278,6 +279,7 @@
 		insert_vm_struct(current->mm, mpnt);
 		current->mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
 	} 
+	up(&current->mm->mmap_sem);
 
 	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
 		if (bprm->page[i]) {
diff -r -u 2.3/fs/super.c build-2.3/fs/super.c
--- 2.3/fs/super.c	Wed Sep  1 18:22:45 1999
+++ build-2.3/fs/super.c	Tue Oct 12 19:37:26 1999
@@ -977,7 +977,7 @@
 
 static int copy_mount_options (const void * data, unsigned long *where)
 {
-	int i;
+	unsigned long i;
 	unsigned long page;
 	struct vm_area_struct * vma;
 
@@ -985,6 +985,10 @@
 	if (!data)
 		return 0;
 
+	if (!(page = __get_free_page(GFP_KERNEL))) {
+		return -ENOMEM;
+	}
+	down(&current->mm->mmap_sem);
 	vma = find_vma(current->mm, (unsigned long) data);
 	if (!vma || (unsigned long) data < vma->vm_start)
 		return -EFAULT;
@@ -993,9 +997,8 @@
 	i = vma->vm_end - (unsigned long) data;
 	if (PAGE_SIZE <= (unsigned long) i)
 		i = PAGE_SIZE-1;
-	if (!(page = __get_free_page(GFP_KERNEL))) {
-		return -ENOMEM;
-	}
+	up(&current->mm->mmap_sem);
+	
 	if (copy_from_user((void *) page,data,i)) {
 		free_page(page); 
 		return -EFAULT;
diff -r -u 2.3/include/linux/sched.h build-2.3/include/linux/sched.h
--- 2.3/include/linux/sched.h	Tue Oct 12 18:02:40 1999
+++ build-2.3/include/linux/sched.h	Tue Oct 12 18:04:10 1999
@@ -213,6 +213,7 @@
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
 	int map_count;				/* number of VMAs */
 	struct semaphore mmap_sem;
+	struct semaphore vma_list_sem;
 	spinlock_t page_table_lock;
 	unsigned long context;
 	unsigned long start_code, end_code, start_data, end_data;
@@ -235,6 +236,7 @@
 		swapper_pg_dir, 			\
 		ATOMIC_INIT(2), ATOMIC_INIT(1), 1,	\
 		__MUTEX_INITIALIZER(name.mmap_sem),	\
+		__MUTEX_INITIALIZER(name.vma_list_sem),	\
 		SPIN_LOCK_UNLOCKED,			\
 		0,					\
 		0, 0, 0, 0,				\
diff -r -u 2.3/kernel/fork.c build-2.3/kernel/fork.c
--- 2.3/kernel/fork.c	Tue Oct 12 18:02:40 1999
+++ build-2.3/kernel/fork.c	Tue Oct 12 18:02:24 1999
@@ -303,6 +303,7 @@
 		atomic_set(&mm->mm_users, 1);
 		atomic_set(&mm->mm_count, 1);
 		init_MUTEX(&mm->mmap_sem);
+		init_MUTEX(&mm->vma_list_sem);
 		mm->page_table_lock = SPIN_LOCK_UNLOCKED;
 		mm->pgd = pgd_alloc();
 		if (mm->pgd)
diff -r -u 2.3/kernel/ptrace.c build-2.3/kernel/ptrace.c
--- 2.3/kernel/ptrace.c	Wed Sep  1 18:22:53 1999
+++ build-2.3/kernel/ptrace.c	Tue Oct 12 19:32:52 1999
@@ -79,14 +79,15 @@
 
 int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write)
 {
-	int copied;
-	struct vm_area_struct * vma = find_extend_vma(tsk, addr);
+	int copied = 0;
+	struct vm_area_struct * vma;
+
+	down(&tsk->mm->mmap_sem);
+	vma = find_extend_vma(tsk, addr);
 
 	if (!vma)
-		return 0;
+		goto out;
 
-	down(&tsk->mm->mmap_sem);
-	copied = 0;
 	for (;;) {
 		unsigned long offset = addr & ~PAGE_MASK;
 		int this_len = PAGE_SIZE - offset;
@@ -115,6 +116,7 @@
 	
 		vma = vma->vm_next;
 	}
+out:
 	up(&tsk->mm->mmap_sem);
 	return copied;
 }
diff -r -u 2.3/mm/mmap.c build-2.3/mm/mmap.c
--- 2.3/mm/mmap.c	Tue Sep  7 23:36:11 1999
+++ build-2.3/mm/mmap.c	Tue Oct 12 19:34:12 1999
@@ -16,6 +16,129 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 
+#define MMAP_DEBUG	1
+
+#if defined(__SMP__) && defined(MMAP_DEBUG)
+
+#ifdef __i386__
+extern int kstack_depth_to_print;
+#define VMALLOC_OFFSET (8*1024*1024)
+#define MODULE_RANGE (8*1024*1024)
+
+extern unsigned long _stext;
+extern unsigned long _etext;
+
+void show_stack(void)
+{
+	unsigned long *stack, addr, module_start, module_end;
+	int i;
+	unsigned long esp;
+	__asm__("mov %%esp,%0; ":"=r" (esp));
+
+	printk("\nStack: ");
+	stack = (unsigned long *) esp;
+	for(i=0; i < 2*kstack_depth_to_print; i++) {
+		if (((long) stack & 4095) == 0)
+			break;
+		if (i && ((i % 8) == 0))
+			printk("\n       ");
+		printk("%08lx ", *stack++);
+	}
+	printk("\nCall Trace: ");
+	stack = (unsigned long *) esp;
+	i = 1;
+	module_start = PAGE_OFFSET + (max_mapnr << PAGE_SHIFT);
+	module_start = ((module_start + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1));
+	module_end = module_start + MODULE_RANGE;
+	while (((long) stack & 4095) != 0) {
+		addr = *stack++;
+		/*
+		 * If the address is either in the text segment of the
+		 * kernel, or in the region which contains vmalloc'ed
+		 * memory, it *may* be the address of a calling
+		 * routine; if so, print it so that someone tracing
+		 * down the cause of the crash will be able to figure
+		 * out the call path that was taken.
+		 */
+		if (((addr >= (unsigned long) &_stext) &&
+		     (addr <= (unsigned long) &_etext)) ||
+		    ((addr >= module_start) && (addr <= module_end))) {
+			if (i && ((i % 8) == 0))
+				printk("\n       ");
+			printk("[<%08lx>] ", addr);
+			i++;
+		}
+	}
+}
+#else
+#define show_stack()	(void)0
+#endif
+
+
+static inline int test_down(struct semaphore* sem)
+{
+	if(!down_trylock(sem)) {
+		up(sem);
+		return 0;
+	}
+	return 1;
+}
+static inline void assert_down(struct semaphore* sem)
+{
+	if(!test_down(sem)) {
+		printk("semaphore not acquired by %lxh.\n",__builtin_return_address(0));
+		show_stack();
+	}
+}
+
+void assert_up(struct semaphore* sem)
+{
+	if(test_down(sem)) {
+		printk("semaphore acquired by %lxh.\n",__builtin_return_address(0));
+		show_stack();
+	}
+}
+
+static inline void test_vmareadlock(struct mm_struct * mm)
+{
+	if(test_down(&mm->mmap_sem))
+		return;
+	if(test_down(&mm->vma_list_sem))
+		return;
+	printk("test_vamreadlock() failed %lxh.\n",__builtin_return_address(0));
+	show_stack();
+}
+
+static inline void test_vmawritelock(struct mm_struct *mm)
+{
+	if(test_down(&mm->mmap_sem) && test_down(&mm->vma_list_sem))
+		return;
+	printk("test_vmawritelock(): failed %lxh.\n",__builtin_return_address(0));
+	show_stack();
+}
+
+#else
+
+static inline void assert_down(struct semaphore* sem)
+{
+	sem;
+}
+void assert_up(struct semaphore* sem)
+{
+	sem;
+}
+static inline void test_vmareadlock(struct mm_struct * mm)
+{
+	mm;
+}
+
+static inline void test_vmawritelock(struct mm_struct *mm)
+{
+	mm;
+}
+
+#endif
+
 /* description of effects of mapping type and prot in current implementation.
  * this is due to the limited x86 page protection hardware.  The expected
  * behavior is in parens:
@@ -183,7 +306,8 @@
 	/* offset overflow? */
 	if (off + len < off)
 		return -EINVAL;
-
+	
+	assert_down(&mm->mmap_sem);
 	/* Too many mappings? */
 	if (mm->map_count > MAX_MAP_COUNT)
 		return -ENOMEM;
@@ -358,6 +482,7 @@
 		addr = TASK_UNMAPPED_BASE;
 	addr = PAGE_ALIGN(addr);
 
+	test_vmareadlock(current->mm);
 	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
 		/* At this point:  (!vmm || addr < vmm->vm_end). */
 		if (TASK_SIZE - len < addr)
@@ -378,6 +503,7 @@
 	struct vm_area_struct *vma = NULL;
 
 	if (mm) {
+		test_vmareadlock(mm);
 		/* Check the cache first. */
 		/* (Cache hit rate is typically around 35%.) */
 		vma = mm->mmap_cache;
@@ -415,6 +541,7 @@
 				      struct vm_area_struct **pprev)
 {
 	if (mm) {
+		test_vmareadlock(mm);
 		if (!mm->mmap_avl) {
 			/* Go through the linear list. */
 			struct vm_area_struct * prev = NULL;
@@ -579,6 +706,7 @@
 	unsigned long first = start & PGDIR_MASK;
 	unsigned long last = (end + PGDIR_SIZE - 1) & PGDIR_MASK;
 
+	test_vmareadlock(mm);
 	if (!prev) {
 		prev = mm->mmap;
 		if (!prev)
@@ -633,6 +761,7 @@
 	 * on the list.  If nothing is put on, nothing is affected.
 	 */
 	mm = current->mm;
+	assert_down(&mm->mmap_sem);
 	mpnt = find_vma_prev(mm, addr, &prev);
 	if (!mpnt)
 		return 0;
@@ -654,6 +783,7 @@
 	if (!extra)
 		return -ENOMEM;
 
+	down(&mm->vma_list_sem);
 	npp = (prev ? &prev->vm_next : &mm->mmap);
 	free = NULL;
 	for ( ; mpnt && mpnt->vm_start < addr+len; mpnt = *npp) {
@@ -669,6 +799,7 @@
 	 * If the one of the segments is only being partially unmapped,
 	 * it will put new vm_area_struct(s) into the address space.
 	 */
+	up(&mm->vma_list_sem);
 	while ((mpnt = free) != NULL) {
 		unsigned long st, end, size;
 
@@ -678,11 +809,10 @@
 		end = addr+len;
 		end = end > mpnt->vm_end ? mpnt->vm_end : end;
 		size = end - st;
+	
 
-		lock_kernel();
 		if (mpnt->vm_ops && mpnt->vm_ops->unmap)
 			mpnt->vm_ops->unmap(mpnt, st, size);
-		unlock_kernel();
 
 		remove_shared_vm_struct(mpnt);
 		mm->map_count--;
@@ -732,6 +862,7 @@
 	if (!len)
 		return addr;
 
+	assert_down(&mm->mmap_sem);
 	/*
 	 * mlock MCL_FUTURE?
 	 */
@@ -855,6 +986,8 @@
 	struct vm_area_struct **pprev;
 	struct file * file;
 
+	assert_down(&mm->mmap_sem);
+	down(&mm->vma_list_sem);
 	if (!mm->mmap_avl) {
 		pprev = &mm->mmap;
 		while (*pprev && (*pprev)->vm_start <= vmp->vm_start)
@@ -887,6 +1020,7 @@
 		vmp->vm_pprev_share = &inode->i_mmap;
 		spin_unlock(&inode->i_shared_lock);
 	}
+	up(&mm->vma_list_sem);
 }
 
 /* Merge the list of memory segments if possible.
@@ -905,6 +1039,8 @@
 	if (!mpnt)
 		return;
 
+	assert_down(&mm->mmap_sem);
+	down(&mm->vma_list_sem);
 	if (prev1) {
 		prev = prev1;
 	} else {
@@ -957,6 +1093,7 @@
 		mpnt = prev;
 	}
 	mm->mmap_cache = NULL;		/* Kill the cache. */
+	up(&mm->vma_list_sem);
 }
 
 void __init vma_init(void)
diff -r -u 2.3/mm/vmscan.c build-2.3/mm/vmscan.c
--- 2.3/mm/vmscan.c	Sat Oct  9 22:51:29 1999
+++ build-2.3/mm/vmscan.c	Tue Oct 12 18:38:30 1999
@@ -295,6 +295,8 @@
 	/*
 	 * Find the proper vm-area
 	 */
+	assert_up(&mm->vma_list_sem);
+	down(&mm->vma_list_sem);
 	vma = find_vma(mm, address);
 	if (vma) {
 		if (address < vma->vm_start)
@@ -302,14 +304,17 @@
 
 		for (;;) {
 			int result = swap_out_vma(vma, address, gfp_mask);
-			if (result)
+			if (result) {
+				up(&mm->vma_list_sem);
 				return result;
+			}
 			vma = vma->vm_next;
 			if (!vma)
 				break;
 			address = vma->vm_start;
 		}
 	}
+	up(&mm->vma_list_sem);
 
 	/* We didn't find anything for the process */
 	mm->swap_cnt = 0;
>>>>>>>>>>>>>>>>>>>>>>>>>>>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
