Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTFTU35 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 16:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbTFTU35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 16:29:57 -0400
Received: from aneto.able.es ([212.97.163.22]:17598 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263279AbTFTU3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 16:29:51 -0400
Date: Fri, 20 Jun 2003 22:43:49 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Robert Love <rml@tech9.net>, "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: [RFC][PATCH] CONFIG_NR_CPUS for 2.4.21 (take 2)
Message-ID: <20030620204349.GA3174@werewolf.able.es>
References: <20030618222336.GC3768@werewolf.able.es> <20030618230136.GG3768@werewolf.able.es> <1055984673.8770.9.camel@localhost> <Pine.LNX.4.55L.0306201414070.12409@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.55L.0306201414070.12409@freak.distro.conectiva>; from marcelo@conectiva.com.br on Fri, Jun 20, 2003 at 19:14:50 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Here's the patch, with CONFIG_NR_CPUS defaulted to 32 on all architectures.

--- linux/Documentation/Configure.help.orig	2002-06-06 15:48:03.000000000 +0200
+++ linux/Documentation/Configure.help	2002-06-06 15:47:15.000000000 +0200
@@ -137,6 +137,15 @@
 
   If you don't know what to do here, say N.
 
+Maximum number of CPUs
+CONFIG_NR_CPUS
+  This allows you to specify the maximum number of CPUs which this
+  kernel will support.  The maximum supported value is 32 and the
+  mimimum value which makes sense is 2.
+
+  This is purely to save memory - each supported CPU adds
+  approximately eight kilobytes to the kernel image.
+
 Intel or compatible 80x86 processor
 CONFIG_X86
   This is Linux's home port.  Linux was originally native to the Intel
--- linux/include/linux/threads.h.orig	2002-06-06 15:44:27.000000000 +0200
+++ linux/include/linux/threads.h	2002-06-06 15:45:40.000000000 +0200
@@ -9,9 +9,9 @@
  */
  
 #ifdef CONFIG_SMP
-#define NR_CPUS	32		/* Max processors that can be running in SMP */
+#define NR_CPUS	CONFIG_NR_CPUS
 #else
-#define NR_CPUS 1
+#define NR_CPUS	1
 #endif

 #define MIN_THREADS_LEFT_FOR_ROOT 4
--- linux/arch/i386/kernel/smpboot.c.orig	2002-06-06 15:48:19.000000000 +0200
+++ linux/arch/i386/kernel/smpboot.c	2002-06-06 15:49:14.000000000 +0200
@@ -51,7 +51,7 @@
 static int smp_b_stepping;
 
 /* Setup configured maximum number of CPUs to activate */
-static int max_cpus = -1;
+static int max_cpus = NR_CPUS;
 
 /* Total count of live CPUs */
 int smp_num_cpus = 1;
@@ -1116,7 +1116,7 @@
 
 		if (!(phys_cpu_present_map & (1ul << bit)))
 			continue;
-		if ((max_cpus >= 0) && (max_cpus <= cpucount+1))
+		if (max_cpus <= cpucount+1)
 			continue;
 
 		do_boot_cpu(apicid);
--- linux/arch/i386/config.in.orig	2002-06-06 15:43:12.000000000 +0200
+++ linux/arch/i386/config.in	2002-06-06 15:43:37.000000000 +0200
@@ -231,6 +231,7 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
    bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
    if [ "$CONFIG_X86_NUMA" = "y" ]; then
       #Platform Choices
--- linux/arch/i386/defconfig	Wed Jun 19 17:32:33 2002
+++ linux/arch/i386/defconfig	Wed Jun 19 17:26:35 2002
@@ -64,6 +64,7 @@
 CONFIG_SMP=y
 # CONFIG_MULTIQUAD is not set
 CONFIG_HAVE_DEC_LOCK=y
+CONFIG_NR_CPUS=32
 
 #
 # General setup
--- linux/arch/alpha/config.in	Wed Jun 19 17:31:21 2002
+++ linux/arch/alpha/config.in	Wed Jun 19 17:26:35 2002
@@ -257,6 +257,7 @@
 
 if [ "$CONFIG_SMP" = "y" ]; then
    define_bool CONFIG_HAVE_DEC_LOCK y
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
 fi
 
 if [ "$CONFIG_ALPHA_GENERIC" = "y" -o "$CONFIG_ALPHA_SRM" = "y" ]; then
--- linux/arch/ia64/config.in	Wed Jun 19 17:32:34 2002
+++ linux/arch/ia64/config.in	Wed Jun 19 17:26:35 2002
@@ -87,6 +87,10 @@
 define_bool CONFIG_KCORE_ELF y	# On IA-64, we always want an ELF /proc/kcore.
 
 bool 'SMP support' CONFIG_SMP
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
+fi
+
 tristate 'Support running of Linux/x86 binaries' CONFIG_IA32_SUPPORT
 bool 'Performance monitor support' CONFIG_PERFMON
 tristate '/proc/pal support' CONFIG_IA64_PALINFO
--- linux/arch/ia64/defconfig	Wed Jun 19 17:31:23 2002
+++ linux/arch/ia64/defconfig	Wed Jun 19 17:26:35 2002
@@ -42,6 +42,7 @@
 CONFIG_PM=y
 CONFIG_KCORE_ELF=y
 CONFIG_SMP=y
+CONFIG_NR_CPUS=32
 CONFIG_IA32_SUPPORT=y
 CONFIG_PERFMON=y
 CONFIG_IA64_PALINFO=y
--- linux/arch/mips/config-shared.in	Wed Jun 19 17:32:34 2002
+++ linux/arch/mips/config-shared.in	Wed Jun 19 17:26:35 2002
@@ -797,6 +797,8 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
+else
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
 fi
 endmenu
 
--- linux/arch/mips64/defconfig	Wed Jun 19 17:31:25 2002
+++ linux/arch/mips64/defconfig	Wed Jun 19 17:26:35 2002
@@ -53,6 +53,7 @@
 # CONFIG_REPLICATE_KTEXT is not set
 # CONFIG_REPLICATE_EXHANDLERS is not set
 CONFIG_SMP=y
+CONFIG_NR_CPUS=32
 # CONFIG_SGI_IP32 is not set
 # CONFIG_SIBYTE_SB1xxx_SOC is not set
 # CONFIG_SNI_RM200_PCI is not set
--- linux/arch/parisc/config.in	Wed Jun 19 17:32:34 2002
+++ linux/arch/parisc/config.in	Wed Jun 19 17:26:35 2002
@@ -45,6 +45,10 @@
 comment 'General options'
 
 bool 'Symmetric multi-processing support' CONFIG_SMP
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
+fi
+
 bool 'Chassis LCD and LED support' CONFIG_CHASSIS_LCD_LED
 
 bool 'Kernel Debugger support' CONFIG_KWDB
--- linux/arch/ppc/config.in	Wed Jun 19 17:31:16 2002
+++ linux/arch/ppc/config.in	Wed Jun 19 17:26:35 2002
@@ -122,6 +122,7 @@
 bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_SMP" = "y" ]; then
   bool '  Distribute interrupts on all CPUs by default' CONFIG_IRQ_ALL_CPUS
+  int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
 fi

 if [ "$CONFIG_6xx" = "y" -a "$CONFIG_8260" = "n" ];then
--- linux/arch/ppc64/config.in	Wed Jun 19 17:31:23 2002
+++ linux/arch/ppc64/config.in	Wed Jun 19 17:26:35 2002
@@ -29,6 +29,7 @@
 bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_SMP" = "y" ]; then
   bool '  Distribute interrupts on all CPUs by default' CONFIG_IRQ_ALL_CPUS
+  int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
   if [ "$CONFIG_PPC_PSERIES" = "y" ]; then
     bool '  Hardware multithreading' CONFIG_HMT
   fi
--- linux/arch/ppc64/defconfig	Wed Jun 19 17:31:23 2002
+++ linux/arch/ppc64/defconfig	Wed Jun 19 17:26:35 2002
@@ -22,6 +22,7 @@
 CONFIG_PPC_PSERIES=y
 # CONFIG_PPC_ISERIES is not set
 CONFIG_SMP=y
+CONFIG_NR_CPUS=32
 CONFIG_IRQ_ALL_CPUS=y
 # CONFIG_HMT is not set
 # CONFIG_MSCHUNKS is not set
--- linux/arch/s390/config.in	Wed Jun 19 17:31:26 2002
+++ linux/arch/s390/config.in	Wed Jun 19 17:26:35 2002
@@ -32,6 +32,9 @@
 comment 'Processor type and features'
 bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'IEEE FPU emulation' CONFIG_MATHEMU
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
+fi
 endmenu
 
 mainmenu_option next_comment
--- linux/arch/s390/defconfig	Wed Jun 19 17:31:26 2002
+++ linux/arch/s390/defconfig	Wed Jun 19 17:26:35 2002
@@ -27,6 +27,7 @@
 #
 CONFIG_SMP=y
 CONFIG_MATHEMU=y
+CONFIG_NR_CPUS=32
 
 #
 # General setup
--- linux/arch/s390x/config.in	Wed Jun 19 17:31:25 2002
+++ linux/arch/s390x/config.in	Wed Jun 19 17:26:35 2002
@@ -22,6 +22,9 @@
 mainmenu_option next_comment
 comment 'Processor type and features'
 bool 'Symmetric multi-processing support' CONFIG_SMP
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
+fi
 bool 'Kernel support for 31 bit emulation' CONFIG_S390_SUPPORT
 if [ "$CONFIG_S390_SUPPORT" = "y" ]; then
   tristate 'Kernel support for 31 bit ELF binaries' CONFIG_BINFMT_ELF32 
--- linux/arch/s390x/defconfig	Wed Jun 19 17:31:25 2002
+++ linux/arch/s390x/defconfig	Wed Jun 19 17:26:35 2002
@@ -21,6 +21,7 @@
 CONFIG_SMP=y
 CONFIG_S390_SUPPORT=y
 CONFIG_BINFMT_ELF32=y
+CONFIG_NR_CPUS=32
 
 #
 # Loadable module support
--- linux/arch/sparc/config.in	Wed Jun 19 17:31:21 2002
+++ linux/arch/sparc/config.in	Wed Jun 19 17:26:35 2002
@@ -29,6 +29,10 @@
 
 bool 'Symmetric multi-processing support (does not work on sun4/sun4c)' CONFIG_SMP
 
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
+fi
+
 # Identify this as a Sparc32 build
 define_bool CONFIG_SPARC32 y
 
--- linux/arch/sparc64/config.in	Wed Jun 19 17:32:35 2002
+++ linux/arch/sparc64/config.in	Wed Jun 19 17:26:35 2002
@@ -28,6 +28,10 @@
 
 bool 'Symmetric multi-processing support' CONFIG_SMP
 
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
+fi
+
 # Identify this as a Sparc64 build
 define_bool CONFIG_SPARC64 y
 
--- linux/arch/sparc64/defconfig	Wed Jun 19 17:32:35 2002
+++ linux/arch/sparc64/defconfig	Wed Jun 19 17:26:35 2002
@@ -58,6 +58,7 @@
 CONFIG_BINFMT_MISC=m
 # CONFIG_SUNOS_EMUL is not set
 CONFIG_SOLARIS_EMUL=m
+CONFIG_NR_CPUS=32
 
 #
 # Parallel port support
--- linux/arch/x86_64/config.in	Wed Jun 19 17:31:25 2002
+++ linux/arch/x86_64/config.in	Wed Jun 19 17:29:25 2002
@@ -66,6 +66,7 @@
    define_bool CONFIG_X86_UP_IOAPIC y
 else
    define_bool CONFIG_HAVE_DEC_LOCK y
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
 fi
 
 bool 'Machine check support' CONFIG_MCE
--- linux/arch/x86_64/defconfig	Wed Jun 19 17:31:25 2002
+++ linux/arch/x86_64/defconfig	Wed Jun 19 17:26:35 2002
@@ -41,6 +41,7 @@
 CONFIG_X86_LOCAL_APIC=y
 CONFIG_MTRR=y
 # CONFIG_SMP is not set
+CONFIG_NR_CPUS=32
 CONFIG_HPET_TIMER=y
 CONFIG_GART_IOMMU=y
 CONFIG_X86_UP_IOAPIC=y


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-1mdk))
