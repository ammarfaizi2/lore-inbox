Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWEVPFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWEVPFr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 11:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWEVPFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 11:05:47 -0400
Received: from lea.cs.unibo.it ([130.136.1.101]:63951 "EHLO lea.cs.unibo.it")
	by vger.kernel.org with ESMTP id S1750914AbWEVPFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 11:05:46 -0400
Date: Mon, 22 May 2006 17:05:44 +0200
To: Jeff Dike <jdike@addtoit.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, Ulrich Drepper <drepper@gmail.com>,
       osd@cs.unibo.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2-ptrace_multi
Message-ID: <20060522150544.GB11910@cs.unibo.it>
References: <20060518155337.GA17498@cs.unibo.it> <20060519174534.GA22346@cs.unibo.it> <20060519201509.GA13477@nevyn.them.org> <200605192217.30518.ak@suse.de> <1148135825.2085.33.camel@localhost.localdomain> <20060520183020.GC11648@cs.unibo.it> <20060520213959.GA4229@ccure.user-mode-linux.org> <20060521152810.GL15497@cs.unibo.it> <20060522130222.GA16937@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060522130222.GA16937@nevyn.them.org>
User-Agent: Mutt/1.5.6+20040907i
From: renzo@cs.unibo.it (Renzo Davoli)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 09:02:22AM -0400, Daniel Jacobowitz wrote:
> On Sun, May 21, 2006 at 05:28:10PM +0200, Renzo Davoli wrote:
> > It is not enough. I am fixing the [GS]ETREGS for ppc32 but it happens
> > that the error number is stored in the register PT_CCR (a.k.a. R38)
> > so I need an extra call to get that, then I need the program counter which is
> > in PT_NIP (R31). [GS]ETREGS for ppc load/store just the range R0-R31.
> > so I need 3 syscalls for each syscall issued by the ptraced process
> > instead of just one.
> 
> Then have you considered changing the regset returned to be actually
> useful?  Especially for ppc32 where you say it was not previously
> implemented?
Then it would be inconsistent with ppc64 where it does exist, and ppc64
has the very same problem.
So the solution would be to patch also the ppc64 [GS]ETREGS breaking
compatibility with existing applications. 

The MULTI proposal was a way to have a fast, simple, safe support.
Fast: one syscall does all
simple: it is a vector of calls with the params of std ptrace calls
safe: if is not a new call, the security checks for ptrace are already
in place
flexible: with [GS]ETREGS you can get only the registers you need
instead of all the registers (this is just an example).
PPC wants to read/write 32 registers, i386 17, x86_64 21 etc,
when maybe just some of the registers are meaningful to your
application. Using [GS]ETREGS, you have to save the entire register set
somewhere to restore them after some changes. This applies also to areas
of memory, and other ptrace commands.
backward compatible: if you did not use it, nothing changes in ptrace
support.

If you do not find this proposal interesting, I'll continue to support
it as a specific patch for umview. I am not here to "sell" any solution.
On the contrary I think it might be useful in many applications.

	renzo
