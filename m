Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275289AbSIUA5D>; Fri, 20 Sep 2002 20:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275381AbSIUA5D>; Fri, 20 Sep 2002 20:57:03 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:62955 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S275289AbSIUA47>;
	Fri, 20 Sep 2002 20:56:59 -0400
Message-ID: <3D8BC45F.5050007@us.ibm.com>
Date: Fri, 20 Sep 2002 17:59:11 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Martin Bligh <mjbligh@us.ibm.com>,
       James Cleverdon <cleverdj@us.ibm.com>
Subject: CONFIG_MULTIQUAD has got to go...
Content-Type: multipart/mixed;
 boundary="------------030607040802090703080501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030607040802090703080501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,
	The CONFIG_MULTIQUAD option has bothered me for a while now.  It actually 
covers the jobs of 3 config options, 2 of which exist.

This patch splits the use of CONFIG_MULTIQUAD into the 3 config options 
that it really means:
CONFIG_X86_NUMA: General X86 NUMA code (already exists)
CONFIG_X86_NUMAQ: Code specific to just the NUMA-Q platform (already exists)
CONFIG_CLUSTERED_APIC: Code that specifically deals with clustered APIC 
mode (new option)

The patch replaces every occurence of CONFIG_MULTIQUAD in the kernel, 
save 1 (arch/i386/pci/Makefile), which is remedied by the patch I will 
send momentarily.

Please apply.

Cheers!

-Matt

--------------030607040802090703080501
Content-Type: text/plain;
 name="multiquad_change-2.5.37.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="multiquad_change-2.5.37.patch"

diff -Nur linux-2.5.37-vanilla/arch/i386/boot/compressed/misc.c linux-2.5.37-multiquad/arch/i386/boot/compressed/misc.c
--- linux-2.5.37-vanilla/arch/i386/boot/compressed/misc.c	Fri Sep 20 08:20:30 2002
+++ linux-2.5.37-multiquad/arch/i386/boot/compressed/misc.c	Fri Sep 20 13:50:22 2002
@@ -120,7 +120,7 @@
 static int vidport;
 static int lines, cols;
 
-#ifdef CONFIG_MULTIQUAD
+#ifdef CONFIG_X86_NUMAQ
 static void * const xquad_portio = NULL;
 #endif
 
diff -Nur linux-2.5.37-vanilla/arch/i386/config.in linux-2.5.37-multiquad/arch/i386/config.in
--- linux-2.5.37-vanilla/arch/i386/config.in	Fri Sep 20 08:20:22 2002
+++ linux-2.5.37-multiquad/arch/i386/config.in	Fri Sep 20 13:50:22 2002
@@ -173,7 +173,7 @@
      #Platform Choices
      bool 'Multiquad (IBM/Sequent) NUMAQ support' CONFIG_X86_NUMAQ
      if [ "$CONFIG_X86_NUMAQ" = "y" ]; then
-        define_bool CONFIG_MULTIQUAD y
+        define_bool CONFIG_CLUSTERED_APIC y
      fi
      # Common NUMA Features
      if [ "$CONFIG_X86_NUMAQ" = "y" ]; then
diff -Nur linux-2.5.37-vanilla/arch/i386/defconfig linux-2.5.37-multiquad/arch/i386/defconfig
--- linux-2.5.37-vanilla/arch/i386/defconfig	Fri Sep 20 08:20:31 2002
+++ linux-2.5.37-multiquad/arch/i386/defconfig	Fri Sep 20 13:50:22 2002
@@ -60,7 +60,7 @@
 CONFIG_X86_USE_PPRO_CHECKSUM=y
 CONFIG_SMP=y
 # CONFIG_PREEMPT is not set
-# CONFIG_MULTIQUAD is not set
+# CONFIG_X86_NUMA is not set
 CONFIG_X86_MCE=y
 CONFIG_X86_MCE_NONFATAL=y
 CONFIG_X86_MCE_P4THERMAL=y
diff -Nur linux-2.5.37-vanilla/arch/i386/kernel/trampoline.S linux-2.5.37-multiquad/arch/i386/kernel/trampoline.S
--- linux-2.5.37-vanilla/arch/i386/kernel/trampoline.S	Fri Sep 20 08:20:24 2002
+++ linux-2.5.37-multiquad/arch/i386/kernel/trampoline.S	Fri Sep 20 13:50:22 2002
@@ -36,9 +36,7 @@
 
 ENTRY(trampoline_data)
 r_base = .
-#ifdef CONFIG_MULTIQUAD
 	wbinvd
-#endif /* CONFIG_MULTIQUAD */
 	mov	%cs, %ax	# Code and data in the same place
 	mov	%ax, %ds
 
diff -Nur linux-2.5.37-vanilla/include/asm-i386/io.h linux-2.5.37-multiquad/include/asm-i386/io.h
--- linux-2.5.37-vanilla/include/asm-i386/io.h	Fri Sep 20 08:20:25 2002
+++ linux-2.5.37-multiquad/include/asm-i386/io.h	Fri Sep 20 13:50:22 2002
@@ -298,9 +298,9 @@
 #define __FULL_SLOW_DOWN_IO __SLOW_DOWN_IO
 #endif
 
