Return-Path: <rml@tech9.net>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand	id <S317215AbSFKRwT>; Tue, 11 Jun 2002 13:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org	id <S317217AbSFKRwS>; Tue, 11 Jun 2002 13:52:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18933 "EHLO	hermes.mvista.com") by vger.kernel.org with ESMTP	id <S317215AbSFKRwP>; Tue, 11 Jun 2002 13:52:15 -0400
Subject: [PATCH] CONFIG_NR_CPUS, redux
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, davem@redhat.com, torvalds@transmeta.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Jun 2002 10:52:16 -0700
Message-Id: <1023817936.21176.232.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 11 Jun 2002 17:54:14.0568 (UTC) FILETIME=[FFD0D280:01C21170]

On Tue, 2002-06-11 at 02:27, Andrew Morton wrote:

> In which case, CONFIG_NR_CPUS is the only way to get the memory
> back...

Alright, so here we go.  Andrew introduced this idea last week and here
is a revised, perhaps final, version.  We have two goals:

	(a) allow NR_CPUS to be set at configure time, to save
	    on memory and gain an unmeasurable boost in speed

	(b) let each architecture define a default NR_CPUS, i.e.
	    64-bit architectures can have an NR_CPUS of 64

We do this fairly easily.  In include/linux/threads.h:

	#ifdef CONFIG_SMP
	#define NR_CPUS		CONFIG_NR_CPUS
	#else
	#define NR_CPUS		1
	#endif

and in each arch/xxx/config.in add a configure entry, conditional on
CONFIG_SMP, for CONFIG_NR_CPUS with a proper default.  If CONFIG_SMP is
set in defconfig, set CONFIG_NR_CPUS properly there, too.

Here are the defaults I picked:

CONFIG_NR_CPUS=32: i386, mips, parisc, ppc, sparc

CONFIG_NR_CPUS=64: alpha, ia64, mips64, ppc64, s390, s390x, sparc64, x86-64

No CONFIG_NR_CPUS: arm, cris, sh

Andrew has pointed out some architectures may need minor tweaks to work
with NR_CPUS < 32.  He discovered and fixed a minor issue on i386...
other architectures, please verify non-standard options work.  Also make
sure 64 works!

Patch is against 2.5.21, enjoy...

	Robert Love

diff -urN linux-2.5.21/arch/alpha/config.in linux/arch/alpha/config.in
--- linux-2.5.21/arch/alpha/config.in	Sat Jun  8 22:28:07 2002
+++ linux/arch/alpha/config.in	Sun Jun  9 13:22:46 2002
@@ -232,6 +232,7 @@
 
 if [ "$CONFIG_SMP" = "y" ]; then
    define_bool CONFIG_HAVE_DEC_LOCK y
+   int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
 fi
 
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
diff -urN linux-2.5.21/arch/i386/Config.help linux/arch/i386/Config.help
--- linux-2.5.21/arch/i386/Config.help	Sat Jun  8 22:27:21 2002
+++ linux/arch/i386/Config.help	Sun Jun  9 13:13:02 2002
@@ -25,6 +25,14 @@
 
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
diff -urN linux-2.5.21/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.5.21/arch/i386/config.in	Sat Jun  8 22:28:47 2002
+++ linux/arch/i386/config.in	Sun Jun  9 13:23:20 2002
@@ -185,8 +185,8 @@
 
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
-bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'Preemptible Kernel' CONFIG_PREEMPT
+bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Local APIC support on uniprocessors' CONFIG_X86_UP_APIC
    dep_bool 'IO-APIC support on uniprocessors' CONFIG_X86_UP_IOAPIC $CONFIG_X86_UP_APIC
@@ -197,6 +197,7 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
 fi
 
