Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbVIAV7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbVIAV7I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbVIAV7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:59:08 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:58503 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030427AbVIAV7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:59:04 -0400
Date: Thu, 1 Sep 2005 23:59:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 2/10] m68k: introduce setup_thread_stack()/end_of_stack()
Message-ID: <Pine.LNX.4.61.0509012358460.9704@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk> 

encapsulates the rest of arch-dependent operations with thread_info
access.  Two new helpers - setup_thread_stack() and end_of_stack().  For
normal case the former consists of copying thread_info of parent to new
thread_info and the latter returns pointer immediately past the end of
thread_info.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/sched.h |   11 +++++++++++
 kernel/fork.c         |    3 +--
 kernel/sched.c        |    4 ++--
 3 files changed, 14 insertions(+), 4 deletions(-)

Index: linux-2.6-mm/include/linux/sched.h
===================================================================
--- linux-2.6-mm.orig/include/linux/sched.h	2005-09-01 21:04:03.762273052 +0200
+++ linux-2.6-mm/include/linux/sched.h	2005-09-01 21:04:28.637998577 +0200
@@ -1211,6 +1211,17 @@ static inline void task_unlock(struct ta
 
 #define task_thread_info(task) (task)->thread_info
 
+static inline void setup_thread_stack(struct task_struct *p, struct task_struct *org)
+{
+	*task_thread_info(p) = *task_thread_info(org);
+	task_thread_info(p)->task = p;
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
Index: linux-2.6-mm/kernel/fork.c
===================================================================
--- linux-2.6-mm.orig/kernel/fork.c	2005-09-01 21:04:03.861256043 +0200
+++ linux-2.6-mm/kernel/fork.c	2005-09-01 21:04:28.638998406 +0200
@@ -170,10 +170,9 @@ static struct task_struct *dup_task_stru
 		return NULL;
 	}
 
-	*ti = *orig->thread_info;
 	*tsk = *orig;
 	tsk->thread_info = ti;
-	ti->task = tsk;
+	setup_thread_stack(tsk, orig);
 
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
Index: linux-2.6-mm/kernel/sched.c
===================================================================
--- linux-2.6-mm.orig/kernel/sched.c	2005-09-01 21:04:03.896250029 +0200
+++ linux-2.6-mm/kernel/sched.c	2005-09-01 21:04:28.640998062 +0200
@@ -4331,10 +4331,10 @@ static void show_task(task_t *p)
 #endif
 #ifdef CONFIG_DEBUG_STACK_USAGE
 	{
-		unsigned long *n = (unsigned long *) (p->thread_info+1);
+		unsigned long *n = end_of_stack(p);
 		while (!*n)
 			n++;
-		free = (unsigned long) n - (unsigned long)(p->thread_info+1);
+		free = (unsigned long)n - (unsigned long)end_of_stack(p);
 	}
 #endif
 	printk("%5lu %5d %6d ", free, p->pid, p->parent->pid);
