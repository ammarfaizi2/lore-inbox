Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263817AbTEZA1P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 20:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTEZA1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 20:27:14 -0400
Received: from hera.cwi.nl ([192.16.191.8]:39066 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263817AbTEZA0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 20:26:54 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 26 May 2003 02:39:59 +0200 (MEST)
Message-Id: <UTC200305260039.h4Q0dxZ03906.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: [patch] change get_sb prototype
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The boring patch below does not change behaviour.
It does two things:

(i) The prototypes for free_vfsmnt(), alloc_vfsmnt(), do_kern_mount()
so far occurred in several individual c files. Now they are in
<linux/mount.h>.

(ii) do_kern_mount() has a third argument name that is typically
a constant. It is called with "rootfs", "nfsd", type->name, "capifs",
"usbdevfs", "binfmt_misc" etc. So, it should have a prototype that
expresses this:

do_kern_mount(const char *fstype, int flags, const char *name, void *data);

This makes the ugly cast

-       return do_kern_mount(type->name, 0, (char *)type->name, NULL);
+       return do_kern_mount(type->name, 0, type->name, NULL);

go away. Now do_kern_mount() calls type->get_sb(), so also get_sb()
must have a const third argument. That is what the patch below does.
If I am not mistaken, precisely two filesystems do not treat this
argument as a constant, namely afs and cifs. A separate patch
gives some cleanup there.

Andries

----------------------------------------------------------------------

diff -u --recursive --new-file -X /linux/dontdiff a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
--- a/Documentation/filesystems/Locking	Thu May 22 13:16:19 2003
+++ b/Documentation/filesystems/Locking	Mon May 26 03:03:27 2003
@@ -120,7 +120,7 @@
 
 --------------------------- file_system_type ---------------------------
 prototypes:
-	struct super_block *(*get_sb) (struct file_system_type *, int, char *, void *);
+	struct super_block *(*get_sb) (struct file_system_type *, int, const char *, void *);
 	void (*kill_sb) (struct super_block *);
 locking rules:
 		may block	BKL
diff -u --recursive --new-file -X /linux/dontdiff a/Documentation/filesystems/porting b/Documentation/filesystems/porting
--- a/Documentation/filesystems/porting	Thu May 22 13:15:46 2003
+++ b/Documentation/filesystems/porting	Mon May 26 03:02:50 2003
@@ -51,7 +51,7 @@
 informative error value to report).  Call it foo_fill_super().  Now declare
 
 struct super_block foo_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, ext2_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/isdn/capi/capifs.c b/drivers/isdn/capi/capifs.c
--- a/drivers/isdn/capi/capifs.c	Thu May 22 13:16:20 2003
+++ b/drivers/isdn/capi/capifs.c	Mon May 26 01:53:32 2003
@@ -141,7 +141,7 @@
 }
 
 static struct super_block *capifs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_single(fs_type, flags, data, capifs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/oprofile/oprofilefs.c b/drivers/oprofile/oprofilefs.c
--- a/drivers/oprofile/oprofilefs.c	Wed Mar  5 04:29:16 2003
+++ b/drivers/oprofile/oprofilefs.c	Mon May 26 01:15:04 2003
@@ -299,8 +299,8 @@
 }
 
 
-static struct super_block * oprofilefs_get_sb(struct file_system_type * fs_type,
-	int flags, char * dev_name, void * data)
+static struct super_block *oprofilefs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_single(fs_type, flags, data, oprofilefs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/usb/core/inode.c b/drivers/usb/core/inode.c
--- a/drivers/usb/core/inode.c	Thu May 22 13:16:21 2003
+++ b/drivers/usb/core/inode.c	Mon May 26 01:12:25 2003
@@ -489,7 +489,7 @@
 static struct file_system_type usbdevice_fs_type;
 
 static struct super_block *usb_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	if (fs_type == &usbdevice_fs_type)
 		printk (KERN_INFO "Please use the 'usbfs' filetype instead, "
diff -u --recursive --new-file -X /linux/dontdiff a/fs/adfs/super.c b/fs/adfs/super.c
--- a/fs/adfs/super.c	Wed Mar  5 04:28:53 2003
+++ b/fs/adfs/super.c	Mon May 26 01:35:14 2003
@@ -459,7 +459,7 @@
 }
 
 static struct super_block *adfs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, adfs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/affs/super.c b/fs/affs/super.c
--- a/fs/affs/super.c	Thu May 22 13:15:38 2003
+++ b/fs/affs/super.c	Mon May 26 01:35:43 2003
@@ -543,7 +543,7 @@
 }
 
 static struct super_block *affs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, affs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/afs/super.c b/fs/afs/super.c
