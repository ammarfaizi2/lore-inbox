Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266099AbUAUTVv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 14:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266101AbUAUTVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 14:21:51 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:4837 "EHLO fed1mtao08.cox.net")
	by vger.kernel.org with ESMTP id S266099AbUAUTVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 14:21:30 -0500
Date: Wed, 21 Jan 2004 12:21:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       George Anzinger <george@mvista.com>
Subject: Re: PPC KGDB changes and some help?
Message-ID: <20040121192128.GV13454@stop.crashing.org>
References: <20040120172708.GN13454@stop.crashing.org> <200401211946.17969.amitkale@emsyssoft.com> <20040121153019.GR13454@stop.crashing.org> <200401212223.13347.amitkale@emsyssoft.com> <20040121184217.GU13454@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040121184217.GU13454@stop.crashing.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 11:42:17AM -0700, Tom Rini wrote:
> On Wed, Jan 21, 2004 at 10:23:12PM +0530, Amit S. Kale wrote:
> 
> > Hi,
> > 
> > Here it is: ppc kgdb from timesys kernel is available at
> > http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.1.0.tar.bz2
> > 
> > This is my attempt at extracting kgdb from TimeSys kernel. It works well in 
> > TimeSys kernel, so blame me if above patch doesn't work.
> 
> Okay, here's my first patch against this.

And dependant upon this is a patch to fixup the rest of the common PPC
code, as follows:
- Add FRAME_POINTER
- Put the bits of kgdbppc_init into ppc_kgdb_init.
- None of the gen550 stuffs depend on CONFIG_8250_SERIAL directly,
  remove that constraint.
- Add missing bits like debuggerinfo, BREAKPOINT, etc.
- Add a kgdb_map_scc machdep pointer.

--- 1.48/arch/ppc/Kconfig	Wed Jan 21 10:13:13 2004
+++ edited/arch/ppc/Kconfig	Wed Jan 21 12:18:32 2004
@@ -1405,6 +1405,14 @@
 	  Say Y here only if you plan to use some sort of debugger to
 	  debug the kernel.
 	  If you don't debug the kernel, you can say N.
+
+config FRAME_POINTER
+	bool "Compile the kernel with frame pointers"
+	help
+	  If you say Y here the resulting kernel image will be slightly larger
+	  and slower, but it will give very useful debugging information.
+	  If you don't debug the kernel, you can say N, but we may not be able
+	  to solve problems without frame pointers.
 
 config BOOTX_TEXT
 	bool "Support for early boot text console (BootX or OpenFirmware only)"
--- 1.12/arch/ppc/kernel/ppc-stub.c	Wed Jan 21 10:13:13 2004
+++ edited/arch/ppc/kernel/ppc-stub.c	Wed Jan 21 12:17:34 2004
@@ -20,9 +20,11 @@
 #include <linux/kernel.h>
 #include <linux/config.h>
 #include <linux/kgdb.h>
+
 #include <asm/current.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
+#include <asm/machdep.h>
 
 /*
  * Forward prototypes
@@ -81,18 +83,6 @@
 	return 1;
 }
 
-static int ppc_kgdb_init (void)
-{
-	debugger = kgdb_debugger;
-	debugger_bpt = kgdb_breakpoint;
-	debugger_sstep = kgdb_singlestep;
-	debugger_iabr_match = kgdb_iabr_match;
-	debugger_dabr_match = kgdb_dabr_match;
-
-	return 0;
-	
-}
-
 static void ppc_regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 {
 	int reg;
@@ -258,9 +248,10 @@
 	return getDebugChar();
 }
 
-int     kgdbppc_hook(void)
+static int kgdbppc_hook(void)
 {
-	kgdb_map_scc();
+	if (ppc_md.kgdb_map_scc)
+		ppc_md.kgdb_map_scc();
 	return 0;
 }
 
@@ -270,7 +261,16 @@
 	.hook = kgdbppc_hook
 };
 
-void kgdbppc_init(void)
+static int ppc_kgdb_init (void)
 {
+	debugger = kgdb_debugger;
+	debugger_bpt = kgdb_breakpoint;
+	debugger_sstep = kgdb_singlestep;
+	debugger_iabr_match = kgdb_iabr_match;
+	debugger_dabr_match = kgdb_dabr_match;
+
 	kgdb_serial = &kgdbppc_serial;
+
+	return 0;
+	
 }
--- 1.50/arch/ppc/kernel/setup.c	Wed Jan 21 10:13:13 2004
+++ edited/arch/ppc/kernel/setup.c	Wed Jan 21 12:17:34 2004
@@ -37,10 +37,6 @@
 #include <asm/sections.h>
 #include <asm/xmon.h>
 
-#if defined CONFIG_KGDB
-#include <asm/kgdb.h>
-#endif
-
 extern void platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7);
 extern void bootx_init(unsigned long r4, unsigned long phys);
@@ -48,11 +44,6 @@
 extern void do_cpu_ftr_fixups(unsigned long offset);
 extern void reloc_got2(unsigned long offset);
 
-
-#ifdef CONFIG_KGDB
-extern void kgdb_map_scc(void);
-#endif
-
 extern void ppc6xx_idle(void);
 extern void power4_idle(void);
 
@@ -631,10 +622,6 @@
 #endif /* CONFIG_XMON */
 	if ( ppc_md.progress ) ppc_md.progress("setup_arch: enter", 0x3eab);
 
