Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTKMD5O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 22:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbTKMD5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 22:57:14 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:34780 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261973AbTKMD5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 22:57:09 -0500
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC
To: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 2.4.23-rc1: cpu_sibling_map fix
Date: Wed, 12 Nov 2003 19:56:52 -0800
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GEws/cJFmTU1rex"
Message-Id: <200311121956.54438.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_GEws/cJFmTU1rex
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On summit-based machines the cpu_sibling_map data has been hosed for some 
time.  I found out why in Intel's IA-32 Software Deveveopers' Manual Vol 2 
under CPUID.  Looks like the value that cpuid returns is the one latched at 
reset, and doesn't reflect any changes made by the BIOS later:

	* Local APIC ID (high byte of EBX)--this number is the 8-bit ID that is
	  assigned to the local APIC on the processor during power up. This field
	  was introduced in the Pentium 4 processor.

Also, the code in init_intel was a bit overdesigned.  Until Intel releases a 
chip with a non-power-of-2 sibling count on it, there's no point in all that 
bit bashing.


diff -pru 2.4.23-rc1/arch/i386/kernel/setup.c rc1/arch/i386/kernel/setup.c
--- 2.4.23-rc1/arch/i386/kernel/setup.c	2003-11-11 18:09:57.000000000 -0800
+++ rc1/arch/i386/kernel/setup.c	2003-11-12 15:18:44.000000000 -0800
@@ -2461,8 +2461,6 @@ static void __init init_intel(struct cpu
 		extern	int phys_proc_id[NR_CPUS];
 		
 		u32 	eax, ebx, ecx, edx;
-		int 	index_lsb, index_msb, tmp;
-		int	initial_apic_id;
 		int 	cpu = smp_processor_id();
 
 		cpuid(1, &eax, &ebx, &ecx, &edx);
@@ -2471,11 +2469,10 @@ static void __init init_intel(struct cpu
 		if (smp_num_siblings == 1) {
 			printk(KERN_INFO  "CPU: Hyper-Threading is disabled\n");
 		} else if (smp_num_siblings > 1 ) {
-			index_lsb = 0;
-			index_msb = 31;
 			/*
 			 * At this point we only support two siblings per
-			 * processor package.
+			 * processor package.  Assume will be power of 2 until
+			 * we learn otherwise.
 			 */
 #define NR_SIBLINGS	2
 			if (smp_num_siblings != NR_SIBLINGS) {
@@ -2483,20 +2480,7 @@ static void __init init_intel(struct cpu
 				smp_num_siblings = 1;
 				return;
 			}
-			tmp = smp_num_siblings;
-			while ((tmp & 1) == 0) {
-				tmp >>=1 ;
-				index_lsb++;
-			}
-			tmp = smp_num_siblings;
-			while ((tmp & 0x80000000 ) == 0) {
-				tmp <<=1 ;
-				index_msb--;
-			}
-			if (index_lsb != index_msb )
-				index_msb++;
-			initial_apic_id = ebx >> 24 & 0xff;
-			phys_proc_id[cpu] = initial_apic_id >> index_msb;
+			phys_proc_id[cpu] = hard_smp_processor_id() & ~(smp_num_siblings - 1);
 
 			printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
                                phys_proc_id[cpu]);
diff -pru 2.4.23-rc1/include/asm-i386/apicdef.h rc1/include/asm-i386/apicdef.h
--- 2.4.23-rc1/include/asm-i386/apicdef.h	2003-08-25 04:44:43.000000000 -0700
+++ rc1/include/asm-i386/apicdef.h	2003-11-12 16:32:54.000000000 -0800
@@ -11,8 +11,8 @@
 #define		APIC_DEFAULT_PHYS_BASE	0xfee00000
  
 #define		APIC_ID		0x20
-#define			APIC_ID_MASK		(0x0F<<24)
-#define			GET_APIC_ID(x)		(((x)>>24)&0x0F)
+#define			APIC_ID_MASK		(0xFFu<<24)
+#define			GET_APIC_ID(x)		(((unsigned)(x)>>24)&0xFF)
 #define		APIC_LVR	0x30
 #define			APIC_LVR_MASK		0xFF00FF
 #define			GET_APIC_VERSION(x)	((x)&0xFF)

--Boundary-00=_GEws/cJFmTU1rex
Content-Type: text/x-diff;
  charset="us-ascii";
  name="cpu_sibling_map_2003-11-12_2.4.23-rc1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cpu_sibling_map_2003-11-12_2.4.23-rc1"

diff -pru 2.4.23-rc1/arch/i386/kernel/setup.c rc1/arch/i386/kernel/setup.c
--- 2.4.23-rc1/arch/i386/kernel/setup.c	2003-11-11 18:09:57.000000000 -0800
+++ rc1/arch/i386/kernel/setup.c	2003-11-12 15:18:44.000000000 -0800
@@ -2461,8 +2461,6 @@ static void __init init_intel(struct cpu
 		extern	int phys_proc_id[NR_CPUS];
 		
 		u32 	eax, ebx, ecx, edx;
-		int 	index_lsb, index_msb, tmp;
-		int	initial_apic_id;
 		int 	cpu = smp_processor_id();
 
 		cpuid(1, &eax, &ebx, &ecx, &edx);
@@ -2471,11 +2469,10 @@ static void __init init_intel(struct cpu
 		if (smp_num_siblings == 1) {
 			printk(KERN_INFO  "CPU: Hyper-Threading is disabled\n");
 		} else if (smp_num_siblings > 1 ) {
-			index_lsb = 0;
-			index_msb = 31;
 			/*
 			 * At this point we only support two siblings per
-			 * processor package.
+			 * processor package.  Assume will be power of 2 until
+			 * we learn otherwise.
 			 */
 #define NR_SIBLINGS	2
 			if (smp_num_siblings != NR_SIBLINGS) {
@@ -2483,20 +2480,7 @@ static void __init init_intel(struct cpu
 				smp_num_siblings = 1;
 				return;
 			}
-			tmp = smp_num_siblings;
-			while ((tmp & 1) == 0) {
-				tmp >>=1 ;
-				index_lsb++;
-			}
-			tmp = smp_num_siblings;
-			while ((tmp & 0x80000000 ) == 0) {
-				tmp <<=1 ;
-				index_msb--;
-			}
-			if (index_lsb != index_msb )
-				index_msb++;
-			initial_apic_id = ebx >> 24 & 0xff;
-			phys_proc_id[cpu] = initial_apic_id >> index_msb;
+			phys_proc_id[cpu] = hard_smp_processor_id() & ~(smp_num_siblings - 1);
 
 			printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
                                phys_proc_id[cpu]);
diff -pru 2.4.23-rc1/include/asm-i386/apicdef.h rc1/include/asm-i386/apicdef.h
--- 2.4.23-rc1/include/asm-i386/apicdef.h	2003-08-25 04:44:43.000000000 -0700
+++ rc1/include/asm-i386/apicdef.h	2003-11-12 16:32:54.000000000 -0800
@@ -11,8 +11,8 @@
 #define		APIC_DEFAULT_PHYS_BASE	0xfee00000
  
 #define		APIC_ID		0x20
-#define			APIC_ID_MASK		(0x0F<<24)
-#define			GET_APIC_ID(x)		(((x)>>24)&0x0F)
+#define			APIC_ID_MASK		(0xFFu<<24)
+#define			GET_APIC_ID(x)		(((unsigned)(x)>>24)&0xFF)
 #define		APIC_LVR	0x30
 #define			APIC_LVR_MASK		0xFF00FF
 #define			GET_APIC_VERSION(x)	((x)&0xFF)

--Boundary-00=_GEws/cJFmTU1rex--

