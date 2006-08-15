Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030451AbWHOSZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbWHOSZT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbWHOSYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:24:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18398 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030442AbWHOSYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:24:13 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 7/7] file: Modify struct fown_struct to use a struct pid.
Date: Tue, 15 Aug 2006 12:23:12 -0600
Message-Id: <11556661943487-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

File handles can be requested to send sigio and sigurg
to processes.   By tracking the destination processes
using struct pid instead of pid_t we make the interface
safe from all potential pid wrap around problems.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/net/tun.c  |    2 +
 fs/dnotify.c       |    2 +
 fs/fcntl.c         |   78 +++++++++++++++++++++++++++++++++-------------------
 fs/file_table.c    |    1 +
 fs/locks.c         |    2 +
 include/linux/fs.h |    5 +++
 kernel/futex.c     |    2 +
 net/socket.c       |    2 +
 8 files changed, 60 insertions(+), 34 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9ab8ca6..c78d79c 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -697,7 +697,7 @@ static int tun_chr_fasync(int fd, struct
 		return ret; 
  
 	if (on) {
-		ret = f_setown(file, current->pid, 0);
+		ret = __f_setown(file, task_pid(current), PIDTYPE_PID, 0);
 		if (ret)
 			return ret;
 		tun->flags |= TUN_FASYNC;
diff --git a/fs/dnotify.c b/fs/dnotify.c
index f932591..2b0442d 100644
--- a/fs/dnotify.c
+++ b/fs/dnotify.c
@@ -92,7 +92,7 @@ int fcntl_dirnotify(int fd, struct file 
 		prev = &odn->dn_next;
 	}
 
-	error = f_setown(filp, current->pid, 0);
+	error = __f_setown(filp, task_pid(current), PIDTYPE_PID, 0);
 	if (error)
 		goto out_free;
 
diff --git a/fs/fcntl.c b/fs/fcntl.c
index b43d821..55d387c 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -250,19 +250,21 @@ static int setfl(int fd, struct file * f
 	return error;
 }
 
-static void f_modown(struct file *filp, unsigned long pid,
+static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
                      uid_t uid, uid_t euid, int force)
 {
 	write_lock_irq(&filp->f_owner.lock);
 	if (force || !filp->f_owner.pid) {
-		filp->f_owner.pid = pid;
+		put_pid(filp->f_owner.pid);
+		filp->f_owner.pid = get_pid(pid);
+		filp->f_owner.pid_type = type;
 		filp->f_owner.uid = uid;
 		filp->f_owner.euid = euid;
 	}
 	write_unlock_irq(&filp->f_owner.lock);
 }
 
-int f_setown(struct file *filp, unsigned long arg, int force)
+int __f_setown(struct file *filp, struct pid *pid, enum pid_type type, int force)
 {
 	int err;
 	
@@ -270,15 +272,44 @@ int f_setown(struct file *filp, unsigned
 	if (err)
 		return err;
 
-	f_modown(filp, arg, current->uid, current->euid, force);
+	f_modown(filp, pid, type, current->uid, current->euid, force);
 	return 0;
 }
 
+EXPORT_SYMBOL(__f_setown);
+
+int f_setown(struct file *filp, unsigned long arg, int force)
+{
+	enum pid_type type;
+	struct pid *pid;
+	int who = arg;
+	int result;
+	type = PIDTYPE_PID;
+	if (who < 0) {
+		type = PIDTYPE_PGID;
+		who = -who;
+	}
+	rcu_read_lock();
+	pid = find_pid(who);
+	result = __f_setown(filp, pid, type, force);
+	rcu_read_unlock();
+	return result;
+}
+
 EXPORT_SYMBOL(f_setown);
 
 void f_delown(struct file *filp)
 {
-	f_modown(filp, 0, 0, 0, 1);
+	f_modown(filp, NULL, PIDTYPE_PID, 0, 0, 1);
+}
+
+pid_t f_getown(struct file *filp)
+{
+	pid_t pid;
+	pid = pid_nr(filp->f_owner.pid);
+	if (sock->file->f_owner.pid_type == PIDTYPE_PGID)
+		pid = -pid;
+	return pid;
 }
 
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
@@ -319,7 +350,7 @@ static long do_fcntl(int fd, unsigned in
 		 * current syscall conventions, the only way
 		 * to fix this will be in libc.
 		 */
-		err = filp->f_owner.pid;
+		err = f_getown(filp);
 		force_successful_syscall_return();
 		break;
 	case F_SETOWN:
@@ -470,24 +501,19 @@ static void send_sigio_to_task(struct ta
 void send_sigio(struct fown_struct *fown, int fd, int band)
 {
 	struct task_struct *p;
-	int pid;
+	enum pid_type type;
+	struct pid *pid;
 	
 	read_lock(&fown->lock);
+	type = fown->pid_type;
 	pid = fown->pid;
 	if (!pid)
 		goto out_unlock_fown;
 	
 	read_lock(&tasklist_lock);
-	if (pid > 0) {
-		p = find_task_by_pid(pid);
-		if (p) {
-			send_sigio_to_task(p, fown, fd, band);
-		}
-	} else {
-		do_each_task_pid(-pid, PIDTYPE_PGID, p) {
-			send_sigio_to_task(p, fown, fd, band);
-		} while_each_task_pid(-pid, PIDTYPE_PGID, p);
-	}
+	do_each_pid_task(pid, type, p) {
+		send_sigio_to_task(p, fown, fd, band);
+	} while_each_pid_task(pid, type, p);
 	read_unlock(&tasklist_lock);
  out_unlock_fown:
 	read_unlock(&fown->lock);
@@ -503,9 +529,12 @@ static void send_sigurg_to_task(struct t
 int send_sigurg(struct fown_struct *fown)
 {
 	struct task_struct *p;
-	int pid, ret = 0;
+	enum pid_type type;
+	struct pid *pid;
+	int ret = 0;
 	
 	read_lock(&fown->lock);
+	type = fown->pid_type;
 	pid = fown->pid;
 	if (!pid)
 		goto out_unlock_fown;
@@ -513,16 +542,9 @@ int send_sigurg(struct fown_struct *fown
 	ret = 1;
 	
 	read_lock(&tasklist_lock);
-	if (pid > 0) {
-		p = find_task_by_pid(pid);
-		if (p) {
-			send_sigurg_to_task(p, fown);
-		}
-	} else {
-		do_each_task_pid(-pid, PIDTYPE_PGID, p) {
-			send_sigurg_to_task(p, fown);
-		} while_each_task_pid(-pid, PIDTYPE_PGID, p);
-	}
+	do_each_pid_task(pid, type, p) {
+		send_sigurg_to_task(p, fown);
+	} while_each_pid_task(pid, type, p);
 	read_unlock(&tasklist_lock);
  out_unlock_fown:
 	read_unlock(&fown->lock);
diff --git a/fs/file_table.c b/fs/file_table.c
index 2d9069c..c64764a 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -181,6 +181,7 @@ #endif
 	fops_put(file->f_op);
 	if (file->f_mode & FMODE_WRITE)
 		put_write_access(inode);
+	put_pid(file->f_owner.pid);
 	file_kill(file);
 	file->f_dentry = NULL;
 	file->f_vfsmnt = NULL;
diff --git a/fs/locks.c b/fs/locks.c
index d7c5339..b12e819 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1514,7 +1514,7 @@ int fcntl_setlease(unsigned int fd, stru
 		goto out_unlock;
 	}
 
-	error = f_setown(filp, current->pid, 0);
+	error = __f_setown(filp, task_pid(current), PIDTYPE_PID, 0);
 out_unlock:
 	unlock_kernel();
 	return error;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 50e6eb2..b74d39b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -667,7 +667,8 @@ extern struct block_device *I_BDEV(struc
 
 struct fown_struct {
 	rwlock_t lock;          /* protects pid, uid, euid fields */
-	int pid;		/* pid or -pgrp where SIGIO should be sent */
+	struct pid *pid;	/* pid or -pgrp where SIGIO should be sent */
+	enum pid_type pid_type;	/* Kind of process group SIGIO should be sent to */
 	uid_t uid, euid;	/* uid/euid of process setting the owner */
 	int signum;		/* posix.1b rt signal to be delivered on IO */
 };
@@ -919,8 +920,10 @@ extern void kill_fasync(struct fasync_st
 /* only for net: no internal synchronization */
 extern void __kill_fasync(struct fasync_struct *, int, int);
 
+extern int __f_setown(struct file *filp, struct pid *, enum pid_type, int force);
 extern int f_setown(struct file *filp, unsigned long arg, int force);
 extern void f_delown(struct file *filp);
+extern pid_t f_getown(struct file *filp);
 extern int send_sigurg(struct fown_struct *fown);
 
 /*
diff --git a/kernel/futex.c b/kernel/futex.c
index d4633c5..d78d898 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1589,7 +1589,7 @@ static int futex_fd(u32 __user *uaddr, i
 	filp->f_mapping = filp->f_dentry->d_inode->i_mapping;
 
 	if (signal) {
-		err = f_setown(filp, current->pid, 1);
+		err = __f_setown(filp, task_pid(current), PIDTYPE_PID, 1);
 		if (err < 0) {
 			goto error;
 		}
diff --git a/net/socket.c b/net/socket.c
index 2bfc60a..a66bd4c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -825,7 +825,7 @@ #endif				/* CONFIG_WIRELESS_EXT */
 			break;
 		case FIOGETOWN:
 		case SIOCGPGRP:
-			err = put_user(sock->file->f_owner.pid,
+			err = put_user(f_getown(sock->file),
 				       (int __user *)argp);
 			break;
 		case SIOCGIFBR:
-- 
1.4.2.rc3.g7e18e-dirty

