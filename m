Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267185AbTBUFQk>; Fri, 21 Feb 2003 00:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267157AbTBUFQG>; Fri, 21 Feb 2003 00:16:06 -0500
Received: from packet.digeo.com ([12.110.80.53]:38075 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267173AbTBUFPv>;
	Fri, 21 Feb 2003 00:15:51 -0500
Date: Thu, 20 Feb 2003 21:27:30 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: iosched: impact of streaming write on read-many-files
Message-Id: <20030220212730.29de4171.akpm@digeo.com>
In-Reply-To: <20030220212304.4712fee9.akpm@digeo.com>
References: <20030220212304.4712fee9.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 05:25:51.0829 (UTC) FILETIME=[B308D850:01C2D969]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here we look at what affect a large streaming write has upon an operation
which reads many small files from the same disk.


A single streaming write was set up with:

	while true
	do
	        dd if=/dev/zero of=foo bs=1M count=512 conv=notrunc
	done

and we measure how long it takes to read all the files from a 2.4.19 kernel
tree off the same disk with

	time (find kernel-tree -type f | xargs cat > /dev/null)

As a reference, the time to read the kernel tree with no competing I/O is 7.9
seconds.

2.4.21-pre4:

    Don't know.  I killed it after 15 minutes.  Judging from the vmstat
    output it would have taken many hours.

2.5.61+hacks:	7 minutes 27 seconds
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  8      0   2188   1200 226692    0    0   852 17664 1204   253  0  3  0 97
 0  8      0   4148   1212 224804    0    0  1940 16208 1187   245  0  2  0 98
 0  7      0   4260   1128 224756    0    0   324 20228 1226   298  0  3  0 97
 0  8      0   4204   1048 224944    0    0   500 20856 1227   313  0  3  0 97
 1  7      0   2300   1040 226840    0    0   348 20272 1227   313  0  3  0 97
 0  8      0   4204   1044 224952    0    0   212 21564 1230   320  0  3  0 97

2.5.61+CFQ:	9 minutes 55 seconds
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  2      0   4308   1028 224660    0    0   180 38368 1250   357  0  3  6 91
 0  4      0   2180   1020 226852    0    0   324 25196 1266   408  0  4  1 95
 0  4      0   2236   1016 226744    0    0   252 26948 1276   449  0  4  2 93
 0  4      0   4196   1020 224816    0    0   380 23204 1250   454  0  3  4 93
 0  3      0   4356   1036 224632    0    0  2616 25824 1271   490  0  4  0 96
 0  4      0   4140    968 224996    0    0   496 29416 1304   609  0  4  0 96
 0  4      0   2180    948 226972    0    0   352 29364 1300   688  0  5  0 95
 0  3      0   4364    928 224796    0    0   344 22100 1281   656  0  4 22 74

(CFQ had a strange 20-second pause in which it performed no reads at all)
(And a later 4-second one)
(then 10 seconds..)


2.5.61+AS:	17 seconds
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  6      0   2280   2716 226112    0    0     0 22388 1205   151  0  3  0 97
 0  6      0   4296   2596 224168    0    0     0 21968 1213   148  0  3  0 97
 1  6      0   3872   2516 224408    0    0   296 19552 1223   249  0  3  0 97
 0  9      0   2176   2584 225324    0    0  5112 14588 1573  1424  0  5  0 94
 0  8      0   3364   2668 223116    0    0 17512  8500 3059  6065  0  8  0 92
 1  8      0   4156   2708 221340    0    0 12812  9560 2695  4863  0  9  0 91
 0  8      0   3740   2956 221188    0    0 17216  7200 2406  4045  0  6  0 94
 0  9      0   3828   2668 221192    0    0  9712  8972 1615  1540  0  5  0 94
 1  6      0   2060   2924 222272    0    0  8428 17784 1713  1718  0  5  0 95


