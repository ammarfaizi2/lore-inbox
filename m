Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVEPToL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVEPToL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 15:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVEPToL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 15:44:11 -0400
Received: from peabody.ximian.com ([130.57.169.10]:63647 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261842AbVEPTin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 15:38:43 -0400
Subject: [patch] inotify update for 2.6-mm.
From: Robert Love <rml@novell.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mr Morton <akpm@osdl.org>
Cc: John McCutchan <ttb@tentacle.dhs.org>
In-Reply-To: <1116271318.6589.66.camel@betsy>
References: <1116271318.6589.66.camel@betsy>
Content-Type: text/plain
Date: Mon, 16 May 2005 15:38:42 -0400
Message-Id: <1116272322.6589.70.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 15:22 -0400, Robert Love wrote:

> Only changes since the last code release are
> 
> 	- Replace open-coded hook in sysfs with fsnotify
> 	- Replace open-coded hooks in nfsd with fsnotify
> 	- Misc. cleanup
> 
> E.g., a loud scream of "mature."

Here is an update against 2.6.12-rc4-mm2, bringing it up to date wrt the
latest inotify release.

In addition to the above, this update includes a few other optimizations
and cleanups.

Sir, please apply.

	Robert Love


Signed-Off-By: Robert Love <rml@novell.com>

 fs/inotify.c             |   21 ++++++++++++---------
 fs/nfsd/vfs.c            |    6 +++---
 fs/sysfs/file.c          |    7 ++-----
 include/linux/fsnotify.h |    4 ++--
 4 files changed, 19 insertions(+), 19 deletions(-)

diff -urN linux-2.6.12-rc4-mm2/fs/inotify.c linux-inotify/fs/inotify.c
--- linux-2.6.12-rc4-mm2/fs/inotify.c	2005-05-16 15:33:12.000000000 -0400
+++ linux-inotify/fs/inotify.c	2005-05-16 15:29:54.000000000 -0400
@@ -50,7 +50,7 @@
  * Lock ordering:
  *
  * dentry->d_lock (used to keep d_move() away from dentry->d_parent)
- * iprune_sem (synchronize versus shrink_icache_memory())
+ * iprune_sem (synchronize shrink_icache_memory())
  * 	inode_lock (protects the super_block->s_inodes list)
  * 	inode->inotify_sem (protects inode->inotify_watches and watches->i_list)
  * 		inotify_dev->sem (protects inotify_device and watches->d_list)
@@ -251,16 +251,16 @@
 			if (len % event_size == 0)
 				rem = 0;
 		}
-		len += rem;
 
-		kevent->name = kmalloc(len, GFP_KERNEL);
+		kevent->name = kmalloc(len + rem, GFP_KERNEL);
 		if (unlikely(!kevent->name)) {
 			kmem_cache_free(event_cachep, kevent);
 			return NULL;
 		}
