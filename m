Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753461AbWKCTWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbWKCTWm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 14:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753486AbWKCTWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 14:22:42 -0500
Received: from smtpproxy1.mitre.org ([192.160.51.76]:11466 "EHLO
	smtp-bedford.mitre.org") by vger.kernel.org with ESMTP
	id S1753461AbWKCTWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 14:22:41 -0500
Date: Fri, 3 Nov 2006 14:22:39 -0500 (EST)
From: Mark Workman <mworkman@linus.mitre.org>
To: sgrubb@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19-rc4] audit: support for descriptor pairs
Message-ID: <Pine.GSO.4.51.0611031340250.6889@linus.mitre.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

provide an audit record of the descriptor pair returned by pipe() and
socketpair().

Signed-off-by: Jeremy Latt <jlatt@faceprint.com>
Signed-off-by: Steven Trieber <spt@mitre.org>
Signed-off-by: Mark Workman <mworkman@mitre.org>

---
 fs/pipe.c             |    7 ++++++
 include/linux/audit.h |    9 ++++++++
 kernel/auditsc.c      |   40 ++++++++++++++++++++++++++++++++++++
 net/socket.c          |   55 +++++++++++++++++++++++++++++++++++++++-----------
 4 files changed, 99 insertions(+), 12 deletions(-)
---
diff -uprN -X a/Documentation/dontdiff a/fs/pipe.c b/fs/pipe.c
--- a/fs/pipe.c	2006-10-31 16:03:48.000000000 -0500
+++ b/fs/pipe.c	2006-10-31 16:10:50.000000000 -0500
@@ -16,6 +16,7 @@
 #include <linux/uio.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
+#include <linux/audit.h>

 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
@@ -972,6 +973,10 @@ int do_pipe(int *fd)
 		goto err_fdr;
 	fdw = error;

+ 	error = audit_fd_pair(fdr, fdw);
+ 	if (error < 0)
+ 		goto err_fdw;
+
 	fd_install(fdr, fr);
 	fd_install(fdw, fw);
 	fd[0] = fdr;
@@ -979,6 +984,8 @@ int do_pipe(int *fd)

 	return 0;

+ err_fdw:
+	put_unused_fd(fdw);
  err_fdr:
 	put_unused_fd(fdr);
  err_read_pipe:
diff -uprN -X a/Documentation/dontdiff a/include/linux/audit.h b/include/linux/audit.h
--- a/include/linux/audit.h	2006-10-31 16:03:48.000000000 -0500
+++ b/include/linux/audit.h	2006-10-31 16:10:50.000000000 -0500
@@ -89,6 +89,7 @@
 #define AUDIT_MQ_NOTIFY		1314	/* POSIX MQ notify record type */
 #define AUDIT_MQ_GETSETATTR	1315	/* POSIX MQ get/set attribute record type */
 #define AUDIT_KERNEL_OTHER	1316	/* For use by 3rd party modules */
+#define AUDIT_FD_PAIR		1317    /* audit record for pipe/socketpair */

 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
