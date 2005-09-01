Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030430AbVIAWAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbVIAWAz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbVIAWAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:00:55 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:64647 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030436AbVIAWAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:00:49 -0400
Date: Fri, 2 Sep 2005 00:00:46 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 6/10] add stack field to task_struct
Message-ID: <Pine.LNX.4.61.0509020000270.11552@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds a new field stack to task_struct. Its value is identical to thread_info,
but on m68k it doesn't point to the thread_info. This allows to convert direct accesses
to the thread_info field to either convert to using the stack field, end_of_stack()
or task_thread_info().

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/asm-m68k/thread_info.h |    4 ++--
 include/linux/init_task.h      |    1 +
 include/linux/sched.h          |    5 +++--
 kernel/fork.c                  |    1 +
 4 files changed, 7 insertions(+), 4 deletions(-)

Index: linux-2.6-mm/include/linux/sched.h
===================================================================
--- linux-2.6-mm.orig/include/linux/sched.h	2005-09-01 21:04:33.241207651 +0200
+++ linux-2.6-mm/include/linux/sched.h	2005-09-01 21:04:41.963708999 +0200
@@ -662,6 +662,7 @@ struct mempolicy;
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
+	void *stack;
 	atomic_t usage;
 	unsigned long flags;	/* per process flags, defined below */
 	unsigned long ptrace;
@@ -1211,7 +1212,7 @@ static inline void task_unlock(struct ta
 
 #ifndef __HAVE_THREAD_FUNCTIONS
 
-#define task_thread_info(task) (task)->thread_info
+#define task_thread_info(task) ((struct thread_info *)(task)->stack)
 
 static inline void setup_thread_stack(struct task_struct *p, struct task_struct *org)
 {
@@ -1221,7 +1222,7 @@ static inline void setup_thread_stack(st
 
 static inline unsigned long *end_of_stack(struct task_struct *p)
 {
-	return (unsigned long *)(p->thread_info + 1);
+	return (unsigned long *)(task_thread_info(p) + 1);
 }
 
 #endif
Index: linux-2.6-mm/include/linux/init_task.h
===================================================================
--- linux-2.6-mm.orig/include/linux/init_task.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/linux/init_task.h	2005-09-01 21:04:41.987704876 +0200
@@ -81,6 +81,7 @@ extern struct group_info init_groups;
 {									\
 	.state		= 0,						\
 	.thread_info	= &init_thread_info,				\
+	.stack		= &init_stack,					\
 	.usage		= ATOMIC_INIT(2),				\
 	.flags		= 0,						\
 	.lock_depth	= -1,						\
Index: linux-2.6-mm/kernel/fork.c
===================================================================
--- linux-2.6-mm.orig/kernel/fork.c	2005-09-01 21:04:28.638998406 +0200
+++ linux-2.6-mm/kernel/fork.c	2005-09-01 21:04:41.988704704 +0200
@@ -172,6 +172,7 @@ static struct task_struct *dup_task_stru
 
 	*tsk = *orig;
 	tsk->thread_info = ti;
+	tsk->stack = ti;
 	setup_thread_stack(tsk, orig);
 
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
Index: linux-2.6-mm/include/asm-m68k/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-m68k/thread_info.h	2005-09-01 21:04:39.711096024 +0200
+++ linux-2.6-mm/include/asm-m68k/thread_info.h	2005-09-01 21:04:41.988704704 +0200
@@ -42,11 +42,11 @@ struct thread_info {
 #define __HAVE_THREAD_FUNCTIONS
 
 #define setup_thread_stack(p, org) ({			\
-	*(struct task_struct **)(p)->thread_info = (p);	\
+	*(struct task_struct **)(p)->stack = (p);	\
 	task_thread_info(p)->task = (p);		\
 })
 
-#define end_of_stack(p) ((unsigned long *)(p)->thread_info + 1)
+#define end_of_stack(p) ((unsigned long *)(p)->stack + 1)
 
 /* entry.S relies on these definitions!
  * bits 0-7 are tested at every exception exit
