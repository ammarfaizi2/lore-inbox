Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263790AbUECQuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263790AbUECQuq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 12:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbUECQuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 12:50:46 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:12497 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263790AbUECQuk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 12:50:40 -0400
Subject: [PATCH][SELINUX] Re-open descriptors closed on exec by SELinux to
	/dev/null
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1083603014.7446.197.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 03 May 2004 12:50:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.6-rc3 changes the SELinux module to try to reset
any descriptors it closes on exec (due to a lack of permission by the
new domain to the inherited open file) to refer to the null device. 
This counters the problem of SELinux inducing program misbehavior,
particularly due to having descriptors 0-2 closed when the new domain is
not allowed access to the caller's tty.  This is primarily to address
the case where the caller is trusted with respect to the new domain, as
the untrusted caller case is already handled via AT_SECURE and glibc
secure mode.  The code is partly based on the OpenWall LSM, which in
turn drew from the OpenWall kernel patch.  Note that the code does not
guarantee that the descriptor is always re-opened to /dev/null; it
merely makes a reasonable effort to do so, but can fail under various
conditions.
Please apply.

 security/selinux/hooks.c                         |   85 ++++++++++++++++++++++-
 security/selinux/include/flask.h                 |    3 
 security/selinux/include/initial_sid_to_string.h |    1 
 3 files changed, 85 insertions(+), 4 deletions(-)

diff -X /home/sds/dontdiff -ru linux-2.6/security/selinux/hooks.c linux-2.6.new/security/selinux/hooks.c
--- linux-2.6/security/selinux/hooks.c	2004-04-30 14:12:43.042622889 -0400
+++ linux-2.6.new/security/selinux/hooks.c	2004-04-30 13:50:48.000000000 -0400
@@ -62,6 +62,7 @@
 #include <linux/nfs_mount.h>
 #include <net/ipv6.h>
 #include <linux/hugetlb.h>
+#include <linux/major.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -1712,18 +1713,77 @@
 	kfree(bsec);
 }
 
+/* Create an open file that refers to the null device.
+   Derived from the OpenWall LSM. */
+struct file *open_devnull(void) 
+{
+	struct inode *inode;
+	struct dentry *dentry;
+	struct file *file = NULL;
+	struct inode_security_struct *isec;
+	dev_t dev;
+
+	inode = new_inode(current->fs->rootmnt->mnt_sb);
+	if (!inode)
+		goto out;
+
+	dentry = dget(d_alloc_root(inode));
+	if (!dentry)
+		goto out_iput;
+
+	file = get_empty_filp();
+	if (!file)
+		goto out_dput;
+
+	dev = MKDEV(MEM_MAJOR, 3); /* null device */
+
+	inode->i_uid = current->fsuid;
+	inode->i_gid = current->fsgid;
+	inode->i_blksize = PAGE_SIZE;
+	inode->i_blocks = 0;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_state = I_DIRTY; /* so that mark_inode_dirty won't touch us */
+
+	isec = inode->i_security;
+	isec->sid = SECINITSID_DEVNULL;
+	isec->sclass = SECCLASS_CHR_FILE;
+	isec->initialized = 1;
+
+	file->f_flags = O_RDWR;
+	file->f_mode = FMODE_READ | FMODE_WRITE;
+	file->f_dentry = dentry;
+	file->f_vfsmnt = mntget(current->fs->rootmnt);
+	file->f_pos = 0;
+
+	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO, dev);
+	if (inode->i_fop->open(inode, file))
+		goto out_fput;
+
+out:
+	return file;
+out_fput:
+	mntput(file->f_vfsmnt);
+	put_filp(file);
+out_dput:	
+	dput(dentry);
+out_iput:	
+	iput(inode);
+	file = NULL;
+	goto out;
+}
+	
 /* Derived from fs/exec.c:flush_old_files. */
 static inline void flush_unauthorized_files(struct files_struct * files)
 {
 	struct avc_audit_data ad;
-	struct file *file;
+	struct file *file, *devnull = NULL;
 	long j = -1;
 
 	AVC_AUDIT_DATA_INIT(&ad,FS);
 
 	spin_lock(&files->file_lock);
 	for (;;) {
-		unsigned long set, i;
+		unsigned long set, i, fd;
 
 		j++;
 		i = j * __NFDBITS;
@@ -1740,8 +1800,27 @@
 					continue;
 				if (file_has_perm(current,
 						  file,
-						  file_to_av(file)))
+						  file_to_av(file))) {
 					sys_close(i);
+					fd = get_unused_fd();
+					if (fd != i) {
+						if (fd >= 0)
+							put_unused_fd(fd);
+						fput(file);
+						continue;
+					}
+					if (devnull) {
+						atomic_inc(&devnull->f_count);
+					} else {
+						devnull = open_devnull();
+						if (!devnull) {
+							put_unused_fd(fd);
+							fput(file);
+							continue;
+						}
+					}
+					fd_install(fd, devnull);
+				}
 				fput(file);
 			}
 		}
diff -X /home/sds/dontdiff -ru linux-2.6/security/selinux/include/flask.h linux-2.6.new/security/selinux/include/flask.h
--- linux-2.6/security/selinux/include/flask.h	2003-08-12 09:05:09.000000000 -0400
+++ linux-2.6.new/security/selinux/include/flask.h	2004-04-30 13:47:59.000000000 -0400
@@ -65,7 +65,8 @@
 #define SECINITSID_KMOD                                 24
 #define SECINITSID_POLICY                               25
 #define SECINITSID_SCMP_PACKET                          26
+#define SECINITSID_DEVNULL                              27
 
-#define SECINITSID_NUM                                  26
+#define SECINITSID_NUM                                  27
 
 #endif
diff -X /home/sds/dontdiff -ru linux-2.6/security/selinux/include/initial_sid_to_string.h linux-2.6.new/security/selinux/include/initial_sid_to_string.h
--- linux-2.6/security/selinux/include/initial_sid_to_string.h	2003-08-12 09:05:09.000000000 -0400
+++ linux-2.6.new/security/selinux/include/initial_sid_to_string.h	2004-04-30 13:48:10.000000000 -0400
@@ -28,5 +28,6 @@
     "kmod",
     "policy",
     "scmp_packet",
+    "devnull",
 };
 


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

