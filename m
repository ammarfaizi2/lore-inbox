Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbUABA3Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbUABA3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:29:16 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:51383 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261973AbUABA3D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:29:03 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Christophe Saout <christophe@saout.de>
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Date: Fri, 2 Jan 2004 01:27:50 +1400
User-Agent: KMail/1.5
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1072977507.4170.14.camel@leto.cs.pocnet.net>
In-Reply-To: <1072977507.4170.14.camel@leto.cs.pocnet.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401020127.50558.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 January 2004 07:18, Christophe Saout wrote:
> Hi!

Hi,

> I was just investigating where bio->bi_idx gets modified in the kernel.
>
> I found these lines in ide-disk.c in ide_multwrite (DMA off, TASKFILE_IO
>
> off):
> > if (++bio->bi_idx >= bio->bi_vcnt) {
> >     bio->bi_idx = 0;
> >     bio = bio->bi_next;
> > }
>
> (rq->bio also gets changed but it's protected by the scratch buffer)
>
> I think changing the bi_idx here is dangerous because
> end_that_request_first needs this value to be unchanged because it
> tracks the progress of the bio processing and updates bi_idx itself.

This is not a problem here because ide_multwrite() walks rq->bio chain itself.
It also updates current_nr_sectors and hard_cur_sectors fields of drive->wrq.

> And bio->bi_idx = 0 is probably wrong because the bio can be submitted
> with bio->bi_idx > 0 (if the bio was splitted and there are clones that
> share the bio_vec array, like raid or device-mapper code).
>
> If it really needs to play with bi_idx itself care should be taken to
> reset bi_idx to the original value, not to zero.

RAID or device-mapper code doesn't seem to care about bio->bi_idx
value after bio has been submitted to the block layer, so the current
code is safe enough.  Also there is no place to store original bi_idx.

> I wasn't able to trigger a problem though, I don't know why exactly,
> perhaps there are paths in __end_that_request_first that are not
> interested in bi_dx. I still think there is something wrong with it.

After finishing data transfer multwrite_intr() calls ide_end_request()
with rq->nr_sectors argument (where rq is hwgroup->rq not drive->wrq),
so only whole bios are completed.  There are no partial completions
and code depending on bio->bi_idx inside __end_that_request_first()
is not executed.

The real (generic) problem is that atomic block segment for a block device
(in this case ATA disk) can be composed of bvecs, bios or bios+bvecs and
driver can obtain information about next bvec from block layer (from rq->bio)
only after previous bvec has been acknowledgment by end_that_request_first().
In situation when information about previously processed bios/bvecs is needed
(ie. error condition) this information is already lost.

There are 2 solutions for this problem:

- Use separate bio lists (rq->cbio) and temporary data
  (rq->nr_cbio_segments and rq->nr_cbio_sectors) for submission/completion.
  Please look at process_that_request_first() and its usage in TASKFILE code.

  You are then required to do partial bio completion.

- Do not use struct request fields directly and store information needed by
  driver in separate data structures
  (ie. scatter-gather data stored by SCSI layer).

  You are then not allowed (and shouldn't need) to do partial bio completions.

IDE multi-sector code uses first method because second one was too
invasive/risky to be done (required serious rewrite of IDE transport code).

I hope generic block transport layer in 2.7.x will make life simpler.

--bart