diff -urN linux-2.5.21/arch/i386/defconfig linux/arch/i386/defconfig
--- linux-2.5.21/arch/i386/defconfig	Sat Jun  8 22:27:26 2002
+++ linux/arch/i386/defconfig	Sun Jun  9 13:21:32 2002
@@ -74,6 +74,7 @@
 # CONFIG_PREEMPT is not set
 # CONFIG_MULTIQUAD is not set
 CONFIG_HAVE_DEC_LOCK=y
+CONFIG_NR_CPUS=32
 
 #
 # General options
diff -urN linux-2.5.21/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux-2.5.21/arch/i386/kernel/smpboot.c	Sat Jun  8 22:29:52 2002
+++ linux/arch/i386/kernel/smpboot.c	Sun Jun  9 13:13:02 2002
@@ -54,7 +54,7 @@
 static int smp_b_stepping;
 
 /* Setup configured maximum number of CPUs to activate */
-static int max_cpus = -1;
+static int max_cpus = NR_CPUS;
 
 /* Total count of live CPUs */
 int smp_num_cpus = 1;
@@ -1145,7 +1145,7 @@
 
 		if (!(phys_cpu_present_map & (1 << bit)))
 			continue;
-		if ((max_cpus >= 0) && (max_cpus <= cpucount+1))
+		if (max_cpus <= cpucount+1)
 			continue;
 
 		do_boot_cpu(apicid);
diff -urN linux-2.5.21/arch/ia64/config.in linux/arch/ia64/config.in
--- linux-2.5.21/arch/ia64/config.in	Sat Jun  8 22:30:07 2002
+++ linux/arch/ia64/config.in	Sun Jun  9 13:24:00 2002
@@ -95,6 +95,10 @@
 tristate '/proc/pal support' CONFIG_IA64_PALINFO
 tristate '/proc/efi/vars support' CONFIG_EFI_VARS
 
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
+fi
+
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
diff -urN linux-2.5.21/arch/ia64/defconfig linux/arch/ia64/defconfig
--- linux-2.5.21/arch/ia64/defconfig	Sat Jun  8 22:27:16 2002
+++ linux/arch/ia64/defconfig	Sun Jun  9 13:21:00 2002
@@ -61,6 +61,7 @@
 CONFIG_EFI_VARS=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
+CONFIG_NR_CPUS=64
 
 #
 # ACPI Support
diff -urN linux-2.5.21/arch/mips/config.in linux/arch/mips/config.in
--- linux-2.5.21/arch/mips/config.in	Sat Jun  8 22:30:41 2002
+++ linux/arch/mips/config.in	Sun Jun  9 13:24:57 2002
@@ -500,6 +500,8 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
+else
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
 fi
 endmenu
 
diff -urN linux-2.5.21/arch/mips64/config.in linux/arch/mips64/config.in
--- linux-2.5.21/arch/mips64/config.in	Sat Jun  8 22:27:29 2002
+++ linux/arch/mips64/config.in	Sun Jun  9 13:25:12 2002
@@ -247,6 +247,8 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
+else
+   int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
 fi
 endmenu
 
diff -urN linux-2.5.21/arch/mips64/defconfig linux/arch/mips64/defconfig
--- linux-2.5.21/arch/mips64/defconfig	Sat Jun  8 22:27:52 2002
+++ linux/arch/mips64/defconfig	Sun Jun  9 13:20:17 2002
@@ -32,6 +32,7 @@
 # CONFIG_EISA is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
+CONFIG_NR_CPUS=64
 
 #
 # CPU selection
diff -urN linux-2.5.21/arch/parisc/config.in linux/arch/parisc/config.in
--- linux-2.5.21/arch/parisc/config.in	Sat Jun  8 22:31:31 2002
+++ linux/arch/parisc/config.in	Sun Jun  9 13:25:41 2002
@@ -18,6 +18,10 @@
 # bool 'Symmetric multi-processing support' CONFIG_SMP
 define_bool CONFIG_SMP n
 
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
+fi
+
 bool 'Kernel Debugger support' CONFIG_KWDB
 # define_bool CONFIG_KWDB n
 