--- a/fs/afs/super.c	Wed Mar  5 04:29:17 2003
+++ b/fs/afs/super.c	Mon May 26 02:45:33 2003
@@ -40,7 +40,8 @@
 static void afs_i_init_once(void *foo, kmem_cache_t *cachep, unsigned long flags);
 
 static struct super_block *afs_get_sb(struct file_system_type *fs_type,
-				      int flags, char *dev_name, void *data);
+				      int flags, const char *dev_name,
+				      void *data);
 
 static struct inode *afs_alloc_inode(struct super_block *sb);
 
@@ -407,10 +408,9 @@
  * get an AFS superblock
  * - TODO: don't use get_sb_nodev(), but rather call sget() directly
  */
-static struct super_block *afs_get_sb(struct file_system_type *fs_type,
-				      int flags,
-				      char *dev_name,
-				      void *options)
+static struct super_block *
+afs_get_sb(struct file_system_type *fs_type, int flags,
+	   const char *dev_name, void *options)
 {
 	struct super_block *sb;
 	void *data[2] = { dev_name, options };
diff -u --recursive --new-file -X /linux/dontdiff a/fs/autofs/init.c b/fs/autofs/init.c
--- a/fs/autofs/init.c	Wed Mar  5 04:29:30 2003
+++ b/fs/autofs/init.c	Mon May 26 01:36:37 2003
@@ -15,7 +15,7 @@
 #include "autofs_i.h"
 
 static struct super_block *autofs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_nodev(fs_type, flags, data, autofs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/autofs4/init.c b/fs/autofs4/init.c
--- a/fs/autofs4/init.c	Wed Mar  5 04:29:31 2003
+++ b/fs/autofs4/init.c	Mon May 26 01:36:53 2003
@@ -15,7 +15,7 @@
 #include "autofs_i.h"
 
 static struct super_block *autofs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_nodev(fs_type, flags, data, autofs4_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
--- a/fs/befs/linuxvfs.c	Thu May 22 13:15:47 2003
+++ b/fs/befs/linuxvfs.c	Mon May 26 01:37:34 2003
@@ -916,8 +916,8 @@
 }
 
 static struct super_block *
-befs_get_sb(struct file_system_type *fs_type, int flags, char *dev_name,
-		void *data)
+befs_get_sb(struct file_system_type *fs_type, int flags, const char *dev_name,
+	    void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, befs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/bfs/inode.c b/fs/bfs/inode.c
--- a/fs/bfs/inode.c	Wed Mar  5 04:29:17 2003
+++ b/fs/bfs/inode.c	Mon May 26 01:38:09 2003
@@ -379,7 +379,7 @@
 }
 
 static struct super_block *bfs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, bfs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/binfmt_misc.c b/fs/binfmt_misc.c
--- a/fs/binfmt_misc.c	Thu May 22 13:16:21 2003
+++ b/fs/binfmt_misc.c	Mon May 26 01:34:29 2003
@@ -623,7 +623,7 @@
 }
 
 static struct super_block *bm_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_single(fs_type, flags, data, bm_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/block_dev.c b/fs/block_dev.c
--- a/fs/block_dev.c	Sun May 25 17:54:02 2003
+++ b/fs/block_dev.c	Mon May 26 01:29:01 2003
@@ -196,7 +196,7 @@
  */
 
 static struct super_block *bd_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_pseudo(fs_type, "bdev:", NULL, 0x62646576);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
--- a/fs/cifs/cifsfs.c	Sun May 25 17:54:02 2003
+++ b/fs/cifs/cifsfs.c	Mon May 26 02:29:11 2003
@@ -57,13 +57,14 @@
 struct task_struct * oplockThread = NULL;
 
 extern int cifs_mount(struct super_block *, struct cifs_sb_info *, char *,
-			char *);
+			const char *);
 extern int cifs_umount(struct super_block *, struct cifs_sb_info *);
 void cifs_proc_init(void);
 void cifs_proc_clean(void);
 
 static int
-cifs_read_super(struct super_block *sb, void *data, char *devname, int silent)
+cifs_read_super(struct super_block *sb, void *data,
+		const char *devname, int silent)
 {
 	struct inode *inode;
 	struct cifs_sb_info *cifs_sb;
@@ -251,7 +252,7 @@
 
 static struct super_block *
 cifs_get_sb(struct file_system_type *fs_type,
-	    int flags, char *dev_name, void *data)
+	    int flags, const char *dev_name, void *data)
 {
 	int rc;
 	struct super_block *sb = sget(fs_type, NULL, set_anon_super, NULL);
diff -u --recursive --new-file -X /linux/dontdiff a/fs/cifs/connect.c b/fs/cifs/connect.c
--- a/fs/cifs/connect.c	Sun May 25 17:54:02 2003
+++ b/fs/cifs/connect.c	Mon May 26 02:30:34 2003
@@ -342,7 +342,7 @@
 }
 
 int
-parse_mount_options(char *options, char *devname, struct smb_vol *vol)
+parse_mount_options(char *options, const char *devname, struct smb_vol *vol)
 {
 	char *value;
 	char *data;
@@ -795,7 +795,7 @@
 
 int
 cifs_mount(struct super_block *sb, struct cifs_sb_info *cifs_sb,
-	   char *mount_data, char *devname)
+	   char *mount_data, const char *devname)
 {
 	int rc = 0;
 	int xid;
@@ -811,7 +811,7 @@
 	xid = GetXid();
 	cFYI(1, ("Entering cifs_mount. Xid: %d with: %s", xid, mount_data));
 
-	if(parse_mount_options(mount_data, devname, &volume_info)) {
+	if (parse_mount_options(mount_data, devname, &volume_info)) {
 		FreeXid(xid);
 		return -EINVAL;
 	}
diff -u --recursive --new-file -X /linux/dontdiff a/fs/coda/inode.c b/fs/coda/inode.c
--- a/fs/coda/inode.c	Wed Mar  5 04:29:19 2003
+++ b/fs/coda/inode.c	Mon May 26 01:38:56 2003
@@ -303,7 +303,7 @@
 /* init_coda: used by filesystems.c to register coda */
 
 static struct super_block *coda_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_nodev(fs_type, flags, data, coda_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/cramfs/inode.c b/fs/cramfs/inode.c
--- a/fs/cramfs/inode.c	Thu May 22 13:15:47 2003
+++ b/fs/cramfs/inode.c	Mon May 26 01:39:24 2003
@@ -464,7 +464,7 @@
 };
 
 static struct super_block *cramfs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, cramfs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/devfs/base.c b/fs/devfs/base.c
--- a/fs/devfs/base.c	Sun May 25 17:54:02 2003
+++ b/fs/devfs/base.c	Mon May 26 02:56:18 2003
@@ -2554,8 +2554,9 @@
     return -EINVAL;
 }   /*  End Function devfs_fill_super  */
 
-static struct super_block *devfs_get_sb (struct file_system_type *fs_type,
-					 int flags, char *dev_name, void *data)
+static struct super_block *
+devfs_get_sb (struct file_system_type *fs_type, int flags,
+	      const char *dev_name, void *data)
 {
     return get_sb_single (fs_type, flags, data, devfs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/devpts/inode.c b/fs/devpts/inode.c
--- a/fs/devpts/inode.c	Wed Mar  5 04:29:03 2003
+++ b/fs/devpts/inode.c	Mon May 26 02:19:23 2003
@@ -72,7 +72,8 @@
 	.remount_fs	= devpts_remount,
 };
 
-static int devpts_fill_super(struct super_block *s, void *data, int silent)
+static int
+devpts_fill_super(struct super_block *s, void *data, int silent)
 {
 	struct inode * inode;
 
@@ -105,7 +106,7 @@
 }
 
 static struct super_block *devpts_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_single(fs_type, flags, data, devpts_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/efs/super.c b/fs/efs/super.c
--- a/fs/efs/super.c	Wed Mar  5 04:29:33 2003
+++ b/fs/efs/super.c	Mon May 26 01:41:42 2003
@@ -16,7 +16,7 @@
 #include <linux/vfs.h>
 
 static struct super_block *efs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, efs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/eventpoll.c b/fs/eventpoll.c
--- a/fs/eventpoll.c	Thu May 22 13:16:03 2003
+++ b/fs/eventpoll.c	Mon May 26 01:33:42 2003
@@ -260,17 +260,20 @@
 static int ep_poll_callback(wait_queue_t *wait, unsigned mode, int sync);
 static int ep_eventpoll_close(struct inode *inode, struct file *file);
 static unsigned int ep_eventpoll_poll(struct file *file, poll_table *wait);
-static int ep_collect_ready_items(struct eventpoll *ep, struct list_head *txlist, int maxevents);
+static int ep_collect_ready_items(struct eventpoll *ep,
+				  struct list_head *txlist, int maxevents);
 static int ep_send_events(struct eventpoll *ep, struct list_head *txlist,
 			  struct epoll_event *events);
 static void ep_reinject_items(struct eventpoll *ep, struct list_head *txlist);
-static int ep_events_transfer(struct eventpoll *ep, struct epoll_event *events, int maxevents);
-static int ep_poll(struct eventpoll *ep, struct epoll_event *events, int maxevents,
-		   long timeout);
+static int ep_events_transfer(struct eventpoll *ep,
+			      struct epoll_event *events, int maxevents);
+static int ep_poll(struct eventpoll *ep, struct epoll_event *events,
+		   int maxevents, long timeout);
 static int eventpollfs_delete_dentry(struct dentry *dentry);
 static struct inode *ep_eventpoll_inode(void);
 static struct super_block *eventpollfs_get_sb(struct file_system_type *fs_type,
-					      int flags, char *dev_name, void *data);
+					      int flags, const char *dev_name,
+					      void *data);
 
 
 /* Safe wake up implementation */
@@ -1637,10 +1640,10 @@
 }
 
 
-static struct super_block *eventpollfs_get_sb(struct file_system_type *fs_type,
-					      int flags, char *dev_name, void *data)
+static struct super_block *
+eventpollfs_get_sb(struct file_system_type *fs_type, int flags,
+		   const char *dev_name, void *data)
 {
-
 	return get_sb_pseudo(fs_type, "eventpoll:", NULL, EVENTPOLLFS_MAGIC);
 }
 
diff -u --recursive --new-file -X /linux/dontdiff a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	Thu May 22 13:16:03 2003
+++ b/fs/ext2/super.c	Mon May 26 01:42:01 2003
@@ -989,7 +989,7 @@
 }
 
 static struct super_block *ext2_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, ext2_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Sun May 25 17:54:02 2003
+++ b/fs/ext3/super.c	Mon May 26 01:42:20 2003
@@ -2029,7 +2029,7 @@
 #endif
 
 static struct super_block *ext3_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, ext3_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
--- a/fs/freevxfs/vxfs_super.c	Wed Mar  5 04:29:34 2003
+++ b/fs/freevxfs/vxfs_super.c	Mon May 26 01:42:43 2003
@@ -230,7 +230,7 @@
  * The usual module blurb.
  */
 static struct super_block *vxfs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, vxfs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/hfs/super.c b/fs/hfs/super.c
--- a/fs/hfs/super.c	Wed Mar  5 04:29:15 2003
+++ b/fs/hfs/super.c	Mon May 26 01:43:12 2003
@@ -100,7 +100,7 @@
 /*================ File-local variables ================*/
 
 static struct super_block *hfs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, hfs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/hpfs/super.c b/fs/hpfs/super.c
--- a/fs/hpfs/super.c	Wed Mar  5 04:29:23 2003
+++ b/fs/hpfs/super.c	Mon May 26 01:43:29 2003
@@ -637,7 +637,7 @@
 }
 
 static struct super_block *hpfs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, hpfs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
