Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318930AbSHMEG0>; Tue, 13 Aug 2002 00:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318931AbSHMEGZ>; Tue, 13 Aug 2002 00:06:25 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:37871 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S318930AbSHMEGY>;
	Tue, 13 Aug 2002 00:06:24 -0400
Date: Tue, 13 Aug 2002 00:10:11 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, riel@conectiva.com.br
Subject: Re: [patch 1/21] random fixes
Message-ID: <20020813041011.GA12227@www.kroptech.com>
References: <3D56146B.C3CAB5E1@zip.com.au> <20020811142938.GA681@www.kroptech.com> <3D56A83E.ECF747C6@zip.com.au> <20020812002739.GA778@www.kroptech.com> <3D57406E.D39E9B89@zip.com.au> <20020813002603.GA20817@www.kroptech.com> <3D5857A4.FE358FA2@zip.com.au> <20020813022550.GA6810@www.kroptech.com> <3D587706.A0F2DC21@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D587706.A0F2DC21@zip.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 08:03:34PM -0700, Andrew Morton wrote:
> Adam Kropelin wrote:
> > Actually, I'm running an FTP server on the testbed machine and pushing the
> > data from a client on another (much faster) machine. I straced the server
> > (redhat wu-ftpd2.6.1-20) and it looks like 8 KB reads/writes.
> > 
> 
> OK, tried that against a slow disk (13 megs/sec write bandwidth).  2.5.31,
> defalt writeback settings.
> 
> ext3 is misbehaving:
> and takes 86 seconds.
> 
> When the server is writing to ext2, it is good:
> and the transfer takes 54 seconds, which is wirespeed.
> 
> Are you _sure_ it was bad with ext2?

Yes.

[root@devbox adk0212] mount
/dev/hda3 on / type ext2 (rw)
none on /proc type proc (rw)
/dev/hda1 on /boot type ext2 (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /dev/shm type tmpfs (rw)

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  1  1    120   4360      0 141132   0   0     0  9804 6775   564   0  45  55
 0  1  1    120   4344      0 141132   0   0     0     0 1083    20   0   0  99
 0  0  0    120   4364      0 141116   0   0     0    40 2098   156   0  11  89
 0  0  0    120   4384      0 141368   0   0     0     4 7013   594   0  52  47
 0  0  0    120   4360      0 141416   0   0     0     0 6914   589   1  56  43
 0  1  1    120   4464      0 140856   0   0     0 15420 6235   520   0  42  58
 0  1  1    120   4456      0 140856   0   0     0  3240 1094    36   0   2  98
 1  0  0    120   4428      0 140844   0   0     0    52 1151    70   0   4  96
 1  0  0    120   4440      0 141356   0   0     0     4 6810   541   1  42  57
 0  0  0    120   4464      0 141320   0   0     0     0 6894   553   1  40  58
 0  1  1    120   4396      0 140840   0   0     0 15508 6018   466   0  40  59
 0  1  1    120   4388      0 140840   0   0     0  1608 1093    57   0   2  98
 0  0  0    120   4404      0 140832   0   0     0    52 2350   165   0  12  87
 0  0  0    120   4460      0 141380   0   0     0     4 7040   564   1  42  57
 1  0  0    120   4356      0 141372   0   0     0     4 7073   570   1  45  54
 0  1  1    120   4360      0 140916   0   0     0 15404 5541   437   1  36  63
 0  1  1    120   4356      0 140916   0   0     0  2832 1084    55   0   1  99
 0  0  0    120   4356      0 140904   0   0     0    48 1614   125   0   8  91
 0  0  1    120   4380      0 141412   0   0     0     4 6888   552   1  43  56
 1  0  0    120   4232      0 141476   0   0     4     0 6857   556   1  40  58
 0  1  1    120   4352      0 140988   0   0     0 13700 5148   449   0  35  65

Is it possible that the darn thing is mounted ext3 even though fstab and mount
agree that it's ext2?

> How long does
> 
> 	dd if=/dev/zero of=foo bs=1M count=600 ; sync
> 
> take against that disk?

1m 23s  (I said it was a slow disk ;)

Even during that, the writeout was inconsistent (but a lot better than during
the FTP transfer):

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  1  3   1784   2180      0 141072   0   0     0  5220 1070    19   0   6  93
 0  1  2   1784   2248      0 141020   0   0     0  8064 1066    23   0   8  92
 1  0  3   1784   2296      0 141008   0   0     0  8436 1132    36   0  12  87
 0  1  3   1784   2300      0 141004   0   0     0  6828 1072   164   0  24  75
 1  0  2   1784   2988      0 140336   0   0     0  4664 1071   144   0  21  79
 1  0  2   1784   2616      0 140700   0   0     0 12944 2688   102   0   5  95
 0  1  3   1784   2296      0 141036   0   0     0 10048 1076   125   1  21  78
 0  1  1   1784   3284      0 140048   0   0     4  5504 1064   143   0  19  80
 0  1  1   1784   3284      0 140048   0   0     0     0 1064    51   0   1  99
 0  1  1   1784   3284      0 140048   0   0     0     0 1058    23   0   1  99
 1  1  3   1812   2312      0 141236   0  28     0 22892 2495   131   0  10  90
 0  2  3   1812   3204      0 140340   0   0     4  7736 1065    81   0  25  75
 0  2  3   1812   3204      0 140340   0   0     0  3848 1062    52   0   9  90
 0  2  3   1812   3204      0 140340   0   0     0  7696 1059    50   0   2  98
 0  1  3   1812   3196      0 140336   0   0     4  3976 1061    58   0  20  80
 0  1  3   1812   3312      0 140208   0   0     0  7944 1065    25   0   4  96
 0  1  2   1812   3308      0 140208   0   0     0  3844 1065    32   0   1  99
 0  1  2   1812   3308      0 140208   0   0     0  2956 1056    43   0   3  97
 0  1  2   1812   3268      0 140248   0   0     4  5548 1059    64   0   5  94
 0  1  2   1812   3268      0 140252   0   0     0   236 1065    56   0   4  96
 0  1  2   1812   3268      0 140252   0   0     0     0 1058    42   0   1  99

(all of the above discussion was 2.5.31 stock with default writeout settings)

I've been trying these sorts of tests on this machine for over a year now,
with various disk subsystems, and I have *never* seen anything as nice and
consistent as the ext2 writeout you quoted. Maybe this machine is cursed.

--Adam

