Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbUB0BHl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbUB0BGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:06:53 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:34265 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S261559AbUB0BFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:05:15 -0500
Date: Fri, 27 Feb 2004 12:04:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linus@osdl.org, anton@samba.org, paulus@samba.org,
       axboe@suse.de, piggin@cyberone.com.au,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iSeries virtual disk
Message-Id: <20040227120451.0e3c43bd.sfr@canb.auug.org.au>
In-Reply-To: <20040226095156.GA25423@lst.de>
References: <20040123163504.36582570.sfr@canb.auug.org.au>
	<20040122221136.174550c3.akpm@osdl.org>
	<20040226172325.3a139f73.sfr@canb.auug.org.au>
	<20040226095156.GA25423@lst.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__27_Feb_2004_12_04_51_+1100_e2esplu0XIP=oB8F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__27_Feb_2004_12_04_51_+1100_e2esplu0XIP=oB8F
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Christoph,

On Thu, 26 Feb 2004 10:51:56 +0100 Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Feb 26, 2004 at 05:23:25PM +1100, Stephen Rothwell wrote:
> > Unfortunately, things have moved on in the last couple of weeks and to
> > fix everyone;s abjections, I need to include in this patch a ppc64 specific
> > version of the dma_mapping routines.  They are pretty straight forward.
> 
> While thes dma mapping changes look good they really don't belong into a
> patch for a new driver. Can you split them out into a separate patch? 

Yeah, I don't know what I was thinking :-(

> > Disks are now called /dev/iseries/vd<x><n> (without devfs) or
> > /dev/viod/disc<n>/part<n> (with devfs).  Up to 7 partitions are supported
> > on each of up to 32 disks.
> 
> Hmm, different names for devfs vs non-devfs seems silly.  But I think we
> can't easily get rid of the disc<foo>/part sillyness.  Can you at least
> make both use the same prefix?

I was trying to maintain compatability with a previously published
(out of tree) version of the driver, but I think I have broken that
anyway, so I will change ths as well.

> >  config VIOCD
> >  	tristate "iSeries Virtual I/O CD support"
> >  	help
> 
> What happened to this driver, btw?

Coming soon to a mailing list near you :-) (I decided to separate them)

> So vio on iseries claims to be pci?  That's a little silly if you ask
> me..

It is an expedience and changes are already in train to change this.

> > +#include <linux/major.h>
> > +#include <linux/fs.h>
> > +#include <asm/uaccess.h>
> 
> please put all asm/* headers after linux/*

done.

> > +#include <linux/hdreg.h>
> 
> probably not needed anymore without ide emulation.

it is, actually. for HDIO_GETGEO ioctl stuff.

> > +#include <linux/seq_file.h>
> 
> you don't use this anymore, do you?

Thanks, missed removing it with the rest of the proc stuff.

> > +static int		viodasd_max_disk;
> 
> the code surrounding this doesn't look right yet.  You first initialize
> it to the maximum value and then reset it in a magic even handler?
> I think that logic needs some clarification.

The "magic event handler" is synchronous with the probe_disk routine.  I
agree it is a bit confusing, but, at least I have the comment there about
the side effects of the probe_disk routine.  Changed slightly.

> > +#define DEVICE_NO(cell)	((struct viodasd_device *)(cell) - &viodasd_devices[0])
> 
> Aniother idea:  It might be better to just put a disk_no member into
> struct viodasd_device - then you can allocate the struct viodasd_device
> dynamically one by one and easily support lots of disks without overhead
> for lowend configurations (remember we have a 32bit dev_t now)

Can I leave this for now?

> > +extern struct device *iSeries_vio_dev;
> 
> shouldn't this be in some header?

Yes, it should, but can I leave this to the future as well, please?

> > +static void viodasd_init_disk(struct viodasd_device *d);
> 
> What's preventing this one to be implemented above it's usage? or even
> better merging it into it's only caller.

Nothing, now.

> > +static void viodasd_end_request(struct request *req, int uptodate,
> > +		int num_sectors)
> > +{
> > +	if (end_that_request_first(req, uptodate, num_sectors))
> > +		return;
> > +        add_disk_randomness(req->rq_disk);
> > +	end_that_request_last(req);
> > +}
> 
> indentation looks messed up here.

Yeah, spaces v. tabs.

> > +static void viodasd_init_disk(struct viodasd_device *d)
> > +{
> > +	struct gendisk *g;
> > +	struct request_queue *q;
> > +	int disk_no = DEVICE_NO(d);
> > +
> > +	if (d->disk)
> > +		return;
> 
> as there's only one caller it shouldn't happen, should it?

Correct.

> > +	g->private_data = (void *)d;
> 
> no need to cast to void * here - this is implicit in C

OK.

> > +        for (i = 0; i < MAX_DISKNO; i++) {
> > +		d = &viodasd_devices[i];
> > +		if (d->disk) {
> 
> How can d->disk ever be NULLL here?

Because it was never initialised ... we only create the gendisks for
disks that exist.

> > +			if (d->disk->queue)
> > +				blk_cleanup_queue(d->disk->queue);
> > +			del_gendisk(d->disk);
> 
> the queue cleanups needs to be after put_gendisk.  Also where did you
> see d->disk->queue as NULL?

OK, fixed.

New patch following soon ...
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__27_Feb_2004_12_04_51_+1100_e2esplu0XIP=oB8F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPpezFG47PeJeR58RArJ4AJ9nj4MEI5ZauV30hdNVjfJzCMLL3ACffhRB
fEdLmgt8bBrmLNoBGgrMosg=
=B0o9
-----END PGP SIGNATURE-----

--Signature=_Fri__27_Feb_2004_12_04_51_+1100_e2esplu0XIP=oB8F--
