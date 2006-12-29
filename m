Return-Path: <linux-kernel-owner+w=401wt.eu-S965133AbWL2UHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbWL2UHY (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 15:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbWL2UHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 15:07:24 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:49854 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965133AbWL2UHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 15:07:21 -0500
Date: Fri, 29 Dec 2006 21:03:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Ollie Wild <aaw@google.com>
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [patch] remove MAX_ARG_PAGES
Message-ID: <20061229200357.GA5940@elte.hu>
References: <65dd6fd50610101705t3db93a72sc0847cd120aa05d3@mail.gmail.com> <1160572460.2006.79.camel@taijtu> <65dd6fd50610111448q7ff210e1nb5f14917c311c8d4@mail.gmail.com> <65dd6fd50610241048h24af39d9ob49c3816dfe1ca64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65dd6fd50610241048h24af39d9ob49c3816dfe1ca64@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI, i have forward ported your MAX_ARG_PAGES limit removal patch to 
2.6.20-rc2 and have included it in the -rt kernel. It's working great - 
i can now finally do a "ls -t patches/*.patch" in my patch repository - 
something i havent been able to do for years ;-)

what is keeping this fix from going upstream?

	Ingo

-------------->
Subject: [patch] remove MAX_ARG_PAGES
From: Ollie Wild <aaw@google.com>

this patch removes the MAX_ARG_PAGES limit by copying between VMs. This 
makes process argv/env limited by the stack limit (and it's thus 
arbitrarily sizable). No more:

  -bash: /bin/ls: Argument list too long

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86_64/ia32/ia32_binfmt.c |   55 -----
 fs/binfmt_elf.c                |   12 -
 fs/binfmt_misc.c               |    4 
 fs/binfmt_script.c             |    4 
 fs/compat.c                    |  118 ++++--------
 fs/exec.c                      |  382 +++++++++++++++++++----------------------
 include/linux/binfmts.h        |   14 -
 include/linux/mm.h             |    7 
 kernel/auditsc.c               |    5 
 mm/mprotect.c                  |    2 
 mm/mremap.c                    |    2 
 11 files changed, 250 insertions(+), 355 deletions(-)

