Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTFPGij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 02:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTFPGh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 02:37:29 -0400
Received: from dp.samba.org ([66.70.73.150]:14016 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263458AbTFPGhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 02:37:06 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] any_online_cpus returns NR_CPUS on failure.
Date: Mon, 16 Jun 2003 15:53:43 +1000
Message-Id: <20030616065058.D80AD2C0C0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

I prefer any_online_cpus() to return NR_CPUS if no CPUs in the mask
are online, which matches find_first_bit/find_next_bit(), rather than
-1.

Noone uses the return value at the moment, so the change is still
trivial.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: any_online_cpu to return NR_CPUS
Author: Rusty Russell
Status: Trivial

D: Matt Fleming points out that returning int from any_online_cpu
D: where cpu numbers are passed as unsigned ints elsewhere is awkward
D: and a little dangerous.
D:
D: Make any_online_cpu() match find_first_bit(), by returning NR_CPUS
D: when no cpu is found, rather than -1.  This also simplifies the
D: future case where NR_CPUS > BITS_PER_LONG.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29838-linux-2.5.71-bk1/include/asm-i386/smp.h .29838-linux-2.5.71-bk1.updated/include/asm-i386/smp.h
--- .29838-linux-2.5.71-bk1/include/asm-i386/smp.h	2003-06-15 11:30:07.000000000 +1000
+++ .29838-linux-2.5.71-bk1.updated/include/asm-i386/smp.h	2003-06-16 15:45:35.000000000 +1000
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
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29838-linux-2.5.71-bk1/include/asm-ia64/smp.h .29838-linux-2.5.71-bk1.updated/include/asm-ia64/smp.h
--- .29838-linux-2.5.71-bk1/include/asm-ia64/smp.h	2003-06-15 11:30:07.000000000 +1000
+++ .29838-linux-2.5.71-bk1.updated/include/asm-ia64/smp.h	2003-06-16 15:45:35.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29838-linux-2.5.71-bk1/include/asm-parisc/smp.h .29838-linux-2.5.71-bk1.updated/include/asm-parisc/smp.h
--- .29838-linux-2.5.71-bk1/include/asm-parisc/smp.h	2003-02-11 14:26:16.000000000 +1100
+++ .29838-linux-2.5.71-bk1.updated/include/asm-parisc/smp.h	2003-06-16 15:45:35.000000000 +1000
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
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29838-linux-2.5.71-bk1/include/asm-ppc/smp.h .29838-linux-2.5.71-bk1.updated/include/asm-ppc/smp.h
--- .29838-linux-2.5.71-bk1/include/asm-ppc/smp.h	2003-01-02 12:27:50.000000000 +1100
+++ .29838-linux-2.5.71-bk1.updated/include/asm-ppc/smp.h	2003-06-16 15:45:35.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29838-linux-2.5.71-bk1/include/asm-s390/smp.h .29838-linux-2.5.71-bk1.updated/include/asm-s390/smp.h
--- .29838-linux-2.5.71-bk1/include/asm-s390/smp.h	2003-04-20 18:05:13.000000000 +1000
+++ .29838-linux-2.5.71-bk1.updated/include/asm-s390/smp.h	2003-06-16 15:45:35.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29838-linux-2.5.71-bk1/include/asm-sparc64/smp.h .29838-linux-2.5.71-bk1.updated/include/asm-sparc64/smp.h
--- .29838-linux-2.5.71-bk1/include/asm-sparc64/smp.h	2003-02-07 19:20:43.000000000 +1100
+++ .29838-linux-2.5.71-bk1.updated/include/asm-sparc64/smp.h	2003-06-16 15:45:35.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29838-linux-2.5.71-bk1/include/asm-x86_64/smp.h .29838-linux-2.5.71-bk1.updated/include/asm-x86_64/smp.h
--- .29838-linux-2.5.71-bk1/include/asm-x86_64/smp.h	2003-06-15 11:30:08.000000000 +1000
+++ .29838-linux-2.5.71-bk1.updated/include/asm-x86_64/smp.h	2003-06-16 15:45:35.000000000 +1000
@@ -66,12 +66,12 @@ extern volatile unsigned long cpu_callou
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
