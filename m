Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266310AbUFZQuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUFZQuV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 12:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267190AbUFZQuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 12:50:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4613 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267189AbUFZQtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 12:49:13 -0400
Date: Sat, 26 Jun 2004 17:49:04 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.7-bk: asm/setup.h and linux/init.h
Message-ID: <20040626174904.B30532@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20040626153511.A30532@flint.arm.linux.org.uk> <Pine.LNX.4.58.0406260903190.14449@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0406260903190.14449@ppc970.osdl.org>; from torvalds@osdl.org on Sat, Jun 26, 2004 at 09:05:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 09:05:57AM -0700, Linus Torvalds wrote:
> On Sat, 26 Jun 2004, Russell King wrote:
> > Is there a reason why we can't delete asm/setup.h from linux/init.h
> > and change that declaration to:
> > 
> > +extern char saved_command_line[];
> 
> Yes. A number of achitectures use something like
> 
> 	strlcpy(saved_command_line, cmd_line, sizeof(saved_command_line));
> 
> and that "sizeof()" would require the full declaration.
> 
> However, I don't see any reason why we couldn't make that sizeof be
> COMMAND_LINE_SIZE instead, if somebody is willing to grep and do the
> conversion and make sure everybody who now uses it has <asm/setup.h>
> included.

Ok, grepping around for sizeof.*saved_command_line and COMMAND_LINE_SIZE
resulted in this patch:

===== arch/alpha/kernel/setup.c 1.43 vs edited =====
--- 1.43/arch/alpha/kernel/setup.c	Thu Jun 24 09:55:53 2004
+++ edited/arch/alpha/kernel/setup.c	Sat Jun 26 17:35:52 2004
@@ -39,6 +39,7 @@
 #include <linux/reboot.h>
 #endif
 #include <linux/notifier.h>
+#include <asm/setup.h>
 #include <asm/io.h>
 
 extern struct notifier_block *panic_notifier_list;
===== arch/cris/kernel/setup.c 1.15 vs edited =====
--- 1.15/arch/cris/kernel/setup.c	Thu Jun 24 09:55:46 2004
+++ edited/arch/cris/kernel/setup.c	Sat Jun 26 17:36:04 2004
@@ -18,6 +18,8 @@
 #include <linux/seq_file.h>
 #include <linux/tty.h>
 
+#include <asm/setup.h>
+
 /*
  * Setup options
  */
===== arch/h8300/kernel/setup.c 1.8 vs edited =====
--- 1.8/arch/h8300/kernel/setup.c	Thu Jun 24 09:55:46 2004
+++ edited/arch/h8300/kernel/setup.c	Sat Jun 26 17:47:10 2004
@@ -155,8 +155,8 @@
 #endif
 	/* Keep a copy of command line */
 	*cmdline_p = &command_line[0];
-	memcpy(saved_command_line, command_line, sizeof(saved_command_line));
-	saved_command_line[sizeof(saved_command_line)-1] = 0;
+	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
+	saved_command_line[COMMAND_LINE_SIZE-1] = 0;
 
 #ifdef DEBUG
 	if (strlen(*cmdline_p)) 
===== arch/ia64/kernel/setup.c 1.75 vs edited =====
--- 1.75/arch/ia64/kernel/setup.c	Thu Jun 24 09:55:46 2004
+++ edited/arch/ia64/kernel/setup.c	Sat Jun 26 17:47:10 2004
@@ -47,6 +47,7 @@
 #include <asm/sal.h>
 #include <asm/sections.h>
 #include <asm/serial.h>
+#include <asm/setup.h>
 #include <asm/smp.h>
 #include <asm/system.h>
 #include <asm/unistd.h>
@@ -284,7 +285,7 @@
 	ia64_patch_vtop((u64) __start___vtop_patchlist, (u64) __end___vtop_patchlist);
 
 	*cmdline_p = __va(ia64_boot_param->command_line);
-	strlcpy(saved_command_line, *cmdline_p, sizeof(saved_command_line));
+	strlcpy(saved_command_line, *cmdline_p, COMMAND_LINE_SIZE);
 
 	efi_init();
 	io_port_init();
