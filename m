Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317644AbSFLGbq>; Wed, 12 Jun 2002 02:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317646AbSFLGbp>; Wed, 12 Jun 2002 02:31:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39880 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317644AbSFLGbk>;
	Wed, 12 Jun 2002 02:31:40 -0400
Date: Wed, 12 Jun 2002 08:29:30 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Keith Owens <kaos@ocs.com.au>
Cc: Cengiz Akinli <cengiz@drtalus.aoe.vt.edu>, <linux-kernel@vger.kernel.org>,
        xsdg <xsdg@openprojects.net>
Subject: [patch] early printk. (was: Re: computer reboots before "Uncompressing
 Linux..." with 2.5.19-xfs)
In-Reply-To: <17757.1023845630@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.44.0206120825510.4043-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Jun 2002, Keith Owens wrote:

> >>Then, after a small pause, the box reboots (note: it does _not_ print
> >>"Uncompressing Linux...").  I have tried the following:
> >
> >Interesting problem.....  Interesting because I'm having the EXACT
> >SAME PROBLEM!!!!  ARRRRRGGGGHHH!!!!
> 
> Try http://marc.theaimsgroup.com/?l=linux-kernel&m=101072840225142&w=2

you might as well try the attached early_printk() patch, it's slightly
easier to use than a one-char macro. But the goal is the same.

	Ingo

diff -Naur -X dontdiff linux-2.4.14-gold/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.14-gold/Documentation/Configure.help	Mon Nov 12 12:56:02 2001
+++ linux/Documentation/Configure.help	Wed Nov 14 11:20:39 2001
@@ -18510,6 +18510,13 @@
   It is recommended to be used on a NetWinder, but it is not a
   necessity.
 
+Early printk support
+CONFIG_X86_EARLY_PRINTK
+  Saying Y here enables the early_printk function, which allows output
+  to the console much earlier in the boot process than printk.  This 
+  is useful when debugging fatal problems early in the boot sequence 
+  (e.g. within setup_arch).  If unsure, say N.
+  
 Debug high memory support
 CONFIG_DEBUG_HIGHMEM
   This options enables addition error checking for high memory systems.
diff -Naur -X dontdiff linux-2.4.14-gold/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.4.14-gold/arch/i386/config.in	Mon Nov 12 12:55:48 2001
+++ linux/arch/i386/config.in	Wed Nov 14 11:08:50 2001
@@ -405,6 +405,7 @@
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
+   bool '  Early printk support' CONFIG_X86_EARLY_PRINTK
 fi
 
 endmenu
diff -Naur -X dontdiff linux-2.4.14-gold/arch/i386/kernel/Makefile linux/arch/i386/kernel/Makefile
--- linux-2.4.14-gold/arch/i386/kernel/Makefile	Mon Nov 12 12:55:48 2001
+++ linux/arch/i386/kernel/Makefile	Wed Nov 14 11:09:04 2001
@@ -40,5 +40,6 @@
 obj-$(CONFIG_X86_LOCAL_APIC)	+= mpparse.o apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
+obj-$(CONFIG_X86_EARLY_PRINTK)	+= debug.o
 
 include $(TOPDIR)/Rules.make
diff -Naur -X dontdiff linux-2.4.14-gold/arch/i386/kernel/debug.c linux/arch/i386/kernel/debug.c
--- linux-2.4.14-gold/arch/i386/kernel/debug.c	Wed Dec 31 16:00:00 1969
+++ linux/arch/i386/kernel/debug.c	Wed Nov 14 13:12:06 2001
@@ -0,0 +1,67 @@
+/*
+ *  debug.c - IA32 Early Debug Support
+ *
+ *  Copyright (C) 2001 Ingo Molnar <mingo@elte.hu>  [early_printk support]
+ *
+ *  Boot-time and early wakeup debug support for IA32 platforms.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/kernel_stat.h>
+#include <linux/swap.h>
+#include <linux/swapctl.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+
+
+/* --------------------------------------------------------------------------
+                                 Early printk
+   -------------------------------------------------------------------------- */
+
+#ifdef CONFIG_X86_EARLY_PRINTK
+
+int early_printk_disable = 0;
+char printk_buffer[1024];
+
+#define vmem ((char *)(PAGE_OFFSET+0xb8000))
+
+#define NCOLS 80
+#define NROWS 25
+
+#define early_putc(c, row, line, color) \
+		{ vmem[2*(row)+(line)]=(c); vmem[2*(row)+(line)+1]=(color); }
+
+void __early_printk(char * str)
+{
+	char num [16];
+	int i;
+	static int x = 0;
+	static int y = 0;
+	static int line = 0;
+	int s_len = strlen(str), num_len;
+
+	num_len = sprintf(num, "<%03d> ", line);
+	num[num_len] = 0;
+
+	for (i = 0; i < num_len; i++)
+		early_putc(num[i], i, y, 0x2f);
+
+	x = num_len;
+
+	for (i = 0; i < s_len; i++) {
+		early_putc(str[i], x, y, 0x3f);
+		x++;
+		if ((str[i] == '\n') || x > NCOLS) {
+			line++;
+			y += 2*NCOLS;
+			x = 0;
+			if (y >= NROWS*2*NCOLS)
+				y = 0;
+		}
+	}
+}
+
+#endif /*CONFIG_X86_EARLY_PRINTK*/
diff -Naur -X dontdiff linux-2.4.14-gold/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
--- linux-2.4.14-gold/arch/i386/kernel/setup.c	Mon Nov 12 12:55:48 2001
+++ linux/arch/i386/kernel/setup.c	Wed Nov 14 13:10:24 2001
@@ -108,10 +108,13 @@
 #include <asm/dma.h>
 #include <asm/mpspec.h>
 #include <asm/mmu_context.h>
+#ifdef CONFIG_X86_EARLY_PRINTK
+#include <asm/debug.h>
+#endif
+
 /*
  * Machine setup..
  */
-
 char ignore_irq13;		/* set if exception 16 works */
 struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 
@@ -941,7 +944,9 @@
 	 */
 	reserve_bootmem(PAGE_SIZE, PAGE_SIZE);
 #endif
-
+#ifdef CONFIG_X86_EARLY_PRINTK
+	early_printk("Early printk support enabled\n");
+#endif 
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
 	 * Find and reserve possible boot-time SMP configuration:
@@ -984,7 +989,6 @@
 	init_apic_mappings();
 #endif
 
-
 	/*
 	 * Request address space for all standard RAM and ROM resources
 	 * and also for regions reported as reserved by the e820.
@@ -1033,6 +1037,9 @@
 	conswitchp = &dummy_con;
 #endif
 #endif
+#ifdef CONFIG_X86_EARLY_PRINTK
+	early_printk_disable = 1;
+#endif 
 }
 
 #ifndef CONFIG_X86_TSC
diff -Naur -X dontdiff linux-2.4.14-gold/include/asm-i386/debug.h linux/include/asm-i386/debug.h
--- linux-2.4.14-gold/include/asm-i386/debug.h	Wed Dec 31 16:00:00 1969
+++ linux/include/asm-i386/debug.h	Wed Nov 14 13:12:51 2001
@@ -0,0 +1,41 @@
+/*
+ *  asm-i386/debug.h - IA32 Early Debug Support
+ *
+ *  Copyright (C) 2001 Ingo Molnar <mingo@elte.hu>
+ */
+
+#ifndef _ASM_DEBUG_H
+#define _ASM_DEBUG_H
+
+
+/* --------------------------------------------------------------------------
+                                 Early printk
+   -------------------------------------------------------------------------- */
+
+#if !defined(ASSEMBLY) && !defined(__ASSEMBLY__)
+
+#ifdef CONFIG_X86_EARLY_PRINTK
+
+extern int early_printk_disable;
+extern char printk_buffer[1024];
+extern void __early_printk(char * str);
+
+static inline void early_printk(char * v, ...) 
+{
+	if (!early_printk_disable) {
+		unsigned int len = sprintf(printk_buffer, v);
+		printk_buffer[len] = 0;
+		__early_printk(printk_buffer);
+	}
+	printk(v);
+}
+
+#else /*CONFIG_X86_EARLY_PRINTK*/
+
+#define early_printk(v...) do { printk(v); } while (0)
+
+#endif /*CONFIG_X86_EARLY_PRINTK*/
+
+#endif /*!defined(ASSEMBLY) && !defined(__ASSEMBLY__)*/
+
+#endif /*_ASM_DEBUG_H*/

