Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUIOKwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUIOKwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 06:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUIOKwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 06:52:20 -0400
Received: from holomorphy.com ([207.189.100.168]:3995 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264668AbUIOKwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 06:52:12 -0400
Date: Wed, 15 Sep 2004 03:51:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: [procfs] [2/1] report per-process pagetable usage
Message-ID: <20040915105157.GM9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914025304.GT9106@holomorphy.com> <20040914025458.GU9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914025458.GU9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 07:53:04PM -0700, William Lee Irwin III wrote:
>> Not all binfmts page align ->end_code and ->start_code, so the task_mmu
>> statistics calculations need to perform this allocation themselves.

On Mon, Sep 13, 2004 at 07:54:58PM -0700, William Lee Irwin III wrote:
> s/allocation/alignment/

Andi Kleen requested that the number of pagetable pages in use by a
process be reported in /proc/$PID/status; this patch implements that.
Atop the text reporting fix. Compiletested on x86-64.

Index: mm5-2.6.9-rc1/arch/i386/mm/hugetlbpage.c
===================================================================
--- mm5-2.6.9-rc1.orig/arch/i386/mm/hugetlbpage.c	2004-08-13 22:37:42.000000000 -0700
+++ mm5-2.6.9-rc1/arch/i386/mm/hugetlbpage.c	2004-09-15 03:31:26.914794288 -0700
@@ -247,6 +247,7 @@
 
 			page = pmd_page(*pmd);
 			pmd_clear(pmd);
+			mm->nr_ptes--;
 			dec_page_state(nr_page_table_pages);
 			page_cache_release(page);
 		}
Index: mm5-2.6.9-rc1/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- mm5-2.6.9-rc1.orig/arch/ppc64/mm/hugetlbpage.c	2004-09-13 16:27:32.000000000 -0700
+++ mm5-2.6.9-rc1/arch/ppc64/mm/hugetlbpage.c	2004-09-15 03:32:25.375906848 -0700
@@ -213,6 +213,7 @@
 		}
 		page = pmd_page(*pmd);
 		pmd_clear(pmd);
+		mm->nr_ptes--;
 		dec_page_state(nr_page_table_pages);
 		pte_free_tlb(tlb, page);
 	}
Index: mm5-2.6.9-rc1/fs/proc/task_mmu.c
===================================================================
--- mm5-2.6.9-rc1.orig/fs/proc/task_mmu.c	2004-09-13 19:43:19.000000000 -0700
+++ mm5-2.6.9-rc1/fs/proc/task_mmu.c	2004-09-15 03:42:42.746052320 -0700
@@ -18,12 +18,14 @@
 		"VmData:\t%8lu kB\n"
 		"VmStk:\t%8lu kB\n"
 		"VmExe:\t%8lu kB\n"
-		"VmLib:\t%8lu kB\n",
+		"VmLib:\t%8lu kB\n"
+		"VmPTE:\t%8lu kB\n",
 		(mm->total_vm - mm->reserved_vm) << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
 		mm->rss << (PAGE_SHIFT-10),
 		data << (PAGE_SHIFT-10),
-		mm->stack_vm << (PAGE_SHIFT-10), text, lib);
+		mm->stack_vm << (PAGE_SHIFT-10), text, lib,
+		(PTRS_PER_PTE*sizeof(pte_t)*mm->nr_ptes) >> 10);
 	return buffer;
 }
 
Index: mm5-2.6.9-rc1/include/linux/sched.h
===================================================================
--- mm5-2.6.9-rc1.orig/include/linux/sched.h	2004-09-14 14:44:05.000000000 -0700
+++ mm5-2.6.9-rc1/include/linux/sched.h	2004-09-15 03:22:38.650102728 -0700
@@ -227,7 +227,7 @@
 	unsigned long start_brk, brk, start_stack;
 	unsigned long arg_start, arg_end, env_start, env_end;
 	unsigned long rss, total_vm, locked_vm, shared_vm;
-	unsigned long exec_vm, stack_vm, reserved_vm, def_flags;
+	unsigned long exec_vm, stack_vm, reserved_vm, def_flags, nr_ptes;
 
 	unsigned long saved_auxv[42]; /* for /proc/PID/auxv */
 
Index: mm5-2.6.9-rc1/kernel/fork.c
===================================================================
--- mm5-2.6.9-rc1.orig/kernel/fork.c	2004-09-14 14:45:49.000000000 -0700
+++ mm5-2.6.9-rc1/kernel/fork.c	2004-09-15 03:23:33.238803984 -0700
@@ -308,6 +308,7 @@
 	atomic_set(&mm->mm_count, 1);
 	init_rwsem(&mm->mmap_sem);
 	mm->core_waiters = 0;
+	mm->nr_ptes = 0;
 	mm->page_table_lock = SPIN_LOCK_UNLOCKED;
 	mm->ioctx_list_lock = RW_LOCK_UNLOCKED;
 	mm->ioctx_list = NULL;
Index: mm5-2.6.9-rc1/mm/memory.c
===================================================================
--- mm5-2.6.9-rc1.orig/mm/memory.c	2004-09-13 16:27:46.000000000 -0700
+++ mm5-2.6.9-rc1/mm/memory.c	2004-09-15 03:30:32.241105952 -0700
@@ -114,6 +114,7 @@
 	page = pmd_page(*dir);
 	pmd_clear(dir);
 	dec_page_state(nr_page_table_pages);
+	tlb->mm->nr_ptes--;
 	pte_free_tlb(tlb, page);
 }
 
@@ -163,7 +164,6 @@
 		spin_lock(&mm->page_table_lock);
 		if (!new)
 			return NULL;
-
 		/*
 		 * Because we dropped the lock, we should re-check the
 		 * entry, as somebody else could have populated it..
@@ -172,6 +172,7 @@
 			pte_free(new);
 			goto out;
 		}
+		mm->nr_ptes++;
 		inc_page_state(nr_page_table_pages);
 		pmd_populate(mm, pmd, new);
 	}
