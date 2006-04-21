Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWDUEsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWDUEsE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWDUEoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:12674 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932251AbWDUEoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:17 -0400
Date: Thu, 20 Apr 2006 21:39:20 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 18/22] Fix file lookup without ref
Message-ID: <20060421043920.GO12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-file-lookup-without-ref.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dipankar Sarma <dipankar@in.ibm.com>

[PATCH] Fix file lookup without ref

There are places in the kernel where we look up files in fd tables and
access the file structure without holding refereces to the file.  So, we
need special care to avoid the race between looking up files in the fd
table and tearing down of the file in another CPU.  Otherwise, one might
see a NULL f_dentry or such torn down version of the file.  This patch
fixes those special places where such a race may happen.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
Acked-by: "Paul E. McKenney" <paulmck@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/char/tty_io.c |    8 ++++++--
 fs/locks.c            |    9 +++++++--
 fs/proc/base.c        |   21 +++++++++++++++------
 3 files changed, 28 insertions(+), 10 deletions(-)

--- linux-2.6.16.9.orig/drivers/char/tty_io.c
+++ linux-2.6.16.9/drivers/char/tty_io.c
@@ -2706,7 +2706,11 @@ static void __do_SAK(void *arg)
 		}
 		task_lock(p);
 		if (p->files) {
-			rcu_read_lock();
+			/*
+			 * We don't take a ref to the file, so we must
+			 * hold ->file_lock instead.
+			 */
+			spin_lock(&p->files->file_lock);
 			fdt = files_fdtable(p->files);
 			for (i=0; i < fdt->max_fds; i++) {
 				filp = fcheck_files(p->files, i);
@@ -2721,7 +2725,7 @@ static void __do_SAK(void *arg)
 					break;
 				}
 			}
-			rcu_read_unlock();
+			spin_unlock(&p->files->file_lock);
 		}
 		task_unlock(p);
 	} while_each_task_pid(session, PIDTYPE_SID, p);
--- linux-2.6.16.9.orig/fs/locks.c
+++ linux-2.6.16.9/fs/locks.c
@@ -2212,7 +2212,12 @@ void steal_locks(fl_owner_t from)
 
 	lock_kernel();
 	j = 0;
-	rcu_read_lock();
+
+	/*
+	 * We are not taking a ref to the file structures, so
+	 * we need to acquire ->file_lock.
+	 */
+	spin_lock(&files->file_lock);
 	fdt = files_fdtable(files);
 	for (;;) {
 		unsigned long set;
@@ -2230,7 +2235,7 @@ void steal_locks(fl_owner_t from)
 			set >>= 1;
 		}
 	}
-	rcu_read_unlock();
+	spin_unlock(&files->file_lock);
 	unlock_kernel();
 }
 EXPORT_SYMBOL(steal_locks);
--- linux-2.6.16.9.orig/fs/proc/base.c
+++ linux-2.6.16.9/fs/proc/base.c
@@ -294,16 +294,20 @@ static int proc_fd_link(struct inode *in
 
 	files = get_files_struct(task);
 	if (files) {
-		rcu_read_lock();
+		/*
+		 * We are not taking a ref to the file structure, so we must
+		 * hold ->file_lock.
+		 */
+		spin_lock(&files->file_lock);
 		file = fcheck_files(files, fd);
 		if (file) {
 			*mnt = mntget(file->f_vfsmnt);
 			*dentry = dget(file->f_dentry);
-			rcu_read_unlock();
+			spin_unlock(&files->file_lock);
 			put_files_struct(files);
 			return 0;
 		}
-		rcu_read_unlock();
+		spin_unlock(&files->file_lock);
 		put_files_struct(files);
 	}
 	return -ENOENT;
@@ -1485,7 +1489,12 @@ static struct dentry *proc_lookupfd(stru
 	if (!files)
 		goto out_unlock;
 	inode->i_mode = S_IFLNK;
-	rcu_read_lock();
+
+	/*
+	 * We are not taking a ref to the file structure, so we must
+	 * hold ->file_lock.
+	 */
+	spin_lock(&files->file_lock);
 	file = fcheck_files(files, fd);
 	if (!file)
 		goto out_unlock2;
@@ -1493,7 +1502,7 @@ static struct dentry *proc_lookupfd(stru
 		inode->i_mode |= S_IRUSR | S_IXUSR;
 	if (file->f_mode & 2)
 		inode->i_mode |= S_IWUSR | S_IXUSR;
-	rcu_read_unlock();
+	spin_unlock(&files->file_lock);
 	put_files_struct(files);
 	inode->i_op = &proc_pid_link_inode_operations;
 	inode->i_size = 64;
@@ -1503,7 +1512,7 @@ static struct dentry *proc_lookupfd(stru
 	return NULL;
 
 out_unlock2:
-	rcu_read_unlock();
+	spin_unlock(&files->file_lock);
 	put_files_struct(files);
 out_unlock:
 	iput(inode);

--