Index: linux/arch/x86_64/ia32/ia32_binfmt.c
===================================================================
--- linux.orig/arch/x86_64/ia32/ia32_binfmt.c
+++ linux/arch/x86_64/ia32/ia32_binfmt.c
@@ -279,9 +279,6 @@ do {							\
 #define load_elf_binary load_elf32_binary
 
 #define ELF_PLAT_INIT(r, load_addr)	elf32_init(r)
-#define setup_arg_pages(bprm, stack_top, exec_stack) \
-	ia32_setup_arg_pages(bprm, stack_top, exec_stack)
-int ia32_setup_arg_pages(struct linux_binprm *bprm, unsigned long stack_top, int executable_stack);
 
 #undef start_thread
 #define start_thread(regs,new_rip,new_rsp) do { \
@@ -336,57 +333,7 @@ static void elf32_init(struct pt_regs *r
 int ia32_setup_arg_pages(struct linux_binprm *bprm, unsigned long stack_top,
 			 int executable_stack)
 {
-	unsigned long stack_base;
-	struct vm_area_struct *mpnt;
-	struct mm_struct *mm = current->mm;
-	int i, ret;
-
-	stack_base = stack_top - MAX_ARG_PAGES * PAGE_SIZE;
-	mm->arg_start = bprm->p + stack_base;
-
-	bprm->p += stack_base;
-	if (bprm->loader)
-		bprm->loader += stack_base;
-	bprm->exec += stack_base;
-
-	mpnt = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
-	if (!mpnt) 
-		return -ENOMEM; 
-
-	memset(mpnt, 0, sizeof(*mpnt));
-
-	down_write(&mm->mmap_sem);
-	{
-		mpnt->vm_mm = mm;
-		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
-		mpnt->vm_end = stack_top;
-		if (executable_stack == EXSTACK_ENABLE_X)
-			mpnt->vm_flags = VM_STACK_FLAGS |  VM_EXEC;
-		else if (executable_stack == EXSTACK_DISABLE_X)
-			mpnt->vm_flags = VM_STACK_FLAGS & ~VM_EXEC;
-		else
-			mpnt->vm_flags = VM_STACK_FLAGS;
- 		mpnt->vm_page_prot = (mpnt->vm_flags & VM_EXEC) ? 
- 			PAGE_COPY_EXEC : PAGE_COPY;
-		if ((ret = insert_vm_struct(mm, mpnt))) {
-			up_write(&mm->mmap_sem);
-			kmem_cache_free(vm_area_cachep, mpnt);
-			return ret;
-		}
-		mm->stack_vm = mm->total_vm = vma_pages(mpnt);
-	} 
-
-	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
-		struct page *page = bprm->page[i];
-		if (page) {
-			bprm->page[i] = NULL;
-			install_arg_page(mpnt, page, stack_base);
-		}
-		stack_base += PAGE_SIZE;
-	}
-	up_write(&mm->mmap_sem);
-	
-	return 0;
+	return setup_arg_pages(bprm, stack_top, executable_stack);
 }
 EXPORT_SYMBOL(ia32_setup_arg_pages);
 
Index: linux/fs/binfmt_elf.c
===================================================================
--- linux.orig/fs/binfmt_elf.c
+++ linux/fs/binfmt_elf.c
@@ -253,8 +253,8 @@ create_elf_tables(struct linux_binprm *b
 		size_t len;
 		if (__put_user((elf_addr_t)p, argv++))
 			return -EFAULT;
-		len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
-		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
+		len = strnlen_user((void __user *)p, MAX_ARG_STRLEN);
+		if (!len || len > MAX_ARG_STRLEN)
 			return 0;
 		p += len;
 	}
@@ -265,8 +265,8 @@ create_elf_tables(struct linux_binprm *b
 		size_t len;
 		if (__put_user((elf_addr_t)p, envp++))
 			return -EFAULT;
-		len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
-		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
+		len = strnlen_user((void __user *)p, MAX_ARG_STRLEN);
+		if (!len || len > MAX_ARG_STRLEN)
 			return 0;
 		p += len;
 	}
@@ -767,10 +767,6 @@ static int load_elf_binary(struct linux_
 	}
 
 	/* OK, This is the point of no return */
-	current->mm->start_data = 0;
-	current->mm->end_data = 0;
-	current->mm->end_code = 0;
-	current->mm->mmap = NULL;
 	current->flags &= ~PF_FORKNOEXEC;
 	current->mm->def_flags = def_flags;
 
Index: linux/fs/binfmt_misc.c
===================================================================
--- linux.orig/fs/binfmt_misc.c
+++ linux/fs/binfmt_misc.c
@@ -126,7 +126,9 @@ static int load_misc_binary(struct linux
 		goto _ret;
 
 	if (!(fmt->flags & MISC_FMT_PRESERVE_ARGV0)) {
-		remove_arg_zero(bprm);
+		retval = remove_arg_zero(bprm);
+		if (retval)
+			goto _ret;
 	}
 
 	if (fmt->flags & MISC_FMT_OPEN_BINARY) {
Index: linux/fs/binfmt_script.c
===================================================================
--- linux.orig/fs/binfmt_script.c
+++ linux/fs/binfmt_script.c
@@ -68,7 +68,9 @@ static int load_script(struct linux_binp
 	 * This is done in reverse order, because of how the
 	 * user environment and arguments are stored.
 	 */
-	remove_arg_zero(bprm);
+	retval = remove_arg_zero(bprm);
+	if (retval)
+		return retval;
 	retval = copy_strings_kernel(1, &bprm->interp, bprm);
 	if (retval < 0) return retval; 
 	bprm->argc++;
Index: linux/fs/compat.c
===================================================================
--- linux.orig/fs/compat.c
+++ linux/fs/compat.c
@@ -1389,6 +1389,7 @@ static int compat_copy_strings(int argc,
 {
 	struct page *kmapped_page = NULL;
 	char *kaddr = NULL;
+	unsigned long kpos = 0;
 	int ret;
 
 	while (argc-- > 0) {
@@ -1397,92 +1398,72 @@ static int compat_copy_strings(int argc,
 		unsigned long pos;
 
 		if (get_user(str, argv+argc) ||
-			!(len = strnlen_user(compat_ptr(str), bprm->p))) {
+		    !(len = strnlen_user(compat_ptr(str), MAX_ARG_STRLEN))) {
 			ret = -EFAULT;
 			goto out;
 		}
 
-		if (bprm->p < len)  {
+		if (MAX_ARG_STRLEN < len) {
 			ret = -E2BIG;
 			goto out;
 		}
 
-		bprm->p -= len;
-		/* XXX: add architecture specific overflow check here. */
+		/* We're going to work our way backwords. */
 		pos = bprm->p;
+		str += len;
+		bprm->p -= len;
 
 		while (len > 0) {
-			int i, new, err;
 			int offset, bytes_to_copy;
-			struct page *page;
 
 			offset = pos % PAGE_SIZE;
-			i = pos/PAGE_SIZE;
-			page = bprm->page[i];
-			new = 0;
-			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
-				bprm->page[i] = page;
-				if (!page) {
-					ret = -ENOMEM;
+			if (offset == 0)
+				offset = PAGE_SIZE;
+
+			bytes_to_copy = offset;
+			if (bytes_to_copy > len)
+				bytes_to_copy = len;
+
+			offset -= bytes_to_copy;
+			pos -= bytes_to_copy;
+			str -= bytes_to_copy;
+			len -= bytes_to_copy;
+
+			if (!kmapped_page || kpos != (pos & PAGE_MASK)) {
+				struct page *page;
+
+				ret = get_user_pages(current, bprm->mm, pos,
+						     1, 1, 1, &page, NULL);
+				if (ret <= 0) {
+					/* We've exceed the stack rlimit. */
+					ret = -E2BIG;
 					goto out;
 				}
-				new = 1;
-			}
 
-			if (page != kmapped_page) {
-				if (kmapped_page)
+				if (kmapped_page) {
 					kunmap(kmapped_page);
+					put_page(kmapped_page);
+				}
 				kmapped_page = page;
 				kaddr = kmap(kmapped_page);
+				kpos = pos & PAGE_MASK;
 			}
-			if (new && offset)
-				memset(kaddr, 0, offset);
-			bytes_to_copy = PAGE_SIZE - offset;
-			if (bytes_to_copy > len) {
-				bytes_to_copy = len;
-				if (new)
-					memset(kaddr+offset+len, 0,
-						PAGE_SIZE-offset-len);
-			}
-			err = copy_from_user(kaddr+offset, compat_ptr(str),
-						bytes_to_copy);
-			if (err) {
+			if (copy_from_user(kaddr+offset, compat_ptr(str),
+						bytes_to_copy)) {
 				ret = -EFAULT;
 				goto out;
 			}
-
-			pos += bytes_to_copy;
-			str += bytes_to_copy;
-			len -= bytes_to_copy;
 		}
 	}
 	ret = 0;
 out:
-	if (kmapped_page)
+	if (kmapped_page) {
 		kunmap(kmapped_page);
-	return ret;
-}
-
-#ifdef CONFIG_MMU
-
-#define free_arg_pages(bprm) do { } while (0)
-
-#else
-
-static inline void free_arg_pages(struct linux_binprm *bprm)
-{
-	int i;
-
-	for (i = 0; i < MAX_ARG_PAGES; i++) {
-		if (bprm->page[i])
-			__free_page(bprm->page[i]);
-		bprm->page[i] = NULL;
+		put_page(kmapped_page);
 	}
+	return ret;
 }
 
-#endif /* CONFIG_MMU */
-
 /*
  * compat_do_execve() is mostly a copy of do_execve(), with the exception
  * that it processes 32 bit argv and envp pointers.
@@ -1495,7 +1476,6 @@ int compat_do_execve(char * filename,
 	struct linux_binprm *bprm;
 	struct file *file;
 	int retval;
-	int i;
 
 	retval = -ENOMEM;
 	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
@@ -1509,24 +1489,19 @@ int compat_do_execve(char * filename,
 
 	sched_exec();
 
-	bprm->p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
 	bprm->file = file;
 	bprm->filename = filename;
 	bprm->interp = filename;
-	bprm->mm = mm_alloc();
-	retval = -ENOMEM;
-	if (!bprm->mm)
-		goto out_file;
 
-	retval = init_new_context(current, bprm->mm);
-	if (retval < 0)
-		goto out_mm;
+	retval = bprm_mm_init(bprm);
+	if (retval)
+		goto out_file;
 
-	bprm->argc = compat_count(argv, bprm->p / sizeof(compat_uptr_t));
+	bprm->argc = compat_count(argv, MAX_ARG_STRINGS);
 	if ((retval = bprm->argc) < 0)
 		goto out_mm;
 
-	bprm->envc = compat_count(envp, bprm->p / sizeof(compat_uptr_t));
+	bprm->envc = compat_count(envp, MAX_ARG_STRINGS);
 	if ((retval = bprm->envc) < 0)
 		goto out_mm;
 
@@ -1551,10 +1526,8 @@ int compat_do_execve(char * filename,
 	if (retval < 0)
 		goto out;
 
-	retval = search_binary_handler(bprm, regs);
+	retval = search_binary_handler(bprm,regs);
 	if (retval >= 0) {
-		free_arg_pages(bprm);
-
 		/* execve success */
 		security_bprm_free(bprm);
 		acct_update_integrals(current);
@@ -1563,19 +1536,12 @@ int compat_do_execve(char * filename,
 	}
 
 out:
-	/* Something went wrong, return the inode and free the argument pages*/
-	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
-		struct page * page = bprm->page[i];
-		if (page)
-			__free_page(page);
-	}
-
 	if (bprm->security)
 		security_bprm_free(bprm);
 
 out_mm:
 	if (bprm->mm)
-		mmdrop(bprm->mm);
+		mmput (bprm->mm);
 
 out_file:
 	if (bprm->file) {
Index: linux/fs/exec.c
===================================================================
--- linux.orig/fs/exec.c
+++ linux/fs/exec.c
@@ -174,6 +174,79 @@ exit:
 	goto out;
 }
 
+#ifdef CONFIG_STACK_GROWSUP
+#error	I broke your build because I rearchitected the stack code, and I \
+	don't have access to an architecture where CONFIG_STACK_GROWSUP is \
+	set.  Please fixe this or send me a machine which I can test this on. \
+	\
+	-- Ollie Wild <aaw@google.com>
+#endif
+
+/* Create a new mm_struct and populate it with a temporary stack
+ * vm_area_struct.  We don't have enough context at this point to set the
+ * stack flags, permissions, and offset, so we use temporary values.  We'll
+ * update them later in setup_arg_pages(). */
+int bprm_mm_init(struct linux_binprm *bprm)
+{
+	int err;
+	struct mm_struct *mm = NULL;
+	struct vm_area_struct *vma = NULL;
+
+	bprm->mm = mm = mm_alloc();
+	err = -ENOMEM;
+	if (!mm)
+		goto err;
+
+	if ((err = init_new_context(current, mm)))
+		goto err;
+
+	bprm->vma = vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
+	err = -ENOMEM;
+	if (!vma)
+		goto err;
+
+	down_write(&mm->mmap_sem);
+	{
+		vma->vm_mm = mm;
+
+		/* Place the stack at the top of user memory.  Later, we'll
+		 * move this to an appropriate place.  We don't use STACK_TOP
+		 * because that can depend on attributes which aren't
+		 * configured yet. */
+		vma->vm_end = TASK_SIZE;
+		vma->vm_start = vma->vm_end - PAGE_SIZE;
+
+		vma->vm_flags = VM_STACK_FLAGS;
+		vma->vm_page_prot = protection_map[vma->vm_flags & 0x7];
+		if ((err = insert_vm_struct(mm, vma))) {
+			up_write(&mm->mmap_sem);
+			goto err;
+		}
+
+		mm->stack_vm = mm->total_vm = 1;
+	}
+	up_write(&mm->mmap_sem);
+
+	bprm->p = vma->vm_end - sizeof(void *);
+
+	return 0;
+
+err:
+	if (vma) {
+		bprm->vma = NULL;
+		kmem_cache_free(vm_area_cachep, vma);
+	}
+
+	if (mm) {
+		bprm->mm = NULL;
+		mmdrop(mm);
+	}
+
+	return err;
+}
+
+EXPORT_SYMBOL(bprm_mm_init);
+
 /*
  * count() counts the number of strings in array ARGV.
  */
@@ -199,15 +272,16 @@ static int count(char __user * __user * 
 }
 
 /*
- * 'copy_strings()' copies argument/environment strings from user
- * memory to free pages in kernel mem. These are in a format ready
- * to be put directly into the top of new user memory.
+ * 'copy_strings()' copies argument/environment strings from the old
+ * processes's memory to the new process's stack.  The call to get_user_pages()
+ * ensures the destination page is created and not swapped out.
  */
 static int copy_strings(int argc, char __user * __user * argv,
 			struct linux_binprm *bprm)
 {
 	struct page *kmapped_page = NULL;
 	char *kaddr = NULL;
+	unsigned long kpos = 0;
 	int ret;
 
 	while (argc-- > 0) {
@@ -216,69 +290,68 @@ static int copy_strings(int argc, char _
 		unsigned long pos;
 
 		if (get_user(str, argv+argc) ||
-				!(len = strnlen_user(str, bprm->p))) {
+				!(len = strnlen_user(str, MAX_ARG_STRLEN))) {
 			ret = -EFAULT;
 			goto out;
 		}
 
-		if (bprm->p < len)  {
+		if (MAX_ARG_STRLEN < len) {
 			ret = -E2BIG;
 			goto out;
 		}
 
-		bprm->p -= len;
-		/* XXX: add architecture specific overflow check here. */
+		/* We're going to work our way backwords. */
 		pos = bprm->p;
+		str += len;
+		bprm->p -= len;
 
 		while (len > 0) {
-			int i, new, err;
 			int offset, bytes_to_copy;
-			struct page *page;
 
 			offset = pos % PAGE_SIZE;
-			i = pos/PAGE_SIZE;
-			page = bprm->page[i];
-			new = 0;
-			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
-				bprm->page[i] = page;
-				if (!page) {
-					ret = -ENOMEM;
+			if (offset == 0)
+				offset = PAGE_SIZE;
+
+			bytes_to_copy = offset;
+			if (bytes_to_copy > len)
+				bytes_to_copy = len;
+
+			offset -= bytes_to_copy;
+			pos -= bytes_to_copy;
+			str -= bytes_to_copy;
+			len -= bytes_to_copy;
+
+			if (!kmapped_page || kpos != (pos & PAGE_MASK)) {
+				struct page *page;
+
+				ret = get_user_pages(current, bprm->mm, pos,
+						     1, 1, 1, &page, NULL);
+				if (ret <= 0) {
+					/* We've exceed the stack rlimit. */
+					ret = -E2BIG;
 					goto out;
 				}
-				new = 1;
-			}
 
-			if (page != kmapped_page) {
-				if (kmapped_page)
+				if (kmapped_page) {
 					kunmap(kmapped_page);
+					put_page(kmapped_page);
+				}
 				kmapped_page = page;
 				kaddr = kmap(kmapped_page);
+				kpos = pos & PAGE_MASK;
 			}
-			if (new && offset)
-				memset(kaddr, 0, offset);
-			bytes_to_copy = PAGE_SIZE - offset;
-			if (bytes_to_copy > len) {
-				bytes_to_copy = len;
-				if (new)
-					memset(kaddr+offset+len, 0,
-						PAGE_SIZE-offset-len);
-			}
-			err = copy_from_user(kaddr+offset, str, bytes_to_copy);
-			if (err) {
+			if (copy_from_user(kaddr+offset, str, bytes_to_copy)) {
 				ret = -EFAULT;
 				goto out;
 			}
-
-			pos += bytes_to_copy;
-			str += bytes_to_copy;
-			len -= bytes_to_copy;
 		}
 	}
 	ret = 0;
 out:
-	if (kmapped_page)
+	if (kmapped_page) {
 		kunmap(kmapped_page);
+		put_page(kmapped_page);
+	}
 	return ret;
 }
 
@@ -297,157 +370,79 @@ int copy_strings_kernel(int argc,char **
 
 EXPORT_SYMBOL(copy_strings_kernel);
 
-#ifdef CONFIG_MMU
-/*
- * This routine is used to map in a page into an address space: needed by
- * execve() for the initial stack and environment pages.
- *
- * vma->vm_mm->mmap_sem is held for writing.
- */
-void install_arg_page(struct vm_area_struct *vma,
-			struct page *page, unsigned long address)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	pte_t * pte;
-	spinlock_t *ptl;
-
-	if (unlikely(anon_vma_prepare(vma)))
-		goto out;
-
-	flush_dcache_page(page);
-	pte = get_locked_pte(mm, address, &ptl);
-	if (!pte)
-		goto out;
-	if (!pte_none(*pte)) {
-		pte_unmap_unlock(pte, ptl);
-		goto out;
-	}
-	inc_mm_counter(mm, anon_rss);
-	lru_cache_add_active(page);
-	set_pte_at(mm, address, pte, pte_mkdirty(pte_mkwrite(mk_pte(
-					page, vma->vm_page_prot))));
-	page_add_new_anon_rmap(page, vma, address);
-	pte_unmap_unlock(pte, ptl);
-
-	/* no need for flush_tlb */
-	return;
-out:
-	__free_page(page);
-	force_sig(SIGKILL, current);
-}
-
 #define EXTRA_STACK_VM_PAGES	20	/* random */
 
+/* Finalizes the stack vm_area_struct.  The flags and permissions are updated,
+ * the stack is optionally relocated, and some extra space is added.
+ */
 int setup_arg_pages(struct linux_binprm *bprm,
 		    unsigned long stack_top,
 		    int executable_stack)
 {
-	unsigned long stack_base;
-	struct vm_area_struct *mpnt;
+	unsigned long ret;
+	unsigned long stack_base, stack_shift;
 	struct mm_struct *mm = current->mm;
-	int i, ret;
-	long arg_size;
 
-#ifdef CONFIG_STACK_GROWSUP
-	/* Move the argument and environment strings to the bottom of the
-	 * stack space.
-	 */
-	int offset, j;
-	char *to, *from;
+	BUG_ON(stack_top > TASK_SIZE);
+	BUG_ON(stack_top & ~PAGE_MASK);
 
-	/* Start by shifting all the pages down */
-	i = 0;
-	for (j = 0; j < MAX_ARG_PAGES; j++) {
-		struct page *page = bprm->page[j];
-		if (!page)
-			continue;
-		bprm->page[i++] = page;
-	}
-
-	/* Now move them within their pages */
-	offset = bprm->p % PAGE_SIZE;
-	to = kmap(bprm->page[0]);
-	for (j = 1; j < i; j++) {
-		memmove(to, to + offset, PAGE_SIZE - offset);
-		from = kmap(bprm->page[j]);
-		memcpy(to + PAGE_SIZE - offset, from, offset);
-		kunmap(bprm->page[j - 1]);
-		to = from;
-	}
-	memmove(to, to + offset, PAGE_SIZE - offset);
-	kunmap(bprm->page[j - 1]);
-
-	/* Limit stack size to 1GB */
-	stack_base = current->signal->rlim[RLIMIT_STACK].rlim_max;
-	if (stack_base > (1 << 30))
-		stack_base = 1 << 30;
-	stack_base = PAGE_ALIGN(stack_top - stack_base);
-
-	/* Adjust bprm->p to point to the end of the strings. */
-	bprm->p = stack_base + PAGE_SIZE * i - offset;
-
-	mm->arg_start = stack_base;
-	arg_size = i << PAGE_SHIFT;
-
-	/* zero pages that were copied above */
-	while (i < MAX_ARG_PAGES)
-		bprm->page[i++] = NULL;
-#else
-	stack_base = arch_align_stack(stack_top - MAX_ARG_PAGES*PAGE_SIZE);
+	stack_base = arch_align_stack(stack_top - mm->stack_vm*PAGE_SIZE);
 	stack_base = PAGE_ALIGN(stack_base);
-	bprm->p += stack_base;
-	mm->arg_start = bprm->p;
-	arg_size = stack_top - (PAGE_MASK & (unsigned long) mm->arg_start);
-#endif
 
-	arg_size += EXTRA_STACK_VM_PAGES * PAGE_SIZE;
+	stack_shift = (bprm->p & PAGE_MASK) - stack_base;
+	BUG_ON(stack_shift < 0);
+	bprm->p -= stack_shift;
+	mm->arg_start = bprm->p;
 
 	if (bprm->loader)
-		bprm->loader += stack_base;
-	bprm->exec += stack_base;
-
-	mpnt = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
-	if (!mpnt)
-		return -ENOMEM;
-
-	memset(mpnt, 0, sizeof(*mpnt));
+		bprm->loader -= stack_shift;
+	bprm->exec -= stack_shift;
 
 	down_write(&mm->mmap_sem);
 	{
-		mpnt->vm_mm = mm;
-#ifdef CONFIG_STACK_GROWSUP
-		mpnt->vm_start = stack_base;
-		mpnt->vm_end = stack_base + arg_size;
-#else
-		mpnt->vm_end = stack_top;
-		mpnt->vm_start = mpnt->vm_end - arg_size;
-#endif
+		struct vm_area_struct *vma = bprm->vma;
+		struct vm_area_struct *prev = NULL;
+		unsigned long vm_flags = vma->vm_flags;
+
 		/* Adjust stack execute permissions; explicitly enable
 		 * for EXSTACK_ENABLE_X, disable for EXSTACK_DISABLE_X
 		 * and leave alone (arch default) otherwise. */
 		if (unlikely(executable_stack == EXSTACK_ENABLE_X))
-			mpnt->vm_flags = VM_STACK_FLAGS |  VM_EXEC;
+			vm_flags |= VM_EXEC;
 		else if (executable_stack == EXSTACK_DISABLE_X)
-			mpnt->vm_flags = VM_STACK_FLAGS & ~VM_EXEC;
-		else
-			mpnt->vm_flags = VM_STACK_FLAGS;
-		mpnt->vm_flags |= mm->def_flags;
-		mpnt->vm_page_prot = protection_map[mpnt->vm_flags & 0x7];
-		if ((ret = insert_vm_struct(mm, mpnt))) {
+			vm_flags &= ~VM_EXEC;
+		vm_flags |= mm->def_flags;
+
+		ret = mprotect_fixup(vma, &prev, vma->vm_start, vma->vm_end,
+				vm_flags);
+		if (ret) {
 			up_write(&mm->mmap_sem);
-			kmem_cache_free(vm_area_cachep, mpnt);
 			return ret;
 		}
-		mm->stack_vm = mm->total_vm = vma_pages(mpnt);
-	}
+		BUG_ON(prev != vma);
+
+		/* Move stack pages down in memory. */
+		if (stack_shift) {
+			/* This should be safe even with overlap because we
+			 * are shifting down. */
+			ret = move_vma(vma, vma->vm_start,
+					vma->vm_end - vma->vm_start,
+					vma->vm_end - vma->vm_start,
+					vma->vm_start - stack_shift);
+			if (ret & ~PAGE_MASK) {
+				up_write(&mm->mmap_sem);
+				return ret;
+			}
+		}
 
-	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
-		struct page *page = bprm->page[i];
-		if (page) {
-			bprm->page[i] = NULL;
-			install_arg_page(mpnt, page, stack_base);
+		// Expand the stack.
+		vma = find_vma(mm, bprm->p);
+		BUG_ON(!vma || bprm->p < vma->vm_start);
+		if (expand_stack(vma, stack_base -
+					EXTRA_STACK_VM_PAGES * PAGE_SIZE)) {
+			up_write(&mm->mmap_sem);
+			return -EFAULT;
 		}
-		stack_base += PAGE_SIZE;
 	}
 	up_write(&mm->mmap_sem);
 	
@@ -456,23 +451,6 @@ int setup_arg_pages(struct linux_binprm 
 
 EXPORT_SYMBOL(setup_arg_pages);
 
-#define free_arg_pages(bprm) do { } while (0)
-
-#else
-
-static inline void free_arg_pages(struct linux_binprm *bprm)
-{
-	int i;
-
-	for (i = 0; i < MAX_ARG_PAGES; i++) {
-		if (bprm->page[i])
-			__free_page(bprm->page[i]);
-		bprm->page[i] = NULL;
-	}
-}
-
-#endif /* CONFIG_MMU */
-
 struct file *open_exec(const char *name)
 {
 	struct nameidata nd;
@@ -993,8 +971,10 @@ void compute_creds(struct linux_binprm *
 
 EXPORT_SYMBOL(compute_creds);
 
-void remove_arg_zero(struct linux_binprm *bprm)
+int remove_arg_zero(struct linux_binprm *bprm)
 {
+	int ret = 0;
+
 	if (bprm->argc) {
 		unsigned long offset;
 		char * kaddr;
@@ -1008,13 +988,23 @@ void remove_arg_zero(struct linux_binprm
 				continue;
 			offset = 0;
 			kunmap_atomic(kaddr, KM_USER0);
+			put_page(page);
 inside:
-			page = bprm->page[bprm->p/PAGE_SIZE];
+			ret = get_user_pages(current, bprm->mm, bprm->p,
+					     1, 0, 1, &page, NULL);
+			if (ret <= 0) {
+				ret = -EFAULT;
+				goto out;
+			}
 			kaddr = kmap_atomic(page, KM_USER0);
 		}
 		kunmap_atomic(kaddr, KM_USER0);
 		bprm->argc--;
+		ret = 0;
 	}
+
+out:
+	return ret;
 }
 
 EXPORT_SYMBOL(remove_arg_zero);
@@ -1041,7 +1031,7 @@ int search_binary_handler(struct linux_b
 		fput(bprm->file);
 		bprm->file = NULL;
 
-	        loader = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
+	        loader = bprm->vma->vm_end - sizeof(void *);
 
 		file = open_exec("/sbin/loader");
 		retval = PTR_ERR(file);
@@ -1134,7 +1124,6 @@ int do_execve(char * filename,
 	struct linux_binprm *bprm;
 	struct file *file;
 	int retval;
-	int i;
 
 	retval = -ENOMEM;
 	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
@@ -1148,25 +1137,19 @@ int do_execve(char * filename,
 
 	sched_exec();
 
-	bprm->p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
-
 	bprm->file = file;
 	bprm->filename = filename;
 	bprm->interp = filename;
-	bprm->mm = mm_alloc();
-	retval = -ENOMEM;
-	if (!bprm->mm)
-		goto out_file;
 
-	retval = init_new_context(current, bprm->mm);
-	if (retval < 0)
-		goto out_mm;
+	retval = bprm_mm_init(bprm);
+	if (retval)
+		goto out_file;
 
-	bprm->argc = count(argv, bprm->p / sizeof(void *));
+	bprm->argc = count(argv, MAX_ARG_STRINGS);
 	if ((retval = bprm->argc) < 0)
 		goto out_mm;
 
-	bprm->envc = count(envp, bprm->p / sizeof(void *));
+	bprm->envc = count(envp, MAX_ARG_STRINGS);
 	if ((retval = bprm->envc) < 0)
 		goto out_mm;
 
@@ -1193,8 +1176,6 @@ int do_execve(char * filename,
 
 	retval = search_binary_handler(bprm,regs);
 	if (retval >= 0) {
-		free_arg_pages(bprm);
-
 		/* execve success */
 		security_bprm_free(bprm);
 		acct_update_integrals(current);
@@ -1203,19 +1184,12 @@ int do_execve(char * filename,
 	}
 
 out:
-	/* Something went wrong, return the inode and free the argument pages*/
-	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
-		struct page * page = bprm->page[i];
-		if (page)
-			__free_page(page);
-	}
-
 	if (bprm->security)
 		security_bprm_free(bprm);
 
 out_mm:
 	if (bprm->mm)
-		mmdrop(bprm->mm);
+		mmput (bprm->mm);
 
 out_file:
 	if (bprm->file) {
Index: linux/include/linux/binfmts.h
===================================================================
--- linux.orig/include/linux/binfmts.h
+++ linux/include/linux/binfmts.h
@@ -5,12 +5,9 @@
 
 struct pt_regs;
 
-/*
- * MAX_ARG_PAGES defines the number of pages allocated for arguments
- * and envelope for the new program. 32 should suffice, this gives
- * a maximum env+arg of 128kB w/4KB pages!
- */
-#define MAX_ARG_PAGES 32
+/* FIXME: Find real limits, or none. */
+#define MAX_ARG_STRLEN (PAGE_SIZE * 32)
+#define MAX_ARG_STRINGS 0x7FFFFFFF
 
 /* sizeof(linux_binprm->buf) */
 #define BINPRM_BUF_SIZE 128
@@ -22,7 +19,7 @@ struct pt_regs;
  */
 struct linux_binprm{
 	char buf[BINPRM_BUF_SIZE];
-	struct page *page[MAX_ARG_PAGES];
+	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	unsigned long p; /* current top of mem */
 	int sh_bang;
@@ -65,7 +62,7 @@ extern int register_binfmt(struct linux_
 extern int unregister_binfmt(struct linux_binfmt *);
 
 extern int prepare_binprm(struct linux_binprm *);
-extern void remove_arg_zero(struct linux_binprm *);
+extern int __must_check remove_arg_zero(struct linux_binprm *);
 extern int search_binary_handler(struct linux_binprm *,struct pt_regs *);
 extern int flush_old_exec(struct linux_binprm * bprm);
 
@@ -82,6 +79,7 @@ extern int suid_dumpable;
 extern int setup_arg_pages(struct linux_binprm * bprm,
 			   unsigned long stack_top,
 			   int executable_stack);
+extern int bprm_mm_init(struct linux_binprm *bprm);
 extern int copy_strings_kernel(int argc,char ** argv,struct linux_binprm *bprm);
 extern void compute_creds(struct linux_binprm *binprm);
 extern int do_coredump(long signr, int exit_code, struct pt_regs * regs);
Index: linux/include/linux/mm.h
===================================================================
--- linux.orig/include/linux/mm.h
+++ linux/include/linux/mm.h
@@ -775,7 +775,6 @@ static inline int handle_mm_fault(struct
 
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
-void install_arg_page(struct vm_area_struct *, struct page *, unsigned long);
 
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
@@ -791,9 +790,15 @@ int FASTCALL(set_page_dirty(struct page 
 int set_page_dirty_lock(struct page *page);
 int clear_page_dirty_for_io(struct page *page);
 
+extern unsigned long move_vma(struct vm_area_struct *vma,
+		unsigned long old_addr, unsigned long old_len,
+		unsigned long new_len, unsigned long new_addr);
 extern unsigned long do_mremap(unsigned long addr,
 			       unsigned long old_len, unsigned long new_len,
 			       unsigned long flags, unsigned long new_addr);
+extern int mprotect_fixup(struct vm_area_struct *vma,
+			  struct vm_area_struct **pprev, unsigned long start,
+			  unsigned long end, unsigned long newflags);
 
 /*
  * Prototype to add a shrinker callback for ageable caches.
Index: linux/kernel/auditsc.c
===================================================================
--- linux.orig/kernel/auditsc.c
+++ linux/kernel/auditsc.c
@@ -1755,6 +1755,10 @@ int __audit_ipc_set_perm(unsigned long q
 
 int audit_bprm(struct linux_binprm *bprm)
 {
+	/* FIXME: Don't do anything for now until I figure out how to handle
+	 * this.  With the latest changes, kmalloc could well fail under good
+	 * scenarios. */
+#if 0
 	struct audit_aux_data_execve *ax;
 	struct audit_context *context = current->audit_context;
 	unsigned long p, next;
@@ -1782,6 +1786,7 @@ int audit_bprm(struct linux_binprm *bprm
 	ax->d.type = AUDIT_EXECVE;
 	ax->d.next = context->aux;
 	context->aux = (void *)ax;
+#endif
 	return 0;
 }
 
Index: linux/mm/mprotect.c
===================================================================
--- linux.orig/mm/mprotect.c
+++ linux/mm/mprotect.c
@@ -128,7 +128,7 @@ static void change_protection(struct vm_
 	flush_tlb_range(vma, start, end);
 }
 
-static int
+int
 mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	unsigned long start, unsigned long end, unsigned long newflags)
 {
Index: linux/mm/mremap.c
===================================================================
--- linux.orig/mm/mremap.c
+++ linux/mm/mremap.c
@@ -155,7 +155,7 @@ static unsigned long move_page_tables(st
 	return len + old_addr - old_end;	/* how much done */
 }
 
-static unsigned long move_vma(struct vm_area_struct *vma,
+unsigned long move_vma(struct vm_area_struct *vma,
 		unsigned long old_addr, unsigned long old_len,
 		unsigned long new_len, unsigned long new_addr)
 {
