Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVECSut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVECSut (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 14:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVECSut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 14:50:49 -0400
Received: from peabody.ximian.com ([130.57.169.10]:35007 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261566AbVECStH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 14:49:07 -0400
Subject: [patch] 2.6-mm inotify update
From: Robert Love <rml@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John McCutchan <ttb@tentacle.dhs.org>
Content-Type: text/plain
Date: Tue, 03 May 2005 14:48:29 -0400
Message-Id: <1115146110.6734.5.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Following patch is an update (not a replacement, I'll send that next if
you prefer) to inotify in 2.6.12-rc3-mm2.  Please apply.

This patch contains the following changes:

        - Add a "Rationale" section to the inotify documentation and
        move the design FAQ there from the ChangeLog.  We'll just stuff
        every conceivable design question in the documentation for all
        eternity.
        
        - Mask out the user-space mask, allowing only legal bits to be
        set on a new watch.  Return EINVAL if nothing is left.
        
        - New default limits: 8192 watches, 128 devices, and 8192
        events.  This is an increase in events, which take up very
        little room, and a decrease in watches.
        
        - Add the  IN_ISDIR flag.  For any event, the presence of this
        flag delineates whether the event occurred to a directory or a
        file.  This allows us to remove the _FILE and _SUBDIR events.
        
        - Misc. cleanup and optimizations

Please, apply.

	Robert Love


Signed-off-by: Robert Love <rml@novell.com>

 Documentation/filesystems/inotify.txt |   42 +++++++++++++
 fs/inotify.c                          |   23 ++++---
 fs/namei.c                            |    6 -
 include/linux/fsnotify.h              |  105 +++++++++++++++++++++-------------
 include/linux/inotify.h               |   12 +--
 5 files changed, 130 insertions(+), 58 deletions(-)

diff -urN linux-2.6.12-rc3-mm2/Documentation/filesystems/inotify.txt linux/Documentation/filesystems/inotify.txt
--- linux-2.6.12-rc3-mm2/Documentation/filesystems/inotify.txt	2005-05-03 12:59:46.000000000 -0400
+++ linux/Documentation/filesystems/inotify.txt	2005-05-03 13:02:22.000000000 -0400
@@ -79,3 +79,45 @@
 off of each associated device and each associated inode.
 
 See fs/inotify.c for the locking and lifetime rules.
+
+
+(iii) Rationale
+
+Q: What is the design decision behind not tying the watch to the
+open fd of the watched object?
+
+A: Watches are associated with an open inotify device, not an
+open file.  This solves the primary problem with dnotify:
+keeping the file open pins the file and thus, worse, pins the
+mount.  Dnotify is therefore infeasible for use on a desktop
+system with removable media as the media cannot be unmounted.
+
+Q: What is the design decision behind using an-fd-per-device as
+opposed to an fd-per-watch?
+
+A: An fd-per-watch quickly consumes more file descriptors than
+are allowed, more fd's than are feasible to manage, and more
+fd's than are ideally select()-able.  Yes, root can bump the
+per-process fd limit and yes, users can use epoll, but requiring
+both is silly and an extraneous requirement.  A watch consumes
+less memory than an open file, separating the number spaces is
+thus sensible.  The current design is what user-space developers
+want: Users open the device, once, and add n watches, requiring
+but one fd and no twiddling with fd limits.
+Opening /dev/inotify two thousand times is silly.  If we can
+implement user-space's preferences cleanly--and we can, the idr
+layer makes stuff like this trivial--then we should.
+
+Q: Why a device node?
+
+A: The second biggest problem with dnotify is that the user
+interface sucks ass.  Signals are a terrible, terrible interface
+for file notification.  Or for anything, for that matter.  The
+idea solution, from all perspectives, is a file descriptor based
+one that allows basic file I/O and poll/select.  Obtaining the
+fd and managing the watches could of been done either via a
+device file or a family of new system calls.  We decided to
+implement a device file because adding three or four new system
+calls that mirrored open, close, and ioctl seemed silly.  A
+character device makes sense from user-space and was easy to
+implement inside of the kernel.
diff -urN linux-2.6.12-rc3-mm2/fs/inotify.c linux/fs/inotify.c
--- linux-2.6.12-rc3-mm2/fs/inotify.c	2005-05-03 12:59:49.000000000 -0400
+++ linux/fs/inotify.c	2005-05-03 13:02:22.000000000 -0400
@@ -361,7 +361,7 @@
  * Callers must hold dev->sem.  This function can sleep.
  */
 static int inotify_dev_get_wd(struct inotify_device *dev,
-			     struct inotify_watch *watch)
+			      struct inotify_watch *watch)
 {
 	int ret;
 
@@ -734,7 +734,6 @@
 	INIT_LIST_HEAD(&dev->watches);
 	init_waitqueue_head(&dev->wq);
 	sema_init(&dev->sem, 1);
-
 	dev->event_count = 0;
 	dev->queue_size = 0;
 	dev->max_events = max_queued_events;
@@ -742,7 +741,7 @@
 	atomic_set(&dev->count, 0);
 
 	get_inotify_dev(dev);
-	atomic_inc(&current->user->inotify_devs);
+	atomic_inc(&user->inotify_devs);
 
 	file->private_data = dev;
 
@@ -800,8 +799,7 @@
 	return 0;
 }
 
-static int inotify_add_watch(struct inotify_device *dev,
-			     int fd, u32 mask)
+static int inotify_add_watch(struct inotify_device *dev, int fd, u32 mask)
 {
 	struct inotify_watch *watch, *old;
 	struct inode *inode;
@@ -816,6 +814,13 @@
 	down(&inode->inotify_sem);
 	down(&dev->sem);
 
+	/* don't let user-space set invalid bits: we don't want flags set */
+	mask &= IN_ALL_EVENTS;
+	if (!mask) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/*
 	 * Handle the case of re-adding a watch on an (inode,dev) pair that we
 	 * are already watching.  We just update the mask and return its wd.
@@ -870,7 +875,7 @@
 	down(&inode->inotify_sem);
 	down(&dev->sem);
 
-	/* make sure we did not race */
+	/* make sure that we did not race */
 	watch = idr_find(&dev->idr, wd);
 	if (likely(watch))
 		remove_watch(watch, dev);
@@ -947,9 +952,9 @@
 	if (unlikely(ret))
 		panic("inotify: misc_register returned %d\n", ret);
 
-	max_queued_events = 512;
-	max_user_devices = 64;
-	max_user_watches = 16384;
+	max_queued_events = 8192;
+	max_user_devices = 128;
+	max_user_watches = 8192;
 
 	class = inotify_device.class;
 	class_device_create_file(class, &class_device_attr_max_queued_events);
diff -urN linux-2.6.12-rc3-mm2/fs/namei.c linux/fs/namei.c
--- linux-2.6.12-rc3-mm2/fs/namei.c	2005-05-03 12:59:49.000000000 -0400
+++ linux/fs/namei.c	2005-05-03 13:02:22.000000000 -0400
@@ -2152,7 +2152,7 @@
 {
 	int error;
 	int is_dir = S_ISDIR(old_dentry->d_inode->i_mode);
-	char *old_name;
+	const char *old_name;
 
 	if (old_dentry->d_inode == new_dentry->d_inode)
  		return 0;
@@ -2174,7 +2174,7 @@
 	DQUOT_INIT(old_dir);
 	DQUOT_INIT(new_dir);
 
-	old_name = fsnotify_oldname_init(old_dentry);
+	old_name = fsnotify_oldname_init(old_dentry->d_name.name);
 
 	if (is_dir)
 		error = vfs_rename_dir(old_dir,old_dentry,new_dir,new_dentry);
@@ -2182,7 +2182,7 @@
 		error = vfs_rename_other(old_dir,old_dentry,new_dir,new_dentry);
 	if (!error) {
 		const char *new_name = old_dentry->d_name.name;
-		fsnotify_move(old_dir, new_dir, old_name, new_name);
+		fsnotify_move(old_dir, new_dir, old_name, new_name, is_dir);
 	}
 	fsnotify_oldname_free(old_name);
 
diff -urN linux-2.6.12-rc3-mm2/include/linux/fsnotify.h linux/include/linux/fsnotify.h
--- linux-2.6.12-rc3-mm2/include/linux/fsnotify.h	2005-05-03 12:59:50.000000000 -0400
+++ linux/include/linux/fsnotify.h	2005-05-03 13:02:22.000000000 -0400
@@ -2,7 +2,7 @@
 #define _LINUX_FS_NOTIFY_H
 
 /*
- * include/linux/fs_notify.h - generic hooks for filesystem notification, to
+ * include/linux/fsnotify.h - generic hooks for filesystem notification, to
  * reduce in-source duplication from both dnotify and inotify.
  *
  * We don't compile any of this away in some complicated menagerie of ifdefs.
@@ -20,9 +20,10 @@
  * fsnotify_move - file old_name at old_dir was moved to new_name at new_dir
  */
 static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
-				 const char *old_name, const char *new_name)
+				 const char *old_name, const char *new_name,
+				 int isdir)
 {
-	u32 cookie;
+	u32 cookie = inotify_get_cookie();
 
 	if (old_dir == new_dir)
 		inode_dir_notify(old_dir, DN_RENAME);
@@ -31,10 +32,10 @@
 		inode_dir_notify(new_dir, DN_CREATE);
 	}
 
-	cookie = inotify_get_cookie();
-
-	inotify_inode_queue_event(old_dir, IN_MOVED_FROM, cookie, old_name);
-	inotify_inode_queue_event(new_dir, IN_MOVED_TO, cookie, new_name);
+	if (isdir)
+		isdir = IN_ISDIR;
+	inotify_inode_queue_event(old_dir, IN_MOVED_FROM|isdir,cookie,old_name);
+	inotify_inode_queue_event(new_dir, IN_MOVED_TO|isdir, cookie, new_name);
 }
 
 /*
@@ -45,7 +46,7 @@
 	struct inode *inode = dentry->d_inode;
 
 	inode_dir_notify(dir, DN_DELETE);
-	inotify_inode_queue_event(dir, IN_DELETE_FILE, 0, dentry->d_name.name);
+	inotify_inode_queue_event(dir, IN_DELETE, 0, dentry->d_name.name);
 	inotify_inode_queue_event(inode, IN_DELETE_SELF, 0, NULL);
 
 	inotify_inode_is_dead(inode);
@@ -58,19 +59,18 @@
 				  struct inode *dir)
 {
 	inode_dir_notify(dir, DN_DELETE);
-	inotify_inode_queue_event(dir, IN_DELETE_SUBDIR,0,dentry->d_name.name);
-	inotify_inode_queue_event(inode, IN_DELETE_SELF, 0, NULL);
-
+	inotify_inode_queue_event(dir,IN_DELETE|IN_ISDIR,0,dentry->d_name.name);
+	inotify_inode_queue_event(inode, IN_DELETE_SELF | IN_ISDIR, 0, NULL);
 	inotify_inode_is_dead(inode);
 }
 
 /*
- * fsnotify_create - filename was linked in
+ * fsnotify_create - 'name' was linked in
  */
