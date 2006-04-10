Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWDJXOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWDJXOj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 19:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWDJXOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 19:14:39 -0400
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:44769 "EHLO
	imf18aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S932192AbWDJXOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 19:14:38 -0400
Subject: [PATCH 2.6.17-rc1] procfs control to cue lockd to release all
	locks on a single device
From: Jeff Layton <jtlayton@poochiereds.net>
To: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ha@lists.linux-ha.org
Content-Type: text/plain
Date: Mon, 10 Apr 2006 19:14:40 -0400
Message-Id: <1144710880.5653.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's been a long standing problem with Linux' NFS implementation. If
a client has active POSIX locks on a filesystem, the server cannot
unmount the underlying device even if it has unexported it and killed
any userspace processes that are actively working in it. This is
especially a problem in clustered NFS setups, as it can prevent a
successful failover from occurring.

There is an existing workaround, which is to send a SIGKILL to lockd.
Unfortunately, that makes it drop all of its locks -- even ones on
filesystems that aren't failing over. This is bad in a cluster with
multiple NFS services that fail over independently, or on hosts with a
mix of clustered and non-clustered NFS shares.

This patch attempts to remedy this by adding a new procfs file
(/proc/fs/lockd/release_device). Echoing the dev_t value of the block
device with the underlying filesystem will tell lockd to drop all locks
on that device. I considered implementing this via sysfs or configfs,
but it wasn't clear to me how this would fall into the heirarchy of
either.

I've tested this and it works correctly. Comments and suggestions are
welcome.

Signed-off-by: Jeff Layton <jtlayton@poochiereds.net>


diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -34,11 +34,15 @@
 #include <linux/sunrpc/svcsock.h>
 #include <linux/lockd/lockd.h>
 #include <linux/nfs.h>
+#include <asm/uaccess.h>
 
 #define NLMDBG_FACILITY		NLMDBG_SVC
 #define LOCKD_BUFSIZE		(1024 + NLMSVC_XDRSIZE)
 #define ALLOWED_SIGS		(sigmask(SIGKILL))
 
+/* string representation of dev_t shouldn't be larger than this */
+#define DEV_T_STRLEN		13
+
 static struct svc_program	nlmsvc_program;
 
 struct nlmsvc_binding *		nlmsvc_ops;
@@ -71,6 +75,7 @@ static const unsigned long	nlm_timeout_m
 static const int		nlm_port_min = 0, nlm_port_max = 65535;
 
 static struct ctl_table_header * nlm_sysctl_table;