--- a/fs/hugetlbfs/inode.c	Sun May 25 17:54:02 2003
+++ b/fs/hugetlbfs/inode.c	Mon May 26 01:43:49 2003
@@ -501,7 +501,7 @@
 }
 
 static struct super_block *hugetlbfs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_nodev(fs_type, flags, data, hugetlbfs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/intermezzo/super.c b/fs/intermezzo/super.c
--- a/fs/intermezzo/super.c	Thu May 22 13:15:38 2003
+++ b/fs/intermezzo/super.c	Mon May 26 02:38:20 2003
@@ -187,8 +187,9 @@
 
 /* We always need to remove the presto options before passing 
    mount options to cache FS */
-struct super_block * presto_get_sb(struct file_system_type *izo_type, 
-                                   int flags, char *devname, void * data)
+struct super_block *
+presto_get_sb(struct file_system_type *izo_type, int flags,
+	      const char *devname, void *data)
 {
         struct file_system_type *fstype;
         struct presto_cache *cache = NULL;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/isofs/inode.c b/fs/isofs/inode.c
--- a/fs/isofs/inode.c	Wed Mar  5 04:29:52 2003
+++ b/fs/isofs/inode.c	Mon May 26 01:44:10 2003
@@ -1376,7 +1376,7 @@
 #endif
 
 static struct super_block *isofs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, isofs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/jffs/inode-v23.c b/fs/jffs/inode-v23.c
--- a/fs/jffs/inode-v23.c	Sun May 25 17:54:02 2003
+++ b/fs/jffs/inode-v23.c	Mon May 26 03:01:37 2003
@@ -1783,7 +1783,7 @@
 };
 
 static struct super_block *jffs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, jffs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/jffs2/super.c b/fs/jffs2/super.c
--- a/fs/jffs2/super.c	Wed Mar  5 04:29:15 2003
+++ b/fs/jffs2/super.c	Mon May 26 02:36:50 2003
@@ -101,9 +101,9 @@
 	return 0;
 }
 
