Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129821AbQKVGie>; Wed, 22 Nov 2000 01:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130127AbQKVGiY>; Wed, 22 Nov 2000 01:38:24 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:448 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S129821AbQKVGiQ>; Wed, 22 Nov 2000 01:38:16 -0500
From: kumon@flab.fujitsu.co.jp
Date: Wed, 22 Nov 2000 15:08:04 +0900
Message-Id: <200011220608.PAA02949@asami.proc.flab.fujitsu.co.jp>
To: Jens Axboe <axboe@suse.de>
Cc: kumon@flab.fujitsu.co.jp, linux-kernel@vger.kernel.org,
        Dave Jones <davej@suse.de>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] livelock in elevator scheduling
In-Reply-To: <20001121140122.H10007@suse.de>
In-Reply-To: <200011210838.RAA27382@asami.proc.flab.fujitsu.co.jp>
	<20001121112836.B10007@suse.de>
	<200011211130.UAA27961@asami.proc.flab.fujitsu.co.jp>
	<20001121123608.F10007@suse.de>
	<200011211239.VAA28311@asami.proc.flab.fujitsu.co.jp>
	<20001121140122.H10007@suse.de>
Reply-To: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes:
 > > The benchmark invokes lots of processes, each corresponds to a client,
 > > and each accesses different portion of few large files.  We have
 > > enough memory to hold all dirty data at onece (1GB without himem), so
 > > if no I/O blocking occur, all process can be run simultaneously with
 > > limited amount of dirty flush I/O stream.
 > 
 > Flushing that much dirty data will always end up blocking waiting
 > for request slots.

Yes, such benchmarks need moderate long startup time, like 10 minutes
or more.  During that period, physical read requests are issued and
those are waiting on a queue, resulting low performance value.
 As file data is accumulated into memory, CPU usage goes
high. Finally, all required data are on the buffer, the system can use
100% CPU.

I show you the example of "vmstat 10" during the test.
It includes the beginning, startup, full-usage states.

At the current setting, the hard-threshold of dirty cache, which needs
synchronous flushing, is over 300MB and this test doesn't reach at the
limit.

During startup period, "cache" steadily increase, but until READ
is disappeared cpu usage stays very low.

If some of the read requests have inferior priority to others, those
requests need (extremely) long time to be served, then the startup
process never end in reasonable time.


   procs                   memory    swap          io     system         cpu
 r  b  wswpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0   0 863424   1760  13200   0   0     0     0  101     6   0   0 100

START CLIENTS
 0 16  0   0 843448   2052  25796   0   0   322     0  587   458   1   2  97
 0 16  0   0 827988   2052  40836   0   0   376     0  619   491   1   0  99
 0 16  0   0 813276   2052  55120   0   0   357     0  630   489   1   0  98

DIRTY FLUSH STARTS
 0 16  0   0 802488   2052  65608   0   0   262    34  541   420   1   0  99
	9 more lines
 0 16  0   0 717824   2052 148040   0   0   151    73  572   442   1   0  99
	9 more lines
 0 16  1   0 657216   2052 206980   0   0   119    71  790   602   2   1  98
	9 more lines
 0 16  1   0 652484   2052 211592   0   0   115    72  815   613   2   0  98
	9 more lines
 0 16  1   0 623256   2052 240072   0   0    20   119  432   424   1   0  99
	9 more lines
 0 16  1   0 598600   2052 264088   0   0    16   119  884   719   2   1  97
	9 more lines
 1 15  1   0 592156   2052 270332   0   0    15   119 1609  1185   5   1  94
 0 16  1   0 591540   2052 270916   0   0    15   119 1475  1102   4   1  95
 1 15  1   0 590920   2052 271512   0   0    15   119 1669  1243   5   1  94
 1 15  1   0 590344   2052 272072   0   0    14   122 2091  1500   7   2  92
 0 16  1   0 589752   2052 272644   0   0    14   120 2484  1767   8   2  91
 1 15  1   0 589180   2052 273196   0   0    14   120 2674  1905   8   2  90
 2 14  1   0 588608   2052 273748   0   0    14   122 3059  2142  10   2  88
 0 16  1   0 588044   2052 274288   0   0    14   122 4430  3037  16   3  82
 0 16  1   0 587524   2052 274800   0   0    13   123 5892  3913  21   4  75
 1 14  2   0 587036   2052 275236   0   0    11   121 8525  6062  31   7  62
10  4  2   0 586688   2052 275576   0   0     9   124 12162  8902  47  10  43
14  1  2   0 586528   2052 275708   0   0     3   129 17605  7710  80  18   2

FULL CPU USAGE (No physical read request is issued)
15  0  2   0 586492   2052 275740   0   0     1   131 18843  6652  82  18   0
14  0  2   0 586484   2052 275748   0   0     0   132 19210  6340  82  18   0

CONTINUE TO THE END

--
Computer Systems Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