-		memset(kevent->name, 0, len);
-		strncpy(kevent->name, name, strlen(name));
-		kevent->event.len = len;
+		memcpy(kevent->name, name, len);
+		if (rem)
+			memset(kevent->name + len, 0, rem);		
+		kevent->event.len = len + rem;
 	} else {
 		kevent->event.len = 0;
 		kevent->name = NULL;
@@ -293,9 +293,8 @@
 
 	/* coalescing: drop this event if it is a dupe of the previous */
 	last = inotify_dev_get_event(dev);
-	if (dev->event_count && last->event.mask == mask &&
-			last->event.cookie == cookie &&
-			last->event.wd == watch->wd) {
+	if (last && last->event.mask == mask && last->event.wd == watch->wd &&
+			last->event.cookie == cookie) {
 		const char *lastname = last->name;
 
 		if (!name && !lastname)
@@ -574,6 +573,9 @@
 		struct inotify_watch *watch, *next_w;
 		struct list_head *watches;
 
+		/* In case the remove_watch() drops a reference */
+		__iget(inode);
+
 		/*
 		 * We can safely drop inode_lock here because the per-sb list
 		 * of inodes must not change during unmount and iprune_sem
@@ -592,6 +594,7 @@
 			up(&dev->sem);
 		}
 		up(&inode->inotify_sem);
+		iput(inode);		
 
 		spin_lock(&inode_lock);
 	}
diff -urN linux-2.6.12-rc4-mm2/fs/nfsd/vfs.c linux-inotify/fs/nfsd/vfs.c
--- linux-2.6.12-rc4-mm2/fs/nfsd/vfs.c	2005-05-16 15:33:12.000000000 -0400
+++ linux-inotify/fs/nfsd/vfs.c	2005-05-16 15:30:14.000000000 -0400
@@ -45,7 +45,7 @@
 #endif /* CONFIG_NFSD_V3 */
 #include <linux/nfsd/nfsfh.h>
 #include <linux/quotaops.h>
-#include <linux/dnotify.h>
+#include <linux/fsnotify.h>
 #include <linux/xattr_acl.h>
 #include <linux/posix_acl.h>
 #ifdef CONFIG_NFSD_V4
@@ -862,7 +862,7 @@
 		nfsdstats.io_read += err;
 		*count = err;
 		err = 0;
-		dnotify_parent(file->f_dentry, DN_ACCESS);
+		fsnotify_access(file->f_dentry);
 	} else 
 		err = nfserrno(err);
 out:
@@ -918,7 +918,7 @@
 	set_fs(oldfs);
 	if (err >= 0) {
 		nfsdstats.io_write += cnt;
-		dnotify_parent(file->f_dentry, DN_MODIFY);
+		fsnotify_modify(file->f_dentry);
 	}
 
 	/* clear setuid/setgid flag after write */
diff -urN linux-2.6.12-rc4-mm2/fs/sysfs/file.c linux-inotify/fs/sysfs/file.c
--- linux-2.6.12-rc4-mm2/fs/sysfs/file.c	2005-05-16 15:33:12.000000000 -0400
+++ linux-inotify/fs/sysfs/file.c	2005-05-16 15:29:54.000000000 -0400
@@ -3,7 +3,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/dnotify.h>
+#include <linux/fsnotify.h>
 #include <linux/kobject.h>
 #include <linux/namei.h>
 #include <asm/uaccess.h>
@@ -390,9 +390,6 @@
  * sysfs_update_file - update the modified timestamp on an object attribute.
  * @kobj: object we're acting for.
  * @attr: attribute descriptor.
- *
- * Also call dnotify for the dentry, which lots of userspace programs
- * use.
  */
 int sysfs_update_file(struct kobject * kobj, const struct attribute * attr)
 {
@@ -407,7 +404,7 @@
 		if (victim->d_inode && 
 		    (victim->d_parent->d_inode == dir->d_inode)) {
 			victim->d_inode->i_mtime = CURRENT_TIME;
-			dnotify_parent(victim, DN_MODIFY);
+			fsnotify_modify(victim);
 
 			/**
 			 * Drop reference from initial sysfs_get_dentry().
diff -urN linux-2.6.12-rc4-mm2/include/linux/fsnotify.h linux-inotify/include/linux/fsnotify.h
--- linux-2.6.12-rc4-mm2/include/linux/fsnotify.h	2005-05-16 15:33:12.000000000 -0400
+++ linux-inotify/include/linux/fsnotify.h	2005-05-16 15:29:54.000000000 -0400
@@ -219,7 +219,7 @@
  *
  * XXX: This could be kstrdup if only we could add that to lib/string.c
  */
-static inline char *fsnotify_oldname_init(const char *name)
+static inline const char *fsnotify_oldname_init(const char *name)
 {
 	size_t len;
 	char *buf;
@@ -241,7 +241,7 @@
 
 #else	/* CONFIG_INOTIFY */
 
-static inline char *fsnotify_oldname_init(const char *name)
+static inline const char *fsnotify_oldname_init(const char *name)
 {
 	return NULL;
 }


