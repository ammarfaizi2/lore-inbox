Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319238AbSH2P3j>; Thu, 29 Aug 2002 11:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319237AbSH2P3j>; Thu, 29 Aug 2002 11:29:39 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:59143
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319238AbSH2P2y>; Thu, 29 Aug 2002 11:28:54 -0400
Subject: [PATCH] compile-time configurable NR_CPUS
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Aug 2002 11:33:20 -0400
Message-Id: <1030635200.939.2561.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:

	- implements per-architecture NR_CPUS value with a default value
	  that is the maximum per-arch (e.g. BITS_PER_LONG).

	- provides a configure option for changing the value.

Setting a saner NR_CPUS, e.g. 2, reduced my kernel footprint by over
200KB (all in data and bss).  Now that we have loops terminating on
NR_CPUS, you can save a bit of cycles too.

Patch is against 2.5.32...

	Robert Love

diff -urN linux-2.5.32/arch/alpha/config.in linux/arch/alpha/config.in
--- linux-2.5.32/arch/alpha/config.in	Tue Aug 27 15:26:37 2002
+++ linux/arch/alpha/config.in	Wed Aug 28 19:15:32 2002
@@ -233,6 +233,7 @@
 
 if [ "$CONFIG_SMP" = "y" ]; then
    define_bool CONFIG_HAVE_DEC_LOCK y
+   int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
 fi
 
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
diff -urN linux-2.5.32/arch/i386/Config.help linux/arch/i386/Config.help
--- linux-2.5.32/arch/i386/Config.help	Tue Aug 27 15:26:34 2002
+++ linux/arch/i386/Config.help	Wed Aug 28 19:15:32 2002
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
diff -urN linux-2.5.32/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.5.32/arch/i386/config.in	Tue Aug 27 15:26:39 2002
+++ linux/arch/i386/config.in	Wed Aug 28 19:15:32 2002
@@ -166,6 +166,7 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
 fi
 
diff -urN linux-2.5.32/arch/i386/defconfig linux/arch/i386/defconfig
--- linux-2.5.32/arch/i386/defconfig	Tue Aug 27 15:26:34 2002
+++ linux/arch/i386/defconfig	Wed Aug 28 19:15:32 2002
@@ -75,6 +75,7 @@
 # CONFIG_MATH_EMULATION is not set
 # CONFIG_MTRR is not set
 CONFIG_HAVE_DEC_LOCK=y
+CONFIG_NR_CPUS=32
 
 #
 # Power management options (ACPI, APM)
diff -urN linux-2.5.32/arch/ia64/config.in linux/arch/ia64/config.in
--- linux-2.5.32/arch/ia64/config.in	Tue Aug 27 15:27:34 2002
+++ linux/arch/ia64/config.in	Wed Aug 28 19:15:32 2002
@@ -96,6 +96,10 @@
 tristate '/proc/pal support' CONFIG_IA64_PALINFO
 tristate '/proc/efi/vars support' CONFIG_EFI_VARS
 
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
+fi
+
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
diff -urN linux-2.5.32/arch/ia64/defconfig linux/arch/ia64/defconfig
--- linux-2.5.32/arch/ia64/defconfig	Tue Aug 27 15:26:34 2002
+++ linux/arch/ia64/defconfig	Wed Aug 28 19:15:32 2002
@@ -61,6 +61,7 @@
 CONFIG_EFI_VARS=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
+CONFIG_NR_CPUS=64
 
 #
 # ACPI Support
diff -urN linux-2.5.32/arch/mips/config.in linux/arch/mips/config.in
--- linux-2.5.32/arch/mips/config.in	Tue Aug 27 15:26:53 2002
+++ linux/arch/mips/config.in	Wed Aug 28 19:15:32 2002
@@ -490,6 +490,8 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
+else
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
 fi
 endmenu
 
diff -urN linux-2.5.32/arch/mips64/config.in linux/arch/mips64/config.in
--- linux-2.5.32/arch/mips64/config.in	Tue Aug 27 15:26:35 2002
+++ linux/arch/mips64/config.in	Wed Aug 28 19:15:32 2002
@@ -244,6 +244,8 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
+else
+   int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
 fi
 endmenu
 
