Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262639AbTCPKA1>; Sun, 16 Mar 2003 05:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262641AbTCPKA1>; Sun, 16 Mar 2003 05:00:27 -0500
Received: from holomorphy.com ([66.224.33.161]:35285 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262639AbTCPKAZ>;
	Sun, 16 Mar 2003 05:00:25 -0500
Date: Sun, 16 Mar 2003 02:10:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu-2.5.64-1
Message-ID: <20030316101055.GG20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
References: <20030316083609.GE20188@holomorphy.com> <16504.1047806371@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16504.1047806371@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Mar 2003 00:36:09 -0800, William Lee Irwin III wrote:
>> That was a bit too braindead of a translation, yes. But it is x86 arch
>> code so it shouldn't be that large of an issue for big MIPS boxen etc.
>> I'll search & replace for stuff of this kind and wipe it out anyway.

On Sun, Mar 16, 2003 at 08:19:31PM +1100, Keith Owens wrote:
> Good, it lets us optimize for 1/32/64/lots of cpus.  NR_CPUS > 8 *
> sizeof(unsigned long) is the interesting case, it needs arrays.

Hmm. It shouldn't make a difference with respect to optimizing them.
My API passes transparently by reference:

#include <linux/bitmap.h>

#define CPU_ARRAY_SIZE         BITS_TO_LONGS(NR_CPUS)

struct cpumask
{
       unsigned long mask[CPU_ARRAY_SIZE];
};

typedef struct cpumask cpumask_t;

#define cpu_set(cpu, map)		set_bit(cpu, (map).mask)
#define cpu_clear(cpu, map)		clear_bit(cpu, (map).mask)
#define cpu_isset(cpu, map)		test_bit(cpu, (map).mask)
#define cpu_test_and_set(cpu, map)	test_and_set_bit(cpu, (map).mask)
+
#define cpus_and(dst,src1,src2)		bitmap_and((dst).mask, (src1).mask, (src2).mask, NR_CPUS)
#define cpus_or(dst,src1,src2)		bitmap_or((dst).mask, (src1).mask, (src2).mask, NR_CPUS)
#define cpus_clear(map)			bitmap_clear((map).mask, NR_CPUS)
#define cpus_equal(map1, map2)		bitmap_equal((map1).mask, (map2).mask, NR_CPUS)
#define cpus_empty(map)			(any_online_cpu(map) >= NR_CPUS)
#define first_cpu(map)			find_first_bit((map).mask, NR_CPUS)
#define next_cpu(cpu, map)		find_next_bit((map).mask, NR_CPUS, cpu)


i.e. the structures vaguely look like they're being passed by value and
I get the pointer to the start of the array with implicit decay.

Now the special case exploits the appearance of call by value:

#else /* !CONFIG_SMP */

typedef unsigned long cpumask_t;

#define any_online_cpu(map)		((map) != 0UL)
#define cpu_set(cpu, map)		do { map |= 1UL << (cpu); } while (0)
#define cpu_clear(cpu, map)		do { map &= ~(1UL << (cpu)); } while (0)
#define cpu_isset(cpu, map)		((map) & (1UL << (cpu)))
#define cpu_test_and_set(cpu, map)	test_and_set_bit(cpu, &(map))
#define cpus_and(dst,src1,src2)		do { dst = (src1) & (src2); } while (0)
#define cpus_or(dst,src1,src2)		do { dst = (src1) | (src2); } while (0)
#define cpus_clear(map)			do { map = 0UL; } while (0)
#define cpus_equal(map1, map2)		((map1) == (map2))
#define cpus_empty(map)			((map) != 0UL)
#define first_cpu(map)			0
#define next_cpu(cpu, map)		NR_CPUS

... okay, a couple of minor fixups are needed for small-scale SMP, but
you get the idea. So basically the references to cpu_online_map don't
affect the UP/tinySMP special-casing b/c of the calling conventions
giving enough play to use either pointers (wrapped in structures) or
plain old unsigned longs.

fixups:

#define first_cpu(map)			__ffs(map)
#define next_cpu(cpu, map)		__ffs((map) & ~((1UL < (cpu)) - 1))

*and* the plain old bugfix(!):

#define cpus_empty(map)			((map) == 0UL)


So mostly there isn't much to get excited about, but using
cpu_online_map directly doesn't appear to be a plus or a minus for my
strategy, if it in fact differs enough from any of the various others
of these posted before to be able to be called my own.


-- wli
