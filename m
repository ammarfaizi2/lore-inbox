Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUFDJZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUFDJZc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbUFDJZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:25:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48307 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261939AbUFDJZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:25:19 -0400
Date: Fri, 4 Jun 2004 11:25:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andy Lutomirski <luto@myrealbox.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, arjanv@redhat.com,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
Message-ID: <20040604092552.GA11034@elte.hu>
References: <20040602205025.GA21555@elte.hu> <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org> <20040603072146.GA14441@elte.hu> <20040603124448.GA28775@elte.hu> <20040603175422.4378d901.ak@suse.de> <40BFADE5.9040506@myrealbox.com> <20040603230834.GF868@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603230834.GF868@wotan.suse.de>
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


* Andi Kleen <ak@suse.de> wrote:

> > The whole point of NX, though, is that it prevents certain classes of 
> > exploits.  If a setuid binary is vulnerable to one of these, then Ingo's 
> > patch "fixes" it.  Your approach breaks that.
> 
> Good point.
> 
> But that only applies to the NX personality bit. For the uname
> emulation it is not an issue.
> 
> So maybe the dropping on exec should only zero a few selected
> personality bits, but not all.

ok, how about the attached patch then? There's a PERS_DROP_ON_SUID mask
that we drop upon setuid - all the other personality bits get inherited.

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
@@ -37,6 +38,8 @@ enum {
 	ADDR_LIMIT_3GB = 	0x8000000,
 };
 
+#define PERS_DROP_ON_SUID (MMAP_PAGE_ZERO|ADDR_SPACE_EXECUTABLE)
+
 /*
  * Personality types.
  *
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
+			current->personality &= ~PERS_DROP_ON_SUID;
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
+			current->personality &= ~PERS_DROP_ON_SUID;
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