-static inline void fsnotify_create(struct inode *inode, const char *filename)
+static inline void fsnotify_create(struct inode *inode, const char *name)
 {
 	inode_dir_notify(inode, DN_CREATE);
-	inotify_inode_queue_event(inode, IN_CREATE_FILE, 0, filename);
+	inotify_inode_queue_event(inode, IN_CREATE, 0, name);
 }
 
 /*
@@ -79,7 +79,7 @@
 static inline void fsnotify_mkdir(struct inode *inode, const char *name)
 {
 	inode_dir_notify(inode, DN_CREATE);
-	inotify_inode_queue_event(inode, IN_CREATE_SUBDIR, 0, name);
+	inotify_inode_queue_event(inode, IN_CREATE | IN_ISDIR, 0, name);
 }
 
 /*
@@ -87,10 +87,15 @@
  */
 static inline void fsnotify_access(struct dentry *dentry)
 {
+	struct inode *inode = dentry->d_inode;
+	u32 mask = IN_ACCESS;
+
+	if (S_ISDIR(inode->i_mode))
+		mask |= IN_ISDIR;
+
 	dnotify_parent(dentry, DN_ACCESS);
-	inotify_dentry_parent_queue_event(dentry, IN_ACCESS, 0,
-					  dentry->d_name.name);
-	inotify_inode_queue_event(dentry->d_inode, IN_ACCESS, 0, NULL);
+	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
+	inotify_inode_queue_event(inode, mask, 0, NULL);
 }
 
 /*
@@ -98,10 +103,15 @@
  */
 static inline void fsnotify_modify(struct dentry *dentry)
 {
+	struct inode *inode = dentry->d_inode;
+	u32 mask = IN_MODIFY;
+
+	if (S_ISDIR(inode->i_mode))
+		mask |= IN_ISDIR;
+
 	dnotify_parent(dentry, DN_MODIFY);
-	inotify_dentry_parent_queue_event(dentry, IN_MODIFY, 0,
-					  dentry->d_name.name);
-	inotify_inode_queue_event(dentry->d_inode, IN_MODIFY, 0, NULL);
+	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
+	inotify_inode_queue_event(inode, mask, 0, NULL);
 }
 
 /*
@@ -109,9 +119,14 @@
  */
 static inline void fsnotify_open(struct dentry *dentry)
 {
-	inotify_inode_queue_event(dentry->d_inode, IN_OPEN, 0, NULL);
-	inotify_dentry_parent_queue_event(dentry, IN_OPEN, 0,
-					  dentry->d_name.name);
+	struct inode *inode = dentry->d_inode;
+	u32 mask = IN_OPEN;
+
+	if (S_ISDIR(inode->i_mode))
+		mask |= IN_ISDIR;
+
+	inotify_inode_queue_event(inode, mask, 0, NULL);
+	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
 }
 
 /*
@@ -121,12 +136,14 @@
 {
 	struct dentry *dentry = file->f_dentry;
 	struct inode *inode = dentry->d_inode;
-	const char *filename = dentry->d_name.name;
+	const char *name = dentry->d_name.name;
 	mode_t mode = file->f_mode;
-	u32 mask;
+	u32 mask = (mode & FMODE_WRITE) ? IN_CLOSE_WRITE : IN_CLOSE_NOWRITE;
+
+	if (S_ISDIR(inode->i_mode))
+		mask |= IN_ISDIR;
 
-	mask = (mode & FMODE_WRITE) ? IN_CLOSE_WRITE : IN_CLOSE_NOWRITE;
-	inotify_dentry_parent_queue_event(dentry, mask, 0, filename);
+	inotify_dentry_parent_queue_event(dentry, mask, 0, name);
 	inotify_inode_queue_event(inode, mask, 0, NULL);
 }
 
@@ -135,9 +152,14 @@
  */
 static inline void fsnotify_xattr(struct dentry *dentry)
 {
-	inotify_dentry_parent_queue_event(dentry, IN_ATTRIB, 0,
-					  dentry->d_name.name);
-	inotify_inode_queue_event(dentry->d_inode, IN_ATTRIB, 0, NULL);
+	struct inode *inode = dentry->d_inode;
+	u32 mask = IN_ATTRIB;
+
+	if (S_ISDIR(inode->i_mode))
+		mask |= IN_ISDIR;
+
+	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
+	inotify_inode_queue_event(inode, mask, 0, NULL);
 }
 
 /*
@@ -146,6 +168,7 @@
  */
 static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
 {
+	struct inode *inode = dentry->d_inode;
 	int dn_mask = 0;
 	u32 in_mask = 0;
 
@@ -181,7 +204,9 @@
 	if (dn_mask)
 		dnotify_parent(dentry, dn_mask);
 	if (in_mask) {
-		inotify_inode_queue_event(dentry->d_inode, in_mask, 0, NULL);
+		if (S_ISDIR(inode->i_mode))
+			in_mask |= IN_ISDIR;
+		inotify_inode_queue_event(inode, in_mask, 0, NULL);
 		inotify_dentry_parent_queue_event(dentry, in_mask, 0,
 						  dentry->d_name.name);
 	}
@@ -192,16 +217,18 @@
 /*
  * fsnotify_oldname_init - save off the old filename before we change it
  *
- * this could be kstrdup if only we could add that to lib/string.c
+ * XXX: This could be kstrdup if only we could add that to lib/string.c
  */
-static inline char *fsnotify_oldname_init(struct dentry *old_dentry)
+static inline char *fsnotify_oldname_init(const char *name)
 {
-	char *old_name;
+	size_t len;
+	char *buf;
 
-	old_name = kmalloc(strlen(old_dentry->d_name.name) + 1, GFP_KERNEL);
-	if (old_name)
-		strcpy(old_name, old_dentry->d_name.name);
-	return old_name;
+	len = strlen(name) + 1;
+	buf = kmalloc(len, GFP_KERNEL);
+	if (likely(buf))
+		memcpy(buf, name, len);
+	return buf;
 }
 
 /*
diff -urN linux-2.6.12-rc3-mm2/include/linux/inotify.h linux/include/linux/inotify.h
--- linux-2.6.12-rc3-mm2/include/linux/inotify.h	2005-05-03 12:59:50.000000000 -0400
+++ linux/include/linux/inotify.h	2005-05-03 13:02:22.000000000 -0400
@@ -42,11 +42,9 @@
 #define IN_OPEN			0x00000020	/* File was opened */
 #define IN_MOVED_FROM		0x00000040	/* File was moved from X */
 #define IN_MOVED_TO		0x00000080	/* File was moved to Y */
-#define IN_DELETE_SUBDIR	0x00000100	/* Subdir was deleted */
-#define IN_DELETE_FILE		0x00000200	/* Subfile was deleted */
-#define IN_CREATE_SUBDIR	0x00000400	/* Subdir was created */
-#define IN_CREATE_FILE		0x00000800	/* Subfile was created */
-#define IN_DELETE_SELF		0x00001000	/* Self was deleted */
+#define IN_CREATE		0x00000100	/* Subfile was created */
+#define IN_DELETE		0x00000200	/* Subfile was deleted */
+#define IN_DELETE_SELF		0x00000400	/* Self was deleted */
 
 /* the following are legal events.  they are sent as needed to any watch */
 #define IN_UNMOUNT		0x00002000	/* Backing fs was unmounted */
@@ -58,6 +56,7 @@
 #define IN_MOVE			(IN_MOVED_FROM | IN_MOVED_TO) /* moves */
 
 /* special flags */
+#define IN_ISDIR		0x40000000	/* event occurred against dir */
 #define IN_ONESHOT		0x80000000	/* only send event once */
 
 /*
@@ -67,8 +66,7 @@
  */
 #define IN_ALL_EVENTS	(IN_ACCESS | IN_MODIFY | IN_ATTRIB | IN_CLOSE_WRITE | \
 			 IN_CLOSE_NOWRITE | IN_OPEN | IN_MOVED_FROM | \
-			 IN_MOVED_TO | IN_DELETE_SUBDIR | IN_DELETE_FILE | \
-			 IN_CREATE_SUBDIR | IN_CREATE_FILE | IN_DELETE_SELF)
+			 IN_MOVED_TO | IN_DELETE | IN_CREATE | IN_DELETE_SELF)
 
 #define INOTIFY_IOCTL_MAGIC	'Q'
 #define INOTIFY_IOCTL_MAXNR	2


