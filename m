Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVFNOoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVFNOoT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 10:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVFNOoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 10:44:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:26790 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261251AbVFNOdq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 10:33:46 -0400
Date: Tue, 14 Jun 2005 20:01:10 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] files: lock-free fd look-up
Message-ID: <20050614143110.GF4557@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050614142612.GA4557@in.ibm.com> <20050614142735.GB4557@in.ibm.com> <20050614142818.GC4557@in.ibm.com> <20050614142928.GD4557@in.ibm.com> <20050614143019.GE4557@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614143019.GE4557@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



With the use of RCU in files structure, the look-up of files
using fds can now be lock-free. The lookup is protected
by rcu_read_lock()/rcu_read_unlock(). This patch changes
the readers to use lock-free lookup.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Ravikiran Thirumalai <kiran_th@gmail.com>
Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>


 arch/mips/kernel/irixioctl.c    |    5 +++--
 arch/sparc64/solaris/ioctl.c    |    7 ++++---
 drivers/char/tty_io.c           |    4 ++--
 fs/fcntl.c                      |    4 ++--
 fs/proc/base.c                  |   29 +++++++++++++++--------------
 fs/select.c                     |   13 ++++++++++---
 net/ipv4/netfilter/ipt_owner.c  |   17 +++++++++--------
 net/ipv6/netfilter/ip6t_owner.c |   11 ++++++-----
 security/selinux/hooks.c        |    2 +-
 9 files changed, 52 insertions(+), 40 deletions(-)

diff -puN arch/mips/kernel/irixioctl.c~lock-free-fd-lookup arch/mips/kernel/irixioctl.c
--- linux-2.6.12-rc6-fd/arch/mips/kernel/irixioctl.c~lock-free-fd-lookup	2005-06-14 14:05:06.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/arch/mips/kernel/irixioctl.c	2005-06-14 14:05:06.000000000 +0530
@@ -14,6 +14,7 @@
 #include <linux/syscalls.h>
 #include <linux/tty.h>
 #include <linux/file.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 #include <asm/ioctl.h>
@@ -33,7 +34,7 @@ static struct tty_struct *get_tty(int fd
 	struct file *filp;
 	struct tty_struct *ttyp = NULL;
 
-	spin_lock(&current->files->file_lock);
+	rcu_read_lock();
 	filp = fcheck(fd);
 	if(filp && filp->private_data) {
 		ttyp = (struct tty_struct *) filp->private_data;
@@ -41,7 +42,7 @@ static struct tty_struct *get_tty(int fd
 		if(ttyp->magic != TTY_MAGIC)
 			ttyp =NULL;
 	}
-	spin_unlock(&current->files->file_lock);
+	rcu_read_unlock();
 	return ttyp;
 }
 
diff -puN arch/sparc64/solaris/ioctl.c~lock-free-fd-lookup arch/sparc64/solaris/ioctl.c
--- linux-2.6.12-rc6-fd/arch/sparc64/solaris/ioctl.c~lock-free-fd-lookup	2005-06-14 14:05:06.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/arch/sparc64/solaris/ioctl.c	2005-06-14 14:05:06.000000000 +0530
@@ -24,6 +24,7 @@
 #include <linux/netdevice.h>
 #include <linux/mtio.h>
 #include <linux/time.h>
+#include <linux/rcupdate.h>
 #include <linux/compat.h>
 
 #include <net/sock.h>
@@ -295,16 +296,16 @@ static inline int solaris_sockmod(unsign
 	struct inode *ino;
 	struct fdtable *fdt;
 	/* I wonder which of these tests are superfluous... --patrik */
-	spin_lock(&current->files->file_lock);
+	rcu_read_lock();
 	fdt = files_fdtable(current->files);
 	if (! fdt->fd[fd] ||
 	    ! fdt->fd[fd]->f_dentry ||
 	    ! (ino = fdt->fd[fd]->f_dentry->d_inode) ||
 	    ! S_ISSOCK(ino->i_mode)) {
-		spin_unlock(&current->files->file_lock);
+		rcu_read_unlock();
 		return TBADF;
 	}
-	spin_unlock(&current->files->file_lock);
+	rcu_read_unlock();
 	
 	switch (cmd & 0xff) {
 	case 109: /* SI_SOCKPARAMS */
diff -puN drivers/char/tty_io.c~lock-free-fd-lookup drivers/char/tty_io.c
--- linux-2.6.12-rc6-fd/drivers/char/tty_io.c~lock-free-fd-lookup	2005-06-14 14:05:06.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/drivers/char/tty_io.c	2005-06-14 14:05:06.000000000 +0530
@@ -2441,7 +2441,7 @@ static void __do_SAK(void *arg)
 		}
 		task_lock(p);
 		if (p->files) {
-			spin_lock(&p->files->file_lock);
+			rcu_read_lock();
 			fdt = files_fdtable(p->files);
 			for (i=0; i < fdt->max_fds; i++) {
 				filp = fcheck_files(p->files, i);
@@ -2456,7 +2456,7 @@ static void __do_SAK(void *arg)
 					break;
 				}
 			}
-			spin_unlock(&p->files->file_lock);
+			rcu_read_unlock();
 		}
 		task_unlock(p);
 	} while_each_task_pid(session, PIDTYPE_SID, p);