diff -urN linux-2.5.21/arch/ppc/config.in linux/arch/ppc/config.in
--- linux-2.5.21/arch/ppc/config.in	Sat Jun  8 22:26:28 2002
+++ linux/arch/ppc/config.in	Sun Jun  9 13:26:29 2002
@@ -172,6 +172,7 @@
 bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_SMP" = "y" ]; then
    bool '  Distribute interrupts on all CPUs by default' CONFIG_IRQ_ALL_CPUS
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
 fi
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Preemptible Kernel' CONFIG_PREEMPT
diff -urN linux-2.5.21/arch/ppc64/config.in linux/arch/ppc64/config.in
--- linux-2.5.21/arch/ppc64/config.in	Sat Jun  8 22:27:32 2002
+++ linux/arch/ppc64/config.in	Sun Jun  9 13:26:43 2002
@@ -21,6 +21,7 @@
 bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_SMP" = "y" ]; then
   bool '  Distribute interrupts on all CPUs by default' CONFIG_IRQ_ALL_CPUS
+  int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
   if [ "$CONFIG_PPC_PSERIES" = "y" ]; then
     bool '  Hardware multithreading' CONFIG_HMT
   fi
diff -urN linux-2.5.21/arch/ppc64/defconfig linux/arch/ppc64/defconfig
--- linux-2.5.21/arch/ppc64/defconfig	Sat Jun  8 22:28:19 2002
+++ linux/arch/ppc64/defconfig	Sun Jun  9 13:20:43 2002
@@ -38,6 +38,7 @@
 CONFIG_IRQ_ALL_CPUS=y
 # CONFIG_HMT is not set
 # CONFIG_PREEMPT is not set
+CONFIG_NR_CPUS=64
 
 #
 # General setup
diff -urN linux-2.5.21/arch/s390/config.in linux/arch/s390/config.in
--- linux-2.5.21/arch/s390/config.in	Sat Jun  8 22:28:13 2002
+++ linux/arch/s390/config.in	Sun Jun  9 13:27:07 2002
@@ -20,6 +20,9 @@
 comment 'Processor type and features'
 bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'IEEE FPU emulation' CONFIG_MATHEMU
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
+fi
 endmenu
 
 mainmenu_option next_comment
diff -urN linux-2.5.21/arch/s390/defconfig linux/arch/s390/defconfig
--- linux-2.5.21/arch/s390/defconfig	Sat Jun  8 22:31:19 2002
+++ linux/arch/s390/defconfig	Sun Jun  9 13:40:37 2002
@@ -35,6 +35,7 @@
 #
 CONFIG_SMP=y
 CONFIG_MATHEMU=y
+CONFIG_NR_CPUS=64
 
 #
 # Base setup
diff -urN linux-2.5.21/arch/s390x/config.in linux/arch/s390x/config.in
--- linux-2.5.21/arch/s390x/config.in	Sat Jun  8 22:27:21 2002
+++ linux/arch/s390x/config.in	Sun Jun  9 13:40:14 2002
@@ -19,6 +19,9 @@
 mainmenu_option next_comment
 comment 'Processor type and features'
 bool 'Symmetric multi-processing support' CONFIG_SMP
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
+fi
 bool 'Kernel support for 31 bit emulation' CONFIG_S390_SUPPORT
 if [ "$CONFIG_S390_SUPPORT" = "y" ]; then
   tristate 'Kernel support for 31 bit ELF binaries' CONFIG_BINFMT_ELF32 
diff -urN linux-2.5.21/arch/s390x/defconfig linux/arch/s390x/defconfig
--- linux-2.5.21/arch/s390x/defconfig	Sat Jun  8 22:26:26 2002
+++ linux/arch/s390x/defconfig	Sun Jun  9 13:40:46 2002
@@ -36,6 +36,7 @@
 CONFIG_SMP=y
 CONFIG_S390_SUPPORT=y
 CONFIG_BINFMT_ELF32=y
+CONFIG_NR_CPUS=64
 
 #
 # Base setup