-#ifdef CONFIG_MULTIQUAD
+#ifdef CONFIG_X86_NUMAQ
 extern void *xquad_portio;    /* Where the IO area was mapped */
-#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_X86_NUMAQ */
 
 /*
  * Talk about misusing macros..
@@ -311,7 +311,7 @@
 #define __OUT2(s,s1,s2) \
 __asm__ __volatile__ ("out" #s " %" s1 "0,%" s2 "1"
 
-#ifdef CONFIG_MULTIQUAD
+#ifdef CONFIG_X86_NUMAQ
 #define __OUTQ(s,ss,x)    /* Do the equivalent of the portio op on quads */ \
 static inline void out##ss(unsigned x value, unsigned short port) { \
 	if (xquad_portio) \
@@ -339,9 +339,9 @@
 	else\
 		return 0;\
 }
-#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_X86_NUMAQ */
 
-#ifndef CONFIG_MULTIQUAD
+#ifndef CONFIG_X86_NUMAQ
 #define __OUT(s,s1,x) \
 __OUT1(s,x) __OUT2(s,s1,"w") : : "a" (value), "Nd" (port)); } \
 __OUT1(s##_p,x) __OUT2(s,s1,"w") __FULL_SLOW_DOWN_IO : : "a" (value), "Nd" (port));} 
@@ -352,7 +352,7 @@
 __OUT1(s##_p_local,x) __OUT2(s,s1,"w") __FULL_SLOW_DOWN_IO : : "a" (value), "Nd" (port));} \
 __OUTQ(s,s,x) \
 __OUTQ(s,s##_p,x) 
-#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_X86_NUMAQ */
 
 #define __IN1(s) \
 static inline RETURN_TYPE in##s(unsigned short port) { RETURN_TYPE _v;
@@ -360,7 +360,7 @@
 #define __IN2(s,s1,s2) \
 __asm__ __volatile__ ("in" #s " %" s2 "1,%" s1 "0"
 
-#ifndef CONFIG_MULTIQUAD
+#ifndef CONFIG_X86_NUMAQ
 #define __IN(s,s1,i...) \
 __IN1(s) __IN2(s,s1,"w") : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
 __IN1(s##_p) __IN2(s,s1,"w") __FULL_SLOW_DOWN_IO : "=a" (_v) : "Nd" (port) ,##i ); return _v; } 
@@ -371,7 +371,7 @@
 __IN1(s##_p_local) __IN2(s,s1,"w") __FULL_SLOW_DOWN_IO : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
 __INQ(s,s) \
 __INQ(s,s##_p) 
-#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_X86_NUMAQ */
 
 #define __INS(s) \
 static inline void ins##s(unsigned short port, void * addr, unsigned long count) \
diff -Nur linux-2.5.37-vanilla/include/asm-i386/mpspec.h linux-2.5.37-multiquad/include/asm-i386/mpspec.h
--- linux-2.5.37-vanilla/include/asm-i386/mpspec.h	Fri Sep 20 08:20:13 2002
+++ linux-2.5.37-multiquad/include/asm-i386/mpspec.h	Fri Sep 20 13:50:22 2002
@@ -16,11 +16,11 @@
 /*
  * a maximum of 16 APICs with the current APIC ID architecture.
  */
-#ifdef CONFIG_MULTIQUAD
+#ifdef CONFIG_X86_NUMA
 #define MAX_APICS 256
-#else /* !CONFIG_MULTIQUAD */
+#else /* !CONFIG_X86_NUMA */
 #define MAX_APICS 16
-#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_X86_NUMA */
 
 #define MAX_MPC_ENTRY 1024
 
@@ -184,11 +184,11 @@
  *	7	2 CPU MCA+PCI
  */
 
-#ifdef CONFIG_MULTIQUAD
+#ifdef CONFIG_X86_NUMA
 #define MAX_IRQ_SOURCES 512
-#else /* !CONFIG_MULTIQUAD */
+#else /* !CONFIG_X86_NUMA */
 #define MAX_IRQ_SOURCES 256
-#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_X86_NUMA */
 
 #define MAX_MP_BUSSES 32
 enum mp_bustype {
diff -Nur linux-2.5.37-vanilla/include/asm-i386/smp.h linux-2.5.37-multiquad/include/asm-i386/smp.h
--- linux-2.5.37-vanilla/include/asm-i386/smp.h	Fri Sep 20 08:20:15 2002
+++ linux-2.5.37-multiquad/include/asm-i386/smp.h	Fri Sep 20 13:50:22 2002
@@ -22,7 +22,7 @@
 #endif
 
 #ifdef CONFIG_SMP
-# ifdef CONFIG_MULTIQUAD
+# ifdef CONFIG_CLUSTERED_APIC
 #  define TARGET_CPUS 0xf     /* all CPUs in *THIS* quad */
 #  define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
 # else
@@ -35,13 +35,13 @@
 #endif
 
 #ifndef clustered_apic_mode
- #ifdef CONFIG_MULTIQUAD
+ #ifdef CONFIG_CLUSTERED_APIC
   #define clustered_apic_mode (1)
   #define esr_disable (1)
- #else /* !CONFIG_MULTIQUAD */
+ #else /* !CONFIG_CLUSTERED_APIC */
   #define clustered_apic_mode (0)
   #define esr_disable (0)
- #endif /* CONFIG_MULTIQUAD */
+ #endif /* CONFIG_CLUSTERED_APIC */
 #endif 
 
 #ifdef CONFIG_SMP
diff -Nur linux-2.5.37-vanilla/include/asm-i386/smpboot.h linux-2.5.37-multiquad/include/asm-i386/smpboot.h
--- linux-2.5.37-vanilla/include/asm-i386/smpboot.h	Fri Sep 20 08:20:35 2002
+++ linux-2.5.37-multiquad/include/asm-i386/smpboot.h	Fri Sep 20 13:50:22 2002
@@ -2,35 +2,35 @@
 #define __ASM_SMPBOOT_H
 
 #ifndef clustered_apic_mode
- #ifdef CONFIG_MULTIQUAD
+ #ifdef CONFIG_CLUSTERED_APIC
   #define clustered_apic_mode (1)
- #else /* !CONFIG_MULTIQUAD */
+ #else /* !CONFIG_CLUSTERED_APIC */
   #define clustered_apic_mode (0)
- #endif /* CONFIG_MULTIQUAD */
+ #endif /* CONFIG_CLUSTERED_APIC */
 #endif 
  
-#ifdef CONFIG_MULTIQUAD
+#ifdef CONFIG_CLUSTERED_APIC
  #define TRAMPOLINE_LOW phys_to_virt(0x8)
  #define TRAMPOLINE_HIGH phys_to_virt(0xa)
-#else /* !CONFIG_MULTIQUAD */
+#else /* !CONFIG_CLUSTERED_APIC */
  #define TRAMPOLINE_LOW phys_to_virt(0x467)
  #define TRAMPOLINE_HIGH phys_to_virt(0x469)
-#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_CLUSTERED_APIC */
 
-#ifdef CONFIG_MULTIQUAD
+#ifdef CONFIG_CLUSTERED_APIC
  #define boot_cpu_apicid boot_cpu_logical_apicid
-#else /* !CONFIG_MULTIQUAD */
+#else /* !CONFIG_CLUSTERED_APIC */
  #define boot_cpu_apicid boot_cpu_physical_apicid
-#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_CLUSTERED_APIC */
 
 /*
  * How to map from the cpu_present_map
  */
-#ifdef CONFIG_MULTIQUAD
+#ifdef CONFIG_CLUSTERED_APIC
  #define cpu_present_to_apicid(mps_cpu) ( ((mps_cpu/4)*16) + (1<<(mps_cpu%4)) )
-#else /* !CONFIG_MULTIQUAD */
+#else /* !CONFIG_CLUSTERED_APIC */
  #define cpu_present_to_apicid(apicid) (apicid)
-#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_CLUSTERED_APIC */
 
 /*
  * Mappings between logical cpu number and logical / physical apicid
@@ -45,18 +45,13 @@
 #define cpu_to_logical_apicid(cpu) cpu_2_logical_apicid[cpu]
 #define physical_apicid_to_cpu(apicid) physical_apicid_2_cpu[apicid]
 #define cpu_to_physical_apicid(cpu) cpu_2_physical_apicid[cpu]
-#ifdef CONFIG_MULTIQUAD			/* use logical IDs to bootstrap */
+#ifdef CONFIG_CLUSTERED_APIC			/* use logical IDs to bootstrap */
 #define boot_apicid_to_cpu(apicid) logical_apicid_2_cpu[apicid]
 #define cpu_to_boot_apicid(cpu) cpu_2_logical_apicid[cpu]
-#else /* !CONFIG_MULTIQUAD */		/* use physical IDs to bootstrap */
+#else /* !CONFIG_CLUSTERED_APIC */		/* use physical IDs to bootstrap */
 #define boot_apicid_to_cpu(apicid) physical_apicid_2_cpu[apicid]
 #define cpu_to_boot_apicid(cpu) cpu_2_physical_apicid[cpu]
-#endif /* CONFIG_MULTIQUAD */
-
-
-#ifdef CONFIG_MULTIQUAD
-#else /* !CONFIG_MULTIQUAD */
-#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_CLUSTERED_APIC */
 
 
 #endif
diff -Nur linux-2.5.37-vanilla/kernel/printk.c linux-2.5.37-multiquad/kernel/printk.c
--- linux-2.5.37-vanilla/kernel/printk.c	Fri Sep 20 08:20:36 2002
+++ linux-2.5.37-multiquad/kernel/printk.c	Fri Sep 20 13:50:22 2002
@@ -30,7 +30,7 @@
 
 #include <asm/uaccess.h>
 
-#if defined(CONFIG_MULTIQUAD) || defined(CONFIG_IA64)
+#if defined(CONFIG_X86_NUMA) || defined(CONFIG_IA64)
 #define LOG_BUF_LEN	(65536)
 #elif defined(CONFIG_ARCH_S390)
 #define LOG_BUF_LEN	(131072)

--------------030607040802090703080501--

