Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbTBTMc4>; Thu, 20 Feb 2003 07:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbTBTMcs>; Thu, 20 Feb 2003 07:32:48 -0500
Received: from octopussy.utanet.at ([213.90.36.45]:45020 "EHLO
	octopussy.utanet.at") by vger.kernel.org with ESMTP
	id <S265305AbTBTMaZ>; Thu, 20 Feb 2003 07:30:25 -0500
Date: Thu, 20 Feb 2003 13:40:27 +0100
From: Dejan Muhamedagic <dejan@hello-penguin.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm issues on sap app server
Message-ID: <20030220124026.GA4051@lilith.homenet>
Reply-To: Dejan Muhamedagic <dejan@hello-penguin.com>
References: <20030219171432.A6059@smp.colors.kwc> <20030219180523.GK14633@x30.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219180523.GK14633@x30.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

On Wed, Feb 19, 2003 at 07:05:24PM +0100, Andrea Arcangeli wrote:
> On Wed, Feb 19, 2003 at 05:14:32PM +0100, Dejan Muhamedagic wrote:
> > 
> > Both servers swap constantly, but the 2.4.20aa1 at a 10-fold
> > higher rate.  OTOH, there should be enough memory for
> > everything.  It seems like both VMs have preference for
> > cache.  Is it possible to reduce the amount of memory used
> > for cache?
> 
> yes:
> 
> 	echo 1000 >/proc/sys/vm/vm_mapped_ratio
> 
> this controls how hard the vm will try to shrink the cache before
> starting swapping/unmapping activities.

Today the swapping rate went up compared to yesterday.  So much
that it made a serious impact on performance.  The server has been
up for four days and the more the time passes the less it is
capable of handling the load.  I tried changing the
vm_mapped_ratio as you suggested, but the cache use is still very
high:

Cached:        2292156 kB
SwapCached:    2770440 kB

I must ask for an explanation of the latter item.  Is that swap
being cached?  If so, why?  AFAIK, if a page is swapped out and
later (soon) referenced again then the system is in a need of more
memory or the VM didn't predict well.  The latter case should occur
infrequently.  In the former no clever piece of software would help
anyway.  So, why cache swap?

elvtune gives:

/dev/sda elevator ID            2
        read_latency:           128
        write_latency:          512
        max_bomb_segments:      0

Which seems fine to me.  Anyway, with this much swapping (100-800Kpps)
it won't help.  I'll do some testing later with file transfer.

> 2.4.21pre4aa3 has also extreme scalability optimizations that generates
> three digits percent improvements on some hardware, however those won't
> help latency directly. These optimizations will also change partly when
> the vm starts swapping, and it will defer the "swap" point somehow, this
> new behaviour (besides the greatly improved scalability) is also
> beneficial to very shm-userspace-cache intensive apps.

It is exactly the case here:

# df /dev/shm
Filesystem           1k-blocks      Used Available Use% Mounted on
shmfs                 16384000   5798364  10585636  36% /dev/shm

> You can revert to
> the non-scalable behaviour (but possibly more desiderable on small
> desktop/laptops) by using echo 1 >/proc/sys/vm/vm_anon_lru. You should
> also try 'echo 1 >/proc/sys/vm/vm_anon_lru' if you see the VM isn't
> swapping well enough and that it shrinks too much cache after upgrading
> to 2.4.21pre4aa3.

I hope I will be able to give this one a try.

> Thanks for the interesting feedback!

Thank you for your input.

Cheers!

Dejan
