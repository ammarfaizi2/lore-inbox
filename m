Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264604AbUAVRoj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 12:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUAVRoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 12:44:39 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:9175 "EHLO fed1mtao02.cox.net")
	by vger.kernel.org with ESMTP id S264604AbUAVRo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 12:44:28 -0500
Date: Thu, 22 Jan 2004 10:44:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       George Anzinger <george@mvista.com>
Subject: Re: PPC KGDB changes and some help?
Message-ID: <20040122174416.GJ15271@stop.crashing.org>
References: <20040120172708.GN13454@stop.crashing.org> <200401211946.17969.amitkale@emsyssoft.com> <20040121153019.GR13454@stop.crashing.org> <200401212223.13347.amitkale@emsyssoft.com> <20040121184217.GU13454@stop.crashing.org> <20040121192128.GV13454@stop.crashing.org> <20040121192230.GW13454@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040121192230.GW13454@stop.crashing.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 12:22:30PM -0700, Tom Rini wrote:
> On Wed, Jan 21, 2004 at 12:21:28PM -0700, Tom Rini wrote:
> > On Wed, Jan 21, 2004 at 11:42:17AM -0700, Tom Rini wrote:
> > > On Wed, Jan 21, 2004 at 10:23:12PM +0530, Amit S. Kale wrote:
> > > 
> > > > Hi,
> > > > 
> > > > Here it is: ppc kgdb from timesys kernel is available at
> > > > http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.1.0.tar.bz2
> > > > 
> > > > This is my attempt at extracting kgdb from TimeSys kernel. It works well in 
> > > > TimeSys kernel, so blame me if above patch doesn't work.
> > > 
> > > Okay, here's my first patch against this.
> > 
> > And dependant upon this is a patch to fixup the rest of the common PPC
> > code, as follows:
> 
> And on top of all of that is the following, which allows KGDB to work on
> the Motorola LoPEC.

On top of everything from yesterday, here's:

Cleanup ppc-stub.c
 - Lindent
 - Redo boilerplate to match most other PPC files.
 - Rearrange code so that we don't need forward declarations.

 arch/ppc/kernel/ppc-stub.c |  184 ++++++++++++++++++++-------------------------
 1 files changed, 83 insertions(+), 101 deletions(-)
--- 1.13/arch/ppc/kernel/ppc-stub.c	Wed Jan 21 12:21:23 2004
+++ edited/arch/ppc/kernel/ppc-stub.c	Thu Jan 22 10:40:55 2004
@@ -1,20 +1,13 @@
 /*
+ * arch/ppc/kernel/ppc-stub.c
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2, or (at your option) any
- * later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
+ * PowerPC-specific bits to work with the common KGDB stub.
  *
- */
-
-/*
- * Copyright (C) 2003 Timesys Corporation.
- * KGDB for the PowerPC processor
+ * 2003 (c) TimeSys Corporation
+ * 2004 (c) MontaVista Software, Inc.
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
@@ -27,68 +20,56 @@
 #include <asm/machdep.h>
 
 /*
- * Forward prototypes
- */
-static void kgdb_debugger (struct pt_regs *regs);
-static int kgdb_breakpoint (struct pt_regs *regs);
-static int kgdb_singlestep (struct pt_regs *regs);
-static int ppc_kgdb_init (void);
-static void ppc_regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs);
-static void ppc_sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p);
-static void ppc_gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs);
-void ppc_handler_exit (void);
-static int ppc_handle_exception (int            vector,
-                           int            signo,
-                           int            err_code,
-                           char           *remcomInBuffer,
-                           char           *remcomOutBuffer,
-                           struct pt_regs *linux_regs);
-
-/*
  * Routines
  */
-static void kgdb_debugger (struct pt_regs *regs)
+static void
+kgdb_debugger(struct pt_regs *regs)
 {
 	(*linux_debug_hook) (0, 0, 0, regs);
 	return;
 }
 
-static int kgdb_breakpoint (struct pt_regs *regs)
+static int
+kgdb_breakpoint(struct pt_regs *regs)
 {
 	extern atomic_t kgdb_setting_breakpoint;
 
 	(*linux_debug_hook) (0, SIGTRAP, 0, regs);
 
-	if (atomic_read (&kgdb_setting_breakpoint))
+	if (atomic_read(&kgdb_setting_breakpoint))
 		regs->nip += 4;
 
 	return 1;
 }
 
-static int kgdb_singlestep (struct pt_regs *regs)
+static int
+kgdb_singlestep(struct pt_regs *regs)
 {
 	(*linux_debug_hook) (0, SIGTRAP, 0, regs);
 	return 1;
 }
 
-int kgdb_iabr_match(struct pt_regs *regs)
+int
+kgdb_iabr_match(struct pt_regs *regs)
 {
 	(*linux_debug_hook) (0, 0, 0, regs);
 	return 1;
 }
 
-int kgdb_dabr_match(struct pt_regs *regs)
+int
+kgdb_dabr_match(struct pt_regs *regs)
 {
 	(*linux_debug_hook) (0, 0, 0, regs);
 	return 1;
 }
 
-static void ppc_regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+static void
+ppc_regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 {
 	int reg;
 	unsigned long *ptr = gdb_regs;
 
-	memset(gdb_regs, 0, MAXREG*4);
+	memset(gdb_regs, 0, MAXREG * 4);
 
 	for (reg = 0; reg < 32; reg++)
 		*(ptr++) = regs->gpr[reg];
@@ -104,16 +85,17 @@
 	*(ptr++) = regs->xer;
 
 	return;
-}	/* regs_to_gdb_regs */
+}				/* regs_to_gdb_regs */
 
