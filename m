Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267663AbTAMAHj>; Sun, 12 Jan 2003 19:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267670AbTAMAHK>; Sun, 12 Jan 2003 19:07:10 -0500
Received: from mons.uio.no ([129.240.130.14]:33162 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267663AbTAMAFd>;
	Sun, 12 Jan 2003 19:05:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15906.1238.370262.868014@charged.uio.no>
Date: Mon, 13 Jan 2003 01:14:14 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Secure user authentication for NFS using RPCSEC_GSS [3/6]
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch provides the upcall mechanism that will be used for communicating
with the RPCSEC client user daemons.

It sets up a 'ramfs' style filesystem (rpc_pipefs) that is populated with
named pipes. Each time the kernel initializes a new NFS, lockd, statd or
portmapper client, a directory automatically gets set up in this fs.
The directory is initially only populated with a single file "info"
that provides information such as the server IP address, the port number
and the RPC service for the benefit of the user daemon.

When an RPCSEC_GSS mechanism needs to communicate with the daemon, it
is provided with a toolkit for setting up a named pipe in the same
directory. It can then perform upcalls/downcalls in order to talk to the
daemon in much the same way as is done by CODA.

The NFSv4 client will also need to use this same filesystem to communicate
with its user daemon in order to do name-to-uid/name-from-uid and
name-to-gid/name-from-gid translation.

diff -u --recursive --new-file linux-2.5.56-03-rpc_encode/include/linux/sunrpc/clnt.h linux-2.5.56-04-auth_upcall/include/linux/sunrpc/clnt.h
--- linux-2.5.56-03-rpc_encode/include/linux/sunrpc/clnt.h	2002-11-13 15:09:19.000000000 +0100
+++ linux-2.5.56-04-auth_upcall/include/linux/sunrpc/clnt.h	2003-01-12 22:39:49.000000000 +0100
@@ -28,6 +28,8 @@
 	__u16			pm_port;
 };
 
+struct rpc_inode;
+
 /*
  * The high-level client handle
  */
@@ -58,6 +60,8 @@
 
 	int			cl_nodelen;	/* nodename length */
 	char 			cl_nodename[UNX_MAXNODENAME];
+	char			cl_pathname[30];/* Path in rpc_pipe_fs */
+	struct dentry *		cl_dentry;	/* inode */
 };
 #define cl_timeout		cl_xprt->timeout
 #define cl_prog			cl_pmap.pm_prog
diff -u --recursive --new-file linux-2.5.56-03-rpc_encode/include/linux/sunrpc/rpc_pipe_fs.h linux-2.5.56-04-auth_upcall/include/linux/sunrpc/rpc_pipe_fs.h
--- linux-2.5.56-03-rpc_encode/include/linux/sunrpc/rpc_pipe_fs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-04-auth_upcall/include/linux/sunrpc/rpc_pipe_fs.h	2003-01-12 22:39:49.000000000 +0100
@@ -0,0 +1,47 @@
+#ifndef _LINUX_SUNRPC_RPC_PIPE_FS_H
+#define _LINUX_SUNRPC_RPC_PIPE_FS_H
+
+#ifdef __KERNEL__
+
+struct rpc_pipe_msg {
+	struct list_head list;
+	void *data;
+	size_t len;
+	size_t copied;
+	int errno;
+};
+
+struct rpc_pipe_ops {
+	ssize_t (*upcall)(struct file *, struct rpc_pipe_msg *, char *, size_t);
+	ssize_t (*downcall)(struct file *, const char *, size_t);
+	void (*destroy_msg)(struct rpc_pipe_msg *);
+};
+
+struct rpc_inode {
+	struct inode vfs_inode;
+	void *private;
+	struct list_head pipe;
+	int pipelen;
+	int nreaders;
+	wait_queue_head_t waitq;
+	struct rpc_pipe_ops *ops;
+};
+
+static inline struct rpc_inode *
+RPC_I(struct inode *inode)
+{
+	return container_of(inode, struct rpc_inode, vfs_inode);
+}
+
+extern void rpc_inode_setowner(struct inode *, void *);
+extern int rpc_queue_upcall(struct inode *, struct rpc_pipe_msg *);
+
+extern struct dentry *rpc_mkdir(char *, struct rpc_clnt *);
+extern int rpc_rmdir(char *);
+extern struct dentry *rpc_mkpipe(char *, void *, struct rpc_pipe_ops *);
+extern int rpc_unlink(char *);
+
+void __rpc_purge_current_upcall(struct file *);
+
+#endif
+#endif
diff -u --recursive --new-file linux-2.5.56-03-rpc_encode/net/sunrpc/clnt.c linux-2.5.56-04-auth_upcall/net/sunrpc/clnt.c
--- linux-2.5.56-03-rpc_encode/net/sunrpc/clnt.c	2003-01-12 22:39:48.000000000 +0100
+++ linux-2.5.56-04-auth_upcall/net/sunrpc/clnt.c	2003-01-12 22:39:49.000000000 +0100
@@ -30,6 +30,7 @@
 #include <linux/utsname.h>
 
 #include <linux/sunrpc/clnt.h>
