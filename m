Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264569AbUD1BXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbUD1BXl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 21:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264573AbUD1BXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 21:23:41 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:4771 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S264569AbUD1BXi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 21:23:38 -0400
Subject: Re: [PATCH] Fix cpu iterator on empty bitmask
From: Rusty Russell <rusty@rustcorp.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20040428000511.GU743@holomorphy.com>
References: <1083109972.2150.124.camel@bach>
	 <20040428000511.GU743@holomorphy.com>
Content-Type: text/plain
Message-Id: <1083115347.30987.202.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Apr 2004 11:22:28 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-28 at 10:05, William Lee Irwin III wrote:
> On Wed, Apr 28, 2004 at 09:52:53AM +1000, Rusty Russell wrote:
> > Name: Fix cpumask iterator over empty cpu set
> > Status: Trivial
> > Can't use _ffs() without first checking for zero, and if bits beyond
> > NR_CPUS set it'll give bogus results.  Use find_first_bit
> 
> I sent in something equivalent to this along with a number of other
> fixes (cpus_shift_right() leaking junk bits in in and cpus_weight()
> and cpus_empty() and cpus_equal() and the like not ignoring tails) and
> got a NAK since it clashes with something Paul Jackson's doing.

Agreed, I'm pretty sure Paul's work doesn't make this mistake, but this
is a trivial patch for a real big which is causing oopses today.

Linus, please apply...
Rusty.

Name: Fix cpumask iterator over empty cpu set
Status: Trivial

Can't use _ffs() without first checking for zero, and if bits beyond
NR_CPUS set it'll give bogus results.  Use find_first_bit

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26180-linux-2.6.6-rc2-bk5/include/asm-generic/cpumask_arith.h .26180-linux-2.6.6-rc2-bk5.updated/include/asm-generic/cpumask_arith.h
--- .26180-linux-2.6.6-rc2-bk5/include/asm-generic/cpumask_arith.h	2004-01-10 13:59:33.000000000 +1100
+++ .26180-linux-2.6.6-rc2-bk5.updated/include/asm-generic/cpumask_arith.h	2004-04-28 09:50:23.000000000 +1000
@@ -43,7 +43,7 @@
 #define cpus_promote(map)		({ map; })
 #define cpumask_of_cpu(cpu)		({ ((cpumask_t)1) << (cpu); })
 
-#define first_cpu(map)			__ffs(map)
+#define first_cpu(map)			find_first_bit(&(map), NR_CPUS)
 #define next_cpu(cpu, map)		find_next_bit(&(map), NR_CPUS, cpu + 1)
 
 #endif /* __ASM_GENERIC_CPUMASK_ARITH_H */

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

