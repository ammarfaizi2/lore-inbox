Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWCSWSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWCSWSn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 17:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWCSWSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 17:18:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53431 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751125AbWCSWSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 17:18:42 -0500
Date: Sun, 19 Mar 2006 14:18:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: viro@ftp.linux.org.uk, kernel-stuff@comcast.net,
       linux-kernel@vger.kernel.org, alex-kernel@digriz.org.uk,
       jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
In-Reply-To: <20060319124701.41e16e7b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603191412270.3826@g5.osdl.org>
References: <200603181525.14127.kernel-stuff@comcast.net>
 <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <20060318165302.62851448.akpm@osdl.org>
 <Pine.LNX.4.64.0603181827530.3826@g5.osdl.org> <Pine.LNX.4.64.0603191034370.3826@g5.osdl.org>
 <Pine.LNX.4.64.0603191050340.3826@g5.osdl.org> <Pine.LNX.4.64.0603191125220.3826@g5.osdl.org>
 <20060319194004.GZ27946@ftp.linux.org.uk> <Pine.LNX.4.64.0603191148160.3826@g5.osdl.org>
 <Pine.LNX.4.64.0603191217560.3826@g5.osdl.org> <20060319124701.41e16e7b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Mar 2006, Andrew Morton wrote:
> 
> That's about the same saving as uninlining first_cpu() and next_cpu()
> provides.

Btw, we could do that better for UP too.

How does this patch look? It makes "for_each_cpu()" look the same 
regardless of whether it is UP/SMP, by simply making first_cpu() and 
next_cpu() work appropriately. 

No ugly macros this time ;)

		Linus

---
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 60e56c6..c8dbc24 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -212,17 +212,15 @@ static inline void __cpus_shift_left(cpu
 	bitmap_shift_left(dstp->bits, srcp->bits, n, nbits);
 }
 
-#define first_cpu(src) __first_cpu(&(src), NR_CPUS)
-static inline int __first_cpu(const cpumask_t *srcp, int nbits)
-{
-	return min_t(int, nbits, find_first_bit(srcp->bits, nbits));
-}
-
-#define next_cpu(n, src) __next_cpu((n), &(src), NR_CPUS)
-static inline int __next_cpu(int n, const cpumask_t *srcp, int nbits)
-{
-	return min_t(int, nbits, find_next_bit(srcp->bits, nbits, n+1));
-}
+#if NR_CPUS > 1
+extern int fastcall __first_cpu(const cpumask_t *srcp);
+extern int fastcall __next_cpu(int n, const cpumask_t *srcp);
+#define first_cpu(srcp) __first_cpu(&(srcp))
+#define next_cpu(n,srcp) __next_cpu((n),&(srcp))
+#else
+#define first_cpu(srcp)		(0)
+#define next_cpu(n, srcp)	((n)+1)
+#endif
 
 #define cpumask_of_cpu(cpu)						\
 ({									\
@@ -313,14 +311,10 @@ static inline void __cpus_remap(cpumask_
 	bitmap_remap(dstp->bits, srcp->bits, oldp->bits, newp->bits, nbits);
 }
 
-#if NR_CPUS > 1
 #define for_each_cpu_mask(cpu, mask)		\
 	for ((cpu) = first_cpu(mask);		\
 		(cpu) < NR_CPUS;		\
 		(cpu) = next_cpu((cpu), (mask)))
-#else /* NR_CPUS == 1 */
-#define for_each_cpu_mask(cpu, mask) for ((cpu) = 0; (cpu) < 1; (cpu)++)
-#endif /* NR_CPUS */
 
 /*
  * The following particular system cpumasks and operations manage
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e882c6b..0a9cc97 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <linux/unistd.h>
 #include <linux/cpu.h>
+#include <linux/cpumask.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/stop_machine.h>
@@ -20,6 +21,18 @@ static DECLARE_MUTEX(cpucontrol);
 
 static struct notifier_block *cpu_chain;
 
+int __first_cpu(const cpumask_t *srcp)
+{
+	return min_t(int, NR_CPUS, find_first_bit(srcp->bits, NR_CPUS));
+}
+EXPORT_SYMBOL(__first_cpu);
+
+int __next_cpu(int n, const cpumask_t *srcp)
+{
+	return min_t(int, NR_CPUS, find_next_bit(srcp->bits, NR_CPUS, n+1));
+}
+EXPORT_SYMBOL(__next_cpu);
+
 #ifdef CONFIG_HOTPLUG_CPU
 static struct task_struct *lock_cpu_hotplug_owner;
 static int lock_cpu_hotplug_depth;
