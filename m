Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWAITRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWAITRH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWAITRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:17:05 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:56497 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751059AbWAITRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:17:02 -0500
Subject: Re: [PATCH] protect remove_proc_entry
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <20060107033637.458c4716.akpm@osdl.org>
References: <1135973075.6039.63.camel@localhost.localdomain>
	 <1135978110.6039.81.camel@localhost.localdomain>
	 <20060107033637.458c4716.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 14:16:50 -0500
Message-Id: <1136834210.6197.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-07 at 03:36 -0800, Andrew Morton wrote:

> 
> Aren't there other places where we need to take this lock?  Code which
> traverses that list, code which adds things to it?
> 

Andrew,

How's this patch look?  I tested this with the following module:

http://www.kihontech.com/tests/proc/proc_stress.c

Without the patch, I could hang the processes (the processes would
either crash, or just get stuck spinning inside the list).  With the
patch, the module ran to completion each time.

I don't believe any of the calls are called from interrupt context, so I
held off from using the _irqsave versions of spin_lock.

-- Steve

Index: linux-2.6.15/fs/proc/generic.c
===================================================================
--- linux-2.6.15.orig/fs/proc/generic.c	2006-01-09 13:58:23.000000000 -0500
+++ linux-2.6.15/fs/proc/generic.c	2006-01-09 13:58:34.000000000 -0500
@@ -19,6 +19,7 @@
 #include <linux/idr.h>
 #include <linux/namei.h>
 #include <linux/bitops.h>
+#include <linux/spinlock.h>
 #include <asm/uaccess.h>
 
 static ssize_t proc_file_read(struct file *file, char __user *buf,
@@ -27,6 +28,8 @@
 			       size_t count, loff_t *ppos);
 static loff_t proc_file_lseek(struct file *, loff_t, int);
 
+DEFINE_SPINLOCK(proc_subdir_lock);
+
 int proc_match(int len, const char *name, struct proc_dir_entry *de)
 {
 	if (de->namelen != len)
@@ -275,7 +278,9 @@
 	const char     		*cp = name, *next;
 	struct proc_dir_entry	*de;
 	int			len;
+	int 			rtn = 0;
 
+	spin_lock(&proc_subdir_lock);
 	de = &proc_root;
 	while (1) {
 		next = strchr(cp, '/');
@@ -287,13 +292,17 @@
 			if (proc_match(len, cp, de))
 				break;
 		}
-		if (!de)
-			return -ENOENT;
+		if (!de) {
+			rtn = -ENOENT;
+			goto out;
+		}
 		cp += len + 1;
 	}
 	*residual = cp;
 	*ret = de;
-	return 0;
+out:
+	spin_unlock(&proc_subdir_lock);
+	return rtn;
 }
 
 static DEFINE_IDR(proc_inum_idr);
@@ -378,6 +387,7 @@
 	int error = -ENOENT;
 
 	lock_kernel();
+	spin_lock(&proc_subdir_lock);
 	de = PDE(dir);
 	if (de) {
 		for (de = de->subdir; de ; de = de->next) {
@@ -386,12 +396,15 @@
 			if (!memcmp(dentry->d_name.name, de->name, de->namelen)) {
 				unsigned int ino = de->low_ino;
 
+				spin_unlock(&proc_subdir_lock);
 				error = -EINVAL;
 				inode = proc_get_inode(dir->i_sb, ino, de);
+				spin_lock(&proc_subdir_lock);
 				break;
 			}
 		}
 	}
+	spin_unlock(&proc_subdir_lock);
 	unlock_kernel();
 
 	if (inode) {
@@ -445,11 +458,13 @@
 			filp->f_pos++;
 			/* fall through */
 		default:
+			spin_lock(&proc_subdir_lock);
 			de = de->subdir;
 			i -= 2;
 			for (;;) {
 				if (!de) {
 					ret = 1;
+					spin_unlock(&proc_subdir_lock);
 					goto out;
 				}
 				if (!i)
@@ -459,12 +474,16 @@
 			}
 
 			do {
+				/* filldir passes info to user space */
+				spin_unlock(&proc_subdir_lock);
 				if (filldir(dirent, de->name, de->namelen, filp->f_pos,
 					    de->low_ino, de->mode >> 12) < 0)
 					goto out;
+				spin_lock(&proc_subdir_lock);
 				filp->f_pos++;
 				de = de->next;
 			} while (de);
+			spin_unlock(&proc_subdir_lock);
 	}
 	ret = 1;
 out:	unlock_kernel();
@@ -498,9 +517,13 @@
 	if (i == 0)
 		return -EAGAIN;
 	dp->low_ino = i;
+
+	spin_lock(&proc_subdir_lock);
 	dp->next = dir->subdir;
 	dp->parent = dir;
 	dir->subdir = dp;
+	spin_unlock(&proc_subdir_lock);
+
 	if (S_ISDIR(dp->mode)) {
 		if (dp->proc_iops == NULL) {
 			dp->proc_fops = &proc_dir_operations;
@@ -692,6 +715,8 @@
 	if (!parent && xlate_proc_name(name, &parent, &fn) != 0)
 		goto out;
 	len = strlen(fn);
+
+	spin_lock(&proc_subdir_lock);
 	for (p = &parent->subdir; *p; p=&(*p)->next ) {
 		if (!proc_match(len, fn, *p))
 			continue;
@@ -712,6 +737,7 @@
 		}
 		break;
 	}
+	spin_unlock(&proc_subdir_lock);
 out:
 	return;
 }
Index: linux-2.6.15/fs/proc/proc_devtree.c
===================================================================
--- linux-2.6.15.orig/fs/proc/proc_devtree.c	2006-01-09 13:58:23.000000000 -0500
+++ linux-2.6.15/fs/proc/proc_devtree.c	2006-01-09 14:05:10.000000000 -0500
@@ -112,9 +112,11 @@
 		 * properties are quite unimportant for us though, thus we
 		 * simply "skip" them here, but we do have to check.
 		 */
+		spin_lock(&proc_subdir_lock);
 		for (ent = de->subdir; ent != NULL; ent = ent->next)
 			if (!strcmp(ent->name, pp->name))
 				break;
+		spin_unlock(&proc_subdir_lock);
 		if (ent != NULL) {
 			printk(KERN_WARNING "device-tree: property \"%s\" name"
 			       " conflicts with node in %s\n", pp->name,
Index: linux-2.6.15/include/linux/proc_fs.h
===================================================================
--- linux-2.6.15.orig/include/linux/proc_fs.h	2006-01-09 08:59:13.000000000 -0500
+++ linux-2.6.15/include/linux/proc_fs.h	2006-01-09 14:07:09.000000000 -0500
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/spinlock.h>
 #include <asm/atomic.h>
 
 /*
@@ -92,6 +93,8 @@
 extern struct proc_dir_entry *proc_root_driver;
 extern struct proc_dir_entry *proc_root_kcore;
 
+extern spinlock_t proc_subdir_lock;
+
 extern void proc_root_init(void);
 extern void proc_misc_init(void);
 


