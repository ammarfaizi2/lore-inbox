Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSFFKGp>; Thu, 6 Jun 2002 06:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316080AbSFFKGo>; Thu, 6 Jun 2002 06:06:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16145 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315748AbSFFKGn>;
	Thu, 6 Jun 2002 06:06:43 -0400
Message-ID: <3CFF3504.1DCD24E7@zip.com.au>
Date: Thu, 06 Jun 2002 03:10:12 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] CONFIG_NR_CPUS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reducing NR_CPUS from 32 to 2 reduces the kernel footprint by
approximately 240 kilobytes.

Before:
   text    data     bss     dec     hex filename
2120633  283268  251572 2655473  2884f1 vmlinux

After:
   text    data     bss     dec     hex filename
2120777  390116  384308 2895201  2c2d61 vmlinux




--- 2.5.20/arch/i386/config.in~config_nr_cpus	Thu Jun  6 02:47:35 2002
+++ 2.5.20-akpm/arch/i386/config.in	Thu Jun  6 02:47:35 2002
@@ -185,8 +185,8 @@ fi
 
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
-bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'Preemptible Kernel' CONFIG_PREEMPT
+bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Local APIC support on uniprocessors' CONFIG_X86_UP_APIC
    dep_bool 'IO-APIC support on uniprocessors' CONFIG_X86_UP_IOAPIC $CONFIG_X86_UP_APIC
@@ -197,6 +197,7 @@ if [ "$CONFIG_SMP" != "y" ]; then
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
 fi
 
--- 2.5.20/include/linux/threads.h~config_nr_cpus	Thu Jun  6 02:47:35 2002
+++ 2.5.20-akpm/include/linux/threads.h	Thu Jun  6 02:47:35 2002
@@ -9,7 +9,13 @@
  */
  
 #ifdef CONFIG_SMP
+
+#ifdef CONFIG_NR_CPUS
+#define NR_CPUS CONFIG_NR_CPUS
+#else
 #define NR_CPUS	32		/* Max processors that can be running in SMP */
+#endif
+
 #else
 #define NR_CPUS 1
 #endif
--- 2.5.20/arch/i386/Config.help~config_nr_cpus	Thu Jun  6 02:47:35 2002
+++ 2.5.20-akpm/arch/i386/Config.help	Thu Jun  6 02:47:35 2002
@@ -25,6 +25,14 @@ CONFIG_SMP
 
   If you don't know what to do here, say N.
 
+CONFIG_NR_CPUS
+  This allows you to specify the maximum number of CPUs which this
+  kernel will support.  The maximum supported value is 32 and the
+  mimimum value which makes sense is 2.
+
+  This is purely to save memory - each supported CPU adds
+  approximately eight kilobytes to the kernel image.
+
 CONFIG_PREEMPT
   This option reduces the latency of the kernel when reacting to
   real-time or interactive events by allowing a low priority process to
--- 2.5.20/arch/i386/kernel/smpboot.c~config_nr_cpus	Thu Jun  6 02:53:20 2002
+++ 2.5.20-akpm/arch/i386/kernel/smpboot.c	Thu Jun  6 02:57:35 2002
@@ -54,7 +54,7 @@
 static int smp_b_stepping;
 
 /* Setup configured maximum number of CPUs to activate */
-static int max_cpus = -1;
+static int max_cpus = NR_CPUS;
 
 /* Total count of live CPUs */
 int smp_num_cpus = 1;
@@ -1145,7 +1145,7 @@ void __init smp_boot_cpus(void)
 
 		if (!(phys_cpu_present_map & (1 << bit)))
 			continue;
-		if ((max_cpus >= 0) && (max_cpus <= cpucount+1))
+		if (max_cpus <= cpucount+1)
 			continue;
 
 		do_boot_cpu(apicid);

-
