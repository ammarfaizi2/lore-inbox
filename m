Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWI0Mvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWI0Mvt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 08:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWI0Mvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 08:51:49 -0400
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:28144 "EHLO
	ausmtp06.au.ibm.com") by vger.kernel.org with ESMTP id S932203AbWI0Mvs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 08:51:48 -0400
Message-ID: <451A78DF.1060901@in.ibm.com>
Date: Wed, 27 Sep 2006 18:43:03 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060801)
MIME-Version: 1.0
To: dm-devel@redhat.com, linux-lvm@redhat.com, linux-kernel@vger.kernel.org,
       mingo@elte.hu, agk@redhat.com
Subject: [RFC] Reverting "bd_mount_mutex" to "bd_mount_sem"
Content-Type: multipart/mixed;
 boundary="------------020402080609080603050102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020402080609080603050102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all
  When I was executing "dmsetup resume <device-name>" command,I got the 
error shown below. Which basically tells that, "bd_mount_mutex"  in 
thaw_bdev() is not locked by "dmsetup resume" command and hence it is 
not allowing it to unlock also.
=========================================================
Badness in debug_mutex_unlock at kernel/mutex-debug.c:80

Call Trace:
[C0000000634DB260] [C000000000010948] .show_stack+0x68/0x1b0 (unreliable)
[C0000000634DB300] [C0000000003376C4] .program_check_exception+0x1cc/0x5b0
[C0000000634DB3D0] [C0000000000047EC] program_check_common+0xec/0x100
--- Exception: 700 at .debug_mutex_unlock+0x3c/0xc4
    LR = .debug_mutex_unlock+0x30/0xc4
[C0000000634DB6C0] [C0000000634DB750] 0xc0000000634db750 (unreliable)
[C0000000634DB740] [C000000000335950] .__mutex_unlock_slowpath+0xd8/0x144
[C0000000634DB7E0] [C0000000000E2370] .thaw_bdev+0x9c/0xb8
[C0000000634DB870] [D000000000480830] .unlock_fs+0x34/0x70 [dm_mod]
[C0000000634DB900] [D000000000481720] .dm_resume+0x110/0x1ac [dm_mod]
[C0000000634DB9A0] [D000000000485C54] .dev_suspend+0x1b0/0x204 [dm_mod]
[C0000000634DBA40] [D000000000486728] .ctl_ioctl+0x29c/0x318 [dm_mod]
[C0000000634DBC30] [C0000000000F8310] .do_ioctl+0xbc/0xf0
[C0000000634DBCD0] [C0000000000F879C] .vfs_ioctl+0x458/0x498
[C0000000634DBD80] [C0000000000F8874] .sys_ioctl+0x98/0xe0
[C0000000634DBE30] [C00000000000871C] syscall_exit+0x0/0x40
======================================================================

   On debugging I found out that,"dmsetup suspend <device name>" calls 
"freeze_bdev()",which locks "bd_mount_mutex" to make sure that no new 
mounts happen on bdev until thaw_bdev() is called.
   This "thaw_bdev()" is getting called when we resume the device through
"dmsetup resume <device-name>".
   Hence we have 2 processes,one of which locks "bd_mount_mutex"(dmsetup
suspend) and Another(dmsetup resume) unlocks it.

   Since this is not allowed in mutex,I reverted back to 
bd_mount_sem(semaphore),It worked for me.

  So  need your comments for changing "bd_mount_mutex" to "bd_mount_sem".
  
  This is the patch,which I have used.

Thanks
 Srinivasa Ds
 LTC-IBM
 Bangalore



--------------020402080609080603050102
Content-Type: text/plain;
 name="mutex_to_sem.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mutex_to_sem.fix"

diff -Naurp linux-2.6.18-rc6-orig/fs/block_dev.c linux-2.6.18-rc6-mod/fs/block_dev.c
--- linux-2.6.18-rc6-orig/fs/block_dev.c	2006-09-27 04:47:25.000000000 -0700
+++ linux-2.6.18-rc6-mod/fs/block_dev.c	2006-09-27 04:53:29.000000000 -0700
@@ -261,7 +261,7 @@ static void init_once(void * foo, kmem_c
 	{
 		memset(bdev, 0, sizeof(*bdev));
 		mutex_init(&bdev->bd_mutex);
-		mutex_init(&bdev->bd_mount_mutex);
+		sema_init(&bdev->bd_mount_sem, 1);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
 #ifdef CONFIG_SYSFS
diff -Naurp linux-2.6.18-rc6-orig/fs/buffer.c linux-2.6.18-rc6-mod/fs/buffer.c
--- linux-2.6.18-rc6-orig/fs/buffer.c	2006-09-27 04:46:14.000000000 -0700
+++ linux-2.6.18-rc6-mod/fs/buffer.c	2006-09-27 04:49:55.000000000 -0700
@@ -213,7 +213,7 @@ struct super_block *freeze_bdev(struct b
 {
 	struct super_block *sb;
 
-	mutex_lock(&bdev->bd_mount_mutex);
+	down(&bdev->bd_mount_sem);
 	sb = get_super(bdev);
 	if (sb && !(sb->s_flags & MS_RDONLY)) {
 		sb->s_frozen = SB_FREEZE_WRITE;
@@ -255,7 +255,7 @@ void thaw_bdev(struct block_device *bdev
 		drop_super(sb);
 	}
 
-	mutex_unlock(&bdev->bd_mount_mutex);
+	up(&bdev->bd_mount_sem);
 }
 EXPORT_SYMBOL(thaw_bdev);
 
diff -Naurp linux-2.6.18-rc6-orig/fs/super.c linux-2.6.18-rc6-mod/fs/super.c
--- linux-2.6.18-rc6-orig/fs/super.c	2006-09-27 04:46:51.000000000 -0700
+++ linux-2.6.18-rc6-mod/fs/super.c	2006-09-27 04:50:56.000000000 -0700
@@ -700,9 +700,9 @@ int get_sb_bdev(struct file_system_type 
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
 
diff -Naurp linux-2.6.18-rc6-orig/include/linux/fs.h linux-2.6.18-rc6-mod/include/linux/fs.h
--- linux-2.6.18-rc6-orig/include/linux/fs.h	2006-09-27 04:45:31.000000000 -0700
+++ linux-2.6.18-rc6-mod/include/linux/fs.h	2006-09-27 04:52:30.000000000 -0700
@@ -414,7 +414,7 @@ struct block_device {
 	struct inode *		bd_inode;	/* will die */
 	int			bd_openers;
 	struct mutex		bd_mutex;	/* open/close mutex */
-	struct mutex		bd_mount_mutex;	/* mount mutex */
+	struct semaphore        bd_mount_sem;
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;

--------------020402080609080603050102--