diff -urN linux-2.5.21/arch/sparc/config.in linux/arch/sparc/config.in
--- linux-2.5.21/arch/sparc/config.in	Sat Jun  8 22:26:59 2002
+++ linux/arch/sparc/config.in	Sun Jun  9 13:27:41 2002
@@ -17,6 +17,10 @@
 
 bool 'Symmetric multi-processing support (does not work on sun4/sun4c)' CONFIG_SMP
 
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
+fi
+
 # Identify this as a Sparc32 build
 define_bool CONFIG_SPARC32 y
 
diff -urN linux-2.5.21/arch/sparc64/config.in linux/arch/sparc64/config.in
--- linux-2.5.21/arch/sparc64/config.in	Sat Jun  8 22:28:44 2002
+++ linux/arch/sparc64/config.in	Sun Jun  9 13:28:05 2002
@@ -17,6 +17,10 @@
 bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'Preemptible kernel' CONFIG_PREEMPT
 
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
+fi
+
 # Identify this as a Sparc64 build
 define_bool CONFIG_SPARC64 y
 
diff -urN linux-2.5.21/arch/sparc64/defconfig linux/arch/sparc64/defconfig
--- linux-2.5.21/arch/sparc64/defconfig	Sat Jun  8 22:28:49 2002
+++ linux/arch/sparc64/defconfig	Sun Jun  9 13:21:45 2002
@@ -63,6 +63,7 @@
 CONFIG_BINFMT_MISC=m
 # CONFIG_SUNOS_EMUL is not set
 CONFIG_SOLARIS_EMUL=m
+CONFIG_NR_CPUS=64
 
 #
 # Parallel port support
diff -urN linux-2.5.21/arch/x86_64/config.in linux/arch/x86_64/config.in
--- linux-2.5.21/arch/x86_64/config.in	Sat Jun  8 22:28:13 2002
+++ linux/arch/x86_64/config.in	Sun Jun  9 13:28:46 2002
@@ -45,8 +45,11 @@
 #bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
 bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'Preemptible Kernel' CONFIG_PREEMPT
-if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then
-    define_bool CONFIG_HAVE_DEC_LOCK y
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
+   if [ "$CONFIG_X86_CMPXCHG" = "y" ]; then
+      define_bool CONFIG_HAVE_DEC_LOCK y
+   fi
 fi
 
 define_bool CONFIG_X86_MCE y
diff -urN linux-2.5.21/arch/x86_64/defconfig linux/arch/x86_64/defconfig
--- linux-2.5.21/arch/x86_64/defconfig	Sat Jun  8 22:30:52 2002
+++ linux/arch/x86_64/defconfig	Sun Jun  9 13:20:30 2002
@@ -51,6 +51,7 @@
 CONFIG_HAVE_DEC_LOCK=y
 CONFIG_X86_MCE=y
 # CONFIG_X86_MCE_NONFATAL is not set
+CONFIG_NR_CPUS=64
 
 #
 # General options
diff -urN linux-2.5.21/include/linux/threads.h linux/include/linux/threads.h
--- linux-2.5.21/include/linux/threads.h	Sat Jun  8 22:26:49 2002
+++ linux/include/linux/threads.h	Sun Jun  9 13:16:29 2002
@@ -8,10 +8,16 @@
  * /proc/sys/kernel/threads-max.
  */
  
+/*
+ * Maximum supported processors that can run under SMP.  This value is
+ * set via configure setting.  The maximum is equal to the size of the
+ * bitmasks used on that platform, i.e. 32 or 64.  Setting this smaller
+ * saves quite a bit of memory.
+ */
 #ifdef CONFIG_SMP
-#define NR_CPUS	32		/* Max processors that can be running in SMP */
+#define NR_CPUS		CONFIG_NR_CPUS
 #else
-#define NR_CPUS 1
+#define NR_CPUS		1
 #endif
 
 #define MIN_THREADS_LEFT_FOR_ROOT 4

