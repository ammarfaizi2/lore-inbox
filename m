Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131273AbRCWQz3>; Fri, 23 Mar 2001 11:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131270AbRCWQzT>; Fri, 23 Mar 2001 11:55:19 -0500
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:58756 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S131248AbRCWQzN>; Fri, 23 Mar 2001 11:55:13 -0500
Date: Fri, 23 Mar 2001 11:51:23 -0500
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adding just a pinch of icache/dcache pressure...
Message-ID: <20010323115123.A12720@cs.cmu.edu>
Mail-Followup-To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20010323015358Z129164-406+3041@vger.kernel.org> <Pine.LNX.4.21.0103230403370.29682-100000@imladris.rielhome.conectiva> <20010323122815.A6428@win.tue.nl> <m1hf0k1qvi.fsf@frodo.biederman.org> <3ABB6833.183E9188@mandrakesoft.com> <20010323111056.A9332@cs.cmu.edu> <20010323171716.28420@colin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010323171716.28420@colin.muc.de>; from ak@muc.de on Fri, Mar 23, 2001 at 05:17:16PM +0100
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 05:17:16PM +0100, Andi Kleen wrote:
> On Fri, Mar 23, 2001 at 05:10:56PM +0100, Jan Harkes wrote:
> > btw. There definitely is a network receive buffer leak somewhere in
> > either the 3c905C path or higher up in the network layers (2.4.0 or
> > 2.4.1). The normal path does not leak anything.
> 
> What do you mean with "normal path" ? 
> 
> And are you sure it was a leak? TCP can buffer quite a bit of skbs, but it 
> should be bounded based on the number of sockets. 
> 
> -Andi

No corrupted packets. I was pretty sure it was a leak once I noticed
that most of my memory got allocated here:

Top 10 of the not yet freed allocations taken from /proc/memleak in an
IKD-patched 2.4.2 kernel a couple of weeks ago:

memleak/01-02-27__15:44:19
74603    buffer.c:1234 
42956    3c59x.c:2232 
13025    dcache.c:598 
12392    inode.c:665 
5921     dcache.c:603 
4480     ll_rw_blk.c:397 
2304     raid5.c:154 
2105     mmap.c:276 
2064     af_unix.c:1340 
1312     file_table.c:62 

Buffer, dcache and inode allocations are all accounted for, I was
expecting the problem there. However the 3c59x.c allocations are not,
each of those buffers is taken from the size-2048 slab so they were
already taking about 88MB. This was after running a backup, but the
backup was already over and the sockets must have been closed. The
backup statistics showed tcp transfer speed to be an average of 75kB/s
instead of the more typical 350kB/s

Before the backup run, (01-02-27__14:41:45)
7679     3c59x.c:2232 

Later that afternoon the switch was fixed and life returned to normal.
I rebooted the next day and ran another backup, this is the top ten
unfreed allocations after that run.

memleak/01-02-28__16:03:03
191764   buffer.c:1234 
13957    inode.c:665 
9684     dcache.c:598 
4620     ll_rw_blk.c:397 
2304     raid5.c:154 
1587     mmap.c:276 
1066     file_table.c:62 
864      raid5.c:322 
846      dst.c:103 
802      dcache.c:603 
...
224      3c59x.c:2232		# not even in the top 10, it is number 19


I don't have any more numbers, and can't reproduce the situation anymore.

Jan
