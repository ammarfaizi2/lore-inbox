Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319515AbSIMEvH>; Fri, 13 Sep 2002 00:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319516AbSIMEvH>; Fri, 13 Sep 2002 00:51:07 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:46840 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S319515AbSIMEvD>; Fri, 13 Sep 2002 00:51:03 -0400
Date: Fri, 13 Sep 2002 00:55:54 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-aio@kvack.org
Subject: [patch] aio -- sync iocb support and small cleanup
Message-ID: <20020913005554.A1674@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

The patch below (which can also be pulled from master.kernel.org:aio-2.5) 
adds support for synchronous iocbs and converts generic_file_read to use a 
sync iocb to call into generic_file_aio_read.  The tests I've run with 
lmbench on a piii-866 showed no difference in file re-read speed when 
forced to use a completion path via aio_complete and an -EIOCBQUEUED 
return from generic_file_aio_read -- people with slower machines might 
want to test this to see if we can tune it any better.  Also, a bug fix 
to correct a missing call into the aio code from the fork code is present.
This patch sets things up for making generic_file_aio_read actually 
asynchronous.

		-ben


 fs/aio.c                  |   45 ++++++++++++++++++++++++++++++++++++++++++---
 include/linux/aio.h       |   22 ++++++++++++++--------
 include/linux/init_task.h |   30 ++++++++++++++++++++++--------
 include/linux/sched.h     |    5 ++++-
 kernel/fork.c             |    4 ++++
 mm/filemap.c              |   17 ++++++++++++++++-
 6 files changed, 102 insertions(+), 21 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.590   -> 1.591  
#	 include/linux/aio.h	1.1     -> 1.2    
#	include/linux/init_task.h	1.15    -> 1.16   
#	include/linux/sched.h	1.83.1.6 -> 1.86   
#	       kernel/fork.c	1.70    -> 1.71   
#	        mm/filemap.c	1.134   -> 1.135  
#	            fs/aio.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/13	bcrl@toomuch.toronto.redhat.com	1.497.2.3
# a couple of aio cleanups and sync iocb support for use in implementing read() in terms of aio_read()
# --------------------------------------------
# 02/09/13	bcrl@toomuch.toronto.redhat.com	1.591
# Merge master.kernel.org:aio-2.5
# into toomuch.toronto.redhat.com:/md0/net-aio/bk/work/work-core
# --------------------------------------------
#
diff -Nru a/fs/aio.c b/fs/aio.c
--- a/fs/aio.c	Fri Sep 13 00:46:54 2002
+++ b/fs/aio.c	Fri Sep 13 00:46:54 2002
@@ -30,10 +30,11 @@
 #include <linux/compiler.h>
 #include <linux/brlock.h>
 #include <linux/module.h>
+#include <linux/tqueue.h>
+#include <linux/highmem.h>
 
 #include <asm/kmap_types.h>
 #include <asm/uaccess.h>
-#include <linux/highmem.h>
 
 #if DEBUG > 1
 #define dprintk		printk
@@ -304,10 +305,25 @@
 		schedule();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	}
-	set_task_state(tsk, TASK_RUNNING);
+	__set_task_state(tsk, TASK_RUNNING);
 	remove_wait_queue(&ctx->wait, &wait);
 }
 
