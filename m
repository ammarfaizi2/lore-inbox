Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317371AbSHMFSS>; Tue, 13 Aug 2002 01:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317378AbSHMFSS>; Tue, 13 Aug 2002 01:18:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19470 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317371AbSHMFSQ>;
	Tue, 13 Aug 2002 01:18:16 -0400
Message-ID: <3D5899DB.B087E40D@zip.com.au>
Date: Mon, 12 Aug 2002 22:32:11 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: lkml <linux-kernel@vger.kernel.org>, riel@conectiva.com.br
Subject: Re: [patch 1/21] random fixes
References: <3D56146B.C3CAB5E1@zip.com.au> <20020811142938.GA681@www.kroptech.com> <3D56A83E.ECF747C6@zip.com.au> <20020812002739.GA778@www.kroptech.com> <3D57406E.D39E9B89@zip.com.au> <20020813002603.GA20817@www.kroptech.com> <3D5857A4.FE358FA2@zip.com.au> <20020813022550.GA6810@www.kroptech.com> <3D587706.A0F2DC21@zip.com.au> <20020813041011.GA12227@www.kroptech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> 
> On Mon, Aug 12, 2002 at 08:03:34PM -0700, Andrew Morton wrote:
> > Adam Kropelin wrote:
> > > Actually, I'm running an FTP server on the testbed machine and pushing the
> > > data from a client on another (much faster) machine. I straced the server
> > > (redhat wu-ftpd2.6.1-20) and it looks like 8 KB reads/writes.
> > >
> >
> > OK, tried that against a slow disk (13 megs/sec write bandwidth).  2.5.31,
> > defalt writeback settings.
> >
> > ext3 is misbehaving:
> > and takes 86 seconds.
> >
> > When the server is writing to ext2, it is good:
> > and the transfer takes 54 seconds, which is wirespeed.
> >
> > Are you _sure_ it was bad with ext2?
> 
> Yes.
> 
> [root@devbox adk0212] mount
> /dev/hda3 on / type ext2 (rw)
> none on /proc type proc (rw)
> /dev/hda1 on /boot type ext2 (rw)
> none on /dev/pts type devpts (rw,gid=5,mode=620)
> none on /dev/shm type tmpfs (rw)
> 
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  0  1  1    120   4360      0 141132   0   0     0  9804 6775   564   0  45  55
>  0  1  1    120   4344      0 141132   0   0     0     0 1083    20   0   0  99
>  0  0  0    120   4364      0 141116   0   0     0    40 2098   156   0  11  89
>  0  0  0    120   4384      0 141368   0   0     0     4 7013   594   0  52  47
>  0  0  0    120   4360      0 141416   0   0     0     0 6914   589   1  56  43
>  0  1  1    120   4464      0 140856   0   0     0 15420 6235   520   0  42  58
>  0  1  1    120   4456      0 140856   0   0     0  3240 1094    36   0   2  98
>  1  0  0    120   4428      0 140844   0   0     0    52 1151    70   0   4  96
>  1  0  0    120   4440      0 141356   0   0     0     4 6810   541   1  42  57
>  0  0  0    120   4464      0 141320   0   0     0     0 6894   553   1  40  58
>  0  1  1    120   4396      0 140840   0   0     0 15508 6018   466   0  40  59
>  0  1  1    120   4388      0 140840   0   0     0  1608 1093    57   0   2  98
>  0  0  0    120   4404      0 140832   0   0     0    52 2350   165   0  12  87
>  0  0  0    120   4460      0 141380   0   0     0     4 7040   564   1  42  57
>  1  0  0    120   4356      0 141372   0   0     0     4 7073   570   1  45  54
> ...

Sure looks like ext3.

> 
> Is it possible that the darn thing is mounted ext3 even though fstab and mount
> agree that it's ext2?

Yes.  Although it's usually the other way round. "How come it keeps running
fsck even though mount says ext3?".

Take a look in /proc/mounts.

> > How long does
> >
> >       dd if=/dev/zero of=foo bs=1M count=600 ; sync
> >
> > take against that disk?
> 
> 1m 23s  (I said it was a slow disk ;)

gack.  I've seen pencils which can write faster than that.

So your wirespeed actually exceeds the disk speed.  That changes things.

The kernel *has* to stall the generator of dirty data.  We can make
the stalls shorter, and more frequent.  Go into drivers/block/ll_rw_blk.c
and see where it's initialising batch_requests.  Just change it to

	batch_requests = 1;

batch_requests needs to die anyhow...

And in fs/mpage.c, set RATELIMIT_PAGES to 16.

The application has to block, but the disk should certainly never
fall idle.  I'll play with this a bit.  IDE ceased to be an option
in 2.5.30, which does not aid this effort.

> I've been trying these sorts of tests on this machine for over a year now,
> with various disk subsystems, and I have *never* seen anything as nice and
> consistent as the ext2 writeout you quoted. Maybe this machine is cursed.
> 

Lumpy writeback is pretty common.  As is bad latency during writeout.
It's quite tricky to get these things balanced out, and it's easy to
fix one thing and break another.  Not a lot of effort has been put into
fine tuning 2.5 for smoothness and latency thus far.
