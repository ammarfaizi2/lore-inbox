Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318727AbSHLGQx>; Mon, 12 Aug 2002 02:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318728AbSHLGQx>; Mon, 12 Aug 2002 02:16:53 -0400
Received: from peace.netnation.com ([204.174.223.2]:17591 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S318727AbSHLGQw>; Mon, 12 Aug 2002 02:16:52 -0400
Date: Sun, 11 Aug 2002 23:20:39 -0700
From: Simon Kirby <sim@netnation.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
Message-ID: <20020812062039.GA29420@netnation.com>
References: <20020811031705.GA13878@netnation.com> <Pine.LNX.4.44.0208111121510.9930-100000@home.transmeta.com> <3D572B4C.90F4AF3C@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D572B4C.90F4AF3C@zip.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 08:28:12PM -0700, Andrew Morton wrote:

> So I'd appreciate it if Simon could invetigate a little further
> with the test app I posted.  Something is up, and it may not
> be just an NFS thing.  But note that nfs_readpage will go
> synchronous if rsize is less than PAGE_CACHE_SIZE, so it has
> to be set up right.

You're right -- my NFS page size is set to 2048.  I can't remember if I
did this because I was trying to work around huge read-ahead or because I
was trying to work around the bursts of high latency from my Terayon
cable modem (which idles at a slow line speed and "falls forward" to
higher speeds once it detects traffic, but with a delay, causing awful
latency at the expense of "better noise immunity").  Anyway, I will test
this tomorrow.  I recall that 1024 byte-sized blocks were too small
because the latency of the cable modem would cause it to not have high
enough throughput, so I settled with 2048.

I haven't been able to test your application over NFS yet, but I did get
a chance to test it with a floppy.  I was able to (on 2.4.19) reproduce a
case where even with just 5 KB/second reads, the read() would block every
so often (long strace attached).

I don't really trust my floppy device to read every sector successfully
on the first try, but at one point during this strace, I saw a point
where read() blocked and the floppy LED lit immediately, as if it had
done no preparation at all (it was not as if it was close and the motor
didn't spin up in time).

Some strace snippets:

[sroot@oof:/]# umount /a ; mount -t ext2 -o noatime,nodiratime /dev/fd0 /a
 && strace -o /tmp/strace.txt -r a/stream -i a/bigfile 5 1024

     0.209706 read(3, "\0\0\0\0\0"..., 1024) = 1024
     0.000242 nanosleep({0, 200000000}, {3221223736, 1073818412}) = 0
     0.209861 read(3, "\0\0\0\0\0"..., 1024) = 1024
     0.000318 nanosleep({0, 200000000}, {3221223736, 1073818412}) = 0
     0.209665 read(3, "\0\0\0\0\0"..., 1024) = 1024
     0.538707 nanosleep({0, 200000000}, {3221223736, 1073818412}) = 0
     0.201309 read(3, "\0\0\0\0\0"..., 1024) = 1024
     0.000298 nanosleep({0, 200000000}, {3221223736, 1073818412}) = 0
     0.209675 read(3, "\0\0\0\0\0"..., 1024) = 1024
     0.000226 nanosleep({0, 200000000}, {3221223736, 1073818412}) = 0

     0.209711 read(3, "\0\0\0\0\0"..., 1024) = 1024
     0.000290 nanosleep({0, 200000000}, {3221223736, 1073818412}) = 0
     0.209757 read(3, "\0\0\0\0\0"..., 1024) = 1024
     0.000308 nanosleep({0, 200000000}, {3221223736, 1073818412}) = 0
     0.209863 read(3, "\0\0\0\0\0"..., 1024) = 1024
     2.680966 nanosleep({0, 200000000}, {3221223736, 1073818412}) = 0
     0.209039 read(3, "\0\0\0\0\0"..., 1024) = 1024
     0.000359 nanosleep({0, 200000000}, {3221223736, 1073818412}) = 0
     0.209648 read(3, "\0\0\0\0\0"..., 1024) = 1024
     0.000308 nanosleep({0, 200000000}, {3221223736, 1073818412}) = 0
     0.209711 read(3, "\0\0\0\0\0"..., 1024) = 1024

     0.209645 read(3, "\0\0\0\0\0"..., 1024) = 1024
     0.000307 nanosleep({0, 200000000}, {3221223736, 1073818412}) = 0
     0.209734 read(3, "\0\0\0\0\0"..., 1024) = 1024
     0.000301 nanosleep({0, 200000000}, {3221223736, 1073818412}) = 0
     0.209672 read(3, "\0\0\0\0\0"..., 1024) = 1024
     2.964750 nanosleep({0, 200000000}, {3221223736, 1073818412}) = 0
     0.205464 read(3, "\0\0\0\0\0"..., 1024) = 1024
     0.000316 nanosleep({0, 200000000}, {3221223736, 1073818412}) = 0
     0.209628 read(3, "\0\0\0\0\0"..., 1024) = 1024
     0.000302 nanosleep({0, 200000000}, {3221223736, 1073818412}) = 0
     0.209792 read(3, "\0\0\0\0\0"..., 1024) = 1024

So, something does appear to be wrong.  If I can actually mount a
filesystem on a floppy in 2.5, I'll see if the same thing happens.

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]
