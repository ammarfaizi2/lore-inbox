Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbSIRFEe>; Wed, 18 Sep 2002 01:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265264AbSIRFEe>; Wed, 18 Sep 2002 01:04:34 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:49926
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265262AbSIRFEd>; Wed, 18 Sep 2002 01:04:33 -0400
Subject: Re: [PATCH] schedule() in_atomic() fix
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Cc: Andrew Morton <akpm@digeo.com>
In-Reply-To: <3D88099C.9B5F044D@digeo.com>
References: <1032324404.4593.764.camel@phantasy> 
	<3D88099C.9B5F044D@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Sep 2002 01:09:37 -0400
Message-Id: <1032325778.4588.791.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-18 at 01:05, Andrew Morton wrote:

> Robert Love wrote:
> > 
> > +    printk(KERN_ERR "scheduling while non-atomic!\n");
> 
> When did this become illegal?  :-)

Ugh, reality is blurred... thanks.

Linus, this patch reduces the kernel by 4 bytes over the previous. 
Please, apply.

	Robert Love

diff -urN linux-2.5.36/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.36/kernel/sched.c	Tue Sep 17 20:58:48 2002
+++ linux/kernel/sched.c	Wed Sep 18 00:41:09 2002
@@ -940,9 +940,6 @@
 	struct list_head *queue;
 	int idx;
 
-	if (unlikely(in_atomic()))
-		BUG();
-
 #if CONFIG_DEBUG_HIGHMEM
 	check_highmem_ptes();
 #endif
@@ -950,8 +947,20 @@
 	preempt_disable();
 	prev = current;
 	rq = this_rq();
-
 	release_kernel_lock(prev);
+
+	/*
+	 * Test if we are atomic.  Since do_exit() needs to call into
+	 * schedule() atomically, we ignore that for now.  Otherwise,
+	 * whine if we are scheduling when we should not be.
+	 */
+	if (likely(current->state != TASK_ZOMBIE)) {
+		if (unlikely((preempt_count() & ~PREEMPT_ACTIVE) != 1)) {
+			printk(KERN_ERR "scheduling while atomic!\n");
+			dump_stack();
+		}
+	}
+
 	prev->sleep_timestamp = jiffies;
 	spin_lock_irq(&rq->lock);
 