-#if defined(CONFIG_KGDB)
-	kgdbppc_init();
-#endif
-
 	/*
 	 * Set cache line size based on type of cpu as a default.
 	 * Systems with OF can look in the properties on the cpu node(s)
--- 1.10/arch/ppc/syslib/Makefile	Wed Sep  3 05:16:34 2003
+++ edited/arch/ppc/syslib/Makefile	Wed Jan 21 12:17:34 2004
@@ -66,7 +66,7 @@
 obj-$(CONFIG_SPRUCE)		+= cpc700_pic.o indirect_pci.o pci_auto.o \
 				   todc_time.o
 obj-$(CONFIG_8260)		+= m8260_setup.o ppc8260_pic.o
-ifeq ($(CONFIG_SERIAL_8250)$(CONFIG_PPC_GEN550),yy)
+ifeq ($(CONFIG_PPC_GEN550),y)
 obj-$(CONFIG_KGDB)		+= gen550_kgdb.o gen550_dbg.o
 obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= gen550_dbg.o
 endif
--- 1.1/arch/ppc/syslib/gen550_dbg.c	Tue Jul  1 08:34:08 2003
+++ edited/arch/ppc/syslib/gen550_dbg.c	Wed Jan 21 12:17:34 2004
@@ -17,6 +17,8 @@
  */
 
 #include <linux/config.h>
+#include <linux/types.h>
+#include <linux/serial.h>
 #include <linux/tty.h>		/* For linux/serial_core.h */
 #include <linux/serial_core.h>
 #include <linux/serialP.h>
--- 1.2/arch/ppc/syslib/gen550_kgdb.c	Fri Sep 12 09:26:55 2003
+++ edited/arch/ppc/syslib/gen550_kgdb.c	Wed Jan 21 12:17:34 2004
@@ -74,10 +74,10 @@
 
 /*
  * Note: gen550_init() must be called already on the port we are going
- * to use.
+ * to use, or <asm/serial.h> must provide static definitions.
  */
 void
-kgdb_map_scc(void)
+gen550_kgdb_map_scc(void)
 {
 	printk(KERN_DEBUG "kgdb init\n");
 	kgdb_debugport = serial_init(KGDB_PORT, NULL);
--- 1.4/include/asm-ppc/kgdb.h	Sun Sep 15 21:52:04 2002
+++ edited/include/asm-ppc/kgdb.h	Wed Jan 21 12:17:34 2004
@@ -2,6 +2,8 @@
  * kgdb.h: Defines and declarations for serial line source level
  *         remote debugging of the Linux kernel using gdb.
  *
+ * PPC Mods (C) 2004 Tom Rini (trini@mvista.com)
+ * PPC Mods (C) 2003 John Whitney (john.whitney@timesys.com)
  * PPC Mods (C) 1998 Michael Tesch (tesch@cs.wisc.edu)
  *
  * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
@@ -11,10 +13,23 @@
 #define _PPC_KGDB_H
 
 #ifndef __ASSEMBLY__
-/* To initialize the serial, first thing called */
+
+#define BREAK_INSTR_SIZE	4
+#define MAXREG			(PT_FPSCR+1)
+#define NUMREGBYTES		(MAXREG * sizeof(int))
+#define BUFMAX			((NUMREGBYTES * 2) + 512)
+#define OUTBUFMAX		((NUMREGBYTES * 2) + 512)
+#define BREAKPOINT()		asm(".long 0x7d821008") /* twge r2, r2 */
+
+/* Things specific to the gen550 backend. */
+struct uart_port;
+
+extern void gen550_progress(char *, unsigned short);
+extern void gen550_kgdb_map_scc(void);
+extern void gen550_init(int, struct uart_port *);
+
+/* Things specific to the pmac backend. */
 extern void zs_kgdb_hook(int tty_num);
-/* To init the kgdb engine. (called by serial hook)*/
-extern void set_debug_traps(void);
 
 /* To enter the debugger explicitly. */
 extern void breakpoint(void);
--- 1.16/include/asm-ppc/machdep.h	Wed Apr 23 00:49:34 2003
+++ edited/include/asm-ppc/machdep.h	Wed Jan 21 12:17:34 2004
@@ -53,6 +53,7 @@
 	void		(*setup_io_mappings)(void);
 
   	void		(*progress)(char *, unsigned short);
+	void		(*kgdb_map_scc)(void);
 
 	unsigned char 	(*nvram_read_val)(int addr);
 	void		(*nvram_write_val)(int addr, unsigned char val);
--- 1.39/include/asm-ppc/processor.h	Fri Sep 26 16:31:59 2003
+++ edited/include/asm-ppc/processor.h	Wed Jan 21 12:17:34 2004
@@ -119,6 +119,9 @@
 	unsigned long	vrsave;
 	int		used_vr;	/* set if process has used altivec */
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_KGDB
+	void		*debuggerinfo;
+#endif
 };
 
 #define INIT_SP		(sizeof(init_stack) + (unsigned long) &init_stack)

-- 
Tom Rini
http://gate.crashing.org/~trini/
