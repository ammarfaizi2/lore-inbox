Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268852AbRHBIYF>; Thu, 2 Aug 2001 04:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268853AbRHBIXz>; Thu, 2 Aug 2001 04:23:55 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31808 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268852AbRHBIXp>; Thu, 2 Aug 2001 04:23:45 -0400
Date: Thu, 2 Aug 2001 10:24:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeremy Higdon <jeremy@classic.engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: changes to kiobuf support in 2.4.(?)4
Message-ID: <20010802102431.L29065@athlon.random>
In-Reply-To: <10108012254.ZM192062@classic.engr.sgi.com> <20010802084259.H29065@athlon.random> <andrea@suse.de> <10108020031.ZM229058@classic.engr.sgi.com> <20010802094517.I29065@athlon.random> <andrea@suse.de> <10108020110.ZM232959@classic.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10108020110.ZM232959@classic.engr.sgi.com>; from jeremy@classic.engr.sgi.com on Thu, Aug 02, 2001 at 01:10:44AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 01:10:44AM -0700, Jeremy Higdon wrote:
> The first is that I don't need the bh's or block's in my implementation.

So the very latest layer of the scsi driver understand the kiobufs
natively for you right? (I assume you ported this functionality only to
a few scsi drivers, right?)

> Everything I need is in the old-style kiobuf or is passed as an argument.

Ok.

> The second is I don't see a file->f_iobuf pointer in my source tree, which
> is 2.4.8-pre3, I believe.  In fact, the kiobuf pointer is stored in the

It's in the O_DIRECT patch.

> raw_devices array in my version of raw.c, and there is only one per raw
> device.

This is why I said also rawio should start using the f_iobuf to have one
kiobuf per-file like with O_DIRECT, infact if you open("/dev/hda",
O_DIRECT) instead of using the rawio API you will just get the kiobuf
per file.

> Assuming I'm out of date, and there is some way to store a kiobuf pointer
> into the file data structure, and I'll never see two requests outstanding
> at the same time to the same file, then I could do as you suggest.  I'd

There's the possibility of two requests outstanding on the same file
still if you share the same file with multiple filedescriptors but I
don't think that's an interesting case to optimize, however I still need
a test_and_set_bit and a slow path allocation of the kiovec to handle
the multiple fd pointing to the same filp case correctly (but I think
that's ok).

> be wasting about 16KB per open file (assuming 512KB and 64 bit) and adding
> unneeded CPU overhead at open time, but I could live with that.

If you don't need the bh and blocks part of the kiobuf and we split it
off (which I would be fine to change if the lowlevel driver would
understand the kiobuf as an I/O entity, that again I'm not saying it's a
good thing or not here) you should still be faster by avoiding
allocating the kiobuf in the fast path and you won't have the 16KB
overhead per open device once/if the kiobuf will shrink in size (so it
should still better than allocating a smaller kiobuf in a fast path).

What do you think?

Andrea
