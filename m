Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130449AbRAUDQO>; Sat, 20 Jan 2001 22:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131185AbRAUDQF>; Sat, 20 Jan 2001 22:16:05 -0500
Received: from mtiwmhc23.worldnet.att.net ([204.127.131.48]:39923 "EHLO
	mtiwmhc23.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S130449AbRAUDPy>; Sat, 20 Jan 2001 22:15:54 -0500
Message-ID: <3A6A558D.5E0CF29E@att.net>
Date: Sat, 20 Jan 2001 22:20:45 -0500
From: Michael Lindner <mikel@att.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Dan Maas <dmaas@dcine.com>, Edgar Toernig <froese@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data  
 available
In-Reply-To: <fa.nc2eokv.1dj8r80@ifi.uio.no> <fa.dcei62v.1s5scos@ifi.uio.no> <015e01c082ac$4bf9c5e0$0701a8c0@morph> <3A69361F.EBBE76AA@att.net> <20010120200727.A1069@metastasis.f00f.org> <3A694254.B52AE20B@att.net> <3A6A09F2.8E5150E@gmx.de> <022f01c08342$088f67b0$0701a8c0@morph> <20010121133433.A1112@metastasis.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, 2.4.0 kernel installed, and a new set of numbers:

test		kernel		ping-pongs/s. @ total CPU util	w/SOL_NDELAY
sample (2 skts)	2.2.18		100 @ 0.1%			800 @ 1%
sample (1 skt)	2.2.18		8000 @ 100%			8000 @ 50%
real app	2.2.18		100 @ 0.1%			800 @ 1%

sample (2 skts)	2.4.0		8000 @ 50%			8000 @ 50%
sample (1 skt)	2.4.0		10000 @ 50%			10000 @ 50%
real app	2.4.0		1200 @ 50%			1200 @ 50%

real app	Windows 2K	4000 @ 100%

The two points that still seem strange to me are:

1. The 1 socket case is still 25% faster than the 2 socket case in 2.4.0
(in 2.2.18 the 1 socket case was 10x faster).

2. Linux never devotes more than 50% of the CPU (average over a long
run) to the two processes (25% to each process, with the rest of the
time idle).

I'd really love to show that Linux is a viable platform for our SW, and
I think it would be doable if I could figure out how to get the other
50% of my CPU involved. An "strace -rT" of the real app on 2.4.0 looks
like this for each ping/pong.

     0.052371 send(7, "\0\0\0
\177\0\0\1\3243\0\0\0\2\4\236\216\341\0\0\v\277"..., 32, 0) = 32
<0.000529>
     0.000882 rt_sigprocmask(SIG_BLOCK, ~[], [RT_0], 8) = 0 <0.000021>
     0.000242 rt_sigprocmask(SIG_SETMASK, [RT_0], NULL, 8) = 0
<0.000021>
     0.000173 select(8, [3 4 6 7], NULL, NULL, NULL) = 1 (in [6])
<0.000047>
     0.000328 read(6, "\0\0\0 ", 4)     = 4 <0.000031>
     0.000179 read(6,
"\177\0\0\1\3242\0\0\0\2\4\236\216\341\0\0\7\327\177\0\0"..., 28) = 28
<0.000075>

--
Mike Lindner
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
