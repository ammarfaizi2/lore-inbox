Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbTBUFR7>; Fri, 21 Feb 2003 00:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbTBUFQt>; Fri, 21 Feb 2003 00:16:49 -0500
Received: from packet.digeo.com ([12.110.80.53]:39611 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267176AbTBUFQT>;
	Fri, 21 Feb 2003 00:16:19 -0500
Date: Thu, 20 Feb 2003 21:27:58 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: iosched: impact of streaming read on read-many-files
Message-Id: <20030220212758.5064927f.akpm@digeo.com>
In-Reply-To: <20030220212304.4712fee9.akpm@digeo.com>
References: <20030220212304.4712fee9.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 05:26:20.0063 (UTC) FILETIME=[C3DD02F0:01C2D969]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here we look at what affect a large streaming read has upon an operation
which reads many small files from the same disk.

A single streaming read was set up with:

	while true
	do
	        cat 512M-file > /dev/null
	done

and we measure how long it takes to read all the files from a 2.4.19 kernel
tree off the same disk with

	time (find kernel-tree -type f | xargs cat > /dev/null)



2.4.21-pre4:	31 minutes 30 seconds

2.5.61+hacks:	3 minutes 39 seconds

2.5.61+CFQ:	5 minutes 7 seconds (*)

2.5.61+AS:	17 seconds





* CFQ performed very strangely here.  Tremendous amount of seeking and a
  big drop in aggregate bandwidth.  See the vmstat 1 output from when the
  kernel tree read started up:


 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  1   1240 125260   1176 109488    0    0 40744     0 1672   725  0  3 49 47
 0  1   1240  85892   1220 148788    0    0 39344     0 1651   693  0  3 49 48
 0  1   1240  45124   1260 189492    0    0 40744     0 1663   683  0  3 49 47
 1  1   1240   4544   1300 230068    0    0 40616     0 1661   837  0  4 49 47
 0  2   1348   3468    944 231696    0  108 40488   148 1671   800  0  4  4 91
 0  2   1348   2180    936 232920    0    0 40612    64 1668   789  0  4  0 96
 0  3   1348   4220    996 230648    0    0 11348     0 1256   352  0  2  0 98
 0  3   1348   4052   1064 230472    0    0  9012     0 1207   305  0  1  0 98
 0  4   1348   3596   1148 230580    0    0  6756     0 1171   247  0  1  0 99
 0  4   1348   4044   1148 229888    0    0  6344     0 1165   237  0  1  0 99
 1  3   1348   3708   1160 230212    0    0  7800     0 1187   255  0  1 21 78


