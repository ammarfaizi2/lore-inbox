Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVA0KQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVA0KQY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVA0KNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:13:41 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:41732 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262549AbVA0KM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:12:56 -0500
Date: Thu, 27 Jan 2005 10:12:54 +0000
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 3/6  per process flag
Message-ID: <20050127101254.GD9760@infradead.org>
References: <20050127101117.GA9760@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127101117.GA9760@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Even thoguh there is a global flag to disable randomisation, it's useful to
have a per process flag too; the patch below introduces this per process
flag and automatically sets it for "new" binaries.

Eventually we will want to tie this to the legacy-va-space personality

Signed-off-by: Arjan van de Ven <arjan@infradead.org>

diff -purN linux-step-4a/fs/binfmt_elf.c linux-step-5/fs/binfmt_elf.c
--- linux-step-3/fs/binfmt_elf.c	2005-01-26 21:18:49.000000000 +0100
+++ linux-step-2/fs/binfmt_elf.c	2005-01-27 09:08:41.000000000 +0100
@@ -757,6 +759,9 @@ static int load_elf_binary(struct linux_
 	if (elf_read_implies_exec(loc->elf_ex, have_pt_gnu_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
+	if (executable_stack == EXSTACK_DISABLE_X && randomize_va_space) {
+		current->flags |= PF_RANDOMIZE;
+	}
 	arch_pick_mmap_layout(current->mm);
 
 	/* Do this so that we can load the interpreter, if need be.  We will
diff -purN linux-step-3/fs/exec.c linux-step-2/fs/exec.c
--- linux-step-3/fs/exec.c	2005-01-26 18:24:38.762322000 +0100
+++ linux-step-2/fs/exec.c	2005-01-26 21:15:33.860310848 +0100
@@ -877,6 +877,7 @@ int flush_old_exec(struct linux_binprm *
 	tcomm[i] = '\0';
 	set_task_comm(current, tcomm);
 
+	current->flags &= ~PF_RANDOMIZE;
 	flush_thread();
 
 	if (bprm->e_uid != current->euid || bprm->e_gid != current->egid || 
diff -purN linux-step-3/include/linux/sched.h linux-step-2/include/linux/sched.h
--- linux-step-3/include/linux/sched.h	2005-01-26 18:24:39.606194000 +0100
+++ linux-step-2/include/linux/sched.h	2005-01-26 21:13:28.692339272 +0100
@@ -736,6 +736,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
+#define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
 
 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);
