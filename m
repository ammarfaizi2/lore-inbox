Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbVKIVP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbVKIVP0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbVKIVP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:15:26 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:17026 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751375AbVKIVPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:15:25 -0500
From: Zach Brown <zach.brown@oracle.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051109211758.25027.78199.sendpatchset@volauvent.pdx.zabbo.net>
Subject: [PATCH 1/3] aio: remove kioctx from mm_struct
Date: Wed,  9 Nov 2005 13:15:06 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


aio: remove kioctx from mm_struct

Sync iocbs have a life cycle that don't need a kioctx.  Their retrying, if any,
is done in the context of their owner who has allocated them on the stack.  The
sole user of a sync iocb's ctx reference was aio_complete() checking for an
elevated iocb ref count that could never happen.  No path which grabs an iocb
ref has access to sync iocbs.  If we were to implement sync iocb cancelation it
would be done by the owner of the iocb using its on-stack reference.  Removing
this chunk from aio_complete allows us to remove the entire kioctx instance
from mm_struct, reducing its size by a third.  On a i386 testing box the slab
size went from 768 to 504 bytes and from 5 to 8 per page.

  Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 fs/aio.c                  |   27 +++++++++------------------
 include/linux/aio.h       |    2 +-
 include/linux/init_task.h |    1 -
 include/linux/sched.h     |    1 -
 kernel/fork.c             |    1 -
 5 files changed, 10 insertions(+), 22 deletions(-)

Index: 2.6.14-mm1-aio-cleanups/fs/aio.c
===================================================================
--- 2.6.14-mm1-aio-cleanups.orig/fs/aio.c	2005-11-09 11:37:49.117278690 -0800
+++ 2.6.14-mm1-aio-cleanups/fs/aio.c	2005-11-09 11:48:22.848483645 -0800
@@ -937,28 +937,19 @@
 	unsigned long	tail;
 	int		ret;
 
-	/* Special case handling for sync iocbs: events go directly
-	 * into the iocb for fast handling.  Note that this will not 
-	 * work if we allow sync kiocbs to be cancelled. in which
-	 * case the usage count checks will have to move under ctx_lock
-	 * for all cases.
+	/* 
+	 * Special case handling for sync iocbs: 
+	 *  - events go directly into the iocb for fast handling
+	 *  - the sync task with the iocb in its stack holds the single iocb
+	 *    ref, no other paths have a way to get another ref
+	 *  - the sync task helpfully left a reference to itself in the iocb
 	 */
 	if (is_sync_kiocb(iocb)) {
-		int ret;
-
+		BUG_ON(iocb->ki_users != 1);
 		iocb->ki_user_data = res;
-		if (iocb->ki_users == 1) {
-			iocb->ki_users = 0;
-			ret = 1;
-		} else {
-			spin_lock_irq(&ctx->ctx_lock);
-			iocb->ki_users--;
-			ret = (0 == iocb->ki_users);
-			spin_unlock_irq(&ctx->ctx_lock);
-		}
-		/* sync iocbs put the task here for us */
+		iocb->ki_users = 0;
 		wake_up_process(iocb->ki_obj.tsk);
-		return ret;
+		return 1;
 	}
 
 	info = &ctx->ring_info;
Index: 2.6.14-mm1-aio-cleanups/include/linux/aio.h
===================================================================
--- 2.6.14-mm1-aio-cleanups.orig/include/linux/aio.h	2005-11-09 11:37:49.100283807 -0800
+++ 2.6.14-mm1-aio-cleanups/include/linux/aio.h	2005-11-09 11:48:22.848483645 -0800
@@ -124,7 +124,7 @@
 		(x)->ki_users = 1;			\
 		(x)->ki_key = KIOCB_SYNC_KEY;		\
 		(x)->ki_filp = (filp);			\
-		(x)->ki_ctx = &tsk->active_mm->default_kioctx;	\
+		(x)->ki_ctx = NULL;			\
 		(x)->ki_cancel = NULL;			\
 		(x)->ki_dtor = NULL;			\
 		(x)->ki_obj.tsk = tsk;			\
Index: 2.6.14-mm1-aio-cleanups/include/linux/init_task.h
===================================================================
--- 2.6.14-mm1-aio-cleanups.orig/include/linux/init_task.h	2005-11-09 11:37:49.100283807 -0800
+++ 2.6.14-mm1-aio-cleanups/include/linux/init_task.h	2005-11-09 11:48:22.848483645 -0800
@@ -51,7 +51,6 @@
 	.page_table_lock =  SPIN_LOCK_UNLOCKED, 		\
 	.mmlist		= LIST_HEAD_INIT(name.mmlist),		\
 	.cpu_vm_mask	= CPU_MASK_ALL,				\
-	.default_kioctx = INIT_KIOCTX(name.default_kioctx, name),	\
 }
 
 #define INIT_SIGNALS(sig) {	\
Index: 2.6.14-mm1-aio-cleanups/include/linux/sched.h
===================================================================
--- 2.6.14-mm1-aio-cleanups.orig/include/linux/sched.h	2005-11-09 11:37:49.094285613 -0800
+++ 2.6.14-mm1-aio-cleanups/include/linux/sched.h	2005-11-09 11:48:22.849483344 -0800
@@ -360,7 +360,6 @@
 	/* aio bits */
 	rwlock_t		ioctx_list_lock;
 	struct kioctx		*ioctx_list;
-	struct kioctx		default_kioctx;
 };
 
 struct sighand_struct {
Index: 2.6.14-mm1-aio-cleanups/kernel/fork.c
===================================================================
--- 2.6.14-mm1-aio-cleanups.orig/kernel/fork.c	2005-11-09 11:37:49.108281399 -0800
+++ 2.6.14-mm1-aio-cleanups/kernel/fork.c	2005-11-09 11:48:22.850483043 -0800
@@ -324,7 +324,6 @@
 	spin_lock_init(&mm->page_table_lock);
 	rwlock_init(&mm->ioctx_list_lock);
 	mm->ioctx_list = NULL;
-	mm->default_kioctx = (struct kioctx)INIT_KIOCTX(mm->default_kioctx, *mm);
 	mm->free_area_cache = TASK_UNMAPPED_BASE;
 	mm->cached_hole_size = ~0UL;
 
