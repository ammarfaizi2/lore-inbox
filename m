Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUCRIFm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 03:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbUCRIFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 03:05:42 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:53209
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261967AbUCRIF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 03:05:29 -0500
Message-ID: <40595842.5070708@redhat.com>
Date: Thu, 18 Mar 2004 00:05:22 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: sched_setaffinity usability
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sched_setaffinity syscall currently has a usability problem.  The
size of cpumask_t is not visible outside the kernel and might change
from kernel to kernel.  So, if the user uses a large CPU bitset and
passes it to the kernel it is not known at all whether all the bits
provided in the bitmap are used.  The kernel simply copies the first
bytes, enough to fill in the cpumask_t object and ignores the rest.

A simple check for a too large bitset is not good.  Programs which are
portable (to different kernels) and future safe should use large bitmap
sizes.  Instead the user should only be notified about the size problem
if any nonzero bit is ignored.

Doing this in the kernel isn't good.  It would require copying all the
bitmap into the kernel address space.  So do it at userlevel.

But how?  The userlevel code does not know the size of the type the
kernel used.  In the getaffinity call this is handled nicely: the
syscall returns the size of the type.

I think we should do the same for setaffinity.  Something like this:

--- kernel/sched.c      2004-03-16 20:57:25.000000000 -0800
+++ kernel/sched.c-new  2004-03-17 23:52:25.000000000 -0800
@@ -2328,6 +2328,8 @@ asmlinkage long sys_sched_setaffinity(pi
                goto out_unlock;

        retval = set_cpus_allowed(p, new_mask);
+       if (retval == 0)
+               retval = sizeof(new_mask);

 out_unlock:
        put_task_struct(p);


The userlevel code could then check whether the remaining words in the
bitset contain any set bits.

The interface change is limited to the kernel only.  We can arrange for
the sched_setaffinity/pthread_setaffinity calls to still return zero in
case of success (in fact, that's the desirable solution).  Additionally,
we could hardcode a size for the case when the syscall returns zero to
handle old kernels.


Is this acceptable?

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
