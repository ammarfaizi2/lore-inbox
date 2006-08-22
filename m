Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWHVHkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWHVHkr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 03:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWHVHkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 03:40:47 -0400
Received: from ns2.suse.de ([195.135.220.15]:8383 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751065AbWHVHkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 03:40:47 -0400
From: Neil Brown <neilb@suse.de>
To: Andrzej Szymanski <szymans@agh.edu.pl>
Date: Tue, 22 Aug 2006 17:40:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17642.46325.818963.951269@cse.unsw.edu.au>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: Strange write starvation on 2.6.17 (and other) kernels
In-Reply-To: message from Andrzej Szymanski on Monday August 21
References: <44E0A69C.5030103@agh.edu.pl>
	<ec19r7$uba$1@news.cistron.nl>
	<17641.3304.948174.971955@cse.unsw.edu.au>
	<44E9A9C0.6000405@agh.edu.pl>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday August 21, szymans@agh.edu.pl wrote:
> Neil Brown wrote:
> > On Thursday August 17, miquels@cistron.nl wrote:
> > 
> > Can you report the contents of /proc/meminfo before, during, and after
> > the long pause?
> > I'm particularly interested in MemTotal, Dirty, and Writeback, but the
> > others are of interest too.
> > 
> > Thanks,
> > NeilBrown
> 
> I've prepared two logs, from different machines, the first one is on 
> software RAID5 (4 ATA disks) with deadline scheduler, the second on a 
> single ATA disk with CFQ scheduler. In the first case 10 writer threads 
> are sufficient to give large delays, in the second case I've run an 
> additional tar thread reading from the disk.
> 
> The logs are here:
> http://galaxy.agh.edu.pl/~szymans/logs/
> 
> Each writer starts with:
> Writing 200 MB to stdout without fsync
> 
> than reports each write() that lasts > 3s along with pid:
> 6582 - Delayed 4806 ms.
> 
> And finishes with:
> Max write delay: 14968 ms.
> 
> Andrzej.


Hmm...
I spent altogether too long exploring this :-)

I think all that is happening here is that the delay that has to be
imposed on the different write calls is being imposed somewhat
unfairly.

Suppose your filesystem/device can sustain 15MB/sec (like my
notebook).
Then with 10 concurrent threads, each should expect to write at
1.5MB/sec, or 1 Megabyte every 667 milliseconds

So you might expect each 1Meg write to take 667msec.
However Linux only imposes write throttling every 4Meg (If you have
128Meg or RAM of more).  So you would expect 3 out of 4 requests to be
instantaneous, and 1 out of 4 to take 2.667 seconds.

However it very hard to impose rate limiting completely uniformly. 
For example the block device driver imposes a queue length limit when
space becomes available on the queue, it is fairly random which
process gets to use it.
Further the block layer actually imposes some unfairness: when a
process gets an entry on the queue, it is (almost) guaranteed another
31 so it will make lots of progress and the expense of anyone else.
It does this to improve throughput (I believe).

So getting individual 1Meg writes taking a few seconds is quite likely. 
Having a few take several seconds should be expected.
You report numbers up to 26 seconds.  That is clearly quite a lot, but
I'm not sure there is much to be done about it - imposing strict
fairness will always have a cost.  That 26 seconds was in a run where
there were 2000 writes. You would expect 500 to hit delays. Only 63
hit delays > 3seconds.

In my various experimenting the one thing that was effective in
improving the fairness was to make Linux impose write throttling more
often.
In mm/page-writeback.c, in set_ratelimit() where ratelimit_pages is
calculated, cap it at much lower. e.g. set it unconditionally to 16.

This might increase CPU load on multi-processor machines, but it does
seem to increase the fairness of write throttling.

NeilBrown
