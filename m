Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262711AbSJCAiD>; Wed, 2 Oct 2002 20:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSJCAiD>; Wed, 2 Oct 2002 20:38:03 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:48268 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262711AbSJCAhy>;
	Wed, 2 Oct 2002 20:37:54 -0400
Date: Wed, 02 Oct 2002 17:39:17 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] NUMA-Q fixes 2/2
Message-ID: <411500000.1033605557@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch basically just renames usages of CONFIG_MULTIQUAD to
CONFIG_X86_NUMAQ. The original multiquad option covered a variety
of sins, and just made a mess (my fault). After extensive community 
discussion, this is the naming scheme everyone agreed to - the
CONFIG_X86_NUMAQ option already exists, we're just renaming usages
of MULTIQUAD to it, and removing the MULTIQUAD option.

A couple of points of interest:

1. Stuff that's really to do with clustered APIC mode is put under 
CONFIG_CLUSTERED_APIC instead, as it's not specific to the NUMA-Q.

2. the wbinvd in trampoline is exposed, not under a config option. Alan did
this some time ago in his tree, and has had no problems. It's just a flush, so
should be perfectly safe for everyone.

Note that the definitions of clustered_apic_mode are still duplicated, so the
changes appear twice. I'm not making it worse, just haven't fixed this one yet,
will do that next.

Patch was written by Matt Dobson.

Please apply,
Thanks,

Martin.

diff -purN -X /home/mbligh/.diff.exclude tsc_disable/arch/i386/boot/compressed/misc.c remove_multiquad/arch/i386/boot/compressed/misc.c
--- tsc_disable/arch/i386/boot/compressed/misc.c	Tue Oct  1 00:07:05 2002
+++ remove_multiquad/arch/i386/boot/compressed/misc.c	Wed Oct  2 16:54:07 2002
@@ -120,7 +120,7 @@ static char *vidmem = (char *)0xb8000;
 static int vidport;
 static int lines, cols;
 
-#ifdef CONFIG_MULTIQUAD
+#ifdef CONFIG_X86_NUMAQ
 static void * xquad_portio = NULL;
 #endif
 
diff -purN -X /home/mbligh/.diff.exclude tsc_disable/arch/i386/config.in remove_multiquad/arch/i386/config.in
--- tsc_disable/arch/i386/config.in	Wed Oct  2 16:52:27 2002
+++ remove_multiquad/arch/i386/config.in	Wed Oct  2 16:54:07 2002
@@ -173,7 +173,7 @@ else
      #Platform Choices
      bool 'Multiquad (IBM/Sequent) NUMAQ support' CONFIG_X86_NUMAQ
      if [ "$CONFIG_X86_NUMAQ" = "y" ]; then
-        define_bool CONFIG_MULTIQUAD y
+        define_bool CONFIG_CLUSTERED_APIC y
      fi
      # Common NUMA Features
      if [ "$CONFIG_X86_NUMAQ" = "y" ]; then
diff -purN -X /home/mbligh/.diff.exclude tsc_disable/arch/i386/kernel/trampoline.S remove_multiquad/arch/i386/kernel/trampoline.S
--- tsc_disable/arch/i386/kernel/trampoline.S	Tue Oct  1 00:06:55 2002
+++ remove_multiquad/arch/i386/kernel/trampoline.S	Wed Oct  2 16:54:07 2002
@@ -36,9 +36,7 @@
 
 ENTRY(trampoline_data)
 r_base = .
-#ifdef CONFIG_MULTIQUAD
 	wbinvd
-#endif /* CONFIG_MULTIQUAD */
 	mov	%cs, %ax	# Code and data in the same place
 	mov	%ax, %ds
 
