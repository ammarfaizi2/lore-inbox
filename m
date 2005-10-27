Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbVJ0EIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbVJ0EIy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 00:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbVJ0EIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 00:08:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51102 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964958AbVJ0EIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 00:08:53 -0400
Date: Wed, 26 Oct 2005 21:08:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: rajesh.shah@intel.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] export cpu_online_map
Message-Id: <20051026210803.07efba69.akpm@osdl.org>
In-Reply-To: <20051026205038.26a1c333.pj@sgi.com>
References: <200510260421.j9Q4LGh9014087@shell0.pdx.osdl.net>
	<20051026205038.26a1c333.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Andrew asked:
> > - Why isn't set_cpus_allowed() just a no-op on UP?  Or some trivial thing
> >   which tests for cpu #0?
> 
> I don't know.
> 
> By scanning random copies of kernels left on my drive, I can see that
> it changed from a trivial "return 0" to the more interesting check using
> cpu_online_map in one of your "linus.patch" patches in the release
> 2.6.11-rc1-mm2.
> 
> But I don't know how to get to the history at this point to see what
> happened.
> 
> It looks like Linus started the git history at 2.6.12-rc2.
> 
>   Could someone clue me in on how to find Linux history BG (before-git)?
>
> Since bk no longer works for me, I have no idea how to access any
> history prior to about 2.6.12-rc2.  Ugh.

There's still bkbits.net:

http://linux.bkbits.net:8080/linux-2.6/diffs/include/linux/sched.h@1.271.1.6?nav=index.html|src/|src/include|src/include/linux|hist/include/linux/sched.h


From: Rusty Russell <rusty@rustcorp.com.au>

Return EINVAL for invalid sched_setaffinity on UP.  I was a little
surprised that sys_sched_setaffinity for CPU 1 didn't fail on my UP box. 
With CONFIG_SMP it would have.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/linux/sched.h |    3 +++
 1 files changed, 3 insertions(+)

diff -puN include/linux/sched.h~sys_sched_setaffinity-on-up-should-fail-for-non-zero include/linux/sched.h
--- 25/include/linux/sched.h~sys_sched_setaffinity-on-up-should-fail-for-non-zero	2005-01-04 18:48:15.000000000 -0800
+++ 25-akpm/include/linux/sched.h	2005-01-04 20:24:20.010381184 -0800
@@ -13,6 +13,7 @@
 #include <linux/rbtree.h>
 #include <linux/thread_info.h>
 #include <linux/cpumask.h>
+#include <linux/errno.h>
 
 #include <asm/system.h>
 #include <asm/semaphore.h>
@@ -732,6 +733,8 @@ extern int set_cpus_allowed(task_t *p, c
 #else
 static inline int set_cpus_allowed(task_t *p, cpumask_t new_mask)
 {
+	if (!cpus_intersects(new_mask, cpu_online_map))
+		return -EINVAL;
 	return 0;
 }
 #endif
_

Seems silly to use cpu_online_map to test for `1'?
