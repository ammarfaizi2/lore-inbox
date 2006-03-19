Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWCSTdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWCSTdf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 14:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWCSTdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 14:33:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52125 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750738AbWCSTde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 14:33:34 -0500
Date: Sun, 19 Mar 2006 11:33:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: kernel-stuff@comcast.net, linux-kernel@vger.kernel.org,
       alex-kernel@digriz.org.uk, jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
In-Reply-To: <Pine.LNX.4.64.0603191050340.3826@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0603191125220.3826@g5.osdl.org>
References: <200603181525.14127.kernel-stuff@comcast.net>
 <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <20060318165302.62851448.akpm@osdl.org>
 <Pine.LNX.4.64.0603181827530.3826@g5.osdl.org> <Pine.LNX.4.64.0603191034370.3826@g5.osdl.org>
 <Pine.LNX.4.64.0603191050340.3826@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Mar 2006, Linus Torvalds wrote:
> 
> Now, the simple version will iterate 8 times over the loop, while the more 
> complex version will iterate just as many times as there are CPU's in the 
> actual system. So there's a trade-off. The "load the CPU mask first and 
> then shift it down by one every time" thing (that required different 
> syntax) would have been able to exit early. This one isn't. So the syntax 
> change would still help a lot (and would avoid the "btl").

Hah. My "abuse every gcc feature and do really ugly macros" dark side has 
been vetted, and it came up with the appended work of art.

Doing a "break" inside a conditional by using the gcc statement 
expressions is sublime. 

And it works. It's a couple of instructions longer than the shortest 
version (but still about half the size of the horror we have now), but the 
instructions are simpler (just a shift rather than a "btl"), and it now 
knows to break out early if there are no CPU's left to check.

It has the added advantage that because it uses simpler core instructions, 
gcc can actually optimize it better - in "nr_context_switches()" gcc 
happily hoisted the "mask->bits[0]" load to outside the loop, for example.

With NR_CPUS==2, gcc even apparently unrolls the loop, to the point where 
it isn't even a loop at all. Good boy (at least for that case - I sure 
hope it won't do that for some of the larger loops ;).

Of course, I shouldn't say "works", since it is still totally untested. It 
_looks_ good, and that statement expression usage is just _so_ ugly it's 
cute.

		Linus

---
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 60e56c6..17a965c 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -313,11 +313,20 @@ static inline void __cpus_remap(cpumask_
 	bitmap_remap(dstp->bits, srcp->bits, oldp->bits, newp->bits, nbits);
 }
 
-#if NR_CPUS > 1
+#define check_for_each_cpu(cpu, mask) \
+	({ unsigned long __bits = (mask).bits[0] >> (cpu); if (!__bits) break; __bits & 1; })
+
+#if NR_CPUS > 32
 #define for_each_cpu_mask(cpu, mask)		\
 	for ((cpu) = first_cpu(mask);		\
 		(cpu) < NR_CPUS;		\
 		(cpu) = next_cpu((cpu), (mask)))
+#elif NR_CPUS > 1
+#define for_each_cpu_mask(cpu, mask)		\
+	for ((cpu) = 0; (cpu) < NR_CPUS; (cpu)++) \
+		if (!check_for_each_cpu(cpu, mask))	\
+			continue;		\
+		else
 #else /* NR_CPUS == 1 */
 #define for_each_cpu_mask(cpu, mask) for ((cpu) = 0; (cpu) < 1; (cpu)++)
 #endif /* NR_CPUS */