-static struct super_block *jffs2_get_sb_mtd(struct file_system_type *fs_type,
-					      int flags, char *dev_name, 
-					      void *data, struct mtd_info *mtd)
+static struct super_block *
+jffs2_get_sb_mtd(struct file_system_type *fs_type, int flags,
+		 const char *dev_name, void *data, struct mtd_info *mtd)
 {
 	struct super_block *sb;
 	struct jffs2_sb_info *c;
@@ -153,9 +153,9 @@
 	return sb;
 }
 
-static struct super_block *jffs2_get_sb_mtdnr(struct file_system_type *fs_type,
-					      int flags, char *dev_name, 
-					      void *data, int mtdnr)
+static struct super_block *
+jffs2_get_sb_mtdnr(struct file_system_type *fs_type, int flags,
+		   const char *dev_name, void *data, int mtdnr)
 {
 	struct mtd_info *mtd;
 
@@ -168,8 +168,9 @@
 	return jffs2_get_sb_mtd(fs_type, flags, dev_name, data, mtd);
 }
 
-static struct super_block *jffs2_get_sb(struct file_system_type *fs_type,
-					int flags, char *dev_name, void *data)
+static struct super_block *
+jffs2_get_sb(struct file_system_type *fs_type, int flags,
+	     const char *dev_name, void *data)
 {
 	int err;
 	struct nameidata nd;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/jfs/super.c b/fs/jfs/super.c
--- a/fs/jfs/super.c	Wed Mar  5 04:29:18 2003
+++ b/fs/jfs/super.c	Mon May 26 01:45:47 2003
@@ -372,8 +372,9 @@
 			txResume(sb);
 	}
 }
