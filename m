Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130323AbRAACSO>; Sun, 31 Dec 2000 21:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130468AbRAACSE>; Sun, 31 Dec 2000 21:18:04 -0500
Received: from slc231.modem.xmission.com ([166.70.9.231]:30471 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S130323AbRAACRy>; Sun, 31 Dec 2000 21:17:54 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: [PATCH] maintain a dirty RSS count for 2.4.0-test13-pre7
In-Reply-To: <Pine.LNX.4.21.0012281804430.1403-100000@duckman.distro.conectiva>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 31 Dec 2000 18:36:13 -0700
In-Reply-To: Rik van Riel's message of "Thu, 28 Dec 2000 18:22:56 -0200 (BRDT)"
Message-ID: <m1bstsoxyq.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik, Linus, all.

The following patch is intended to compliment the work done with the
max RSS limit patch.  For now all I do is track the number of dirty
pages that are in a processes working set.  The code compiles but
hasn't _yet_ been run. 

The idea is simple.  We manually handle the transition from clean
mapped page to dirty page so we can always get the dirty counts.
There were only two places in the kernel that needed to be changed
to get this to work. 

For the rest I just added code to increment dirty_rss in appropriate
places.

I'm not quite certain how we want to take advantage of this code.  But
in situations where we are heavily swapping but not yet thrashing
knowing which processes have dirty pages in them should be a help.  

I haven't evaluated 2.4's swapping behavior, but I know classically
not being to limit the number of dirty pages in the system has been
an Achilles heal of our swap code.

Comments?

Eric


diff -uNrX linux-ignore-files linux-2.4.0-test13-pre7/arch/ia64/ia32/binfmt_elf32.c linux-2.4.0-test13-pre7.rss-dirty-count/arch/ia64/ia32/binfmt_elf32.c
--- linux-2.4.0-test13-pre7/arch/ia64/ia32/binfmt_elf32.c	Tue Dec  5 23:39:01 2000
+++ linux-2.4.0-test13-pre7.rss-dirty-count/arch/ia64/ia32/binfmt_elf32.c	Sun Dec 31 12:26:10 2000
@@ -201,6 +201,7 @@
 	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
 		if (bprm->page[i]) {
 			current->mm->rss++;
+			current->mm->dirty_rss++;
 			put_dirty_page(current,bprm->page[i],stack_base);
 		}
 		stack_base += PAGE_SIZE;
diff -uNrX linux-ignore-files linux-2.4.0-test13-pre7/arch/mips/kernel/irixelf.c linux-2.4.0-test13-pre7.rss-dirty-count/arch/mips/kernel/irixelf.c
--- linux-2.4.0-test13-pre7/arch/mips/kernel/irixelf.c	Tue Dec  5 23:38:22 2000
+++ linux-2.4.0-test13-pre7.rss-dirty-count/arch/mips/kernel/irixelf.c	Sun Dec 31 12:28:33 2000
@@ -690,6 +690,7 @@
 	 * change some of these later.
 	 */
 	current->mm->rss = 0;
+	current->mm->dirty_rss = 0;
 	setup_arg_pages(bprm);
 	current->mm->start_stack = bprm->p;
 
diff -uNrX linux-ignore-files linux-2.4.0-test13-pre7/arch/mips/mm/umap.c linux-2.4.0-test13-pre7.rss-dirty-count/arch/mips/mm/umap.c
--- linux-2.4.0-test13-pre7/arch/mips/mm/umap.c	Sun Sep 10 19:31:21 2000
+++ linux-2.4.0-test13-pre7.rss-dirty-count/arch/mips/mm/umap.c	Sun Dec 31 18:08:13 2000
@@ -121,6 +121,8 @@
 		__free_page(ptpage);
 		if (current->mm->rss <= 0)
 			return;
+		if (pte_dirty(page)) 
+			current->mm->rss_dirty--;
 		current->mm->rss--;
 		return;
 	}
