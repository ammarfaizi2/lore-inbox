Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbUC3Bt4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 20:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbUC3Bt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 20:49:56 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:33762 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262575AbUC3Btv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 20:49:51 -0500
Subject: Re: [PATCH] mask ADT: replace cpumask_t implementation [3/22]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20040329041256.0f27e8c4.pj@sgi.com>
References: <20040329041256.0f27e8c4.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1080611340.6742.147.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 29 Mar 2004 17:49:01 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 04:12, Paul Jackson wrote:
> Patch_3_of_22 - Rework cpumasks to use new mask ADT
> 	Removes many old include/asm-<arch> and asm-generic cpumask files
> 	Add intersects, subset, xor and andnot operators.
> 	Provides temporary emulators for obsolete const, promote, coerce
> 	Presents entire cpumask API clearly in single cpumask.h file

<snip>

> + * int num_online_cpus()		Number of online CPUs
> + * int num_possible_cpus()		Number of all possible CPUs
> + * int cpu_online(cpu)			Is some cpu < NR_CPUS online?
> + * int cpu_possible(cpu)		Is some cpu < NR_CPUS possible?
> + * int any_online_cpu(mask)		First online cpu in mask

This made me do a double-take.  I don't think it's necessary to specify
the passed in cpu number is < NR_CPUS, because that is true for the
whole API.  This comment seemed to imply at first reading that the call
would return true if any CPU with a number less than 'cpu' was
online/possible.


> +#define cpu_set(cpu, mask) mask_setbit((cpu), (mask))
> +#define cpu_clear(cpu, mask) mask_clearbit((cpu), (mask))
> +#define cpus_setall(mask) mask_setall(mask, NR_CPUS)
> +#define cpus_clear(mask) mask_clearall(mask)
> +#define cpu_isset(cpu, mask) mask_isset((cpu), (mask))
> +#define cpu_test_and_set(cpu, mask) mask_test_and_set((cpu), (mask))
> +#define cpus_and(dst, src1, src2) mask_and((dst), (src1), (src2))
> +#define cpus_or(dst, src1, src2) mask_or((dst), (src1), (src2))
> +#define cpus_xor(dst, src1, src2) mask_xor((dst), (src1), (src2))
> +#define cpus_andnot(dst, src1, src2) mask_andnot((dst), (src1), (src2))
> +#define cpus_complement(dst, src) mask_complement((dst), (src), NR_CPUS)
> +#define cpus_equal(mask1, mask2) mask_equal((mask1), (mask2))
> +#define cpus_intersects(mask1, mask2) mask_intersects(mask1, mask2)
> +#define cpus_subset(mask1, mask2) mask_subset(mask1, mask2)
> +#define cpus_empty(mask) mask_empty(mask)
> +#define cpus_full(mask) mask_full(mask, NR_CPUS)
> +#define cpus_weight(mask) mask_weight(mask, NR_CPUS)
> +#define cpus_shift_right(dst, src, n) \
> +			mask_shift_right((dst), (src), (n), NR_CPUS)
> +#define cpus_shift_left(dst, src, n) \
> +			mask_shift_left((dst), (src), (n), NR_CPUS)
> +#define first_cpu(mask) mask_first(mask, NR_CPUS)
> +#define next_cpu(cpu, mask) mask_next(cpu, mask, NR_CPUS)
> +#define cpumask_of_cpu(cpu) mask_of_bit((cpu), _unused_cpumask_arg_)
> +#define CPU_MASK_ALL MASK_ALL(NR_CPUS)
> +#define CPU_MASK_NONE MASK_NONE(NR_CPUS)
> +#define cpus_raw(mask) mask_raw(mask)
> +#define cpumask_scnprintf(buf, len, mask) \
> +			mask_scnprintf(buf, len, mask, NR_CPUS)
> +#define cpumask_parse(ubuf, ulen, mask) \
> +			mask_parse(ubuf, ulen, mask, NR_CPUS)

What would you think about creating two versions of some of the mask_*
functions, one that takes a nrbits argument and one that doesn't.  Many
(all?) of the bitmap_* functions take a number of bits to operate on,
and for the mask_* functions we simply compute the size of the mask and
pass that along.  We can be smarter in the cpumask/nodemask cases
because we *know* how many bits we're really using, and we can pass that
information along.  Basically, what I'm suggesting is:

mask_empty(mask) -> bitmap_empty(mask, sizeof(mask))
mask_empty_bits(mask, nrbits) -> bitmap_empty(mask, nrbits)
cpus_empty(mask) -> mask_empty_bits(mask, NR_CPUS)

This allows anyone using the mask API to specify the exact number of
bits if they care to, and it buys us a little protection from non-word
sized cpumask/nodemask errors.


>  #else
> +
>  #define	cpu_online_map			cpumask_of_cpu(0)
>  #define	cpu_possible_map		cpumask_of_cpu(0)
> +
>  #define num_online_cpus()		1
>  #define num_possible_cpus()		1
>  #define cpu_online(cpu)			({ BUG_ON((cpu) != 0); 1; })
>  #define cpu_possible(cpu)		({ BUG_ON((cpu) != 0); 1; })

Might it make more sense to actually define a cpu_online_map &
cpu_possible_map for UP, rather than generating this code:

#define mask_of_bit(bit, T)                                            \
({                                                                     \
       typeof(T) m;                                                    \
       mask_clearall(m);                                               \
       mask_setbit((bit), m);                                          \
       m;                                                              \
})

every time some code references cpu_online_map?  It'll only cost us 2
unsigned longs on 32-bit == 8 bytes...

-Matt

