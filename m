Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261813AbSJNB6e>; Sun, 13 Oct 2002 21:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261814AbSJNB6e>; Sun, 13 Oct 2002 21:58:34 -0400
Received: from franka.aracnet.com ([216.99.193.44]:43160 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261813AbSJNB6b>; Sun, 13 Oct 2002 21:58:31 -0400
Date: Sun, 13 Oct 2002 19:02:18 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       Dave Jones <davej@codemonkey.org.uk>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Summit support for 2.5 [0/4]
Message-ID: <1924305625.1034535736@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.44.0210131514240.1775-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0210131514240.1775-100000@home.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 13 Oct 2002, Martin J. Bligh wrote:
>> 1. Time
>> 2. It'd make the patches much bigger and harder to read.
> 
> Hmm.. I'd actually rather have the code split up in the proper location,
> even if it would mean that summit support wouldn't work (or even
> necessarily compile) by the feature-freeze.

OK. Having looked at this, it actuallly looks easy enough, and
cleaner if I can just stick to the Summit stuff for now. The
patches will actually be smaller, and the only disadvantage seems
to be that I'll end up with less hair ;-) 

Below is a brief proof-of-concept I did, please cluebat me now if 
this isn't the type of thing you want before I burn hours and blood 
pressure fixing up the rest of it.

Consider me "re-aligned" ;-)

M.

PS. This distros want Summit to autodetect for their install kernels,
which is what the x86_summit switch is for.

------------

diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/Config.help subarch-1/arch/i386/Config.help
--- virgin/arch/i386/Config.help	Fri Oct 11 21:21:31 2002
+++ subarch-1/arch/i386/Config.help	Sun Oct 13 18:40:30 2002
@@ -73,6 +73,12 @@ CONFIG_X86_CYCLONE
   If you are suffering from time skew using a multi-CEC system, say YES.
   Otherwise it is safe to say NO.
 
+CONFIG_X86_SUMMIT
+  This option is needed for IBM systems that use the Summit/EXA chipset.
+  In particular, it is needed for the x440.
+
+  If you don't have one of these computers, you should say N here.
+
 CONFIG_X86_UP_IOAPIC
   An IO-APIC (I/O Advanced Programmable Interrupt Controller) is an
   SMP-capable replacement for PC-style interrupt controllers. Most
diff -urpN -X
/home/fletch/.diff.exclude virgin/arch/i386/Makefile subarch-1/arch/i386/Makefile
--- virgin/arch/i386/Makefile	Fri Oct 11 21:21:39 2002
+++ subarch-1/arch/i386/Makefile	Sun Oct 13 17:54:32 2002
@@ -46,7 +46,11 @@ CFLAGS += $(cflags-y)
 ifdef CONFIG_VISWS
 MACHINE	:= mach-visws
 else
-MACHINE	:= mach-generic
+ ifdef CONFIG_X86_SUMMIT
+  MACHINE	:= mach-summit
+ else
+  MACHINE	:= mach-generic
+ endif
 endif
 
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/config.in subarch-1/arch/i386/config.in
--- virgin/arch/i386/config.in	Fri Oct 11 21:21:38 2002
+++ subarch-1/arch/i386/config.in	Sun Oct 13 18:40:30 2002
@@ -172,7 +172,8 @@ else
   if [ "$CONFIG_X86_NUMA" = "y" ]; then

#Platform Choices
      bool 'Multiquad (IBM/Sequent) NUMAQ support' CONFIG_X86_NUMAQ
-     if [ "$CONFIG_X86_NUMAQ" = "y" ]; then
+     bool 'IBM x440 (Summit/EXA) support' CONFIG_X86_SUMMIT
+     if [ "$CONFIG_X86_NUMAQ" = "y" -o "$CONFIG_X86_SUMMIT" = "y" ]; then
         define_bool CONFIG_CLUSTERED_APIC y
      fi
      # Common NUMA Features
diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/kernel/apic.c subarch-1/arch/i386/kernel/apic.c
--- virgin/arch/i386/kernel/apic.c	Fri Oct 11 21:22:46 2002
+++ subarch-1/arch/i386/kernel/apic.c	Sun Oct 13 18:34:45 2002
@@ -31,6 +31,7 @@
 #include <asm/pgalloc.h>
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
+#include "mach_apic.h"
 
 void __init apic_intr_init(void)
 {
@@ -328,15 +329,13 @@
void __init setup_local_APIC (void)
 		 * Put the APIC into flat delivery mode.
 		 * Must be "all ones" explicitly for 82489DX.
 		 */
-		apic_write_around(APIC_DFR, 0xffffffff);
+		apic_write_around(APIC_DFR, APIC_DFR_VALUE);
 
 		/*
 		 * Set up the logical destination ID.
 		 */
 		value = apic_read(APIC_LDR);
-		value &= ~APIC_LDR_MASK;
-		value |= (1<<(smp_processor_id()+24));
-		apic_write_around(APIC_LDR, value);
+		apic_write_around(APIC_LDR, calculate_ldr(value));
 	}
 
 	/*
diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/kernel/io_apic.c subarch-1/arch/i386/kernel/io_apic.c
--- virgin/arch/i386/kernel/io_apic.c	Fri Oct 11 21:21:38 2002
+++ subarch-1/arch/i386/kernel/io_apic.c	Sun Oct 13 18:33:53 2002
@@ -35,6 +35,7 @@
 #include
<asm/io.h>
 #include <asm/smp.h>
 #include <asm/desc.h>
+#include "mach_apic.h"
 
 #undef APIC_LOCKUP_DEBUG
 
diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/mach-generic/mach_apic.h subarch-1/arch/i386/mach-generic/mach_apic.h
--- virgin/arch/i386/mach-generic/mach_apic.h	Wed Dec 31 16:00:00 1969
+++ subarch-1/arch/i386/mach-generic/mach_apic.h	Sun Oct 13 18:29:40 2002
@@ -0,0 +1,20 @@
+#ifndef __ASM_MACH_APICDEF_H
+#define __ASM_MACH_APICDEF_H
+
+static inline unsigned long calculate_ldr(unsigned long old)
+{
+	unsigned long id;
+
+	id = 1UL << smp_processor_id();
+	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
+}
+
+#define APIC_DFR_VALUE	(APIC_DFR_FLAT)
+
+#ifdef CONFIG_SMP
+ #define TARGET_CPUS (clustered_apic_mode ? 0xf
: cpu_online_map)
+#else
+ #define TARGET_CPUS 0x01
+#endif
+
+#endif /* __ASM_MACH_APICDEF_H */
diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/mach-summit/mach_apic.h subarch-1/arch/i386/mach-summit/mach_apic.h
--- virgin/arch/i386/mach-summit/mach_apic.h	Wed Dec 31 16:00:00 1969
+++ subarch-1/arch/i386/mach-summit/mach_apic.h	Sun Oct 13 18:14:32 2002
@@ -0,0 +1,20 @@
+#ifndef __ASM_MACH_APICDEF_H
+#define __ASM_MACH_APICDEF_H
+
+extern int x86_summit;
+
+static inline unsigned long calculate_ldr(unsigned long old)
+{
+	unsigned long id;
+
+	if (x86_summit)
+		id = xapic_phys_to_log_apicid(hard_smp_processor_id());
+	else
+		id = 1UL << smp_processor_id();
+	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
+}
+
+#define
APIC_DFR_VALUE	(x86_summit ? APIC_DFR_CLUSTER : APIC_DFR_FLAT)
+#define TARGET_CPUS	(x86_summit ? XAPIC_DEST_CPUS_MASK : cpu_online_map)
+
+#endif /* __ASM_MACH_APICDEF_H */
diff -urpN -X /home/fletch/.diff.exclude virgin/include/asm-i386/apicdef.h subarch-1/include/asm-i386/apicdef.h
--- virgin/include/asm-i386/apicdef.h	Fri Oct 11 21:22:09 2002
+++ subarch-1/include/asm-i386/apicdef.h	Sun Oct 13 18:40:30 2002
@@ -32,6 +32,8 @@
 #define			SET_APIC_LOGICAL_ID(x)	(((x)<<24))
 #define			APIC_ALL_CPUS		0xFF
 #define		APIC_DFR	0xE0
+#define			APIC_DFR_CLUSTER		0x0FFFFFFFul
+#define			APIC_DFR_FLAT			0xFFFFFFFFul
 #define		APIC_SPIV	0xF0
 #define			APIC_SPIV_FOCUS_DISABLED	(1<<9)
 #define			APIC_SPIV_APIC_ENABLED		(1<<8)
diff -urpN -X
/home/fletch/.diff.exclude virgin/include/asm-i386/smp.h subarch-1/include/asm-i386/smp.h
--- virgin/include/asm-i386/smp.h	Fri Oct 11 21:22:09 2002
+++ subarch-1/include/asm-i386/smp.h	Sun Oct 13 18:31:05 2002
@@ -21,17 +21,10 @@
 #endif
 #endif
 
-#ifdef CONFIG_SMP
-# ifdef CONFIG_CLUSTERED_APIC
-#  define TARGET_CPUS 0xf     /* all CPUs in *THIS* quad */
-#  define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
-# else
-#  define TARGET_CPUS cpu_online_map
-#  define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
-# endif
+#ifdef CONFIG_CLUSTERED_APIC
+ #define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
 #else
-# define INT_DELIVERY_MODE 1     /* logical delivery */
-# define TARGET_CPUS
0x01
+ #define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
 #endif
 
 #ifndef clustered_apic_mode

