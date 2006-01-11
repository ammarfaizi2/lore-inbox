Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWAKRxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWAKRxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWAKRxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:53:12 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:24383 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932398AbWAKRxL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:53:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Qh98s05Zt8LAyo1AH+qV4Z2q+97CpXPCReiwsKWiFji3COc8WQk1qqwcMI1Y5VOk2WcV8mrR/vxlVxcZi7IQffUZAWo8Of2QI/Q6Pwxba5n0yJaIx6DbCBQ1PFzeiFlD1UiDfrfyvb8Sm8lFGXyJ9vDk5fjQHDbVagnIyZTmas0=
Message-ID: <401b11ae0601110953h2389f118t3d4d11c33eece4f8@mail.gmail.com>
Date: Wed, 11 Jan 2006 17:53:10 +0000
From: erg0t <ergot86@gmail.com>
To: mingo@elte.hu
Subject: [PATCH] i386 - sys_clone from vsyscall
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a little problem when sys_clone is called from a
vsyscall and a new stack
for the child is specifed.
Some regs, and return address are pushed in the stack before sysenter,
so when the syscall returns, pop the regs and return, if we made a new
stack for the thread
we need to copy that to the new stack or the thread will segfault.
Sorry for use the 0xffffe410 constant I didn't find another way to reference it.
And sorry for my english :S
	Signed-off-by: Daniel F <ergot86@gmail.com>

--- /usr/src/linux-2.6.14/arch/i386/kernel/process.c.orig    
2005-12-13 17:06:46.000000000 +0000
+++ /usr/src/linux-2.6.14/arch/i386/kernel/process.c  2006-01-11
15:19:01.000000000 +0000
@@ -446,6 +446,7 @@ int copy_thread(int nr, unsigned long cl
 {
        struct pt_regs * childregs;
        struct task_struct *tsk;
+       unsigned long vsyscall_stack[4] ;
        int err;

        childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long)
p->thread_info)) - 1;
@@ -462,6 +463,17 @@ int copy_thread(int nr, unsigned long cl
        childregs = (struct pt_regs *) ((unsigned long) childregs - 8);
        *childregs = *regs;
        childregs->eax = 0;
+       /*
+        * When we were called from a vsyscall some thigs are pushed
on the stack,
+        * we need to copy the stuff to the new stack.
+        */
+       if ((regs->esp != esp) && (regs->eip == 0xffffe410)) {
+               if (copy_from_user(vsyscall_stack,(void
*)regs->esp,sizeof(vsyscall_stack)))
+                       return -EFAULT ;
+               if (copy_to_user((void
*)esp-sizeof(vsyscall_stack),vsyscall_stack,sizeof(vsyscall_stack)))
+                       return -EFAULT ;
+               esp -= sizeof(vsyscall_stack) ;
+       }
        childregs->esp = esp;

        p->thread.esp = (unsigned long) childregs;