-static void ppc_sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
+static void
+ppc_sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
 {
 	struct pt_regs *regs = (struct pt_regs *) (p->thread.ksp +
-	                                           STACK_FRAME_OVERHEAD);
+						   STACK_FRAME_OVERHEAD);
 	int reg;
 	unsigned long *ptr = gdb_regs;
 
-	memset(gdb_regs, 0, MAXREG*4);
+	memset(gdb_regs, 0, MAXREG * 4);
 
 	/* Regs GPR0-2 */
 	for (reg = 0; reg < 3; reg++)
@@ -140,7 +122,8 @@
 	return;
 }
 
-static void ppc_gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+static void
+ppc_gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 {
 	int reg;
 	unsigned long *ptr = gdb_regs;
@@ -159,96 +142,81 @@
 	regs->xer = *(ptr++);
 
 	return;
-}	/* gdb_regs_to_regs */
-
+}				/* gdb_regs_to_regs */
 
 /* exit_handler:
  * 
  * This is called by the generic layer when it is about to return from 
  * the exception handler
  */
-void ppc_handler_exit (void)
+void
+ppc_handler_exit(void)
 {
-//	flush_instruction_cache ();
+//      flush_instruction_cache ();
 	return;
 }
 
-
 /*
  * This function does PoerPC specific procesing for interfacing to gdb.
  */
-static int ppc_handle_exception (int            vector,
-                          int            signo,
-                          int            err_code,
-                          char           *remcomInBuffer,
-                          char           *remcomOutBuffer,
-                          struct pt_regs *linux_regs)
+static int
+ppc_handle_exception(int vector,
+		     int signo,
+		     int err_code,
+		     char *remcomInBuffer,
+		     char *remcomOutBuffer, struct pt_regs *linux_regs)
 {
 	char *ptr;
 	unsigned long addr;
-	
-	switch (remcomInBuffer[0])
-		{
+
+	switch (remcomInBuffer[0]) {
 		/*
 		 * sAA..AA   Step one instruction from AA..AA 
 		 * This will return an error to gdb ..
 		 */
-		case 's':
-		case 'c':
-			if (kgdb_contthread && kgdb_contthread != current)
-			{
-				strcpy(remcomOutBuffer, "E00");
-				break;
-			}
-
-			kgdb_contthread = NULL;
-
-			/* handle the optional parameter */
-			ptr = &remcomInBuffer[1];
-			if (kgdb_hexToLong (&ptr, &addr))
-				linux_regs->nip = addr;
-
-			/* set the trace bit if we're stepping */
-			if (remcomInBuffer[0] == 's')
-			{
+	case 's':
+	case 'c':
+		if (kgdb_contthread && kgdb_contthread != current) {
+			strcpy(remcomOutBuffer, "E00");
+			break;
+		}
+
+		kgdb_contthread = NULL;
+
+		/* handle the optional parameter */
+		ptr = &remcomInBuffer[1];
+		if (kgdb_hexToLong(&ptr, &addr))
+			linux_regs->nip = addr;
+
+		/* set the trace bit if we're stepping */
+		if (remcomInBuffer[0] == 's') {
 #if defined (CONFIG_4xx)
-				linux_regs->msr |= MSR_DE;
-				current->thread.dbcr0 |= (DBCR_IDM | DBCR_IC);
+			linux_regs->msr |= MSR_DE;
+			current->thread.dbcr0 |= (DBCR_IDM | DBCR_IC);
 #else
-				linux_regs->msr |= MSR_SE;
+			linux_regs->msr |= MSR_SE;
 #endif
-			}
-			return 0;
+		}
+		return 0;
 	}
 
 	return -1;
 }
 
-/*
- * Global data
- */
-struct kgdb_arch arch_kgdb_ops =
-{
-	.gdb_bpt_instr = { 0x7d, 0x82, 0x10, 0x08 },
-	.kgdb_init = ppc_kgdb_init,
-	.regs_to_gdb_regs = ppc_regs_to_gdb_regs,
-	.sleeping_thread_to_gdb_regs = ppc_sleeping_thread_to_gdb_regs,
-	.gdb_regs_to_regs = ppc_gdb_regs_to_regs,
-	.handle_exception = ppc_handle_exception,
-	.handler_exit = ppc_handler_exit,
-};
-
-static void kgdbppc_write_char(int chr)
+static void
+kgdbppc_write_char(int chr)
 {
 	putDebugChar(chr);
 }
 
-static int kgdbppc_read_char(void)
+static int
+kgdbppc_read_char(void)
 {
 	return getDebugChar();
 }
 
-static int kgdbppc_hook(void)
+static int
+kgdbppc_hook(void)
 {
 	if (ppc_md.kgdb_map_scc)
 		ppc_md.kgdb_map_scc();
@@ -261,7 +229,8 @@
 	.hook = kgdbppc_hook
 };
 
-static int ppc_kgdb_init (void)
+static int
+ppc_kgdb_init(void)
 {
 	debugger = kgdb_debugger;
 	debugger_bpt = kgdb_breakpoint;
@@ -272,5 +241,18 @@
 	kgdb_serial = &kgdbppc_serial;
 
 	return 0;
-	
+
 }
+
+/*
+ * Global data
+ */
+struct kgdb_arch arch_kgdb_ops = {
+	.gdb_bpt_instr = {0x7d, 0x82, 0x10, 0x08},
+	.kgdb_init = ppc_kgdb_init,
+	.regs_to_gdb_regs = ppc_regs_to_gdb_regs,
+	.sleeping_thread_to_gdb_regs = ppc_sleeping_thread_to_gdb_regs,
+	.gdb_regs_to_regs = ppc_gdb_regs_to_regs,
+	.handle_exception = ppc_handle_exception,
+	.handler_exit = ppc_handler_exit,
+};

I'll have some functional changes that apply on top of this soon.

-- 
Tom Rini
http://gate.crashing.org/~trini/
