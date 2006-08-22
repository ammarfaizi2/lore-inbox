Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWHVLzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWHVLzF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 07:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWHVLzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 07:55:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48788 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751371AbWHVLzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 07:55:02 -0400
Date: Tue, 22 Aug 2006 12:54:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: [PATCH] kevent_user: remove non-chardev interface
Message-ID: <20060822115459.GA10839@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	lkml <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
	netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
References: <12345678912345.GA1898@2ka.mipt.ru> <11561555871530@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11561555871530@2ka.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a user can create a user kevents in two ways:

 a) simply open() the kevent chardevice
 b) use sys_kevent_ctl with the KEVENT_CTL_INIT cmd type

both are equally easy to use for the user, but to support type b) a lot
of code in kernelspace is required.  remove type b to save lots of code
without functionality loss.


 include/linux/ukevent.h     |    1
 kernel/kevent/kevent_user.c |   99 +-------------------------------------------
 2 files changed, 4 insertions(+), 96 deletions(-)

Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/kernel/kevent/kevent_user.c
===================================================================
--- linux-2.6.orig/kernel/kevent/kevent_user.c	2006-08-22 13:26:25.000000000 +0200
+++ linux-2.6/kernel/kevent/kevent_user.c	2006-08-22 13:46:08.000000000 +0200
@@ -36,20 +36,6 @@
 static char kevent_name[] = "kevent";
 static kmem_cache_t *kevent_cache;
 
-static int kevent_get_sb(struct file_system_type *fs_type, 
-		int flags, const char *dev_name, void *data, struct vfsmount *mnt)
-{
-	/* So original magic... */
-	return get_sb_pseudo(fs_type, kevent_name, NULL, 0xbcdbcdul, mnt);
-}
-
-static struct file_system_type kevent_fs_type = {
-	.name		= kevent_name,
-	.get_sb		= kevent_get_sb,
-	.kill_sb	= kill_anon_super,
-};
-
-static struct vfsmount *kevent_mnt;
 
 /*
  * kevents are pollable, return POLLIN and POLLRDNORM 
@@ -178,17 +164,14 @@
 }
 
 
-/*
- * Allocate new kevent userspace control entry.
- */
-static struct kevent_user *kevent_user_alloc(void)
+static int kevent_user_open(struct inode *inode, struct file *file)
 {
 	struct kevent_user *u;
 	int i;
 
 	u = kzalloc(sizeof(struct kevent_user), GFP_KERNEL);
 	if (!u)
-		return NULL;
+		return -ENOMEM;
 
 	INIT_LIST_HEAD(&u->ready_list);
 	spin_lock_init(&u->ready_lock);
@@ -202,23 +185,12 @@
 
 	atomic_set(&u->refcnt, 1);
 
-	if (kevent_user_ring_init(u)) {
+	if (unlikely(kevent_user_ring_init(u))) {
 		kfree(u);
-		u = NULL;
-	}
-
-	return u;
-}
-
-static int kevent_user_open(struct inode *inode, struct file *file)
-{
-	struct kevent_user *u = kevent_user_alloc();
-	
-	if (!u)
 		return -ENOMEM;
+	}
 
 	file->private_data = u;
-	
 	return 0;
 }
 
@@ -807,51 +779,6 @@
 	.fops = &kevent_user_fops,
 };
 
-
-/*
- * Userspace control block creation and initialization.
- */
-static int kevent_ctl_init(void)
-{
-	struct kevent_user *u;
-	struct file *file;
-	int fd, ret;
-
-	fd = get_unused_fd();
-	if (fd < 0)
-		return fd;
-
-	file = get_empty_filp();
-	if (!file) {
-		ret = -ENFILE;
-		goto out_put_fd;
-	}
-
-	u = kevent_user_alloc();
-	if (unlikely(!u)) {
-		ret = -ENOMEM;
-		goto out_put_file;
-	}
-
-	file->f_op = &kevent_user_fops;
-	file->f_vfsmnt = mntget(kevent_mnt);
-	file->f_dentry = dget(kevent_mnt->mnt_root);
-	file->f_mapping = file->f_dentry->d_inode->i_mapping;
-	file->f_mode = FMODE_READ;
-	file->f_flags = O_RDONLY;
-	file->private_data = u;
-	
-	fd_install(fd, file);
-
-	return fd;
-
-out_put_file:
-	put_filp(file);
-out_put_fd:
-	put_unused_fd(fd);
-	return ret;
-}
-
 static int kevent_ctl_process(struct file *file, unsigned int cmd, unsigned int num, void __user *arg)
 {
 	int err;
@@ -920,9 +847,6 @@
 	int err = -EINVAL;
 	struct file *file;
 
-	if (cmd == KEVENT_CTL_INIT)
-		return kevent_ctl_init();
-
 	file = fget(fd);
 	if (!file)
 		return -ENODEV;
@@ -948,16 +872,6 @@
 	kevent_cache = kmem_cache_create("kevent_cache", 
 			sizeof(struct kevent), 0, SLAB_PANIC, NULL, NULL);
 
-	err = register_filesystem(&kevent_fs_type);
-	if (err)
-		panic("%s: failed to register filesystem: err=%d.\n",
-			       kevent_name, err);
-
-	kevent_mnt = kern_mount(&kevent_fs_type);
-	if (IS_ERR(kevent_mnt))
-		panic("%s: failed to mount silesystem: err=%ld.\n", 
-				kevent_name, PTR_ERR(kevent_mnt));
-	
 	err = misc_register(&kevent_miscdev);
 	if (err) {
 		printk(KERN_ERR "Failed to register kevent miscdev: err=%d.\n", err);
@@ -969,17 +883,12 @@
 	return 0;
 
 err_out_exit:
-	mntput(kevent_mnt);
-	unregister_filesystem(&kevent_fs_type);
-
 	return err;
 }
 
 static void __devexit kevent_user_fini(void)
 {
 	misc_deregister(&kevent_miscdev);
-	mntput(kevent_mnt);
-	unregister_filesystem(&kevent_fs_type);
 }
 
 module_init(kevent_user_init);
Index: linux-2.6/include/linux/ukevent.h
===================================================================
--- linux-2.6.orig/include/linux/ukevent.h	2006-08-22 12:10:24.000000000 +0200
+++ linux-2.6/include/linux/ukevent.h	2006-08-22 13:48:05.000000000 +0200
@@ -131,6 +131,5 @@
 #define	KEVENT_CTL_ADD 		0
 #define	KEVENT_CTL_REMOVE	1
 #define	KEVENT_CTL_MODIFY	2
-#define	KEVENT_CTL_INIT		3
 
 #endif /* __UKEVENT_H */
