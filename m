Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268078AbRGYU2O>; Wed, 25 Jul 2001 16:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268047AbRGYU2A>; Wed, 25 Jul 2001 16:28:00 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:14436 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268063AbRGYU1n>; Wed, 25 Jul 2001 16:27:43 -0400
Date: Wed, 25 Jul 2001 22:28:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Herbert Valerio Riedel <hvr@hvrlab.org>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: RFC: block/loop.c & crypto
Message-ID: <20010725222813.B32148@athlon.random>
In-Reply-To: <20010723170038.G822@athlon.random> <Pine.LNX.4.33.0107241125000.1351-100000@janus.txd.hvrlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107241125000.1351-100000@janus.txd.hvrlab.org>; from hvr@hvrlab.org on Tue, Jul 24, 2001 at 11:56:02AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, 2001 at 11:56:02AM +0200, Herbert Valerio Riedel wrote:
> 
> ...moving it back to the kernel list...
> 
> On Mon, 23 Jul 2001, Andrea Arcangeli wrote:
> > You don't read 1k. You only read 512bytes and you encrypt them using
> > the IV of such 512byte block.
> >
> > Then the next 512byte block will use again the same IV again. What's the
> > problem?
> ok, so I didn't understand you well in the first place :-)
> 
> you actually want only to change the IV calculation to be based on a
> hardcoded 1024 IV-blocksize, but don't change anything else in the loop.c
> module, right? (if not, ignore the following text... :-)

yes

> 
> if so, I really don't like it;
> 
> 1.) I really don't like to encode 2 512-blocks with the same IV, (I
> actually thought I could just switch to 1024-blocks and thus have it
> sensible again, but since you only change the IV calculation without
> changing the data-transfer granularity it won't work)

the only data transfer that you can be using right now is the one with
softblocksize 1k (or you would not been able to mount the fs), so I
don't change the IV granularity for those in use cryptoloops and that's
why 1k is automatically backwards compatible and it will(/should ;) work.

> 2.) It will break filesystems using set_blocksize(lo_dev, 512)... why?

If a filesystem uses set_blocksize(512) you couldn't create it, this is
why I'm saying 1k softblocksize should take care of the existing
cryptoloops.

> say, we had a transfer request from the buffer cache requesting starting
> at byte 0 (initial IV=0) of the block device for length of 2048 bytes,

the length will always be 512bytes because you said the softblocksize is
512.

> this would lead to
> 
>   transfer_filter (buf, bufsize=2048, IV=0);

bufsize will be 512.

> 
>    since the transfer_filter contains the logic to split the buffer into
>    chunks with the blocksize (e.g. 512 byte blocks) required*) for

but anyways  even if bufsize could be 2048 I think the logic for the IV
progression should be in the highlevel if something, not in the low
layer because:

>    encryption the loop may look like:
> 
>     int IV2 = IV << 1;
>     while (bufsize > 0) {
>       encdecfunc (buf, 512, IV2 >> 1);
>       IV2++;
>       buf += 512;
>     }

the real cost is encdecfunc not the while(bufsize >0) loop, so you can
also take a cleaner transfer API and have the knowledge of the
granularity of the IV only in one place without duplicating the
knowledge and the code of the logic in all the crypto plugins.

Andrea
