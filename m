Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267943AbTAHWbS>; Wed, 8 Jan 2003 17:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267944AbTAHWbS>; Wed, 8 Jan 2003 17:31:18 -0500
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:5344 "EHLO demo.mitica")
	by vger.kernel.org with ESMTP id <S267943AbTAHWbQ>;
	Wed, 8 Jan 2003 17:31:16 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH]: Remove PF_MEMDIE as it is redundant
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 08 Jan 2003 23:47:52 +0100
Message-ID: <m2r8bn6yxz.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
        PF_MEMDIE don't have any use in current kernels.  Please
        remove, we only set it in one place, and there we also set
        PF_MEMALLOC.  And we only test it in other place, and we also
        test for PF_MEMALLOC.  This patch has existed in aa for some
        quite time.

        Please apply.

        Later, Juan.

diff -urNp ref/include/linux/sched.h 2.4.20pre5aa1/include/linux/sched.h
--- ref/include/linux/sched.h	Fri Aug 30 01:55:20 2002
+++ 2.4.20pre5aa1/include/linux/sched.h	Fri Aug 30 01:55:22 2002
@@ -481,7 +481,6 @@ struct task_struct {
 #define PF_DUMPCORE	0x00000200	/* dumped core */
 #define PF_SIGNALED	0x00000400	/* killed by a signal */
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
-#define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
 #define PF_FREE_PAGES	0x00002000	/* per process page freeing */
 #define PF_NOIO		0x00004000	/* avoid generating further I/O */
 
diff -urNp ref/mm/oom_kill.c 2.4.20pre5aa1/mm/oom_kill.c
--- t3/mm/oom_kill.c.cc13-2.orig	2002-10-25 12:53:02.000000000 +0200
+++ t3/mm/oom_kill.c	2002-10-25 13:09:27.000000000 +0200
@@ -149,7 +149,7 @@ void oom_kill_task(struct task_struct *p
 	 * exit() and clear out its resources quickly...
 	 */
 	p->counter = 5 * HZ;
-	p->flags |= PF_MEMALLOC | PF_MEMDIE;
+	p->flags |= PF_MEMALLOC;
 
 	/* This process has hardware access, be more careful. */
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
diff -uNp t1/mm/page_alloc.c.cc13-3.orig t1/mm/page_alloc.c
--- t1/mm/page_alloc.c.cc13-3.orig	2003-01-08 23:32:31.000000000 +0100
+++ t1/mm/page_alloc.c	2003-01-08 23:40:26.000000000 +0100
@@ -351,7 +351,7 @@ struct page * __alloc_pages(unsigned int
 	/* here we're in the low on memory slow path */
 
 rebalance:
-	if (current->flags & (PF_MEMALLOC | PF_MEMDIE)) {
+	if (current->flags & PF_MEMALLOC) {
 		zone = zonelist->zones;
 		for (;;) {
 			zone_t *z = *(zone++);





-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
