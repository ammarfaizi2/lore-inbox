Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbUK3Ejb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbUK3Ejb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 23:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUK3Ejb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 23:39:31 -0500
Received: from ozlabs.org ([203.10.76.45]:57317 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261978AbUK3Ej1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 23:39:27 -0500
Subject: [PATCH] sys_sched_setaffinity() on UP should fail for non-zero
	CPUs.
From: Rusty Russell <rusty@rustcorp.com.au>
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 30 Nov 2004 15:39:24 +1100
Message-Id: <1101789564.14565.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Return EINVAL for invalid sched_setaffinity on UP
Status: Tested on 2.6.10-rc2-bk13
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

I was a little surprised that sys_sched_setaffinity for CPU 1 didn't
fail on my UP box.  With CONFIG_SMP it would have.

Index: linux-2.6.10-rc2-bk13-Misc/include/linux/sched.h
===================================================================
--- linux-2.6.10-rc2-bk13-Misc.orig/include/linux/sched.h	2004-11-16 15:30:07.000000000 +1100
+++ linux-2.6.10-rc2-bk13-Misc/include/linux/sched.h	2004-11-30 14:09:38.000000000 +1100
@@ -13,6 +13,7 @@
 #include <linux/rbtree.h>
 #include <linux/thread_info.h>
 #include <linux/cpumask.h>
+#include <linux/errno.h>
 
 #include <asm/system.h>
 #include <asm/semaphore.h>
@@ -708,6 +709,8 @@
 #else
 static inline int set_cpus_allowed(task_t *p, cpumask_t new_mask)
 {
+	if (!cpus_intersects(new_mask, cpu_online_map))
+		return -EINVAL;
 	return 0;
 }
 #endif

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

