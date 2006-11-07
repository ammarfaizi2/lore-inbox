Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWKGSfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWKGSfa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754264AbWKGSfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:35:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52874 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754266AbWKGSf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:35:29 -0500
Date: Tue, 7 Nov 2006 18:34:59 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Ingo Molnar <mingo@elte.hu>, Eric Sandeen <sandeen@sandeen.net>,
       Srinivasa DS <srinivasa@in.ibm.com>
Subject: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061107183459.GG6993@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, dm-devel@redhat.com,
	Ingo Molnar <mingo@elte.hu>, Eric Sandeen <sandeen@sandeen.net>,
	Srinivasa DS <srinivasa@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivasa Ds <srinivasa@in.ibm.com>

On debugging I found out that,"dmsetup suspend <device name>" calls
"freeze_bdev()",which locks "bd_mount_mutex" to make sure that no new mounts
happen on bdev until thaw_bdev() is called.  This "thaw_bdev()" is getting
called when we resume the device through "dmsetup resume <device-name>".
Hence we have 2 processes,one of which locks "bd_mount_mutex"(dmsetup
suspend) and another(dmsetup resume) unlocks it.                                               

Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Eric Sandeen <sandeen@sandeen.net>
Cc: dm-devel@redhat.com

Index: linux-2.6.19-rc4/fs/block_dev.c
===================================================================
--- linux-2.6.19-rc4.orig/fs/block_dev.c	2006-11-07 17:06:20.000000000 +0000
+++ linux-2.6.19-rc4/fs/block_dev.c	2006-11-07 17:26:04.000000000 +0000
@@ -263,7 +263,7 @@ static void init_once(void * foo, kmem_c
 	{
 		memset(bdev, 0, sizeof(*bdev));
 		mutex_init(&bdev->bd_mutex);
-		mutex_init(&bdev->bd_mount_mutex);
+		sema_init(&bdev->bd_mount_sem, 1);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
 #ifdef CONFIG_SYSFS
Index: linux-2.6.19-rc4/fs/buffer.c
===================================================================
--- linux-2.6.19-rc4.orig/fs/buffer.c	2006-11-07 17:06:20.000000000 +0000
+++ linux-2.6.19-rc4/fs/buffer.c	2006-11-07 17:26:04.000000000 +0000
@@ -188,7 +188,9 @@ struct super_block *freeze_bdev(struct b
 {
 	struct super_block *sb;
 
-	mutex_lock(&bdev->bd_mount_mutex);
+	if (down_trylock(&bdev->bd_mount_sem))
+		return -EBUSY;
+
 	sb = get_super(bdev);
 	if (sb && !(sb->s_flags & MS_RDONLY)) {
 		sb->s_frozen = SB_FREEZE_WRITE;
@@ -230,7 +232,7 @@ void thaw_bdev(struct block_device *bdev
 		drop_super(sb);
 	}
 
-	mutex_unlock(&bdev->bd_mount_mutex);
+	up(&bdev->bd_mount_sem);
 }
 EXPORT_SYMBOL(thaw_bdev);
 
Index: linux-2.6.19-rc4/fs/super.c
===================================================================
--- linux-2.6.19-rc4.orig/fs/super.c	2006-11-07 17:06:20.000000000 +0000
+++ linux-2.6.19-rc4/fs/super.c	2006-11-07 17:26:04.000000000 +0000
@@ -735,9 +735,9 @@ int get_sb_bdev(struct file_system_type 
 	 * will protect the lockfs code from trying to start a snapshot
 	 * while we are mounting
 	 */
-	mutex_lock(&bdev->bd_mount_mutex);
+	down(&bdev->bd_mount_sem);
 	s = sget(fs_type, test_bdev_super, set_bdev_super, bdev);
-	mutex_unlock(&bdev->bd_mount_mutex);
+	up(&bdev->bd_mount_sem);
 	if (IS_ERR(s))
 		goto error_s;
 
Index: linux-2.6.19-rc4/include/linux/fs.h
===================================================================
--- linux-2.6.19-rc4.orig/include/linux/fs.h	2006-11-07 17:06:20.000000000 +0000
+++ linux-2.6.19-rc4/include/linux/fs.h	2006-11-07 17:26:04.000000000 +0000
@@ -456,7 +456,7 @@ struct block_device {
 	struct inode *		bd_inode;	/* will die */
 	int			bd_openers;
 	struct mutex		bd_mutex;	/* open/close mutex */
-	struct mutex		bd_mount_mutex;	/* mount mutex */
+	struct semaphore        bd_mount_sem;
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;
