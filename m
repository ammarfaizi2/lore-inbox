Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289214AbSA1P22>; Mon, 28 Jan 2002 10:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289218AbSA1P2V>; Mon, 28 Jan 2002 10:28:21 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:25184 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289214AbSA1P2I>; Mon, 28 Jan 2002 10:28:08 -0500
Date: Mon, 28 Jan 2002 16:29:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre4aa1
Message-ID: <20020128162916.B1309@athlon.random>
In-Reply-To: <20020124002342.A630@earthlink.net> <E16ToWW-0002mf-00@starship.berlin> <20020125010907.D25170@athlon.random> <E16V8Te-00008L-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E16V8Te-00008L-00@starship.berlin>; from phillips@bonn-fries.net on Mon, Jan 28, 2002 at 10:53:25AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2002 at 10:53:25AM +0100, Daniel Phillips wrote:
> On January 25, 2002 01:09 am, Andrea Arcangeli wrote:
> > On Thu, Jan 24, 2002 at 07:27:43AM +0100, Daniel Phillips wrote:
> > > On January 24, 2002 06:23 am, rwhron@earthlink.net wrote:
> > > > Benchmarks on 2.4.18pre4aa1 and lots of other kernels at:
> > > > http://home.earthlink.net/~rwhron/kernel/k6-2-475.html
> > > 
> > >   "dbench 64, 128, 192 on ext2fs. dbench may not be the best I/O 
> > >   benchmark, but it does create a high load, and may put some pressure on 
> > >   the cpu and i/o schedulers. Each dbench process creates about 21 
> > >   megabytes worth of files, so disk usage is 1.3 GB, 2.6 GB and 4.0 GB 
> > >   for the dbench runs. Big enough so the tests cannot run from the 
> > >   buffer/page caches on this box."
> > > 
> > > Thanks kindly for the testing, but please don't use dbench any more for 
> > > benchmarks.  If you are testing stability, fine, but dbench throughput 
> > > numbers are not good for much more than wild goose chases.
> > > 
> > > Even when mostly uncached, dbench still produces flaky results.
> > 
> > this is not enterely true. dbench has a value.
> 
> Yes, but not for benchmarks.  It has value only as a stability test - while 
> it may in some cases provide some general indication of performance, its 
> variance is far too large, even under controlled conditions, for it to have 
> any value as a benchmark.  I'm surprised you'd even suggest this.
> 
> Andrea, please, if we want good benchmarks let's at least be clear on what 
> tools benchmarkers should/should not be using.
> 
> > the only problem with
> > dbench is that you can trivially cheat and change the kernel in a broken
> > way, but optimal _only_ for dbench, just to get stellar dbench numbers,
> 
> No, this is not the only problem.  DBench is just plain *flaky*.  You don't
> appear to be clear on why.  In short, dbench has two main flaws:
> 
>   - It's extremely sensitive to scheduling.  If one process happens to make
>     progress then it gets more heavily cached and its progress becomes even
>     greater.  The benchmark completes much more quickly in this case, whereas
>     if all processes progress at nearly the same rate (by chance) it runs
>     more slowly.
> 
>   - It can happen (again by chance) that dbench files get deleted while still
>     in cache, and this process completes in a fraction of the time that real 
>     disk IO would require.
> 
> I've seen successsive runs of dbench *under identical conditions* (that is, 
> from a clean reboot etc.) vary by as much as 30%.  Others report even greater 
> variance.  Can we please agree that dbench is useless for benchmarks?

I never seen it to vary 30% on the same kernel.

Anyways dbench tells you mostly about elevator etc... it's a good test
to check the elevator is working properly, the ++ must be mixed with the
dots etc... if the elevator is aggressive enough. Of course that means
the elevator is not perfectly fair but that's the whole point about
having an elevator. It is also an interesting test for page replacement,
but with page replacement it would be possible to write a broken
algorithm that produces good numbers, that's the thing I believe to be
bad about dbench (oh, like tiotest fake numbers too of course). Other
than this it just shows rmap12a has an elevator not aggressive enough
which is probably true, I doubt it has anything to do with the VM
changes in rmap (of course rmap design significant overhead is helping
to slow it down too though), more likely the bomb_segments logic from
Andrew that Rik has included, infact the broken page replacement that
lefts old stuff in cache if something might generate more unfairness
that should generate faster dbench numbers for rmap, but on this last
bit I'm not 100% sure (AFIK to get a fast dbench by cheating with the vm
you need to make sure to cache lots of the readahead as well (also the
one not used yet), but I'm not 100% sure on the effect of lefting old
pollution in cache rather than recycling it, I never attempted it).

Andrea
