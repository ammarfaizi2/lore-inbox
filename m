Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLBAw6>; Fri, 1 Dec 2000 19:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQLBAws>; Fri, 1 Dec 2000 19:52:48 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:47374 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129314AbQLBAwf>; Fri, 1 Dec 2000 19:52:35 -0500
Message-ID: <3A2840AB.EE085CAA@thebarn.com>
Date: Fri, 01 Dec 2000 18:22:03 -0600
From: Russell Cattelan <cattelan@thebarn.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-whipme11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: kumon@flab.fujitsu.co.jp, linux-kernel@vger.kernel.org,
        Dave Jones <davej@suse.de>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] livelock in elevator scheduling
In-Reply-To: <200011210838.RAA27382@asami.proc.flab.fujitsu.co.jp> <20001121112836.B10007@suse.de> <200011211130.UAA27961@asami.proc.flab.fujitsu.co.jp> <20001121123608.F10007@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> On Tue, Nov 21 2000, kumon@flab.fujitsu.co.jp wrote:
> >  > Believe it or not, but this is intentional. In that regard, the
> >  > function name is a misnomer -- call it i/o scheduler instead :-)
> >
> > I never believe it intentional.  If it is true, the current kernel
> > will be suffered from a kind of DOS attack.  Yes, actually I'm a
> > victim of it.
>
> The problem is caused by the too high sequence numbers in stock
> kernel, as I said. Plus, the sequence decrementing doesn't take
> request/buffer size into account. So the starvation _is_ limited,
> the limit is just too high.
>
> > By Running ZD's ServerBench, not only the performance down, but my
> > machine blocks all commands execution including /bin/ps, /bin/ls... ,
> > and those are not ^C able unless the benchmark is stopped. Those
> > commands are read from disks but the requests are wating at the end of
> > I/O queue, those won't be executed.
>
> If performance is down, then that problem is most likely elsewhere.
> I/O limited benchmarking typically thrives on lots of request
> latency -- with that comes better throughput for individual threads.
>
> > Anyway, I'll try your patch.

Well this patch does help with the request starvation problem.
Unfortunately it has introduced another problem.
Running 4 doio programs, on and XFS partion with KIO buf IO turned on.

I did see something about problems with aic7xxx driver in test11, so this may

not be related to your patch.

I'm going to run without kiobuf  to see if the problem still occurs.


XFS (dev: 8/17) mounting with KIOBUFIO
Start mounting filesystem: sd(8,17)
Ending clean XFS mount for filesystem: sd(8,17)
NMI Watchdog detected LOCKUP on CPU1, registers:
CPU:    1
EIP:    0010:[<c0217a9f>]
EFLAGS: 00000082
eax: c01b21ac   ebx: c197b078   ecx: 00000000   edx: 00000012
esi: 00000286   edi: dfff7f70   ebp: dfff7f20   esp: dfff7f14
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=dfff7000)
Stack: c190fb20 04000001 00000020 dfff7f40 c010c539 00000012 c197b078
dfff7f70
       00000240 c0331a40 00000012 dfff7f68 c010c73d 00000012 dfff7f70
c190fb20
       c0108960 dfff6000 c0108960 c190fb20 00000001 dfff7fa4 c010a8c8
c0108960
Call Trace: [<c010c539>] [<c010c73d>] [<c0108960>] [<c0108960>] [<c010a8c8>]
[<c0108960>] [<c0108960>]
       [<c0100018>] [<c010898f>] [<c0108a02>] [<c010a9be>]
Code: f3 90 7e f5 e9 1b a7 f9 ff 80 3d e4 e4 2e c0 00 f3 90 7e f5

Entering kdb (current=0xdfff6000, pid 0) on processor 1 due to WatchDog
Interrupt @ 0xc0217a9f
eax = 0xc01b21ac ebx = 0xc197b078 ecx = 0x00000000 edx = 0x00000012
esi = 0x00000286 edi = 0xdfff7f70 esp = 0xdfff7f14 eip = 0xc0217a9f
ebp = 0xdfff7f20 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00000082
xds = 0xc1970018 xes = 0xdfff0018 origeax = 0xc01b21ac &regs = 0xdfff7ee0
[1]kdb> bt
    EBP       EIP         Function(args)
           0x00000000c0217a9f stext_lock+0x43af
                               kernel .text.lock 0xc02136f0 0xc02136f0
0xc02197c0
0xdfff7f20 0x00000000c01b21c3 do_aic7xxx_isr+0x17 (0x12, 0xc197b078,
0xdfff7f70, 0x240, 0xc0331a40)
                               kernel .text 0xc0100000 0xc01b21ac 0xc01b225c
0xdfff7f40 0x00000000c010c539 handle_IRQ_event+0x4d (0x12, 0xdfff7f70,
0xc190fb20, 0xc0108960, 0xdfff6000)
                               kernel .text 0xc0100000 0xc010c4ec 0xc010c568
0xdfff7f68 0x00000000c010c73d do_IRQ+0x99 (0xc0108960, 0x0, 0xdfff6000,
0xdfff6000, 0xc0108960)
                               kernel .text 0xc0100000 0xc010c6a4 0xc010c790
           0x00000000c010a8c8 ret_from_intr
                               kernel .text 0xc0100000 0xc010a8c8 0xc010a8e8
Interrupt registers:
eax = 0x00000000 ebx = 0xc0108960 ecx = 0x00000000 edx = 0xdfff6000
esi = 0xdfff6000 edi = 0xc0108960 esp = 0xdfff7fa4 eip = 0xc010898f
ebp = 0xdfff7fa4 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00000246
xds = 0xc0100018 xes = 0xdfff0018 origeax = 0xffffff12 &regs = 0xdfff7f70
           0x00000000c010898f default_idle+0x2f
                               kernel .text 0xc0100000 0xc0108960 0xc0108998
0xdfff7fb8 0x00000000c0108a02 cpu_idle+0x42
                               kernel .text 0xc0100000 0xc01089c0 0xc0108a18
0xdfff7fc0 0x00000000c02fb5b9 start_secondary+0x25
                               kernel .text.init 0xc02f6000 0xc02fb594
0xc02fb5c0


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
