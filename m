Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSFXTMB>; Mon, 24 Jun 2002 15:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315167AbSFXTMB>; Mon, 24 Jun 2002 15:12:01 -0400
Received: from terminus.zytor.com ([64.158.222.227]:32961 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S315120AbSFXTL5>; Mon, 24 Jun 2002 15:11:57 -0400
Subject: [PATCH] Configurable NR_CPUS for 2.5.24
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 24 Jun 2002 15:06:40 -0400
Message-Id: <1024945649.2550.7.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is in 2.5-dj now and thus I have gotten a couple emails for a
resync against 2.5 proper... so here we go, live from the Kernel Summit.

This patch implements a CONFIG_NR_CPUS that allows the user to specify a
sane value for NR_CPUS in an effort to save memory and cycles.  This is
especially useful for debugging or other work where you have large
per-CPU static structures.  It also has a more appreciable benefit now
that hotplug CPUs has more code using NR_CPUS vs smp_num_cpus.

This patch also allows each architecture to specify its own default
NR_CPUS, allowing 64-bit arches to set their default to 64.

We need feedback on use of other-than-default NR_CPUS values (x86 is
well tested) as well as use of the new 64 default on such architectures.

Oh, and to make Tom Rini happy I will accept patches for other
architectures Config.help entries :)

Patch is against 2.5.24.

	Robert Love

diff -urN linux-2.5.24/arch/alpha/config.in linux/arch/alpha/config.in
--- linux-2.5.24/arch/alpha/config.in	Thu Jun 20 15:53:47 2002
+++ linux/arch/alpha/config.in	Thu Jun 20 16:35:45 2002
@@ -232,6 +232,7 @@
 
 if [ "$CONFIG_SMP" = "y" ]; then
    define_bool CONFIG_HAVE_DEC_LOCK y
+   int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
 fi
 
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
diff -urN linux-2.5.24/arch/i386/Config.help linux/arch/i386/Config.help
--- linux-2.5.24/arch/i386/Config.help	Thu Jun 20 15:53:44 2002
+++ linux/arch/i386/Config.help	Thu Jun 20 16:35:45 2002
@@ -25,6 +25,14 @@
 
   If you don't know what to do here, say N.
 
+CONFIG_NR_CPUS
+  This allows you to specify the maximum number of CPUs which this
+  kernel will support.  The maximum supported value is 32 and the
+  minimum value which makes sense is 2.
+
+  This is purely to save memory - each supported CPU adds
+  approximately eight kilobytes to the kernel image.
+
 CONFIG_PREEMPT
   This option reduces the latency of the kernel when reacting to
   real-time or interactive events by allowing a low priority process to
diff -urN linux-2.5.24/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.5.24/arch/i386/config.in	Thu Jun 20 15:53:49 2002
+++ linux/arch/i386/config.in	Thu Jun 20 16:35:45 2002
@@ -165,6 +165,7 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
 fi
 
diff -urN linux-2.5.24/arch/i386/defconfig linux/arch/i386/defconfig
--- linux-2.5.24/arch/i386/defconfig	Thu Jun 20 15:53:45 2002
+++ linux/arch/i386/defconfig	Thu Jun 20 16:35:45 2002
@@ -74,6 +74,7 @@
 # CONFIG_PREEMPT is not set
 # CONFIG_MULTIQUAD is not set
 CONFIG_HAVE_DEC_LOCK=y
+CONFIG_NR_CPUS=32
 
 #
 # General options
diff -urN linux-2.5.24/arch/ia64/config.in linux/arch/ia64/config.in
--- linux-2.5.24/arch/ia64/config.in	Thu Jun 20 15:53:53 2002
+++ linux/arch/ia64/config.in	Thu Jun 20 16:35:45 2002
@@ -95,6 +95,10 @@
 tristate '/proc/pal support' CONFIG_IA64_PALINFO
 tristate '/proc/efi/vars support' CONFIG_EFI_VARS
 
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
+fi
+
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
diff -urN linux-2.5.24/arch/ia64/defconfig linux/arch/ia64/defconfig
--- linux-2.5.24/arch/ia64/defconfig	Thu Jun 20 15:53:44 2002
+++ linux/arch/ia64/defconfig	Thu Jun 20 16:35:45 2002
@@ -61,6 +61,7 @@
 CONFIG_EFI_VARS=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
