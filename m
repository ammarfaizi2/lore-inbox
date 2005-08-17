Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbVHQVCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVHQVCA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 17:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVHQVCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 17:02:00 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:61167 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751281AbVHQVB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 17:01:59 -0400
Date: Wed, 17 Aug 2005 14:01:43 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org
Subject: Re: [2.6.13-rc6-latest] SCSI disk registration msgs repeat themselves
Message-ID: <20050817210143.GA11364@us.ibm.com>
References: <200508162304_MC3-1-A768-3F2@compuserve.com> <20050817043933.GA2803@us.ibm.com> <20050816225113.1c3677c2.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050816225113.1c3677c2.zaitcev@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 10:51:13PM -0700, Pete Zaitcev wrote:
> On Tue, 16 Aug 2005 21:39:33 -0700, Patrick Mansfield <patmans@us.ibm.com> wrote:
> > On Tue, Aug 16, 2005 at 11:01:30PM -0400, Chuck Ebbert wrote:
> 
> > >   I just added some usb-storage devices to my system and got the below.
> 
> > > Why do the first four lines repeat for each device?  (Not sure if
> > > this is a SCSI or USB problem.)
> > 
> > It is in the partition code. I posted twice before about this with no
> > response.
> 
> It's not an important problem, presumably. I observe dual revalidations
> as well, but they are not that bothersome. Add to it that your patch

Yes.

Does this *only* happens for sd (scsi) devices?

> appears wrong (see below). If you offered an acceptable solution, I would
> expect a warmer welcome... But even then getting a reply from linux-scsi
> folks is like pulling a tooth (if my own little CD-ROM sizing patch is
> any indication). So, steel yourself for challenges of this life, Patrick!

;-)

> Here's what it was in 2.6.9, as documented in drivers/block/ub.c:
> 
> +	/*
> +	 * This is a workaround for a specific problem in our block layer.
> +	 * In 2.6.9, register_disk duplicates the code from rescan_partitions.
> +	 * However, if we do add_disk with a device which persistently reports
> +	 * a changed media, add_disk calls register_disk, which does do_open,
> +	 * which will call rescan_paritions for changed media. After that,
> +	 * register_disk attempts to do it all again and causes double kobject
> +	 * registration and a eventually an oops on module removal.
> +	 *
> +	 * The bottom line is, Al Viro says that we should not allow
> +	 * bdev->bd_invalidated to be set when doing add_disk no matter what.
> +	 */

> +	if (sc->first_open) {
> +		if (sc->changed) {
> +			sc->first_open = 0;
> +			rc = -ENOMEDIUM;
> +			goto err_open;
> +		}
> +	}
> 
> Users were hitting it with oopses like these:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0409.2/0011.html
> 
> The ub alone was not suffient to motivate Al for the fix, so I added
> this silly "first_open" thingie, which papered over it. It was thought
> that sd was miraclously immune.
> 
> However, over time users hit it with usb-storage and sd, like this:
>  http://lkml.org/lkml/2004/2/21/19
> This prompted Al's action. He simply dropped all the extra code like
> this:
> 
> --- linux-2.6.9-11.5.EL/fs/partitions/check.c	2004-10-18 14:55:07.000000000 -0700
> +++ linux-2.6.12/fs/partitions/check.c	2005-06-17 12:48:29.000000000 -0700
> @@ -358,24 +357,9 @@ void register_disk(struct gendisk *disk)
>  	if (!bdev)
>  		return;
>  
> +	bdev->bd_invalidated = 1;
>  	if (blkdev_get(bdev, FMODE_READ, 0) < 0)
>  		return;
> -	state = check_partition(disk, bdev);
> -	if (state) {
> -		for (j = 1; j < state->limit; j++) {
> -			sector_t size = state->parts[j].size;
> -			sector_t from = state->parts[j].from;
> -			if (!size)
> -				continue;
> -			add_partition(disk, j, from, size);
> -#ifdef CONFIG_BLK_DEV_MD
> -			if (!state->parts[j].flags)
> -				continue;
> -			md_autodetect_dev(bdev->bd_dev+j);
> -#endif
> -		}
> -		kfree(state);
> -	}
>  	blkdev_put(bdev);
>  }

OK, thanks for posting those links and information.

> > --- linux-2.6.11-rc1/fs/partitions/check.c	Fri Dec 24 13:35:28 2004
> > +++ no-double-sd-linux-2.6.11-rc1/fs/partitions/check.c	Fri Jan 21 11:19:00 2005
> > @@ -375,8 +375,6 @@ int rescan_partitions(struct gendisk *di
> >  	bdev->bd_invalidated = 0;
> >  	for (p = 1; p < disk->minors; p++)
> >  		delete_partition(disk, p);
> > -	if (disk->fops->revalidate_disk)
> > -		disk->fops->revalidate_disk(disk);
> 
> As for your proposed fix, it may be problematic. The ->revalidate
> method has to be called at least once for a new device, because
> that's when drivers fetch the capacities. But ->open only calls
> check_disk_change() for removable devices. Who is going to call
> ->revalidate inside add_disk() for non-removable devices?

sd.c always calls its revalidate_disk method (sd_revalidate_disk) when the
device is attached, so for scsi, we definitely do not miss anything.

I thought revalidate_disk was not called prior to Al's patch, so why do we
need to call it on the first open now?

You already have to call set_capacity() before add_disk(), else
register_disk thinks there is no media present, and won't set
bd_invalidated. So drivers must already get the capacity (or fake it)
prior to calling add_disk.

-- Patrick Mansfield
