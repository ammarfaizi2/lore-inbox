Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130376AbQLDX4i>; Mon, 4 Dec 2000 18:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130469AbQLDX42>; Mon, 4 Dec 2000 18:56:28 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:35107 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130376AbQLDX4P>; Mon, 4 Dec 2000 18:56:15 -0500
Message-ID: <3A2C27F5.EF36CADD@thebarn.com>
Date: Mon, 04 Dec 2000 17:25:41 -0600
From: Russell Cattelan <cattelan@thebarn.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-whipme11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: kumon@flab.fujitsu.co.jp, linux-kernel@vger.kernel.org,
        Dave Jones <davej@suse.de>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] livelock in elevator scheduling
In-Reply-To: <200011210838.RAA27382@asami.proc.flab.fujitsu.co.jp> <20001121112836.B10007@suse.de> <200011211130.UAA27961@asami.proc.flab.fujitsu.co.jp> <20001121123608.F10007@suse.de> <3A2840AB.EE085CAA@thebarn.com> <20001202164234.B31217@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> On Fri, Dec 01 2000, Russell Cattelan wrote:
> > > If performance is down, then that problem is most likely elsewhere.
> > > I/O limited benchmarking typically thrives on lots of request
> > > latency -- with that comes better throughput for individual threads.
> > >
> > > > Anyway, I'll try your patch.
> >
> > Well this patch does help with the request starvation problem.
> > Unfortunately it has introduced another problem.
> > Running 4 doio programs, on and XFS partion with KIO buf IO turned on.
>
> This looks like a generic aic7xxx problem, and not block related. Since
> you are doing such nice traces, what is the other CPU doing? CPU1
> seems to be stuck grabbing the io_request_lock (for reasons not entirely
> clear from reading the aic7xxx source...)
>

Sorry I haven't been able to get a decent backtrace of the other processor.

According to Keith Owens the maintainer of kdb there is a race condition in

kbd and the NMI loop detection stuff that resulting in not being able to
switch cpus.


I'll keep try to dig up some more info.

I'm also seeing various other panics in XFS (well pagebuf to be specific)
with this patch.
Nothing seems to be very consistent and this point.

Ok I did manage to switch processors.
Entering kdb (current=0xd7c0a000, pid 645) on processor 1 due to cpu switch

[1]kdb> bt
    EBP       EIP         Function(args)
           0x00000000c0216594 stext_lock+0x2ea4
                               kernel .text.lock 0xc02136f0 0xc02136f0
0xc02197c0
0xd7c0bf98 0x00000000c0155964 ext2_sync_file+0x2c (0xd8257560, 0xd7348220,
0x0, 0xd7c0a000)
                               kernel .text 0xc0100000 0xc0155938
0xc0155a40
0xd7c0bfbc 0x00000000c0136064 sys_fsync+0x54 (0x1, 0xbffff020, 0x0,
0xbffff048, 0x8051738)
                               kernel .text 0xc0100000 0xc0136010
0xc0136088
           0x00000000c010a807 system_call+0x33
                               kernel .text 0xc0100000 0xc010a7d4
0xc010a80c
[1]kdb>


>
> --
> * Jens Axboe <axboe@suse.de>
> * SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
