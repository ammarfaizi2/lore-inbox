Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268094AbUJDMo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268094AbUJDMo0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 08:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268128AbUJDMo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 08:44:26 -0400
Received: from hera.cwi.nl ([192.16.191.8]:23024 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S268094AbUJDMoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 08:44:15 -0400
Date: Mon, 4 Oct 2004 14:44:08 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] restricted overcommit
Message-ID: <20041004124407.GA9146@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[The below is just for discussion, not to be applied]

Below a trimmed down version of a patch I made a few days ago.

The exec.c part can be viewed as cleanup, except that it adds
an EXTRA_STACK_VM_PAGES, following a suggestion by Alan,
giving a guaranteed lower bound on the amount of stack available.

(Without any reasoning or experimenting I wrote 20, and have
not seen a segfault since.)

The security/commoncap.c part makes sure that something is left
for root, even when some user takes all he can, and also, that
something is left for the user, even after one of his buggy programs
ran away and took everything. (Of course he should have used
RLIMIT_AS, but nobody does.)

Given these two patches, one can do #echo 2 > /proc/sys/vm/overcommit_memory
and work as usual and not see an OOM anymore, provided there is enough
swap.

(What I wrote a few days ago was the slightly larger patch where
upon swapon/swapoff the no overcommit mode was enabled/disabled
when the amount of swap was at least twice the amount of physical
memory. Again, this factor 2 is mostly unmotivated.)

So, this seems to work with a sample of size 1 from the set
of Linux users. Maybe others can try this, or comment.

Andries


diff -uprN -X /linux/dontdiff a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	2004-10-01 22:46:33.000000000 +0200
+++ b/fs/exec.c	2004-10-04 14:14:33.000000000 +0200
@@ -336,6 +336,8 @@ out_sig:
 	force_sig(SIGKILL, current);
 }
 
+#define EXTRA_STACK_VM_PAGES	20	/* random */
+
 int setup_arg_pages(struct linux_binprm *bprm, int executable_stack)
 {
 	unsigned long stack_base;
@@ -373,15 +375,15 @@ int setup_arg_pages(struct linux_binprm 
 	memmove(to, to + offset, PAGE_SIZE - offset);
 	kunmap(bprm->page[j - 1]);
 
-	/* Adjust bprm->p to point to the end of the strings. */
-	bprm->p = PAGE_SIZE * i - offset;
-
 	/* Limit stack size to 1GB */
 	stack_base = current->rlim[RLIMIT_STACK].rlim_max;
 	if (stack_base > (1 << 30))
 		stack_base = 1 << 30;
 	stack_base = PAGE_ALIGN(STACK_TOP - stack_base);
 
+	/* Adjust bprm->p to point to the end of the strings. */
+	bprm->p = stack_base + PAGE_SIZE * i - offset;
+
 	mm->arg_start = stack_base;
 	arg_size = i << PAGE_SHIFT;
 
@@ -390,11 +392,13 @@ int setup_arg_pages(struct linux_binprm 
 		bprm->page[i++] = NULL;
 #else
 	stack_base = STACK_TOP - MAX_ARG_PAGES * PAGE_SIZE;
-	mm->arg_start = bprm->p + stack_base;
+	bprm->p += stack_base;
+	mm->arg_start = bprm->p;
 	arg_size = STACK_TOP - (PAGE_MASK & (unsigned long) mm->arg_start);
 #endif
 
-	bprm->p += stack_base;
+	arg_size += EXTRA_STACK_VM_PAGES * PAGE_SIZE;
+
 	if (bprm->loader)
 		bprm->loader += stack_base;
 	bprm->exec += stack_base;
@@ -415,11 +419,10 @@ int setup_arg_pages(struct linux_binprm 
 		mpnt->vm_mm = mm;
 #ifdef CONFIG_STACK_GROWSUP
 		mpnt->vm_start = stack_base;
-		mpnt->vm_end = PAGE_MASK &
-			(PAGE_SIZE - 1 + (unsigned long) bprm->p);
+		mpnt->vm_end = stack_base + arg_size;
 #else
-		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end = STACK_TOP;
+		mpnt->vm_start = mpnt->vm_end - arg_size;
 #endif
 		/* Adjust stack execute permissions; explicitly enable
 		 * for EXSTACK_ENABLE_X, disable for EXSTACK_DISABLE_X
diff -uprN -X /linux/dontdiff a/security/commoncap.c b/security/commoncap.c
--- a/security/commoncap.c	2004-10-01 22:46:41.000000000 +0200
+++ b/security/commoncap.c	2004-10-04 14:14:33.000000000 +0200
@@ -364,6 +364,14 @@ int cap_vm_enough_memory(long pages)
 		allowed -= allowed / 32;
 	allowed += total_swap_pages;
 
+	/* Leave the last 3% for root */
+	if (current->euid)
+		allowed -= allowed / 32;
+
+	/* Don't let a single process grow too big:
+	   leave 3% of the size of this process for other processes */
+	allowed -= current->mm->total_vm / 32;
+
 	if (atomic_read(&vm_committed_space) < allowed)
 		return 0;
 
diff -uprN -X /linux/dontdiff a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	2004-10-01 22:46:41.000000000 +0200
+++ b/security/dummy.c	2004-10-04 14:16:06.000000000 +0200
@@ -153,6 +153,14 @@ static int dummy_vm_enough_memory(long p
 		* sysctl_overcommit_ratio / 100;
 	allowed += total_swap_pages;
 
+	/* Leave the last 3% for root */	
+	if (current->euid)
+		allowed -= allowed / 32;
+
+	/* Don't let a single process grow too big:
+	   leave 3% of the size of this process for other processes */
+	allowed -= current->mm->total_vm / 32;
+
 	if (atomic_read(&vm_committed_space) < allowed)
 		return 0;
 
