Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUCZWjV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 17:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbUCZWjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 17:39:21 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:31659 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261396AbUCZWjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 17:39:03 -0500
Date: Fri, 26 Mar 2004 14:36:48 -0800
From: Paul Jackson <pj@sgi.com>
To: "David S. Miller" <davem@redhat.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Sparc64, cpumask_t and struct arguments (was: [PATCH] Introduce
 nodemask_t ADT)
Message-Id: <20040326143648.5be0e221.pj@sgi.com>
In-Reply-To: <20040325101827.GO791@holomorphy.com>
References: <20040320031843.GY2045@holomorphy.com>
	<20040320000235.5e72040a.pj@sgi.com>
	<20040320111340.GA2045@holomorphy.com>
	<20040322171243.070774e5.pj@sgi.com>
	<20040323020940.GV2045@holomorphy.com>
	<20040322183918.5e0f17c7.pj@sgi.com>
	<20040323031345.GY2045@holomorphy.com>
	<20040322193628.4278db8c.pj@sgi.com>
	<20040323035921.GZ2045@holomorphy.com>
	<20040325012457.51f708c7.pj@sgi.com>
	<20040325101827.GO791@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

I understand that you are the Sparc64 expert.  I am doing some more
work refining the cpumask_t (and nodemask_t) implementation, in an
effort to obtain a common "mask_t" underlying ADT that can be useful
for both cpu and node masks.

As part of this, I'm looking at having only one data representation
for these masks - an array of unsigned longs encapsulated inside a
struct.  For the processors and compilation environment that I am
most focused on - gcc 3.2 and above on Intel CPUs, this generates
just as good code as the other variants.

However, as I recall, you recommend against passing structs on the
Sparc64 processor and compilation environment.  Am I recalling
correctly?

The two places that I see sparc64 passing a cpumask_t across a real
function call boundary (as opposed to an inline function) is in the file
arch/sparc64/kernel/smp.c, by the functions cheetah_xcall_deliver() and
smp_cross_call_masked().

Could you describe to me the requirements here.

 1) Are the above the two places of interest, currently, for sparc64 work?

 2) What sizes of cpumask_t are needed?

 3) Which of passing by pointer, passing as a struct, and/or passing by
    simple value, are required or acceptable or unacceptable?

 4) Does your answer to (3) vary with the sizes needed in (2)?

 5) The cpu_clear(i, mask) on about line 534 of smp.c confuses me, as it
    seems to be changing a local copy of 'mask' that no one will examine
    later.  What purpose does it serve?  See this line annotated with
    "No affect??" in the changes, below.

 6) I'm not done yet, but so far I have the following changes in my
    workarea for sparc64 (along with larger changes elsewhere).  These
    changes are untested, unbuilt, incomplete and unreviewed.  They
    were generated on a 2.6.4 base, with Matthew Dobson's nodemask_t
    patch of this thread applied.  Do you see anything that looks
    wrong in the following so far?

===== smp.c 1.66 vs edited =====
--- 1.66/arch/sparc64/kernel/smp.c      Tue Feb 24 16:11:02 2004
+++ edited/smp.c        Fri Mar 26 14:01:23 2004
@@ -409,14 +409,8 @@
        int i;

        __asm__ __volatile__("rdpr %%pstate, %0" : "=r" (pstate));
-       for (i = 0; i < NR_CPUS; i++) {
-               if (cpu_isset(i, mask)) {
-                       spitfire_xcall_helper(data0, data1, data2, pstate, i);
-                       cpu_clear(i, mask);
-                       if (cpus_empty(mask))
-                               break;
-               }
-       }
+       for_each_cpu_mask(i, mask)
+               spitfire_xcall_helper(data0, data1, data2, pstate, i);
 }

 /* Cheetah now allows to send the whole 64-bytes of data in the interrupt
@@ -459,25 +453,19 @@

        nack_busy_id = 0;
        {
-               cpumask_t work_mask = mask;
                int i;

-               for (i = 0; i < NR_CPUS; i++) {
-                       if (cpu_isset(i, work_mask)) {
-                               u64 target = (i << 14) | 0x70;
-
-                               if (!is_jalapeno)
-                                       target |= (nack_busy_id << 24);
-                               __asm__ __volatile__(
-                                       "stxa   %%g0, [%0] %1\n\t"
-                                       "membar #Sync\n\t"
-                                       : /* no outputs */
-                                       : "r" (target), "i" (ASI_INTR_W));
-                               nack_busy_id++;
-                               cpu_clear(i, work_mask);
-                               if (cpus_empty(work_mask))
-                                       break;
-                       }
+               for_each_cpu_mask(i, mask) {
+                       u64 target = (i << 14) | 0x70;
+
+                       if (!is_jalapeno)
+                               target |= (nack_busy_id << 24);
+                       __asm__ __volatile__(
+                               "stxa   %%g0, [%0] %1\n\t"
+                               "membar #Sync\n\t"
+                               : /* no outputs */
+                               : "r" (target), "i" (ASI_INTR_W));
+                       nack_busy_id++;
                }
        }

@@ -521,6 +509,8 @@
                        /* Clear out the mask bits for cpus which did not
                         * NACK us.
                         */
+                       /* Could replace with for_each_cpu_mask(i, mask) loop,
+                        * were it not for the cpu_clear(i, mask) below. -pj */
                        for (i = 0; i < NR_CPUS; i++) {
                                if (cpu_isset(i, work_mask)) {
                                        u64 check_mask;
@@ -531,7 +521,7 @@
                                                check_mask = (0x2UL <<
                                                              this_busy_nack);
                                        if ((dispatch_stat & check_mask) == 0)
-                                               cpu_clear(i, mask);
+                                               cpu_clear(i, mask); /* No affect?? -pj */
                                        this_busy_nack += 2;
                                        cpu_clear(i, work_mask);
                                        if (cpus_empty(work_mask))


Thank-you for your considerations.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
