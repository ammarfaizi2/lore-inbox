Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWAZDri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWAZDri (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWAZDri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:47:38 -0500
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:22750 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932189AbWAZDri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:47:38 -0500
Date: Wed, 25 Jan 2006 22:43:49 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] i386 - sys_clone from vsyscall
To: erg0t <ergot86@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Message-ID: <200601252247_MC3-1-B6BF-F209@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <401b11ae0601110953h2389f118t3d4d11c33eece4f8@mail.gmail.com>

On Wed, 11 Jan 2006 at 17:53:10 +0000, erg0t wrote:

> This patch fixes a little problem when sys_clone is called from
> a vsyscall and a new stack for the child is specifed.
> Some regs, and return address are pushed in the stack before sysenter,
> so when the syscall returns, pop the regs and return, if we made
> a new stack for the thread we need to copy that to the new stack
> or the thread will segfault.

glibc works around this bug by hardcoding "int 0x80" at
glibc-2.3.5/sysdeps/unix/sysv/linux/i386/clone.S line 99.

> Sorry for use the 0xffffe410 constant I didn't find another way
> to reference it.

It's SYSENTER_RETURN.

> Signed-off-by: Daniel F <ergot86@gmail.com>

Your patch almost works but it copies the stack into the parent's address space.
Using access_process_vm() fixes it.  However, that still leaves unfixed the case
where vsyscall-int80 is used.


[patch] i386: fix sys_clone when using vsyscall-sysenter

Fix a problem when sys_clone is called from sysenter vsyscall and a new stack
for the child is specified.  Some data needs to be copied from the parent
to the child stack or the child will segfault.

Bug report and initial patch from Daniel F <ergot86@gmail.com>

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.15a.orig/arch/i386/kernel/process.c
+++ 2.6.15a/arch/i386/kernel/process.c
@@ -429,12 +429,15 @@ void prepare_to_copy(struct task_struct 
 	unlazy_fpu(tsk);
 }
 
+void SYSENTER_RETURN(void);
+
 int copy_thread(int nr, unsigned long clone_flags, unsigned long esp,
 	unsigned long unused,
 	struct task_struct * p, struct pt_regs * regs)
 {
 	struct pt_regs * childregs;
 	struct task_struct *tsk;
+	unsigned long vsyscall_stack[4];
 	int err;
 
 	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
@@ -451,6 +454,19 @@ int copy_thread(int nr, unsigned long cl
 	childregs = (struct pt_regs *) ((unsigned long) childregs - 8);
 	*childregs = *regs;
 	childregs->eax = 0;
+	/*
+	 * When we were called from a vsyscall some things are pushed on the stack;
+	 * we need to copy the stuff to the new stack.
+	 */
+	if (regs->esp != esp && (void *)regs->eip == SYSENTER_RETURN) {
+		int size = sizeof(vsyscall_stack);
+
+		if (copy_from_user(vsyscall_stack, (void *)regs->esp, size))
+			return -EFAULT;
+		if (access_process_vm(p, esp - size, vsyscall_stack, size, 1) != size)
+			return -EFAULT;
+		esp -= size;
+	}
 	childregs->esp = esp;
 
 	p->thread.esp = (unsigned long) childregs;
-- 
Chuck
