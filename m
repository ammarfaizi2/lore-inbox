Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbUBYU7p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbUBYU6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:58:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:18574 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261466AbUBYUw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:52:59 -0500
Message-Id: <200402252052.i1PKqsr30515@mail.osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: reaim - 2.6.3-mm1 IO performance down. 
In-Reply-To: Your message of "Wed, 25 Feb 2004 11:16:33 PST."
             <20040225111633.46ddacc7.akpm@osdl.org> 
Date: Wed, 25 Feb 2004 12:52:54 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Cliff White <cliffw@osdl.org> wrote:
> >
> >  > Thanks.  You could try reverting adaptive-lazy-readahead.patch.  If it i
> s
> >  > not that I'd be suspecting CPU scheduler changes.  Do you have uniproces
> sor
> >  > test results?
> > 
> >  I have them for 2.6.3-mm3, am re-running 2.6.3-mm1 right now.
> >  Gross results are within 1%, but looking at the detail, i do see badness,
> 
> OK, I'll do the bsearch.  Again.  Could you please tell me what would be an
> appropriate reaim command line with which to reproduce this?

Sure. 
We use the 'workfile.new_fserver' for this load. Comes in the kit.
This test does IO, so you'll need to list some directories and a filepool
size
in a text file. Ours looks like this:
stp.config
-------------------
FILESIZE 80k
POOLSIZE 1024k
DISKDIR /mnt/disk1
DISKDIR /mnt/disk2
DISKDIR /mnt/disk3
DISKDIR /mnt/disk4
--------------------

If you want the shortest possible run,  shrink POOLSIZE and 
go with the defaults:
reaim -fworkfile.new_fserver -l./stp.config

That will run 1->5 users, should be < 1 egg timer in duration
on modern iron. I dunno if that'll be a useful data point.
To replicate at a specific number of users, pick a number 
( example: 20 )
, and use this:

reaim -s20 -e20 -fworkfile.new_fserver -l./stp.config

That will do one pass at 20 users. Should be quick, maybe 2-4
egg timers, and will give you one of the data points I reported.
If you have more time, this runs range 20->80 with a 10 user increment:

reaim -s20 -e80 -i10 -t -fworkfile.new_fserver -l./stp.config
( the -t turns off the AIM7 adaptive increment )

The STP runs are very long. Many egg-timers. 
We invoke them like this, where NCPU is the number of CPUS we have:
The 'quick convergence run' ( repeats three times )
reaim -s$NCPU -q -t -i$NCPU -fworkfile.new_fserver -r3 -b -l./stp.config

This is the 'maximum' longest run
reaim -s$NCPU -s -t -i$NCPU -fworkfile.new_fserver -r3 -b -l./stp.config

If you want those, quicker to request via STP/PLM -
cliffw 





> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
