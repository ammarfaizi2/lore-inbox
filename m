Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317470AbSGYGv3>; Thu, 25 Jul 2002 02:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318347AbSGYGv3>; Thu, 25 Jul 2002 02:51:29 -0400
Received: from [196.26.86.1] ([196.26.86.1]:35276 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317470AbSGYGv2>; Thu, 25 Jul 2002 02:51:28 -0400
Date: Thu, 25 Jul 2002 09:11:36 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc3-ac2 SMP
In-Reply-To: <200207242034.01605.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0207250859590.17209-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002, James Cleverdon wrote:

> Ah ha!  Note that while the CPU records in the {MPS,ACPI/MADT} table are in 
> numerical order (as preserved in raw_phys_apicid), the boot CPU is # 02.  The 
> flat code in smp_boot_cpus assumes that the boot CPU will be the first record 
> in the list.  Oops.

Ok i'll give it a whirl, in that case how about the following code to do 
the BSP check in another area too?

Index: linux-2.4.19-rc3-ac2/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /home/zwane/source/cvs_rep/linux-2.4.19-rc3-ac2/arch/i386/kernel/smpboot.c,v
retrieving revision 1.2
diff -u -r1.2 smpboot.c
--- linux-2.4.19-rc3-ac2/arch/i386/kernel/smpboot.c	2002/07/25 06:06:56	1.2
+++ linux-2.4.19-rc3-ac2/arch/i386/kernel/smpboot.c	2002/07/25 06:15:05
@@ -46,6 +46,7 @@
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
 #include <asm/smpboot.h>
+#include <asm/msr.h>
 
 /* Set if we find a B stepping CPU			*/
 static int smp_b_stepping;
@@ -229,6 +230,14 @@
 	return res;
 }
 
+int smp_cpu_is_bsp (void)
+{
+	unsigned long l, h;
+	
+	rdmsr(MSR_IA32_APICBASE, l, h);
+	return (l & MSR_IA32_APICBASE_BSP);
+}
+
 static void __init synchronize_tsc_bp (void)
 {
 	int i;
@@ -1067,7 +1076,7 @@
 	connect_bsp_APIC();
 	setup_local_APIC();
 
-	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_physical_apicid)
+	if (!smp_cpu_is_bsp())
 		BUG();
 
 	/*

-- 
function.linuxpower.ca

