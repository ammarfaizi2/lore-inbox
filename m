Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSHLGap>; Mon, 12 Aug 2002 02:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317328AbSHLGap>; Mon, 12 Aug 2002 02:30:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37132 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316887AbSHLGao>;
	Mon, 12 Aug 2002 02:30:44 -0400
Message-ID: <3D57594B.C56A1932@zip.com.au>
Date: Sun, 11 Aug 2002 23:44:27 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Simon Kirby <sim@netnation.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
References: <20020811031705.GA13878@netnation.com> <Pine.LNX.4.44.0208111121510.9930-100000@home.transmeta.com> <3D572B4C.90F4AF3C@zip.com.au> <20020812062039.GA29420@netnation.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kirby wrote:
> 
> On Sun, Aug 11, 2002 at 08:28:12PM -0700, Andrew Morton wrote:
> 
> > So I'd appreciate it if Simon could invetigate a little further
> > with the test app I posted.  Something is up, and it may not
> > be just an NFS thing.  But note that nfs_readpage will go
> > synchronous if rsize is less than PAGE_CACHE_SIZE, so it has
> > to be set up right.
> 
> You're right -- my NFS page size is set to 2048.  I can't remember if I
> did this because I was trying to work around huge read-ahead or because I
> was trying to work around the bursts of high latency from my Terayon
> cable modem (which idles at a slow line speed and "falls forward" to
> higher speeds once it detects traffic, but with a delay, causing awful
> latency at the expense of "better noise immunity").  Anyway, I will test
> this tomorrow.  I recall that 1024 byte-sized blocks were too small
> because the latency of the cable modem would cause it to not have high
> enough throughput, so I settled with 2048.

OK, thanks.

> I haven't been able to test your application over NFS yet, but I did get
> a chance to test it with a floppy.  I was able to (on 2.4.19) reproduce a
> case where even with just 5 KB/second reads, the read() would block every
> so often (long strace attached).

Well with a 64k readahead chunk the kernel will only talk to the
floppy drive once per 13 seconds.  Surely it's spinning down?
Try setting the readahead to 16 kbytes (three seconds) with

	blockdev --setra 32 /dev/floppy
 
> 
> So, something does appear to be wrong.  If I can actually mount a
> filesystem on a floppy in 2.5, I'll see if the same thing happens.

Nope, floppy is bust.  But you can read directly from /dev/fd0h1440 OK.
