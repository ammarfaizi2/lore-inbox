Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbUCYPOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 10:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263193AbUCYPOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 10:14:49 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:15279 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S263191AbUCYPOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 10:14:45 -0500
Date: Thu, 25 Mar 2004 08:14:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Kgdb-bugreport] Document hooks in kgdb
Message-ID: <20040325151444.GC13366@smtp.west.cox.net>
References: <20040319162009.GE4569@smtp.west.cox.net> <200403242011.26314.amitkale@emsyssoft.com> <20040324154355.GD7126@smtp.west.cox.net> <200403251022.39704.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403251022.39704.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 10:22:39AM +0530, Amit S. Kale wrote:
> On Wednesday 24 Mar 2004 9:13 pm, Tom Rini wrote:
> > On Wed, Mar 24, 2004 at 08:11:26PM +0530, Amit S. Kale wrote:
> > > That's a good idea. Go ahead.
> > > -Amit
> > >
> > > On Friday 19 Mar 2004 9:50 pm, Tom Rini wrote:
> > > > Hi.  The following is my first attempt at documenting the hooks found
> > > > in the KGDB found on kgdb.sf.net.  I'm not quite sure about the
> > > > description of some of the optional hooks (used under hw breakpoints)
> > > > so corrections / suggestions welcome.  After I got done with it, it hit
> > > > me that maybe I should have done this in the code, and in DocBook
> > > > format, so I'll go and do that next...
> > > >
> > > > <-- snip -->
> > > > This is an attempt to document the various architecture specific
> > > > functions that are part of KGDB.  There are a number of optional
> > > > functions, depending on hardware setps, for which empty defaults are
> > > > provided.  There are also functions which must be implemented and for
> > > > which no default is provided.
> > > >
> > > > The required functions are:
> > > > int kgdb_arch_handle_exception(int vector, int signo, int err_code,
> > > > 		char *InBuffer, char *outBuffer, struct pt_regs *regs)
> > > > 	This function MUST handle the 'c' and 's' command packets,
> > > > 	as well packets to set / remove a hardware breakpoint, if used.
> > > >
> > > > void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
> > > > 	Convert the ptrace regs in regs into what GDB expects to
> > > > 	see for registers, in gdb_regs.
> > > >
> > > > void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct
> > > > task_struct *p) Like regs_to_gdb_regs, except that the process in p is
> > > > sleeping,
> > > > 	so we cannot get as much information.
> > > >
> > > > void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
> > > > 	Convert the GDB regs in gdb_regs into the ptrace regs pointed
> > > > 	to in regs.
> > > >
> > > > The optional functions are:
> > > > int kgdb_arch_init(void) :
> > > > 	This function will handle the initalization of any architecture
> > > > 	specific hooks.  If there is a suitable early output driver,
> > > > 	kgdb_serial can be pointed at it now.
> > > >
> > > > void kgdb_printexceptioninfo(int exceptionNo, int errorcode, char
> > > > *buffer) Write into buffer and information about the exception that has
> > > > occured that can be gleaned from exceptionNo and errorcode.
> > > >
> > > > void kgdb_disable_hw_debug(struct pt_regs *regs)
> > > > 	Disable hardware debugging while we are in kgdb.
> > > >
> > > > void kgdb_correct_hw_break(void)
> > > > 	A hook to allow for changes to the hardware breakpoint, called
> > > > 	after a single step (s) or continue (c) packet, and once we're about
> > > > 	to let the kernel continue running.
> > > >
> > > > void kgdb_post_master_code(struct pt_regs *regs, int eVector, int
> > > > err_code) Store the raw vector and error, for later retreival.
> > > >
> > > > void kgdb_shadowinfo(struct pt_regs *regs, char *buffer, unsigned
> > > > threadid) struct task_struct *kgdb_get_shadow_thread(struct pt_regs
> > > > *regs, int threadid) struct pt_regs *kgdb_shadow_regs(struct pt_regs
> > > > *regs, int threadid) If we have a shadow thread (determined by setting
> > > > 	kgdb_ops->shadowth = 1), these functions are required to return
> > > > 	information about this thread.
> > >
> > > An addition: shadow threads are needed to provide information not
> > > retrievable by gdb. e.g. Backtraces beyond interrupt entrypoints, that
> > > aren't retrievable in absence of debugging info for interrupt entrypoint
> > > code.
> >
> > If I follow everything right, this could go in favor of cfi macros,
> > right ?
> 
> Yes. Shadow threads won't be required with CFI macros.
> 
> I believe they are not required with x86_64. I have to verify this.

x86_64 is currently the only arch implementing this.

> How about keeping the shadow thread framework in place even after we get 
> x86_64, x86 and ppc CFI macros. That'll help when we have other architectures 
> coming in.

We should probably drop the shadow stuff altogether, and get the CFI
stuff done right, first on x86_64.  Especially given how vocal the arch
maintainer has been on this issue.

-- 
Tom Rini
http://gate.crashing.org/~trini/
