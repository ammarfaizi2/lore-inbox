Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293483AbSCKCNz>; Sun, 10 Mar 2002 21:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293484AbSCKCNf>; Sun, 10 Mar 2002 21:13:35 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15416 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293483AbSCKCNY>; Sun, 10 Mar 2002 21:13:24 -0500
Date: Mon, 11 Mar 2002 03:14:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <fletch@aracnet.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 23 second kernel compile (aka which patches help scalibility on NUMA)
Message-ID: <20020311031425.N8949@dualathlon.random>
In-Reply-To: <82825246.1015624024@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82825246.1015624024@[10.10.2.3]>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 09:47:04PM -0800, Martin J. Bligh wrote:
> Big locks left:
> 
> pagemap_lru_lock
> 20.2% 57.1%  5.4us(  86us)  111us(  16ms)(14.7%)   1014988 42.9% 57.1%    0%  

I think this is only due the lru_cache_add executed by the anonymous
pagefaults. Pagecache should stay in the lru constantly if you're
running in hot pagecache as I guess. For a workload like this one
keeping anon pages out of the lru would be an obvious win. The only
reason we put anon pages into the lru before they are converted to
swapcache is to get a nicer swapout behaviour, but you're certainly not
swapping out anything. It's a tradeoff. Just like the additional
memory/cpu and locking overhead that rmap requires will slowdown page
faults even more than what you see now, with the only object to get a
nicer pagout behaviour (modulo the ram-binding "migration" stuff where
rmap is mandatory to do it instantly and not over time). If we don't
care of getting a nice swapout behaviour workloads like a kernel compile
could be speededup and scaled up much better, but for general purpose we
don't want to slowdown like a crawl when swapping activities become
necessary.

> Any other suggestions are welcome. I'd also be interested
> to know if 23s is fast for make bzImage, or if other big
> iron machines can kick this around the room.

It's also a big function of .config, compiler and kernel source (and if
you include make dep too or not).

>From my part my record kernel compile is been at LANL with 32cpus
wildfire with a 2.4.3-aa kernel IIRC (it just had the basic numa
scheduler optimizations), it took 37 seconds IIRC (with a quite generic
.config that could be used on most alphas except for the
CONFIG_WILDFIRE that was required at that time, but not all the possible
drivers out there included of course).  With Ingo's scheduler and the
other enachements that happend during 2.4, it probably won't go down to
the teenth, but it should get into the low twenty I believe.  Also 32way
scalability on a kernel compile cannot be exploited completly, unless
the .config is very full like the one used by distributions. Last but
not the least the output was scrolling so fast on the VGA console that I
guess redirecting the output to >/dev/null may save some point percent
too :). and of course that was with an alpha target, not an x86 target,
so that's not comparable also because of last variable. I think your
23 seconds figure looks very nice.

Andrea
