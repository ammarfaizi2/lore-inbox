Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274456AbRJEXMs>; Fri, 5 Oct 2001 19:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274455AbRJEXLx>; Fri, 5 Oct 2001 19:11:53 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:19686 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S274424AbRJEXL2>; Fri, 5 Oct 2001 19:11:28 -0400
Date: Fri, 05 Oct 2001 16:07:44 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
cc: Dan Merillat <harik@chaos.ao.net>, linux-kernel@vger.kernel.org
Subject: Re: Wierd /proc/cpuinfo with 2.4.11-pre4
Message-ID: <1570684149.1002298064@mbligh.des.sequent.com>
In-Reply-To: <3BBE3DD4.27DFFDCE@oracle.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Doesn't build here...

Looks like you need the other patch I posted here too.

M.

Combined reformated patch below:

diff -urN virgin-2.4.11-pre4/arch/i386/kernel/setup.c numa-2.4.11-pre4/arch/i386/kernel/setup.c
--- virgin-2.4.11-pre4/arch/i386/kernel/setup.c	Fri Oct  5 15:39:54 2001
+++ numa-2.4.11-pre4/arch/i386/kernel/setup.c	Fri Oct  5 15:42:37 2001
@@ -2420,7 +2420,7 @@
 	 * WARNING - nasty evil hack ... if we print > 8, it overflows the
 	 * page buffer and corrupts memory - this needs fixing properly
 	 */
-	for (n = 0; n < 8; n++, c++) {
+	for (n = 0; n < (clustered_apic_mode ? 8 : NR_CPUS); n++, c++) {
 	/* for (n = 0; n < NR_CPUS; n++, c++) { */
 		int fpu_exception;
 #ifdef CONFIG_SMP
diff -urN virgin-2.4.11-pre4/include/asm-i386/smp.h numa-2.4.11-pre4/include/asm-i386/smp.h
--- virgin-2.4.11-pre4/include/asm-i386/smp.h	Fri Oct  5 15:40:46 2001
+++ numa-2.4.11-pre4/include/asm-i386/smp.h	Fri Oct  5 15:44:57 2001
@@ -22,7 +22,7 @@
 #endif
 #endif
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 # ifdef CONFIG_MULTIQUAD
 #  define TARGET_CPUS 0xf     /* all CPUs in *THIS* quad */
 #  define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
@@ -31,9 +31,20 @@
 #  define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
 # endif
 #else
+# define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
 # define TARGET_CPUS 0x01
 #endif
 
+#ifndef clustered_apic_mode
+ #ifdef CONFIG_MULTIQUAD
+  #define clustered_apic_mode (1)
+  #define esr_disable (1)
+ #else /* !CONFIG_MULTIQUAD */
+  #define clustered_apic_mode (0)
+  #define esr_disable (0)
+ #endif /* CONFIG_MULTIQUAD */
+#endif 
+
 #ifdef CONFIG_SMP
 #ifndef ASSEMBLY
 
@@ -76,16 +87,6 @@
 extern volatile int physical_apicid_to_cpu[MAX_APICID];
 extern volatile int cpu_to_logical_apicid[NR_CPUS];
 extern volatile int logical_apicid_to_cpu[MAX_APICID];
-
-#ifndef clustered_apic_mode
- #ifdef CONFIG_MULTIQUAD
-  #define clustered_apic_mode (1)
-  #define esr_disable (1)
- #else /* !CONFIG_MULTIQUAD */
-  #define clustered_apic_mode (0)
-  #define esr_disable (0)
- #endif /* CONFIG_MULTIQUAD */
-#endif 
 
 /*
  * General functions that each host system must provide.