-static struct super_block *jfs_get_sb(struct file_system_type *fs_type,
-		int flags, char *dev_name, void *data)
+
+static struct super_block *jfs_get_sb(struct file_system_type *fs_type, 
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, jfs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/libfs.c b/fs/libfs.c
--- a/fs/libfs.c	Sun May 25 17:54:02 2003
+++ b/fs/libfs.c	Mon May 26 00:52:41 2003
@@ -7,8 +7,6 @@
 #include <linux/mount.h>
 #include <linux/vfs.h>
 
-extern struct vfsmount *do_kern_mount(const char *, int, char *, void *);
-
 int simple_getattr(struct vfsmount *mnt, struct dentry *dentry,
 		   struct kstat *stat)
 {
diff -u --recursive --new-file -X /linux/dontdiff a/fs/minix/inode.c b/fs/minix/inode.c
--- a/fs/minix/inode.c	Wed Mar  5 04:29:19 2003
+++ b/fs/minix/inode.c	Mon May 26 01:46:05 2003
@@ -554,7 +554,7 @@
 }
 
 static struct super_block *minix_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, minix_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/msdos/msdosfs_syms.c b/fs/msdos/msdosfs_syms.c
--- a/fs/msdos/msdosfs_syms.c	Wed Mar  5 04:29:30 2003
+++ b/fs/msdos/msdosfs_syms.c	Mon May 26 01:46:30 2003
@@ -25,7 +25,7 @@
 EXPORT_SYMBOL(msdos_unlink);
 
 static struct super_block *msdos_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, msdos_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c	Sun May 25 17:54:02 2003
+++ b/fs/namespace.c	Mon May 26 00:59:14 2003
@@ -23,7 +23,6 @@
 #include <linux/mount.h>
 #include <asm/uaccess.h>
 
-extern struct vfsmount *do_kern_mount(const char *type, int flags, char *name, void *data);
 extern int __init init_rootfs(void);
 extern int __init fs_subsys_init(void);
 
@@ -39,7 +38,7 @@
 	return tmp & hash_mask;
 }
 
