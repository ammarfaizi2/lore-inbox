Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbUKCOnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbUKCOnj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 09:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUKCOnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 09:43:39 -0500
Received: from cantor.suse.de ([195.135.220.2]:22449 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261282AbUKCOnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 09:43:32 -0500
Date: Wed, 3 Nov 2004 15:40:06 +0100
From: Andi Kleen <ak@suse.de>
To: Jean Delvare <khali@linux-fr.org>
Cc: ak@suse.de, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: dmi_scan on x86_64
Message-ID: <20041103144006.GE24195@wotan.suse.de>
References: <20041103124642.GD18867@wotan.suse.de> <oW5plZBL.1099487525.5944720.khali@gcu.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oW5plZBL.1099487525.5944720.khali@gcu.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 02:12:07PM +0100, Jean Delvare wrote:
> 
> Hi Andi,
> 
> > > Any reason why dmi_scan is availble on the i386 arch and not on the
> > > x86_64 arch? I would have a need for the latter (for run-time
> > > identification purposes, not boot-time blacklisting).
> >
> > So far nothing needed it, so I didn't add it.  For what do you need it?
> 
> I am in the process of adding SMBus multiplexing support for the Tyan
> S4882 motherboard, as seen on this thread:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109863982018999&w=2

Here's a patch for testing.

-Andi


Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c	2004-11-03 15:21:16.%N +0100
+++ linux/arch/x86_64/kernel/setup.c	2004-11-03 15:21:16.%N +0100
@@ -40,6 +40,7 @@
 #include <linux/acpi.h>
 #include <linux/kallsyms.h>
 #include <linux/edd.h>
+#include <linux/dmi.h>
 #include <asm/mtrr.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -1120,3 +1121,12 @@
 	.stop =	c_stop,
 	.show =	show_cpuinfo,
 };
+
+/* We don't need DMI early, so call it later after bootmem when
+   ioremap works. */
+static __init void call_dmi(void) 
+{ 
+	dmi_scan_machine();	
+}
+core_initcall(call_dmi);
+ 
\ No newline at end of file
Index: linux/arch/x86_64/kernel/Makefile
===================================================================
--- linux.orig/arch/x86_64/kernel/Makefile	2004-11-03 15:21:16.%N +0100
+++ linux/arch/x86_64/kernel/Makefile	2004-11-03 15:21:16.%N +0100
@@ -6,7 +6,7 @@
 EXTRA_AFLAGS	:= -traditional
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_x86_64.o \
-		x8664_ksyms.o i387.o syscall.o vsyscall.o \
+		x8664_ksyms.o i387.o syscall.o vsyscall.o dmi_scan.o \
 		setup64.o bootflag.o e820.o reboot.o warmreboot.o quirks.o
 
 obj-$(CONFIG_X86_MCE)         += mce.o
@@ -41,3 +41,4 @@
 microcode-$(subst m,y,$(CONFIG_MICROCODE))  += ../../i386/kernel/microcode.o
 intel_cacheinfo-y		+= ../../i386/kernel/cpu/intel_cacheinfo.o
 quirks-y			+= ../../i386/kernel/quirks.o
+dmi_scan-y			+= ../../i386/kernel/dmi_scan.o
Index: linux/arch/i386/kernel/dmi_scan.c
===================================================================
--- linux.orig/arch/i386/kernel/dmi_scan.c	2004-10-19 01:55:01.%N +0200
+++ linux/arch/i386/kernel/dmi_scan.c	2004-11-03 15:28:49.%N +0100
@@ -11,6 +11,12 @@
 #include <linux/dmi.h>
 #include <linux/bootmem.h>
 
+#ifdef CONFIG_X86_64
+#define bt_ioremap ioremap
+#define bt_iounmap(a,b) iounmap(a)
+#define alloc_bootmem(a) kmalloc(a, GFP_ATOMIC)
+#endif
+
 
 int es7000_plat = 0;
 
@@ -162,6 +168,9 @@
 #define NO_MATCH	{ DMI_NONE, NULL}
 #define MATCH		DMI_MATCH
 
+/* Before you add x86-64 specific entries here move this to a sepatate file. */
+#ifndef CONFIG_X86_64 
+
 /*
  * Toshiba keyboard likes to repeat keys when they are not repeated.
  */
@@ -251,6 +260,8 @@
 }  
 #endif
 
+#endif
+
 /*
  *	Process the DMI blacklists
  */
@@ -263,6 +274,8 @@
  
 static __initdata struct dmi_blacklist dmi_blacklist[]={
 
+#ifndef CONFIG_X86_64
+
 	{ broken_toshiba_keyboard, "Toshiba Satellite 4030cdt", { /* Keyboard generates spurious repeats */
 			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
 			NO_MATCH, NO_MATCH, NO_MATCH
@@ -441,6 +454,8 @@
 
 #endif
 
+#endif
+
 	{ NULL, }
 };
 
Index: linux/include/linux/dmi.h
===================================================================
--- linux.orig/include/linux/dmi.h	2004-08-15 19:45:50.%N +0200
+++ linux/include/linux/dmi.h	2004-11-03 15:21:16.%N +0100
@@ -32,7 +32,7 @@
 
 #define DMI_MATCH(a,b)	{ a, b }
 
-#if defined(CONFIG_X86) && !defined(CONFIG_X86_64)
+#if defined(CONFIG_X86)
 
 extern int dmi_check_system(struct dmi_system_id *list);
 extern char * dmi_get_system_info(int field);
@@ -44,4 +44,6 @@
 
 #endif
 
+extern void dmi_scan_machine(void);
+
 #endif	/* __DMI_H__ */
