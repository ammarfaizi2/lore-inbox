Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267303AbRGXJ4K>; Tue, 24 Jul 2001 05:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267414AbRGXJ4A>; Tue, 24 Jul 2001 05:56:00 -0400
Received: from cm.med.3284844210.kabelnet.net ([195.202.190.178]:5136 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S267303AbRGXJzs>; Tue, 24 Jul 2001 05:55:48 -0400
Date: Tue, 24 Jul 2001 11:56:02 +0200 (CEST)
From: Herbert Valerio Riedel <hvr@hvrlab.org>
X-X-Sender: <hvr@janus.txd.hvrlab.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Subject: Re: RFC: block/loop.c & crypto
In-Reply-To: <20010723170038.G822@athlon.random>
Message-ID: <Pine.LNX.4.33.0107241125000.1351-100000@janus.txd.hvrlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


...moving it back to the kernel list...

On Mon, 23 Jul 2001, Andrea Arcangeli wrote:
> You don't read 1k. You only read 512bytes and you encrypt them using
> the IV of such 512byte block.
>
> Then the next 512byte block will use again the same IV again. What's the
> problem?
ok, so I didn't understand you well in the first place :-)

you actually want only to change the IV calculation to be based on a
hardcoded 1024 IV-blocksize, but don't change anything else in the loop.c
module, right? (if not, ignore the following text... :-)

if so, I really don't like it;

1.) I really don't like to encode 2 512-blocks with the same IV, (I
actually thought I could just switch to 1024-blocks and thus have it
sensible again, but since you only change the IV calculation without
changing the data-transfer granularity it won't work)

2.) It will break filesystems using set_blocksize(lo_dev, 512)... why?

say, we had a transfer request from the buffer cache requesting starting
at byte 0 (initial IV=0) of the block device for length of 2048 bytes,
this would lead to

  transfer_filter (buf, bufsize=2048, IV=0);

   since the transfer_filter contains the logic to split the buffer into
   chunks with the blocksize (e.g. 512 byte blocks) required*) for
   encryption the loop may look like:

    int IV2 = IV << 1;
    while (bufsize > 0) {
      encdecfunc (buf, 512, IV2 >> 1);
      IV2++;
      buf += 512;
    }

  which leads to the following calls for the mentioned example:

  encdecfunc (buf, 512, 0);
  encdecfunc (buf+512, 512, 0);
  encdecfunc (buf+1024, 512, 1);
  encdecfunc (buf+1536, 512, 1);

  so far so good; but now imagine that the original request get's changed
  a bit, to start at offset 512 (initial IV still 0!!) instead of offset 0;

   transfer_filter (buf, bufsize=2048, IV=0); // the same values are
                                              // passed for bufsize and IV!

  encdecfunc (buf, 512, IV=0);       // OK
  encdecfunc (buf+512, 512, IV=0);   // wrong, IV should be 1
  encdecfunc (buf+1024, 512, IV=1);  // OK
  encdecfunc (buf+1536, 512, IV=1);  // wrong, IV should be 2

  ...so you see?

  that's why it's better IMHO to stick to the same IV-granularity that is
  used for transfers, otherwise you'd have to lose performance by
  passing only single IV-blocksize length data-blocks to the filter
  functions which need to be aligned...

  *) actually only filters making use of the IV parameter would need to
     split it up, other function may process bigger blocks at once, and
     thus minimizing possible overhead...

>> and btw, at least one other popular crypto loop filter uses 512 byte
>> based IVs, namely loop-AES...
> I guess it emulates it internally, so it should keep working if we do
> the fixed 1k granularity for the IV (while it should break the on-disk
> format if we do the 512byte granularity).

no, you can't emulate it internally if the passed IV is calculated based
on a bigger IV-blocksize than the needed one... that's the problem, and why
it's IMHO better to calculate based on the smallest used IV-blocksize :-(
(that way you can always convert it to a bigger IV-blocksize based one)

regards,
-- 
Herbert Valerio Riedel       /    Phone: (EUROPE) +43-1-58801-18840
Email: hvr@hvrlab.org       /    Finger hvr@gnu.org for GnuPG Public Key
GnuPG Key Fingerprint: 7BB9 2D6C D485 CE64 4748  5F65 4981 E064 883F 4142

