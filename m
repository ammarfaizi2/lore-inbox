Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263053AbUKTBvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbUKTBvA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 20:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbUKTBtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 20:49:19 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:53154 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262836AbUKTBqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 20:46:00 -0500
Subject: [RFC PATCH] cpumask_t initializers
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Janis Johnson <janis187@us.ibm.com>, Darren Hart <dvhltc@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1100915156.4653.13.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 19 Nov 2004 17:45:57 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the course of another patch I've been working on, I stumbled across
some weirdness with some of the SD_*_INIT sched_domains initializers.  A
day or so of digging narrowed it down to the CPU_MASK_NONE initializer
nested inside the sched_domain initializers.  The errors I got were:

kernel/sched.c:4812: error: initializer element is not constant
kernel/sched.c:4812: error: (near initialization for `sched_domain_dummy')
kernel/sched.c:4812: error: initializer element is not constant

which was this line:

static struct sched_domain sched_domain_dummy = SD_CPU_INIT;

Janis Johnson, a GCC hacker, told me the following:
-----BEGIN QUOTE------
On Fri, Nov 19, 2004 at 01:30:39PM -0800, Matthew Dobson wrote:
> > /* GCC doesn't like parens around the array initializer, whether or
> >    not the cast is used.  */
> > #ifdef P
> > #define CPU_MASK_NONE (CAST1 { { [0 ... 1-1] = 0UL } })
> > #else
> > #define CPU_MASK_NONE CAST1 { { [0 ... 1-1] = 0UL } }
> > #endif
> 
> Janis, this may be a dumb question, but WHY does GCC care about parens
> around the array initializer?  It's always been my (apparently
> incorrect) understanding that GCC will just throw away any useless
> parens, assuming they are matched...  I'm sure there is one, but I
just
> can't think of a good reason why GCC would care about a set of parens
> around an array initializer, but not around a struct initializer?

Extra parens can be thrown away in expressions, but the syntax for
initializers has curly braces on the outside of the list.  GCC doesn't
seem to mind if there are parens outside the braces for a struct
initializer, but that's probably a bug and could change in a future
version of GCC's C parser.

Janis

-----END QUOTE------

So, in order to both make my code compile and future-proof (heh) the
CPU_MASK_* initializers I wrote up this little patch.  This DEFINITELY
needs to be tested further (I've compile-tested it on x86, x86 NUMA,
x86_64 & ppc64), but the good news is that any breakage from the patch
will be compile-time breakage and should be obvious.

The fact that GCC's parser may change in the future to disallow struct
initializers wrapped in parens kind of scares me, because just about
every struct initializer I've ever seen in the kernel is wrapped in
parens!!  This needs to be delved into further, but I'm leaving for home
for a week for Thanksgiving and will have limited access to email.

Without further ado, I submit this patch for testing and possibly
inclusion into the -mm series.

-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc2-mm2/include/linux/cpumask.h linux-2.6.10-rc2-mm2-CPU_MASK_INIT-fix/include/linux/cpumask.h
--- linux-2.6.10-rc2-mm2/include/linux/cpumask.h	2004-11-18 17:46:14.000000000 -0800
+++ linux-2.6.10-rc2-mm2-CPU_MASK_INIT-fix/include/linux/cpumask.h	2004-11-19 13:41:54.000000000 -0800
@@ -238,29 +238,29 @@ static inline int __next_cpu(int n, cons
 #if NR_CPUS <= BITS_PER_LONG
 
 #define CPU_MASK_ALL							\
-((cpumask_t) { {							\
+(cpumask_t) { {								\
 	[BITS_TO_LONGS(NR_CPUS)-1] = CPU_MASK_LAST_WORD			\
-} })
+} }
 
 #else
 
 #define CPU_MASK_ALL							\
-((cpumask_t) { {							\
+(cpumask_t) { {								\
 	[0 ... BITS_TO_LONGS(NR_CPUS)-2] = ~0UL,			\
 	[BITS_TO_LONGS(NR_CPUS)-1] = CPU_MASK_LAST_WORD			\
-} })
+} }
 
 #endif
 
 #define CPU_MASK_NONE							\
-((cpumask_t) { {							\
+(cpumask_t) { {								\
 	[0 ... BITS_TO_LONGS(NR_CPUS)-1] =  0UL				\
-} })
+} }
 
 #define CPU_MASK_CPU0							\
-((cpumask_t) { {							\
+(cpumask_t) { {								\
 	[0] =  1UL							\
-} })
+} }
 
 #define cpus_addr(src) ((src).bits)
 


