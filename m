Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271624AbTGQWgo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271609AbTGQWev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:34:51 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:18844
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S271603AbTGQWeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:34:15 -0400
Date: Fri, 18 Jul 2003 00:50:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>
Subject: Re: 2.4.22pre6aa1
Message-ID: <20030717225002.GY1855@dualathlon.random>
References: <20030717102857.GA1855@dualathlon.random> <200307180013.38078.m.c.p@wolk-project.de> <200307180024.17523.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307180024.17523.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 12:30:45AM +0200, Marc-Christian Petersen wrote:
> On Friday 18 July 2003 00:13, Marc-Christian Petersen wrote:
> 
> > On Thursday 17 July 2003 12:28, Andrea Arcangeli wrote:
> >
> > Hi Andrea,
> >
> > > Only in 2.4.22pre6aa1: 00_elevator-lowlatency-1
> > > Only in 2.4.22pre6aa1: 00_elevator-read-reservation-axboe-2l-1
> >
> > Hmm, this is now my first day testing out .22-pre6 and .22-pre6aa1 with the
> > new I/O stall fixes. At a first look & feel it's very good, but I've
> > noticed a side effect (if it can be called so):
> >
> > VMware4 Workstation
> > -------------------
> >
> > 2.4.22-pre[6|6aa1]: ~ 1 minute 02 seconds from: Start this virtual machine
> > ... 2.4.22-pre2       : ~          30 seconds from: Start this virtual
> > machine ...
> >
> > ... to start up Windows 2000 Professional completely.
> >
> > Well, personally I don't care about the slowdown of vmware startup with a
> > VM but there may be many other slowdows?!
> hmmm:
> 
> 2.4.22-pre[6|6aa1]:
> -------------------
> root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 count=131072
> 131072+0 records in
> 131072+0 records out
> 2147483648 bytes transferred in 128.765686 seconds (16677453 bytes/sec)
> 
> 2.4.22-pre2:
> ------------
> root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 count=131072
> 131072+0 records in
> 131072+0 records out
> 2147483648 bytes transferred in 98.489331 seconds (21804226 bytes/sec)
> 
> both kernels freshly rebooted.

this explains it.

Can you try to change include/linux/blkdev.h like this:

-#define MAX_QUEUE_SECTORS (4 << (20 - 9)) /* 4 mbytes when full sized */
+#define MAX_QUEUE_SECTORS (16 << (20 - 9)) /* 4 mbytes when full sized */

This will raise the queue from 4 to 16M. That is the first(/only) thing
that can explain a drop in performnace while doing contigous I/O.
However I didn't expect it to make a difference, or at least not so
relevant.

If this doesn't help at all, it might not be an elevator/blkdev thing.
At least on my machines the contigous I/O still at the same speed.

You also where the only one reporting a loss of performance with
elevator-lowlatency, it could be still the same problem that you've
seen at that time.

Last but not the least, if it's an elevator/blkdev thing, you must be
able to measure it with reads too, not only with writes. Can you try to
read that file back? (careful about the cache effects if you read it
multiple times and you interrupt it, best it to benchmark reads after a
mount to be sure)

> ext3fs (data=ordered)

can you try with data=writeback (or ext2) or hdparm -W1 and see if you
can still see the same delta between the two kernels? (careful with -W1
as it invalidates journaling)

thanks,

Andrea