-struct vfsmount *alloc_vfsmnt(char *name)
+struct vfsmount *alloc_vfsmnt(const char *name)
 {
 	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL); 
 	if (mnt) {
@@ -63,8 +62,7 @@
 
 void free_vfsmnt(struct vfsmount *mnt)
 {
-	if (mnt->mnt_devname)
-		kfree(mnt->mnt_devname);
+	kfree(mnt->mnt_devname);
 	kmem_cache_free(mnt_cache, mnt);
 }
 
diff -u --recursive --new-file -X /linux/dontdiff a/fs/ncpfs/inode.c b/fs/ncpfs/inode.c
--- a/fs/ncpfs/inode.c	Thu May 22 13:15:48 2003
+++ b/fs/ncpfs/inode.c	Mon May 26 01:46:49 2003
@@ -955,7 +955,7 @@
 #endif
 
 static struct super_block *ncp_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_nodev(fs_type, flags, data, ncp_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/nfs/inode.c b/fs/nfs/inode.c
--- a/fs/nfs/inode.c	Sun May 25 17:54:02 2003
+++ b/fs/nfs/inode.c	Mon May 26 02:14:31 2003
@@ -1192,7 +1192,7 @@
 }
 
 static struct super_block *nfs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *raw_data)
+	int flags, const char *dev_name, void *raw_data)
 {
 	int error;
 	struct nfs_server *server;
@@ -1421,7 +1421,7 @@
 }
 
 static struct super_block *nfs4_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *raw_data)
+	int flags, const char *dev_name, void *raw_data)
 {
 	int error;
 	struct nfs_server *server;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/nfsctl.c b/fs/nfsctl.c
--- a/fs/nfsctl.c	Thu May 22 13:16:03 2003
+++ b/fs/nfsctl.c	Mon May 26 00:54:19 2003
@@ -19,8 +19,6 @@
  * open a file on nfsd fs
  */
 
-struct vfsmount *do_kern_mount(const char *type, int flags, char *name, void *data);
-
 static struct file *do_open(char *name, int flags)
 {
 	struct nameidata nd;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
--- a/fs/nfsd/nfsctl.c	Sun May 25 17:54:02 2003
+++ b/fs/nfsd/nfsctl.c	Mon May 26 01:48:17 2003
@@ -433,7 +433,7 @@
 }
 
 static struct super_block *nfsd_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_single(fs_type, flags, data, nfsd_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Thu May 22 13:16:21 2003
+++ b/fs/ntfs/super.c	Mon May 26 01:48:39 2003
@@ -1656,7 +1656,7 @@
 DECLARE_MUTEX(ntfs_lock);
 
 static struct super_block *ntfs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, ntfs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
--- a/fs/openpromfs/inode.c	Wed Mar  5 04:29:18 2003
+++ b/fs/openpromfs/inode.c	Mon May 26 03:01:15 2003
@@ -1053,7 +1053,7 @@
 }
 
 static struct super_block *openprom_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_single(fs_type, flags, data, openprom_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/pipe.c b/fs/pipe.c
--- a/fs/pipe.c	Sun May 25 17:54:02 2003
+++ b/fs/pipe.c	Mon May 26 01:29:37 2003
@@ -627,7 +627,7 @@
  */
 
 static struct super_block *pipefs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_pseudo(fs_type, "pipe:", NULL, PIPEFS_MAGIC);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/proc/root.c b/fs/proc/root.c
--- a/fs/proc/root.c	Wed Mar  5 04:29:32 2003
+++ b/fs/proc/root.c	Mon May 26 01:48:57 2003
@@ -25,7 +25,7 @@
 #endif
 
 static struct super_block *proc_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_single(fs_type, flags, data, proc_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/qnx4/inode.c b/fs/qnx4/inode.c
--- a/fs/qnx4/inode.c	Wed Mar  5 04:29:34 2003
+++ b/fs/qnx4/inode.c	Mon May 26 01:49:23 2003
@@ -555,7 +555,7 @@
 }
 
 static struct super_block *qnx4_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, qnx4_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/ramfs/inode.c b/fs/ramfs/inode.c
--- a/fs/ramfs/inode.c	Wed Mar  5 04:29:15 2003
+++ b/fs/ramfs/inode.c	Mon May 26 02:19:54 2003
@@ -192,13 +192,13 @@
 }
 
 static struct super_block *ramfs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_nodev(fs_type, flags, data, ramfs_fill_super);
 }
 
 static struct super_block *rootfs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_nodev(fs_type, flags|MS_NOUSER, data, ramfs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Sun May 25 17:54:02 2003
+++ b/fs/reiserfs/super.c	Mon May 26 02:42:20 2003
@@ -1373,12 +1373,10 @@
 }
 
 static struct super_block*
-get_super_block (struct file_system_type *fs_type,
-		 int                      flags,
-		 char                    *dev_name,
-		 void                    *data)
+get_super_block (struct file_system_type *fs_type, int flags,
+		 const char *dev_name, void *data)
 {
-	return get_sb_bdev (fs_type, flags, dev_name, data, reiserfs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, reiserfs_fill_super);
 }
 
 static int __init