diff -puN fs/fcntl.c~lock-free-fd-lookup fs/fcntl.c
--- linux-2.6.12-rc6-fd/fs/fcntl.c~lock-free-fd-lookup	2005-06-14 14:05:06.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/fs/fcntl.c	2005-06-14 14:05:06.000000000 +0530
@@ -40,10 +40,10 @@ static inline int get_close_on_exec(unsi
 	struct files_struct *files = current->files;
 	struct fdtable *fdt;
 	int res;
-	spin_lock(&files->file_lock);
+	rcu_read_lock();
 	fdt = files_fdtable(files);
 	res = FD_ISSET(fd, fdt->close_on_exec);
-	spin_unlock(&files->file_lock);
+	rcu_read_unlock();
 	return res;
 }
 
diff -puN fs/proc/base.c~lock-free-fd-lookup fs/proc/base.c
--- linux-2.6.12-rc6-fd/fs/proc/base.c~lock-free-fd-lookup	2005-06-14 14:05:06.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/fs/proc/base.c	2005-06-14 14:05:06.000000000 +0530
@@ -28,6 +28,7 @@
 #include <linux/namespace.h>
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
+#include <linux/rcupdate.h>
 #include <linux/kallsyms.h>
 #include <linux/mount.h>
 #include <linux/security.h>
