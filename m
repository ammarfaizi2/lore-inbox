Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWINHL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWINHL3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 03:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWINHL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 03:11:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:18831 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751380AbWINHL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 03:11:28 -0400
From: Neil Brown <neilb@suse.de>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Al Viro <viro@zeniv.linux.org.uk>
Date: Thu, 14 Sep 2006 17:11:21 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17673.153.361371.49294@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@linux.intel.com>, Andrew Morton <akpm@osdl.org>,
       Jason Baron <jbaron@redhat.com>
Subject: Re: [PATCH 2/2] new bd_mutex lockdep annotation
In-Reply-To: message from Peter Zijlstra on Wednesday September 13
References: <20060913174312.528491000@chello.nl>
	<20060913174650.432175000@chello.nl>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday September 13, a.p.zijlstra@chello.nl wrote:
> Use the gendisk partition number to set a lock class.

Yes, this does look a lot nicer, thanks.

Two observations.
1/ I was confused that you added a call to mutex_init.   One would
 normally expect to only have one of these for any given mutex, so
 adding one was a surprise.
 I now realise that the purpose of this call is not exactly to init
 the mutex, but to init the lockdep class in case this inode was
 previously used for a partition but is now being used for a whole
 device.  This makes sense, but renders the mutex_init in 
 init_once pointless.  Maybe that should be removed?

2/ You are introducing a new call to get_gendisk.
   This bothers me for two reasons.  Both relate to a comparison
   with the call to get_gendisk in block_dev.c:do_open.
   a/ That call is protected by lock_kernel.  Your call is not.
   b/ That call is followed by a test for '!disk' implying that it
       can return NULL.  Yours is not - at least not obviously
       (put_disk does have the check).

   I'm not sure if these are actually problems, but the do bother me.

   Thinking through the possibly reasons for the lock_kernel, I wonder
   it the current device number mapping scheme actually allows you
   to determine if something is partitioned or not in a static sense.
   Maybe that is only guaranteed to be stable while the device is
   open...
   I wonder if Al Viro could put my mind at rest .... Al - do you have
   a moment to look at this?  Thanks.

NeilBrown
    
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Neil Brown <neilb@cse.unsw.edu.au>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Andrew Morton <akpm@osdl.org>
> Cc: Jason Baron <jbaron@redhat.com>
> ---
>  fs/block_dev.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> Index: linux-2.6-mm/fs/block_dev.c
> ===================================================================
> --- linux-2.6-mm.orig/fs/block_dev.c
> +++ linux-2.6-mm/fs/block_dev.c
> @@ -357,10 +357,14 @@ static int bdev_set(struct inode *inode,
>  
>  static LIST_HEAD(all_bdevs);
>  
> +static struct lock_class_key bdev_part_lock_key;
> +
>  struct block_device *bdget(dev_t dev)
>  {
>  	struct block_device *bdev;
>  	struct inode *inode;
> +	struct gendisk *disk;
> +	int part = 0;
>  
>  	inode = iget5_locked(bd_mnt->mnt_sb, hash(dev),
>  			bdev_test, bdev_set, &dev);
> @@ -386,6 +390,11 @@ struct block_device *bdget(dev_t dev)
>  		list_add(&bdev->bd_list, &all_bdevs);
>  		spin_unlock(&bdev_lock);
>  		unlock_new_inode(inode);
> +		mutex_init(&bdev->bd_mutex);
> +		disk = get_gendisk(dev, &part);
> +		if (part)
> +			lockdep_set_class(&bdev->bd_mutex, &bdev_part_lock_key);
> +		put_disk(disk);
>  	}
>  	return bdev;
>  }
> 
> --
