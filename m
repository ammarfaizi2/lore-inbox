Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTFGGEh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 02:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTFGGEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 02:04:36 -0400
Received: from dp.samba.org ([66.70.73.150]:52937 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261757AbTFGGEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 02:04:30 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, fleming@austin.ibm.com, zwane@linuxpower.ca
Subject: [PATCH] Change any_online_cpu()
Date: Sat, 07 Jun 2003 16:16:13 +1000
Message-Id: <20030607061805.2EF952C013@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Noone calls it yet, but Matt Fleming points out that returning int
from any_online_cpu where cpu numbers are passed as unsigned ints
elsewhere is awkward and a little dangerous.

Make any_online_cpu() match find_first_bit(), by returning NR_CPUS
when no cpu is found, rather than -1.  This also simplifies the future
case where NR_CPUS > BITS_PER_LONG.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.70-bk11/include/asm-i386/smp.h working-2.5.70-bk11-tmp/include/asm-i386/smp.h
--- linux-2.5.70-bk11/include/asm-i386/smp.h	2003-06-07 15:22:56.000000000 +1000
+++ working-2.5.70-bk11-tmp/include/asm-i386/smp.h	2003-06-07 16:05:01.000000000 +1000
@@ -78,12 +78,12 @@ static inline int num_booting_cpus(void)
 extern void map_cpu_to_logical_apicid(void);
 extern void unmap_cpu_to_logical_apicid(int cpu);
 
-extern inline int any_online_cpu(unsigned int mask)
+extern inline unsigned int any_online_cpu(unsigned int mask)
 {
 	if (mask & cpu_online_map)
 		return __ffs(mask & cpu_online_map);
 
-	return -1;
+	return NR_CPUS;
 }
 #ifdef CONFIG_X86_LOCAL_APIC
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.70-bk11/include/asm-ia64/smp.h working-2.5.70-bk11-tmp/include/asm-ia64/smp.h
--- linux-2.5.70-bk11/include/asm-ia64/smp.h	2003-06-07 15:22:56.000000000 +1000
+++ working-2.5.70-bk11-tmp/include/asm-ia64/smp.h	2003-06-07 16:07:09.000000000 +1000
@@ -56,12 +56,12 @@ num_online_cpus (void)
 	return hweight64(cpu_online_map);
 }
 
-static inline int
+static inline unsigned int
 any_online_cpu (unsigned int mask)
 {
 	if (mask & cpu_online_map)
 		return __ffs(mask & cpu_online_map);
-	return -1;
+	return NR_CPUS;
 }
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.70-bk11/include/asm-parisc/smp.h working-2.5.70-bk11-tmp/include/asm-parisc/smp.h
--- linux-2.5.70-bk11/include/asm-parisc/smp.h	2003-02-11 14:26:16.000000000 +1100
+++ working-2.5.70-bk11-tmp/include/asm-parisc/smp.h	2003-06-07 16:07:21.000000000 +1000
@@ -60,12 +60,12 @@ extern inline unsigned int num_online_cp
 	return hweight32(cpu_online_map);
 }
 
-extern inline int any_online_cpu(unsigned int mask)
+extern inline unsigned int any_online_cpu(unsigned int mask)
 {
 	if (mask & cpu_online_map)
 		return __ffs(mask & cpu_online_map);
 
-	return -1;
+	return NR_CPUS;
 }
 #endif /* CONFIG_SMP */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.70-bk11/include/asm-ppc/smp.h working-2.5.70-bk11-tmp/include/asm-ppc/smp.h
--- linux-2.5.70-bk11/include/asm-ppc/smp.h	2003-01-02 12:27:50.000000000 +1100
+++ working-2.5.70-bk11-tmp/include/asm-ppc/smp.h	2003-06-07 16:07:27.000000000 +1000
@@ -53,12 +53,12 @@ extern inline unsigned int num_online_cp
 	return hweight32(cpu_online_map);
 }
 
-extern inline int any_online_cpu(unsigned int mask)
+extern inline unsigned int any_online_cpu(unsigned int mask)
 {
 	if (mask & cpu_online_map)
 		return __ffs(mask & cpu_online_map);
 
-	return -1;
+	return NR_CPUS;
 }
 
 extern int __cpu_up(unsigned int cpu);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.70-bk11/include/asm-s390/smp.h working-2.5.70-bk11-tmp/include/asm-s390/smp.h
--- linux-2.5.70-bk11/include/asm-s390/smp.h	2003-04-20 18:05:13.000000000 +1000
+++ working-2.5.70-bk11-tmp/include/asm-s390/smp.h	2003-06-07 16:07:35.000000000 +1000
@@ -59,12 +59,12 @@ extern inline unsigned int num_online_cp
 #endif /* __s390x__ */
 }
 
-extern inline int any_online_cpu(unsigned int mask)
+extern inline unsigned int any_online_cpu(unsigned int mask)
 {
 	if (mask & cpu_online_map)
 		return __ffs(mask & cpu_online_map);
 
-	return -1;
+	return NR_CPUS;
 }
 
 extern __inline__ __u16 hard_smp_processor_id(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.70-bk11/include/asm-sparc64/smp.h working-2.5.70-bk11-tmp/include/asm-sparc64/smp.h
--- linux-2.5.70-bk11/include/asm-sparc64/smp.h	2003-02-07 19:20:43.000000000 +1100
+++ working-2.5.70-bk11-tmp/include/asm-sparc64/smp.h	2003-06-07 16:07:42.000000000 +1000
@@ -80,11 +80,11 @@ extern atomic_t sparc64_num_cpus_online;
 extern atomic_t sparc64_num_cpus_possible;
 #define num_possible_cpus()	(atomic_read(&sparc64_num_cpus_possible))
 
-static inline int any_online_cpu(unsigned long mask)
+static inline unsigned int any_online_cpu(unsigned long mask)
 {
 	if ((mask &= cpu_online_map) != 0UL)
 		return __ffs(mask);
-	return -1;
+	return NR_CPUS;
 }
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.70-bk11/include/asm-x86_64/smp.h working-2.5.70-bk11-tmp/include/asm-x86_64/smp.h
--- linux-2.5.70-bk11/include/asm-x86_64/smp.h	2003-06-07 15:22:57.000000000 +1000
+++ working-2.5.70-bk11-tmp/include/asm-x86_64/smp.h	2003-06-07 16:07:54.000000000 +1000
@@ -64,12 +64,12 @@ extern volatile unsigned long cpu_callou
 	    cpu = __ffs(mask), mask != 0; \
 	    mask &= ~(1UL<<cpu))
 
-extern inline int any_online_cpu(unsigned int mask)
+extern inline unsigned int any_online_cpu(unsigned int mask)
 {
 	if (mask & cpu_online_map)
 		return __ffs(mask & cpu_online_map);
 
-		return -1; 
+	return NR_CPUS; 
 } 
 
 extern inline unsigned int num_online_cpus(void)
