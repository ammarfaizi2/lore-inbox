Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267199AbTBUFTB>; Fri, 21 Feb 2003 00:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbTBUFSJ>; Fri, 21 Feb 2003 00:18:09 -0500
Received: from packet.digeo.com ([12.110.80.53]:42427 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267176AbTBUFQu>;
	Fri, 21 Feb 2003 00:16:50 -0500
Date: Thu, 20 Feb 2003 21:28:29 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: iosched: effect of streaming read on streaming write
Message-Id: <20030220212829.6319d09c.akpm@digeo.com>
In-Reply-To: <20030220212304.4712fee9.akpm@digeo.com>
References: <20030220212304.4712fee9.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 05:26:51.0016 (UTC) FILETIME=[D6501080:01C2D969]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here we look at how much damage a streaming read can do to writeout
performance.  Start a streaming read with:

	while true
	do
	        cat 512M-file > /dev/null
	done

and measure how long it takes to write out and fsync a 100 megabyte file:

	time write-and-fsync -f -m 100 outfile

2.4.21-pre4:	6.4 seconds
2.5.61+hacks:	7.7 seconds
2.5.61+CFQ:	8.4 seconds
2.5.61+AS:	11.9 seconds

This is the one where the anticipatory scheduler could show its downside. 
It's actually not too bad - the read stream steals 2/3rds of the disk
bandwidth.  Dirty memory will reach the vm threshold and writers will
throttle.  This is usually what we want to happen.

Here is the vmstat 1 trace for the anticipatory scheduler:

 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  1   8728   2268   2620 233412    0    0 40360     0 1658   802  0  4  0 96
 0  2   8728   3780   2508 231924    0    0 40616     4 1668   874  0  5  0 95
 0  2   8728   3668   2276 232416    0    0 40740    20 1668   978  0  4  0 96
 0  3   8728   3660   2192 232668   40    0 35296    12 1603   904  0  4  0 95
 0  5   8728   3612   1964 231672    0    0 26220 18572 1497  1381  0 15  0 85
 0  5   8728   2100   1732 233584    0    0 25232  8696 1497   867  0  3 16 81
 0  5   8728   3664   1204 232424    0    0 27668  8696 1533   787  0  3  0 97
 1  4   8728   2432    792 234108    0    0 27160  8696 1527   965  0  3  0 97
 0  6   8728   2208    760 234436    0    0 25904  9584 1513   856  0  3  0 97
 2  6   8728   3776    760 233148    0    0 27776  8716 1537   880  0  3  0 97
 0  6   8728   2204    624 234968    0    0 27924  8812 1541   991  0  4  0 96
 0  4   8716   2508    600 234740    0    0 28188  8216 1537  1038  0  4  0 96
 0  4   8716   4072    532 233316    0   16 25624  9644 1515   896  0  3  0 97
 0  4   8716   3740    548 233624    0    0 27548  8696 1528   908  0  3  0 97



