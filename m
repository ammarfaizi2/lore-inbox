Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316637AbSFUPKh>; Fri, 21 Jun 2002 11:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316644AbSFUPKg>; Fri, 21 Jun 2002 11:10:36 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:65337 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S316637AbSFUPKd>; Fri, 21 Jun 2002 11:10:33 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Optimisation for smp_num_cpus loop in hotplug 
In-reply-to: Your message of "Thu, 20 Jun 2002 19:41:52 -0400."
             <200206202341.g5KNfqU07377@localhost.localdomain> 
Date: Sat, 22 Jun 2002 01:14:46 +1000
Message-Id: <E17LQ7b-0000Iz-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200206202341.g5KNfqU07377@localhost.localdomain> you write:
> The hotplug CPU patch introduces this to replace the loop over all active CPUs 
> abstraction:
> 
> 	for (i = 0; i < NR_CPUS; i++) {
> 		if (!cpu_online(i))
> 			continue;

Yeah, it's simple, and none of the current ones are really critical.
But I think we're better off with:
	for (i = first_cpu(); i < NR_CPUS; i = next_cpu(i)) {

Which is simple enough not to need an iterator macro, and also has the
bonus of giving irq-balancing et al. an efficient, portable way of
looking for the "next" cpu.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: CPU iterator patch
Author: Rusty Russell
Status: Trivial

D: This patch adds first_cpu() & next_cpu(cpu) for more efficient cpu
D: iteration.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.24/include/asm-i386/smp.h working-2.5.24-cpu-iter/include/asm-i386/smp.h
--- linux-2.5.24/include/asm-i386/smp.h	Thu Jun 20 01:28:51 2002
+++ working-2.5.24-cpu-iter/include/asm-i386/smp.h	Sat Jun 22 00:55:46 2002
@@ -107,6 +107,18 @@
 	return -1;
 }
 
+/* x86 is always linear, ie. cpu_online(0) always true at the moment. */
+static inline unsigned int first_cpu(void)
+{
+	return 0;
+}
+
+/* Return "next" online cpu.  Returns NR_CPUS on end. */
+static inline unsigned int next_cpu(unsigned int cpu)
+{
+	return find_next_bit(&cpu_online_map, NR_CPUS, cpu+1);
+}
+
 static __inline int hard_smp_processor_id(void)
 {
 	/* we don't want to mark this access volatile - bad code generation */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.24/include/asm-ia64/smp.h working-2.5.24-cpu-iter/include/asm-ia64/smp.h
--- linux-2.5.24/include/asm-ia64/smp.h	Thu Jun 20 01:28:51 2002
+++ working-2.5.24-cpu-iter/include/asm-ia64/smp.h	Sat Jun 22 00:59:34 2002
@@ -45,6 +45,17 @@
 
 extern unsigned long ap_wakeup_vector;
 
+static inline unsigned int first_cpu(void)
+{
+	return __ffs(cpu_online_map);
+}
+
+/* Return "next" online cpu.  Returns NR_CPUS on end. */
+static inline unsigned int next_cpu(unsigned int cpu)
+{
+	return find_next_bit(&cpu_online_map, NR_CPUS, cpu+1);
+}
+
 #define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
 extern inline unsigned int num_online_cpus(void)
 {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.24/include/asm-ppc/smp.h working-2.5.24-cpu-iter/include/asm-ppc/smp.h
--- linux-2.5.24/include/asm-ppc/smp.h	Thu Jun 20 01:28:51 2002
+++ working-2.5.24-cpu-iter/include/asm-ppc/smp.h	Sat Jun 22 00:58:37 2002
@@ -47,6 +47,17 @@
 
 #define smp_processor_id() (current_thread_info()->cpu)
 
+static inline unsigned int first_cpu(void)
+{
+	return __ffs(cpu_online_map);
+}
+
+/* Return "next" online cpu.  Returns NR_CPUS on end. */
+static inline unsigned int next_cpu(unsigned int cpu)
+{
+	return find_next_bit(&cpu_online_map, NR_CPUS, cpu+1);
+}
+
 #define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
 
 extern inline unsigned int num_online_cpus(void)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.24/include/asm-sparc64/smp.h working-2.5.24-cpu-iter/include/asm-sparc64/smp.h
--- linux-2.5.24/include/asm-sparc64/smp.h	Fri Jun 21 09:41:55 2002
+++ working-2.5.24-cpu-iter/include/asm-sparc64/smp.h	Sat Jun 22 01:06:58 2002
@@ -77,6 +77,17 @@
 	return -1;
 }
 
+static inline unsigned int first_cpu(void)
+{
+	return __ffs(cpu_online_map);
+}
+
+/* Return "next" online cpu.  Returns NR_CPUS on end. */
+static inline unsigned int next_cpu(unsigned int cpu)
+{
+	return find_next_bit(&cpu_online_map, NR_CPUS, cpu+1);
+}
+
 /*
  *	General functions that each host system must provide.
  */