diff -uNrX linux-ignore-files linux-2.4.0-test13-pre7/arch/sparc64/kernel/binfmt_aout32.c linux-2.4.0-test13-pre7.rss-dirty-count/arch/sparc64/kernel/binfmt_aout32.c
--- linux-2.4.0-test13-pre7/arch/sparc64/kernel/binfmt_aout32.c	Sun Sep 10 19:30:30 2000
+++ linux-2.4.0-test13-pre7.rss-dirty-count/arch/sparc64/kernel/binfmt_aout32.c	Sun Dec 31 12:30:23 2000
@@ -239,6 +239,7 @@
 		(current->mm->start_brk = N_BSSADDR(ex));
 
 	current->mm->rss = 0;
+	current->mm->dirty_rss = 0;
 	current->mm->mmap = NULL;
 	compute_creds(bprm);
  	current->flags &= ~PF_FORKNOEXEC;
Binary files linux-2.4.0-test13-pre7/drivers/net/hamradio/soundmodem/gentbl and linux-2.4.0-test13-pre7.rss-dirty-count/drivers/net/hamradio/soundmodem/gentbl differ
diff -uNrX linux-ignore-files linux-2.4.0-test13-pre7/fs/binfmt_aout.c linux-2.4.0-test13-pre7.rss-dirty-count/fs/binfmt_aout.c
--- linux-2.4.0-test13-pre7/fs/binfmt_aout.c	Sun Sep 10 19:30:42 2000
+++ linux-2.4.0-test13-pre7.rss-dirty-count/fs/binfmt_aout.c	Sun Dec 31 12:31:33 2000
@@ -302,6 +302,7 @@
 		(current->mm->start_brk = N_BSSADDR(ex));
 
 	current->mm->rss = 0;
+	current->mm->dirty_rss = 0;
 	current->mm->mmap = NULL;
 	compute_creds(bprm);
  	current->flags &= ~PF_FORKNOEXEC;
diff -uNrX linux-ignore-files linux-2.4.0-test13-pre7/fs/binfmt_elf.c linux-2.4.0-test13-pre7.rss-dirty-count/fs/binfmt_elf.c
--- linux-2.4.0-test13-pre7/fs/binfmt_elf.c	Sun Dec 31 11:29:22 2000
+++ linux-2.4.0-test13-pre7.rss-dirty-count/fs/binfmt_elf.c	Sun Dec 31 12:31:22 2000
@@ -589,6 +589,7 @@
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
 	current->mm->rss = 0;
+	current->mm->dirty_rss = 0;
 	setup_arg_pages(bprm); /* XXX: check error */
 	current->mm->start_stack = bprm->p;
 
diff -uNrX linux-ignore-files linux-2.4.0-test13-pre7/fs/exec.c linux-2.4.0-test13-pre7.rss-dirty-count/fs/exec.c
--- linux-2.4.0-test13-pre7/fs/exec.c	Sun Dec 31 11:33:38 2000
+++ linux-2.4.0-test13-pre7.rss-dirty-count/fs/exec.c	Sun Dec 31 12:24:19 2000
@@ -322,6 +322,7 @@
 		if (page) {
 			bprm->page[i] = NULL;
 			current->mm->rss++;
+			current->mm->dirty_rss++;
 			put_dirty_page(current,page,stack_base);
 		}
 		stack_base += PAGE_SIZE;
diff -uNrX linux-ignore-files linux-2.4.0-test13-pre7/fs/proc/array.c linux-2.4.0-test13-pre7.rss-dirty-count/fs/proc/array.c
--- linux-2.4.0-test13-pre7/fs/proc/array.c	Tue Dec  5 23:39:22 2000
+++ linux-2.4.0-test13-pre7.rss-dirty-count/fs/proc/array.c	Sun Dec 31 12:55:38 2000
@@ -206,12 +206,14 @@
 		"VmData:\t%8lu kB\n"
 		"VmStk:\t%8lu kB\n"
 		"VmExe:\t%8lu kB\n"
-		"VmLib:\t%8lu kB\n",
+		"VmLib:\t%8lu kB\n"
+		"VmDirtyRSS:\t%8lu Kb\n",
 		mm->total_vm << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
 		mm->rss << (PAGE_SHIFT-10),
 		data - stack, stack,
