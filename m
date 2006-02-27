Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751683AbWB0IUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbWB0IUv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWB0IUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:20:51 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:36485 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751097AbWB0IUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:20:50 -0500
Subject: [Patch 5/7]  synchronous block I/O delays
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <1141026996.5785.38.camel@elinux04.optonline.net>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
Content-Type: text/plain
Organization: IBM
Message-Id: <1141028448.5785.64.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 27 Feb 2006 03:20:49 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-blkio.patch

Record time spent by a task waiting for completion of 
userspace initiated synchronous block I/O. This can help
determine the right I/O priority for the task.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 fs/buffer.c               |    3 +++
 fs/read_write.c           |    5 ++++-
 include/linux/delayacct.h |    8 ++++++++
 include/linux/sched.h     |    2 ++
 kernel/delayacct.c        |   14 ++++++++++++++
 mm/filemap.c              |    5 ++++-
 mm/memory.c               |    8 +++++++-
 7 files changed, 42 insertions(+), 3 deletions(-)

Index: linux-2.6.16-rc4/include/linux/delayacct.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/delayacct.h	2006-02-27 01:52:56.000000000 -0500
+++ linux-2.6.16-rc4/include/linux/delayacct.h	2006-02-27 01:52:59.000000000 -0500
@@ -25,6 +25,7 @@ int delayacct_sysctl_handler(ctl_table *
 extern int delayacct_init(void);
 extern void __delayacct_tsk_init(struct task_struct *);
 extern void __delayacct_tsk_exit(struct task_struct *);
+extern void __delayacct_blkio(void);
 
 static inline void delayacct_tsk_early_init(struct task_struct *tsk)
 {
@@ -48,6 +49,11 @@ static inline void delayacct_timestamp_s
 	if (unlikely(current->delays && delayacct_on))
 		do_posix_clock_monotonic_gettime(&current->delays->start);
 }
+static inline void delayacct_blkio(void)
+{
+	if (unlikely(current->delays && delayacct_on))
+		__delayacct_blkio();
+}
 #else
 static inline void delayacct_tsk_early_init(struct task_struct *tsk)
 {}
@@ -57,6 +63,8 @@ static inline void delayacct_tsk_exit(st
 {}
 static inline void delayacct_timestamp_start(void)
 {}
+static inline void delayacct_blkio(void)
+{}
 static inline int delayacct_init(void)
 {}
 #endif /* CONFIG_TASK_DELAY_ACCT */
Index: linux-2.6.16-rc4/kernel/delayacct.c
===================================================================
--- linux-2.6.16-rc4.orig/kernel/delayacct.c	2006-02-27 01:52:56.000000000 -0500
+++ linux-2.6.16-rc4/kernel/delayacct.c	2006-02-27 01:52:59.000000000 -0500
@@ -78,6 +78,20 @@ static inline nsec_t delayacct_measure(v
 	return timespec_diff_ns(&current->delays->start, &current->delays->end);
 }
 
+void __delayacct_blkio(void)
+{
+	nsec_t delay;
+
+	delay = delayacct_measure();
+	if (delay < 0)
+		return;
+
+	spin_lock(&current->delays->lock);
+	current->delays->blkio_delay += delay;
+	current->delays->blkio_count++;
+	spin_unlock(&current->delays->lock);
+}
+
 /* Allocate task_delay_info for all tasks without one */
 static int alloc_delays(void)
 {
Index: linux-2.6.16-rc4/fs/buffer.c
===================================================================
--- linux-2.6.16-rc4.orig/fs/buffer.c	2006-02-27 01:20:01.000000000 -0500
+++ linux-2.6.16-rc4/fs/buffer.c	2006-02-27 01:52:59.000000000 -0500
@@ -42,6 +42,7 @@
 #include <linux/bitops.h>
 #include <linux/mpage.h>
 #include <linux/bit_spinlock.h>
+#include <linux/delayacct.h>
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static void invalidate_bh_lrus(void);
@@ -344,6 +345,7 @@ static long do_fsync(unsigned int fd, in
 		goto out_putf;
 	}
 
+	delayacct_timestamp_start();
 	mapping = file->f_mapping;
 
 	current->flags |= PF_SYNCWRITE;
@@ -366,6 +368,7 @@ static long do_fsync(unsigned int fd, in
 out_putf:
 	fput(file);
 out:
+	delayacct_blkio();
 	return ret;
 }
 
Index: linux-2.6.16-rc4/fs/read_write.c
===================================================================
--- linux-2.6.16-rc4.orig/fs/read_write.c	2006-02-27 01:20:02.000000000 -0500
+++ linux-2.6.16-rc4/fs/read_write.c	2006-02-27 01:52:59.000000000 -0500
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/syscalls.h>
 #include <linux/pagemap.h>
+#include <linux/delayacct.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -236,8 +237,10 @@ ssize_t do_sync_read(struct file *filp, 
 		(ret = filp->f_op->aio_read(&kiocb, buf, len, kiocb.ki_pos)))
 		wait_on_retry_sync_kiocb(&kiocb);
 
-	if (-EIOCBQUEUED == ret)
+	if (-EIOCBQUEUED == ret) {
+		delayacct_timestamp_start();
 		ret = wait_on_sync_kiocb(&kiocb);
+	}
 	*ppos = kiocb.ki_pos;
 	return ret;
 }
Index: linux-2.6.16-rc4/mm/filemap.c
===================================================================
--- linux-2.6.16-rc4.orig/mm/filemap.c	2006-02-27 01:20:04.000000000 -0500
+++ linux-2.6.16-rc4/mm/filemap.c	2006-02-27 01:52:59.000000000 -0500
@@ -29,6 +29,7 @@
 #include <linux/blkdev.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/delayacct.h>
 #include "filemap.h"
 /*
  * FIXME: remove all knowledge of the buffer layer from the core VM
@@ -1084,8 +1085,10 @@ generic_file_read(struct file *filp, cha
 
 	init_sync_kiocb(&kiocb, filp);
 	ret = __generic_file_aio_read(&kiocb, &local_iov, 1, ppos);
-	if (-EIOCBQUEUED == ret)
+	if (-EIOCBQUEUED == ret) {
+		delayacct_timestamp_start();
 		ret = wait_on_sync_kiocb(&kiocb);
+	}
 	return ret;
 }
 
Index: linux-2.6.16-rc4/mm/memory.c
===================================================================
--- linux-2.6.16-rc4.orig/mm/memory.c	2006-02-27 01:20:04.000000000 -0500
+++ linux-2.6.16-rc4/mm/memory.c	2006-02-27 01:52:59.000000000 -0500
@@ -48,6 +48,7 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/delayacct.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -2208,12 +2209,17 @@ static inline int handle_pte_fault(struc
 
 	old_entry = entry = *pte;
 	if (!pte_present(entry)) {
+		delayacct_timestamp_start();
 		if (pte_none(entry)) {
+			int ret;
 			if (!vma->vm_ops || !vma->vm_ops->nopage)
 				return do_anonymous_page(mm, vma, address,
 					pte, pmd, write_access);
-			return do_no_page(mm, vma, address,
+			ret = do_no_page(mm, vma, address,
 					pte, pmd, write_access);
+			if (vma->vm_file)
+				delayacct_blkio();
+			return ret;
 		}
 		if (pte_file(entry))
 			return do_file_page(mm, vma, address,
Index: linux-2.6.16-rc4/include/linux/sched.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/sched.h	2006-02-27 01:52:54.000000000 -0500
+++ linux-2.6.16-rc4/include/linux/sched.h	2006-02-27 01:52:59.000000000 -0500
@@ -551,6 +551,8 @@ struct task_delay_info {
 	struct timespec start, end;
 
 	/* Add stats in pairs: u64 delay, u32 count, aligned properly */
+	u64 blkio_delay;	/* wait for sync block io completion */
+	u32 blkio_count;
 };
 #endif
 


