Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262533AbSI0ROl>; Fri, 27 Sep 2002 13:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262532AbSI0ROk>; Fri, 27 Sep 2002 13:14:40 -0400
Received: from magic.adaptec.com ([208.236.45.80]:64902 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S262531AbSI0ROg>; Fri, 27 Sep 2002 13:14:36 -0400
Date: Fri, 27 Sep 2002 11:19:38 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Jens Axboe <axboe@suse.de>
cc: Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing
 file transfers
Message-ID: <2483176224.1033147178@aslan.btc.adaptec.com>
In-Reply-To: <20020927143040.GF23468@suse.de>
References: <20020927074509.GA860@suse.de>
 <Pine.BSF.4.21.0209270055290.18408-100000@beppo>
 <20020927102503.GA15101@suse.de> <389902704.1033133455@aslan.scsiguy.com>
 <20020927143040.GF23468@suse.de>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If the above is what has been observed in the real world, then there
> would be no problem. Lets say I have 32 tags pending, all writes. Now I
> issue a read. Then I go ahead and through my writes at the drive,
> basically keeping it at 32 tags all the time. When will this read
> complete? The answer is, well it might not within any reasonable time,
> because the drive happily starves the read to get the best write
> throughput.

Just because you use 32 or 4 or 8 or whatever tags you cannot know the
number of commands still in the drive's cache.  Have you disabled
turned off the WCE bit on your drive and retested your latency numbers?

> The size of the dirty cache back log, or whatever you want to call it,
> does not matter _at all_. I don't know why both you and Matt keep
> bringing that point up. The 'back log' is just that, it will be
> processed in due time. If a read comes in, the io scheduler will decide
> it's the most important thing on earth. So I may have 1 gig of dirty
> cache waiting to be flushed to disk, that _does not_ mean that the read
> that now comes in has to wait for the 1 gig to be flushed first.

But it does matter.  If single process can fill the drive's or array's
cache with silly write data as well as have all outstanding tags busy
on its writes, you will incur a significant delay.  No single process
should be allowed to do that.  It doesn't matter that the read becomes
the most important thing on earth to the OS, you can't take back what
you've already issued to the device.  Sorry.  It doesn't work that
way.

> However, I maintain that going beyond any reasonable number of tags for
> a standard drive is *stupid*. The Linux io scheduler gets very good
> performance without any queueing at all. Going from 4 to 64 tags gets
> you very very little increase in performance, if any at all.

Under what benchmarks?  http load?  Squid, News, or mail simulations?
All I've seen are examples crafted to prove your point that I don't
think mirror real world workloads.

>> In all I/O studies that have been performed todate, reads far outnumber
>> writes *unless* you are creating an ISO image on your disk.  In my
>> opinion
> 
> Well it's my experience that it's pretty balanced, at least for my own
> workload. atime updates and compiles etc put a nice load on writes.

These are very differnet than the "benchmark" I've seen used in this
dicussion:

dd if=/dev/zero of=somefile bs=1M &
cat somefile.

Have you actually timed some of your common activities (say a full
build of the Linux kernel w/modules) at different tag depths, with
or without write caching enabled, etc?
 
> If you care to show me this cake, I'd be happy to devour it. I see
> nothing even resembling a solution to this problem in your email, except
> from you above saying I should ignore it and optimize for 'the common'
> concurrent read case.

Take a look inside True64 (I believe there are a few papers about this)
to see how to use command response times to modulate device workload.
FreeBSD has several algorithms in its VM to prevent a single process
from holding onto too many dirty buffers.  FreeBSD, Solaris, True64,
even WindowsNT have effective algorithms for sanely retiring dirty
buffers without saturating the system.  All of these algorithms have
been discussed at length in conference papers.  You just need to go
do a google search.  None of these issues are new and the solutions
are not novel.
 
> It's pointless to argue that tagging is oh so great and always
> outperforms the os io scheduler, and that we should just use 253 tags
> because the drive knwos best, when several examples have shown that this
> is _not the case_.

You are trying to solve these problems at the wrong level.

--
Justin
