Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291788AbSBAUML>; Fri, 1 Feb 2002 15:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291966AbSBAUMB>; Fri, 1 Feb 2002 15:12:01 -0500
Received: from holomorphy.com ([216.36.33.161]:45960 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S291788AbSBAULt>;
	Fri, 1 Feb 2002 15:11:49 -0500
Date: Fri, 1 Feb 2002 12:11:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adam McKenna <adam-dated-1013023458.e87e05@flounder.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: should I trust 'free' or 'top'?
Message-ID: <20020201201145.GD834@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Adam McKenna <adam-dated-1013023458.e87e05@flounder.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020201192415.GC23997@flounder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020201192415.GC23997@flounder.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 11:24:16AM -0800, Adam McKenna wrote:
> adam@xpdb:~$ uptime
>  11:21am  up 42 days, 18:53,  3 users,  load average: 54.72, 21.21, 17.60
> adam@xpdb:~$ free
>              total       used       free     shared    buffers     cached
> Mem:       5528464    5522744       5720          0        476    5349784
> -/+ buffers/cache:     172484    5355980
> Swap:      2939804    1302368    1637436
> As you can see, there are supposedly 5.3 gigs of memory free (not counting
> memory used for cache).  However, the box is swapping like mad (about 10 megs
> every 2 seconds according to vmstat) and the load is skyrocketing.

That 5.3GB is without kernel caches. I see 5.7MB...

On Fri, Feb 01, 2002 at 11:24:16AM -0800, Adam McKenna wrote:
> Now top, on the other hand, has a very different idea about the amount of
> free memory:
> CPU states:  0.0% user,  0.1% system,  0.1% nice,  0.0% idle
> Mem:  5528464K av, 5523484K used,   4980K free,      0K shrd,    340K buff
> Swap: 2939804K av, 1082008K used, 1857796K free                5351892K
> cached

They actually agree. The line you're reading with 5.3GB in it subtracts
kernel caches from the memory in use.

The fun bit about swapping like mad is because kernel caches are not
being flushed and shrunk properly in response to growth of the working
set. In more concrete terms, the kernel is making decisions which prefer
to keep things like the page cache, the dentry cache, the inode cache,
and the buffer cache in memory over the working sets of your programs.
There is some tradeoff: it is probably also not desirable to allow the
working set to erode kernel caches to the absolute minimum (or at least
not very easily), but obviously what tradeoffs are happening here are
suboptimal for your workload (and generally insufficiently adaptive). It
appears that when the kernel caches are done with you you've got 172MB
out of 5.5GB of physical memory left for your programs' anonymous memory.

What kernel/VM are you using?
Could you follow up with /proc/slabinfo and /proc/meminfo?


Cheers,
Bill
