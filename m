Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWFSMZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWFSMZG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWFSMZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:25:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54717 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932393AbWFSMZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:25:04 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 05/15] frv: binfmt_elf_fdpic __user annotations
Date: Mon, 19 Jun 2006 13:24:55 +0100
To: torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060619122455.10060.96293.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
References: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Add __user annotations to binfmt_elf_fdpic.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/binfmt_elf_fdpic.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index a2e48c9..eba4e23 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -435,9 +435,10 @@ static int create_elf_fdpic_tables(struc
 				   struct elf_fdpic_params *interp_params)
 {
 	unsigned long sp, csp, nitems;
-	elf_caddr_t *argv, *envp;
+	elf_caddr_t __user *argv, *envp;
 	size_t platform_len = 0, len;
-	char *k_platform, *u_platform, *p;
+	char *k_platform;
+	char __user *u_platform, *p;
 	long hwcap;
 	int loop;
 
@@ -462,12 +463,11 @@ #endif
 	if (k_platform) {
 		platform_len = strlen(k_platform) + 1;
 		sp -= platform_len;
+		u_platform = (char __user *) sp;
 		if (__copy_to_user(u_platform, k_platform, platform_len) != 0)
 			return -EFAULT;
 	}
 
-	u_platform = (char *) sp;
-
 #if defined(__i386__) && defined(CONFIG_SMP)
 	/* in some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
 	 * by the processes running on the same package. One thing we can do
@@ -490,7 +490,7 @@ #endif
 	sp = (sp - len) & ~7UL;
 	exec_params->map_addr = sp;
 
-	if (copy_to_user((void *) sp, exec_params->loadmap, len) != 0)
+	if (copy_to_user((void __user *) sp, exec_params->loadmap, len) != 0)
 		return -EFAULT;
 
 	current->mm->context.exec_fdpic_loadmap = (unsigned long) sp;
@@ -501,7 +501,7 @@ #endif
 		sp = (sp - len) & ~7UL;
 		interp_params->map_addr = sp;
 
-		if (copy_to_user((void *) sp, interp_params->loadmap, len) != 0)
+		if (copy_to_user((void __user *) sp, interp_params->loadmap, len) != 0)
 			return -EFAULT;
 
 		current->mm->context.interp_fdpic_loadmap = (unsigned long) sp;
@@ -527,7 +527,7 @@ #endif
 	/* put the ELF interpreter info on the stack */
 #define NEW_AUX_ENT(nr, id, val)						\
 	do {									\
-		struct { unsigned long _id, _val; } *ent = (void *) csp;	\
+		struct { unsigned long _id, _val; } __user *ent = (void __user *) csp;	\
 		__put_user((id), &ent[nr]._id);					\
 		__put_user((val), &ent[nr]._val);				\
 	} while (0)
@@ -564,13 +564,13 @@ #undef NEW_AUX_ENT
 
 	/* allocate room for argv[] and envv[] */
 	csp -= (bprm->envc + 1) * sizeof(elf_caddr_t);
-	envp = (elf_caddr_t *) csp;
+	envp = (elf_caddr_t __user *) csp;
 	csp -= (bprm->argc + 1) * sizeof(elf_caddr_t);
-	argv = (elf_caddr_t *) csp;
+	argv = (elf_caddr_t __user *) csp;
 
 	/* stack argc */
 	csp -= sizeof(unsigned long);
-	__put_user(bprm->argc, (unsigned long *) csp);
+	__put_user(bprm->argc, (unsigned long __user *) csp);
 
 	BUG_ON(csp != sp);
 
@@ -581,7 +581,7 @@ #else
 	current->mm->arg_start = current->mm->start_stack - (MAX_ARG_PAGES * PAGE_SIZE - bprm->p);
 #endif
 
-	p = (char *) current->mm->arg_start;
+	p = (char __user *) current->mm->arg_start;
 	for (loop = bprm->argc; loop > 0; loop--) {
 		__put_user((elf_caddr_t) p, argv++);
 		len = strnlen_user(p, PAGE_SIZE * MAX_ARG_PAGES);
@@ -1025,7 +1025,7 @@ static int elf_fdpic_map_file_by_direct_
 		/* clear the bit between beginning of mapping and beginning of PT_LOAD */
 		if (prot & PROT_WRITE && disp > 0) {
 			kdebug("clear[%d] ad=%lx sz=%lx", loop, maddr, disp);
-			clear_user((void *) maddr, disp);
+			clear_user((void __user *) maddr, disp);
 			maddr += disp;
 		}
 
@@ -1059,7 +1059,7 @@ #ifdef CONFIG_MMU
 		if (prot & PROT_WRITE && excess1 > 0) {
 			kdebug("clear[%d] ad=%lx sz=%lx",
 			       loop, maddr + phdr->p_filesz, excess1);
-			clear_user((void *) maddr + phdr->p_filesz, excess1);
+			clear_user((void __user *) maddr + phdr->p_filesz, excess1);
 		}
 
 #else

