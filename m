Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUCRJsi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 04:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbUCRJrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 04:47:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:10148 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262476AbUCRJpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 04:45:19 -0500
Date: Thu, 18 Mar 2004 01:45:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: sched_setaffinity usability
Message-Id: <20040318014517.3cd232c4.akpm@osdl.org>
In-Reply-To: <40595842.5070708@redhat.com>
References: <40595842.5070708@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> wrote:
>
>  The sched_setaffinity syscall currently has a usability problem.  The
>  size of cpumask_t is not visible outside the kernel and might change
>  from kernel to kernel.  So, if the user uses a large CPU bitset and
>  passes it to the kernel it is not known at all whether all the bits
>  provided in the bitmap are used.  The kernel simply copies the first
>  bytes, enough to fill in the cpumask_t object and ignores the rest.
> 
>  A simple check for a too large bitset is not good.  Programs which are
>  portable (to different kernels) and future safe should use large bitmap
>  sizes.  Instead the user should only be notified about the size problem
>  if any nonzero bit is ignored.

Perhaps the syscall itself should go look for set bits which are beyond the
current number of physical CPUs and fail the syscall if any are found.

Like this, if it was tested:


diff -puN kernel/sched.c~a kernel/sched.c
--- 25/kernel/sched.c~a	2004-03-18 01:25:29.697217008 -0800
+++ 25-akpm/kernel/sched.c	2004-03-18 01:42:32.312755816 -0800
@@ -2736,13 +2736,39 @@ asmlinkage long sys_sched_setaffinity(pi
 	cpumask_t new_mask;
 	int retval;
 	task_t *p;
+	int remainder;
+	unsigned long __user *up;
 
 	if (len < sizeof(new_mask))
 		return -EINVAL;
 
+	/* Avoid spending stupid amounts of time in the kernel */
+	if (len > 16384)
+		return -EINVAL;
+
 	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
 		return -EFAULT;
 
+	/*
+	 * Check that the user hasn't asked for any impossible CPUs outside
+	 * sizeof(cpumask_t).  set_cpus_allowed() will check for impossible
+	 * cpus inside sizeof(cpumask_t).
+	 */
+	remainder = len - sizeof(new_mask);	/* bytes */
+	up = user_mask_ptr + 1;
+	while (remainder > 0) {
+		unsigned long u;
+		int nr_bits;
+
+		if (get_user(u, up))
+			return -EFAULT;
+		nr_bits = min((int)sizeof(u), remainder);
+		if (find_next_bit(&u, nr_bits, 0) >= nr_bits)
+			return -EINVAL;
+		remainder -= sizeof(u);
+		up++;
+	}
+
 	read_lock(&tasklist_lock);
 
 	p = find_process_by_pid(pid);

_