+static struct proc_dir_entry *lockd_dir,*release_device_file;
 
 static unsigned long set_grace_period(void)
 {
@@ -391,6 +396,33 @@ static ctl_table nlm_sysctl_root[] = {
 	{ .ctl_name = 0 }
 };
 
+/* function for release_device procfs control */
+static int proc_write_release_device(struct file *file, const char *buffer,
+				     unsigned long count, void *data)
+{
+	int len;
+	dev_t device;
+	char kdev_str[DEV_T_STRLEN];
+
+	if(count > DEV_T_STRLEN)
+		len = DEV_T_STRLEN;
+	else
+		len = count;
+
+	if (copy_from_user(&kdev_str, buffer, len))
+		return -EFAULT;
+
+	kdev_str[len] = '\0';
+	device = (dev_t)(simple_strtoul((const char *) &kdev_str, NULL, 0));
+
+	if (device) {
+		dprintk("lockd: releasing all locks on 0x%x\n",device);	
+		nlmsvc_release_device(device);
+	}
+
+	return len;
+}
+
 /*
  * Module (and driverfs) parameters.
  */
@@ -463,14 +495,46 @@ module_param_call(nlm_tcpport, param_set
 
 static int __init init_nlm(void)
 {
+	int rv = 0;
+
 	nlm_sysctl_table = register_sysctl_table(nlm_sysctl_root, 0);
-	return nlm_sysctl_table ? 0 : -ENOMEM;
+	if (! nlm_sysctl_table) {
+		rv = -ENOMEM;
+		goto out;
+	}
+
+	lockd_dir = proc_mkdir("fs/lockd",NULL);
+	if (! lockd_dir) {
+		rv = -ENOMEM;
+		goto no_lockd_dir;
+	}
+	lockd_dir->owner=THIS_MODULE;
+
+	release_device_file = create_proc_entry("release_device", 0200,
+						lockd_dir);
+	if (!release_device_file) {
+		rv = -ENOMEM;
+		goto no_release_device_file;
+	}
+
+	release_device_file->write_proc = proc_write_release_device;
+	release_device_file->owner = THIS_MODULE;
+	goto out;
+
+no_release_device_file:
+	remove_proc_entry("fs/lockd", NULL);
+no_lockd_dir:
+	unregister_sysctl_table(nlm_sysctl_table);
+out:
+	return rv;
 }
 
 static void __exit exit_nlm(void)
 {
 	/* FIXME: delete all NLM clients */
 	nlm_shutdown_hosts();
+	remove_proc_entry("release_device",lockd_dir);
+	remove_proc_entry("fs/lockd", NULL);
 	unregister_sysctl_table(nlm_sysctl_table);
 }
 
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -235,7 +235,7 @@ nlm_inspect_file(struct nlm_host *host, 
  * Loop over all files in the file table.
  */
 static int
-nlm_traverse_files(struct nlm_host *host, int action)
+nlm_traverse_files(struct nlm_host *host, dev_t device, int action)
 {
 	struct nlm_file	*file, **fp;
 	int		i;
@@ -244,6 +244,13 @@ nlm_traverse_files(struct nlm_host *host
 	for (i = 0; i < FILE_NRHASH; i++) {
 		fp = nlm_files + i;
 		while ((file = *fp) != NULL) {
+
+			if (device &&
+			    nlmsvc_file_inode(file)->i_sb->s_dev != device) {
+				fp = &file->f_next;
+				continue;
+			}
+
 			/* Traverse locks, blocks and shares of this file
 			 * and update file->f_locks count */
 			if (nlm_inspect_file(host, file, action)) {
@@ -301,7 +308,7 @@ nlmsvc_mark_resources(void)
 {
 	dprintk("lockd: nlmsvc_mark_resources\n");
 
-	nlm_traverse_files(NULL, NLM_ACT_MARK);
+	nlm_traverse_files(NULL, 0, NLM_ACT_MARK);
 }
 
 /*
@@ -312,7 +319,7 @@ nlmsvc_free_host_resources(struct nlm_ho
 {
 	dprintk("lockd: nlmsvc_free_host_resources\n");
 
-	if (nlm_traverse_files(host, NLM_ACT_UNLOCK))
+	if (nlm_traverse_files(host, 0, NLM_ACT_UNLOCK))
 		printk(KERN_WARNING
 			"lockd: couldn't remove all locks held by %s",
 			host->h_name);
@@ -332,3 +339,16 @@ nlmsvc_invalidate_all(void)
 		nlm_release_host(host);
 	}
 }
+
+/*
+ * release all locks on the given device
+ */
+void
+nlmsvc_release_device(dev_t device)
+{
+	dprintk("lockd: nlmsvc_release_device\n");
+	if (nlm_traverse_files(NULL, device, NLM_ACT_UNLOCK))
+		printk(KERN_WARNING
+			"lockd: couldn't remove all locks on device %x\n",
+			device);
+}
diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -30,6 +30,7 @@ extern struct nlmsvc_binding *	nlmsvc_op
  * Functions exported by the lockd module
  */
 extern int	nlmclnt_proc(struct inode *, int, struct file_lock *);
+extern void	nlmsvc_release_device(dev_t device);
 extern int	lockd_up(void);
 extern void	lockd_down(void);
 


