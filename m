Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWETSaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWETSaW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 14:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWETSaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 14:30:22 -0400
Received: from lea.cs.unibo.it ([130.136.1.101]:22156 "EHLO lea.cs.unibo.it")
	by vger.kernel.org with ESMTP id S932360AbWETSaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 14:30:22 -0400
Date: Sat, 20 May 2006 20:30:20 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Daniel Jacobowitz <dan@debian.org>,
       Ulrich Drepper <drepper@gmail.com>, osd@cs.unibo.it,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2-ptrace_multi
Message-ID: <20060520183020.GC11648@cs.unibo.it>
References: <20060518155337.GA17498@cs.unibo.it> <20060519174534.GA22346@cs.unibo.it> <20060519201509.GA13477@nevyn.them.org> <200605192217.30518.ak@suse.de> <1148135825.2085.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148135825.2085.33.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
From: renzo@cs.unibo.it (Renzo Davoli)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To summarize the thread we have agreed that
/proc/*/mem should be writable, at least with ptrace permissions.

Even reading from /proc/*/mem does not currently have the same permissions of
ptrace. E.g. when a setuid process is started under ptrace it runs
without the setuid semantics, thus it is possible to get/put data
using PTRACE_{PEEK,POKE}*.
There are no security threats as the process is running in an
unprivileged way, on the contrary this is a feature that allows
virtual machines to run setuid code, e.g. we use this feature to
run /bin/ping on virtual networks.
Instead it is not possible to read the memory through /proc/*/mem
in the same situation.
(In UMview -- see our cvs if you like -- to manage this exception
there is now a read from /proc/*/mem file and if the read fails it 
rolls back to the standard PTRACE_PEEKDATA.)

Let me point out that PTRACE_MULTI is not only related to memory access.
We are using PTRACE_MULTI also to store the registers and restart the
execution of the ptraced process with a single syscall.
This is very effective when umview runs on a ppc32 architecture. In
fact, PPC_PTRACE_{G,S}ETREGS do not exist for that architecture
(IMHO there is no evident reason for that). Without PTRACE_MULTI each register
must be read/written individually by a PTRACE_{PEEK,POKE}USER(*)

PTRACE_MULTI can be also used to optimize many other virtualized calls,
e.g. to read/write all the buffers for a readv/writev/recvmsg/sendmsg
call at once.

Therefore I feel that /proc/*/mem access can help but PTRACE_MULTI
gives something more.

	renzo

(*) two notes about PPC_PTRACE_{G,S}ETREGS for powerpc.
It is not clear to me why the same calls are okay for ppc64 and forbidden
for ppc32, all the statements inside this ifdef

arch/powerpc/kernel/ptrace.c: 407  #ifdef CONFIG_PPC64
arch/powerpc/kernel/ptrace.c: 408  case PPC_PTRACE_GETREGS: { /* Get GPRs 0 - 31. */
...

are meaningful for ppc32 too. I have not tested it yet, but maybe
deleting the #ifdef is enough to provide PPC_PTRACE_{G,S}ETREGS to
ppc32, too.
There is another detail. IMVHO in ppc64 architecture the security control 
that forbids to change the PT_ORIG_R3 register by PTRACE_POKEUSER

arch/powerpc/kernel/ptrace.c: 329  if (index == PT_ORIG_R3)
arch/powerpc/kernel/ptrace.c: 330    break;

is circunvented by PPC_PTRACE_SETREGS that rewrites all the registers
including PT_ORIG_R3. (Maybe I am wrong but I haven't seen any
check about this).
