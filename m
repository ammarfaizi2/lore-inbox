Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTKLBTl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 20:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbTKLBTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 20:19:41 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18334 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261336AbTKLBTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 20:19:34 -0500
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: [PATCH] 2.6.0-test9-mm2: cpu_sibling_map fix
Date: Tue, 11 Nov 2003 17:19:21 -0800
User-Agent: KMail/1.5
Cc: John Stultz <johnstul@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311111719.23690.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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


diff -pru 2.6.0-test9-mm2/arch/i386/kernel/cpu/intel.c 
q9m2/arch/i386/kernel/cpu/intel.c
--- 2.6.0-test9-mm2/arch/i386/kernel/cpu/intel.c	2003-11-11 11:38:01.000000000 
-0800
+++ q9m2/arch/i386/kernel/cpu/intel.c	2003-11-11 16:16:56.000000000 -0800
@@ -276,8 +276,6 @@ static void __init init_intel(struct cpu
 		extern	int phys_proc_id[NR_CPUS];
 		
 		u32 	eax, ebx, ecx, edx;
-		int 	index_lsb, index_msb, tmp;
-		int	initial_apic_id;
 		int 	cpu = smp_processor_id();
 
 		cpuid(1, &eax, &ebx, &ecx, &edx);
@@ -286,8 +284,6 @@ static void __init init_intel(struct cpu
 		if (smp_num_siblings == 1) {
 			printk(KERN_INFO  "CPU: Hyper-Threading is disabled\n");
 		} else if (smp_num_siblings > 1 ) {
-			index_lsb = 0;
-			index_msb = 31;
 			/*
 			 * At this point we only support two siblings per
 			 * processor package.
@@ -298,20 +294,13 @@ static void __init init_intel(struct cpu
 				smp_num_siblings = 1;
 				goto too_many_siblings;
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
+			/* cpuid returns the value latched in the HW at reset,
+			 * not the APIC ID register's value.  For any box
+			 * whose BIOS changes APIC IDs, like clustered APIC
+			 * systems, we must use hard_smp_processor_id.
+			 * See Intel's IA-32 SW Dev's Manual Vol2 under CPUID.
+			 */
+			phys_proc_id[cpu] = hard_smp_processor_id() & ~(smp_num_siblings - 1);
 
 			printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
                                phys_proc_id[cpu]);

