Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310598AbSCLL3U>; Tue, 12 Mar 2002 06:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310561AbSCLL3L>; Tue, 12 Mar 2002 06:29:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24078 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310552AbSCLL3F>;
	Tue, 12 Mar 2002 06:29:05 -0500
Date: Tue, 12 Mar 2002 11:29:00 +0000
From: wli@holomorphy.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020312112900.A14628@holomorphy.com>
Mail-Followup-To: wli@holomorphy.com, Andrea Arcangeli <andrea@suse.de>,
	wli@parcelfarce.linux.theplanet.co.uk,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
	phillips@bonn-fries.net
In-Reply-To: <20020312041958.C687@holomorphy.com> <20020312070645.X10413@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Description: brief message
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020312070645.X10413@dualathlon.random>; from andrea@suse.de on Tue, Mar 12, 2002 at 07:06:45AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 01:22:39AM +0100, Andrea Arcangeli wrote:
>>> The result is that it exploits most of the random input, and physically
>>> consecutive pages are liekly to use the same cacheline in case there is
>>> some pattern. That looks a good algorithm to me.

On Tue, Mar 12, 2002 at 04:19:58AM +0000, wli@parcelfarce.linux.theplanet.co.uk wrote:
>> I'm sorry, this reasoning is too flawed to address in detail. I'm a

On Tue, Mar 12, 2002 at 04:19:58AM +0000, wli@parcelfarce.linux.theplanet.co.uk wrote:
> Well, that's the same reasoning behind the hashfn that everybody using
> linux computes at every read syscall. I didn't invented it, I only told
> you what's the reasoning behind it.

I maintain that this reasoning is fallacious and that the results are
suboptimal. The argument is by authority and the results I have measured.


On Tue, Mar 12, 2002 at 07:06:45AM +0100, Andrea Arcangeli wrote:
> btw, some year back also Chuck Lever did an very interesting extensive
> research on hashing and he just evaluated the multiplicative hash
> method.

I cited Chuck Lever in my comments.


On Tue, Mar 12, 2002 at 07:06:45AM +0100, Andrea Arcangeli wrote:
> The critical thing that araised from Chuck's extensive research on the
> hashes is been the dynamic sizing of the hashes as boot. the hashfn
> weren't changed. If we could have exploited a huge performance
> optimization and if the current hashfn would been flawed how could you
> explain that the hashfn are still unchanged? Because Linus dropped the
> email with the patches and those emails weren't resent? Then why didn't
> somebody piked them up in a different benchmark tree?

The pagecache hash function and the inode cache hash functions don't pass
statistical tests and performance improvements from using hash functions
that do are demonstrable.


On Tue, Mar 12, 2002 at 07:06:45AM +0100, Andrea Arcangeli wrote:
> Said that I agree that for the pagecache hash, there could be
> interesting patterns in input. If the inodes are allocated at nearly the
> same time after boot, and you work on large files, then you'll likely
> generate lots of collisions that may be avoided by the multiplicatve
> hash. So it's not optimal for the big files handling only a few inodes.

-ESPECULATION

Q(chi^2|nu), the probability that a uniform distribution would give
rise to such measured distributions by chance, is vanishingly small for
the pagecache hash functions. I have measured this in various scenarios,
and am attempting to gather enough information to compute statistical
correlations between benchmarks and statistical tests for the
uniformity of the distribution across buckets in addition to statistical
properties of the bucket distributions themselves.


On Tue, Mar 12, 2002 at 07:06:45AM +0100, Andrea Arcangeli wrote:
> But note that this email thread is about the wait_table hash, not the
> pagecache hash, they're two completly different beasts, even if the
> reasoning behind them is the same one.

Not really. The pagecache hash function proved itself so poor in the
pagecache setting it was not a worthwhile candidate.


On Tue, Mar 12, 2002 at 04:19:58AM +0000, wli@parcelfarce.linux.theplanet.co.uk wrote:
>> programmer, not a schoolteacher. I'll drop a hint: "randomness" is not

On Tue, Mar 12, 2002 at 07:06:45AM +0100, Andrea Arcangeli wrote:
> I studied the multiplicative hashes (i recall the div method) in
> Introduction to Algorithms and what I think about them is that those
> hashfns are been designed to work well in presence of non random
> patterns in input. One example of an hashfn in linux that doesn't get
> significantive random input, is the buffer cache hash.  That's indexed
> by offset and the blkdev. the blkdev is just fixed, no matter if it's a
> pointer or a major/minor. The offset will definitely have huge patterns
> that can lead to bad distribution (just like the "offset" in the
> pagecache hash). I recall Chuck noticed that, and infact the hashfn of
> the buffercache is the only one that I'm sure it's been replaced because
> it was bad.

CLR's mention of multiplicative hashing is little more than a citation
of Knuth with a brief computation of a bucket index (using floating
point arithmetic!) for an example. The div method is in the section
immediately preceding it and is described as slot = key % tablesize.


On Tue, Mar 12, 2002 at 07:06:45AM +0100, Andrea Arcangeli wrote:
> See what it become now:
> #define _hashfn(dev,block)	\
> 	((((dev)<<(bh_hash_shift - 6)) ^ ((dev)<<(bh_hash_shift - 9))) ^ \
> 	 (((block)<<(bh_hash_shift - 6)) ^ ((block) >> 13) ^ \
> 	  ((block) << (bh_hash_shift - 12))))

