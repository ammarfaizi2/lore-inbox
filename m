Return-Path: <linux-kernel-owner+w=401wt.eu-S1161049AbXALJwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbXALJwQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 04:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161051AbXALJwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 04:52:16 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:50062 "EHLO
	ausmtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161049AbXALJwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 04:52:15 -0500
Message-ID: <45A76006.5070504@in.ibm.com>
Date: Fri, 12 Jan 2007 15:46:38 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.8 (X11/20061105)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Eric Sandeen <sandeen@redhat.com>, Alasdair G Kergon <agk@redhat.com>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
References: <20061107183459.GG6993@agk.surrey.redhat.com>	<20061107122837.54828e24.akpm@osdl.org>	<45510C73.7060408@redhat.com> <20061107150017.fb78a327.akpm@osdl.org>
In-Reply-To: <20061107150017.fb78a327.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------010702040602090709050200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010702040602090709050200
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> On Tue, 07 Nov 2006 16:45:07 -0600
> Eric Sandeen <sandeen@redhat.com> wrote:
>
>   
>> Andrew Morton wrote:
>>
>>     
>>>> --- linux-2.6.19-rc4.orig/fs/buffer.c	2006-11-07 17:06:20.000000000 +0000
>>>> +++ linux-2.6.19-rc4/fs/buffer.c	2006-11-07 17:26:04.000000000 +0000
>>>> @@ -188,7 +188,9 @@ struct super_block *freeze_bdev(struct b
>>>>  {
>>>>  	struct super_block *sb;
>>>>  
>>>> -	mutex_lock(&bdev->bd_mount_mutex);
>>>> +	if (down_trylock(&bdev->bd_mount_sem))
>>>> +		return -EBUSY;
>>>> +
>>>>         
>>> This is a functional change which isn't described in the changelog.  What's
>>> happening here?
>>>       
>> Only allow one bdev-freezer in at a time, rather than queueing them up?
>>
>>     
>
> You're asking me? ;)
>
> Guys, I'm going to park this patch pending a full description of what it
> does, a description of what the above hunk is doing 
Iam really sorry for delayed reply. Here is my full explanation on my 
patch.
Patch, that I have proposed replaces the mutex on bd_mount_mutex with 
the semaphore (bd_mount_sem). It was(bd_mount_sem) used to be a 
semaphore earlier and then Ingo's patch changed it to mutex. Hence we 
had the problem in device mapper commands. But now, the proposed patch 
allows two separate device mapper commands to suspend and resume the 
logical devices. Even though this explaination is from deveice mapper 
perspective, since semaphore(bd_mount_sem) existed earlier, proposed 
patch doesn't hurt XFS code which access the freeze_bdev().
As for as the above code is concerned,Iam using down_trylock() to allow 
only one process to freeze the filesystem at a time and hence stops the 
other process from queuing up.
> and pending an
> examination of whether we'd be better off changing the mutex-debugging code
> rather than switching to semaphores.
>
>   
Regarding this one,I agree with what Arjan has told.
" It's not used as a mutex. Sad but true. It's not so easy to say "just
shut up the debug code", because it's just not that easy: The interface
allows double "unlock", which is fine for semaphores for example. There
fundamentally is no "owner" for this case, and all the mutex concepts
assume that there is an owner. If the owner goes away, pointers to their
task struct for example are no longer valid (used by lockdep and the
other debugging parts). It's what makes the difference between a mutex
and a semaphore: a mutex has an owner and several semantics follow from
that. These semantics allow a more efficient implementation (no multiple
"owners" possible) but once you go away from that fundamental property,
soon we'll see "oh and it needs <this extra code> to cover the wider
semantics correctly.. and soon you have a semaphore again.

Let true semaphores be semaphores, and make all real mutexes mutexes.
But lets not make actual semaphores use mutex code... ".

So Iam reproposing my patch(taken against latest kernel) here. Please 
let me know your comments on this.

Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Eric Sandeen <sandeen@sandeen.net>
Cc: dm-devel@redhat.com




--------------010702040602090709050200
Content-Type: text/plain;
 name="dm.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dm.fix"

 fs/block_dev.c     |    2 +-
 fs/buffer.c        |    6 ++++--
 fs/super.c         |    4 ++--
 include/linux/fs.h |    2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

Index: linux-2.6.20-rc4/fs/block_dev.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/block_dev.c
+++ linux-2.6.20-rc4/fs/block_dev.c
@@ -411,7 +411,7 @@ static void init_once(void * foo, struct
 	{
 		memset(bdev, 0, sizeof(*bdev));
 		mutex_init(&bdev->bd_mutex);
-		mutex_init(&bdev->bd_mount_mutex);
+		sema_init(&bdev->bd_mount_sem, 1);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
 #ifdef CONFIG_SYSFS
Index: linux-2.6.20-rc4/fs/buffer.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/buffer.c
+++ linux-2.6.20-rc4/fs/buffer.c
@@ -189,7 +189,9 @@ struct super_block *freeze_bdev(struct b
 {
 	struct super_block *sb;
 
-	mutex_lock(&bdev->bd_mount_mutex);
+	if (down_trylock(&bdev->bd_mount_sem))
+		return -EBUSY;
+
 	sb = get_super(bdev);
 	if (sb && !(sb->s_flags & MS_RDONLY)) {
 		sb->s_frozen = SB_FREEZE_WRITE;
@@ -231,7 +233,7 @@ void thaw_bdev(struct block_device *bdev
 		drop_super(sb);
 	}
 
-	mutex_unlock(&bdev->bd_mount_mutex);
+	up(&bdev->bd_mount_sem);
 }
 EXPORT_SYMBOL(thaw_bdev);
 
Index: linux-2.6.20-rc4/include/linux/fs.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/fs.h
+++ linux-2.6.20-rc4/include/linux/fs.h
@@ -458,7 +458,7 @@ struct block_device {
 	struct inode *		bd_inode;	/* will die */
 	int			bd_openers;
 	struct mutex		bd_mutex;	/* open/close mutex */
-	struct mutex		bd_mount_mutex;	/* mount mutex */
+	struct semaphore	bd_mount_sem;
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;
Index: linux-2.6.20-rc4/fs/super.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/super.c
+++ linux-2.6.20-rc4/fs/super.c
@@ -753,9 +753,9 @@ int get_sb_bdev(struct file_system_type 
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
 

--------------010702040602090709050200--
