Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272991AbRIIR3J>; Sun, 9 Sep 2001 13:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272990AbRIIR2v>; Sun, 9 Sep 2001 13:28:51 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:14656 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272989AbRIIR23>; Sun, 9 Sep 2001 13:28:29 -0400
Date: Sun, 9 Sep 2001 19:29:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010909192918.W11329@athlon.random>
In-Reply-To: <20010909164738.T11329@athlon.random> <Pine.LNX.4.33.0109090922330.14365-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109090922330.14365-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Sep 09, 2001 at 09:24:51AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 09:24:51AM -0700, Linus Torvalds wrote:
> 
> On Sun, 9 Sep 2001, Andrea Arcangeli wrote:
> >
> > > filesystems. The only case it doesn't like is the "rw-open of a device
> > > that is rw-mounted".
> >
> > it also doesn't work for ro-open of a device that is rw-mounted, hdparm
> > -t as said a million of times now.
> 
> It _does_ work for that case, and you just aren't reading my emails.
> 
> You only need to invalidate the device if the open was a read-write open.
> 
> It would be _stupid_ to force a writeback and device invalidate for
> read-only opens, now wouldn't it?

1) you add a special case just for that, and you argued for ages that you
   don't want special cases in the blkdev close path and I agree on that
   (infact I don't have special cases except where strictly needed to be
   safe)

> The fact that you cannot know the difference between a read-only and a
> read-write open is _entirely_ due to the fact that you leave the flush
> until the last close. If you do it at every close (like I have said for
> the last twohundred mails or so), you can trivially see if the open was a
> read-only or not.

If you read my previous email completly:

	you make this special case you would be safe on that side).  But also
								     ^^^^^^^^
	the user may do O_RDWR open and not modify the device, and still we must
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	not screwup a rw-mountd fs under it.
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

you would now know why even adding the O_RDONLY special case isn't
enough. I can rephrase it: the user is allowed to open(O_RDWR), to only
read(2) and not to write(2) and still expect not to corrupt the
underlying fs. We cannot check all the tools out there to verify they
are opeining all the device with O_RDONLY when they're not going to
write to it. So if some tool is opeining with O_RDWR and never using
write(2) we shouldn't corrupt the underlying rw-mounted fs in my
vocabulary. I considered all this details while writing the current
code.

Andrea
