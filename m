Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbTGDJxc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 05:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbTGDJxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 05:53:32 -0400
Received: from holomorphy.com ([66.224.33.161]:33999 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265931AbTGDJxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 05:53:30 -0400
Date: Fri, 4 Jul 2003 03:07:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 fails to boot due to APIC trouble, 2.5.73mm3 works.
Message-ID: <20030704100749.GD26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <3F054109.2050100@aitel.hist.no> <20030704093531.GA26348@holomorphy.com> <20030704095004.GB26348@holomorphy.com> <20030704100217.GC26348@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704100217.GC26348@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 02:50:04AM -0700, William Lee Irwin III wrote:
>> This time diffed against the right tree:

On Fri, Jul 04, 2003 at 03:02:17AM -0700, William Lee Irwin III wrote:
> And this time with a one-line typo fixed (it seemed to compile anyway):
> s/CPU_MASK_NONE/PHYSID_MASK_NONE/ somewhere in io_apic.c where a physid
> mask was being initialized.

Unrelated tangent:

Nuke cpumask_arith.h; it's unused as of the requested updates to use
strong typing for all arches.


-- wli


diff -prauN physid-2.5.74-1/include/asm-generic/cpumask_arith.h physid-2.5.74-2/include/asm-generic/cpumask_arith.h
--- physid-2.5.74-1/include/asm-generic/cpumask_arith.h	2003-07-03 12:23:56.000000000 -0700
+++ physid-2.5.74-2/include/asm-generic/cpumask_arith.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,61 +0,0 @@
-#ifndef __ASM_GENERIC_CPUMASK_ARITH_H
-#define __ASM_GENERIC_CPUMASK_ARITH_H
-
-#define cpu_set(cpu, map)				\
-	do {						\
-		map |= ((cpumask_t)1) << (cpu);		\
-	} while (0)
-#define cpu_clear(cpu, map)				\
-	do {						\
-		map &= ~(((cpumask_t)1) << (cpu));	\
-	} while (0)
-#define cpu_isset(cpu, map)				\
-	((map) & (((cpumask_t)1) << (cpu)))
-#define cpu_test_and_set(cpu, map)			\
-	test_and_set_bit(cpu, (unsigned long *)(&(map)))
-
-#define cpus_and(dst,src1,src2)		do { dst = (src1) & (src2); } while (0)
-#define cpus_or(dst,src1,src2)		do { dst = (src1) | (src2); } while (0)
-#define cpus_clear(map)			do { map = 0; } while (0)
-#define cpus_complement(map)		do { map = ~(map); } while (0)
-#define cpus_equal(map1, map2)		((map1) == (map2))
-#define cpus_empty(map)			((map) == 0)
-
-#if BITS_PER_LONG == 32
-#if NR_CPUS <= 32
-#define cpus_weight(map)		hweight32(map)
-#else
-#define cpus_weight(map)				\
-({							\
-	u32 *__map = (u32 *)(&(map));			\
-	hweight32(__map[0]) + hweight32(__map[1]);	\
-})
-#endif
-#elif BITS_PER_LONG == 64
-#define cpus_weight(map)		hweight64(map)
-#endif
-
-#define cpus_shift_right(dst, src, n)	do { dst = (src) >> (n); } while (0)
-#define cpus_shift_left(dst, src, n)	do { dst = (src) >> (n); } while (0)
-
-#define any_online_cpu(map)		(!cpus_empty(map))
-
-
-#define CPU_MASK_ALL	(~((cpumask_t)0) >> (8*sizeof(cpumask_t) - NR_CPUS))
-#define CPU_MASK_NONE	((cpumask_t)0)
-
-/* only ever use this for things that are _never_ used on large boxen */
-#define cpus_coerce(map)		((unsigned long)(map))
-#define cpus_promote(map)		({ map; })
-#define cpumask_of_cpu(cpu)		({ ((cpumask_t)1) << (cpu); })
-
-#ifdef CONFIG_SMP
-#define first_cpu(map)			__ffs(map)
-#define next_cpu(cpu, map)				\
-	__ffs((map) & ~(((cpumask_t)1 << (cpu)) - 1))
-#else
-#define first_cpu(map)			0
-#define next_cpu(cpu, map)		1
-#endif /* CONFIG_SMP */
-
-#endif /* __ASM_GENERIC_CPUMASK_ARITH_H */