@@ -382,6 +383,7 @@ extern int __audit_ipc_set_perm(unsigned
 extern int audit_bprm(struct linux_binprm *bprm);
 extern int audit_socketcall(int nargs, unsigned long *args);
 extern int audit_sockaddr(int len, void *addr);
+extern int __audit_fd_pair(int fd1, int fd2);
 extern int audit_avc_path(struct dentry *dentry, struct vfsmount *mnt);
 extern int audit_set_macxattr(const char *name);
 extern int __audit_mq_open(int oflag, mode_t mode, struct mq_attr __user *u_attr);
@@ -396,6 +398,12 @@ static inline int audit_ipc_obj(struct k
 		return __audit_ipc_obj(ipcp);
 	return 0;
 }
+static inline int audit_fd_pair(int fd1, int fd2)
+{
+	if (unlikely(!audit_dummy_context()))
+		return __audit_fd_pair(fd1, fd2);
+	return 0;
+}
 static inline int audit_ipc_set_perm(unsigned long qbytes, uid_t uid, gid_t gid, mode_t mode)
 {
 	if (unlikely(!audit_dummy_context()))
@@ -453,6 +461,7 @@ extern int audit_n_rules;
 #define audit_ipc_set_perm(q,u,g,m) ({ 0; })
 #define audit_bprm(p) ({ 0; })
 #define audit_socketcall(n,a) ({ 0; })
+#define audit_fd_pair(n,a) ({ 0; })
 #define audit_sockaddr(len, addr) ({ 0; })
 #define audit_avc_path(dentry, mnt) ({ 0; })
 #define audit_set_macxattr(n) do { ; } while (0)
diff -uprN -X a/Documentation/dontdiff a/kernel/auditsc.c b/kernel/auditsc.c
--- a/kernel/auditsc.c	2006-10-31 16:03:48.000000000 -0500
+++ b/kernel/auditsc.c	2006-10-31 16:10:50.000000000 -0500
@@ -169,6 +169,11 @@ struct audit_aux_data_sockaddr {
 	char			a[0];
 };

+struct audit_aux_data_fd_pair {
+	struct	audit_aux_data d;
+	int	fd[2];
+};
+
 struct audit_aux_data_path {
 	struct audit_aux_data	d;
 	struct dentry		*dentry;
@@ -956,6 +961,11 @@ static void audit_log_exit(struct audit_
 			audit_log_d_path(ab, "path=", axi->dentry, axi->mnt);
 			break; }

+		case AUDIT_FD_PAIR: {
+			struct audit_aux_data_fd_pair *axs = (void *)aux;
+			audit_log_format(ab, "fd0=%d fd1=%d", axs->fd[0], axs->fd[1]);
+			break; }
+
 		}
 		audit_log_end(ab);
 	}
@@ -1808,6 +1818,36 @@ int audit_socketcall(int nargs, unsigned
 }

 /**
+ * __audit_fd_pair - record audit data for pipe and socketpair
+ * @fd1: the first file descriptor
+ * @fd2: the second file descriptor
+ *
+ * Returns 0 for success or NULL context or < 0 on error.
+ */
+int __audit_fd_pair(int fd1, int fd2)
+{
+	struct audit_context *context = current->audit_context;
+	struct audit_aux_data_fd_pair *ax;
+
+	if (likely(!context)) {
+		return 0;
+	}
+
+	ax = kmalloc(sizeof(*ax), GFP_KERNEL);
+	if (!ax) {
+		return -ENOMEM;
+	}
+
+	ax->fd[0] = fd1;
+	ax->fd[1] = fd2;
+
+	ax->d.type = AUDIT_FD_PAIR;
+	ax->d.next = context->aux;
+	context->aux = (void *)ax;
+	return 0;
+}
+
+/**
  * audit_sockaddr - record audit data for sys_bind, sys_connect, sys_sendto
  * @len: data length in user space
  * @a: data address in kernel space
diff -uprN -X a/Documentation/dontdiff a/net/socket.c b/net/socket.c
--- a/net/socket.c	2006-10-31 16:03:49.000000000 -0500
+++ b/net/socket.c	2006-11-03 14:19:46.000000000 -0500
@@ -393,6 +393,47 @@ int sock_map_fd(struct socket *sock)
 	return fd;
 }

+int sock_map_fd_pair(struct socket *sock1, struct socket *sock2, int *fd1, int *fd2)
+{
+	int err;
+	struct file *newfile1;
+	struct file *newfile2;
+
+	*fd1 = err = sock_alloc_fd(&newfile1);
+	if (unlikely(*fd1 < 0))
+		return err;
+
+	err = sock_attach_fd(sock1, newfile1);
+	if (unlikely(err < 0))
+		goto err_f1;
+
+	*fd2 = err = sock_alloc_fd(&newfile2);
+	if (unlikely(*fd2 < 0))
+		goto err_f1;
+
+	err = sock_attach_fd(sock2, newfile2);
+	if (unlikely(err < 0))
+		goto err_f2;
+
+	err = audit_fd_pair(*fd1, *fd2);
+	if (err < 0)
+		goto err_f2;
+
+	fd_install(*fd1, newfile1);
+	fd_install(*fd2, newfile2);
+
+	return 0;
+
+err_f2:
+	fput(newfile2);
+	put_unused_fd(*fd2);
+
+err_f1:
+	fput(newfile1);
+	put_unused_fd(*fd1);
+	return (err);
+}
+
 static struct socket *sock_from_file(struct file *file, int *err)
 {
 	struct inode *inode;
@@ -1220,15 +1261,9 @@ asmlinkage long sys_socketpair(int famil

 	fd1 = fd2 = -1;

-	err = sock_map_fd(sock1);
+	err = sock_map_fd_pair(sock1, sock2, &fd1, &fd2);
 	if (err < 0)
 		goto out_release_both;
-	fd1 = err;
-
-	err = sock_map_fd(sock2);
-	if (err < 0)
-		goto out_close_1;
-	fd2 = err;

 	/* fd1 and fd2 may be already another descriptors.
 	 * Not kernel problem.
@@ -1244,11 +1279,6 @@ asmlinkage long sys_socketpair(int famil
 	sys_close(fd1);
 	return err;

-out_close_1:
-	sock_release(sock2);
-	sys_close(fd1);
-	return err;
-
 out_release_both:
 	sock_release(sock2);
 out_release_1:
@@ -2259,6 +2289,7 @@ EXPORT_SYMBOL(sock_create);
 EXPORT_SYMBOL(sock_create_kern);
 EXPORT_SYMBOL(sock_create_lite);
 EXPORT_SYMBOL(sock_map_fd);
+EXPORT_SYMBOL(sock_map_fd_pair);
 EXPORT_SYMBOL(sock_recvmsg);
 EXPORT_SYMBOL(sock_register);
 EXPORT_SYMBOL(sock_release);