+/* wait_on_sync_kiocb:
+ *	Waits on the given sync kiocb to complete.
+ */
+ssize_t wait_on_sync_kiocb(struct kiocb *iocb)
+{
+	while (iocb->ki_users) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (!iocb->ki_users)
+			break;
+		schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+	return iocb->ki_user_data;
+}
+
 /* exit_aio: called when the last user of mm goes away.  At this point, 
  * there is no way for any new requests to be submited or any of the 
  * io_* syscalls to be called on the context.  However, there may be 
@@ -516,12 +532,35 @@
 int aio_complete(struct kiocb *iocb, long res, long res2)
 {
 	struct kioctx	*ctx = iocb->ki_ctx;
-	struct aio_ring_info	*info = &ctx->ring_info;
+	struct aio_ring_info	*info;
 	struct aio_ring	*ring;
 	struct io_event	*event;
 	unsigned long	flags;
 	unsigned long	tail;
 	int		ret;
+
+	/* Special case handling for sync iocbs: events go directly
+	 * into the iocb for fast handling.  Note that this will not 
+	 * work if we allow sync kiocbs to be cancelled. in which
+	 * case the usage count checks will have to move under ctx_lock
+	 * for all cases.
+	 */
+	if (ctx == &ctx->mm->default_kioctx) {
+		int ret;
+
+		iocb->ki_user_data = res;
+		if (iocb->ki_users == 1) {
+			iocb->ki_users = 0;
+			return 1;
+		}
+		spin_lock_irq(&ctx->ctx_lock);
+		iocb->ki_users--;
+		ret = (0 == iocb->ki_users);
+		spin_unlock_irq(&ctx->ctx_lock);
+		return 0;
+	}
+
+	info = &ctx->ring_info;
 
 	/* add a completion event to the ring buffer.
 	 * must be done holding ctx->ctx_lock to prevent
diff -Nru a/include/linux/aio.h b/include/linux/aio.h
--- a/include/linux/aio.h	Fri Sep 13 00:46:54 2002
+++ b/include/linux/aio.h	Fri Sep 13 00:46:54 2002
@@ -1,7 +1,6 @@
 #ifndef __LINUX__AIO_H
 #define __LINUX__AIO_H
 
-#include <linux/tqueue.h>
 #include <linux/list.h>
 #include <asm/atomic.h>
 
@@ -21,10 +20,14 @@
 #define KIOCB_C_CANCELLED	0x01
 #define KIOCB_C_COMPLETE	0x02
 
+#define KIOCB_SYNC_KEY		(~0U)
+
 #define KIOCB_PRIVATE_SIZE	(16 * sizeof(long))
 
 struct kiocb {
 	int			ki_users;
+	unsigned		ki_key;		/* id of this request */
+
 	struct file		*ki_filp;
 	struct kioctx		*ki_ctx;	/* may be NULL for sync ops */
 	int			(*ki_cancel)(struct kiocb *, struct io_event *);
@@ -34,17 +37,19 @@
 	void			*ki_data;	/* for use by the the file */
 	void			*ki_user_obj;	/* pointer to userland's iocb */
 	__u64			ki_user_data;	/* user's data for completion */
-	unsigned		ki_key;		/* id of this request */
 
 	long			private[KIOCB_PRIVATE_SIZE/sizeof(long)];
 };
 
-#define init_sync_kiocb(x, filp)	\
-	do {				\
-		(x)->ki_users = 1;	\
-		(x)->ki_filp = (filp);	\
-		(x)->ki_ctx = 0;	\
-		(x)->ki_cancel = NULL;	\
+#define init_sync_kiocb(x, filp)			\
+	do {						\
+		struct task_struct *tsk = current;	\
+		(x)->ki_users = 1;			\
+		(x)->ki_key = KIOCB_SYNC_KEY;		\
+		(x)->ki_filp = (filp);			\
+		(x)->ki_ctx = &tsk->active_mm->default_kioctx;	\
+		(x)->ki_cancel = NULL;			\
+		(x)->ki_user_obj = tsk;			\
 	} while (0)
 
 #define AIO_RING_MAGIC			0xa10a10a1
@@ -105,6 +110,7 @@
 /* prototypes */
 extern unsigned aio_max_size;
 
+extern ssize_t FASTCALL(wait_on_sync_kiocb(struct kiocb *iocb));
 extern int FASTCALL(aio_put_req(struct kiocb *iocb));
 extern int FASTCALL(aio_complete(struct kiocb *iocb, long res, long res2));
 extern void FASTCALL(__put_ioctx(struct kioctx *ctx));
diff -Nru a/include/linux/init_task.h b/include/linux/init_task.h
--- a/include/linux/init_task.h	Fri Sep 13 00:46:54 2002
+++ b/include/linux/init_task.h	Fri Sep 13 00:46:54 2002
@@ -18,15 +18,29 @@
 	.fd_array	= { NULL, } 			\
 }
 