diff -purN -X /home/mbligh/.diff.exclude tsc_disable/include/asm-i386/io.h remove_multiquad/include/asm-i386/io.h
--- tsc_disable/include/asm-i386/io.h	Tue Oct  1 00:06:59 2002
+++ remove_multiquad/include/asm-i386/io.h	Wed Oct  2 16:54:07 2002
@@ -297,9 +297,9 @@ static inline void flush_write_buffers(v
 #define __FULL_SLOW_DOWN_IO __SLOW_DOWN_IO
 #endif
 
-#ifdef CONFIG_MULTIQUAD
+#ifdef CONFIG_X86_NUMAQ
 extern void *xquad_portio;    /* Where the IO area was mapped */
-#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_X86_NUMAQ */
 
 /*
  * Talk about misusing macros..
@@ -310,7 +310,7 @@ static inline void out##s(unsigned x val
 #define __OUT2(s,s1,s2) \
 __asm__ __volatile__ ("out" #s " %" s1 "0,%" s2 "1"
 
-#ifdef CONFIG_MULTIQUAD
+#ifdef CONFIG_X86_NUMAQ
 #define __OUTQ(s,ss,x)    /* Do the equivalent of the portio op on quads */ \
 static inline void out##ss(unsigned x value, unsigned short port) { \
 	if (xquad_portio) \
@@ -338,9 +338,9 @@ static inline RETURN_TYPE in##ss##_quad(
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
@@ -351,7 +351,7 @@ __OUT1(s##_local,x) __OUT2(s,s1,"w") : :
 __OUT1(s##_p_local,x) __OUT2(s,s1,"w") __FULL_SLOW_DOWN_IO : : "a" (value), "Nd" (port));} \
 __OUTQ(s,s,x) \
 __OUTQ(s,s##_p,x) 
-#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_X86_NUMAQ */
 
 #define __IN1(s) \
 static inline RETURN_TYPE in##s(unsigned short port) { RETURN_TYPE _v;
@@ -359,7 +359,7 @@ static inline RETURN_TYPE in##s(unsigned
 #define __IN2(s,s1,s2) \
 __asm__ __volatile__ ("in" #s " %" s2 "1,%" s1 "0"
 
-#ifndef CONFIG_MULTIQUAD
+#ifndef CONFIG_X86_NUMAQ
 #define __IN(s,s1,i...) \
 __IN1(s) __IN2(s,s1,"w") : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
 __IN1(s##_p) __IN2(s,s1,"w") __FULL_SLOW_DOWN_IO : "=a" (_v) : "Nd" (port) ,##i ); return _v; } 
@@ -370,7 +370,7 @@ __IN1(s##_local) __IN2(s,s1,"w") : "=a" 
 __IN1(s##_p_local) __IN2(s,s1,"w") __FULL_SLOW_DOWN_IO : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
 __INQ(s,s) \
 __INQ(s,s##_p) 
-#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_X86_NUMAQ */
 
 #define __INS(s) \
 static inline void ins##s(unsigned short port, void * addr, unsigned long count) \
diff -purN -X /home/mbligh/.diff.exclude tsc_disable/include/asm-i386/mpspec.h remove_multiquad/include/asm-i386/mpspec.h
--- tsc_disable/include/asm-i386/mpspec.h	Tue Oct  1 00:05:46 2002
+++ remove_multiquad/include/asm-i386/mpspec.h	Wed Oct  2 16:54:07 2002
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
 
@@ -184,11 +184,11 @@ struct mpc_config_translation
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
diff -purN -X /home/mbligh/.diff.exclude tsc_disable/include/asm-i386/smp.h remove_multiquad/include/asm-i386/smp.h
--- tsc_disable/include/asm-i386/smp.h	Tue Oct  1 00:06:13 2002
+++ remove_multiquad/include/asm-i386/smp.h	Wed Oct  2 16:54:07 2002
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
diff -purN -X /home/mbligh/.diff.exclude tsc_disable/include/asm-i386/smpboot.h remove_multiquad/include/asm-i386/smpboot.h
--- tsc_disable/include/asm-i386/smpboot.h	Tue Oct  1 00:07:40 2002
+++ remove_multiquad/include/asm-i386/smpboot.h	Wed Oct  2 16:54:07 2002
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
@@ -45,18 +45,13 @@ extern volatile int cpu_2_physical_apici
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
diff -purN -X /home/mbligh/.diff.exclude tsc_disable/kernel/printk.c remove_multiquad/kernel/printk.c
--- tsc_disable/kernel/printk.c	Tue Oct  1 00:07:50 2002
+++ remove_multiquad/kernel/printk.c	Wed Oct  2 16:54:07 2002
@@ -30,7 +30,7 @@
 
 #include <asm/uaccess.h>
 
-#if defined(CONFIG_MULTIQUAD) || defined(CONFIG_IA64)
+#if defined(CONFIG_X86_NUMA) || defined(CONFIG_IA64)
 #define LOG_BUF_LEN	(65536)
 #elif defined(CONFIG_ARCH_S390)
 #define LOG_BUF_LEN	(131072)

