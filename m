Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277804AbRJRQmW>; Thu, 18 Oct 2001 12:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277805AbRJRQmM>; Thu, 18 Oct 2001 12:42:12 -0400
Received: from peace.netnation.com ([204.174.223.2]:17669 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S277804AbRJRQlz>; Thu, 18 Oct 2001 12:41:55 -0400
Date: Thu, 18 Oct 2001 09:42:22 -0700
From: Simon Kirby <sim@netnation.com>
To: Andi Kleen <andi@firstfloor.org>, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org
Subject: Awfully slow /proc/net/tcp, netstat, in.identd in 2.4 (updated)
Message-ID: <20011018094222.A31919@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is definitely something really broken here.  One of our web servers
that was having the problem before has now decided to hit a load average
of 50 because identd is taking so long to parse /proc/net/tcp and give
back ident information.

stracing a process, I see:

open("/proc/net/tcp", O_RDONLY)         = 4
fstat(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40009000
read(4, "  sl  local_address rem_address "..., 4096) = 4096
read(4, "00000000 01:0000023B 00000000   "..., 4096) = 4096
read(4, "0374800 2 c9ae0a60 25 4 0 2 -1  "..., 4096) = 4096
read(4, "           \n  81: 0CDFAECC:0050"..., 4096) = 4096
read(4, "06 00000000:00000000 03:0000131F"..., 4096) = 4096
read(4, "0        0 0 2 e3a92800         "..., 4096) = 4096

...Switching to "strace -tt" on the same process which still hadn't
exited by the time I had typed "strace -tt", I see:

09:25:45.481608 read(4, "0                               "..., 4096) = 4096
09:25:46.843441 read(4, " \n 354: 17612840:0050 23925BC0:"..., 4096) = 4096
09:25:47.542388 read(4, "0:00000000 03:00000B6C 00000000 "..., 4096) = 4096
09:25:49.649454 read(4, " 10385399 2 c9ae0a60 96 4 7 2 -1"..., 4096) = 4096
09:25:51.743338 read(4, "", 4096)       = 0

Each 4k block is taking 2 seconds!  It's probably competing with other
processes, but still, this is crazy.

[sroot@pro:/root]# time wc -l /proc/net/tcp
    427 /proc/net/tcp
0.000u 0.650s 0:01.38 47.1%     0+0k 0+0io 69pf+0w

Also, other servers running exactly the same kernel on the exact same
hardware have _more_ entries in the table and are much faster:

[sroot@bridge:/root]# time wc -l /proc/net/tcp
    805 /proc/net/tcp
0.010u 0.100s 0:00.10 100.0%    0+0k 0+0io 68pf+0w

Also, some inactive servers exactly the same kernel return instantly,
which is why I don't understand why walking too big a hash table can be
the problem:

[sroot@devel:/root]# time wc -l /proc/net/tcp
     10 /proc/net/tcp
0.000u 0.000s 0:00.00 0.0%      0+0k 0+0io 113pf+0w

What gives?

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