+#define INIT_KIOCTX(name, which_mm) \
+{							\
+	.users		= ATOMIC_INIT(1),		\
+	.dead		= 0,				\
+	.mm		= &which_mm,			\
+	.user_id	= 0,				\
+	.next		= NULL,				\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER(name.wait), \
+	.ctx_lock	= SPIN_LOCK_UNLOCKED,		\
+	.reqs_active	= 0U,				\
+	.max_reqs	= ~0U,				\
+}
+
 #define INIT_MM(name) \
-{			 				\
-	.mm_rb		= RB_ROOT,			\
-	.pgd		= swapper_pg_dir, 		\
-	.mm_users	= ATOMIC_INIT(2), 		\
-	.mm_count	= ATOMIC_INIT(1), 		\
-	.mmap_sem	= __RWSEM_INITIALIZER(name.mmap_sem), \
-	.page_table_lock =  SPIN_LOCK_UNLOCKED, 	\
-	.mmlist		= LIST_HEAD_INIT(name.mmlist),	\
+{			 					\
+	.mm_rb		= RB_ROOT,				\
+	.pgd		= swapper_pg_dir, 			\
+	.mm_users	= ATOMIC_INIT(2), 			\
+	.mm_count	= ATOMIC_INIT(1), 			\
+	.mmap_sem	= __RWSEM_INITIALIZER(name.mmap_sem),	\
+	.page_table_lock =  SPIN_LOCK_UNLOCKED, 		\
+	.mmlist		= LIST_HEAD_INIT(name.mmlist),		\
+	.default_kioctx = INIT_KIOCTX(name.default_kioctx, name),	\
 }
 
 #define INIT_SIGNALS(sig) {	\
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Fri Sep 13 00:46:54 2002
+++ b/include/linux/sched.h	Fri Sep 13 00:46:54 2002
@@ -170,7 +170,8 @@
 /* Maximum number of active map areas.. This is a random (large) number */
 #define MAX_MAP_COUNT	(65536)
 
-struct kioctx;
+#include <linux/aio.h>
+
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
 	rb_root_t mm_rb;
@@ -203,6 +204,8 @@
 	/* aio bits */
 	rwlock_t		ioctx_list_lock;
 	struct kioctx		*ioctx_list;
+
+	struct kioctx		default_kioctx;
 };
 
 extern int mmlist_nr;
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Fri Sep 13 00:46:54 2002
+++ b/kernel/fork.c	Fri Sep 13 00:46:54 2002
@@ -299,12 +299,16 @@
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, SLAB_KERNEL))
 #define free_mm(mm)	(kmem_cache_free(mm_cachep, (mm)))
 
+#include <linux/init_task.h>
+
 static struct mm_struct * mm_init(struct mm_struct * mm)
 {
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
 	init_rwsem(&mm->mmap_sem);
 	mm->page_table_lock = SPIN_LOCK_UNLOCKED;
+	mm->ioctx_list_lock = RW_LOCK_UNLOCKED;
+	mm->default_kioctx = (struct kioctx)INIT_KIOCTX(mm->default_kioctx, *mm);
 	mm->pgd = pgd_alloc(mm);
 	if (mm->pgd)
 		return mm;
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Fri Sep 13 00:46:54 2002
+++ b/mm/filemap.c	Fri Sep 13 00:46:54 2002
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
+#include <linux/aio.h>
 #include <linux/kernel_stat.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
@@ -1122,8 +1123,9 @@
  * that can use the page cache directly.
  */
 ssize_t
-generic_file_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
+generic_file_aio_read(struct kiocb *iocb, char *buf, size_t count, loff_t *ppos)
 {
+	struct file *filp = iocb->ki_filp;
 	ssize_t retval;
 
 	if ((ssize_t) count < 0)
@@ -1171,6 +1173,19 @@
 	}
 out:
 	return retval;
+}
+
+ssize_t
+generic_file_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
+{
+	struct kiocb kiocb;
+	ssize_t ret;
+
+	init_sync_kiocb(&kiocb, filp);
+	ret = generic_file_aio_read(&kiocb, buf, count, ppos);
+	if (-EIOCBQUEUED == ret)
+		ret = wait_on_sync_kiocb(&kiocb);
+	return ret;
 }
 
 static int file_send_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