I've actually measured the distributions of entries across buckets
resulting from this hash function and it has impressive statistical
properties. Fibonacci hashing falls flat on its face for the bcache,
which seems to be at variance with your sequential input assertion,
as that appears to be one of Fibonacci hashing's specialties (behold
ext2 inode number allocation).


On Tue, Mar 12, 2002 at 07:06:45AM +0100, Andrea Arcangeli wrote:
> For the pagecache hashfn similar collisions can happen with big files and
> only a few inodes allocated right after boot. The current pagecache hash
> is optimal on the small files, like simultaneous kernel compile + kde
> compile + gcc compile etc....

-ESPECULATION

The pagecache hash function has never passed a single statistical test
that I've put it through. Q(chi^2|nu) < 10**-200 etc. is typical.


On Tue, Mar 12, 2002 at 07:06:45AM +0100, Andrea Arcangeli wrote:
> Also note that one thing that math doesn't contemplate is that it may be
> faster to handle more collisions on a hot L2/L1 cache, rather than not
> having collisons but to constantly run at the speed of the DRAM and the
> current hashes definitely cares a lot about this bit. I only see you
> looking at the distribution on the paper and  not at the access pattern
> to memory and cache effects.

I'll humor you for a moment but point out that L2/L1 cache misses are
considerably cheaper than scheduling storms. Furthermore, the kinds of
proof you'd to establish this sort of assertion for ordinary bucket
disciplines appears to involve reading profiling registers to count
cache misses or perhaps tracing bus accesses using logic analyzers, or
simulation logging, which I doubt have been done.


On Tue, Mar 12, 2002 at 07:06:45AM +0100, Andrea Arcangeli wrote:
> But anyways we're not talking about the pagecache has here, the
> randomness of the input of the wait_table isn't remotely comparable to
> the randomness of the input of the pagecache hash: after load the free
> pages in the freelists will become completly random, and if there's a
> probability, the probability is that they're contigous (for example when
> a kernel stack gets released for example, and two page of pagecahce gets
> allocated while reading a file, and then we wait on both, and we want
> both waitqueues in the same cacheline). It's not like with the
> pagecacache that you can artificially generate collisions easily by
> working on big files with two inodes allocated right after boot.  Here
> the pages are the random input and we can't ask for something better in
> input for an hashfn.

This is pure speculation. Would you care demonstrate these phenomena by
means of tracing methods, e.g. simulator traces or instrumentation code?

My personal opinion on these sorts of assertions is that they are highly
workload dependent and involve interactions with the policies of the slab
and physical allocators with usage patterns, architectural formatting of
virtual addresses, and physical and virtual memory layouts, which in my
mind are complex enough and vary enough they are best modeled with
statistical and empirical methods.


On Tue, Mar 12, 2002 at 07:06:45AM +0100, Andrea Arcangeli wrote:
> If you assume a pure random input, I don't see how can you distribute it
> better with a simple mul assembler instruction. That's my whole point.
> Now if intuition doesn't work here, and you need a complex math
> demonstration to proof it, please give post a poiner to a book or
> pubblication and I will study it, I definitely want to understand how
> the hell could a "mul" distribute better a pure random input because
> intuitions tells me it's not possible.

A random variable could have a distribution concentrated at a single
point (which would defeat any hashing scheme). You need to revise your
terminology at the very least.

I'd also love to hear what sort of distribution you believe your random
input variable to have, and measurements to compare it against.

For specific reasons why multiplication by a magic constant (related to
the golden ratio) should have particularly interesting scattering
properties, Knuth cites Vera Turán Sós, Acta Math. Acad. Sci. Hung. 8
(1957), 461-471; Ann. Univ. Sci. Budapest, Eötvös Sect. Math 1 (1958),
127-134, and gives further details in exercises 8 and 9 in section 6.4,
TAOCP vol. 2 (2nd ed.). There are also some relevant lemmas around for
the connoisseur.

I don't take this to mean that Fibonacci hashing is gospel.
In my mind the advantages are specifically:
(1) the search process for good hash functions may be guided by sieving
(2) there is a comprehensible motivation behind the hashing scheme
(3) the hash functions actually pass the statistical tests I run
(4) they provide demonstrable benefits for the tables I use them in

Now, the proofs as they are carried out appear to involve sequential
natural numbers, yet one should notice that this is *not* a finite
process. Hence, it makes an assertion regarding all of the natural
numbers simultaneously, not sequential insertions.


On Tue, Mar 12, 2002 at 07:06:45AM +0100, Andrea Arcangeli wrote:
> from the graphs it seems the "before" had 250000 buckets, and the
> "after" had 8 million buckets. Is that right? Or were all the other
> 8millions - 250000 buckets unused in the "before" test, if yes, then you
> were definitely not monitorning a misc load with small files, but of
> course for such a kind of workload the fibonacci hashing would very well
> be better than the current pagecache hash, I completly agree. the
> "after" graph also shows the hash is sized wrong, that's because we're
> not using the bootmem allocator, Dave has a patch for that (but it's
> highmem-not-aware still). btw, it's amazing that the hash is almost as
> fast as the radix tree despite the fact the hash can at max be 2M in
> size currently, on a >=4G box you really need it bigger or you'll be
> guaranteed having to walk a bigger depth than the radix tree.

What you're noticing here is what I actually pointed you at was "before"
and "after" for pagecache alloc in bootmem. I don't actually know where
anton's comparisons for my Fibonacci hashing functions vs. that are,
and probably won't hear until hacker hours resume in .au

I will either sort out the results I have on the waitqueues or rerun
tests at my leisure.

Note I am only trying to help you avoid shooting yourself in the foot.


Cheers,
Bill
