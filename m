Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316641AbSE0Oyh>; Mon, 27 May 2002 10:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316643AbSE0Oyg>; Mon, 27 May 2002 10:54:36 -0400
Received: from jalon.able.es ([212.97.163.2]:28667 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316641AbSE0Oyf>;
	Mon, 27 May 2002 10:54:35 -0400
Date: Mon, 27 May 2002 16:54:20 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH][RFC] PentiumPro/II split in x86 config
Message-ID: <20020527145420.GA6738@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Patch below splits the config build option for PentiumPro and PentiumII
to make them different, so gcc (see next patch) can generate pII
specific code. It also kills the lock errata protection in PII code, so
it only applies to PPro, not PII.

Due to Alan's advice, it also adds a check that will panic if a PII or
higher kernel is run on a PPro or lesser (plz, I put that code in the
place I thought it was the best, but probably I'm wrong...).

It still keeps -march=i686. I will change it on a next patch.

Comments ?

Patch follows (91-split-ppro-config):

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
+	if (c->x86 <= 5)
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
