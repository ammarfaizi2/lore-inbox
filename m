Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312523AbSCTM3Z>; Wed, 20 Mar 2002 07:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312524AbSCTM3P>; Wed, 20 Mar 2002 07:29:15 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:10847 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312523AbSCTM26>; Wed, 20 Mar 2002 07:28:58 -0500
Date: Wed, 20 Mar 2002 13:30:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scalability problem (kmap_lock) with -aa kernels
Message-ID: <20020320133036.B4268@dualathlon.random>
In-Reply-To: <20020320024008.A4268@dualathlon.random> <221408128.1016576129@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 10:15:30PM -0800, Martin J. Bligh wrote:
> > If you have PIII cpus pre3 mainline has a bug in the machine check code,
> > this one liner will fix it:
> 
> Thanks - that'll probably save me a bunch of time ... 
> 
> May I assume, for the sake of discussion, that there's not much 
> difference between pre1-aa1 and your latest stuff in the area we're 
> talking about here?
> 
> > One thing I see is not only a scalability problem with the locking, but
> > it seems kmap_high is also spending an huge amount of time in kernel
> > compared to the "standard" profiling.  
> 
> One other wierd thing to note in the profiling is that kunmap_high
> is way up in the profile as well - seeing as kunmap_high doesn't
> do the same sort of scanning as kmap_high, it shouldn't be O(N).
> I'm wondering if somehow the profiling attributes some of the spinning
> cost to the calling function. Pure speculation, but there's defintely
> something strange there ....

Yep. What's the profile buffer size? Just make sure to boot with
profile=2 so you'll have a quite accurate precision.

> > That maybe  because I increased
> > too much the size of the pool (the algorithm is O(N)). Can you try 
> > again with this incremental patch applied?
> 
> Sure ... will retest. But by shrinking the size of the pool back down, 
> won't you just increase the number of global tlbflushes? Any way you 

Yes.

> I appreciate the scanning doesn't scale well, but is the pte-highmem
> stuff the cause of the increase of kmap frequency? There seems to be
> both a frequency and duration problem.

the frequency is higher during a kernel compile due the pte-highmem, but
if you just change the workload and you start 16 tasks simultaenous
reading from a file in cache, you will get the same very frequency no
matter of pte-highmem or not. What you found is a scalability issue with
the persistent kmaps, not introduced by pte-highmem (however with
pte-highmem I have increased its visibility due the additional
usages of the persistent kmaps for certain pte intensive workload and
with a larger pool to scan).

> still need to do a kmap for the pagecache situation you mention?

of course yes. bounce buffers are completly transparent with the
pagecache layer.  The very same persistent kmap that is hurting you with
the pagetable handling is happening also in every generic_file_read/write,
it will happen even if you are using ramfs that doesn't do any I/O at
all.

> OK, I guess we're back to the question of whether a local tlb_flush_one
> per kmap is cheaper than a global tlb_flush_all once per LAST_PKMAP 
> kmaps. Not just in terms of time to execute, but in terms of how much
> we slow down others by trashing the cache ... I guess that's going to
> be tough to really measure.

On a 16-way considering all cpus will hit the mem bus to re-read all the
pagetables at the very same time plus there will be an IPI flood to 16
cpus, so depending on the design of your hardware it may be bad. More
cpus also means a potential much higher kmap frequency. So I'm pretty
sure for NUMA-Q you don't want the persistent kmaps in pagetables and in
pagecache. Persistent kmaps aren't meant to scale, they're meant to
optimize the more common x86 machines (also UP with say 1G of ram) and
to make the kernel code dealing with highmem simpler and more readable.
Those are the very same reasons I'm using the persistent kmaps in
pte-highmem indeed. But on a 16-way you have different scalability needs
for both pagecache and pagetables.

BTW, I would also clarify that it's not that I never checked any
number/profiling of high end systems yet with pte-highmem, it's just
that your hardware and your workload has to be quite different from the
one where pte-highmem is been developed for.  The workloads that were
running out of pagetables due the too many tasks mapping the same 512M
SGA, didn't show any bottleneck in the persistent kmap during the
profiling.

> It would be nice to be able to compare the two different kmap approaches
> against each other - AFAIK, the 2.5 implementation isn't available for 
> 2.4 to compare though ... if your stuff is easy to change over to 
> atomic_kmap, I'd be happy to compare it (unless shrinking the pool size
> fixes it, in which case we're done).

Correct. If shrinking the pool doesn't make significant difference (for
example it may be acceptable if it would reduce the level of overhead
to the same one of lru_cache_add in the anonymous memory page fault that
you also don't want on a NUMA-Q just for kernel compiles without the
need of swapout anything) I can very easily drop the persistent kmap
usage from my tree so you can try that way too (without adding the
kernel pagetables in kernel stuff in 2.5 and without dropping the
quicklist cpu affine cache like what happened in 2.5).

BTW, before I drop the persistent kmaps from the pagetable handling you
can also make a quick check by removing __GFP_HIGHMEM from the
allocation in mm/memory.c:pte_alloc_one() and verifying the kmap_high
overhead goes away during the kernel compiles (that basically disables
the pte-highmem feature).

> Thanks for taking the time to explain all of this - I have a much 
> better idea what's going on now. I'll get you the new numbers tommorow.

You're welcome. Thanks to you to help fixing very-high-end scalability
problems in my tree.

Andrea
