Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935092AbWKXVvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935092AbWKXVvo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935091AbWKXVvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:51:43 -0500
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:12229 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S935090AbWKXVvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:51:42 -0500
Date: Fri, 24 Nov 2006 16:51:40 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: [PATCH 1/16] LTTng 0.6.36 for 2.6.18 : debugfs fix
Message-ID: <20061124215140.GB25048@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:48:35 up 93 days, 18:56,  4 users,  load average: 0.21, 0.29, 0.24
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch against 2.6.19-rc6 already submitted to Greg Kroah-Hartman in tiny
pieces for inclusion.

patch01-2.6.18-lttng-core-0.6.36-debugfs.diff
--BEGIN--
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -23,6 +23,7 @@ #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/namei.h>
 #include <linux/debugfs.h>
+#include <linux/fsnotify.h>
 
 #define DEBUGFS_MAGIC	0x64626720
 
@@ -54,7 +55,8 @@ static struct inode *debugfs_get_inode(s
 			inode->i_op = &simple_dir_inode_operations;
 			inode->i_fop = &simple_dir_operations;
 
-			/* directory inodes start off with i_nlink == 2 (for "." entry) */
+			/* directory inodes start off with i_nlink == 2
+			 * (for "." entry) */
 			inode->i_nlink++;
 			break;
 		}
@@ -87,15 +89,22 @@ static int debugfs_mkdir(struct inode *d
 
 	mode = (mode & (S_IRWXUGO | S_ISVTX)) | S_IFDIR;
 	res = debugfs_mknod(dir, dentry, mode, 0);
-	if (!res)
+	if (!res) {
 		dir->i_nlink++;
+		fsnotify_mkdir(dir, dentry);
+	}
 	return res;
 }
 
 static int debugfs_create(struct inode *dir, struct dentry *dentry, int mode)
 {
+	int res;
+
 	mode = (mode & S_IALLUGO) | S_IFREG;
-	return debugfs_mknod(dir, dentry, mode, 0);
+	res = debugfs_mknod(dir, dentry, mode, 0);
+	if (!res)
+		fsnotify_create(dir, dentry);
+	return res;
 }
 
 static inline int debugfs_positive(struct dentry *dentry)
@@ -135,7 +144,7 @@ static int debugfs_create_by_name(const 
 	 * block. A pointer to that is in the struct vfsmount that we
 	 * have around.
 	 */
-	if (!parent ) {
+	if (!parent) {
 		if (debugfs_mount && debugfs_mount->mnt_sb) {
 			parent = debugfs_mount->mnt_sb->s_root;
 		}
@@ -153,10 +162,10 @@ static int debugfs_create_by_name(const 
 			error = debugfs_mkdir(parent->d_inode, *dentry, mode);
 		else 
 			error = debugfs_create(parent->d_inode, *dentry, mode);
+		dput(*dentry);
 	} else
 		error = PTR_ERR(dentry);
 	mutex_unlock(&parent->d_inode->i_mutex);
-
 	return error;
 }
 
@@ -198,13 +207,15 @@ struct dentry *debugfs_create_file(const
 
 	pr_debug("debugfs: creating file '%s'\n",name);
 
-	error = simple_pin_fs(&debug_fs_type, &debugfs_mount, &debugfs_mount_count);
+	error = simple_pin_fs(&debug_fs_type, &debugfs_mount,
+		&debugfs_mount_count);
 	if (error)
 		goto exit;
 
 	error = debugfs_create_by_name(name, mode, parent, &dentry);
 	if (error) {
 		dentry = NULL;
+		simple_release_fs(&debugfs_mount, &debugfs_mount_count);
 		goto exit;
 	}
 
@@ -265,6 +276,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_dir);
 void debugfs_remove(struct dentry *dentry)
 {
 	struct dentry *parent;
+	int ret = 0;
 	
 	if (!dentry)
 		return;
@@ -276,11 +288,19 @@ void debugfs_remove(struct dentry *dentr
 	mutex_lock(&parent->d_inode->i_mutex);
 	if (debugfs_positive(dentry)) {
 		if (dentry->d_inode) {
-			if (S_ISDIR(dentry->d_inode->i_mode))
-				simple_rmdir(parent->d_inode, dentry);
-			else
+			dget(dentry);
+			if (S_ISDIR(dentry->d_inode->i_mode)) {
+				ret = simple_rmdir(parent->d_inode, dentry);
+				if (ret)
+					printk(KERN_ERR
+						"DebugFS rmdir on %s failed : "
+						"directory not empty.\n",
+						dentry->d_name.name);
+			} else
 				simple_unlink(parent->d_inode, dentry);
-		dput(dentry);
+			if (!ret)
+				d_delete(dentry);
+			dput(dentry);
 		}
 	}
 	mutex_unlock(&parent->d_inode->i_mutex);
--END--




OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
