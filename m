Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317278AbSILUk5>; Thu, 12 Sep 2002 16:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSILUk5>; Thu, 12 Sep 2002 16:40:57 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:51213
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S317278AbSILUkw>; Thu, 12 Sep 2002 16:40:52 -0400
Subject: Re: [PATCH] kernel BUG at sched.c:944! only with CONFIG_PREEMPT=y]
From: Robert Love <rml@tech9.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Cole <elenstev@mesatop.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Steven Cole <scole@lanl.gov>
In-Reply-To: <Pine.LNX.4.44.0209122242300.21936-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0209122242300.21936-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 12 Sep 2002 16:45:43 -0400
Message-Id: <1031863543.3837.110.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 16:44, Ingo Molnar wrote:

> it *is* a great debugging check, at zero added cost. Scheduling from an
> atomic region *is* a critical bug that can and will cause problems in 99%
> of the cases. Rather fix the asserts that got triggered instead of backing
> out useful debugging checks ...

There are a lot of shitty drivers that this is going to catch.  Yes,
that is great... but we cannot BUG().  There really are a LOT of them. 
In the least, we need to show_trace().

Anyhow, this currently will catch _all_ kernel preemptions because the
PREEMPT_ACTIVE flag is set.

We need to do something like the attached (untested), at the very
least...

I would prefer to make this a kernel debugging check, however.  Or, make
using kernel preemption the default.  Using the "free" abilities of
kernel preemption is great, but not at the expense of its users.

	Robert Love

diff -urN linux-2.5.34/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.34/kernel/sched.c	Thu Sep 12 16:26:23 2002
+++ linux/kernel/sched.c	Thu Sep 12 16:42:59 2002
@@ -940,8 +940,10 @@
 	struct list_head *queue;
 	int idx;
 
-	if (unlikely(in_atomic()))
-		BUG();
+	if (unlikely(in_atomic() && preempt_count() != PREEMPT_ACTIVE)) {
+		printk(KERN_ERROR "schedule() called while non-atomic!\n");
+		show_stack(NULL);
+	}
 
 #if CONFIG_DEBUG_HIGHMEM
 	check_highmem_ptes();
@@ -959,7 +961,7 @@
 	 * if entering off of a kernel preemption go straight
 	 * to picking the next task.
 	 */
-	if (unlikely(preempt_count() & PREEMPT_ACTIVE))
+	if (unlikely(preempt_count() == PREEMPT_ACTIVE))
 		goto pick_next_task;
 
 	switch (prev->state) {

