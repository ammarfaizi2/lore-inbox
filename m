Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbTDEQS3 (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 11:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbTDEQS3 (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 11:18:29 -0500
Received: from mail-5.tiscali.it ([195.130.225.151]:64064 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id S262513AbTDEQS0 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 11:18:26 -0500
Date: Sat, 5 Apr 2003 18:30:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030405163003.GD1326@dualathlon.random>
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405040614.66511e1e.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 04:06:14AM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@digeo.com> wrote:
> >
> > Nobody has written an "exploit" for this yet, but it's there.
> 
> Here we go.  The test app is called `rmap-test'.  It is in ext3 CVS.  See
> 
> 	http://www.zip.com.au/~akpm/linux/ext3/
> 
> It sets up N MAP_SHARED VMA's and N tasks touching them in various access
> patterns.

I'm not questioning during paging rmap is more efficient than objrmap,
but your argument about rmap having lower complexity of objrmap and that
rmap is needed is wrong. The fact is that with your 100 mappings per
each of the 100 tasks case, both algorithms works in O(N) where N is
the number of the pagetables mapping the page. No difference in
complexity.  I don't care how many cycles you spend to reach the 100x100
pagetables, those are fixed cycles, the fact is that there are 100x100
pagetables, rmap won't change the complexity of the algorithm at all,
that's mandated by the hardware and by your application, we can't do
better than O(N) with N the number of pagetables to unmap a single page.
Even rmap has the O(N) complexity, it won't be allowed to reach only 100
pagetables instead of 100000 pagetables. swapping isn't the important
path so it is extremely worthwhile to take fast all the other normal
workloads and the real important realistic benchmarks fast, and spend
more cpu into the swapping as far as it can be done with a non
exponential complexity.  And IMHO your rmap-test should be renamed as
the rmap-very-best-and-not-interesting-case, since that's the only
workload where rmap pays off, and objrmap is more than enough to satify
my complexity needs for the multigigabyte swapping and objrmap obviously
can't hurt the fast paths, becase we always had objrmap even in 2.4.
And objrmap can't avoided, it's needed for the truncate semantics
against mmap.

Check all other important benchmarks not testing the paging load like
page faults, kernel compile from Martin, fork, AIM etc... Those are IMHO
an order of magnitude of more interest than your rmap-test paging load
with some hundred thousand of vmas. The paging just needs to run with
linear complexity, and it's useful anyways to have objrmap to be able to
defragment ram, or to possibly do process migration of threads with
anonymous memory in a more friendy manner.

> vmm:/usr/src/ext3/tools> ./rmap-test 
> Usage: ./rmap-test [-hlrvV] [-iN] [-nN] [-sN] [-tN] filename
>      -h:          Pattern: half of memory is busy
>      -l:          Pattern: linear
>      -r:          Pattern: random
>      -iN:         Number of iterations
>      -nN:         Number of VMAs
>      -sN:         VMA size (pages)
>      -tN:         Run N tasks
>      -VN:         Number of VMAs to process
>      -v:          Verbose
> 
> The kernels which were compared were 2.5.66-mm4, 2.5.66-mm4+all objrmap
> patches and 2.4.21-pre5aa2.  The machine has 256MB of memory, 2.7G P4,
> uniprocessor, IDE disk.
> 
> 
> 
> 
> The first test has 100 tasks, each of which has 100 vma's.  The 100 processes
> modify their 100 vma's in a linear walk.  Total working set is 240MB
> (slightly more than is available).
> 
> 	./rmap-test -l -i 10 -n 100 -s 600 -t 100 foo
> 
> 2.5.66-mm4:
> 	15.76s user 86.91s system 33% cpu 5:05.07 total
> 2.5.66-mm4+objrmap:
> 	23.07s user 1143.26s system 87% cpu 22:09.81 total
> 2.4.21-pre5aa2:
> 	14.91s user 75.30s system 24% cpu 6:15.84 total
> 
> 
> 
> 
> 
> In the second test we again have 100 tasks, each with 100 vma's but the
> access pattern is random:
> 
> 	./rmap-test -vv -V 2 -r -i 1 -n 100 -s 600 -t 100 foo
> 
> 2.5.66-mm4:
> 	0.12s user 6.05s system 2% cpu 3:59.68 total
> 2.5.66-mm4+objrmap:
> 	0.12s user 2.10s system 0% cpu 4:01.15 total
> 2.4.21-pre5aa2:
> 	0.07s user 2.03s system 0% cpu 4:12.69 total
> 
> 
> The -aa VM failed in this test.
> 
> 	__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> 	VM: killing process rmap-test

I'll work on it. Many thanks. I wonder if it could be related to the
mixture of the access bit with the overcomplexity of the algorithm that
makes the passes over so many vmas useless. Certainly this workload
isn't common. I guess what I will try to do first is to simply ignore
the accessed bitflag after half of the passes failed. What do you think?

> I'd have to call this a bug - the machine was full of reclaimable
> memory.

If it's full of reclaimable memory it's definitely a bug and I need to
fix it ASAP ;).

> I also saw the 2.4 kernel do 705,000 context switches in a single second,
> which was odd.  It only happened once.

that could be the yelding paths in the getblk or ext3. Usually when you
see that it's the yielding not very good paths in the kernel. Probably
it's related to the oom anyways. Those paths won't fail, they'll just
loop forever until they succeed generating the overscheduling. Fixing
the oom should take care of them too. I don't worry about them at the
moment especially since you said it only happened once which confirms my
theory everything is fine and nothing is running out of control and it's
only a side effect of this workload that is folling the accessed bit
driving the box to a fake oom.

> These are not ridiculous workloads, especially the third one.  And 10k VMA's

the point is that you must be paging hard this stuff. This is what makes
it not very realistic. sure, 10k vmas are fine, but I prefer to run so
much faster in the fast paths, than to be able to swap them much faster.

> And as expected, the full rmap implementation gives the most stable,
> predictable and highest performance result under heavy load.  That's why
> we're using it.

and that's why the much more important fast paths suffers. I don't trade
some speedup in paging with the fast paths. 99% of users care about the
fast paths, or the paging in a laptop not under you special
best-case-rmap-test, which means pure swap bandwidth with a normal
number of vmas, no matter the cpu usage. Especially very high end smp
and PDA embedded usage definitely should avoid rmap and use objrmap IMHO
(those won't even need the anonymoys and shm information since they may
not have any swap at all, this definitely is the case of the PDA, so
objrmap is perfect for that and CONFIG_SWAP should exactly do that,
provide only objrmap for file mappings and leave anon ram pinned and
unknown by the vm).

Maybe I'm wrong but those are my current opinions on the matter ;)

Andrea