diff -urN linux-2.5.32/arch/mips64/defconfig linux/arch/mips64/defconfig
--- linux-2.5.32/arch/mips64/defconfig	Tue Aug 27 15:26:37 2002
+++ linux/arch/mips64/defconfig	Wed Aug 28 19:15:32 2002
@@ -32,6 +32,7 @@
 # CONFIG_EISA is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
+CONFIG_NR_CPUS=64
 
 #
 # CPU selection
diff -urN linux-2.5.32/arch/parisc/config.in linux/arch/parisc/config.in
--- linux-2.5.32/arch/parisc/config.in	Tue Aug 27 15:27:33 2002
+++ linux/arch/parisc/config.in	Wed Aug 28 19:15:32 2002
@@ -19,6 +19,10 @@
 # bool 'Symmetric multi-processing support' CONFIG_SMP
 define_bool CONFIG_SMP n
 
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
+fi
+
 bool 'Kernel Debugger support' CONFIG_KWDB
 # define_bool CONFIG_KWDB n
 
diff -urN linux-2.5.32/arch/ppc/config.in linux/arch/ppc/config.in
--- linux-2.5.32/arch/ppc/config.in	Tue Aug 27 15:26:30 2002
+++ linux/arch/ppc/config.in	Wed Aug 28 19:15:32 2002
@@ -173,6 +173,7 @@
 bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_SMP" = "y" ]; then
    bool '  Distribute interrupts on all CPUs by default' CONFIG_IRQ_ALL_CPUS
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
 fi
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Preemptible Kernel' CONFIG_PREEMPT
diff -urN linux-2.5.32/arch/ppc64/config.in linux/arch/ppc64/config.in
--- linux-2.5.32/arch/ppc64/config.in	Tue Aug 27 15:26:35 2002
+++ linux/arch/ppc64/config.in	Wed Aug 28 19:15:32 2002
@@ -21,6 +21,7 @@
 bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_SMP" = "y" ]; then
   bool '  Distribute interrupts on all CPUs by default' CONFIG_IRQ_ALL_CPUS
+  int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
   if [ "$CONFIG_PPC_PSERIES" = "y" ]; then
     bool '  Hardware multithreading' CONFIG_HMT
     bool '  Discontiguous Memory Support' CONFIG_DISCONTIGMEM
diff -urN linux-2.5.32/arch/ppc64/defconfig linux/arch/ppc64/defconfig
--- linux-2.5.32/arch/ppc64/defconfig	Tue Aug 27 15:26:38 2002
+++ linux/arch/ppc64/defconfig	Wed Aug 28 19:15:55 2002
@@ -39,6 +39,7 @@
 # CONFIG_HMT is not set
 # CONFIG_DISCONTIGMEM is not set
 # CONFIG_PREEMPT is not set
+CONFIG_NR_CPUS=64
 # CONFIG_RTAS_FLASH is not set
 
 #
diff -urN linux-2.5.32/arch/s390/config.in linux/arch/s390/config.in
--- linux-2.5.32/arch/s390/config.in	Tue Aug 27 15:26:37 2002
+++ linux/arch/s390/config.in	Wed Aug 28 19:15:32 2002
@@ -20,6 +20,9 @@
 comment 'Processor type and features'
 bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'IEEE FPU emulation' CONFIG_MATHEMU
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
+fi
 endmenu
 
 mainmenu_option next_comment
diff -urN linux-2.5.32/arch/s390/defconfig linux/arch/s390/defconfig
--- linux-2.5.32/arch/s390/defconfig	Tue Aug 27 15:27:12 2002
+++ linux/arch/s390/defconfig	Wed Aug 28 19:15:32 2002
@@ -35,6 +35,7 @@
 #
 CONFIG_SMP=y
 CONFIG_MATHEMU=y
+CONFIG_NR_CPUS=64
 
 #
 # Base setup