+#include <linux/sunrpc/rpc_pipe_fs.h>
 
 #include <linux/nfs.h>
 
@@ -108,8 +109,19 @@
 
 	rpc_init_rtt(&clnt->cl_rtt, xprt->timeout.to_initval);
 
-	if (!rpcauth_create(flavor, clnt))
+	snprintf(clnt->cl_pathname, sizeof(clnt->cl_pathname),
+			"/%s/clnt%p", clnt->cl_protname, clnt);
+	clnt->cl_dentry = rpc_mkdir(clnt->cl_pathname, clnt);
+	if (IS_ERR(clnt->cl_dentry)) {
+		printk(KERN_INFO "RPC: Couldn't create pipefs entry %s\n",
+				clnt->cl_pathname);
+		goto out_no_path;
+	}
+	if (!rpcauth_create(flavor, clnt)) {
+		printk(KERN_INFO "RPC: Couldn't create auth handle (flavor %u)\n",
+				flavor);
 		goto out_no_auth;
+	}
 
 	/* save the nodename */
 	clnt->cl_nodelen = strlen(system_utsname.nodename);
@@ -123,8 +135,8 @@
 	printk(KERN_INFO "RPC: out of memory in rpc_create_client\n");
 	goto out;
 out_no_auth:
-	printk(KERN_INFO "RPC: Couldn't create auth handle (flavor %u)\n",
-		flavor);
+	rpc_rmdir(clnt->cl_pathname);
+out_no_path:
 	kfree(clnt);
 	clnt = NULL;
 	goto out;
@@ -176,6 +188,7 @@
 		rpcauth_destroy(clnt->cl_auth);
 		clnt->cl_auth = NULL;
 	}