diff -u --recursive --new-file -X /linux/dontdiff a/fs/romfs/inode.c b/fs/romfs/inode.c
--- a/fs/romfs/inode.c	Wed Mar  5 04:29:30 2003
+++ b/fs/romfs/inode.c	Mon May 26 01:50:13 2003
@@ -599,7 +599,7 @@
 };
 
 static struct super_block *romfs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, romfs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/smbfs/inode.c b/fs/smbfs/inode.c
--- a/fs/smbfs/inode.c	Wed Mar  5 04:28:59 2003
+++ b/fs/smbfs/inode.c	Mon May 26 01:50:33 2003
@@ -759,7 +759,7 @@
 #endif
 
 static struct super_block *smb_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_nodev(fs_type, flags, data, smb_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/super.c b/fs/super.c
--- a/fs/super.c	Sun May 25 17:54:02 2003
+++ b/fs/super.c	Mon May 26 02:13:21 2003
@@ -259,9 +259,6 @@
 	return s;
 }
 
-struct vfsmount *alloc_vfsmnt(char *name);
-void free_vfsmnt(struct vfsmount *mnt);
-
 void drop_super(struct super_block *sb)
 {
 	up_read(&sb->s_umount);
@@ -558,7 +555,7 @@
 }
 
 struct super_block *get_sb_bdev(struct file_system_type *fs_type,
-	int flags, char *dev_name, void * data,
+	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int))
 {
 	struct block_device *bdev;
@@ -663,7 +660,7 @@
 }
 
 struct vfsmount *
-do_kern_mount(const char *fstype, int flags, char *name, void *data)
+do_kern_mount(const char *fstype, int flags, const char *name, void *data)
 {
 	struct file_system_type *type = get_fs_type(fstype);
 	struct super_block *sb = ERR_PTR(-ENOMEM);
@@ -702,5 +699,5 @@
 
 struct vfsmount *kern_mount(struct file_system_type *type)
 {
-	return do_kern_mount(type->name, 0, (char *)type->name, NULL);
+	return do_kern_mount(type->name, 0, type->name, NULL);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/sysfs/mount.c b/fs/sysfs/mount.c
--- a/fs/sysfs/mount.c	Thu May 22 13:15:29 2003
+++ b/fs/sysfs/mount.c	Mon May 26 01:50:51 2003
@@ -55,7 +55,7 @@
 }
 
 static struct super_block *sysfs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_single(fs_type, flags, data, sysfs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/sysv/super.c b/fs/sysv/super.c
--- a/fs/sysv/super.c	Wed Mar  5 04:29:00 2003
+++ b/fs/sysv/super.c	Mon May 26 02:21:25 2003
@@ -497,13 +497,13 @@
 /* Every kernel module contains stuff like this. */
 
 static struct super_block *sysv_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, sysv_fill_super);
 }
 
 static struct super_block *v7_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, v7_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/udf/super.c b/fs/udf/super.c
--- a/fs/udf/super.c	Wed Mar  5 04:29:30 2003
+++ b/fs/udf/super.c	Mon May 26 01:51:32 2003
@@ -99,7 +99,7 @@
 
 /* UDF filesystem type */
 static struct super_block *udf_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, udf_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/ufs/super.c b/fs/ufs/super.c
--- a/fs/ufs/super.c	Wed Mar  5 04:28:53 2003
+++ b/fs/ufs/super.c	Mon May 26 01:52:01 2003
@@ -1055,7 +1055,7 @@
 };
 
 static struct super_block *ufs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, ufs_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/vfat/vfatfs_syms.c b/fs/vfat/vfatfs_syms.c
--- a/fs/vfat/vfatfs_syms.c	Wed Mar  5 04:29:32 2003
+++ b/fs/vfat/vfatfs_syms.c	Mon May 26 01:52:15 2003
@@ -12,7 +12,7 @@
 #include <linux/msdos_fs.h>
 
 static struct super_block *vfat_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, vfat_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/xfs/linux/xfs_super.c b/fs/xfs/linux/xfs_super.c
--- a/fs/xfs/linux/xfs_super.c	Sun May 25 17:54:02 2003
+++ b/fs/xfs/linux/xfs_super.c	Mon May 26 01:52:41 2003
@@ -746,7 +746,7 @@
 linvfs_get_sb(
 	struct file_system_type	*fs_type,
 	int			flags,
-	char			*dev_name,
+	const char		*dev_name,
 	void			*data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, linvfs_fill_super);
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Sun May 25 17:54:05 2003
+++ b/include/linux/fs.h	Mon May 26 02:32:50 2003
@@ -917,7 +917,8 @@
 	const char *name;
 	struct subsystem subsys;
 	int fs_flags;
