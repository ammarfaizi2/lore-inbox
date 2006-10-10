Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWJJPFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWJJPFP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 11:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWJJPFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 11:05:15 -0400
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:58552 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP id S932151AbWJJPFN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 11:05:13 -0400
Message-ID: <452BB67E.7000700@in.ibm.com>
Date: Tue, 10 Oct 2006 20:34:30 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Eric Sandeen <sandeen@sandeen.net>
CC: Ingo Molnar <mingo@elte.hu>, dm-devel@redhat.com, linux-lvm@redhat.com,
       linux-kernel@vger.kernel.org, agk@redhat.com
Subject: Re: [RFC] Reverting "bd_mount_mutex" to "bd_mount_sem"
References: <451A78DF.1060901@in.ibm.com> <20060927135705.GA30311@elte.hu> <4526C184.7070507@sandeen.net>
In-Reply-To: <4526C184.7070507@sandeen.net>
Content-Type: multipart/mixed;
 boundary="------------060308030904000603050506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060308030904000603050506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Eric Sandeen wrote:
> Ingo Molnar wrote:
>   
>> * Srinivasa Ds <srinivasa@in.ibm.com> wrote:
>>
>>     
>>>   On debugging I found out that,"dmsetup suspend <device name>" calls 
>>> "freeze_bdev()",which locks "bd_mount_mutex" to make sure that no new 
>>> mounts happen on bdev until thaw_bdev() is called.
>>>   This "thaw_bdev()" is getting called when we resume the device 
>>> through "dmsetup resume <device-name>".
>>>   Hence we have 2 processes,one of which locks 
>>> "bd_mount_mutex"(dmsetup suspend) and Another(dmsetup resume) unlocks 
>>> it.
>>>       
>> hm, to me this seems quite a fragile construct - even if the 
>> mutex-debugging warning is worked around by reverting to a semaphore.
>>
>> 	Ingo
>>     
>
> Ingo, what do you feel is fragile about this?  It seems like this is a
> reasonable way to go, except that maybe a down_trylock would be good if
> a 2nd process tries to freeze while it's already frozen...
>
> Thanks,
>
> -Eric
>   
Ingo, As per the discussion resending the patch with down_trylock.

Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>



--------------060308030904000603050506
Content-Type: text/plain;
 name="dmsetup.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmsetup.fix"

---
 fs/block_dev.c     |    2 +-
 fs/buffer.c        |    6 ++++--
 fs/super.c         |    4 ++--
 include/linux/fs.h |    2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

Index: linux-2.6.19-rc1/fs/block_dev.c
===================================================================
--- linux-2.6.19-rc1.orig/fs/block_dev.c
+++ linux-2.6.19-rc1/fs/block_dev.c
@@ -263,7 +263,7 @@ static void init_once(void * foo, kmem_c
 	{
 		memset(bdev, 0, sizeof(*bdev));
 		mutex_init(&bdev->bd_mutex);
-		mutex_init(&bdev->bd_mount_mutex);
+		sema_init(&bdev->bd_mount_sem, 1);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
 #ifdef CONFIG_SYSFS
Index: linux-2.6.19-rc1/fs/buffer.c
===================================================================
--- linux-2.6.19-rc1.orig/fs/buffer.c
+++ linux-2.6.19-rc1/fs/buffer.c
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
 
Index: linux-2.6.19-rc1/fs/super.c
===================================================================
--- linux-2.6.19-rc1.orig/fs/super.c
+++ linux-2.6.19-rc1/fs/super.c
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
 
Index: linux-2.6.19-rc1/include/linux/fs.h
===================================================================
--- linux-2.6.19-rc1.orig/include/linux/fs.h
+++ linux-2.6.19-rc1/include/linux/fs.h
@@ -456,7 +456,7 @@ struct block_device {
 	struct inode *		bd_inode;	/* will die */
 	int			bd_openers;
 	struct mutex		bd_mutex;	/* open/close mutex */
-	struct mutex		bd_mount_mutex;	/* mount mutex */
+	struct semaphore        bd_mount_sem;
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;

--------------060308030904000603050506--