-		exec - lib, lib);
+		exec - lib, lib,
+		mm->dirty_rss << (PAGE_SHIFT-10));
 	up(&mm->mmap_sem);
 	return buffer;
 }
diff -uNrX linux-ignore-files linux-2.4.0-test13-pre7/include/linux/sched.h linux-2.4.0-test13-pre7.rss-dirty-count/include/linux/sched.h
--- linux-2.4.0-test13-pre7/include/linux/sched.h	Sun Dec 31 11:33:43 2000
+++ linux-2.4.0-test13-pre7.rss-dirty-count/include/linux/sched.h	Sun Dec 31 15:52:19 2000
@@ -212,7 +212,7 @@
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
 	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long rss, total_vm, locked_vm;
+	unsigned long rss, dirty_rss, total_vm, locked_vm;
 	unsigned long def_flags;
 	unsigned long cpu_vm_mask;
 	unsigned long swap_cnt;	/* number of pages to swap on next pass */
diff -uNrX linux-ignore-files linux-2.4.0-test13-pre7/mm/memory.c linux-2.4.0-test13-pre7.rss-dirty-count/mm/memory.c
--- linux-2.4.0-test13-pre7/mm/memory.c	Sun Dec 31 11:33:43 2000
+++ linux-2.4.0-test13-pre7.rss-dirty-count/mm/memory.c	Sun Dec 31 18:00:55 2000
@@ -286,24 +286,22 @@
 	}
 }
 
-static inline int zap_pte_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address, unsigned long size)
+static inline void zap_pte_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address, unsigned long size)
 {
 	pte_t * pte;
-	int freed;
 
 	if (pmd_none(*pmd))
-		return 0;
+		return;
 	if (pmd_bad(*pmd)) {
 		pmd_ERROR(*pmd);
 		pmd_clear(pmd);
-		return 0;
+		return;
 	}
 	pte = pte_offset(pmd, address);
 	address &= ~PMD_MASK;
 	if (address + size > PMD_SIZE)
 		size = PMD_SIZE - address;
 	size >>= PAGE_SHIFT;
-	freed = 0;
 	for (;;) {
 		pte_t page;
 		if (!size)
@@ -313,36 +311,36 @@
 		size--;
 		if (pte_none(page))
 			continue;
-		freed += free_pte(page);
+		if (free_pte(page)) {
+			if (pte_dirty(page))
+				mm->dirty_rss--;
+			mm->rss--;
+		}
 	}
-	return freed;
 }
 
-static inline int zap_pmd_range(struct mm_struct *mm, pgd_t * dir, unsigned long address, unsigned long size)
+static inline void zap_pmd_range(struct mm_struct *mm, pgd_t * dir, unsigned long address, unsigned long size)
 {
 	pmd_t * pmd;
 	unsigned long end;
-	int freed;
 
 	if (pgd_none(*dir))
-		return 0;
+		return;
 	if (pgd_bad(*dir)) {
 		pgd_ERROR(*dir);
 		pgd_clear(dir);
-		return 0;
+		return;
 	}
 	pmd = pmd_offset(dir, address);
 	address &= ~PGDIR_MASK;
 	end = address + size;
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
-	freed = 0;
 	do {
-		freed += zap_pte_range(mm, pmd, address, end - address);
+		zap_pte_range(mm, pmd, address, end - address);
 		address = (address + PMD_SIZE) & PMD_MASK; 
 		pmd++;
 	} while (address < end);
-	return freed;
 }
 
 /*
@@ -352,7 +350,6 @@
 {
 	pgd_t * dir;
 	unsigned long end = address + size;
-	int freed = 0;
 
 	dir = pgd_offset(mm, address);
 
@@ -367,19 +364,11 @@
 		BUG();
 	spin_lock(&mm->page_table_lock);
 	do {
-		freed += zap_pmd_range(mm, dir, address, end - address);
+		zap_pmd_range(mm, dir, address, end - address);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
 	spin_unlock(&mm->page_table_lock);
-	/*
-	 * Update rss for the mm_struct (not necessarily current->mm)
-	 * Notice that rss is an unsigned long.
-	 */
-	if (mm->rss > freed)
-		mm->rss -= freed;
-	else
-		mm->rss = 0;
 }
 
 
