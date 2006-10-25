Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751718AbWJYO3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbWJYO3h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 10:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWJYO3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 10:29:37 -0400
Received: from flvpn.ccur.com ([66.10.65.2]:7030 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S1751718AbWJYO3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 10:29:36 -0400
Date: Wed, 25 Oct 2006 10:29:23 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Matt Mackall <mpm@selenic.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strange work_notifysig code since 2.6.16
Message-ID: <20061025142923.GA20833@tsunami.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <20061024231921.GA25130@tsunami.ccur.com> <20061025054806.GP6412@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061025054806.GP6412@waste.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect this won't link with CONFIG_VM86 disabled because save_v86_state
> goes away. I think we just need to move the #endif up a few lines.

Hi Matt,
Since that also makes the 'then' and 'else' branches identical, perhaps
this patch would be better .. it eliminates the VM86 test entirely when
CONFIG_VM86=n.

Boot tested with CONFIG_VM86=y.

Regards,
Joe

The entry.S code at work_notifysig is surely wrong.  It drops into unrelated
code if the branch to work_notifysig_v86 is taken, and CONFIG_VM86=n.

	[PATCH] Make vm86 support optional
	tree 9b5daef5280800a0006343a17f63072658d91a1d
	pushed to git Jan 8, 2006, and first appears in 2.6.16

The 'fix' here is to also compile out the vm86 test & branch when
CONFIG_VM86=n.

Signed-off-by: Joe Korty <joe.korty@ccur.com>

Index: 2.6.18.1/arch/i386/kernel/entry.S
===================================================================
--- 2.6.18.1.orig/arch/i386/kernel/entry.S	2006-10-25 10:06:25.000000000 -0400
+++ 2.6.18.1/arch/i386/kernel/entry.S	2006-10-25 10:10:38.000000000 -0400
@@ -447,6 +447,7 @@
 
 work_notifysig:				# deal with pending signals and
 					# notify-resume requests
+#ifdef CONFIG_VM86
 	testl $VM_MASK, EFLAGS(%esp)
 	movl %esp, %eax
 	jne work_notifysig_v86		# returning to kernel-space or
@@ -457,17 +458,18 @@
 
 	ALIGN
 work_notifysig_v86:
-#ifdef CONFIG_VM86
 	pushl %ecx			# save ti_flags for do_notify_resume
 	CFI_ADJUST_CFA_OFFSET 4
 	call save_v86_state		# %eax contains pt_regs pointer
 	popl %ecx
 	CFI_ADJUST_CFA_OFFSET -4
 	movl %eax, %esp
+#else
+	movl %esp, %eax
+#endif
 	xorl %edx, %edx
 	call do_notify_resume
 	jmp resume_userspace_sig
-#endif
 
 	# perform syscall exit tracing
 	ALIGN
