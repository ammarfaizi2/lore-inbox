Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbUC2AzR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 19:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbUC2AzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 19:55:16 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31876
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262541AbUC2AzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 19:55:04 -0500
Date: Mon, 29 Mar 2004 02:55:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040329005502.GG3039@dualathlon.random>
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406720A7.1050501@pobox.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 01:59:51PM -0500, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> >On Sunday 28 of March 2004 20:30, Jens Axboe wrote:
> >>Making something user tunable is usually not the best idea, if you can
> >>deduct these things automagically instead. So whether this is the best
> >>idea, depends on which way you want to go.
> >
> >
> >I think it's the best idea for now, long-term we are better with automagic.
> 
> 
> Mostly agreed:
> 
> Like I mentioned in the last message, the IO scheduler and the VM should 

this is not an I/O scheduler or VM issue.

the max size of a request is something that should be set internally to
the blkdev layer (at a lower level than the I/O scheduler or the VM
layer).

The point is that if you run read contigously from disk with a 1M or 32M
request size, the wall time speed difference will be maybe 0.01% or so.
Running 100 irqs per second or 3 irq per second doesn't make any
measurable difference. Same goes for keeping the I/O pipeline full, 1M
is more than enough to go at the speed of the storage with minimal cpu
overhead. we waste 900 irqs per second just in the timer irq and
another 900 irqs per second per-cpu in the per-cpu local interrupts in
smp.

In 2.4 reaching 512k DMA units that helped a lot, but going past 512k
didn't help in my measurements.  1M maybe these days is needed (as Jens
suggested) but >1M still sounds overkill and I completely agree with
Jens about that.

If one day things will change and the harddisk will require 32M large
DMA transactions to keep up with the speed of the disk, the thing should
be still solved during disk discovery inside the blkdev layer. The
"automagic" suggestions discussed by Jamie and Jens should be just
benchmarks internal to the blkdev layer, trying to read contigously
first with 1M then 2M then 4M etc..  until the speed difference goes
below 1% or whatever similar "autotune" algorithm.

But definitely this is not an I/O scheduler or VM issue, it's all about
discovering the minimal DMA transaction size that provides peak bulk I/O
performance for a certain device. The smaller the size, the better the
latencies and the less ram will be pinned at the same time (i.e. think a
64M machine writing at 32M chunks at time).

Of course if we'll ever deal with hardware where 32M requests makes a
difference, then we may have to add overrides to the I/O scheduler to
lower the max_requests (i.e. like my obsolete max_bomb_segments did).
But I expect that by default the contigous I/O will use the max_sector
choosen by the blkdev layer (not choosen by VM or I/O scheduler) to
guarantee the best bulk I/O performance as usual (the I/O scheduler
option would be just an optional override). the max_sectors is just
about using a sane DMA transaction size, good enough to run at
disk-speed without measurable cpu overhead, but without being too big so
that it provides sane latencies. Overkill huge DMA transactions might
even stall the cpu when accessing the mem bus (though I'm not an
hardware guru so this is just a guess).

So far there was no need to autotune it, and settings like 512k were
optimal.

Don't take me wrong, I find extremely great that you now can raise the
IDE request size to a value like 512k, the 128k limit was the ugliest
thing of IDE ever, but you provided zero evidence that going past 512k
is beneficial at all, and your bootup log showing 32M is all but
exciting, I'd be a lot more excited to see 512k there.

I expect that the boost from 128k to 512k is very significant, but I
expect that from 512k to 32M there will be just a total waste of latency
with zero performance gain in throughput. So unless you measure any
speed difference from 512k to 32M I recommend to set it to 512k for the
short term like most other driver does for the same reasons.
