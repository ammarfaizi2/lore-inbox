Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263153AbUCYE4r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 23:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUCYE4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 23:56:47 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:44764 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S263153AbUCYE4n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 23:56:43 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [Kgdb-bugreport] Document hooks in kgdb
Date: Thu, 25 Mar 2004 10:22:39 +0530
User-Agent: KMail/1.5
Cc: kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040319162009.GE4569@smtp.west.cox.net> <200403242011.26314.amitkale@emsyssoft.com> <20040324154355.GD7126@smtp.west.cox.net>
In-Reply-To: <20040324154355.GD7126@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403251022.39704.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 Mar 2004 9:13 pm, Tom Rini wrote:
> On Wed, Mar 24, 2004 at 08:11:26PM +0530, Amit S. Kale wrote:
> > That's a good idea. Go ahead.
> > -Amit
> >
> > On Friday 19 Mar 2004 9:50 pm, Tom Rini wrote:
> > > Hi.  The following is my first attempt at documenting the hooks found
> > > in the KGDB found on kgdb.sf.net.  I'm not quite sure about the
> > > description of some of the optional hooks (used under hw breakpoints)
> > > so corrections / suggestions welcome.  After I got done with it, it hit
> > > me that maybe I should have done this in the code, and in DocBook
> > > format, so I'll go and do that next...
> > >
> > > <-- snip -->
> > > This is an attempt to document the various architecture specific
> > > functions that are part of KGDB.  There are a number of optional
> > > functions, depending on hardware setps, for which empty defaults are
> > > provided.  There are also functions which must be implemented and for
> > > which no default is provided.
> > >
> > > The required functions are:
> > > int kgdb_arch_handle_exception(int vector, int signo, int err_code,
> > > 		char *InBuffer, char *outBuffer, struct pt_regs *regs)
> > > 	This function MUST handle the 'c' and 's' command packets,
> > > 	as well packets to set / remove a hardware breakpoint, if used.
> > >
> > > void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
> > > 	Convert the ptrace regs in regs into what GDB expects to
> > > 	see for registers, in gdb_regs.
> > >
> > > void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct
> > > task_struct *p) Like regs_to_gdb_regs, except that the process in p is
> > > sleeping,
> > > 	so we cannot get as much information.
> > >
> > > void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
> > > 	Convert the GDB regs in gdb_regs into the ptrace regs pointed
> > > 	to in regs.
> > >
> > > The optional functions are:
> > > int kgdb_arch_init(void) :
> > > 	This function will handle the initalization of any architecture
> > > 	specific hooks.  If there is a suitable early output driver,
> > > 	kgdb_serial can be pointed at it now.
> > >
> > > void kgdb_printexceptioninfo(int exceptionNo, int errorcode, char
> > > *buffer) Write into buffer and information about the exception that has
> > > occured that can be gleaned from exceptionNo and errorcode.
> > >
> > > void kgdb_disable_hw_debug(struct pt_regs *regs)
> > > 	Disable hardware debugging while we are in kgdb.
> > >
> > > void kgdb_correct_hw_break(void)
> > > 	A hook to allow for changes to the hardware breakpoint, called
> > > 	after a single step (s) or continue (c) packet, and once we're about
> > > 	to let the kernel continue running.
> > >
> > > void kgdb_post_master_code(struct pt_regs *regs, int eVector, int
> > > err_code) Store the raw vector and error, for later retreival.
> > >
> > > void kgdb_shadowinfo(struct pt_regs *regs, char *buffer, unsigned
> > > threadid) struct task_struct *kgdb_get_shadow_thread(struct pt_regs
> > > *regs, int threadid) struct pt_regs *kgdb_shadow_regs(struct pt_regs
> > > *regs, int threadid) If we have a shadow thread (determined by setting
> > > 	kgdb_ops->shadowth = 1), these functions are required to return
> > > 	information about this thread.
> >
> > An addition: shadow threads are needed to provide information not
> > retrievable by gdb. e.g. Backtraces beyond interrupt entrypoints, that
> > aren't retrievable in absence of debugging info for interrupt entrypoint
> > code.
>
> If I follow everything right, this could go in favor of cfi macros,
> right ?

Yes. Shadow threads won't be required with CFI macros.

I believe they are not required with x86_64. I have to verify this.

How about keeping the shadow thread framework in place even after we get 
x86_64, x86 and ppc CFI macros. That'll help when we have other architectures 
coming in.

-Amit