===== arch/m68knommu/kernel/setup.c 1.8 vs edited =====
--- 1.8/arch/m68knommu/kernel/setup.c	Thu Jun 24 09:55:46 2004
+++ edited/arch/m68knommu/kernel/setup.c	Sat Jun 26 17:47:10 2004
@@ -216,8 +216,8 @@
 
 	/* Keep a copy of command line */
 	*cmdline_p = &command_line[0];
-	memcpy(saved_command_line, command_line, sizeof(saved_command_line));
-	saved_command_line[sizeof(saved_command_line)-1] = 0;
+	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
+	saved_command_line[COMMAND_LINE_SIZE-1] = 0;
 
 #ifdef DEBUG
 	if (strlen(*cmdline_p)) 
===== arch/mips/kernel/setup.c 1.16 vs edited =====
--- 1.16/arch/mips/kernel/setup.c	Thu Jun 24 09:55:59 2004
+++ edited/arch/mips/kernel/setup.c	Sat Jun 26 17:47:10 2004
@@ -38,6 +38,7 @@
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 #include <asm/sections.h>
+#include <asm/setup.h>
 #include <asm/system.h>
 
 struct cpuinfo_mips cpu_data[NR_CPUS];
@@ -489,7 +490,7 @@
 	do_earlyinitcalls();
 
 	strlcpy(command_line, arcs_cmdline, sizeof(command_line));
-	strlcpy(saved_command_line, command_line, sizeof(saved_command_line));
+	strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
 
 	*cmdline_p = command_line;
 
===== arch/parisc/kernel/setup.c 1.11 vs edited =====
--- 1.11/arch/parisc/kernel/setup.c	Thu Jun 24 09:55:46 2004
+++ edited/arch/parisc/kernel/setup.c	Sat Jun 26 17:36:13 2004
@@ -44,6 +44,7 @@
 #include <asm/machdep.h>	/* for pa7300lc_init() proto */
 #include <asm/pdc_chassis.h>
 #include <asm/io.h>
+#include <asm/setup.h>
 
 char	command_line[COMMAND_LINE_SIZE];
 
===== arch/ppc/kernel/setup.c 1.55 vs edited =====
--- 1.55/arch/ppc/kernel/setup.c	Thu Jun 24 09:55:46 2004
+++ edited/arch/ppc/kernel/setup.c	Sat Jun 26 17:47:10 2004
@@ -676,7 +676,7 @@
 	init_mm.brk = (unsigned long) klimit;
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	strlcpy(saved_command_line, cmd_line, sizeof(saved_command_line));
+	strlcpy(saved_command_line, cmd_line, COMMAND_LINE_SIZE);
 	*cmdline_p = cmd_line;
 
 	/* set up the bootmem stuff with available memory */
===== arch/ppc64/kernel/setup.c 1.59 vs edited =====
--- 1.59/arch/ppc64/kernel/setup.c	Fri May 28 05:02:20 2004
+++ edited/arch/ppc64/kernel/setup.c	Sat Jun 26 17:47:10 2004
@@ -44,6 +44,7 @@
 #include <asm/sections.h>
 #include <asm/btext.h>
 #include <asm/nvram.h>
+#include <asm/setup.h>
 #include <asm/system.h>
 
 extern unsigned long klimit;
@@ -629,7 +630,7 @@
 	init_mm.brk = klimit;
 	
 	/* Save unparsed command line copy for /proc/cmdline */
-	strlcpy(saved_command_line, cmd_line, sizeof(saved_command_line));
+	strlcpy(saved_command_line, cmd_line, COMMAND_LINE_SIZE);
 	*cmdline_p = cmd_line;
 
 	irqstack_early_init();
===== arch/sh/kernel/setup.c 1.19 vs edited =====
--- 1.19/arch/sh/kernel/setup.c	Thu Jun 24 09:56:13 2004
+++ edited/arch/sh/kernel/setup.c	Sat Jun 26 17:36:21 2004
@@ -25,6 +25,7 @@
 #include <asm/io_generic.h>
 #include <asm/sections.h>
 #include <asm/irq.h>
+#include <asm/setup.h>
 
 #ifdef CONFIG_SH_KGDB
 #include <asm/kgdb.h>
