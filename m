Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267986AbRGVPD1>; Sun, 22 Jul 2001 11:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267987AbRGVPDS>; Sun, 22 Jul 2001 11:03:18 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:36896 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267986AbRGVPDF>; Sun, 22 Jul 2001 11:03:05 -0400
Date: Sun, 22 Jul 2001 17:03:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Herbert Valerio Riedel <hvr@hvrlab.org>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: RFC: block/loop.c & crypto
Message-ID: <20010722170313.B30813@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0107221201260.15777-200000@janus.txd.hvrlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107221201260.15777-200000@janus.txd.hvrlab.org>; from hvr@hvrlab.org on Sun, Jul 22, 2001 at 12:21:30PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, Jul 22, 2001 at 12:21:30PM +0200, Herbert Valerio Riedel wrote:
> hello!
> 
> ...some time has passed since I've contacted you last time about
> crypto/loop issues... but now it's time again to annoy you :-)
> 
>  btw; while I'm at it, a question which came to mind while writing this
>  mail; is it safe to call...
> 
>  if (current->need_resched) schedule();
> 
>  ...from within the transfer function? are there possible race conditions

yes we are. writes are a no brainer, reads are either handled by the
thread for blkdev backed I/O and from the pagecache for file backed I/O.

>  where another transfer request may come in for the same blocks, while
>  another one is still in progress?
> 
> some months ago, when I proposed to switch IV calculation completely to
> fixed a fixed 512 byte blocksize, I was reminded, that the international
> crypto patch was not the only one to make use of the IV calculatiion, and
> doing so would break other crypto packages around...
> 
> ...so I suggested that I'd try a more backward compatible approach, which
> would allow old packages to retain compatibility, and new packages aware
> of the new flag to set IV calculation to 512 byte blocks...
> well the result of this experiment can be seen in the attachment...
> 
> so... any comments?

-               int IV = index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
+               unsigned long IV = loop_get_iv(lo, (pos - lo->lo_offset) >> LO_IV_SECTOR_BITS);
+
                size = PAGE_CACHE_SIZE - offset;
		^^^^
it's more complicated than that.

If you want to change the IV every 512bytes you must as well reduce the
underlined size and recalculate the IV or it won't do what you are
expecting. Same fixup of the logic is needed for even the blkdev backed
I/O (you can't use the same IV for the whole b_size anymore)

I believe the main reason we are using the softblocksize of the device
instead of 512bytes is just because it made strightforward the above
issues. Of course performance will decrease somehow this way.
OTOH the advantage I can see in your change is that the cryptoloop won't
break across a change of the softblocksize if the crypto plugin is using
the IV (like mkfs -b 4096 writing with an IV at 1k and then ext2 reading
with an IV of 4k). Actually if we make this change I believe breaking
backwards compatibility and making it the default could be a good thing,
any crypto plugin depending on the current IV calculation is just
subject to be not completly functional. Furthmore if we make this change
to the IV cryptoloop API, I'm wondering if we really need to make the
default 512bytes and not 1k, if we make the fixed IV granularity 1k then
all current drivers should keep working fine because the mkfs always
defaults to 1k the first time (performance will be better too). Not sure
about the lack of security of having the double number of bits sharing
the same IV but I assume that wasn't the reason of the change.

Andrea
