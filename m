Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWG3Tlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWG3Tlv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 15:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWG3Tlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 15:41:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22671 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932466AbWG3Tlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 15:41:51 -0400
Date: Sun, 30 Jul 2006 12:41:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>
Subject: Re: let md auto-detect 128+ raid members, fix potential race
 condition
Message-Id: <20060730124139.45861b47.akpm@osdl.org>
In-Reply-To: <ork65veg2y.fsf@free.oliva.athome.lsd.ic.unicamp.br>
References: <ork65veg2y.fsf@free.oliva.athome.lsd.ic.unicamp.br>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2006 03:56:21 -0300
Alexandre Oliva <aoliva@redhat.com> wrote:

> I accidentally ran into the 128-devices limit in md.c's
> detected_devices.  It doesn't seem like a high-enough limit, and I
> don't quite see why we wouldn't use a list for this.
> 
> Besides, there appears to be a race condition in it:
> 
>          detected_devices[dev_cnt++] = dev;
> 
> won't atomically increment dev_cnt and use its previous value, unless
> there's something up the call stack that guarantees mutual exclusion.
> I don't see that this is the case.
> 
> Previously devices that exceeded the array would be silently
> discarded.  Now we'll only discard them if we run out of memory, and
> we'll report so if we do.

Neil cc'ed.

> Before I wrap up, a question on style: does it make sense to use
> kzmalloc to allocate this newly-created data structure that contains
> only a list_head and a dev_t, where the latter is immediately copied
> from another dev_t variable, and then the whole thing is added to a
> list?  I.e., could any list-checking present or future feature rely on
> list_head fields that might hurt if not zero-initialized, or would it
> be future-proof to just use kmalloc in this case?

I'd say that if all fields are going to be initialised, kzalloc() shouldn't
be used.

nits:

Index: kernel-2.6.17-1.2462.fc6/drivers/md/md.c
> ===================================================================
> --- kernel-2.6.17-1.2462.fc6.orig/drivers/md/md.c	2006-07-30 01:03:28.000000000 -0300
> +++ kernel-2.6.17-1.2462.fc6/drivers/md/md.c	2006-07-30 03:40:54.000000000 -0300
> @@ -1435,7 +1435,7 @@ static void unlock_rdev(mdk_rdev_t *rdev
>  	blkdev_put_partition(bdev);
>  }
>  
> -void md_autodetect_dev(dev_t dev);
> +int md_register_autodetect_dev(dev_t dev);

Put it in a header file, please.
 
> +int md_register_autodetect_dev(dev_t dev)
>  {
> -	if (dev_cnt >= 0 && dev_cnt < 127)
> -		detected_devices[dev_cnt++] = dev;
> +	struct detected_dev_list_t *ldev = kzalloc(sizeof (*ldev), GFP_KERNEL);
> +
> +	if (!ldev)
> +	  return -1;

whitespace broke.

>  }
> Index: kernel-2.6.17-1.2462.fc6/fs/partitions/check.c
> ===================================================================
> --- kernel-2.6.17-1.2462.fc6.orig/fs/partitions/check.c	2006-07-30 01:03:34.000000000 -0300
> +++ kernel-2.6.17-1.2462.fc6/fs/partitions/check.c	2006-07-30 03:41:02.000000000 -0300
> @@ -36,7 +36,7 @@
>  #include "karma.h"
>  
>  #ifdef CONFIG_BLK_DEV_MD
> -extern void md_autodetect_dev(dev_t dev);
> +extern int md_register_autodetect_dev(dev_t dev);
>  #endif

Again, let's find a header for this.

>  int warn_no_part = 1; /*This is ugly: should make genhd removable media aware*/
> @@ -471,8 +471,10 @@ int rescan_partitions(struct gendisk *di
>  		}
>  		add_partition(disk, p, from, size);
>  #ifdef CONFIG_BLK_DEV_MD
> -		if (state->parts[p].flags)
> -			md_autodetect_dev(bdev->bd_dev+p);
> +		if (state->parts[p].flags
> +		    && md_register_autodetect_dev(bdev->bd_dev+p))
> +			printk(KERN_ERR "md: out of memory registering %s%d\n",
> +			       disk->disk_name, p);
>  #endif

What happens if CONFIG_BLK_DEV_MD=m?
