Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263544AbUFCMnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUFCMnr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 08:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUFCMnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 08:43:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:45754 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263544AbUFCMnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 08:43:42 -0400
Date: Thu, 3 Jun 2004 14:44:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040603124448.GA28775@elte.hu>
References: <20040602205025.GA21555@elte.hu> <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org> <20040603072146.GA14441@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603072146.GA14441@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > And do we have some way of on a per-process basis say "avoid NX
> > because this old version of Oracle/flash/whatever-binary-thing doesn't
> > run with it"?

[...]
> 2) via a runtime method: via the i386 personality. So an application can
>    trigger the 'legacy' Linux VM layout by e.g doing 'i386 java
>    ./test.class'.
> 
> this is a hack in Fedora - we wanted to have a finegrained runtime
> mechanism just in case. But it would be nice to have this upstream too -
> e.g. via a PERSONALITY_3G?

i've attached a patch that provides a cleaner solution. It does 3
changes:

- it adds a ADDR_SPACE_EXECUTABLE bit to the personality 'bug bits'
section. This bit if set will make the stack executable. (if in the
future we decide to make the malloc() heap non-exec [which i definitely
think we should], that property will also listen to this bit.)

- in elf.h, it changes the x86 personality inheritance code to match
that of x86_64 - which is a much saner method. This means if a complex
app that does exec()s will all run with the personality of the
parent(s).

- in exec.c, since address-space executability is a security-relevant
item, we must clear the personality when we exec a setuid binary. I
believe this is also a (small) security robustness fix for current
64-bit architectures.

(the patch also adds a break to the elf_ex.e_phnum loop - there can only
be one STACK header in the binary and once we found it we should not
iterate through the remaining program headers (if any).)

we didnt want to add a non-standard personality flag to Fedora so we
abused PER_LINUX32 as the compatibility flag - but this only works on
x86. With the ADDR_SPACE_EXECUTABLE flag there would be a standard
method to fall back to 'legacy' executability assumptions Linux
applications might make.

hm?

	Ingo

--- linux/include/linux/personality.h.orig	
+++ linux/include/linux/personality.h	
@@ -30,6 +30,7 @@ extern int abi_fake_utsname;
  */
 enum {
 	MMAP_PAGE_ZERO =	0x0100000,
+	ADDR_SPACE_EXECUTABLE =	0x0200000,
 	ADDR_LIMIT_32BIT =	0x0800000,
 	SHORT_INODE =		0x1000000,
 	WHOLE_SECONDS =		0x2000000,
--- linux/include/asm-i386/elf.h.orig	
+++ linux/include/asm-i386/elf.h	
@@ -117,7 +117,8 @@ typedef struct user_fxsr_struct elf_fpxr
 #define AT_SYSINFO_EHDR		33
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+/* child inherits the personality of the parent */
+#define SET_PERSONALITY(ex, ibcs2) do { } while (0)
 
 extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
--- linux/fs/exec.c.orig	
+++ linux/fs/exec.c	
@@ -886,8 +886,11 @@ int prepare_binprm(struct linux_binprm *
 
 	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
 		/* Set-uid? */
-		if (mode & S_ISUID)
+		if (mode & S_ISUID) {
 			bprm->e_uid = inode->i_uid;
+			/* reset personality */
+			current->personality = PER_LINUX;
+		}
 
 		/* Set-gid? */
 		/*
@@ -895,8 +898,11 @@ int prepare_binprm(struct linux_binprm *
 		 * is a candidate for mandatory locking, not a setgid
 		 * executable.
 		 */
-		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP))
+		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 			bprm->e_gid = inode->i_gid;
+			/* reset personality */
+			current->personality = PER_LINUX;
+		}
 	}
 
 	/* fill in binprm security blob */
--- linux/fs/binfmt_elf.c.orig	
+++ linux/fs/binfmt_elf.c	
@@ -490,7 +490,7 @@ static int load_elf_binary(struct linux_
   	struct exec interp_ex;
 	char passed_fileno[6];
 	struct files_struct *files;
-	int executable_stack = EXSTACK_DEFAULT;
+	int executable_stack;
 	
 	/* Get the exec-header */
 	elf_ex = *((struct elfhdr *) bprm->buf);
@@ -616,13 +616,19 @@ static int load_elf_binary(struct linux_
 	}
 
 	elf_ppnt = elf_phdata;
-	for (i = 0; i < elf_ex.e_phnum; i++, elf_ppnt++)
-		if (elf_ppnt->p_type == PT_GNU_STACK) {
-			if (elf_ppnt->p_flags & PF_X)
-				executable_stack = EXSTACK_ENABLE_X;
-			else
-				executable_stack = EXSTACK_DISABLE_X;
-		}
+	if (current->personality & ADDR_SPACE_EXECUTABLE)
+		executable_stack = EXSTACK_ENABLE_X;
+	else {
+		executable_stack = EXSTACK_DEFAULT;
+		for (i = 0; i < elf_ex.e_phnum; i++, elf_ppnt++)
+			if (elf_ppnt->p_type == PT_GNU_STACK) {
+				if (elf_ppnt->p_flags & PF_X)
+					executable_stack = EXSTACK_ENABLE_X;
+				else
+					executable_stack = EXSTACK_DISABLE_X;
+				break;
+			}
+	}
 
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {
