Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317148AbSFQX21>; Mon, 17 Jun 2002 19:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317170AbSFQX20>; Mon, 17 Jun 2002 19:28:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33042 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317148AbSFQX20>;
	Mon, 17 Jun 2002 19:28:26 -0400
Message-ID: <3D0E7041.860710CA@zip.com.au>
Date: Mon, 17 Jun 2002 16:26:57 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dean gaudet <dean-list-linux-kernel@arctic.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3x slower file reading oddity
References: <Pine.LNX.4.44.0206171246270.31265-100000@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
> 
> i was trying to study various cpu & i/o bottlenecks for a backup
> tool (rdiff-backup) and i stumbled into this oddity:
> 
> # time xargs -0 -n100 cat -- > /dev/null < /tmp/filelist
> 0.520u 5.310s 0:36.92 15.7%     0+0k 0+0io 11275pf+0w
> # time xargs -0 -n100 cat -- > /dev/null < /tmp/filelist
> 0.510u 5.090s 0:35.05 15.9%     0+0k 0+0io 11275pf+0w
> 
> # time xargs -0 -P2 -n100 cat -- > /dev/null < /tmp/filelist
> 0.500u 5.380s 1:30.51 6.4%      0+0k 0+0io 11275pf+0w
> # time xargs -0 -P2 -n100 cat -- > /dev/null < /tmp/filelist
> 0.420u 4.810s 1:36.73 5.4%      0+0k 0+0io 11275pf+0w
> 
> 3x slower with the two cats in parallel.

Note that the CPU time remained constant.  The wall time went up.
You did more seeking with the dual-thread approach.

I rather depends on what is in /tmp/filelist.  I assume it's
something like the output of `find'.  And I assume you're
using ext2 or ext3?

- ext2/3 will chop the filesystem up into 128-megabyte block groups.

- It attemts to place all the files in a directory into the same
  block group.

- It will explicitly place new directories into a different blockgroup
  from their parent.

And I suspect it's the latter point which has caught you out.  You have
two threads, and probably each thread's list of 100 files is from a
different directory.  And hence it lives in a different block group.
And hence your two threads are competing for the disk head.

Even increasing the elevator read latency won't help you here - we don't
perform inter-file readahead, so as soon as thread 1 blocks on a read,
it has *no* reads queued up and the other thread's requests are then 
serviced.

You'll get best throughput with a single read thread.  There are some
smarter readahead things we could do in there, but it tends to be
that device-level readahead fixes everything up anyway.

-
