Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318912AbSHMCtg>; Mon, 12 Aug 2002 22:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318913AbSHMCtg>; Mon, 12 Aug 2002 22:49:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28939 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318912AbSHMCtf>;
	Mon, 12 Aug 2002 22:49:35 -0400
Message-ID: <3D587706.A0F2DC21@zip.com.au>
Date: Mon, 12 Aug 2002 20:03:34 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: lkml <linux-kernel@vger.kernel.org>, riel@conectiva.com.br
Subject: Re: [patch 1/21] random fixes
References: <3D56146B.C3CAB5E1@zip.com.au> <20020811142938.GA681@www.kroptech.com> <3D56A83E.ECF747C6@zip.com.au> <20020812002739.GA778@www.kroptech.com> <3D57406E.D39E9B89@zip.com.au> <20020813002603.GA20817@www.kroptech.com> <3D5857A4.FE358FA2@zip.com.au> <20020813022550.GA6810@www.kroptech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> 
> On Mon, Aug 12, 2002 at 05:49:40PM -0700, Andrew Morton wrote:
> > Adam Kropelin wrote:
> > >
> > > ...
> > > > You can make 2.5 use the 2.4 settings with
> > > >
> > > > cd /proc/sys/vm
> > > > echo 30 > dirty_background_ratio
> > > > echo 60 > dirty_async_ratio
> > > > echo 70 > dirty_sync_ratio
> > >
> > > These settings bring -akpm in line with stock 2.5.31, but they are both
> > > still slower than 2.4.19 (which itself could do better, I think).
> >
> > In that case I'm confounded.  It worked sweetly for me.  Just
> 
> > Which ftp client are you using?  And can you strace it, to see how
> > much data it's writing per system call?
> 
> Actually, I'm running an FTP server on the testbed machine and pushing the
> data from a client on another (much faster) machine. I straced the server
> (redhat wu-ftpd2.6.1-20) and it looks like 8 KB reads/writes.
> 

OK, tried that against a slow disk (13 megs/sec write bandwidth).  2.5.31,
defalt writeback settings.

ext3 is misbehaving:

 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  2  2   5104   4376      0 134016   0   0     0 21620 2888  1966   0   5  95
 0  0  2   5104   4448      0 134224   0   0     0 11420 4787  4004   0   8  92
 1  0  0   5104   4464      0 134776   0   0     0   100 13133 12564   1  24  75
 1  0  0   5104   4440      0 134716   0   0     8     0 13281 12660   1  23  76
 0  0  0   5104   4480      0 134448   0   0    56     0 13272 13022   1  22  77
 0  1  2   5104   4592      0 133880   0   0     0 27200 2598  1596   0   5  95
 0  1  2   5104   4588      0 133880   0   0     0 11544 1127   128   0   2  98
 0  0  1   5104   4356      0 134388   0   0     0   692 10383  9839   0  21  79
 1  0  0   5104   4368      0 134836   0   0     0   108 13115 12912   1  25  74
 0  0  0   5104   4360      0 134556   0   0    36    68 11829 11687   1  20  79

and takes 86 seconds.

When the server is writing to ext2, it is good:

 1  0  0   5104   4364      0 135248   0   0    56 12380 13316 16547   1  17  82
 0  0  0   5104   4388      0 135296   0   0     0 12324 13310 16488   1  16  83
 1  0  0   5104   4056      0 135600   0   0     0 12344 13300 16521   1  15  84
 0  0  0   5104   4368      0 135264   0   0     0 12324 13293 16480   0  16  84
 1  0  0   5104   4428      0 135184   0   0     0  8216 13306 16514   1  16  83
 0  0  0   5104   4396      0 135172   0   0    48 12380 13296 16444   1  16  83
 0  0  0   5104   4392      0 135148   0   0    56 12324 13304 16461   1  16  82
 1  0  0   5104   4396      0 135196   0   0     0 12324 13297 16468   1  17  82
 1  0  0   5104   4444      0 135116   0   0     0 12348 13304 16511   1  18  81

and the transfer takes 54 seconds, which is wirespeed.

The ext3 stall is going to require some thought - it's waiting on a previous
transaction commit so it can get in and modify an inode block again.

Are you _sure_ it was bad with ext2?    How long does

	dd if=/dev/zero of=foo bs=1M count=600 ; sync

take against that disk?
