Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264592AbUD1B6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbUD1B6d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 21:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbUD1B6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 21:58:33 -0400
Received: from holomorphy.com ([207.189.100.168]:38081 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264592AbUD1B6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 21:58:30 -0400
Date: Tue, 27 Apr 2004 18:57:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Fix cpu iterator on empty bitmask
Message-ID: <20040428015703.GX743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, Rusty Russell <rusty@rustcorp.com.au>,
	akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <1083109972.2150.124.camel@bach> <20040428000511.GU743@holomorphy.com> <1083115347.30987.202.camel@bach> <20040427183135.6250f7bc.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427183135.6250f7bc.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty wrote:
>> Agreed, I'm pretty sure Paul's work doesn't make this mistake, but this
>> is a trivial patch for a real big which is causing oopses today.
>> Linus, please apply...

On Tue, Apr 27, 2004 at 06:31:35PM -0700, Paul Jackson wrote:
> agreed

Eh? Why are you now suddenly changing your tune from when I wrote a fix
for this and others just 10 days ago? The remainder of the missing fixes
below.


-- wli


Index: wli-2.6.5-mm6/include/asm-generic/cpumask_arith.h
===================================================================
--- wli-2.6.5-mm6.orig/include/asm-generic/cpumask_arith.h	2004-04-03 19:37:37.000000000 -0800
+++ wli-2.6.5-mm6/include/asm-generic/cpumask_arith.h	2004-04-17 19:11:53.000000000 -0700
@@ -15,17 +15,17 @@
 #define cpus_or(dst,src1,src2)		do { dst = (src1) | (src2); } while (0)
 #define cpus_clear(map)			do { map = 0; } while (0)
 #define cpus_complement(map)		do { map = ~(map); } while (0)
-#define cpus_equal(map1, map2)		((map1) == (map2))
-#define cpus_empty(map)			((map) == 0)
+#define cpus_equal(map1, map2)		(!(((map1) ^ (map2)) & CPU_MASK_ALL))
+#define cpus_empty(map)			(!((map) & CPU_MASK_ALL))
 #define cpus_addr(map)			(&(map))
 
 #if BITS_PER_LONG == 32
-#define cpus_weight(map)		hweight32(map)
+#define cpus_weight(map)		hweight32((map) & CPU_MASK_ALL)
 #elif BITS_PER_LONG == 64
-#define cpus_weight(map)		hweight64(map)
+#define cpus_weight(map)		hweight64((map) & CPU_MASK_ALL)
 #endif
 
-#define cpus_shift_right(dst, src, n)	do { dst = (src) >> (n); } while (0)
+#define cpus_shift_right(dst, src, n)	do { dst = ((src) >> (n)) & CPU_MASK_ALL; } while (0)
 #define cpus_shift_left(dst, src, n)	do { dst = (src) << (n); } while (0)
 
 #define any_online_cpu(map)			\
@@ -39,11 +39,15 @@
 #define CPU_MASK_NONE	((cpumask_t)0)
 
 /* only ever use this for things that are _never_ used on large boxen */
-#define cpus_coerce(map)		((unsigned long)(map))
+#define cpus_coerce(map)		((unsigned long)(map) & CPU_MASK_ALL)
 #define cpus_promote(map)		({ map; })
 #define cpumask_of_cpu(cpu)		({ ((cpumask_t)1) << (cpu); })
 
-#define first_cpu(map)			__ffs(map)
 #define next_cpu(cpu, map)		find_next_bit(&(map), NR_CPUS, cpu + 1)
+#define first_cpu(map)						\
+({								\
+	cpumask_t __first_cpu_map__ = (map) & CPU_MASK_ALL;	\
+	__first_cpu_map__ ? __ffs(__first_cpu_map__) : NR_CPUS;	\
+})
 
 #endif /* __ASM_GENERIC_CPUMASK_ARITH_H */
