Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268831AbRHBGmw>; Thu, 2 Aug 2001 02:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268821AbRHBGme>; Thu, 2 Aug 2001 02:42:34 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:33842 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268819AbRHBGmb>; Thu, 2 Aug 2001 02:42:31 -0400
Date: Thu, 2 Aug 2001 08:43:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeremy Higdon <jeremy@classic.engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: changes to kiobuf support in 2.4.(?)4
Message-ID: <20010802084259.H29065@athlon.random>
In-Reply-To: <10108012254.ZM192062@classic.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10108012254.ZM192062@classic.engr.sgi.com>; from jeremy@classic.engr.sgi.com on Wed, Aug 01, 2001 at 10:55:00PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2001 at 10:55:00PM -0700, Jeremy Higdon wrote:
> I'm curious about the changes made to kiobuf support, apparently in
> order to improve raw I/O performance.  I was reading through some old
> posts circa early April, where I saw reference to a rawio-bench program.
> Can someone explain what it does?
> 
> I have a driver that uses kiobufs to perform I/O.  Prior to these
> changes, the kiobuf allocation and manipulation was very quick and
> efficient.  It is now very slow.
> 
> The kiobuf part of the I/O request is as follows:
> 
> 	alloc_kiovec()
> 	map_user_kiobuf()
> 	... do I/O, using kiobuf to store mappings ...
> 	kiobuf_wait_for_io()
> 	free_kiovec()
> 
> Now that the kiobuf is several KB in size, and 1024 buffer heads
> are allocated, the alloc_kiovec part goes from a percent or so of
> CPU usage to do 13000 requests per second to around 90% CPU usage
> to do 3000 per second.
> 
> It looks as though the raw driver allocates one kiobuf at open time
> (rather than on a per-request basis), but if two or more requests
> are issued to a single raw device, it too devolves into the allocate
> on every request strategy.
> 
> Before I go further, I'd appreciate if someone could confirm my
> hypotheses and also explain rawio-bench (and maybe point me to some
> source, if available).

That's all right, no one kiobuf should be allocated in any fast path, if
you follow this rule there's no problem.

The kiobuf in 2.4 is mostly used for rawio which can allocate the kiobuf
at open time. With the O_DIRECT patch I added one kiobuf per each filp
(of course allocated only when you open the file with O_DIRECT), the
rawio should simply switch to use the per-file kiobuf so you can open
the raw device multiple times without overhead of allocating the kiobuf
during simultaneous read/writes (if anybody wants to implement this
improvement on top of O_DIRECT please let me know so we don't duplicate
efforts).

The reason of the large allocation and to put the bh inside the kiobuf
is that if we do a small allocation then we end with a zillion of
allocations of the bh and freeing of the bh at every I/O!! (not even at
every read/write syscall, much more frequently) The flood of allocation
and freeing of the 512byte large bh at every I/O was just an obvious
huge amount of
wasted cpu time and that's why allocating them statically in the kiobuf
makes thing much faster (and also it avoids to run out of memory during
I/O making the rawio reliable), but of course now it's proibitive to
allocate any kiobuf in any fast path (even more since I switched to
vmalloc/vfree to allocate the kiobuf since as said above in 2.4 nobody
should ever allocate a kiobuf in any fast path anyways because of its
size). If you want to make kiobuf a remotely light thing you should
make the kiobuf become the I/O entity instead of the bh (which I'm not
saying it's a good thing here). If you don't make the kiobuf the I/O
entity understood at the very low level from the device drivers, then
you'd better keep having the bh in the kiobuf.

OTOH I'm a little biased in the above reasoning since I use the kiobuf
only for doing direct I/O (I always end calling brw_kiovec somehow,
otherwise I wouldn't be using the kiobufs at all). If you are using the
kiobufs for framebuffers and other drivers that never ends calling
brw_kiovec I think you should be using the mmap callback and
remap_page_range instead as most drivers correctly do to avoid the
overhead of the kiobufs. But ok if you really want to use the kiobuf for
non I/O things instead of remap_page_range (dunno why) we could split
off the bh-array allocation from the kiobuf to make it a bit lighter so
you could use it for non-IO operations without the overhead of the bhs,
but still we should adapt rawio to preallocate the bh at open/close time
(separately from the kiovec).

Andrea
