Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSEWNFz>; Thu, 23 May 2002 09:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316617AbSEWNFy>; Thu, 23 May 2002 09:05:54 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:28405 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316609AbSEWNFx>;
	Thu, 23 May 2002 09:05:53 -0400
Date: Thu, 23 May 2002 18:38:35 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>,
        Paul McKenney <paul.mckenney@us.ibm.com>,
        lse-tech@lists.sourceforge.net
Subject: [RFC] Dynamic percpu data allocator
Message-ID: <20020523183835.E4714@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If static percpu area is around, can dynamic percpu data allocator
be far behind ;-)

As a part of scalable kernel primitives work for higher-end SMP
and NUMA architectures, we have been seeing increasing need
for per-cpu data in various key areas. Rusty's percpu area
work has added a way in 2.5 kernels to maintain static per-cpu
data. Inspired by that work, I have implemented a dynamic per-cpu
data allocator. Currently it is useful to us for -

1. Per-cpu data in dynamically allocated structures.
2. per-cpu statistics and reference counters
3. Per-cpu data in drivers/modules.
4. Scalable locking primitives like local spin only locks
   (or even big reader locks).

Included in this mail is a document that describes the allocator.
I would really appreciate if people comment on it. I am
particularly interested in eek-value of the interfaces,
specially the bit about keeping the type information in
a dummy variable in a union.

The actual patch will follow soon, unless someone convince
me quickly that there is an saner way to do this.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="percpu_data.txt"

                        Per-CPU Data Allocator
                        ----------------------

Interfaces
----------

The interfaces for per-cpu data allocator are similar to Rusty's static
per-CPU data interfaces. One clear goal was to make sure that they
leave no overhead in the UP kernels, so for UP kernels they
reduce to ordinary variables. The basic interfaces are these -

1. percpu_data_declare(type,var)
2. percpu_data_alloc(var)
3. percpu_data(var,cpu) 
4. this_percpu_data(var)
5. percpu_data_free(var)

For example, we can declare the following structure -

	struct yy {
		int a;
		percpu_data_declare(int, b);
		int c;
		int d;
	};

We can allocate memory for percpu int like this -

	struct yy y;

	if (percpu_data_alloc(y.b)) {
		/* Failed */
	}

To use it -
	
	cpu = smp_processor_id();
	percpu_data(y.b, cpu)++;

	or

	this_percpu_data(y.b)++;

To free the per-CPU data

	percpu_data_free(y.b);

The data declaration interface is a bit unnatural, but I can't think of
anything better that would let me preserve the type information for the
original variable so that appropriate typecasting can be done for other
interfaces. percpu_data_declare(type,var) expands to -

	union {
		percpu_data_t *percpu;
		typeof(type) realtype;
	} var

percpu_data_t maintains the pointers necessary to lookup the real
percpu data. 

	typedef struct {
		void *blkaddrs[NR_CPUS];
		struct percpu_data_blk *blkp;
	} percpu_data_t;

The type information is used (using typeof()) to
typecast data accesses. 

	#define percpu_data(var,cpu) \
			(*((typeof(var.realtype) *)var.percpu->blkaddrs[cpu]))

Using a pointer to percpu_data_t adds
an overhead of an additional memory reference while accessing
percpu data. This can be avoided by embedding the percpu_data_t
structure, but since percpu_data_t has an NR_CPUS array, it changes
structure sizes very radically. It is a tradeoff, we could go either
way.



Potential Uses
--------------

1. Scalable counters - they already use a scaled down version of the
allocator inside. Per-cpu counters can reduce the overhead of cacheline
bouncing.

2. Big reader lock - this need not be statically allocated anymore.

3. Per-CPU data in modules - the static per-cpu scheme by Rusty's
doesn't work in modules, atleast I haven't seen a way to do this.

4. Scalable locks - per-cpu data is commonly used in scalable locks
like MCS locks.



Allocator
---------

The current approach is that unless there is interest in a dynamic
percpu data allocator, there is no point in spending too much time
in writing a sophisticated. 

Allocation Policy
-----------------

1. If the allocation requests size is a factor of SMP_CACHE_BYTES,
then it will be interleaved to avoid fragmentation as much as possible.
If the request size is a multiple of SMP_CACHE_BYTES, fragmentation
will still be avoided. Anything else will result in fragmentation.
The current allocator doesn't make any attempt to use the fragmented
portion, in a sense it is like padding to cache line boundary.

2. A simple binary search tree is used to maintain the memory
objects (could be blocks of them) of different sizes. For 
interleaving, the objects are maintained in blocks and a freelist 
mechanism similar to the slab allocator is used within the blocks 
to allocates objects from within. Each block is allocated from kmem_cache.

If there is sufficient interest in the per-cpu data allocator,
then I will revisit the allocator and see if fragmentation can
be reduced for non-multiples/non-factors of SMP_CACHE_BYTES.

For non-factor allocations, the residual part of the cache-line
can be maintained and a best-factor-fit alogorithm can be used
to allocate this. This makes an assumption that kernel allocation
requests are likely to contain repetitive patterns of similar sizes.

Alignment Issues
----------------

The current alignment strategy is this -

1. Minimum allocation size is sizeof(int).
2. Each block is aligned to cache line boundary and size of any
   object allocated within the block is either a factor of the block
   size or equal to the block size. However I am not sure if this
   guarantees proper alignment on all architectures. We need to
   investigate some more about this.

I am sure there is a 69-bit transputer architecture somewhere that
breaks this allocator ;-)

--M9NhX3UHpAaciwkO--