-	struct super_block *(*get_sb) (struct file_system_type *, int, char *, void *);
+	struct super_block *(*get_sb) (struct file_system_type *, int,
+				       const char *, void *);
 	void (*kill_sb) (struct super_block *);
 	struct module *owner;
 	struct file_system_type * next;
@@ -925,7 +926,7 @@
 };
 
 struct super_block *get_sb_bdev(struct file_system_type *fs_type,
-	int flags, char *dev_name, void * data,
+	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int));
 struct super_block *get_sb_single(struct file_system_type *fs_type,
 	int flags, void *data,
@@ -1116,7 +1117,7 @@
 extern void emergency_sync(void);
 extern void emergency_remount(void);
 extern int do_remount_sb(struct super_block *sb, int flags,
-			void *data, int force);
+			 void *data, int force);
 extern sector_t bmap(struct inode *, sector_t);
 extern int setattr_mask(unsigned int);
 extern int notify_change(struct dentry *, struct iattr *);
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/mount.h b/include/linux/mount.h
--- a/include/linux/mount.h	Wed Mar  5 04:28:58 2003
+++ b/include/linux/mount.h	Mon May 26 00:57:20 2003
@@ -50,5 +50,10 @@
 	}
 }
 
+extern void free_vfsmnt(struct vfsmount *mnt);
+extern struct vfsmount *alloc_vfsmnt(const char *name);
+extern struct vfsmount *do_kern_mount(const char *fstype, int flags,
+				      const char *name, void *data);
+
 #endif
 #endif /* _LINUX_MOUNT_H */
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/namespace.h b/include/linux/namespace.h
--- a/include/linux/namespace.h	Wed Mar  5 04:29:20 2003
+++ b/include/linux/namespace.h	Mon May 26 00:43:22 2003
@@ -12,9 +12,8 @@
 	struct rw_semaphore	sem;
 };
 
-void umount_tree(struct vfsmount *mnt);
-
 extern void umount_tree(struct vfsmount *);
+extern int copy_namespace(int, struct task_struct *);
 
 static inline void put_namespace(struct namespace *namespace)
 {
@@ -38,7 +37,6 @@
 		put_namespace(namespace);
 	}
 }
-extern int copy_namespace(int, struct task_struct *);
 
 static inline void get_namespace(struct namespace *namespace)
 {
diff -u --recursive --new-file -X /linux/dontdiff a/kernel/futex.c b/kernel/futex.c
--- a/kernel/futex.c	Thu May 22 13:16:04 2003
+++ b/kernel/futex.c	Mon May 26 01:16:48 2003
@@ -463,7 +463,7 @@
 
 static struct super_block *
 futexfs_get_sb(struct file_system_type *fs_type,
-	       int flags, char *dev_name, void *data)
+	       int flags, const char *dev_name, void *data)
 {
 	return get_sb_pseudo(fs_type, "futex", NULL, 0xBAD1DEA);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c	Sun May 25 17:54:05 2003
+++ b/mm/shmem.c	Mon May 26 02:01:57 2003
@@ -1647,7 +1647,8 @@
 }
 #endif
 
-static int shmem_fill_super(struct super_block *sb, void *data, int silent)
+static int shmem_fill_super(struct super_block *sb,
+			    void *data, int silent)
 {
 	struct inode *inode;
 	struct dentry *root;
@@ -1814,7 +1815,7 @@
 };
 
 static struct super_block *shmem_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_nodev(fs_type, flags, data, shmem_fill_super);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/net/socket.c b/net/socket.c
--- a/net/socket.c	Sun May 25 17:54:05 2003
+++ b/net/socket.c	Mon May 26 01:14:13 2003
@@ -325,7 +325,7 @@
 };
 
 static struct super_block *sockfs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+	int flags, const char *dev_name, void *data)
 {
 	return get_sb_pseudo(fs_type, "socket:", &sockfs_ops, SOCKFS_MAGIC);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
--- a/net/sunrpc/rpc_pipe.c	Sun May 25 17:54:05 2003
+++ b/net/sunrpc/rpc_pipe.c	Mon May 26 01:13:40 2003
@@ -749,7 +749,7 @@
 
 static struct super_block *
 rpc_get_sb(struct file_system_type *fs_type,
-		int flags, char *dev_name, void *data)
+		int flags, const char *dev_name, void *data)
 {
 	return get_sb_single(fs_type, flags, data, rpc_fill_super);
 }




