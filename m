Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318051AbSGLW51>; Fri, 12 Jul 2002 18:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318058AbSGLW50>; Fri, 12 Jul 2002 18:57:26 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:39144 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318051AbSGLW5Z>;
	Fri, 12 Jul 2002 18:57:25 -0400
Date: Fri, 12 Jul 2002 15:58:50 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
cc: colpatch@us.ibm.com
Subject: Re: NUMA-Q breakage 2/7 xquad_portio ioremap deadlock
Message-ID: <1176230000.1026514730@flay>
In-Reply-To: <20020712223942.GZ25360@holomorphy.com>
References: <20020712223942.GZ25360@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The cpu_online_map stuff for hotplug cpu created a brand new bootstrap
> ordering problem for NUMA-Q. The mmapped portio region needs to be
> ioremapped early but ioremap attempts to do TLB shootdown, and
> smp_call_function() (called by flush_tlb_all()) deadlocks when
> cpu_online_map is uninitialized.
> 
> Workaround (due to Matt Dobson) below.
> 
> 
> 
> diff -Nur linux-2.5.23-vanilla/arch/i386/kernel/smp.c linux-2.5.23-patched/arch/i386/kernel/smp.c
> --- linux-2.5.23-vanilla/arch/i386/kernel/smp.c	Tue Jun 18 19:11:47 2002
> +++ linux-2.5.23-patched/arch/i386/kernel/smp.c	Mon Jul  8 14:52:32 2002
> @@ -569,7 +569,7 @@
>  	struct call_data_struct data;
>  	int cpus = num_online_cpus()-1;
>  
> -	if (!cpus)
> +	if (cpus <= 0)
>  		return 0;
>  
>  	data.func = func;

Would it be slightly less of a hack if we just move the ioremap down below
set_bit(0, &cpu_online_map); later on in smp_boot_cpus ? Untested patch
below. As long as we set up the xquad_portio remap before any other cpus 
are online, I can't see it matters exactly when we do it ....

Either that, or we just define cpu_online_map to be =1 to start with.

M.

--- virgin-2.5.25/arch/i386/kernel/smpboot.c	Fri Jul  5 16:42:23 2002
+++ linux-2.5.25-ioremap/arch/i386/kernel/smpboot.c	Fri Jul 12 15:55:20 2002
@@ -1019,16 +1019,6 @@
 {
 	int apicid, cpu, bit;
 
-        if (clustered_apic_mode && (numnodes > 1)) {
-                printk("Remapping cross-quad port I/O for %d quads\n",
-			numnodes);
-                printk("xquad_portio vaddr 0x%08lx, len %08lx\n",
-                        (u_long) xquad_portio, 
-			(u_long) numnodes * XQUAD_PORTIO_LEN);
-                xquad_portio = ioremap (XQUAD_PORTIO_BASE, 
-			numnodes * XQUAD_PORTIO_LEN);
-        }
-
 #ifdef CONFIG_MTRR
 	/*  Must be done before other processors booted  */
 	mtrr_init_boot_cpu ();
@@ -1126,6 +1116,16 @@
 
 	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_physical_apicid)
 		BUG();
+
+        if (clustered_apic_mode && (numnodes > 1)) {
+                printk("Remapping cross-quad port I/O for %d quads\n",
+			numnodes);
+                printk("xquad_portio vaddr 0x%08lx, len %08lx\n",
+                        (u_long) xquad_portio, 
+			(u_long) numnodes * XQUAD_PORTIO_LEN);
+                xquad_portio = ioremap (XQUAD_PORTIO_BASE, 
+			numnodes * XQUAD_PORTIO_LEN);
+        }
 
 	/*
 	 * Scan the CPU present map and fire up the other CPUs via do_boot_cpu

