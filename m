Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbWACXgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbWACXgc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbWACX27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:28:59 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:62141 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965084AbWACX2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:28:53 -0500
Message-ID: <43BB08A4.8070801@watson.ibm.com>
Date: Tue, 03 Jan 2006 23:28:36 +0000
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       LSE <lse-tech@lists.sourceforge.net>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: [Patch 3/6] Delay accounting: Sync block I/O delays
References: <43BB05D8.6070101@watson.ibm.com>
In-Reply-To: <43BB05D8.6070101@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since 12/7/05

- removed __attribute((unused)) qualifiers from timespec vars (dave hansen)
- use existing timestamping function do_posix_clock_monotonic_gettime() (jay lan)

Changes since 11/14/05

- use nanosecond resolution, adjusted wall clock time for timestamps
  instead of sched_clock (akpm, andi, marcelo)
- collect stats only if delay accounting enabled (parag)
- stats collected for delays in all userspace-initiated block I/O
including fsync/fdatasync but not counting waits for async block io events.

11/14/05: First post


delayacct-blkio.patch

Record time spent by a task waiting for completion of
userspace initiated synchronous block I/O. This can help
determine the right I/O priority for the task.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 fs/buffer.c               |    6 ++++++
 fs/read_write.c           |   10 +++++++++-
 include/linux/delayacct.h |    4 ++++
 include/linux/sched.h     |    2 ++
 kernel/delayacct.c        |   16 ++++++++++++++++
 mm/filemap.c              |   10 +++++++++-
 mm/memory.c               |   17 +++++++++++++++--
 7 files changed, 61 insertions(+), 4 deletions(-)

Index: linux-2.6.15-rc7/include/linux/sched.h
===================================================================
--- linux-2.6.15-rc7.orig/include/linux/sched.h
+++ linux-2.6.15-rc7/include/linux/sched.h
@@ -546,6 +546,8 @@ struct task_delay_info {
 	spinlock_t	lock;

 	/* Add stats in pairs: uint64_t delay, uint32_t count */
+	uint64_t blkio_delay;	/* wait for sync block io completion */
+	uint32_t blkio_count;
 };
 #endif

Index: linux-2.6.15-rc7/fs/read_write.c
===================================================================
--- linux-2.6.15-rc7.orig/fs/read_write.c
+++ linux-2.6.15-rc7/fs/read_write.c
@@ -14,6 +14,8 @@
 #include <linux/security.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
+#include <linux/time.h>
+#include <linux/delayacct.h>

 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -224,8 +226,14 @@ ssize_t do_sync_read(struct file *filp,
 		(ret = filp->f_op->aio_read(&kiocb, buf, len, kiocb.ki_pos)))
 		wait_on_retry_sync_kiocb(&kiocb);

-	if (-EIOCBQUEUED == ret)
+	if (-EIOCBQUEUED == ret) {
+		struct timespec start, end;
+
+		do_posix_clock_monotonic_gettime(&start);
 		ret = wait_on_sync_kiocb(&kiocb);
+		do_posix_clock_monotonic_gettime(&end);
+		delayacct_blkio(&start, &end);
+	}
 	*ppos = kiocb.ki_pos;
 	return ret;
 }
Index: linux-2.6.15-rc7/mm/filemap.c
===================================================================
--- linux-2.6.15-rc7.orig/mm/filemap.c
+++ linux-2.6.15-rc7/mm/filemap.c
@@ -28,6 +28,8 @@
 #include <linux/blkdev.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/time.h>