===== arch/sparc/kernel/setup.c 1.29 vs edited =====
--- 1.29/arch/sparc/kernel/setup.c	Thu Jun 24 09:55:46 2004
+++ edited/arch/sparc/kernel/setup.c	Sat Jun 26 17:36:31 2004
@@ -47,6 +47,7 @@
 #include <asm/hardirq.h>
 #include <asm/machines.h>
 #include <asm/cpudata.h>
+#include <asm/setup.h>
 
 struct screen_info screen_info = {
 	0, 0,			/* orig-x, orig-y */
===== arch/sparc64/kernel/setup.c 1.53 vs edited =====
--- 1.53/arch/sparc64/kernel/setup.c	Thu Jun 24 09:55:46 2004
+++ edited/arch/sparc64/kernel/setup.c	Sat Jun 26 17:36:40 2004
@@ -47,6 +47,7 @@
 #include <asm/mmu_context.h>
 #include <asm/timer.h>
 #include <asm/sections.h>
+#include <asm/setup.h>
 
 #ifdef CONFIG_IP_PNP
 #include <net/ipconfig.h>
===== arch/v850/kernel/setup.c 1.6 vs edited =====
--- 1.6/arch/v850/kernel/setup.c	Thu Jun 24 09:55:46 2004
+++ edited/arch/v850/kernel/setup.c	Sat Jun 26 17:47:10 2004
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 
 #include <asm/irq.h>
+#include <asm/setup.h>
 
 #include "mach.h"
 
@@ -63,8 +64,8 @@
 {
 	/* Keep a copy of command line */
 	*cmdline = command_line;
-	memcpy (saved_command_line, command_line, sizeof saved_command_line);
-	saved_command_line[sizeof saved_command_line - 1] = '\0';
+	memcpy (saved_command_line, command_line, COMMAND_LINE_SIZE);
+	saved_command_line[COMMAND_LINE_SIZE - 1] = '\0';
 
 	console_verbose ();
 
===== arch/x86_64/kernel/head64.c 1.9 vs edited =====
--- 1.9/arch/x86_64/kernel/head64.c	Thu May 27 17:34:10 2004
+++ edited/arch/x86_64/kernel/head64.c	Sat Jun 26 17:36:55 2004
@@ -16,6 +16,7 @@
 #include <asm/proto.h>
 #include <asm/smp.h>
 #include <asm/bootsetup.h>
+#include <asm/setup.h>
 
 /* Don't add a printk in there. printk relies on the PDA which is not initialized 
    yet. */
===== arch/x86_64/kernel/setup.c 1.43 vs edited =====
--- 1.43/arch/x86_64/kernel/setup.c	Thu Jun 24 09:55:46 2004
+++ edited/arch/x86_64/kernel/setup.c	Sat Jun 26 17:37:03 2004
@@ -55,6 +55,7 @@
 #include <asm/bootsetup.h>
 #include <asm/smp.h>
 #include <asm/proto.h>
+#include <asm/setup.h>
 
 /*
  * Machine setup..
===== include/linux/init.h 1.32 vs edited =====
--- 1.32/include/linux/init.h	Thu Jun 24 09:55:46 2004
+++ edited/include/linux/init.h	Sat Jun 26 12:50:09 2004
@@ -3,7 +3,6 @@
 
 #include <linux/config.h>
 #include <linux/compiler.h>
-#include <asm/setup.h>
 
 /* These macros are used to mark some functions or 
  * initialized data (doesn't apply to uninitialized data)
@@ -69,7 +68,7 @@
 extern initcall_t __security_initcall_start, __security_initcall_end;
 
 /* Defined in init/main.c */
-extern char saved_command_line[COMMAND_LINE_SIZE];
+extern char saved_command_line[];
 #endif
   
 #ifndef MODULE
===== init/main.c 1.148 vs edited =====
--- 1.148/init/main.c	Thu Jun 24 09:55:46 2004
+++ edited/init/main.c	Sat Jun 26 12:51:27 2004
@@ -47,6 +47,7 @@
 
 #include <asm/io.h>
 #include <asm/bugs.h>
+#include <asm/setup.h>
 
 /*
  * This is one of the first .c files built. Error out early

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
