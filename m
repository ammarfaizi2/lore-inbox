Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315625AbSECK3p>; Fri, 3 May 2002 06:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315626AbSECK3o>; Fri, 3 May 2002 06:29:44 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:35672 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315625AbSECK3o>; Fri, 3 May 2002 06:29:44 -0400
Date: Fri, 3 May 2002 12:30:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020503123009.P11414@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <3972036796.1020330599@[10.10.2.3]> <20020502184037.J11414@dualathlon.random> <20020502171655.GJ32767@holomorphy.com> <20020502204136.M11414@dualathlon.random> <20020502191903.GL32767@holomorphy.com> <20020503080433.R11414@dualathlon.random> <20020503092426.GH24506@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 02:24:26AM -0700, William Lee Irwin III wrote:
> 64GB machines are not new. NUMA-Q's original OS (DYNIX/ptx) must have
> been doing something radically different, for it appeared to run well
> there, and it did so years ago. The amount of data actually required to

Did you ever benchmarked DYNIX/ptx against Linux on a 64bit machine or
on a 4G x86 machine? Special changes to deal with the small KVA as said
are possible but they will have to affect performance somehow. One way
to reduce the regression on the normal 32bit machines could be to take
the special actions like putting the mem_map in highmem only dependent
on the amount of ram (there would be still the branches for every access
of a page structure, at least unless you take the messy self modifying code
way).

> The answer I seem to hear most often is "get a 64-bit CPU".
> 
> But I believe it's fully possible to get the larger highmem systems to
> what is very near a sane working state and feed back to mainline a good
> portion of the less invasive patches required to address fundamental
> stability issues associated with highmem, and welcome any assistance
> toward that end.

The stability should be just complete in current -aa, it's just the
performance that won't be ok. If you want more cache, larger hashes,
more skb etc... you'll need to pay with something else that would then
only hurt on a 64bit arch or on a smaller box then.

> What is likely the more widely beneficial aspect of this work is that
> it can expose the fundamental stability issues of the highmem
> implementation very readily and so provide users of more common 32-bit
> highmem systems a greater degree of stability than they have previously
> enjoyed owing to kva exhaustion issues.

Agreed, infact if somebody can test current -aa on a 64G x86 box I'd be
glad to hear the results. It should just work stable, at least as far as
the VM is concerned (mainline should have some problem instead), except
it will probably return -ENOMEM on mmap/open/etc.. after you finish
normal_zone, and there can be packet loss too, but that's expected
(CONFIG_2G will make it almost completly usable on the kernel side, but
reducing userspace). The important thing is that it never deadlocks or
malfunction with CONFIG_3G.

> Well, this is certainly not the case with other OS's. The design
> limitations of Linux' i386 memory layout, while they now severely

I see it's limited for your needs on a 64G box, but "limited" looks like
"weak", while it's really the optimal design for 64bit archs and normal
32bit machines.

> hamper performance on NUMA-Q, are a tradeoff that has proved
> advantageous on other platforms, and should be approached with some
> degree of caution even while Martin Bligh (truly above all others),
> myself, and others attempt to address the issues raised by it on NUMA-Q.
> But I believe it is possible to achieve a good degree of virtual
> address space conservation without compromising the general design,
> and if I may be so bold as to speak on behalf of my friends, I believe
> we are willing to, capable of, and now exercising that caution.

Putting the mem_map in highmem would be the first step, after that you
should be just at at the 90% of work done to make it general purpose,
you should wrap most actions on the page struct with wrappers and it
will be quite an invasive change (much more invasive than pte-highmem),
but it could be done. For this one (unlike pte-highmem) you definitely
need a config option to select it, most people doesn't need this feature
enabled because they've less than 8G of ram and also considering it will
have a significant runtime cost.

> On Thu, May 02, 2002 at 12:19:03PM -0700, William Lee Irwin III wrote:
> >> Absolutely; I'd be very supportive of improvements for this case as well.
> >> Many of the systems with the need for discontiguous memory support will
> >> also benefit from parallelizations or other methods of avoiding references
> >> to remote nodes/zones or iterations over all nodes/zones.
> 
> On Fri, May 03, 2002 at 08:04:33AM +0200, Andrea Arcangeli wrote:
> > I would suggest to start on case-by-case basis looking at the profiling,
> > so we make more complex only what is worth to optimize.  For example
> > nr_free_buffer_pages() I guess it will showup because it is used quite
> > frequently.
> 
> I think I see nr_free_pages(), but nr_free_buffer_pages() sounds very
> likely as well. Both of these would likely benefit from per-cpu
> counters.

nr_free_pages() actually could be mostly optimized out by setting
overcommit to 1 :), for the rest is used basically only for /proc/
stats, but yes, with overcommit to 0 (default) every mmap will take the
hit in nr_free_pages() so in most workloads it would be even more
frequent than nr_free_buffer_pages() (with the difference that
nr_free_buffer_pages cannot be avoided).

Andrea