+#include <linux/delayacct.h>
 #include "filemap.h"
 /*
  * FIXME: remove all knowledge of the buffer layer from the core VM
@@ -1062,8 +1064,14 @@ generic_file_read(struct file *filp, cha

 	init_sync_kiocb(&kiocb, filp);
 	ret = __generic_file_aio_read(&kiocb, &local_iov, 1, ppos);
-	if (-EIOCBQUEUED == ret)
+	if (-EIOCBQUEUED == ret) {
+		struct timespec start, end;
+
+		do_posix_clock_monotonic_gettime(&start);
 		ret = wait_on_sync_kiocb(&kiocb);
+		do_posix_clock_monotonic_gettime(&end);
+		delayacct_blkio(&start, &end);
+	}
 	return ret;
 }

Index: linux-2.6.15-rc7/mm/memory.c
===================================================================
--- linux-2.6.15-rc7.orig/mm/memory.c
+++ linux-2.6.15-rc7/mm/memory.c
@@ -48,6 +48,8 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/time.h>
+#include <linux/delayacct.h>

 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -2170,11 +2172,22 @@ static inline int handle_pte_fault(struc
 	old_entry = entry = *pte;
 	if (!pte_present(entry)) {
 		if (pte_none(entry)) {
+			int ret;
+			struct timespec start, end;
+
 			if (!vma->vm_ops || !vma->vm_ops->nopage)
 				return do_anonymous_page(mm, vma, address,
 					pte, pmd, write_access);
-			return do_no_page(mm, vma, address,
-					pte, pmd, write_access);
+
+			if (vma->vm_file)
+				do_posix_clock_monotonic_gettime(&start);
+			ret = do_no_page(mm, vma, address,
+					 pte, pmd, write_access);
+			if (vma->vm_file) {
+				do_posix_clock_monotonic_gettime(&end);
+				delayacct_blkio(&start, &end);
+			}
+			return ret;
 		}
 		if (pte_file(entry))
 			return do_file_page(mm, vma, address,
Index: linux-2.6.15-rc7/fs/buffer.c
===================================================================
--- linux-2.6.15-rc7.orig/fs/buffer.c
+++ linux-2.6.15-rc7/fs/buffer.c
@@ -41,6 +41,8 @@
 #include <linux/bitops.h>
 #include <linux/mpage.h>
 #include <linux/bit_spinlock.h>
+#include <linux/time.h>
+#include <linux/delayacct.h>

 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static void invalidate_bh_lrus(void);
@@ -337,6 +339,7 @@ static long do_fsync(unsigned int fd, in
 	struct file * file;
 	struct address_space *mapping;
 	int ret, err;
+	struct timespec start, end;

 	ret = -EBADF;
 	file = fget(fd);
@@ -349,6 +352,7 @@ static long do_fsync(unsigned int fd, in
 		goto out_putf;
 	}

+	do_posix_clock_monotonic_gettime(&start);
 	mapping = file->f_mapping;

 	current->flags |= PF_SYNCWRITE;
@@ -371,6 +375,8 @@ static long do_fsync(unsigned int fd, in
 out_putf:
 	fput(file);
 out:
+	do_posix_clock_monotonic_gettime(&end);
+	delayacct_blkio(&start, &end);
 	return ret;
 }

Index: linux-2.6.15-rc7/include/linux/delayacct.h
===================================================================
--- linux-2.6.15-rc7.orig/include/linux/delayacct.h
+++ linux-2.6.15-rc7/include/linux/delayacct.h
@@ -19,8 +19,12 @@
 #ifdef CONFIG_TASK_DELAY_ACCT
 extern int delayacct_on;	/* Delay accounting turned on/off */
 extern void delayacct_tsk_init(struct task_struct *tsk);
+extern void delayacct_blkio(struct timespec *start, struct timespec *end);
 #else
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {}
+static inline void delayacct_blkio(struct timespec *start, struct timespec *end)
+{}
+
 #endif /* CONFIG_TASK_DELAY_ACCT */
 #endif /* _LINUX_TASKDELAYS_H */
Index: linux-2.6.15-rc7/kernel/delayacct.c
===================================================================
--- linux-2.6.15-rc7.orig/kernel/delayacct.c
+++ linux-2.6.15-rc7/kernel/delayacct.c
@@ -12,6 +12,7 @@
  */

 #include <linux/sched.h>
+#include <linux/time.h>

 int delayacct_on=1;	/* Delay accounting turned on/off */

@@ -34,3 +35,18 @@ static int __init delayacct_init(void)
 	return 0;
 }
 core_initcall(delayacct_init);
+
+inline void delayacct_blkio(struct timespec *start, struct timespec *end)
+{
+	unsigned long long delay;
+
+	if (!delayacct_on)
+		return;
+
+	delay = timespec_diff_ns(start, end);
+
+	spin_lock(&current->delays.lock);
+	current->delays.blkio_delay += delay;
+	current->delays.blkio_count++;
+	spin_unlock(&current->delays.lock);
+}
