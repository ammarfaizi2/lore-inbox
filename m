Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316964AbSFQUDQ>; Mon, 17 Jun 2002 16:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316968AbSFQUDP>; Mon, 17 Jun 2002 16:03:15 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:61632 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S316964AbSFQUDO>; Mon, 17 Jun 2002 16:03:14 -0400
Date: Mon, 17 Jun 2002 13:03:15 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: linux-kernel@vger.kernel.org
Subject: 3x slower file reading oddity
Message-ID: <Pine.LNX.4.44.0206171246270.31265-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i was trying to study various cpu & i/o bottlenecks for a backup
tool (rdiff-backup) and i stumbled into this oddity:

# time xargs -0 -n100 cat -- > /dev/null < /tmp/filelist
0.520u 5.310s 0:36.92 15.7%     0+0k 0+0io 11275pf+0w
# time xargs -0 -n100 cat -- > /dev/null < /tmp/filelist
0.510u 5.090s 0:35.05 15.9%     0+0k 0+0io 11275pf+0w

# time xargs -0 -P2 -n100 cat -- > /dev/null < /tmp/filelist
0.500u 5.380s 1:30.51 6.4%      0+0k 0+0io 11275pf+0w
# time xargs -0 -P2 -n100 cat -- > /dev/null < /tmp/filelist
0.420u 4.810s 1:36.73 5.4%      0+0k 0+0io 11275pf+0w

3x slower with the two cats in parallel.

these particular measurements were taken on this system:

	linux 2.4.19-pre10-ac2
	SMP dual P3 500MHz
	512MB PC100 memory
	promise ultra100/tx2
	maxtor 5400rpm 80GB disk

the filelist has 25400 files totalling 1700MB (two copies of
my ~/mail).

i thought it might be that the /dev/null file is shared amongst
the two parallel cats... so i wrote up a program that just
iterates over the file in 4k blocks and does nothing with the
data:

# time xargs -0 -n100 ~/tmp/reader < /tmp/filelist
0.300u 5.040s 0:37.07 14.4%     0+0k 0+0io 8735pf+0w
# time xargs -0 -n100 -P2 ~/tmp/reader < /tmp/filelist
0.320u 4.740s 1:35.30 5.3%      0+0k 0+0io 8735pf+0w

any ideas what is going on here?

i've seen the same thing on an smp system with 4x maxtors and software
raid5.

-dean

p.s.  i was trying to get more i/o in flight in hopes of seeing better
perf from the disk subsystem... i know it's hopeless with a single IDE
disk without TCQ, but i was targetting the 4-disk system.  are there
any newfangled fun interfaces which can improve the tree recursion and
zillion file open() bottlenecks in filesystem-level backups?

