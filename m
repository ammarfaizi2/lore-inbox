Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbVHYFXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVHYFXg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbVHYFW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:22:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8908 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964820AbVHYFWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:22:06 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (18/22) task_thread_info - part 2/4
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8AEh-0005eT-NP@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:25:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

encapsulates the rest of arch-dependent operations with thread_info access.
Two new helpers - setup_thread_info() and end_of_stack().  For normal
case the former consists of copying thread_info of parent to new thread_info
and the latter returns pointer immediately past the end of thread_info.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-task_thread_info/include/linux/sched.h RC13-rc7-other-helpers/include/linux/sched.h
--- RC13-rc7-task_thread_info/include/linux/sched.h	2005-08-25 00:54:17.000000000 -0400
+++ RC13-rc7-other-helpers/include/linux/sched.h	2005-08-25 00:54:17.000000000 -0400
@@ -1138,6 +1138,16 @@
 
 #define task_thread_info(task) (task)->thread_info
 
+static inline void setup_thread_info(struct task_struct *p, struct thread_info *ti)
+{
+	*ti = *p->thread_info;
+}
+
+static inline unsigned long *end_of_stack(struct task_struct *p)
+{
+	return (unsigned long *)(p->thread_info + 1);
+}
+
 /* set thread flags in other task's structures
  * - see asm/thread_info.h for TIF_xxxx flags available
  */
diff -urN RC13-rc7-task_thread_info/kernel/fork.c RC13-rc7-other-helpers/kernel/fork.c
--- RC13-rc7-task_thread_info/kernel/fork.c	2005-08-25 00:54:17.000000000 -0400
+++ RC13-rc7-other-helpers/kernel/fork.c	2005-08-25 00:54:17.000000000 -0400
@@ -169,8 +169,8 @@
 		return NULL;
 	}
 
-	*ti = *orig->thread_info;
 	*tsk = *orig;
+	setup_thread_info(tsk, ti);
 	tsk->thread_info = ti;
 	ti->task = tsk;
 
diff -urN RC13-rc7-task_thread_info/kernel/sched.c RC13-rc7-other-helpers/kernel/sched.c
--- RC13-rc7-task_thread_info/kernel/sched.c	2005-08-25 00:54:17.000000000 -0400
+++ RC13-rc7-other-helpers/kernel/sched.c	2005-08-25 00:54:17.000000000 -0400
@@ -4121,10 +4121,10 @@
 #endif
 #ifdef CONFIG_DEBUG_STACK_USAGE
 	{
-		unsigned long * n = (unsigned long *) (p->thread_info+1);
+		unsigned long * n = end_of_stack(p);
 		while (!*n)
 			n++;
-		free = (unsigned long) n - (unsigned long)(p->thread_info+1);
+		free = (unsigned long) n - (unsigned long) end_of_stack(p);
 	}
 #endif
 	printk("%5lu %5d %6d ", free, p->pid, p->parent->pid);