@@ -236,16 +237,16 @@ static int proc_fd_link(struct inode *in
 
 	files = get_files_struct(task);
 	if (files) {
-		spin_lock(&files->file_lock);
+		rcu_read_lock();
 		file = fcheck_files(files, fd);
 		if (file) {
 			*mnt = mntget(file->f_vfsmnt);
 			*dentry = dget(file->f_dentry);
-			spin_unlock(&files->file_lock);
+			rcu_read_unlock();
 			put_files_struct(files);
 			return 0;
 		}
-		spin_unlock(&files->file_lock);
+		rcu_read_unlock();
 		put_files_struct(files);
 	}
 	return -ENOENT;
@@ -1001,7 +1002,7 @@ static int proc_readfd(struct file * fil
 			files = get_files_struct(p);
 			if (!files)
 				goto out;
-			spin_lock(&files->file_lock);
+			rcu_read_lock();
 			fdt = files_fdtable(files);
 			for (fd = filp->f_pos-2;
 			     fd < fdt->max_fds;
@@ -1010,7 +1011,7 @@ static int proc_readfd(struct file * fil
 
 				if (!fcheck_files(files, fd))
 					continue;
-				spin_unlock(&files->file_lock);
+				rcu_read_unlock();
 
 				j = NUMBUF;
 				i = fd;
@@ -1022,12 +1023,12 @@ static int proc_readfd(struct file * fil
 
 				ino = fake_ino(tid, PROC_TID_FD_DIR + fd);
 				if (filldir(dirent, buf+j, NUMBUF-j, fd+2, ino, DT_LNK) < 0) {
-					spin_lock(&files->file_lock);
+					rcu_read_lock();
 					break;
 				}
-				spin_lock(&files->file_lock);
+				rcu_read_lock();
 			}
-			spin_unlock(&files->file_lock);
+			rcu_read_unlock();
 			put_files_struct(files);
 	}
 out:
@@ -1200,9 +1201,9 @@ static int tid_fd_revalidate(struct dent
 
 	files = get_files_struct(task);
 	if (files) {
-		spin_lock(&files->file_lock);
+		rcu_read_lock();
 		if (fcheck_files(files, fd)) {
-			spin_unlock(&files->file_lock);
+			rcu_read_unlock();
 			put_files_struct(files);
 			if (task_dumpable(task)) {
 				inode->i_uid = task->euid;
@@ -1214,7 +1215,7 @@ static int tid_fd_revalidate(struct dent
 			security_task_to_inode(task, inode);
 			return 1;
 		}
-		spin_unlock(&files->file_lock);
+		rcu_read_unlock();
 		put_files_struct(files);
 	}
 	d_drop(dentry);
@@ -1306,7 +1307,7 @@ static struct dentry *proc_lookupfd(stru
 	if (!files)
 		goto out_unlock;
 	inode->i_mode = S_IFLNK;
-	spin_lock(&files->file_lock);
+	rcu_read_lock();
 	file = fcheck_files(files, fd);
 	if (!file)
 		goto out_unlock2;
@@ -1314,7 +1315,7 @@ static struct dentry *proc_lookupfd(stru
 		inode->i_mode |= S_IRUSR | S_IXUSR;
 	if (file->f_mode & 2)
 		inode->i_mode |= S_IWUSR | S_IXUSR;
-	spin_unlock(&files->file_lock);
+	rcu_read_unlock();
 	put_files_struct(files);
 	inode->i_op = &proc_pid_link_inode_operations;
 	inode->i_size = 64;
@@ -1324,7 +1325,7 @@ static struct dentry *proc_lookupfd(stru
 	return NULL;
 
 out_unlock2:
-	spin_unlock(&files->file_lock);
+	rcu_read_unlock();
 	put_files_struct(files);
 out_unlock:
 	iput(inode);
diff -puN fs/select.c~lock-free-fd-lookup fs/select.c
--- linux-2.6.12-rc6-fd/fs/select.c~lock-free-fd-lookup	2005-06-14 14:05:06.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/fs/select.c	2005-06-14 14:05:06.000000000 +0530
@@ -22,6 +22,7 @@
 #include <linux/personality.h> /* for STICKY_TIMEOUTS */
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 
@@ -185,9 +186,9 @@ int do_select(int n, fd_set_bits *fds, l
 	int retval, i;
 	long __timeout = *timeout;
 
- 	spin_lock(&current->files->file_lock);
+	rcu_read_lock();
 	retval = max_select_fd(n, fds);
-	spin_unlock(&current->files->file_lock);
+	rcu_read_unlock();
 
 	if (retval < 0)
 		return retval;
@@ -329,8 +330,10 @@ sys_select(int n, fd_set __user *inp, fd
 		goto out_nofds;
 
 	/* max_fdset can increase, so grab it once to avoid race */
+	rcu_read_lock();
 	fdt = files_fdtable(current->files);
 	max_fdset = fdt->max_fdset;
+	rcu_read_unlock();
 	if (n > max_fdset)
 		n = max_fdset;
 
@@ -469,10 +472,14 @@ asmlinkage long sys_poll(struct pollfd _
 	struct poll_list *head;
  	struct poll_list *walk;
 	struct fdtable *fdt;
+	int max_fdset;
 
 	/* Do a sanity check on nfds ... */
+	rcu_read_lock();
 	fdt = files_fdtable(current->files);
-	if (nfds > fdt->max_fdset && nfds > OPEN_MAX)
+	max_fdset = fdt->max_fdset;
+	rcu_read_unlock();
+	if (nfds > max_fdset && nfds > OPEN_MAX)
 		return -EINVAL;
 
 	if (timeout) {
diff -puN net/ipv4/netfilter/ipt_owner.c~lock-free-fd-lookup net/ipv4/netfilter/ipt_owner.c
--- linux-2.6.12-rc6-fd/net/ipv4/netfilter/ipt_owner.c~lock-free-fd-lookup	2005-06-14 14:05:06.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/net/ipv4/netfilter/ipt_owner.c	2005-06-14 14:05:06.000000000 +0530
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/file.h>
+#include <linux/rcupdate.h>
 #include <net/sock.h>
 
 #include <linux/netfilter_ipv4/ipt_owner.h>
@@ -36,18 +37,18 @@ match_comm(const struct sk_buff *skb, co
 		task_lock(p);
 		files = p->files;
 		if(files) {
-			spin_lock(&files->file_lock);
+			rcu_read_lock();
 			fdt = files_fdtable(files);
 			for (i=0; i < fdt->max_fds; i++) {
 				if (fcheck_files(files, i) ==
 				    skb->sk->sk_socket->file) {
-					spin_unlock(&files->file_lock);
+					rcu_read_unlock();
 					task_unlock(p);
 					read_unlock(&tasklist_lock);
 					return 1;
 				}
 			}
-			spin_unlock(&files->file_lock);
+			rcu_read_unlock();
 		}
 		task_unlock(p);
 	} while_each_thread(g, p);
@@ -70,18 +71,18 @@ match_pid(const struct sk_buff *skb, pid
 	task_lock(p);
 	files = p->files;
 	if(files) {
-		spin_lock(&files->file_lock);
+		rcu_read_lock();
 		fdt = files_fdtable(files);
 		for (i=0; i < fdt->max_fds; i++) {
 			if (fcheck_files(files, i) ==
 			    skb->sk->sk_socket->file) {
-				spin_unlock(&files->file_lock);
+				rcu_read_unlock();
 				task_unlock(p);
 				read_unlock(&tasklist_lock);
 				return 1;
 			}
 		}
-		spin_unlock(&files->file_lock);
+		rcu_read_unlock();
 	}
 	task_unlock(p);
 out:
@@ -106,7 +107,7 @@ match_sid(const struct sk_buff *skb, pid
 		task_lock(p);
 		files = p->files;
 		if (files) {
-			spin_lock(&files->file_lock);
+			rcu_read_lock();
 			fdt = files_fdtable(files);
 			for (i=0; i < fdt->max_fds; i++) {
 				if (fcheck_files(files, i) == file) {
@@ -114,7 +115,7 @@ match_sid(const struct sk_buff *skb, pid
 					break;
 				}
 			}
-			spin_unlock(&files->file_lock);
+			rcu_read_unlock();
 		}
 		task_unlock(p);
 		if (found)
diff -puN net/ipv6/netfilter/ip6t_owner.c~lock-free-fd-lookup net/ipv6/netfilter/ip6t_owner.c
--- linux-2.6.12-rc6-fd/net/ipv6/netfilter/ip6t_owner.c~lock-free-fd-lookup	2005-06-14 14:05:06.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/net/ipv6/netfilter/ip6t_owner.c	2005-06-14 14:05:06.000000000 +0530
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/file.h>
+#include <linux/rcupdate.h>
 #include <net/sock.h>
 
 #include <linux/netfilter_ipv6/ip6t_owner.h>
@@ -35,17 +36,17 @@ match_pid(const struct sk_buff *skb, pid
 	task_lock(p);
 	files = p->files;
 	if(files) {
-		spin_lock(&files->file_lock);
+		rcu_read_lock();
 		fdt = files_fdtable(files);
 		for (i=0; i < fdt->max_fds; i++) {
 			if (fcheck_files(files, i) == skb->sk->sk_socket->file) {
-				spin_unlock(&files->file_lock);
+				rcu_read_unlock();
 				task_unlock(p);
 				read_unlock(&tasklist_lock);
 				return 1;
 			}
 		}
-		spin_unlock(&files->file_lock);
+		rcu_read_unlock();
 	}
 	task_unlock(p);
 out:
@@ -70,7 +71,7 @@ match_sid(const struct sk_buff *skb, pid
 		task_lock(p);
 		files = p->files;
 		if (files) {
-			spin_lock(&files->file_lock);
+			rcu_read_lock();
 			fdt = files_fdtable(files);
 			for (i=0; i < fdt->max_fds; i++) {
 				if (fcheck_files(files, i) == file) {
@@ -78,7 +79,7 @@ match_sid(const struct sk_buff *skb, pid
 					break;
 				}
 			}
-			spin_unlock(&files->file_lock);
+			rcu_read_unlock();
 		}
 		task_unlock(p);
 		if (found)
diff -puN security/selinux/hooks.c~lock-free-fd-lookup security/selinux/hooks.c
--- linux-2.6.12-rc6-fd/security/selinux/hooks.c~lock-free-fd-lookup	2005-06-14 14:05:06.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/security/selinux/hooks.c	2005-06-14 14:05:06.000000000 +0530
@@ -1730,7 +1730,7 @@ static inline void flush_unauthorized_fi
 						continue;
 					}
 					if (devnull) {
-						atomic_inc(&devnull->f_count);
+						rcuref_inc(&devnull->f_count);
 					} else {
 						devnull = dentry_open(dget(selinux_null), mntget(selinuxfs_mount), O_RDWR);
 						if (!devnull) {

_
