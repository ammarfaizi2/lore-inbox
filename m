Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317955AbSFSRrl>; Wed, 19 Jun 2002 13:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317956AbSFSRrl>; Wed, 19 Jun 2002 13:47:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31740 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317955AbSFSRri>; Wed, 19 Jun 2002 13:47:38 -0400
Subject: [PATCH] 2.5: mark variables as __initdata
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: davej@suse.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 19 Jun 2002 10:47:38 -0700
Message-Id: <1024508859.1038.50.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch marks the following variables with __initdata:

        arch/i386/kernel/mpparse.c :: static unsigned int num_processors
        arch/i386/kernel/smpboot.c :: static int smp_b_stepping
        arch/i386/kernel/smpboot.c :: static int max_cpus

The data is static and only used by __init functions so can successfully
be jettisoned after boot.  Compiled and booted successfully on an SMP
machine.

I also set max_cpus to NR_CPUS instead of -1.  Besides being the
logically correct value and simplifying a loop elsewhere, this change
allows NR_CPUS to be set to various values other than the normal 32
which is growing in utility with the hotplug CPU changes now in
mainline.

Patch is against 2.5.23.

        Robert Love

diff -urN linux-2.5.23/arch/i386/kernel/mpparse.c linux/arch/i386/kernel/mpparse.c
--- linux-2.5.23/arch/i386/kernel/mpparse.c	Tue Jun 18 19:11:51 2002
+++ linux/arch/i386/kernel/mpparse.c	Wed Jun 19 10:32:10 2002
@@ -64,7 +64,7 @@
 unsigned int boot_cpu_physical_apicid = -1U;
 unsigned int boot_cpu_logical_apicid = -1U;
 /* Internal processor count */
-static unsigned int num_processors;
+static unsigned int __initdata num_processors;
 
 /* Bitmask of physically existing CPUs */
 unsigned long phys_cpu_present_map;
diff -urN linux-2.5.23/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux-2.5.23/arch/i386/kernel/smpboot.c	Tue Jun 18 19:11:54 2002
+++ linux/arch/i386/kernel/smpboot.c	Wed Jun 19 10:32:10 2002
@@ -50,11 +50,11 @@
 #include <asm/tlbflush.h>
 #include <asm/smpboot.h>
 
-/* Set if we find a B stepping CPU			*/
-static int smp_b_stepping;
+/* Set if we find a B stepping CPU */
+static int __initdata smp_b_stepping;
 
 /* Setup configured maximum number of CPUs to activate */
-static int max_cpus = -1;
+static int __initdata max_cpus = NR_CPUS;
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
@@ -1146,7 +1146,7 @@
 
 		if (!(phys_cpu_present_map & (1 << bit)))
 			continue;
-		if ((max_cpus >= 0) && (max_cpus <= cpucount+1))
+		if (max_cpus <= cpucount+1)
 			continue;
 
 		do_boot_cpu(apicid);



