Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUCCFGU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 00:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbUCCFGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 00:06:20 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:36845 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261472AbUCCFGO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 00:06:14 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: [Kgdb-bugreport] [KGDB][RFC] Send a fuller T packet
Date: Wed, 3 Mar 2004 10:36:00 +0530
User-Agent: KMail/1.5
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net, Pavel Machek <pavel@suse.cz>
References: <20040302220233.GG20227@smtp.west.cox.net> <20040302233635.GM20227@smtp.west.cox.net> <4045254E.5010505@mvista.com>
In-Reply-To: <4045254E.5010505@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403031036.01388.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Polution of kgdb.h is definitely bad.

I tried this code from Tom's bitkeeper tree some time back. It was incorrect 
in two aspects hence I took only the minimal 'T' packet.
1. It assumes 32 bit pc and sp.
2. sp is not equal to ((char *)linux_regs) + SP_REGNUM * 4 on powerpc.

A full 'T' packet is still a good idea because it saves a 'g' packet in 
following cases:
1. gdb internal breakpoints, like module_event.
2. conditional breakpoints.
3. tracepoints.

In general we can report an arbitrary number of registers in a 'T' packet.  
Reporting registers other than PC and SP is effectively making 'T' packet 
into a 'g' packet.

Architecture dependent code is the right place to compose the PC and SP part 
of a 'T' packet. Given a pt_regs pointer, an architecture dependent function 
can compose PC number, PC value, SP number and SP value, all of which are 
arch dependent. How about architecture dependent function:
int make_pcsp_packet(struct pt_regs *, char *buffer)

-Amit

On Wednesday 03 Mar 2004 5:52 am, George Anzinger wrote:
> Tom Rini wrote:
> > On Tue, Mar 02, 2004 at 03:28:45PM -0800, George Anzinger wrote:
> >>Tom Rini wrote:
> >>>Hello.  Since a 'T' packet is allowed to send back information on an
> >>>arbitrary number of registers, and on PPC32 we've always been including
> >>>information on the stack pointer and program counter, I was wondering
> >>>what people thought of the following patch:
> >>>
> >>>diff -u linux-2.6.3/include/asm-x86_64/kgdb.h
> >>>linux-2.6.3/include/asm-x86_64/kgdb.h
> >>>--- linux-2.6.3/include/asm-x86_64/kgdb.h	2004-02-27
> >>>11:30:37.445782703 -0700
> >>>+++ linux-2.6.3/include/asm-x86_64/kgdb.h	2004-03-02
> >>>14:42:47.854532793 -0700
> >>>@@ -48,6 +48,10 @@
> >>>/* Number of bytes of registers.  */
> >>>#define NUMREGBYTES (_LASTREG*8)
> >>>
> >>>+#define PC_REGNUM	_PC	/* Program Counter */
> >>>+#define SP_REGNUM	_RSP	/* Stack Pointer */
> >>>+#define PTRACE_PC	rip	/* Program Counter, in ptrace regs. */
> >>
> >>I would really like to keep this stuff out of kgdb.h since it may be
> >>included by the user to pick up the BREAKPOINT() (which, by the way we
> >>should standardize as I note that here it has () while not on the current
> >>x86).
> >
> > It's BREAKPOINT() everywhere:
>
> Yeah, something you changed?  Oh well, I will just have to learn to put the
> "()" in :)
>
> > $ grep BREAKPOINT include/asm-*/kgdb.h
> > include/asm-i386/kgdb.h:#define BREAKPOINT() asm("   int $3");
> > include/asm-ppc/kgdb.h:#define BREAKPOINT()             asm(".long
> > 0x7d821008") /* twge r2, r2 */ include/asm-x86_64/kgdb.h:#define
> > BREAKPOINT() asm("   int $3");
> >
> >>Isn't there a kgdb_local.h which is used only by kdgd and friends?  We
> >>really do want to keep the name space as clean as possible to prevent
> >>possible conflicts.
> >
> > The simple answer is you don't call BREAKPOINT() in your code anywhere.
> > You call breakpoint() or kgdb_schedule_breakpoint().
>
> Uh, why?  Last I knew that was a real function.  Most of the time I just
> want a simple breakpoint.  I surly don't want the register dumps and such
> that a function call causes, not to mention that it may do something else
> that is not friendly.
>
> > The split here is different in that <linux/kgdb.h> should be standalone
> > (it's not, _yet_).
>
> Yeah, but it will most likely include asm/kgdb.h....
>
> > But this is all an aside to my question. :)
>
> Right, my answer on that is if it reduces the line traffic yes, if not, no.
> Because then it is just bloat.