+CONFIG_NR_CPUS=64
 
 #
 # ACPI Support
diff -urN linux-2.5.24/arch/mips/config.in linux/arch/mips/config.in
--- linux-2.5.24/arch/mips/config.in	Thu Jun 20 15:53:54 2002
+++ linux/arch/mips/config.in	Thu Jun 20 16:35:45 2002
@@ -500,6 +500,8 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
+else
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
 fi
 endmenu
 
diff -urN linux-2.5.24/arch/mips64/config.in linux/arch/mips64/config.in
--- linux-2.5.24/arch/mips64/config.in	Thu Jun 20 15:53:45 2002
+++ linux/arch/mips64/config.in	Thu Jun 20 16:35:45 2002
@@ -245,6 +245,8 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
+else
+   int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
 fi
 endmenu
 
diff -urN linux-2.5.24/arch/mips64/defconfig linux/arch/mips64/defconfig
--- linux-2.5.24/arch/mips64/defconfig	Thu Jun 20 15:53:47 2002
+++ linux/arch/mips64/defconfig	Thu Jun 20 16:35:45 2002
@@ -32,6 +32,7 @@
 # CONFIG_EISA is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
+CONFIG_NR_CPUS=64
 
 #
 # CPU selection
diff -urN linux-2.5.24/arch/parisc/config.in linux/arch/parisc/config.in
--- linux-2.5.24/arch/parisc/config.in	Thu Jun 20 15:53:57 2002
+++ linux/arch/parisc/config.in	Thu Jun 20 16:35:45 2002
@@ -18,6 +18,10 @@
 # bool 'Symmetric multi-processing support' CONFIG_SMP
 define_bool CONFIG_SMP n
 
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
+fi
+
 bool 'Kernel Debugger support' CONFIG_KWDB
 # define_bool CONFIG_KWDB n
 
diff -urN linux-2.5.24/arch/ppc/config.in linux/arch/ppc/config.in
--- linux-2.5.24/arch/ppc/config.in	Thu Jun 20 15:53:41 2002
+++ linux/arch/ppc/config.in	Thu Jun 20 16:35:45 2002
@@ -172,6 +172,7 @@
 bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_SMP" = "y" ]; then
    bool '  Distribute interrupts on all CPUs by default' CONFIG_IRQ_ALL_CPUS
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
 fi
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Preemptible Kernel' CONFIG_PREEMPT
diff -urN linux-2.5.24/arch/ppc64/config.in linux/arch/ppc64/config.in
--- linux-2.5.24/arch/ppc64/config.in	Thu Jun 20 15:53:45 2002
+++ linux/arch/ppc64/config.in	Thu Jun 20 16:35:45 2002
@@ -21,6 +21,7 @@
 bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_SMP" = "y" ]; then
   bool '  Distribute interrupts on all CPUs by default' CONFIG_IRQ_ALL_CPUS
+  int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
   if [ "$CONFIG_PPC_PSERIES" = "y" ]; then
     bool '  Hardware multithreading' CONFIG_HMT
   fi
diff -urN linux-2.5.24/arch/ppc64/defconfig linux/arch/ppc64/defconfig
--- linux-2.5.24/arch/ppc64/defconfig	Thu Jun 20 15:53:48 2002
+++ linux/arch/ppc64/defconfig	Thu Jun 20 16:35:45 2002
@@ -38,6 +38,7 @@
 CONFIG_IRQ_ALL_CPUS=y
 # CONFIG_HMT is not set
 # CONFIG_PREEMPT is not set
+CONFIG_NR_CPUS=64
 
 #
 # General setup
diff -urN linux-2.5.24/arch/s390/config.in linux/arch/s390/config.in
--- linux-2.5.24/arch/s390/config.in	Thu Jun 20 15:53:47 2002
+++ linux/arch/s390/config.in	Thu Jun 20 16:35:45 2002
@@ -20,6 +20,9 @@
 comment 'Processor type and features'
 bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'IEEE FPU emulation' CONFIG_MATHEMU
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
+fi
 endmenu
 
 mainmenu_option next_comment
