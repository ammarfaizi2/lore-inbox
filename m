Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264798AbTE1Q3a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 12:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264796AbTE1Q3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 12:29:30 -0400
Received: from fyserv1.fy.chalmers.se ([129.16.110.66]:17331 "EHLO
	fyserv1.fy.chalmers.se") by vger.kernel.org with ESMTP
	id S264795AbTE1Q30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 12:29:26 -0400
Message-ID: <3ED4E70D.1E62D435@fy.chalmers.se>
Date: Wed, 28 May 2003 18:42:53 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-70 ide-cd to guarantee fault-free CD/DVD burning experience?
References: <3ED4681A.738DA3C6@fy.chalmers.se> <20030528074839.GU845@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > As for scsi_ioctl.c in more general sense. It apparently doesn't comply
> > with SG HOWTO, in particular it mis-interprets time-out values.
> > Background information and patch is available at
> > http://fy.chalmers.se/~appro/linux/DVD+RW/scsi_ioctl-2.5.69.patch.
> > There're couple of other issues, usage of 'bytes' variable in access_ok

	bytes = (hdr.dxfer_len + 511) & ~511;
	... access_ok(VERIFY_READ, uaddr, bytes)...
                                          ^^^^^ Shouldn't this be
hdr.dxfer_len? At least that's what memcpy-ed to kalloc-ated buffer.

> > and DMA being off when bio_map_user fails,

While tracing problems down I've commented out call to bio_map_user. But
of course it could have failed for more legitimate reasons, couldn't it?
Reasons such as user buffer residing in non DMA-capable region(?) or
being misaligned. But in either case I noticed that DMA is never engaged
on that buffer allocated with kmalloc. The question is if it's
intentional? If answer is yes, then the case is dismissed. If not, then
it should be looked into. Now I don't know if it's apporpriate to
complement GPF_USER with GFP_DMA, but it might be appropriate to retry
bio_map_user on buffer. I'm actually stepping out of my competence
domains here...

> > @@ -1471,8 +1472,13 @@
> >               /* Keep count of how much data we've moved. */
> >               rq->data += thislen;
> >               rq->data_len -= thislen;
> > +#if 0
> >               if (rq->cmd[0] == GPCMD_REQUEST_SENSE)
> >                       rq->sense_len++;
> > +#else
> > +             if (rq->flags & REQ_SENSE)
> > +                     rq->sense_len+=thislen;
> > +#endif
> >       } else {
> >  confused:
> >               printk ("%s: cdrom_pc_intr: The drive "
> 
> Hmm confused, care to expand?

rq->sense_len++ is obviously bogus as user-land will only get the first
byte of the sense data [so that you can tell apart deferred and
immediate errors, but you can't tell what was actually wrong]. As for
"if (rq->cmd[0] == GPCMD_REQUEST_SENSE)" vs. "if (rq->flags &
REQ_SENSE)." User-land is permitted to issue REQUEST SENSE on it's own
behalf, isn't it? With "rq->cmd[0] == GPCMD_REQUEST_SENSE" kernel will
provide user-land with sense buffer with bogus data (even if it's
zeros:-). "rq->flags & REQ_SENSE" implies "rq->cmd[0] ==
GPCMD_REQUEST_SENSE" as it happens only when kernel itself pulls the
sense data on behalf of failed command and that's exactly what should be
returned to user. Or is it #if 0/#else/#endif which is confusing? Well,
we don't have to keep that, it's just left-overs from my working copy...

> Sorry I misread that, ->data is the one we want. I'm wondering how this
> got mixed up... So to clarify:
> 
>         char *ibuf = req->data;
> 
>         if (!blk_pc_request(req))
>                 return;
>         if (!ibuf)
>                 return;

But req->data is assigned NULL every time bio_map_user succeeds! Just
follow it in sg_io():

	buffer=NULL; ...
	bio=bio_map_user(...);
	if (!bio) buffer=kmalloc(...);
	rq->data=buffer;

So that if(!req->data) is true most of the time [as bio_map_user
succeeds most of the time]... As for req->buffer. Given that only first
4 bytes/32 bits are manipulated it's actually safe to dereference it
directly, isn't it? A.
