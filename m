Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311925AbSCTS1R>; Wed, 20 Mar 2002 13:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311921AbSCTS1H>; Wed, 20 Mar 2002 13:27:07 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:51516 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311934AbSCTS0y>; Wed, 20 Mar 2002 13:26:54 -0500
Date: Wed, 20 Mar 2002 19:26:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scalability problem (kmap_lock) with -aa kernels
Message-ID: <20020320192625.H4268@dualathlon.random>
In-Reply-To: <20020320173959.F4268@dualathlon.random> <Pine.LNX.4.44L.0203201437190.2181-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 02:41:14PM -0300, Rik van Riel wrote:
> Going for a smaller pool just doesn't make sense if you want
> the mappings to be cached, it could even result in more processes
> _sleeping_ on kmap entries to be freed.

256 simultaenous kmaps isn't that small, you need 256 task page faulting
simultaneously to get any of them sleeping, the bigger problem is the
frequency of the IPI and the reduced cache I think, not the
"_sleeping_". Infact it isn't much slower either. I had a feeling that
256 entreis was a kind of low-limit number to make persistent kmaps
still useful, even if I known it was a bit underpowered, but I needed to
check that it wasn't the O(N) pass hurting.

What I was worried about by seeing such long kmap_high time is that with
lots of concurrent tasks faulting, most of the entries were pinned most
of the time and so the pkmap pass had to be run much more frequently
and in a less useful manner, than on a system where the frequency of the
kmaps is high, but where the simultaneous kmaps aren't frequent.

Of course 2048 entries is better from a caching and tlb flushing
prospective (even if the O(N) pass takes more time), not incidentally I
was using 1024 instead of 128 :). (note that mainline only has 512 with
PAE, this is another reason for which I asked to try with 256)

> Please make a choice, do you want kmaps to be cached or would
> you be content to have just cpu-local or maybe process-local
> kmaps and get rid of the global kmap pool ?

One design idea I had to avoid the locking in the persistnt kmaps around
the copy-user, is to rewrite completly the persistnt code with a pool of
atomic kmaps per-CPU and to pin the task to the current CPU before doing
the copy-user, and then to count the number of reentrant persistent
kmaps happening in the current CPU and if it overflows we block waiting
somebody else to be wakenup and to kunmap.  pros: it would avoid all the
locks (complete scalability, all per-cpu), it would avoid the IPI and
the global flush. cons: it will possibly waste some more address space
since not all NR_CPUS are going to be used in all machines, and it will
not be able to do any caching, so page->virtual can be dropped enterely
in x86 then, and it will reduce the ability of the scheduler to
reschedule in idle cpus during copy users around persistent kmaps. And
of course those kmaps should be dropped ASAP, they are meant only for
things like copy-users, or we risk to pin stuff in cpus, it should be
always the scheduler, not the kmap that chooses which cpu the task has
to run on after a wakeup.

And again, such reasoning and the above idea is very-high-end
scalability oriented, a 1G laptop would prefer the current persistent
kmaps, possibly also running invlpg during the O(N) pass instead of the
global tlb flush (we can't do that in SMP because it would take too long
to run such pass in all cpus, so we've to IPI a global flush instead).
And in turn I'm not going to make any change like this in 2.4, it simply
isn't important enough for the 90% of userbase, I will just limit to
avoid persistent kmaps in pte-highmem that is doable without any pain.

btw, this thread is been very useful to learn about some of the timings
and the problematics on the 16-ways NUMA-Q.

comments?

Andrea