diff -urN linux-2.5.24/arch/s390/defconfig linux/arch/s390/defconfig
--- linux-2.5.24/arch/s390/defconfig	Thu Jun 20 15:53:56 2002
+++ linux/arch/s390/defconfig	Thu Jun 20 16:35:45 2002
@@ -35,6 +35,7 @@
 #
 CONFIG_SMP=y
 CONFIG_MATHEMU=y
+CONFIG_NR_CPUS=64
 
 #
 # Base setup
diff -urN linux-2.5.24/arch/s390x/config.in linux/arch/s390x/config.in
--- linux-2.5.24/arch/s390x/config.in	Thu Jun 20 15:53:44 2002
+++ linux/arch/s390x/config.in	Thu Jun 20 16:35:45 2002
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
diff -urN linux-2.5.24/arch/s390x/defconfig linux/arch/s390x/defconfig
--- linux-2.5.24/arch/s390x/defconfig	Thu Jun 20 15:53:41 2002
+++ linux/arch/s390x/defconfig	Thu Jun 20 16:35:45 2002
@@ -36,6 +36,7 @@
 CONFIG_SMP=y
 CONFIG_S390_SUPPORT=y
 CONFIG_BINFMT_ELF32=y
+CONFIG_NR_CPUS=64
 
 #
 # Base setup
diff -urN linux-2.5.24/arch/sparc/config.in linux/arch/sparc/config.in
--- linux-2.5.24/arch/sparc/config.in	Thu Jun 20 15:53:44 2002
+++ linux/arch/sparc/config.in	Thu Jun 20 16:35:45 2002
@@ -17,6 +17,10 @@
 
 bool 'Symmetric multi-processing support (does not work on sun4/sun4c)' CONFIG_SMP
 
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
+fi
+
 # Identify this as a Sparc32 build
 define_bool CONFIG_SPARC32 y
 
diff -urN linux-2.5.24/arch/sparc64/config.in linux/arch/sparc64/config.in
--- linux-2.5.24/arch/sparc64/config.in	Thu Jun 20 15:53:49 2002
+++ linux/arch/sparc64/config.in	Thu Jun 20 16:35:45 2002
@@ -17,6 +17,10 @@
 bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'Preemptible Kernel' CONFIG_PREEMPT
 
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
+fi
+
 # Identify this as a Sparc64 build
 define_bool CONFIG_SPARC64 y
 
diff -urN linux-2.5.24/arch/sparc64/defconfig linux/arch/sparc64/defconfig
--- linux-2.5.24/arch/sparc64/defconfig	Thu Jun 20 15:53:49 2002
+++ linux/arch/sparc64/defconfig	Thu Jun 20 16:35:45 2002
@@ -63,6 +63,7 @@
 CONFIG_BINFMT_MISC=m
 # CONFIG_SUNOS_EMUL is not set
 CONFIG_SOLARIS_EMUL=m
+CONFIG_NR_CPUS=64
 
 #
 # Parallel port support
diff -urN linux-2.5.24/arch/x86_64/config.in linux/arch/x86_64/config.in
--- linux-2.5.24/arch/x86_64/config.in	Thu Jun 20 15:53:47 2002
+++ linux/arch/x86_64/config.in	Thu Jun 20 16:35:45 2002
@@ -54,6 +54,7 @@
 fi
 if [ "$CONFIG_SMP" = "y" ]; then
     define_bool CONFIG_HAVE_DEC_LOCK y
+    int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
 fi
 
 define_bool CONFIG_X86_MCE y
diff -urN linux-2.5.24/arch/x86_64/defconfig linux/arch/x86_64/defconfig
--- linux-2.5.24/arch/x86_64/defconfig	Thu Jun 20 15:53:55 2002
+++ linux/arch/x86_64/defconfig	Thu Jun 20 16:35:45 2002
@@ -51,6 +51,7 @@
 CONFIG_HAVE_DEC_LOCK=y
 CONFIG_X86_MCE=y
 # CONFIG_X86_MCE_NONFATAL is not set
+CONFIG_NR_CPUS=64
 
 #
 # Power management options
diff -urN linux-2.5.24/include/linux/threads.h linux/include/linux/threads.h
--- linux-2.5.24/include/linux/threads.h	Thu Jun 20 15:53:42 2002
+++ linux/include/linux/threads.h	Thu Jun 20 16:35:45 2002
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

