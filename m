Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbUEFS6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUEFS6p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 14:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUEFS62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 14:58:28 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:64334 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262142AbUEFStx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 14:49:53 -0400
Date: Thu, 6 May 2004 11:49:11 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matthew Dobson <colpatch@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Joe Korty <joe.korty@ccur.com>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: [PATCH mask 13/15] mask7-cpumask-etc-fixup
Message-Id: <20040506114911.487bcbfa.pj@sgi.com>
In-Reply-To: <20040506111814.62d1f537.pj@sgi.com>
References: <20040506111814.62d1f537.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mask7-cpumask-etc-fixup
	Remove by recoding other uses of the obsolete cpumask const,
	coerce and promote macros.

Index: 2.6.6-rc3-mm2-bitmapv5/arch/ppc64/kernel/open_pic.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/arch/ppc64/kernel/open_pic.c	2004-05-05 06:07:40.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/arch/ppc64/kernel/open_pic.c	2004-05-05 06:36:15.000000000 -0700
@@ -591,7 +591,7 @@
 void openpic_init_processor(u_int cpumask)
 {
 	openpic_write(&OpenPIC->Global.Processor_Initialization,
-		      physmask(cpumask & cpus_coerce(cpu_online_map)));
+		      physmask(cpumask & cpus_addr(cpu_online_map)[0]));
 }
 
 #ifdef CONFIG_SMP
@@ -625,7 +625,7 @@
 	CHECK_THIS_CPU;
 	check_arg_ipi(ipi);
 	openpic_write(&OpenPIC->THIS_CPU.IPI_Dispatch(ipi),
-		      physmask(cpumask & cpus_coerce(cpu_online_map)));
+		      physmask(cpumask & cpus_addr(cpu_online_map)[0]));
 }
 
 void openpic_request_IPIs(void)
@@ -711,7 +711,7 @@
 {
 	check_arg_timer(timer);
 	openpic_write(&OpenPIC->Global.Timer[timer].Destination,
-		      physmask(cpumask & cpus_coerce(cpu_online_map)));
+		      physmask(cpumask & cpus_addr(cpu_online_map)[0]));
 }
 
 
@@ -844,7 +844,7 @@
 	cpumask_t tmp;
 
 	cpus_and(tmp, cpumask, cpu_online_map);
-	openpic_mapirq(irq_nr - open_pic_irq_offset, physmask(cpus_coerce(tmp)));
+	openpic_mapirq(irq_nr - open_pic_irq_offset, physmask(cpus_addr(tmp)[0]));
 }
 
 #ifdef CONFIG_SMP
Index: 2.6.6-rc3-mm2-bitmapv5/arch/ppc64/kernel/rtasd.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/arch/ppc64/kernel/rtasd.c	2004-05-05 06:07:40.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/arch/ppc64/kernel/rtasd.c	2004-05-05 06:36:15.000000000 -0700
@@ -415,7 +415,7 @@
 	}
 
 	lock_cpu_hotplug();
-	cpu = first_cpu_const(mk_cpumask_const(cpu_online_map));
+	cpu = first_cpu(cpu_online_map);
 	for (;;) {
 		set_cpus_allowed(current, cpumask_of_cpu(cpu));
 		do_event_scan(event_scan);
@@ -429,9 +429,9 @@
 		schedule_timeout((HZ*60/rtas_event_scan_rate) / 2);
 		lock_cpu_hotplug();
 
-		cpu = next_cpu_const(cpu, mk_cpumask_const(cpu_online_map));
+		cpu = next_cpu(cpu, cpu_online_map);
 		if (cpu == NR_CPUS)
-			cpu = first_cpu_const(mk_cpumask_const(cpu_online_map));
+			cpu = first_cpu(cpu_online_map);
 	}
 
 error:
Index: 2.6.6-rc3-mm2-bitmapv5/arch/x86_64/kernel/io_apic.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/arch/x86_64/kernel/io_apic.c	2004-05-05 06:11:36.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/arch/x86_64/kernel/io_apic.c	2004-05-05 06:36:15.000000000 -0700
@@ -1383,7 +1383,7 @@
 	unsigned long flags;
 	unsigned int dest;
 
-	dest = cpu_mask_to_apicid(mk_cpumask_const(mask));
+	dest = cpu_mask_to_apicid(mask);
 
 	/*
 	 * Only the first 8 bits are valid.
Index: 2.6.6-rc3-mm2-bitmapv5/arch/x86_64/kernel/pci-gart.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/arch/x86_64/kernel/pci-gart.c	2004-05-05 06:07:49.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/arch/x86_64/kernel/pci-gart.c	2004-05-05 06:36:15.000000000 -0700
@@ -149,7 +149,7 @@
 { 
 	unsigned long flags;
 	int bus = dev ? dev->bus->number : -1;
-	cpumask_const_t bus_cpumask = pcibus_to_cpumask(bus);
+	cpumask_t bus_cpumask = pcibus_to_cpumask(bus);
 	int flushed = 0;
 	int i;
 
@@ -159,7 +159,7 @@
 			u32 w;
 			if (!northbridges[i]) 
 				continue;
-			if (bus >= 0 && !(cpu_isset_const(i, bus_cpumask)))
+			if (bus >= 0 && !(cpu_isset(i, bus_cpumask)))
 				continue;
 			pci_write_config_dword(northbridges[i], 0x9c, 
 					       northbridge_flush_word[i] | 1); 
Index: 2.6.6-rc3-mm2-bitmapv5/arch/x86_64/kernel/smp.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/arch/x86_64/kernel/smp.c	2004-05-05 06:11:35.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/arch/x86_64/kernel/smp.c	2004-05-05 06:36:15.000000000 -0700
@@ -94,7 +94,7 @@
 
 static inline void send_IPI_mask(cpumask_t cpumask, int vector)
 {
-	unsigned long mask = cpus_coerce(cpumask);
+	unsigned long mask = cpus_addr(cpumask)[0];
 	unsigned long cfg;
 	unsigned long flags;
 
Index: 2.6.6-rc3-mm2-bitmapv5/include/asm-x86_64/smp.h
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/include/asm-x86_64/smp.h	2004-05-05 06:09:00.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/include/asm-x86_64/smp.h	2004-05-05 06:36:15.000000000 -0700
@@ -105,7 +105,6 @@
 		return BAD_APICID;
 }
 
-#define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
 #endif /* !ASSEMBLY */
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
@@ -115,9 +114,9 @@
 #define TARGET_CPUS 1
 
 #ifndef ASSEMBLY
-static inline unsigned int cpu_mask_to_apicid(cpumask_const_t cpumask)
+static inline unsigned int cpu_mask_to_apicid(cpumask_t cpumask)
 {
-	return cpus_coerce_const(cpumask);
+	return cpus_addr(cpumask)[0];
 }
 #endif
 


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
