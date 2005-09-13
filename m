Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbVIMTQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbVIMTQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbVIMTQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:16:49 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:57736 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965149AbVIMTQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:16:48 -0400
Date: Wed, 14 Sep 2005 00:41:17 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.14-rc1] files: fix preemption issues
Message-ID: <20050913191117.GF4612@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did a review of the existing lock-free fdtable code and found
a few places that needed fixes for working correctly with preemption.
Never had a problem while testing, but theoritically they are possible.
This patch fixes those. I have tested this patch with some combinations
of dbench, kernbench and ltp on x86, ppc64 and x86_64 with both
preemption on and off.

Thanks
Dipankar



With the new fdtable locking rules, you have to protect
fdtable with either ->file_lock or rcu_read_lock/unlock().
There are some places where we aren't doing either. This
patch fixes those places.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
--


 arch/alpha/kernel/osf_sys.c |    8 +++++++-
 arch/ia64/kernel/perfmon.c  |    3 ++-
 fs/locks.c                  |    3 +++
 fs/proc/array.c             |    3 +++
 kernel/exit.c               |    6 ++++++
 5 files changed, 21 insertions(+), 2 deletions(-)

diff -puN arch/alpha/kernel/osf_sys.c~files-preemption-fixes arch/alpha/kernel/osf_sys.c
--- linux-2.6.14-rc1-fd/arch/alpha/kernel/osf_sys.c~files-preemption-fixes	2005-09-13 17:12:58.000000000 +0530
+++ linux-2.6.14-rc1-fd-dipankar/arch/alpha/kernel/osf_sys.c	2005-09-13 17:12:58.000000000 +0530
@@ -37,6 +37,7 @@
 #include <linux/namei.h>
 #include <linux/uio.h>
 #include <linux/vfs.h>
+#include <linux/rcupdate.h>
 
 #include <asm/fpu.h>
 #include <asm/io.h>
@@ -975,6 +976,7 @@ osf_select(int n, fd_set __user *inp, fd
 	long timeout;
 	int ret = -EINVAL;
 	struct fdtable *fdt;
+	int max_fdset;
 
 	timeout = MAX_SCHEDULE_TIMEOUT;
 	if (tvp) {
@@ -996,9 +998,13 @@ osf_select(int n, fd_set __user *inp, fd
 		}
 	}
 
+	rcu_read_lock();
 	fdt = files_fdtable(current->files);
-	if (n < 0 || n > fdt->max_fdset)
+	max_fdset = fdt->max_fdset;
+	rcu_read_unlock();
+	if (n < 0 || n > max_fdset) {
 		goto out_nofds;
+	}
 
 	/*
 	 * We need 6 bitmaps (in/out/ex for both incoming and outgoing),
diff -puN fs/locks.c~files-preemption-fixes fs/locks.c
--- linux-2.6.14-rc1-fd/fs/locks.c~files-preemption-fixes	2005-09-13 17:12:58.000000000 +0530
+++ linux-2.6.14-rc1-fd-dipankar/fs/locks.c	2005-09-13 17:12:58.000000000 +0530
@@ -124,6 +124,7 @@
 #include <linux/smp_lock.h>
 #include <linux/syscalls.h>
 #include <linux/time.h>
+#include <linux/rcupdate.h>
 
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
@@ -2205,6 +2206,7 @@ void steal_locks(fl_owner_t from)
 
 	lock_kernel();
 	j = 0;
+	rcu_read_lock();
 	fdt = files_fdtable(files);
 	for (;;) {
 		unsigned long set;
@@ -2222,6 +2224,7 @@ void steal_locks(fl_owner_t from)
 			set >>= 1;
 		}
 	}
+	rcu_read_unlock();
 	unlock_kernel();
 }
 EXPORT_SYMBOL(steal_locks);
diff -puN kernel/exit.c~files-preemption-fixes kernel/exit.c
--- linux-2.6.14-rc1-fd/kernel/exit.c~files-preemption-fixes	2005-09-13 17:12:58.000000000 +0530
+++ linux-2.6.14-rc1-fd-dipankar/kernel/exit.c	2005-09-13 17:12:58.000000000 +0530
@@ -371,6 +371,12 @@ static inline void close_files(struct fi
 	struct fdtable *fdt;
 
 	j = 0;
+
+	/*
+	 * It is safe to dereference the fd table without RCU or
+	 * ->file_lock because this is the last reference to the
+	 * files structure.
+	 */
 	fdt = files_fdtable(files);
 	for (;;) {
 		unsigned long set;
diff -puN fs/proc/array.c~files-preemption-fixes fs/proc/array.c
--- linux-2.6.14-rc1-fd/fs/proc/array.c~files-preemption-fixes	2005-09-13 17:12:58.000000000 +0530
+++ linux-2.6.14-rc1-fd-dipankar/fs/proc/array.c	2005-09-14 00:07:57.000000000 +0530
@@ -74,6 +74,7 @@
 #include <linux/file.h>
 #include <linux/times.h>
 #include <linux/cpuset.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -180,12 +181,14 @@ static inline char * task_state(struct t
 		p->gid, p->egid, p->sgid, p->fsgid);
 	read_unlock(&tasklist_lock);
 	task_lock(p);
+	rcu_read_lock();
 	if (p->files)
 		fdt = files_fdtable(p->files);
 	buffer += sprintf(buffer,
 		"FDSize:\t%d\n"
 		"Groups:\t",
 		fdt ? fdt->max_fds : 0);
+	rcu_read_unlock();
 
 	group_info = p->group_info;
 	get_group_info(group_info);
diff -puN arch/ia64/kernel/perfmon.c~files-preemption-fixes arch/ia64/kernel/perfmon.c
--- linux-2.6.14-rc1-fd/arch/ia64/kernel/perfmon.c~files-preemption-fixes	2005-09-13 17:13:37.000000000 +0530
+++ linux-2.6.14-rc1-fd-dipankar/arch/ia64/kernel/perfmon.c	2005-09-13 17:14:12.000000000 +0530
@@ -2218,12 +2218,13 @@ static void
 pfm_free_fd(int fd, struct file *file)
 {
 	struct files_struct *files = current->files;
-	struct fdtable *fdt = files_fdtable(files);
+	struct fdtable *fdt;
 
 	/* 
 	 * there ie no fd_uninstall(), so we do it here
 	 */
 	spin_lock(&files->file_lock);
+	fdt = files_fdtable(files);
 	rcu_assign_pointer(fdt->fd[fd], NULL);
 	spin_unlock(&files->file_lock);
 

_
