Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWCSSrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWCSSrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 13:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWCSSrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 13:47:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64149 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932164AbWCSSrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 13:47:07 -0500
Date: Sun, 19 Mar 2006 10:46:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: kernel-stuff@comcast.net, linux-kernel@vger.kernel.org,
       alex-kernel@digriz.org.uk, jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
In-Reply-To: <Pine.LNX.4.64.0603181827530.3826@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0603191034370.3826@g5.osdl.org>
References: <200603181525.14127.kernel-stuff@comcast.net>
 <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <20060318165302.62851448.akpm@osdl.org>
 <Pine.LNX.4.64.0603181827530.3826@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Mar 2006, Linus Torvalds wrote:
> 
> The thing is, we could do _so_ much better if we just fixed the "calling 
> convention" for that loop.

Actually, looking at it a bit more, I think we can do better even 
_without_ fixing the "calling convention".

Namely like this.

This should make the "NR_CPUS <= 16" case have a _much_ simpler loop. 

I picked "16" at random. The loop is much faster and much simpler (it 
doesn't use complex instructions like "find first bit", but the downside 
is that if the CPU mask is very sparse, it will take more of those (very 
simple) iterations to figure out that it's empty.

I suspect the "16" could be raised to 32 (at which point it would cover 
all the default vaules), but somebody should probably take a look at 
how much this shrinks the kernel.

I have to admit that it's a bit evil to leave a dangling "else" in a 
macro, but it beautifully handles the "must be followed by exactly one C 
statement" requirement of the old macro ;)

So instead of calling it "evil", let's just say that it's "creative 
macro-writing".

(Btw, we could make this even cleaner by making the non-SMP case define 
"cpu_isset()" to 1 - at that point the UP and the "low CPU count" #defines 
could be merged into one).

		Linus

--
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 60e56c6..a659f42 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -313,11 +313,17 @@ static inline void __cpus_remap(cpumask_
 	bitmap_remap(dstp->bits, srcp->bits, oldp->bits, newp->bits, nbits);
 }
 
-#if NR_CPUS > 1
+#if NR_CPUS > 16
 #define for_each_cpu_mask(cpu, mask)		\
 	for ((cpu) = first_cpu(mask);		\
 		(cpu) < NR_CPUS;		\
 		(cpu) = next_cpu((cpu), (mask)))
+#elif NR_CPUS > 1
+#define for_each_cpu_mask(cpu, mask)		\
+	for ((cpu) = 0; (cpu) < NR_CPUS; (cpu)++) \
+		if (!cpu_isset(cpu, mask))	\
+			continue;		\
+		else
 #else /* NR_CPUS == 1 */
 #define for_each_cpu_mask(cpu, mask) for ((cpu) = 0; (cpu) < 1; (cpu)++)
 #endif /* NR_CPUS */
