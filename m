Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVIYQGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVIYQGe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 12:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVIYQGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 12:06:34 -0400
Received: from silver.veritas.com ([143.127.12.111]:9143 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932240AbVIYQGe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 12:06:34 -0400
Date: Sun, 25 Sep 2005 17:06:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: "David S. Miller" <davem@davemloft.net>,
       Ralf Baechle <ralf@linux-mips.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 15/21] mm: mm_init set_mm_counters
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251704040.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 16:06:33.0712 (UTC) FILETIME=[195FEF00:01C5C1EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How is anon_rss initialized?  In dup_mmap, and by mm_alloc's memset; but
that's not so good if an mm_counter_t is a special type.  And how is rss
initialized?  By set_mm_counter, all over the place.  Come on, we just
need to initialize them both at once by set_mm_counter in mm_init (which
follows the memcpy when forking).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/mips/kernel/irixelf.c          |    1 -
 arch/sparc64/kernel/binfmt_aout32.c |    1 -
 arch/x86_64/ia32/ia32_aout.c        |    1 -
 fs/binfmt_aout.c                    |    1 -
 fs/binfmt_elf.c                     |    1 -
 fs/binfmt_elf_fdpic.c               |    7 -------
 fs/binfmt_flat.c                    |    1 -
 fs/binfmt_som.c                     |    1 -
 kernel/fork.c                       |    4 ++--
 9 files changed, 2 insertions(+), 16 deletions(-)

--- mm14/arch/mips/kernel/irixelf.c	2005-06-17 20:48:29.000000000 +0100
+++ mm15/arch/mips/kernel/irixelf.c	2005-09-24 19:29:40.000000000 +0100
@@ -692,7 +692,6 @@ static int load_irix_binary(struct linux
 	/* Do this so that we can load the interpreter, if need be.  We will
 	 * change some of these later.
 	 */
-	set_mm_counter(current->mm, rss, 0);
 	setup_arg_pages(bprm, STACK_TOP, EXSTACK_DEFAULT);
 	current->mm->start_stack = bprm->p;
 
--- mm14/arch/sparc64/kernel/binfmt_aout32.c	2005-06-17 20:48:29.000000000 +0100
+++ mm15/arch/sparc64/kernel/binfmt_aout32.c	2005-09-24 19:29:40.000000000 +0100
@@ -241,7 +241,6 @@ static int load_aout32_binary(struct lin
 	current->mm->brk = ex.a_bss +
 		(current->mm->start_brk = N_BSSADDR(ex));
 
-	set_mm_counter(current->mm, rss, 0);
 	current->mm->mmap = NULL;
 	compute_creds(bprm);
  	current->flags &= ~PF_FORKNOEXEC;
--- mm14/arch/x86_64/ia32/ia32_aout.c	2005-08-29 00:41:01.000000000 +0100
+++ mm15/arch/x86_64/ia32/ia32_aout.c	2005-09-24 19:29:40.000000000 +0100
@@ -314,7 +314,6 @@ static int load_aout_binary(struct linux
 	current->mm->free_area_cache = TASK_UNMAPPED_BASE;
 	current->mm->cached_hole_size = 0;
 
-	set_mm_counter(current->mm, rss, 0);
 	current->mm->mmap = NULL;
 	compute_creds(bprm);
  	current->flags &= ~PF_FORKNOEXEC;
--- mm14/fs/binfmt_aout.c	2005-08-29 00:41:01.000000000 +0100
+++ mm15/fs/binfmt_aout.c	2005-09-24 19:29:40.000000000 +0100
@@ -318,7 +318,6 @@ static int load_aout_binary(struct linux
 	current->mm->free_area_cache = current->mm->mmap_base;
 	current->mm->cached_hole_size = 0;
 
-	set_mm_counter(current->mm, rss, 0);
 	current->mm->mmap = NULL;
 	compute_creds(bprm);
  	current->flags &= ~PF_FORKNOEXEC;
--- mm14/fs/binfmt_elf.c	2005-09-22 12:31:59.000000000 +0100
+++ mm15/fs/binfmt_elf.c	2005-09-24 19:29:40.000000000 +0100
@@ -773,7 +773,6 @@ static int load_elf_binary(struct linux_
 
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
-	set_mm_counter(current->mm, rss, 0);
 	current->mm->free_area_cache = current->mm->mmap_base;
 	current->mm->cached_hole_size = 0;
 	retval = setup_arg_pages(bprm, randomize_stack_top(STACK_TOP),
--- mm14/fs/binfmt_elf_fdpic.c	2005-06-17 20:48:29.000000000 +0100
+++ mm15/fs/binfmt_elf_fdpic.c	2005-09-24 19:29:40.000000000 +0100
@@ -294,14 +294,7 @@ static int load_elf_fdpic_binary(struct 
 				  &interp_params,
 				  &current->mm->start_stack,
 				  &current->mm->start_brk);
-#endif
-
-	/* do this so that we can load the interpreter, if need be
-	 * - we will change some of these later
-	 */
-	set_mm_counter(current->mm, rss, 0);
 
-#ifdef CONFIG_MMU
 	retval = setup_arg_pages(bprm, current->mm->start_stack, executable_stack);
 	if (retval < 0) {
 		send_sig(SIGKILL, current, 0);
--- mm14/fs/binfmt_flat.c	2005-09-21 12:16:40.000000000 +0100
+++ mm15/fs/binfmt_flat.c	2005-09-24 19:29:40.000000000 +0100
@@ -650,7 +650,6 @@ static int load_flat_file(struct linux_b
 		current->mm->start_brk = datapos + data_len + bss_len;
 		current->mm->brk = (current->mm->start_brk + 3) & ~3;
 		current->mm->context.end_brk = memp + ksize((void *) memp) - stack_len;
-		set_mm_counter(current->mm, rss, 0);
 	}
 
 	if (flags & FLAT_FLAG_KTRACE)
--- mm14/fs/binfmt_som.c	2005-06-17 20:48:29.000000000 +0100
+++ mm15/fs/binfmt_som.c	2005-09-24 19:29:40.000000000 +0100
@@ -259,7 +259,6 @@ load_som_binary(struct linux_binprm * bp
 	create_som_tables(bprm);
 
 	current->mm->start_stack = bprm->p;
-	set_mm_counter(current->mm, rss, 0);
 
 #if 0
 	printk("(start_brk) %08lx\n" , (unsigned long) current->mm->start_brk);
--- mm14/kernel/fork.c	2005-09-24 19:27:33.000000000 +0100
+++ mm15/kernel/fork.c	2005-09-24 19:29:40.000000000 +0100
@@ -198,8 +198,6 @@ static inline int dup_mmap(struct mm_str
 	mm->free_area_cache = oldmm->mmap_base;
 	mm->cached_hole_size = ~0UL;
 	mm->map_count = 0;
-	set_mm_counter(mm, rss, 0);
-	set_mm_counter(mm, anon_rss, 0);
 	cpus_clear(mm->cpu_vm_mask);
 	mm->mm_rb = RB_ROOT;
 	rb_link = &mm->mm_rb.rb_node;
@@ -323,6 +321,8 @@ static struct mm_struct * mm_init(struct
 	INIT_LIST_HEAD(&mm->mmlist);
 	mm->core_waiters = 0;
 	mm->nr_ptes = 0;
+	set_mm_counter(mm, rss, 0);
+	set_mm_counter(mm, anon_rss, 0);
 	spin_lock_init(&mm->page_table_lock);
 	rwlock_init(&mm->ioctx_list_lock);
 	mm->ioctx_list = NULL;
