Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265299AbUAZUqs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 15:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265338AbUAZUqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 15:46:48 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:38099 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S265299AbUAZUqm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 15:46:42 -0500
Date: Mon, 26 Jan 2004 13:46:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: PPC KGDB changes and some help?
Message-ID: <20040126204631.GB32525@stop.crashing.org>
References: <200401211946.17969.amitkale@emsyssoft.com> <20040121153019.GR13454@stop.crashing.org> <200401212223.13347.amitkale@emsyssoft.com> <20040121184217.GU13454@stop.crashing.org> <20040121192128.GV13454@stop.crashing.org> <20040121192230.GW13454@stop.crashing.org> <20040122174416.GJ15271@stop.crashing.org> <20040122180555.GK15271@stop.crashing.org> <20040123224605.GC15271@stop.crashing.org> <4011B07F.5060409@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4011B07F.5060409@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 03:38:39PM -0800, George Anzinger wrote:
> Tom Rini wrote:
> >On Thu, Jan 22, 2004 at 11:05:55AM -0700, Tom Rini wrote:
> >[snip]
> >
> >>First up:
> >>We need to call flush_instruction_cache() on a 'c' or 's' command.
> >>arch/ppc/kernel/ppc-stub.c |   19 ++++++-------------
> >>1 files changed, 6 insertions(+), 13 deletions(-)
> >
> >
> >On tpo of this patch, there's the following:
> >Put back some code to figure out what signal we're dealing with.
> >
> > arch/ppc/kernel/ppc-stub.c |   63 
> > ++++++++++++++++++++++++++++++++++++++++++---
> > 1 files changed, 60 insertions(+), 3 deletions(-)
> >--- 1.15/arch/ppc/kernel/ppc-stub.c	Thu Jan 22 10:53:06 2004
> >+++ edited/arch/ppc/kernel/ppc-stub.c	Fri Jan 23 15:43:10 2004
> >@@ -3,6 +3,7 @@
> >  *
> >  * PowerPC-specific bits to work with the common KGDB stub.
> >  *
> >+ * 1998 (c) Michael AK Tesch (tesch@cs.wisc.edu)
> >  * 2003 (c) TimeSys Corporation
> >  * 2004 (c) MontaVista Software, Inc.
> >  * This file is licensed under the terms of the GNU General Public License
> >@@ -19,13 +20,69 @@
> > #include <asm/processor.h>
> > #include <asm/machdep.h>
> > 
> >+/* Convert the hardware trap type code to a unix signal number. */
> >+/*
> >+ * This table contains the mapping between PowerPC hardware trap types, 
> >and
> >+ * signals, which are primarily what GDB understands.
> >+ */
> >+static struct hard_trap_info
> >+{
> >+	unsigned int tt;		/* Trap type code for powerpc */
> >+	unsigned char signo;		/* Signal that we map this trap into 
> >*/
> >+} hard_trap_info[] = {
> >+#if defined(CONFIG_40x)
> >+	{ 0x100, SIGINT  },		/* critical input interrupt */
> >+	{ 0x200, SIGSEGV },		/* machine check */
> >+	{ 0x300, SIGSEGV },		/* data storage */
> >+	{ 0x400, SIGBUS  },		/* instruction storage */
> >+	{ 0x500, SIGINT  },		/* interrupt */
> >+	{ 0x600, SIGBUS  },		/* alignment */
> >+	{ 0x700, SIGILL  },		/* program */
> >+	{ 0x800, SIGILL  },		/* reserved */
> >+	{ 0x900, SIGILL  },		/* reserved */
> >+	{ 0xa00, SIGILL  },		/* reserved */
> >+	{ 0xb00, SIGILL  },		/* reserved */
> >+	{ 0xc00, SIGCHLD },		/* syscall */
> >+	{ 0xd00, SIGILL  },		/* reserved */
> >+	{ 0xe00, SIGILL  },		/* reserved */
> >+	{ 0xf00, SIGILL  },		/* reserved */
> >+	{ 0x2000, SIGTRAP},		/* debug */
> >+#else
> >+	{ 0x200, SIGSEGV },		/* machine check */
> >+	{ 0x300, SIGSEGV },		/* address error (store) */
> >+	{ 0x400, SIGBUS },		/* instruction bus error */
> >+	{ 0x500, SIGINT },		/* interrupt */
> >+	{ 0x600, SIGBUS },		/* alingment */
> >+	{ 0x700, SIGTRAP },		/* breakpoint trap */
> >+	{ 0x800, SIGFPE },		/* fpu unavail */
> >+	{ 0x900, SIGALRM },		/* decrementer */
> >+	{ 0xa00, SIGILL },		/* reserved */
> >+	{ 0xb00, SIGILL },		/* reserved */
> >+	{ 0xc00, SIGCHLD },		/* syscall */
> >+	{ 0xd00, SIGTRAP },		/* single-step/watch */
> >+	{ 0xe00, SIGFPE },		/* fp assist */
> >+#endif
> >+	{ 0, 0}				/* Must be last */
> >+};
> >+
> >+static int computeSignal(unsigned int tt)
> >+{
> >+	struct hard_trap_info *ht;
> >+
> >+	for (ht = hard_trap_info; ht->tt && ht->signo; ht++)
> >+		if (ht->tt == tt)
> >+			return ht->signo;
> >+
> >+	return SIGHUP; /* default for things we don't know about */
> >+}
> >+
> > /*
> >  * Routines
> >  */
> > static void
> > kgdb_debugger(struct pt_regs *regs)
> > {
> >-	(*linux_debug_hook) (0, 0, 0, regs);
> >+	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
> > 	return;
> > }
> > 
> >@@ -52,14 +109,14 @@
> > int
> > kgdb_iabr_match(struct pt_regs *regs)
> > {
> >-	(*linux_debug_hook) (0, 0, 0, regs);
> >+	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
> > 	return 1;
> > }
> > 
> > int
> > kgdb_dabr_match(struct pt_regs *regs)
> > {
> >-	(*linux_debug_hook) (0, 0, 0, regs);
> >+	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
> > 	return 1;
> > }
> > 
> >
> >Now, not being as well versed in all of the debugging infos that can be
> >passed around, it sounds like this patch could be dropped in the future
> >for a cleaner method using some of the dwarf2 bits being talked about.
> >But I don't know, and clarification and pointers (if so) to how to do
> >this would be appreciated.
> 
> I am not sure what this buys you.  I don't think dwarf2 will help here.

OK.

> There is a real danger of passing signal info back to gdb as it will want 
> to try to deliver the signal which is a non-compute in most kgdbs in the 
> field.  I did put code in the mm-kgdb to do just this, but usually the 
> arrival of such a signal (other than SIGTRAP) is the end of the kernel.  
> All that is left is to read the tea leaves.

The gdb I've been testing this with knows better than to try and send a
singal back, so that's not a worry.  The motivation behind doing this
however is along the lines of "if it ain't broke, don't remove it".  The
original stub was getting all of this information correctly, so why stop
doing it?

-- 
Tom Rini
http://gate.crashing.org/~trini/
