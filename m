Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267157AbTBUFQk>; Fri, 21 Feb 2003 00:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbTBUFP7>; Fri, 21 Feb 2003 00:15:59 -0500
Received: from packet.digeo.com ([12.110.80.53]:36283 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267157AbTBUFOt>;
	Fri, 21 Feb 2003 00:14:49 -0500
Date: Thu, 20 Feb 2003 21:26:27 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: iosched: concurrent reads of many small files
Message-Id: <20030220212627.796605c9.akpm@digeo.com>
In-Reply-To: <20030220212304.4712fee9.akpm@digeo.com>
References: <20030220212304.4712fee9.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 05:24:49.0033 (UTC) FILETIME=[8D9AEF90:01C2D969]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This test is very approximately the "busy web server" workload.  We set up a
number of processes each of which are reading many small files from different
parts of the disk.

Set up six separate copies of the 2.4.19 kernel tree, and then run, in
parallel, six processes which are reading them:

	for i in 1 2 3 4 5 6
	do
		time (find kernel-tree-$i -type f | xargs cat > /dev/null ) &
	done

With this test we have six read requests in the queue all the time.  It's
what the anticipatory scheduler was designed for.


2.4.21-pre4:
	6m57.537s
	6m57.620s
	6m57.741s
	6m57.891s
	6m57.909s
	6m57.916s

2.5.61+hacks:
	3m40.188s
	3m51.332s
	3m55.110s
	3m56.186s
	3m56.757s
	3m56.791s

2.5.61+CFQ:
	5m15.932s
	5m16.219s
	5m16.386s
	5m17.407s
	5m50.233s
	5m50.602s

2.5.61+AS:
	0m44.573s
	0m45.119s
	0m46.559s
	0m49.202s
	0m51.884s
	0m53.087s

This was a little unfair to 2.4 because three of the trees were laid out by
the pre-Orlov ext2.  So I reran the test with 2.4.21-pre4 when all six trees
were laid out by 2.5's Orlov allocator:

	6m12.767s
	6m12.974s
	6m13.001s
	6m13.045s
	6m13.062s
	6m13.085s

Not much difference there, although Orlov is worth a 4x speedup in this test
when there is only a single reader (or multiple readers + anticipatory
scheduler)



