Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbUA0SWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUA0SWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:22:48 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:16374 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S264887AbUA0SWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:22:43 -0500
Date: Tue, 27 Jan 2004 11:22:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       George Anzinger <george@mvista.com>
Subject: Re: PPC KGDB changes and some help?
Message-ID: <20040127182242.GH32525@stop.crashing.org>
References: <20040120172708.GN13454@stop.crashing.org> <200401211946.17969.amitkale@emsyssoft.com> <20040121153019.GR13454@stop.crashing.org> <200401212223.13347.amitkale@emsyssoft.com> <20040121184217.GU13454@stop.crashing.org> <20040121192128.GV13454@stop.crashing.org> <20040121192230.GW13454@stop.crashing.org> <20040122174416.GJ15271@stop.crashing.org> <20040122180555.GK15271@stop.crashing.org> <20040123224605.GC15271@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123224605.GC15271@stop.crashing.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 03:46:05PM -0700, Tom Rini wrote:

> On Thu, Jan 22, 2004 at 11:05:55AM -0700, Tom Rini wrote:
> [snip]
> > First up:
> > We need to call flush_instruction_cache() on a 'c' or 's' command.
> >  arch/ppc/kernel/ppc-stub.c |   19 ++++++-------------
> >  1 files changed, 6 insertions(+), 13 deletions(-)
> 
> On tpo of this patch, there's the following:
> Put back some code to figure out what signal we're dealing with.

And here's a version that with some help from Daniel always passes the
correct information back to GDB (the original code did not).

 arch/ppc/kernel/ppc-stub.c |   63 ++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 60 insertions(+), 3 deletions(-)
--- 1.15/arch/ppc/kernel/ppc-stub.c	Thu Jan 22 10:53:06 2004
+++ edited/arch/ppc/kernel/ppc-stub.c	Tue Jan 27 11:08:25 2004
@@ -3,6 +3,7 @@
  *
  * PowerPC-specific bits to work with the common KGDB stub.
  *
+ * 1998 (c) Michael AK Tesch (tesch@cs.wisc.edu)
  * 2003 (c) TimeSys Corporation
  * 2004 (c) MontaVista Software, Inc.
  * This file is licensed under the terms of the GNU General Public License
@@ -19,13 +20,69 @@
 #include <asm/processor.h>
 #include <asm/machdep.h>
 
+/* Convert the hardware trap type code to a unix signal number. */
+/*
+ * This table contains the mapping between PowerPC hardware trap types, and
+ * signals, which are primarily what GDB understands.
+ */
+static struct hard_trap_info
+{
+	unsigned int tt;		/* Trap type code for powerpc */
+	unsigned char signo;		/* Signal that we map this trap into */
+} hard_trap_info[] = {
+#if defined(CONFIG_40x)
+	{ 0x0100, 0x02 /* SIGINT */  },		/* critical input interrupt */
+	{ 0x0200, 0x0b /* SIGSEGV */ },		/* machine check */
+	{ 0x0300, 0x0b /* SIGSEGV */ },		/* data storage */
+	{ 0x0400, 0x0a /* SIGBUS */  },		/* instruction storage */
+	{ 0x0500, 0x02 /* SIGINT */  },		/* interrupt */
+	{ 0x0600, 0x0a /* SIGBUS */  },		/* alignment */
+	{ 0x0700, 0x04 /* SIGILL */  },		/* program */
+	{ 0x0800, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0900, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0a00, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0b00, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0c00, 0x14 /* SIGCHLD */ },		/* syscall */
+	{ 0x0d00, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0e00, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0f00, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x2000, 0x05 /* SIGTRAP */},		/* debug */
+#else
+	{ 0x0200, 0x0b /* SIGSEGV */ },		/* machine check */
+	{ 0x0300, 0x0b /* SIGSEGV */ },		/* address error (store) */
+	{ 0x0400, 0x0a /* SIGBUS */ },		/* instruction bus error */
+	{ 0x0500, 0x02 /* SIGINT */ },		/* interrupt */
+	{ 0x0600, 0x0a /* SIGBUS */ },		/* alingment */
+	{ 0x0700, 0x05 /* SIGTRAP */ },		/* breakpoint trap */
+	{ 0x0800, 0x08 /* SIGFPE */},		/* fpu unavail */
+	{ 0x0900, 0x0e /* SIGALRM */ },		/* decrementer */
+	{ 0x0a00, 0x04 /* SIGILL */ },		/* reserved */
+	{ 0x0b00, 0x04 /* SIGILL */ },		/* reserved */
+	{ 0x0c00, 0x14 /* SIGCHLD */ },		/* syscall */
+	{ 0x0d00, 0x05 /* SIGTRAP */ },		/* single-step/watch */
+	{ 0x0e00, 0x08 /* SIGFPE */ },		/* fp assist */
+#endif
+	{ 0x0000, 0x000 }			/* Must be last */
+};
+
+static int computeSignal(unsigned int tt)
+{
+	struct hard_trap_info *ht;
+
+	for (ht = hard_trap_info; ht->tt && ht->signo; ht++)
+		if (ht->tt == tt)
+			return ht->signo;
+
+	return SIGHUP; /* default for things we don't know about */
+}
+
 /*
  * Routines
  */
 static void
 kgdb_debugger(struct pt_regs *regs)
 {
-	(*linux_debug_hook) (0, 0, 0, regs);
+	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
 	return;
 }
 
@@ -52,14 +109,14 @@
 int
 kgdb_iabr_match(struct pt_regs *regs)
 {
-	(*linux_debug_hook) (0, 0, 0, regs);
+	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
 	return 1;
 }
 
 int
 kgdb_dabr_match(struct pt_regs *regs)
 {
-	(*linux_debug_hook) (0, 0, 0, regs);
+	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
 	return 1;
 }
 

-- 
Tom Rini
http://gate.crashing.org/~trini/
