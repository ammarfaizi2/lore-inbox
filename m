Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265337AbRGJBH3>; Mon, 9 Jul 2001 21:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265334AbRGJBHU>; Mon, 9 Jul 2001 21:07:20 -0400
Received: from sciurus.rentec.com ([192.5.35.161]:40617 "EHLO
	sciurus.rentec.com") by vger.kernel.org with ESMTP
	id <S265311AbRGJBHJ>; Mon, 9 Jul 2001 21:07:09 -0400
Message-ID: <3B4A5568.6CC9562F@rentec.com>
Date: Mon, 09 Jul 2001 21:07:52 -0400
From: Dirk <dirkw@rentec.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: dead mem pages -> dead machines
In-Reply-To: <Pine.LNX.4.10.10107092147570.25585-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Hahn wrote:

> >  3759  3684 userid    15 2105M 1.1G 928M  254M  0M R N  94.4 23.4  10:57 ceqsim
> >  3498  3425 userid    16 2189M 1.5G 609M  205M  0M R N  91.7 15.3  22:12 ceqsim
>
> do you have any control over the size of these processes?
> with 4G ram, it makes more sense to have them sum to ~3.5G.

i can only allocate 3GB if i use doug lea's malloc, that's a thing in glibc
which hasn't been addressed yet. under normal use of malloc() me
apps only get 2GB per process.
for 3.5 GB i would have to use the patch from aa, posted a couple of months ago.
i am using for the farm a plain vanilla 2.4.[56] to keep things simple first.

no, the typical job has beween 1GB and 3GB in memory. they are independent,
just some number crunchung on farm CPUs.

> > MemTotal:      4058128 kB
> > MemFree:          6832 kB
> > MemShared:           0 kB
> > Buffers:          3152 kB
> > Cached:        2871388 kB
> > Active:        1936040 kB
> > Inact_dirty:    499780 kB
> > Inact_clean:    438720 kB
> > Inact_target:     3080 kB
> > HighTotal:     3211200 kB
> > HighFree:         3988 kB
> > LowTotal:       846928 kB
> > LowFree:          2844 kB
> > SwapTotal:    14337736 kB
> > SwapFree:     10957560 kB
> >
> >
> > machine018:~ # cat /proc/swaps
> > Filename                        Type            Size    Used    Priority
> > /dev/sda5                       partition       2048248 2048248 -1
> > /dev/sdb1                       partition       2048248 1331928 -2
> > /dev/sdc1                       partition       2048248 0       -3
>
> they should all have the same priority, so swapping is distributed.
> currently sda5 fills (and judging by the 5, it's not on the fast
> part of the disk) before sdb1 is used.

well, that's the symptom, but not the disease, medically speaking.

the idea was not swapping to the data disks (which are sdb and sdc)
in the first place.

> > why does the kernel have 2.8GB of cached pages, and our applications
>
> afaik, cached doesn't exclude your apps' pages.

i am in this typical example 2.6GB in swap. where did all my precious memory
go?

> > have to swap 1.5+1.1GB of pages out? also, i do not understand why
> > the amount of inactive pages is so high.
>
> the kernel thinks that there's memory pressure: perhaps you're doing
> file IO?  memory pressure causes it to pick on processes, especially
> large ones, especially the ones that are doing the allocation.

also if i do file i/o, i don't expect the kernel to take away so much memory from
my apps. file caching (or whatever "cached" in /proc/cpuinfo means, is there
a doc btw?) should be a courtesy and not a torture for the performance of app.

> > not to mention, that the moment the machine is swapping pages out
> > in the order of gigabytes, the console even doesn't respond and
>
> from appearances, you've overloaded it.  the kernel also tries to be
> "fair", which in this case means trying to steal pages from the hogs.

it looks to me that the hog is the kernel, and the kernel isn't fair to me, again:

  PID  PPID USER     PRI  SIZE SWAP  RSS SHARE   D STAT %CPU %MEM   TIME COMMAND
 3759  3684 userid    15 2105M 1.1G 928M  254M  0M R N  94.4 23.4  10:57 ceqsim
 3498  3425 userid    16 2189M 1.5G 609M  205M  0M R N  91.7 15.3  22:12 ceqsim
                                   ^^^^^^^ ^^^^

normally if i monitor the farm, i also do a "ps alx" and do a total over the RSS and
VSZ,
which tells something about the memory consumption in user space. in my initial
posting i
forgot to mention this number. just add ~100MB and ~200MB respectively. so from
the user space or application perspective the kernel still eats my memory.

what's wrong and what can i do to help people to help me?


thx,
        ~dirkw


