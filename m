Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316769AbSE0WN5>; Mon, 27 May 2002 18:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316770AbSE0WN4>; Mon, 27 May 2002 18:13:56 -0400
Received: from jalon.able.es ([212.97.163.2]:6560 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316769AbSE0WNz>;
	Mon, 27 May 2002 18:13:55 -0400
Date: Tue, 28 May 2002 00:13:40 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] PentiumPro/II split in x86 config (2)
Message-ID: <20020527221340.GE1848@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected to detect correctly a PII.

Any chance to have this in next pre ? I think it is safe, old configs set up
for CONFIG_M686 will work just the same, but now people can have a slightly
better PII binary...

--- linux-2.4.18/arch/i386/Makefile.orig	2002-05-26 01:26:40.000000000 +0200
+++ linux-2.4.18/arch/i386/Makefile	2002-05-26 01:28:52.000000000 +0200
@@ -50,6 +50,10 @@
 CFLAGS += -march=i686
 endif
 
+ifdef CONFIG_MPENTIUMII
+CFLAGS += -march=i686
+endif
+
 ifdef CONFIG_MPENTIUMIII
 CFLAGS += -march=i686
 endif
--- linux-2.4.18/arch/i386/config.in.orig	2002-05-26 01:29:01.000000000 +0200
+++ linux-2.4.18/arch/i386/config.in	2002-05-26 01:29:41.000000000 +0200
@@ -32,7 +32,8 @@
 	 586/K5/5x86/6x86/6x86MX		CONFIG_M586 \
 	 Pentium-Classic			CONFIG_M586TSC \
 	 Pentium-MMX				CONFIG_M586MMX \
-	 Pentium-Pro/Celeron/Pentium-II		CONFIG_M686 \
+	 Pentium-Pro			CONFIG_M686 \
+	 Pentium-II/Celeron		CONFIG_MPENTIUMII \
 	 Pentium-III/Celeron(Coppermine)	CONFIG_MPENTIUMIII \
 	 Pentium-4				CONFIG_MPENTIUM4 \
 	 K6/K6-II/K6-III			CONFIG_MK6 \
@@ -99,6 +99,13 @@
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_PPRO_FENCE y
 fi
+if [ "$CONFIG_MPENTIUMII" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_GOOD_APIC y
+   define_bool CONFIG_X86_PGE y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+fi
 if [ "$CONFIG_MPENTIUMIII" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_TSC y
--- linux-2.4.18/arch/i386/defconfig.orig	2002-05-26 01:34:19.000000000 +0200
+++ linux-2.4.18/arch/i386/defconfig	2002-05-26 01:34:48.000000000 +0200
@@ -27,6 +27,7 @@
 # CONFIG_M586TSC is not set
 # CONFIG_M586MMX is not set
 # CONFIG_M686 is not set
+# CONFIG_MPENTIUMII is not set
 CONFIG_MPENTIUMIII=y
 # CONFIG_MPENTIUM4 is not set
 # CONFIG_MK6 is not set
--- linux/arch/i386/kernel/setup.c.orig	2002-05-27 00:32:58.000000000 +0200
+++ linux/arch/i386/kernel/setup.c	2002-05-27 00:46:36.000000000 +0200
@@ -2092,6 +2092,14 @@
 
 extern void trap_init_f00f_bug(void);
 
+static void __init check_intel_compat(struct cpuinfo_x86 *c)
+{
+#if defined(CONFIG_MPENTIUMII) || defined(CONFIG_MPENTIUMIII) || defined(CONFIG_MPENTIUM4)
+	if ( (c->x86 < 6) || ((c->x86==6) && (c->x86_model<=1)) )
+		panic("Kernel is unsafe/incompatible with this CPU model. Check your build settings !\n");
+#endif
+}
+
 static void __init init_intel(struct cpuinfo_x86 *c)
 {
 #ifndef CONFIG_M686
@@ -2100,6 +2108,8 @@
 	char *p = NULL;
 	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
 
+	check_intel_compat(c);
+
 #ifndef CONFIG_M686
 	/*
 	 * All current models of Pentium and Pentium with MMX technology CPUs


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam4 #2 SMP dom may 26 11:20:42 CEST 2002 i686