@@ -853,6 +842,7 @@
 	case 1:
 		flush_cache_page(vma, address);
 		establish_pte(vma, address, page_table, pte_mkyoung(pte_mkdirty(pte_mkwrite(pte))));
+		mm->dirty_rss++;
 		spin_unlock(&mm->page_table_lock);
 		return 1;	/* Minor fault */
 	}
@@ -873,6 +863,7 @@
 		if (PageReserved(old_page))
 			++mm->rss;
 		break_cow(vma, old_page, new_page, address, page_table);
+		mm->dirty_rss++;
 
 		/* Free the old page.. */
 		new_page = old_page;
@@ -1044,8 +1035,15 @@
 	 */
 	lock_page(page);
 	swap_free(entry);
-	if (write_access && !is_page_shared(page))
+	if (write_access && !is_page_shared(page)) {
 		pte = pte_mkwrite(pte_mkdirty(pte));
+		mm->dirty_rss++;
+	}
+#if 1
+	else {
+		pte = pte_wrprotect(pte);
+	}
+#endif
 	UnlockPage(page);
 
 	set_pte(page_table, pte);
@@ -1068,6 +1066,7 @@
 		clear_user_highpage(page, addr);
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 		mm->rss++;
+		mm->dirty_rss++;
 		flush_page_to_ram(page);
 	}
 	set_pte(page_table, entry);
@@ -1122,8 +1121,12 @@
 	entry = mk_pte(new_page, vma->vm_page_prot);
 	if (write_access) {
 		entry = pte_mkwrite(pte_mkdirty(entry));
-	} else if (page_count(new_page) > 1 &&
+		mm->dirty_rss++;
+	} else 
+#if 0
+		if (page_count(new_page) > 1 &&
 		   !(vma->vm_flags & VM_SHARED))
+#endif
 		entry = pte_wrprotect(entry);
 	set_pte(page_table, entry);
 	/* no need to invalidate: a not-present page shouldn't be cached */
@@ -1178,6 +1181,7 @@
 			return do_wp_page(mm, vma, address, pte, entry);
 
 		entry = pte_mkdirty(entry);
+		mm->dirty_rss++;
 	}
 	entry = pte_mkyoung(entry);
 	establish_pte(vma, address, pte, entry);
diff -uNrX linux-ignore-files linux-2.4.0-test13-pre7/mm/mmap.c linux-2.4.0-test13-pre7.rss-dirty-count/mm/mmap.c
--- linux-2.4.0-test13-pre7/mm/mmap.c	Sun Dec 31 11:33:43 2000
+++ linux-2.4.0-test13-pre7.rss-dirty-count/mm/mmap.c	Sun Dec 31 12:32:16 2000
@@ -881,6 +881,7 @@
 	mm->mmap = mm->mmap_avl = mm->mmap_cache = NULL;
 	spin_unlock(&mm->page_table_lock);
 	mm->rss = 0;
+	mm->dirty_rss = 0;
 	mm->total_vm = 0;
 	mm->locked_vm = 0;
 	while (mpnt) {
diff -uNrX linux-ignore-files linux-2.4.0-test13-pre7/mm/vmscan.c linux-2.4.0-test13-pre7.rss-dirty-count/mm/vmscan.c
--- linux-2.4.0-test13-pre7/mm/vmscan.c	Sun Dec 31 11:33:43 2000
+++ linux-2.4.0-test13-pre7.rss-dirty-count/mm/vmscan.c	Sun Dec 31 12:10:04 2000
@@ -90,8 +90,10 @@
 	 */
 	if (PageSwapCache(page)) {
 		entry.val = page->index;
-		if (pte_dirty(pte))
+		if (pte_dirty(pte)) {
+			mm->dirty_rss--;
 			set_page_dirty(page);
+		}
 set_swap_pte:
 		swap_duplicate(entry);
 		set_pte(page_table, swp_entry_to_pte(entry));
@@ -130,6 +132,7 @@
 	 */
 	if (page->mapping) {
 		set_page_dirty(page);
+		mm->dirty_rss--;
 		goto drop_pte;
 	}
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
