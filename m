Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264197AbTCXN2e>; Mon, 24 Mar 2003 08:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264212AbTCXN2e>; Mon, 24 Mar 2003 08:28:34 -0500
Received: from bi-01pt1.bluebird.ibm.com ([129.42.208.186]:58640 "EHLO
	bigbang.in.ibm.com") by vger.kernel.org with ESMTP
	id <S264197AbTCXN2a>; Mon, 24 Mar 2003 08:28:30 -0500
Date: Mon, 24 Mar 2003 19:11:35 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: Deadlock between tasklist_lock and dcache_lock
Message-ID: <20030324134134.GB2026@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <Pine.LNX.4.44.0303231818530.3908-100000@dbl.q-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303231818530.3908-100000@dbl.q-ag.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 05:30:39PM +0000, Manfred Spraul wrote:
> __unhash_process acquires the dcache_lock while holding the tasklist_lock 
> for writing. AFAICS this can deadlock:
> 
> CPU1:
> 	[ in release_task() ]
> 	write_lock_irq(&tasklist_lock);
> 	__unhash_process()
> 	
> CPU2:
> 	spin_lock(&dcache_lock);
> 	<interrupt>
> 	read_lock(&tasklist_lock);, // e.g. for signal delivery
> 	** spins, lock held by cpu 1 for writing.
> 
> CPU1:
> 	[ within __unhash_process() ]
> 	spin_lock(&dcache_lock);
> 	** spins, lock held by CPU2
> 
> Probably the callers of __unhash_process must acquire the dcache_lock 
> before write_lock_irq(&tasklist_lock).
> 
> Any other ideas how to fix the deadlock?
> --
> 	Manfred

Hello Manfred, Andrew

How is the patch below?.. just some re-arrangement of code. I don't think
we need task_list lock while cleaning up the proc_dentry.

Same problem is there in fs/exec.c:de_thread(). So this is a common solution.

The patch does following things:
0. brings cleaning up of proc_dentry outside tasklist_lock protection.
1. gets rid of code duplication in __unhash_process() and clean_proc_dentry()
2. combines clean_proc_dentry() and put_proc_dentry()
3. makes clean_proc_dentry() extern

fs/exec.c               |   31 +++++++++++++------------------
include/linux/proc_fs.h |    1 +
kernel/exit.c           |   28 ++++++++--------------------
3 files changed, 22 insertions(+), 38 deletions(-)

diff -urN linux-2.5.65-base/fs/exec.c linux-2.5.65-unhash_process/fs/exec.c
--- linux-2.5.65-base/fs/exec.c	2003-03-18 03:14:03.000000000 +0530
+++ linux-2.5.65-unhash_process/fs/exec.c	2003-03-24 16:49:30.000000000 +0530
@@ -529,27 +529,20 @@
 	return 0;
 }
 
-static struct dentry *clean_proc_dentry(struct task_struct *p)
+void clean_proc_dentry(struct dentry * proc_dentry)
 {
-	struct dentry *proc_dentry = p->proc_dentry;
 
 	if (proc_dentry) {
 		spin_lock(&dcache_lock);
 		if (!d_unhashed(proc_dentry)) {
 			dget_locked(proc_dentry);
 			__d_drop(proc_dentry);
-		} else
-			proc_dentry = NULL;
-		spin_unlock(&dcache_lock);
-	}
-	return proc_dentry;
-}
-
-static inline void put_proc_dentry(struct dentry *dentry)
-{
-	if (dentry) {
-		shrink_dcache_parent(dentry);
-		dput(dentry);
+			spin_unlock(&dcache_lock);
+			shrink_dcache_parent(proc_dentry);
+			dput(proc_dentry);
+		}
+		else
+			spin_unlock(&dcache_lock);
 	}
 }
 
@@ -661,8 +654,8 @@
 			yield();
 
 		write_lock_irq(&tasklist_lock);
-		proc_dentry1 = clean_proc_dentry(current);
-		proc_dentry2 = clean_proc_dentry(leader);
+		proc_dentry1 = current->proc_dentry;
+		proc_dentry2 = leader->proc_dentry;
 
 		if (leader->tgid != current->tgid)
 			BUG();
@@ -703,8 +696,10 @@
 
 		write_unlock_irq(&tasklist_lock);
 
-		put_proc_dentry(proc_dentry1);
-		put_proc_dentry(proc_dentry2);
+		if (proc_dentry1)
+			clean_proc_dentry(proc_dentry1);
+		if (proc_dentry2)
+			clean_proc_dentry(proc_dentry2);
 
 		if (state != TASK_ZOMBIE)
 			BUG();
diff -urN linux-2.5.65-base/include/linux/proc_fs.h linux-2.5.65-unhash_process/include/linux/proc_fs.h
--- linux-2.5.65-base/include/linux/proc_fs.h	2003-03-18 03:13:37.000000000 +0530
+++ linux-2.5.65-unhash_process/include/linux/proc_fs.h	2003-03-24 16:47:10.000000000 +0530
@@ -224,4 +224,5 @@
 	return PROC_I(inode)->pde;
 }
 
+extern void clean_proc_dentry(struct dentry *proc_dentry);
 #endif /* _LINUX_PROC_FS_H */
diff -urN linux-2.5.65-base/kernel/exit.c linux-2.5.65-unhash_process/kernel/exit.c
--- linux-2.5.65-base/kernel/exit.c	2003-03-18 03:14:43.000000000 +0530
+++ linux-2.5.65-unhash_process/kernel/exit.c	2003-03-24 16:46:40.000000000 +0530
@@ -21,6 +21,7 @@
 #include <linux/ptrace.h>
 #include <linux/profile.h>
 #include <linux/mount.h>
+#include <linux/proc_fs.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -33,7 +34,6 @@
 
 static struct dentry * __unhash_process(struct task_struct *p)
 {
-	struct dentry *proc_dentry;
 
 	nr_threads--;
 	detach_pid(p, PIDTYPE_PID);
@@ -46,17 +46,8 @@
 	}
 
 	REMOVE_LINKS(p);
-	proc_dentry = p->proc_dentry;
-	if (unlikely(proc_dentry != NULL)) {
-		spin_lock(&dcache_lock);
-		if (!d_unhashed(proc_dentry)) {
-			dget_locked(proc_dentry);
-			__d_drop(proc_dentry);
-		} else
-			proc_dentry = NULL;
-		spin_unlock(&dcache_lock);
-	}
-	return proc_dentry;
+
+	return p->proc_dentry;
 }
 
 void release_task(struct task_struct * p)
@@ -93,10 +84,9 @@
 	sched_exit(p);
 	write_unlock_irq(&tasklist_lock);
 
-	if (unlikely(proc_dentry != NULL)) {
-		shrink_dcache_parent(proc_dentry);
-		dput(proc_dentry);
-	}
+	if (unlikely(proc_dentry != NULL))
+		clean_proc_dentry(proc_dentry);
+
 	release_thread(p);
 	put_task_struct(p);
 }
@@ -111,10 +101,8 @@
 	proc_dentry = __unhash_process(p);
 	write_unlock_irq(&tasklist_lock);
 
-	if (unlikely(proc_dentry != NULL)) {
-		shrink_dcache_parent(proc_dentry);
-		dput(proc_dentry);
-	}
+	if (unlikely(proc_dentry != NULL)) 
+		clean_proc_dentry(proc_dentry);
 }
 
 /*

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