+	rpc_rmdir(clnt->cl_pathname);
 	if (clnt->cl_xprt) {
 		xprt_destroy(clnt->cl_xprt);
 		clnt->cl_xprt = NULL;
@@ -801,13 +814,23 @@
 static void
 call_refreshresult(struct rpc_task *task)
 {
+	int status = task->tk_status;
 	dprintk("RPC: %4d call_refreshresult (status %d)\n", 
 				task->tk_pid, task->tk_status);
 
-	if (task->tk_status < 0)
-		rpc_exit(task, -EACCES);
-	else
-		task->tk_action = call_reserve;
+	task->tk_status = 0;
+	task->tk_action = call_reserve;
+	if (status >= 0)
+		return;
+	switch (status) {
+		case -EPIPE:
+			rpc_delay(task, 3*HZ);
+		case -ETIMEDOUT:
+			task->tk_action = call_refresh;
+			break;
+		default:
+			rpc_exit(task, -EACCES);
+	}
 }
 
 /*
diff -u --recursive --new-file linux-2.5.56-03-rpc_encode/net/sunrpc/Makefile linux-2.5.56-04-auth_upcall/net/sunrpc/Makefile
--- linux-2.5.56-03-rpc_encode/net/sunrpc/Makefile	2002-12-14 13:38:56.000000000 +0100
+++ linux-2.5.56-04-auth_upcall/net/sunrpc/Makefile	2003-01-12 22:39:49.000000000 +0100
@@ -10,6 +10,6 @@
 	    auth.o auth_null.o auth_unix.o \
 	    svc.o svcsock.o svcauth.o svcauth_unix.o \
 	    pmap_clnt.o timer.o xdr.o \
-	    sunrpc_syms.o cache.o
+	    sunrpc_syms.o cache.o rpc_pipe.o
 sunrpc-$(CONFIG_PROC_FS) += stats.o
 sunrpc-$(CONFIG_SYSCTL) += sysctl.o
diff -u --recursive --new-file linux-2.5.56-03-rpc_encode/net/sunrpc/rpc_pipe.c linux-2.5.56-04-auth_upcall/net/sunrpc/rpc_pipe.c
--- linux-2.5.56-03-rpc_encode/net/sunrpc/rpc_pipe.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-04-auth_upcall/net/sunrpc/rpc_pipe.c	2003-01-12 22:39:49.000000000 +0100
@@ -0,0 +1,817 @@
+/*
+ * net/sunrpc/rpc_pipe.c
+ *
+ * Userland/kernel interface for rpcauth_gss.
+ * Code shamelessly plagiarized from fs/nfsd/nfsctl.c
+ * and fs/driverfs/inode.c
+ *
+ * Copyright (c) 2002, Trond Myklebust <trond.myklebust@fys.uio.no>
+ *
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/pagemap.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/dnotify.h>
+#include <linux/kernel.h>
+
+#include <asm/ioctls.h>
+#include <linux/fs.h>
+#include <linux/poll.h>
+#include <linux/wait.h>
+#include <linux/seq_file.h>
+
+#include <linux/sunrpc/clnt.h>
+#include <linux/sunrpc/rpc_pipe_fs.h>
+
+static struct vfsmount *rpc_mount;
+static spinlock_t rpc_mount_lock = SPIN_LOCK_UNLOCKED;
+static int rpc_mount_count;
+
+static struct file_system_type rpc_pipe_fs_type;
+
+
+static kmem_cache_t *rpc_inode_cachep;
+
+static void
+__rpc_purge_upcall(struct inode *inode, int err)
+{
+	struct rpc_inode *rpci = RPC_I(inode);
+	struct rpc_pipe_msg *msg;
+
+	while (!list_empty(&rpci->pipe)) {
+		msg = list_entry(rpci->pipe.next, struct rpc_pipe_msg, list);
+		list_del_init(&msg->list);
+		msg->errno = err;
+		rpci->ops->destroy_msg(msg);
+	}
+	rpci->pipelen = 0;
+	wake_up(&rpci->waitq);
+}
+
+void
+rpc_purge_upcall(struct inode *inode, int err)
+{
+	down(&inode->i_sem);
+	__rpc_purge_upcall(inode, err);
+	up(&inode->i_sem);
+}
+
+/*
+ * XXX should only be called in ->downcall
+ */
+void
+__rpc_purge_current_upcall(struct file *filp)
+{
+	struct rpc_pipe_msg *msg;
+
+	msg = filp->private_data;
+	filp->private_data = NULL;
+
+	if (msg != NULL)
+		msg->errno = 0;
+}
+
+int
+rpc_queue_upcall(struct inode *inode, struct rpc_pipe_msg *msg)
+{
+	struct rpc_inode *rpci = RPC_I(inode);
+	int res = 0;
+
+	down(&inode->i_sem);
+	if (rpci->nreaders) {
+		list_add_tail(&msg->list, &rpci->pipe);
+		rpci->pipelen += msg->len;
+	} else
+		res = -EPIPE;
+	up(&inode->i_sem);
+	wake_up(&rpci->waitq);
+	return res;
+}
+
+void
+rpc_inode_setowner(struct inode *inode, void *private)
+{
+	struct rpc_inode *rpci = RPC_I(inode);
+	down(&inode->i_sem);
+	rpci->private = private;
+	if (!private)
+		__rpc_purge_upcall(inode, -EPIPE);
+	up(&inode->i_sem);
+}
+
+static struct inode *
+rpc_alloc_inode(struct super_block *sb)
+{
+	struct rpc_inode *rpci;
+	rpci = (struct rpc_inode *)kmem_cache_alloc(rpc_inode_cachep, SLAB_KERNEL);
+	if (!rpci)
+		return NULL;
+	return &rpci->vfs_inode;
+}
+
+static void
+rpc_destroy_inode(struct inode *inode)
+{
+	kmem_cache_free(rpc_inode_cachep, RPC_I(inode));
+}
+
+static int
+rpc_pipe_open(struct inode *inode, struct file *filp)
+{
+	struct rpc_inode *rpci = RPC_I(inode);
+	int res = -ENXIO;
+
+	down(&inode->i_sem);
+	if (rpci->private != NULL) {
+		if (filp->f_mode & FMODE_READ)
+			rpci->nreaders ++;
+		res = 0;
+	}
+	up(&inode->i_sem);
+	return res;
+}
+
+static int
+rpc_pipe_release(struct inode *inode, struct file *filp)
+{
+	struct rpc_inode *rpci = RPC_I(filp->f_dentry->d_inode);
+	struct rpc_pipe_msg *msg;
+
+	msg = (struct rpc_pipe_msg *)filp->private_data;
+	if (msg != NULL) {
+		msg->errno = -EPIPE;
+		rpci->ops->destroy_msg(msg);
+	}
+	down(&inode->i_sem);
+	if (filp->f_mode & FMODE_READ)
+		rpci->nreaders --;
+	if (!rpci->nreaders)
+		__rpc_purge_upcall(inode, -EPIPE);
+	up(&inode->i_sem);
+	return 0;
+}
+
+static ssize_t
+rpc_pipe_read(struct file *filp, char *buf, size_t len, loff_t *offset)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct rpc_inode *rpci = RPC_I(inode);
+	struct rpc_pipe_msg *msg;
+	int res = 0;
+
+	down(&inode->i_sem);
+	if (!rpci->private) {
+		res = -EPIPE;
+		goto out_unlock;
+	}
+	msg = filp->private_data;
+	if (msg == NULL) {
+		if (!list_empty(&rpci->pipe)) {
+			msg = list_entry(rpci->pipe.next,
+					struct rpc_pipe_msg,
+					list);
+			list_del_init(&msg->list);
+			rpci->pipelen -= msg->len;
+			filp->private_data = msg;
+		}
+		if (msg == NULL)
+			goto out_unlock;
+	}
+	res = rpci->ops->upcall(filp, msg, buf, len);
+	if (res < 0 || msg->len == msg->copied) {
+		filp->private_data = NULL;
+		msg->errno = 0;
+		rpci->ops->destroy_msg(msg);
+	}
+out_unlock:
+	up(&inode->i_sem);
+	return res;
+}
+
+static ssize_t
+rpc_pipe_write(struct file *filp, const char *buf, size_t len, loff_t *offset)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct rpc_inode *rpci = RPC_I(inode);
+	int res;
+
+	down(&inode->i_sem);
+	res = -EPIPE;
+	if (rpci->private != NULL)
+		res = rpci->ops->downcall(filp, buf, len);
+	up(&inode->i_sem);
+	return res;
+}
+
+static unsigned int
+rpc_pipe_poll(struct file *filp, struct poll_table_struct *wait)
+{
+	struct rpc_inode *rpci;
+	unsigned int mask = 0;
+
+	rpci = RPC_I(filp->f_dentry->d_inode);
+	poll_wait(filp, &rpci->waitq, wait);
+
+	mask = POLLOUT | POLLWRNORM;
+	if (rpci->private == NULL)
+		mask |= POLLERR | POLLHUP;
+	if (!list_empty(&rpci->pipe))
+		mask |= POLLIN | POLLRDNORM;
+	return mask;
+}
+
+static int
+rpc_pipe_ioctl(struct inode *ino, struct file *filp,
+		unsigned int cmd, unsigned long arg)
+{
+	struct rpc_inode *rpci = RPC_I(filp->f_dentry->d_inode);
+	int len;
+
+	switch (cmd) {
+	case FIONREAD:
+		if (!rpci->private)
+			return -EPIPE;
+		len = rpci->pipelen;
+		if (filp->private_data) {
+			struct rpc_pipe_msg *msg;
+			msg = (struct rpc_pipe_msg *)filp->private_data;
+			len += msg->len - msg->copied;
+		}
+		return put_user(len, (int *)arg);
+	default:
+		return -EINVAL;
+	}
+}
+
+struct inode_operations rpc_pipe_iops = {
+	.lookup		= simple_lookup,
+};
+
+
+struct file_operations rpc_pipe_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= rpc_pipe_read,
+	.write		= rpc_pipe_write,
+	.poll		= rpc_pipe_poll,
+	.ioctl		= rpc_pipe_ioctl,
+	.open		= rpc_pipe_open,
+	.release	= rpc_pipe_release,
+};
+
+static int
+rpc_show_info(struct seq_file *m, void *v)
+{
+	struct rpc_clnt *clnt = m->private;
+
+	seq_printf(m, "RPC server: %s\n", clnt->cl_server);
+	seq_printf(m, "service: %s (%d) version %d\n", clnt->cl_protname,
+			clnt->cl_prog, clnt->cl_vers);
+	seq_printf(m, "address: %u.%u.%u.%u\n",
+			NIPQUAD(clnt->cl_xprt->addr.sin_addr.s_addr));
+	return 0;
+}
+
+static int
+rpc_info_open(struct inode *inode, struct file *file)
+{
+	struct rpc_clnt *clnt;
+	int ret = single_open(file, rpc_show_info, NULL);
+
+	if (!ret) {
+		struct seq_file *m = file->private_data;
+		down(&inode->i_sem);
+		clnt = RPC_I(inode)->private;
+		if (clnt) {
+			atomic_inc(&clnt->cl_users);
+			m->private = clnt;
+		} else {
+			single_release(inode, file);
+			ret = -EINVAL;
+		}
+		up(&inode->i_sem);
+	}
+	return ret;
+}
+
+static int
+rpc_info_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = file->private_data;
+	struct rpc_clnt *clnt = (struct rpc_clnt *)m->private;
+
+	if (clnt)
+		rpc_release_client(clnt);
+	return single_release(inode, file);
+}
+
+static struct file_operations rpc_info_operations = {
+	.open		= rpc_info_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= rpc_info_release,
+};
+
+
+/*
+ * We have a single directory with 1 node in it.
+ */
+enum {
+	RPCAUTH_Root = 1,
+	RPCAUTH_lockd,
+	RPCAUTH_nfs,
+	RPCAUTH_portmap,
+	RPCAUTH_statd,
+	RPCAUTH_RootEOF
+};
+
+/*
+ * Description of fs contents.
+ */
+struct rpc_filelist {
+	char *name;
+	struct file_operations *i_fop;
+	int mode;
+};
+
+static struct rpc_filelist files[] = {
+	[RPCAUTH_lockd] = {
+		.name = "lockd",
+		.mode = S_IFDIR | S_IRUSR | S_IXUSR,
+	},
+	[RPCAUTH_nfs] = {
+		.name = "nfs",
+		.mode = S_IFDIR | S_IRUSR | S_IXUSR,
+	},
+	[RPCAUTH_portmap] = {
+		.name = "portmap",
+		.mode = S_IFDIR | S_IRUSR | S_IXUSR,
+	},
+	[RPCAUTH_statd] = {
+		.name = "statd",
+		.mode = S_IFDIR | S_IRUSR | S_IXUSR,
+	},
+};
+
+enum {
+	RPCAUTH_info = 2,
+	RPCAUTH_EOF
+};
+
+static struct rpc_filelist authfiles[] = {
+	[RPCAUTH_info] = {
+		.name = "info",
+		.i_fop = &rpc_info_operations,
+		.mode = S_IFREG | S_IRUSR,
+	},
+};
+
+static int
+rpc_get_mount(void)
+{
+	struct vfsmount * mnt = NULL;
+
+	spin_lock(&rpc_mount_lock);
+	if (rpc_mount)
+		goto out_get;
+	spin_unlock(&rpc_mount_lock);
+	mnt = kern_mount(&rpc_pipe_fs_type);
+	if (IS_ERR(mnt))
+		return -ENODEV;
+	spin_lock(&rpc_mount_lock);
+	if (!rpc_mount) {
+		rpc_mount = mnt;
+		mnt = NULL;
+		goto out_dontget;
+	}
+out_get:
+	mntget(rpc_mount);
+out_dontget:
+	++rpc_mount_count;
+	spin_unlock(&rpc_mount_lock);
+	if (mnt)
+		mntput(mnt);
+	return 0;
+}
+
+static void
+rpc_put_mount(void)
+{
+	struct vfsmount *mnt;
+
+	spin_lock(&rpc_mount_lock);
+	mnt = rpc_mount;
+	--rpc_mount_count;
+	if (rpc_mount_count == 0)
+		rpc_mount = NULL;
+	else
+		mnt = NULL;
+	spin_unlock(&rpc_mount_lock);
+	if (mnt)
+		mntput(mnt);
+}
+
+static int
+rpc_lookup_path(char *path, struct nameidata *nd, int flags)
+{
+	if (rpc_get_mount()) {
+		printk(KERN_WARNING "%s: %s failed to mount "
+			       "pseudofilesystem \n", __FILE__, __FUNCTION__);
+		return -ENODEV;
+	}
+	nd->mnt = mntget(rpc_mount);
+	nd->dentry = dget(rpc_mount->mnt_sb->s_root);
+	nd->last_type = LAST_ROOT;
+	nd->flags = flags;
+
+	if (path_walk(path, nd)) {
+		printk(KERN_WARNING "%s: %s failed to find path %s\n",
+				__FILE__, __FUNCTION__, path);
+		rpc_put_mount();
+		return -ENOENT;
+	}
+	return 0;
+}
+
+static void
+rpc_release_path(struct nameidata *nd)
+{
+	path_release(nd);
+	rpc_put_mount();
+}
+
+static struct inode *
+rpc_get_inode(struct super_block *sb, int mode)
+{
+	struct inode *inode = new_inode(sb);
+	if (!inode)
+		return NULL;
+	inode->i_mode = mode;
+	inode->i_uid = inode->i_gid = 0;
+	inode->i_blksize = PAGE_CACHE_SIZE;
+	inode->i_blocks = 0;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	switch(mode & S_IFMT) {
+		case S_IFDIR:
+			inode->i_fop = &simple_dir_operations;
+			inode->i_op = &simple_dir_inode_operations;
+			inode->i_nlink++;
+		default:
+			break;
+	}
+	return inode;
+}
+
+/*
+ * FIXME: This probably has races.
+ */
+static void
+rpc_depopulate(struct dentry *dir)
+{
+	LIST_HEAD(head);
+	struct list_head *pos, *next;
+	struct dentry *dentry;
+
+	down(&dir->d_inode->i_sem);
+	spin_lock(&dcache_lock);
+	list_for_each_safe(pos, next, &dir->d_subdirs) {
+		dentry = list_entry(pos, struct dentry, d_child);
+		if (!d_unhashed(dentry)) {
+			dget_locked(dentry);
+			list_del(&dentry->d_hash);
+			list_add(&dentry->d_hash, &head);
+		}
+	}
+	spin_unlock(&dcache_lock);
+	while (!list_empty(&head)) {
+		dentry = list_entry(head.next, struct dentry, d_hash);
+		list_del_init(&dentry->d_hash);
+		if (dentry->d_inode) {
+			rpc_inode_setowner(dentry->d_inode, NULL);
+			simple_unlink(dir->d_inode, dentry);
+		}
+		dput(dentry);
+	}
+	up(&dir->d_inode->i_sem);
+}
+
+static int
+rpc_populate(struct dentry *dir,
+		struct rpc_filelist *files,
+		int start, int eof)
+{
+	void *private = RPC_I(dir->d_inode)->private;
+	struct qstr name;
+	struct dentry *dentry;
+	struct inode *inode;
+	int mode, i;
+	for (i = start; i < eof; i++) {
+		name.name = files[i].name;
+		name.len = strlen(name.name);
+		name.hash = full_name_hash(name.name, name.len);
+		dentry = d_alloc(dir, &name);
+		if (!dentry)
+			goto out_bad;
+		mode = files[i].mode;
+		inode = rpc_get_inode(dir->d_inode->i_sb, mode);
+		if (!inode) {
+			dput(dentry);
+			goto out_bad;
+		}
+		inode->i_ino = i;
+		if (files[i].i_fop)
+			inode->i_fop = files[i].i_fop;
+		if (private)
+			rpc_inode_setowner(inode, private);
+		if (S_ISDIR(mode))
+			dir->d_inode->i_nlink++;
+		d_add(dentry, inode);
+	}
+	return 0;
+out_bad:
+	printk(KERN_WARNING "%s: %s failed to populate directory %s\n",
+			__FILE__, __FUNCTION__, dir->d_name.name);
+	return -ENOMEM;
+}
+
+static int
+__rpc_mkdir(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode;
+
+	inode = rpc_get_inode(dir->i_sb, S_IFDIR | S_IRUSR | S_IXUSR);
+	if (!inode)
+		goto out_err;
+	inode->i_ino = iunique(dir->i_sb, 100);
+	d_instantiate(dentry, inode);
+	dir->i_nlink++;
+	inode_dir_notify(dir, DN_CREATE);
+	rpc_get_mount();
+	return 0;
+out_err:
+	printk(KERN_WARNING "%s: %s failed to allocate inode for dentry %s\n",
+			__FILE__, __FUNCTION__, dentry->d_name.name);
+	return -ENOMEM;
+}
+
+static int
+__rpc_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	int error;
+
+	rpc_inode_setowner(dentry->d_inode, NULL);
+	if ((error = simple_rmdir(dir, dentry)) != 0)
+		return error;
+	if (!error) {
+		inode_dir_notify(dir, DN_DELETE);
+		d_drop(dentry);
+		rpc_put_mount();
+	}
+	return 0;
+}
+
+struct dentry *
+rpc_lookup_negative(char *path, struct nameidata *nd)
+{
+	struct dentry *dentry;
+	struct inode *dir;
+	int error;
+
+	if ((error = rpc_lookup_path(path, nd, LOOKUP_PARENT)) != 0)
+		return ERR_PTR(error);
+	dir = nd->dentry->d_inode;
+	down(&dir->i_sem);
+	dentry = lookup_hash(&nd->last, nd->dentry);
+	if (IS_ERR(dentry))
+		goto out_err;
+	if (dentry->d_inode) {
+		dput(dentry);
+		dentry = ERR_PTR(-EEXIST);
+		goto out_err;
+	}
+	return dentry;
+out_err:
+	up(&dir->i_sem);
+	rpc_release_path(nd);
+	return dentry;
+}
+
+
+struct dentry *
+rpc_mkdir(char *path, struct rpc_clnt *rpc_client)
+{
+	struct nameidata nd;
+	struct dentry *dentry;
+	struct inode *dir;
+	int error;
+
+	dentry = rpc_lookup_negative(path, &nd);
+	if (IS_ERR(dentry))
+		return dentry;
+	dir = nd.dentry->d_inode;
+	if ((error = __rpc_mkdir(dir, dentry)) != 0)
+		goto err_dput;
+	RPC_I(dentry->d_inode)->private = rpc_client;
+	error = rpc_populate(dentry, authfiles,
+			RPCAUTH_info, RPCAUTH_EOF);
+	if (error)
+		goto err_depopulate;
+out:
+	up(&dir->i_sem);
+	rpc_release_path(&nd);
+	return dentry;
+err_depopulate:
+	rpc_depopulate(dentry);
+	__rpc_rmdir(dir, dentry);
+err_dput:
+	dput(dentry);
+	printk(KERN_WARNING "%s: %s() failed to create directory %s (errno = %d)\n",
+			__FILE__, __FUNCTION__, path, error);
+	dentry = ERR_PTR(error);
+	goto out;
+}
+
+int
+rpc_rmdir(char *path)
+{
+	struct nameidata nd;
+	struct dentry *dentry;
+	struct inode *dir;
+	int error;
+
+	if ((error = rpc_lookup_path(path, &nd, LOOKUP_PARENT)) != 0)
+		return error;
+	dir = nd.dentry->d_inode;
+	down(&dir->i_sem);
+	dentry = lookup_hash(&nd.last, nd.dentry);
+	if (IS_ERR(dentry)) {
+		error = PTR_ERR(dentry);
+		goto out_release;
+	}
+	rpc_depopulate(dentry);
+	error = __rpc_rmdir(dir, dentry);
+	dput(dentry);
+out_release:
+	up(&dir->i_sem);
+	rpc_release_path(&nd);
+	return error;
+}
+
+struct dentry *
+rpc_mkpipe(char *path, void *private, struct rpc_pipe_ops *ops)
+{
+	struct nameidata nd;
+	struct dentry *dentry;
+	struct inode *dir, *inode;
+	struct rpc_inode *rpci;
+
+	dentry = rpc_lookup_negative(path, &nd);
+	if (IS_ERR(dentry))
+		return dentry;
+	dir = nd.dentry->d_inode;
+	inode = rpc_get_inode(dir->i_sb, S_IFSOCK | S_IRUSR | S_IXUSR);
+	if (!inode)
+		goto err_dput;
+	inode->i_ino = iunique(dir->i_sb, 100);
+	inode->i_fop = &rpc_pipe_fops;
+	d_instantiate(dentry, inode);
+	rpci = RPC_I(inode);
+	rpci->private = private;
+	rpci->ops = ops;
+	inode_dir_notify(dir, DN_CREATE);
+out:
+	up(&dir->i_sem);
+	rpc_release_path(&nd);
+	return dentry;
+err_dput:
+	dput(dentry);
+	dentry = ERR_PTR(-ENOMEM);
+	printk(KERN_WARNING "%s: %s() failed to create pipe %s (errno = %d)\n",
+			__FILE__, __FUNCTION__, path, -ENOMEM);
+	goto out;
+}
+
+int
+rpc_unlink(char *path)
+{
+	struct nameidata nd;
+	struct dentry *dentry;
+	struct inode *dir;
+	int error;
+
+	if ((error = rpc_lookup_path(path, &nd, LOOKUP_PARENT)) != 0)
+		return error;
+	dir = nd.dentry->d_inode;
+	down(&dir->i_sem);
+	dentry = lookup_hash(&nd.last, nd.dentry);
+	if (IS_ERR(dentry)) {
+		error = PTR_ERR(dentry);
+		goto out_release;
+	}
+	d_drop(dentry);
+	if (dentry->d_inode) {
+		rpc_inode_setowner(dentry->d_inode, NULL);
+		error = simple_unlink(dir, dentry);
+	}
+	dput(dentry);
+	inode_dir_notify(dir, DN_DELETE);
+out_release:
+	up(&dir->i_sem);
+	rpc_release_path(&nd);
+	return error;
+}
+
+/*
+ * populate the filesystem
+ */
+static struct super_operations s_ops = {
+	.alloc_inode	= rpc_alloc_inode,
+	.destroy_inode	= rpc_destroy_inode,
+	.statfs		= simple_statfs,
+};
+
+#define RPCAUTH_GSSMAGIC 0x67596969
+
+static int
+rpc_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct inode *inode;
+	struct dentry *root;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = RPCAUTH_GSSMAGIC;
+	sb->s_op = &s_ops;
+
+	inode = rpc_get_inode(sb, S_IFDIR | 0755);
+	if (!inode)
+		return -ENOMEM;
+	root = d_alloc_root(inode);
+	if (!root) {
+		iput(inode);
+		return -ENOMEM;
+	}
+	if (rpc_populate(root, files, RPCAUTH_Root + 1, RPCAUTH_RootEOF))
+		goto out;
+	sb->s_root = root;
+	return 0;
+out:
+	d_genocide(root);
+	dput(root);
+	return -ENOMEM;
+}
+
+static struct super_block *
+rpc_get_sb(struct file_system_type *fs_type,
+		int flags, char *dev_name, void *data)
+{
+	return get_sb_single(fs_type, flags, data, rpc_fill_super);
+}
+
+static struct file_system_type rpc_pipe_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "rpc_pipefs",
+	.get_sb		= rpc_get_sb,
+	.kill_sb	= kill_litter_super,
+};
+
+static void
+init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+{
+	struct rpc_inode *rpci = (struct rpc_inode *) foo;
+
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR) {
+		inode_init_once(&rpci->vfs_inode);
+		rpci->private = NULL;
+		rpci->nreaders = 0;
+		INIT_LIST_HEAD(&rpci->pipe);
+		rpci->pipelen = 0;
+		init_waitqueue_head(&rpci->waitq);
+		rpci->ops = NULL;
+	}
+}
+
+int register_rpc_pipefs(void)
+{
+	rpc_inode_cachep = kmem_cache_create("rpc_inode_cache",
+                                             sizeof(struct rpc_inode),
+                                             0, SLAB_HWCACHE_ALIGN,
+                                             init_once, NULL);
+	if (!rpc_inode_cachep)
+		return -ENOMEM;
+	register_filesystem(&rpc_pipe_fs_type);
+	return 0;
+}
+
+void unregister_rpc_pipefs(void)
+{
+	if (kmem_cache_destroy(rpc_inode_cachep))
+		printk(KERN_WARNING "RPC: unable to free inode cache\n");
+	unregister_filesystem(&rpc_pipe_fs_type);
+}
diff -u --recursive --new-file linux-2.5.56-03-rpc_encode/net/sunrpc/sunrpc_syms.c linux-2.5.56-04-auth_upcall/net/sunrpc/sunrpc_syms.c
--- linux-2.5.56-03-rpc_encode/net/sunrpc/sunrpc_syms.c	2003-01-08 14:29:07.000000000 +0100
+++ linux-2.5.56-04-auth_upcall/net/sunrpc/sunrpc_syms.c	2003-01-12 22:39:49.000000000 +0100
@@ -22,6 +22,7 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/svcsock.h>
 #include <linux/sunrpc/auth.h>
