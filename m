Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316715AbSFJHWM>; Mon, 10 Jun 2002 03:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316721AbSFJHWL>; Mon, 10 Jun 2002 03:22:11 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:50308 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316715AbSFJHWJ>; Mon, 10 Jun 2002 03:22:09 -0400
Date: Mon, 10 Jun 2002 08:54:17 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][RFC] Memory barriers
Message-ID: <Pine.LNX.4.44.0206100852280.18155-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kinda self explanatory. Enables SFENCE for K7,P3 and MFENCE,LFENCE for P4, 

--- linux-2.5.19/arch/i386/config.in.orig	Mon Jun  3 10:33:18 2002
+++ linux-2.5.19/arch/i386/config.in	Mon Jun 10 08:12:02 2002
@@ -96,12 +96,16 @@
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_SFENCE y
 fi
 if [ "$CONFIG_MPENTIUM4" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_SFENCE y
+   define_bool CONFIG_X86_LFENCE y
+   define_bool CONFIG_X86_MFENCE y
 fi
 if [ "$CONFIG_MK6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -115,6 +119,7 @@
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_SFENCE y
 fi
 if [ "$CONFIG_MELAN" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
--- linux-2.5.19/include/asm-i386/system.h.orig	Mon Jun 10 08:10:55 2002
+++ linux-2.5.19/include/asm-i386/system.h	Mon Jun 10 08:11:04 2002
@@ -284,16 +284,33 @@
  *
  * Some non intel clones support out of order store. wmb() ceases to be a
  * nop for these.
+ *
+ * Pentium III introduced the SFENCE instruction for serialising all store
+ * operations, Pentium IV further introduced LFENCE and MFENCE for load and
+ * memory barriers respecively.
  */
- 
+
+#ifdef CONFIG_X86_MFENCE
+#define mb()	__asm__ __volatile__ ("mfence": : :"memory")
+#else
 #define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
+#endif
+
+#ifdef CONFIG_X86_LFENCE
+#define rmb()	__asm__ __volatile__ ("lfence": : :"memory")
+#else
 #define rmb()	mb()
+#endif
 
+#ifdef CONFIG_X86_SFENCE
+#define wmb()	__asm__ __volatile__ ("sfence": : :"memory")
+#else
 #ifdef CONFIG_X86_OOSTORE
 #define wmb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
 #else
 #define wmb()	__asm__ __volatile__ ("": : :"memory")
 #endif
+#endif /* CONFIG_X86_SFENCE */
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()

-- 
http://function.linuxpower.ca


