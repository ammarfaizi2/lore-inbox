Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264800AbTE1Qud (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 12:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264802AbTE1Qud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 12:50:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59017 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264800AbTE1Qu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 12:50:28 -0400
Date: Wed, 28 May 2003 19:03:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Andy Polyakov <appro@fy.chalmers.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-70 ide-cd to guarantee fault-free CD/DVD burning experience?
Message-ID: <20030528170347.GC845@suse.de>
References: <3ED4681A.738DA3C6@fy.chalmers.se> <20030528074839.GU845@suse.de> <3ED4E70D.1E62D435@fy.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED4E70D.1E62D435@fy.chalmers.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28 2003, Andy Polyakov wrote:
> > > As for scsi_ioctl.c in more general sense. It apparently doesn't comply
> > > with SG HOWTO, in particular it mis-interprets time-out values.
> > > Background information and patch is available at
> > > http://fy.chalmers.se/~appro/linux/DVD+RW/scsi_ioctl-2.5.69.patch.
> > > There're couple of other issues, usage of 'bytes' variable in access_ok
> 
> 	bytes = (hdr.dxfer_len + 511) & ~511;
> 	... access_ok(VERIFY_READ, uaddr, bytes)...
>                                           ^^^^^ Shouldn't this be
> hdr.dxfer_len? At least that's what memcpy-ed to kalloc-ated buffer.

Yes!

> > > and DMA being off when bio_map_user fails,
> 
> While tracing problems down I've commented out call to bio_map_user. But
> of course it could have failed for more legitimate reasons, couldn't it?
> Reasons such as user buffer residing in non DMA-capable region(?) or
> being misaligned. But in either case I noticed that DMA is never engaged

Correct.

> on that buffer allocated with kmalloc. The question is if it's
> intentional? If answer is yes, then the case is dismissed. If not, then
> it should be looked into. Now I don't know if it's apporpriate to

Depends on the lower level driver, for ide-cd yes kmalloc'ed data will
not be dma'ed to. We require a valid bio setup for that, usually the bio
mapping will fail exactly because the length/alignment isn't correct for
ide-cd.

sr will dma to the kmalloced buffer just fine.

> complement GPF_USER with GFP_DMA, but it might be appropriate to retry
> bio_map_user on buffer. I'm actually stepping out of my competence
> domains here...

It's usually not worth it. If the buffer is < 4 bytes, we don't dma. Big
deal. It's the programs responsibility to make sure that data + length
is appropriately aligned for dma operations akin to O_DIRECT for
instance. And they already do that, so...

> > > @@ -1471,8 +1472,13 @@
> > >               /* Keep count of how much data we've moved. */
> > >               rq->data += thislen;
> > >               rq->data_len -= thislen;
> > > +#if 0
> > >               if (rq->cmd[0] == GPCMD_REQUEST_SENSE)
> > >                       rq->sense_len++;
> > > +#else
> > > +             if (rq->flags & REQ_SENSE)
> > > +                     rq->sense_len+=thislen;
> > > +#endif
> > >       } else {
> > >  confused:
> > >               printk ("%s: cdrom_pc_intr: The drive "
> > 
> > Hmm confused, care to expand?
> 
> rq->sense_len++ is obviously bogus as user-land will only get the first
> byte of the sense data [so that you can tell apart deferred and
> immediate errors, but you can't tell what was actually wrong]. As for
> "if (rq->cmd[0] == GPCMD_REQUEST_SENSE)" vs. "if (rq->flags &
> REQ_SENSE)." User-land is permitted to issue REQUEST SENSE on it's own
> behalf, isn't it? With "rq->cmd[0] == GPCMD_REQUEST_SENSE" kernel will
> provide user-land with sense buffer with bogus data (even if it's
> zeros:-). "rq->flags & REQ_SENSE" implies "rq->cmd[0] ==
> GPCMD_REQUEST_SENSE" as it happens only when kernel itself pulls the
> sense data on behalf of failed command and that's exactly what should be
> returned to user. Or is it #if 0/#else/#endif which is confusing? Well,
> we don't have to keep that, it's just left-overs from my working copy...

Ah good point on the REQ_SENSE bit, completely agree. The if 0 thing
cannot go in obviously, I'll kill that along the way.

> > Sorry I misread that, ->data is the one we want. I'm wondering how this
> > got mixed up... So to clarify:
> > 
> >         char *ibuf = req->data;
> > 
> >         if (!blk_pc_request(req))
> >                 return;
> >         if (!ibuf)
> >                 return;
> 
> But req->data is assigned NULL every time bio_map_user succeeds! Just
> follow it in sg_io():
> 
> 	buffer=NULL; ...
> 	bio=bio_map_user(...);
> 	if (!bio) buffer=kmalloc(...);
> 	rq->data=buffer;

Hmm it looks pretty bogus actually, in most cases we have already
removed ->bio at this point.

> So that if(!req->data) is true most of the time [as bio_map_user
> succeeds most of the time]... As for req->buffer. Given that only first
> 4 bytes/32 bits are manipulated it's actually safe to dereference it
> directly, isn't it? A.

->buffer is not to be used in this context, so forget that. It's a relic
from when the pre-transform allocated extra data and we copied back and
freed in post-transform. That was killed, and I'm really wondering
whether we shouldn't just kill the post-transform completely too. For
reference, this is what is should look like...

===== drivers/ide/ide-cd.c 1.46 vs edited =====
--- 1.46/drivers/ide/ide-cd.c	Thu May  8 10:39:34 2003
+++ edited/drivers/ide/ide-cd.c	Wed May 28 19:02:10 2003
@@ -1609,12 +1609,19 @@
 
 static void post_transform_command(struct request *req)
 {
-	char *ibuf = req->buffer;
 	u8 *c = req->cmd;
+	char *ibuf;
 
 	if (!blk_pc_request(req))
 		return;
 
+	if (rq->data)
+		ibuf = rq->data;
+	else if (rq->bio)
+		ibuf = bio_data(rq->bio);
+	else
+		return;
+
 	/*
 	 * set ansi-revision and response data as atapi
 	 */
@@ -1664,8 +1671,8 @@
 		if (dma_error)
 			return DRIVER(drive)->error(drive, "dma error", stat);
 
+		post_transform_command(rq);
 		end_that_request_chunk(rq, 1, rq->data_len);
-		rq->data_len = 0;
 		goto end_request;
 	}
 
@@ -1687,6 +1694,7 @@
 	if ((stat & DRQ_STAT) == 0) {
 		if (rq->data_len)
 			printk("%s: %u residual after xfer\n", __FUNCTION__, rq->data_len);
+		post_transform_command(rq);
 		goto end_request;
 	}
 
@@ -1765,9 +1773,6 @@
 	return ide_started;
 
 end_request:
-	if (!rq->data_len)
-		post_transform_command(rq);
-
 	spin_lock_irqsave(&ide_lock, flags);
 	blkdev_dequeue_request(rq);
 	end_that_request_last(rq);

-- 
Jens Axboe

