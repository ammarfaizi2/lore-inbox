Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266053AbSLNXWH>; Sat, 14 Dec 2002 18:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266064AbSLNXWH>; Sat, 14 Dec 2002 18:22:07 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:44675 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S266053AbSLNXWF>;
	Sat, 14 Dec 2002 18:22:05 -0500
Message-ID: <3DFBBEBD.6000605@colorfullife.com>
Date: Sun, 15 Dec 2002 00:29:01 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: boot_cpu_data problem
Content-Type: multipart/mixed;
 boundary="------------010903040608030500000504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010903040608030500000504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I ran into two problems with boot_cpu_data:

- boot_cpu_data doesn't contain the common capabilities of all cpus, it 
contains the capabilities of the last booted cpu:
head.S is called by the trampoline code, and that overwrites 
boot_cpu_data. [Untested due to lack of hardware]

- "mem=nopentium" disables the pse bit, but that is lost when 
identify_cpu calls cpuid again.

What about the attached patch?
it creates an __initdata structure for head.S and adds a flag that 
informs identify_cpu that pse is disabled.

--
    Manfred

--------------010903040608030500000504
Content-Type: text/plain;
 name="patch-boot"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-boot"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 51
//  EXTRAVERSION =
--- 2.5/arch/i386/kernel/setup.c	2002-12-14 22:57:48.000000000 +0100
+++ build-2.5/arch/i386/kernel/setup.c	2002-12-15 00:23:06.000000000 +0100
@@ -48,6 +48,9 @@
  */
 
 char ignore_irq13;		/* set if exception 16 works */
+/* cpu data as detected by the assembly code in head.S */
+struct cpuinfo_x86 early_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
+/* common cpu data for all cpus */
 struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 
 unsigned long mmu_cr4_features;
@@ -87,6 +90,7 @@
 extern int root_mountflags;
 extern char _text, _etext, _edata, _end;
 extern int blk_nohighio;
+extern int pse_disable;
 void __init visws_get_board_type_and_rev(void);
 
 unsigned long saved_videomode;
@@ -523,6 +527,7 @@
 			if (!memcmp(from+4, "nopentium", 9)) {
 				from += 9+4;
 				clear_bit(X86_FEATURE_PSE, boot_cpu_data.x86_capability);
+				pse_disable = 1;
 			} else if (!memcmp(from+4, "exactmap", 8)) {
 				from += 8+4;
 				e820.nr_map = 0;
@@ -837,6 +842,7 @@
 {
 	unsigned long max_low_pfn;
 
+	memcpy(&boot_cpu_data, &early_cpu_data, sizeof(early_cpu_data));
 	pre_setup_arch_hook();
 	early_cpu_init();
 
--- 2.5/arch/i386/kernel/cpu/common.c	2002-11-20 19:13:03.000000000 +0100
+++ build-2.5/arch/i386/kernel/cpu/common.c	2002-12-15 00:00:45.000000000 +0100
@@ -42,6 +42,7 @@
 }
 __setup("cachesize=", cachesize_setup);
 
+int pse_disable __initdata = 0;
 #ifndef CONFIG_X86_TSC
 static int tsc_disable __initdata = 0;
 
@@ -313,6 +314,9 @@
 	if ( tsc_disable )
 		clear_bit(X86_FEATURE_TSC, c->x86_capability);
 
+	if ( pse_disable )
+		clear_bit(X86_FEATURE_PSE, c->x86_capability);
+
 	/* FXSR disabled? */
 	if (disable_x86_fxsr) {
 		clear_bit(X86_FEATURE_FXSR, c->x86_capability);
--- 2.5/arch/i386/kernel/head.S	2002-12-14 10:06:55.000000000 +0100
+++ build-2.5/arch/i386/kernel/head.S	2002-12-15 00:05:33.000000000 +0100
@@ -23,10 +23,10 @@
 #define NEW_CL_POINTER		0x228	/* Relative to real mode data */
 
 /*
- * References to members of the boot_cpu_data structure.
+ * References to members of the early_cpu_data structure.
  */
 
-#define CPU_PARAMS	boot_cpu_data
+#define CPU_PARAMS	early_cpu_data
 #define X86		CPU_PARAMS+0
 #define X86_VENDOR	CPU_PARAMS+1
 #define X86_MODEL	CPU_PARAMS+2
--- 2.5/include/asm-i386/processor.h	2002-11-30 10:52:22.000000000 +0100
+++ build-2.5/include/asm-i386/processor.h	2002-12-14 23:52:40.000000000 +0100
@@ -77,6 +77,7 @@
  */
 
 extern struct cpuinfo_x86 boot_cpu_data;
+extern struct cpuinfo_x86 early_cpu_data;
 extern struct tss_struct init_tss[NR_CPUS];
 
 #ifdef CONFIG_SMP

--------------010903040608030500000504--