+#include <linux/sunrpc/rpc_pipe_fs.h>
 
 
 /* RPC scheduler */
@@ -42,6 +43,7 @@
 EXPORT_SYMBOL(rpc_create_client);
 EXPORT_SYMBOL(rpc_destroy_client);
 EXPORT_SYMBOL(rpc_shutdown_client);
+EXPORT_SYMBOL(rpc_release_client);
 EXPORT_SYMBOL(rpc_killall_tasks);
 EXPORT_SYMBOL(rpc_call_sync);
 EXPORT_SYMBOL(rpc_call_async);
@@ -51,6 +53,11 @@
 EXPORT_SYMBOL(rpc_delay);
 EXPORT_SYMBOL(rpc_restart_call);
 EXPORT_SYMBOL(rpc_setbufsize);
+EXPORT_SYMBOL(rpc_unlink);
+EXPORT_SYMBOL(rpc_wake_up);
+EXPORT_SYMBOL(rpc_queue_upcall);
+EXPORT_SYMBOL(rpc_mkpipe);
+EXPORT_SYMBOL(__rpc_purge_current_upcall);
 
 /* Client transport */
 EXPORT_SYMBOL(xprt_create_proto);
@@ -126,11 +133,18 @@
 EXPORT_SYMBOL(nlm_debug);
 #endif
 
+extern int register_rpc_pipefs(void);
+extern void unregister_rpc_pipefs(void);
+
 static int __init
 init_sunrpc(void)
 {
-	if (rpc_init_mempool() != 0)
-		return -ENOMEM;
+	int err = register_rpc_pipefs();
+	if (err)
+		goto out;
+	err = rpc_init_mempool() != 0;
+	if (err)
+		goto out;
 #ifdef RPC_DEBUG
 	rpc_register_sysctl();
 #endif
@@ -139,12 +153,14 @@
 #endif
 	cache_register(&auth_domain_cache);
 	cache_register(&ip_map_cache);
-	return 0;
+out:
+	return err;
 }
 
 static void __exit
 cleanup_sunrpc(void)
 {
+	unregister_rpc_pipefs();
 	rpc_destroy_mempool();
 	cache_unregister(&auth_domain_cache);
 	cache_unregister(&ip_map_cache);
