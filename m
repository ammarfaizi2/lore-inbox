Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTIQHRd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 03:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbTIQHRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 03:17:33 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:53143 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262709AbTIQHRT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 03:17:19 -0400
Subject: Re: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, ak@suse.de, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       richard.brunner@amd.com
In-Reply-To: <20030916220843.31533480.akpm@osdl.org>
References: <20030917022256.GA17624@wotan.suse.de>
	 <20030916194446.030d8e70.akpm@osdl.org> <3F67E8D4.6010707@cyberone.com.au>
	 <20030916220843.31533480.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-lft9BwSQB13vgYXwG8m+"
Organization: 
Message-Id: <1063782920.3590.164.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Sep 2003 00:15:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lft9BwSQB13vgYXwG8m+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2003-09-16 at 22:08, Andrew Morton wrote:
> But I would like to see some evidence that prefetch ever provides any
> performance gain in-kernel.  I spent some time fiddling a while back and
> was unable to demonstrate any difference.

For SDET on the NUMA-Q, it's pretty small.  Looks like well less than
1%.  Mostly lost in the noise, though.

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered 
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run
results are non-compliant and not-comparable with any published results.

Prefetch on: 
 Scripts  |  Average Throughput |  Standard Deviation
----------+---------------------+---------------------
       16 |      15795.9100     |     711.3221
       32 |      16450.5800     |     292.6028
       64 |      15800.2400     |     126.2358

Prefetch off:
 Scripts  |  Average Throughput |  Standard Deviation
----------+---------------------+---------------------
       16 |      15672.8600     |     438.5506
       32 |      16376.4100     |     364.5610
       64 |      15744.8100     |     208.9217


For those of you who care, I generated this with a neat little tool that
some interns cooked up for us this summer.  You hand it a little file
like this and it throws back a wealth of information back at you. 
There's a central machine to which has a database of other machines and
figures out the best fit for the job (can be more than 1 machine
requested).  In this case it's easy because there are very few 16x
machines in the database.  Oh, and like good interns, they stole a lot
of code from Steve Pratt's "autobench".  

class host num_cpus=16
+$mytest sdet "1 4 16 32 64" -l /tmp/sdet

disuseprofiler sar

# build the kernel with prefaulting off
build stock 2.6.0-test5 \
    -p http://elm3b114.beaverton.ibm.com/patches/prefetch-off.patch \
    -m -j8
boot
# sdet runs fast on ramfs
fs -mountramfs /tmp/sdet
run "sdet" $mytest
setup umount /tmp/sdet

build stock 2.6.0-test5 -m -j8
boot
fs -mountramfs /tmp/sdet
run "sdet" $mytest
setup umount /tmp/sdet

-- 
Dave Hansen
haveblue@us.ibm.com

--=-lft9BwSQB13vgYXwG8m+
Content-Disposition: attachment; filename=preload-off.patch
Content-Type: text/plain; name=preload-off.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- include/asm/processor.h.orig	Tue Sep 16 22:41:53 2003
+++ include/asm/processor.h	Tue Sep 16 22:40:54 2003
@@ -571,34 +571,4 @@
 #endif
 
 #define ASM_NOP_MAX 8
-
-/* Prefetch instructions for Pentium III and AMD Athlon */
-/* It's not worth to care about 3dnow! prefetches for the K6
-   because they are microcoded there and very slow. */
-#define ARCH_HAS_PREFETCH
-extern inline void prefetch(const void *x)
-{
-	if (cpu_data[0].x86_vendor == X86_VENDOR_AMD)
-		return;		/* Some athlons fault if the address is bad */
-	alternative_input(ASM_NOP4,
-			  "prefetchnta (%1)",
-			  X86_FEATURE_XMM,
-			  "r" (x));
-}
-
-#define ARCH_HAS_PREFETCH
-#define ARCH_HAS_PREFETCHW
-#define ARCH_HAS_SPINLOCK_PREFETCH
-
-/* 3dnow! prefetch to get an exclusive cache line. Useful for 
-   spinlocks to avoid one state transition in the cache coherency protocol. */
-extern inline void prefetchw(const void *x)
-{
-	alternative_input(ASM_NOP4,
-			  "prefetchw (%1)",
-			  X86_FEATURE_3DNOW,
-			  "r" (x));
-}
-#define spin_lock_prefetch(x)	prefetchw(x)
-
 #endif /* __ASM_I386_PROCESSOR_H */

--=-lft9BwSQB13vgYXwG8m+--

