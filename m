Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266897AbSIRPBg>; Wed, 18 Sep 2002 11:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266894AbSIRPBg>; Wed, 18 Sep 2002 11:01:36 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:22023
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S266897AbSIRPBf>; Wed, 18 Sep 2002 11:01:35 -0400
Subject: Re: [PATCH] schedule() in_atomic() fix
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1032324404.4593.764.camel@phantasy>
References: <1032324404.4593.764.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Sep 2002 11:06:29 -0400
Message-Id: <1032361589.5149.1420.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-18 at 00:46, Robert Love wrote:

> Attached patch fixes the scheduler in_atomic() problem with kernel
> preemption enabled (and is also working - when kernel preemption is on,
> it finds a couple issues during boot).

Attached version works with non-CONFIG_PREEMPT ...

	Robert Love

diff -urN linux-2.5.36/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.36/kernel/sched.c	Tue Sep 17 20:58:48 2002
+++ linux/kernel/sched.c	Wed Sep 18 11:03:44 2002
@@ -940,8 +940,17 @@
 	struct list_head *queue;
 	int idx;
 
-	if (unlikely(in_atomic()))
-		BUG();
+	/*
+	 * Test if we are atomic.  Since do_exit() needs to call into
+	 * schedule() atomically, we ignore that for now.  Otherwise,
+	 * whine if we are scheduling when we should not be.
+	 */
+	if (likely(current->state != TASK_ZOMBIE)) {
+		if (unlikely(in_atomic())) {
+			printk(KERN_ERR "scheduling while atomic!\n");
+			dump_stack();
+		}
+	}
 
 #if CONFIG_DEBUG_HIGHMEM
 	check_highmem_ptes();

