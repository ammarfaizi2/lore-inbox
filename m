Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbUABDU4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 22:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbUABDU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 22:20:56 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:35262 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S263290AbUABDUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 22:20:45 -0500
Subject: Re: Possibly wrong BIO usage in ide_multwrite
From: Christophe Saout <christophe@saout.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200401020127.50558.bzolnier@elka.pw.edu.pl>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net>
	 <200401020127.50558.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1073013643.20163.51.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 02 Jan 2004 04:20:44 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr, den 02.01.2004 schrieb Bartlomiej Zolnierkiewicz um 02:27:

> > I was just investigating where bio->bi_idx gets modified in the kernel.
> >
> > I found these lines in ide-disk.c in ide_multwrite (DMA off, TASKFILE_IO
> >
> > off):
> > > if (++bio->bi_idx >= bio->bi_vcnt) {
> > >     bio->bi_idx = 0;
> > >     bio = bio->bi_next;
> > > }
> >
> > (rq->bio also gets changed but it's protected by the scratch buffer)
> >
> > I think changing the bi_idx here is dangerous because
> > end_that_request_first needs this value to be unchanged because it
> > tracks the progress of the bio processing and updates bi_idx itself.
> 
> This is not a problem here because ide_multwrite() walks rq->bio chain itself.
> It also updates current_nr_sectors and hard_cur_sectors fields of drive->wrq.

Yes, I've seen this. That looks okay.

> > And bio->bi_idx = 0 is probably wrong because the bio can be submitted
> > with bio->bi_idx > 0 (if the bio was splitted and there are clones that
> > share the bio_vec array, like raid or device-mapper code).
> >
> > If it really needs to play with bi_idx itself care should be taken to
> > reset bi_idx to the original value, not to zero.
> 
> RAID or device-mapper code doesn't seem to care about bio->bi_idx
> value after bio has been submitted to the block layer, so the current
> code is safe enough. 

Yes, that's right. But I'd like to. I see that the code works this way,
but still it's somewhat incorrect and I'll run into trouble if I want to
do a certain thing. Well, you could simply say "then don't do it", but
hey. ;)

I'm working on a dm encryption target. So I need to allocate and manager
buffers. Under memory pressure (or if dm decided before thta) it can
happen that a bio is split up. But then to avoid deadlocks due to memory
shortage I need to free my buffers up as soon as possible. If a bio
returns (it doesn't even need to be a partial completion) I need to know
which pages I can free.

The way I would prefer is that when someone calls bio_endio the bi_idx
and bv_offset just point where the processed data begins.

Most drivers complete a bio at once and leave bi_idx where it was.
That's fine. With a very small modification end_that_request_first can
also follow the rule that I just outlined.

I implemented the buffer free mechanism this way and it works fine. I
added a lot of debug to make sure all pages get freed correctly and
funny enough everything works fine, I'm not even able to trigger
problems where I expect them. But I still don't trust this.

>  Also there is no place to store original bi_idx.

That seems to be the key problem, sometimes. The other thing I could do
is to use bi_vcnt and bi_size and then go backwards through the bvecs to
find the pages and ignore the whole bi_idx issue. But this is ugly.

> After finishing data transfer multwrite_intr() calls ide_end_request()
> with rq->nr_sectors argument (where rq is hwgroup->rq not drive->wrq),
> so only whole bios are completed.  There are no partial completions
> and code depending on bio->bi_idx inside __end_that_request_first()
> is not executed.

Yes, I suspected this. This part hardly seems to be ever used.

> The real (generic) problem is that atomic block segment for a block device
> (in this case ATA disk) can be composed of bvecs, bios or bios+bvecs and
> driver can obtain information about next bvec from block layer (from rq->bio)
> only after previous bvec has been acknowledgment by end_that_request_first().

Does it? end_that_request_first can deal with nr_bytes that span bvecs
and even bios. The only thing the driver has to do then is to walk the
bvecs and bios itself, what it is already doing, but it should do this
without modifying the indexes. Since it is working on a copy of the
request, the bio pointer doesn't move. But the bvec index does. It is
set to zero after a bio is finished, which is where it most probably was
at the beginning, but might not be.

I know, end_that_request_first doesn't care in this case, and it can't
be called for every bvec because the transfer only ends after the drive
acknowledged it (everything else would be wrong), but still.

Can't another (some local) variable be used as bvec index instead of
bi_idx in the original bio? (except from ide_map_buffer using exactly
this index...)

Still, I see, mcount could go to zero before the bio is finished and we
would need to store the bvec index somewhere, I see the problem.

What about doing a partial bio completion in multwrite_intr? If there is
data left you know you've finished multcount sectors, right?

> In situation when information about previously processed bios/bvecs is needed
> (ie. error condition) this information is already lost.

Sure.

> There are 2 solutions for this problem:
> 
> - Use separate bio lists (rq->cbio) and temporary data
>   (rq->nr_cbio_segments and rq->nr_cbio_sectors) for submission/completion.

That would be somewhat similar to what I just proposed, right?

Would you be interested in a small patch (well, if I can come up with
one)?

>   Please look at process_that_request_first() and its usage in TASKFILE code.

I'll do. I already noticed that it used the other fields and obviously
doesn't use bi_idx the same way.

>   You are then required to do partial bio completion.

Yes.

> - Do not use struct request fields directly and store information needed by
>   driver in separate data structures
>   (ie. scatter-gather data stored by SCSI layer).
> 
>   You are then not allowed (and shouldn't need) to do partial bio completions.
> 
> IDE multi-sector code uses first method because second one was too
> invasive/risky to be done (required serious rewrite of IDE transport code).

I can understand that. The IDE layer seems to somewhat somewhat be a
victim of adding new features and adapting it to new layers.

> I hope generic block transport layer in 2.7.x will make life simpler.

Well, I hope so. And I hope the ide devices don't end up being treated
as scsi devices. ;)


