Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbUCRL21 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 06:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbUCRL21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 06:28:27 -0500
Received: from mx1.elte.hu ([157.181.1.137]:7086 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262525AbUCRL2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 06:28:17 -0500
Date: Thu, 18 Mar 2004 12:29:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: sched_setaffinity usability
Message-ID: <20040318112913.GA13981@elte.hu>
References: <40595842.5070708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40595842.5070708@redhat.com>
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


* Ulrich Drepper <drepper@redhat.com> wrote:

> The sched_setaffinity syscall currently has a usability problem.  The
> size of cpumask_t is not visible outside the kernel and might change
> from kernel to kernel.  So, if the user uses a large CPU bitset and
> passes it to the kernel it is not known at all whether all the bits
> provided in the bitmap are used.  The kernel simply copies the first
> bytes, enough to fill in the cpumask_t object and ignores the rest.
> 
> A simple check for a too large bitset is not good.  Programs which are
> portable (to different kernels) and future safe should use large
> bitmap sizes.  Instead the user should only be notified about the size
> problem if any nonzero bit is ignored.

how about adding a new syscall, sys_sched_get_affinity_span(), which
would be called by glibc first time one of the affinity syscalls are
called.

This syscall would be a prime target to be optimized away via the
vsyscall DSO, so there's no overhead worry.

something like the attached patch.

or, maybe it would be better to introduce some sort of 'system
constants' syscall that would be a generic umbrella for such things -
and could easily be converted into a vsyscall. Or we could make it part
of the .data section of the VDSO - thus no copying overhead, only one
symbol lookup.

	Ingo

--- linux/arch/i386/kernel/entry.S.orig
+++ linux/arch/i386/kernel/entry.S
@@ -908,5 +908,6 @@ ENTRY(sys_call_table)
 	.long sys_utimes
  	.long sys_fadvise64_64
 	.long sys_ni_syscall	/* sys_vserver */
+	.long sys_sched_get_affinity_span
 
 syscall_table_size=(.-sys_call_table)
--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -2793,6 +2793,17 @@ out_unlock:
 }
 
 /**
+ * sys_sched_affinity_span - get the cpu affinity mask size possible
+ *
+ * returns the size of cpumask_t. Note that this is a hard upper limit
+ * for the # of CPUs.
+ */
+asmlinkage long sys_sched_get_affinity_span(void)
+{
+	return sizeof(cpumask_t);
+}
+
+/**
  * sys_sched_yield - yield the current processor to other threads.
  *
  * this function yields the current CPU by moving the calling thread
