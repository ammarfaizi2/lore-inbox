Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWCSWid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWCSWid (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 17:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWCSWid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 17:38:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751155AbWCSWic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 17:38:32 -0500
Date: Sun, 19 Mar 2006 14:35:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@ftp.linux.org.uk, kernel-stuff@comcast.net,
       linux-kernel@vger.kernel.org, alex-kernel@digriz.org.uk,
       jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
Message-Id: <20060319143513.05f8ac94.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603191412270.3826@g5.osdl.org>
References: <200603181525.14127.kernel-stuff@comcast.net>
	<Pine.LNX.4.64.0603181321310.3826@g5.osdl.org>
	<20060318165302.62851448.akpm@osdl.org>
	<Pine.LNX.4.64.0603181827530.3826@g5.osdl.org>
	<Pine.LNX.4.64.0603191034370.3826@g5.osdl.org>
	<Pine.LNX.4.64.0603191050340.3826@g5.osdl.org>
	<Pine.LNX.4.64.0603191125220.3826@g5.osdl.org>
	<20060319194004.GZ27946@ftp.linux.org.uk>
	<Pine.LNX.4.64.0603191148160.3826@g5.osdl.org>
	<Pine.LNX.4.64.0603191217560.3826@g5.osdl.org>
	<20060319124701.41e16e7b.akpm@osdl.org>
	<Pine.LNX.4.64.0603191412270.3826@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
>  How does this patch look?
>

Wonderful - coz it's just like mine ;)

(4 patches temp-joined below)

- I made SMP=n next_cpu() just a constant "1".

- It's odd that the code uses (NR_CPUS>1) rather than CONFIG_SMP.  On x86
  (at least), SMP=y,NR_CPUS==1 isn't allowed anyway.



From: Andrew Morton <akpm@osdl.org>

           text    data     bss     dec     hex filename
before: 3490577 1322408  360000 5172985  4eeef9 vmlinux
after:  3488027 1322496  360128 5170651  4ee5db vmlinux

Cc: Paul Jackson <pj@sgi.com>
DESC
cpumask: uninline next_cpu()
EDESC
From: Andrew Morton <akpm@osdl.org>

           text    data     bss     dec     hex filename
before: 3488027 1322496  360128 5170651  4ee5db vmlinux
after:  3485112 1322480  359968 5167560  4ed9c8 vmlinux

2931 bytes saved

Cc: Paul Jackson <pj@sgi.com>
DESC
cpumask: uninline highest_possible_processor_id()
EDESC
From: Andrew Morton <akpm@osdl.org>

Shrinks the only caller (net/bridge/netfilter/ebtables.c) by 174 bytes.

Also, optimise highest_possible_processor_id() out of existence on
CONFIG_SMP=n.

Cc: Paul Jackson <pj@sgi.com>
DESC
cpumask: uninline any_online_cpu()
EDESC
From: Andrew Morton <akpm@osdl.org>

           text    data     bss     dec     hex filename
before: 3605597 1363528  363328 5332453  515de5 vmlinux
after:  3605295 1363612  363200 5332107  515c8b vmlinux

218 bytes saved.

Also, optimise any_online_cpu() out of existence on CONFIG_SMP=n.

This function seems inefficient.  Can't we simply AND the two masks, then use
find_first_bit()?

Cc: Paul Jackson <pj@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/cpumask.h |   46 ++++++++++++++------------------------
 lib/Makefile            |    2 +
 lib/cpumask.c           |   45 +++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 29 deletions(-)

diff -puN include/linux/cpumask.h~cpumask-uninline-first_cpu include/linux/cpumask.h
--- devel/include/linux/cpumask.h~cpumask-uninline-first_cpu	2006-03-19 14:26:35.000000000 -0800
+++ devel-akpm/include/linux/cpumask.h	2006-03-19 14:28:45.000000000 -0800
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
+#ifdef CONFIG_SMP
+int __first_cpu(const cpumask_t *srcp);
+#define first_cpu(src) __first_cpu(&(src))
+int __next_cpu(int n, const cpumask_t *srcp);
+#define next_cpu(n, src) __next_cpu((n), &(src))
+#else
+#define first_cpu(src)		0
+#define next_cpu(n, src)	1
+#endif
 
 #define cpumask_of_cpu(cpu)						\
 ({									\
@@ -398,27 +396,17 @@ extern cpumask_t cpu_present_map;
 #define cpu_present(cpu)	((cpu) == 0)
 #endif
 
-#define any_online_cpu(mask)			\
-({						\
-	int cpu;				\
-	for_each_cpu_mask(cpu, (mask))		\
-		if (cpu_online(cpu))		\
-			break;			\
-	cpu;					\
-})
+#ifdef CONFIG_SMP
+int highest_possible_processor_id(void);
+#define any_online_cpu(mask) __any_online_cpu(&(mask))
+int __any_online_cpu(const cpumask_t *mask);
+#else
+#define highest_possible_processor_id()	0
+#define any_online_cpu(mask)		0
+#endif
 
 #define for_each_cpu(cpu)	  for_each_cpu_mask((cpu), cpu_possible_map)
 #define for_each_online_cpu(cpu)  for_each_cpu_mask((cpu), cpu_online_map)
 #define for_each_present_cpu(cpu) for_each_cpu_mask((cpu), cpu_present_map)
 
-/* Find the highest possible smp_processor_id() */
-#define highest_possible_processor_id() \
-({ \
-	unsigned int cpu, highest = 0; \
-	for_each_cpu_mask(cpu, cpu_possible_map) \
-		highest = cpu; \
-	highest; \
-})
-
-
 #endif /* __LINUX_CPUMASK_H */
diff -puN /dev/null lib/cpumask.c
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/lib/cpumask.c	2006-03-19 14:28:45.000000000 -0800
@@ -0,0 +1,45 @@
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/cpumask.h>
+#include <linux/module.h>
+
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
+/*
+ * Find the highest possible smp_processor_id()
+ *
+ * Note: if we're prepared to assume that cpu_possible_map never changes
+ * (reasonable) then this function should cache its return value.
+ */
+int highest_possible_processor_id(void)
+{
+	unsigned int cpu;
+	unsigned highest = 0;
+
+	for_each_cpu_mask(cpu, cpu_possible_map)
+		highest = cpu;
+	return highest;
+}
+EXPORT_SYMBOL(highest_possible_processor_id);
+
+int __any_online_cpu(const cpumask_t *mask)
+{
+	int cpu;
+
+	for_each_cpu_mask(cpu, *mask) {
+		if (cpu_online(cpu))
+			break;
+	}
+	return cpu;
+}
+EXPORT_SYMBOL(__any_online_cpu);
diff -puN lib/Makefile~cpumask-uninline-first_cpu lib/Makefile
--- devel/lib/Makefile~cpumask-uninline-first_cpu	2006-03-19 14:26:35.000000000 -0800
+++ devel-akpm/lib/Makefile	2006-03-19 14:26:35.000000000 -0800
@@ -7,6 +7,8 @@ lib-y := errno.o ctype.o string.o vsprin
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
 	 sha1.o
 
+lib-$(CONFIG_SMP) += cpumask.o
+
 lib-y	+= kobject.o kref.o kobject_uevent.o klist.o
 
 obj-y += sort.o parser.o halfmd4.o iomap_copy.o
_

