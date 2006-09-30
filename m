Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751988AbWI3VnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbWI3VnY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 17:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbWI3VnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 17:43:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:22363 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751988AbWI3VnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 17:43:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JxoSDmMmNLURshUwvkkmHYf9F2TFUIhbwpSFe3D28Miv6Ny6m1BsOlFSvRn1NdQ7I14MMvGPEyQisG2ESwB62zv6HqFUNtFMW8oL4XuPaFPi9GJ2YCWZpcJLkA/2cB+6vT6xKX0OH/2WSfTPM89Ul4RiPDXhCeoPXibuVPSLmNg=
Message-ID: <5f3c152b0609301443l5061af04w5740babdfa3dbd3b@mail.gmail.com>
Date: Sat, 30 Sep 2006 23:43:21 +0200
From: "Eric Rannaud" <eric.rannaud@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Ingo Molnar" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>,
       nagar@watson.ibm.com, "Chandra Seetharaman" <sekharan@us.ibm.com>,
       "Jan Beulich" <jbeulich@novell.com>
In-Reply-To: <200609302230.24070.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
	 <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org>
	 <200609302230.24070.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/06, Andi Kleen <ak@suse.de> wrote:
> Index: linux/arch/i386/kernel/process.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/process.c
> +++ linux/arch/i386/kernel/process.c
> @@ -328,6 +328,7 @@ extern void kernel_thread_helper(void);
>  int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
>  {
>         struct pt_regs regs;
> +       int err;
>
>         memset(&regs, 0, sizeof(regs));
>
> @@ -342,7 +343,9 @@ int kernel_thread(int (*fn)(void *), voi
>         regs.eflags = X86_EFLAGS_IF | X86_EFLAGS_SF | X86_EFLAGS_PF | 0x2;
>
>         /* Ok, create the new process.. */
> -       return do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
> +       err = do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
> +       if (err == 0) /* terminate kernel stack */
> +               task_pt_regs(current)->eip = 0;
>  }
>  EXPORT_SYMBOL(kernel_thread);
>
> Index: linux/arch/x86_64/kernel/entry.S
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/entry.S
> +++ linux/arch/x86_64/kernel/entry.S
> @@ -978,6 +978,11 @@ ENTRY(kernel_thread)
>         call do_fork
>         movq %rax,RAX(%rsp)
>         xorl %edi,%edi
> +       test %rax,%rax
> +       jnz  1f
> +       /* terminate stack in child */
> +       movq %rdi,RIP(%rsp)
> +1:
>
>         /*
>          * It isn't worth to check for reschedule here,
>


For the sake of it, I tried your patch (more exactly the version at
the end of that email, againt v2.6.18). It doesn't freeze and prints
the following stack trace:

----
[  174.630434] BUG: warning at
kernel/lockdep.c:565/print_infinite_recursion_bug()
[  174.630506]
[  174.630507] Call Trace:
[  174.630703]  [<ffffffff8020b23d>] show_trace+0xad/0x3b0
[  174.630760]  [<ffffffff8020b785>] dump_stack+0x15/0x20
[  174.630819]  [<ffffffff8024ba7d>] print_infinite_recursion_bug+0x3d/0x50
[  174.630938]  [<ffffffff8024bb8f>] find_usage_backwards+0x2f/0xd0
[  174.631051]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.631163]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.631277]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.631403]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.631530]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.631655]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.631786]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.631912]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.632039]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.632166]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.632293]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.632419]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.632546]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.632672]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.632798]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.632924]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.633050]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.633176]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.633303]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.633432]  [<ffffffff8024bbf3>] find_usage_backwards+0x93/0xd0
[  174.633559]  [<ffffffff8024c5a0>] check_usage+0x40/0x2b0
[  174.633685]  [<ffffffff8024de70>] __lock_acquire+0xa50/0xd20
[  174.633811]  [<ffffffff8024e4cb>] lock_acquire+0x8b/0xc0
[  174.633941]  [<ffffffff804ac5a5>] _spin_lock+0x25/0x40
[  174.634071]  [<ffffffff80227e5b>] double_rq_lock+0x2b/0x50
[  174.634171]  [<ffffffff8022b1bb>] migration_thread+0x22b/0x2e0
[  174.634272]  [<ffffffff80246dca>] kthread+0xda/0x110
[  174.634392]  [<ffffffff8020aaad>] child_rip+0xa/0x11
----

er.


diff --git a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
index 8657c73..5a7ef45 100644
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -336,6 +336,7 @@ __asm__(".section .text\n"
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
        struct pt_regs regs;
+       int err;

        memset(&regs, 0, sizeof(regs));

@@ -350,7 +351,10 @@ int kernel_thread(int (*fn)(void *), voi
        regs.eflags = X86_EFLAGS_IF | X86_EFLAGS_SF | X86_EFLAGS_PF | 0x2;

        /* Ok, create the new process.. */
-       return do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0,
NULL, NULL);
+       err = do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0,
NULL, NULL);
+       if (err == 0) /* terminate kernel stack */
+               task_pt_regs(current)->eip = 0;
+       return err;
 }
 EXPORT_SYMBOL(kernel_thread);

diff --git a/arch/x86_64/kernel/entry.S b/arch/x86_64/kernel/entry.S
index aa8d893..5dce978 100644
--- a/arch/x86_64/kernel/entry.S
+++ b/arch/x86_64/kernel/entry.S
@@ -958,6 +958,11 @@ ENTRY(kernel_thread)
        call do_fork
        movq %rax,RAX(%rsp)
        xorl %edi,%edi
+       test %rax,%rax
+       jnz  1f
+       /* terminate stack in child */
+       movq %rdi,RIP(%rsp)
+1:

        /*
         * It isn't worth to check for reschedule here,
