Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWINIsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWINIsc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 04:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWINIsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 04:48:32 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:61352 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751467AbWINIsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 04:48:31 -0400
Subject: Re: [PATCH 2/2] new bd_mutex lockdep annotation
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Neil Brown <neilb@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@linux.intel.com>,
       Andrew Morton <akpm@osdl.org>, Jason Baron <jbaron@redhat.com>
In-Reply-To: <17673.153.361371.49294@cse.unsw.edu.au>
References: <20060913174312.528491000@chello.nl>
	 <20060913174650.432175000@chello.nl>
	 <17673.153.361371.49294@cse.unsw.edu.au>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 10:50:15 +0200
Message-Id: <1158223815.30737.86.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 17:11 +1000, Neil Brown wrote:
> On Wednesday September 13, a.p.zijlstra@chello.nl wrote:
> > Use the gendisk partition number to set a lock class.
> 
> Yes, this does look a lot nicer, thanks.
> 
> Two observations.
> 1/ I was confused that you added a call to mutex_init.   One would
>  normally expect to only have one of these for any given mutex, so
>  adding one was a surprise.
>  I now realise that the purpose of this call is not exactly to init
>  the mutex, but to init the lockdep class in case this inode was
>  previously used for a partition but is now being used for a whole
>  device.  This makes sense, but renders the mutex_init in 
>  init_once pointless.  Maybe that should be removed?

Yes, that would be quite redundant now, new patch attached.

> 2/ You are introducing a new call to get_gendisk.
>    This bothers me for two reasons.  Both relate to a comparison
>    with the call to get_gendisk in block_dev.c:do_open.
>    a/ That call is protected by lock_kernel.  Your call is not.
>    b/ That call is followed by a test for '!disk' implying that it
>        can return NULL.  Yours is not - at least not obviously
>        (put_disk does have the check).

a) kobj_lookup() vs kobj_(un)map() use the domain lock.

Not all calls to blk_register_region() were under lock_kernel() afaicf.

So I don't think this is needed, but I'll gladly take advise otherwise,
I'm not well versed with the kobj stuff.

b) from quick inspection yesterday I reached two (false) conclusions
 - &part would not be changed when !disk
 - disk would have to exists at the time we call bdget()
Now I can't seem to validate either of them. Added disk to the if
statement just to be safe.

>    I'm not sure if these are actually problems, but the do bother me.
> 
>    Thinking through the possibly reasons for the lock_kernel, I wonder
>    it the current device number mapping scheme actually allows you
>    to determine if something is partitioned or not in a static sense.
>    Maybe that is only guaranteed to be stable while the device is
>    open...

Hmm, yes I think I see what you mean...

>    I wonder if Al Viro could put my mind at rest .... Al - do you have
>    a moment to look at this?  Thanks.

+1

---

Use the gendisk partition number to set a lock class.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Acked-by: Arjan van de Ven <arjan@linux.intel.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Jason Baron <jbaron@redhat.com>
---
 fs/block_dev.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Index: linux-2.6-mm/fs/block_dev.c
===================================================================
--- linux-2.6-mm.orig/fs/block_dev.c
+++ linux-2.6-mm/fs/block_dev.c
@@ -264,7 +264,6 @@ static void init_once(void * foo, kmem_c
 	    SLAB_CTOR_CONSTRUCTOR)
 	{
 		memset(bdev, 0, sizeof(*bdev));
-		mutex_init(&bdev->bd_mutex);
 		mutex_init(&bdev->bd_mount_mutex);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
@@ -357,10 +356,14 @@ static int bdev_set(struct inode *inode,
 
 static LIST_HEAD(all_bdevs);
 
+static struct lock_class_key bdev_part_lock_key;
+
 struct block_device *bdget(dev_t dev)
 {
 	struct block_device *bdev;
 	struct inode *inode;
+	struct gendisk *disk;
+	int part = 0;
 
 	inode = iget5_locked(bd_mnt->mnt_sb, hash(dev),
 			bdev_test, bdev_set, &dev);
@@ -386,6 +389,11 @@ struct block_device *bdget(dev_t dev)
 		list_add(&bdev->bd_list, &all_bdevs);
 		spin_unlock(&bdev_lock);
 		unlock_new_inode(inode);
+		mutex_init(&bdev->bd_mutex);
+		disk = get_gendisk(dev, &part);
+		if (disk && part)
+			lockdep_set_class(&bdev->bd_mutex, &bdev_part_lock_key);
+		put_disk(disk);
 	}
 	return bdev;
 }


