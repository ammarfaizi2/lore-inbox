Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTLPUwl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 15:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbTLPUwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 15:52:41 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:24550 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262196AbTLPUwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 15:52:37 -0500
Date: Tue, 16 Dec 2003 12:52:29 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH]  > 256 CPU cpumask build fix - const confusion
Message-Id: <20031216125229.14871a4e.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Could you please apply the following patch.  It is needed
to build kernels with > 256 CPUs.

This patch actually went out to you and lkml Nov 4 (to which
you replied requesting a fix) and Nov 5 (fixed as requested).

I am guessing that it has gotten lost in the mists of time by
now, so I am retransmitting.

I have recomputed the patch to go on top of test 11 _plus_
the "rearrange cpumask.h headers" patch (Take 2) sent earlier
today, though either version of the following patch should
apply with or without the header rearrange patch -- modulo
line number offsets.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1497  -> 1.1498 
#	include/asm-generic/cpumask_const_value.h	1.1     -> 1.2    
#	include/linux/cpumask.h	1.2     -> 1.3    
#	include/asm-i386/mach-default/mach_apic.h	1.28    -> 1.29   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/12/16	pj@sgi.com	1.1498
# Patch to build with NR_CPUS > 256.
# 
# It now builds with gcc 2.95.3, as well as gcc 3.3.
# 
# The key additional change (between Nov 4 and 5) was removing
# the cast to (cpumask_const_t) in the mk_cpumask_const() macro,
# for the cpumask_const_value case.  gcc 2.x compilers cannot
# take the address of a cast variable, if both the variable and
# the cast have typedef specified types (not even if the cast
# is to the same type).  The removed cast didn't do anything
# in this case anyway.
# 
# It builds successfully for NR_CPUS in {1, 8, 32, 64, 128,
# 256} for gcc 2.95.3 and 3.3 on i386, and for 3.3.2 on ia64.
# Also builds 512 NR_CPUS on ia64.
# 
# The 512 build on i386 fails due to unrelated reason - an overflow
# of cpu_gdt_table in arch/i386/kernel/head.S.  That failure is not
# addressed in this patch.
# 
# The build fix in mach_apic.h that takes i386 from 128 CPUs to
# 256 will probably never be tested.  For less than 128 CPUs,
# it amounts to the application of the literal no-op macro
# mk_cpumask_const(), so "can't break anything".  If you'd
# rather have this patch without the mach_apic.h change, just ask.
# 
# The individual file comments are:
# 
#   include/linux/cpumask.h
#     Build fails if NR_CPUS > 128 (i386) or > 256 (ia64), with:
#         include/linux/cpumask.h: In function `next_online_cpu':
#         include/linux/cpumask.h:56: structure has no member named `val'
#     Fix - add missing mk_cpumask_const() macro calls.
# 
#   include/asm-i386/mach-default/mach_apic.h
#     Have target_cpus return cpumask_const_t, to match type passed
#     into apic setup routines.  Fixes 3 i386 build errors:
#       incompatible type for argument 1 of `cpu_mask_to_apicid'
# 
#   include/asm-generic/cpumask_const_value.h
#     Dont cast cpumask: gcc 2.95.3 (3.3 ok) fails:
# 	"invalid lvalue in unary `&'"
#     taking address of any variable of typedef type
# 	that's cast to typedef type.
# --------------------------------------------
#
diff -Nru a/include/asm-generic/cpumask_const_value.h b/include/asm-generic/cpumask_const_value.h
--- a/include/asm-generic/cpumask_const_value.h	Tue Dec 16 12:39:57 2003
+++ b/include/asm-generic/cpumask_const_value.h	Tue Dec 16 12:39:57 2003
@@ -3,7 +3,7 @@
 
 typedef const cpumask_t cpumask_const_t;
 
-#define mk_cpumask_const(map)		((cpumask_const_t)(map))
+#define mk_cpumask_const(map)		(map)
 #define cpu_isset_const(cpu, map)	cpu_isset(cpu, map)
 #define cpus_and_const(dst,src1,src2)	cpus_and(dst, src1, src2)
 #define cpus_or_const(dst,src1,src2)	cpus_or(dst, src1, src2)
diff -Nru a/include/asm-i386/mach-default/mach_apic.h b/include/asm-i386/mach-default/mach_apic.h
--- a/include/asm-i386/mach-default/mach_apic.h	Tue Dec 16 12:39:57 2003
+++ b/include/asm-i386/mach-default/mach_apic.h	Tue Dec 16 12:39:57 2003
@@ -5,12 +5,12 @@
 
 #define APIC_DFR_VALUE	(APIC_DFR_FLAT)
 
-static inline cpumask_t target_cpus(void)
+static inline cpumask_const_t target_cpus(void)
 { 
 #ifdef CONFIG_SMP
-	return cpu_online_map;
+	return mk_cpumask_const(cpu_online_map);
 #else
-	return cpumask_of_cpu(0);
+	return mk_cpumask_const(cpumask_of_cpu(0));
 #endif
 } 
 #define TARGET_CPUS (target_cpus())
diff -Nru a/include/linux/cpumask.h b/include/linux/cpumask.h
--- a/include/linux/cpumask.h	Tue Dec 16 12:39:57 2003
+++ b/include/linux/cpumask.h	Tue Dec 16 12:39:57 2003
@@ -20,18 +20,18 @@
 static inline int next_online_cpu(int cpu, cpumask_t map)
 {
 	do
-		cpu = next_cpu_const(cpu, map);
+		cpu = next_cpu_const(cpu, mk_cpumask_const(map));
 	while (cpu < NR_CPUS && !cpu_online(cpu));
 	return cpu;
 }
 
 #define for_each_cpu(cpu, map)						\
-	for (cpu = first_cpu_const(map);				\
+	for (cpu = first_cpu_const(mk_cpumask_const(map));		\
 		cpu < NR_CPUS;						\
-		cpu = next_cpu_const(cpu,map))
+		cpu = next_cpu_const(cpu,mk_cpumask_const(map)))
 
 #define for_each_online_cpu(cpu, map)					\
-	for (cpu = first_cpu_const(map);				\
+	for (cpu = first_cpu_const(mk_cpumask_const(map));		\
 		cpu < NR_CPUS;						\
 		cpu = next_online_cpu(cpu,map))
 


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
