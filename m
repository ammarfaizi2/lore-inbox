Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbTKEPvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 10:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTKEPvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 10:51:16 -0500
Received: from zok.SGI.COM ([204.94.215.101]:30891 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262948AbTKEPvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 10:51:11 -0500
Date: Wed, 5 Nov 2003 07:50:30 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Jesse Barnes <jbarnes@sgi.com>, Simon <Simon.Derr@bull.net>,
       Stephen <shemminger@osdl.org>, Sylvain <sylvain.jeaugey@bull.net>
Subject: [PATCH] (again) > 256 CPU cpumask build fix - const confusion
Message-Id: <20031105075030.327ad43f.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please apply the following patch.  It's needed to build NR_CPUS > 256.

This replaces my cpumask build patch from yesterday.  It now builds with
gcc 2.95.3, as well as gcc 3.3.

The key change was to a single line in cpumask_const_value.h, removing
the cast to (cpumask_const_t) in the mk_cpumask_const() macro.

gcc 2.x compilers cannot take the address of a cast variable, if both
the variable and the cast have typedef specified types (not even if the
cast is to the same type).  The removed cast didn't do anything in this
case (const_value) anyway, other than annoy the compiler.

It builds successfully for NR_CPUS in {1, 8, 32, 64, 128, 256} for gcc
2.95.3 and 3.3 on i386, and for 3.3.2 on ia64.  Also builds 512 NR_CPUS
on ia64.

The 512 build on i386 fails due to unrelated reason - an overflow of
cpu_gdt_table in arch/i386/kernel/head.S.

The build fix in mach_apic.h that takes i386 from 128 CPUs to 256 will
probably never be tested.  For less than 128 CPUs, it amounts to the
application of the literal no-op macro mk_cpumask_const(), so "can't
break anything".  If you'd rather take this patch without the
mach_apic.h change, that's fine.

The individual file comments are:

  include/linux/cpumask.h
    Build fails if NR_CPUS > 128 (i386) or > 256 (ia64), with:
        include/linux/cpumask.h: In function `next_online_cpu':
        include/linux/cpumask.h:56: structure has no member named `val'
    Fix - add missing mk_cpumask_const() macro calls.

  include/asm-i386/mach-default/mach_apic.h
    Have target_cpus return cpumask_const_t, to match type passed
    into apic setup routines.  Fixes 3 i386 build errors:
      incompatible type for argument 1 of `cpu_mask_to_apicid'

  include/asm-generic/cpumask_const_value.h
    Dont cast cpumask: gcc 2.95.3 (3.3 ok) fails: "invalid lvalue in unary `&'"
    taking address of any variable of typedef type that's cast to typedef type.

This patch is against the latest http://lia64.bkbits.net/to-linus-2.5.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1357  -> 1.1358 
#	include/asm-generic/cpumask_const_value.h	1.1     -> 1.2    
#	include/linux/cpumask.h	1.1     -> 1.2    
#	include/asm-i386/mach-default/mach_apic.h	1.28    -> 1.29   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/05	pj@sgi.com	1.1358
# cpumask_t build fixes - up to 256 CPUs on i386 or 512 on ia64 build now.
# --------------------------------------------
#
diff -Nru a/include/asm-generic/cpumask_const_value.h b/include/asm-generic/cpumask_const_value.h
--- a/include/asm-generic/cpumask_const_value.h	Wed Nov  5 07:02:58 2003
+++ b/include/asm-generic/cpumask_const_value.h	Wed Nov  5 07:02:58 2003
@@ -3,7 +3,7 @@
 
 typedef const cpumask_t cpumask_const_t;
 
-#define mk_cpumask_const(map)		((cpumask_const_t)(map))
+#define mk_cpumask_const(map)		(map)
 #define cpu_isset_const(cpu, map)	cpu_isset(cpu, map)
 #define cpus_and_const(dst,src1,src2)	cpus_and(dst, src1, src2)
 #define cpus_or_const(dst,src1,src2)	cpus_or(dst, src1, src2)
diff -Nru a/include/asm-i386/mach-default/mach_apic.h b/include/asm-i386/mach-default/mach_apic.h
--- a/include/asm-i386/mach-default/mach_apic.h	Wed Nov  5 07:02:58 2003
+++ b/include/asm-i386/mach-default/mach_apic.h	Wed Nov  5 07:02:58 2003
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
--- a/include/linux/cpumask.h	Wed Nov  5 07:02:58 2003
+++ b/include/linux/cpumask.h	Wed Nov  5 07:02:58 2003
@@ -53,18 +53,18 @@
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