diff -urN linux-2.5.32/arch/s390x/config.in linux/arch/s390x/config.in
--- linux-2.5.32/arch/s390x/config.in	Tue Aug 27 15:26:34 2002
+++ linux/arch/s390x/config.in	Wed Aug 28 19:15:32 2002
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
diff -urN linux-2.5.32/arch/s390x/defconfig linux/arch/s390x/defconfig
--- linux-2.5.32/arch/s390x/defconfig	Tue Aug 27 15:26:30 2002
+++ linux/arch/s390x/defconfig	Wed Aug 28 19:15:32 2002
@@ -36,6 +36,7 @@
 CONFIG_SMP=y
 CONFIG_S390_SUPPORT=y
 CONFIG_BINFMT_ELF32=y
+CONFIG_NR_CPUS=64
 
 #
 # Base setup
diff -urN linux-2.5.32/arch/sparc/config.in linux/arch/sparc/config.in
--- linux-2.5.32/arch/sparc/config.in	Tue Aug 27 15:26:33 2002
+++ linux/arch/sparc/config.in	Wed Aug 28 19:15:32 2002
@@ -18,6 +18,10 @@
 
 bool 'Symmetric multi-processing support (does not work on sun4/sun4c)' CONFIG_SMP
 
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
+fi
+
 # Identify this as a Sparc32 build
 define_bool CONFIG_SPARC32 y
 
diff -urN linux-2.5.32/arch/sparc64/config.in linux/arch/sparc64/config.in
--- linux-2.5.32/arch/sparc64/config.in	Tue Aug 27 15:26:39 2002
+++ linux/arch/sparc64/config.in	Wed Aug 28 19:15:32 2002
@@ -17,6 +17,10 @@
 bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'Preemptible Kernel' CONFIG_PREEMPT
 
+if [ "$CONFIG_SMP" = "y" ]; then
+   int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
+fi
+
 # Identify this as a Sparc64 build
 define_bool CONFIG_SPARC64 y
 
diff -urN linux-2.5.32/arch/sparc64/defconfig linux/arch/sparc64/defconfig
--- linux-2.5.32/arch/sparc64/defconfig	Tue Aug 27 15:26:39 2002
+++ linux/arch/sparc64/defconfig	Wed Aug 28 19:15:32 2002
@@ -57,6 +57,7 @@
 CONFIG_BINFMT_MISC=m
 # CONFIG_SUNOS_EMUL is not set
 CONFIG_SOLARIS_EMUL=m
+CONFIG_NR_CPUS=64
 
 #
 # Parallel port support
diff -urN linux-2.5.32/arch/x86_64/config.in linux/arch/x86_64/config.in
--- linux-2.5.32/arch/x86_64/config.in	Tue Aug 27 15:26:37 2002
+++ linux/arch/x86_64/config.in	Wed Aug 28 19:15:32 2002
@@ -54,6 +54,7 @@
 fi
 if [ "$CONFIG_SMP" = "y" ]; then
     define_bool CONFIG_HAVE_DEC_LOCK y
+    int  'Maximum number of CPUs (2-64)' CONFIG_NR_CPUS 64
 fi
 
 define_bool CONFIG_X86_MCE y
diff -urN linux-2.5.32/arch/x86_64/defconfig linux/arch/x86_64/defconfig
--- linux-2.5.32/arch/x86_64/defconfig	Tue Aug 27 15:26:54 2002
+++ linux/arch/x86_64/defconfig	Wed Aug 28 19:15:32 2002
@@ -51,6 +51,7 @@
 CONFIG_HAVE_DEC_LOCK=y
 CONFIG_X86_MCE=y
 # CONFIG_X86_MCE_NONFATAL is not set
+CONFIG_NR_CPUS=64
 
 #
 # Power management options
diff -urN linux-2.5.32/include/linux/threads.h linux/include/linux/threads.h
--- linux-2.5.32/include/linux/threads.h	Tue Aug 27 15:26:32 2002
+++ linux/include/linux/threads.h	Wed Aug 28 19:15:32 2002
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

