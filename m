Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTIQUFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 16:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbTIQUFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 16:05:51 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6784 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262805AbTIQUFj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 16:05:39 -0400
Date: Wed, 17 Sep 2003 16:05:57 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ben Johnson <ben@blarg.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linear vs. logical addresses?  how does cpu interpret kernel
 addrs?
In-Reply-To: <20030917124221.A3970@blarg.net>
Message-ID: <Pine.LNX.4.53.0309171551080.426@chaos>
References: <20030916154747.A22526@blarg.net> <Pine.LNX.4.53.0309170734240.881@chaos>
 <20030917124221.A3970@blarg.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Sep 2003, Ben Johnson wrote:

> On Wed, Sep 17, 2003 at 07:39:53AM -0400, Richard B. Johnson wrote:
> >
> > All stack offsets are accessed relative to SS. No exceptions.
> > However a compiler may calculate those offsets based upon
> > something else.
> > This is why DS must equal SS if 'C' is going to access both
> > stack data variables and data segment variables. This is how
> > the 'C' code converter is set up. It is not a CPU limitation.
> > If you change the SS in the kernel, strange and wonderful
> > things will occur.
>
> Let me see if I understand you.  If SS and DS point to segments that
> have different base addresses then code like this...  (I'm an assembly
> newbie.  hope I get this right.)
>
> # get whatever is at %ss:%esp + 4 and put it in eax
> movl 4(%esp), %eax
> movl %esp, %edx
> # get whatever is at %ds:%edx + 4 and put it in eax
> movl 4(%edx), %eax
>
> # eax probably changed twice because while esp and edx have same value,
> # if SS->baseaddr != DS->baseaddr, then (%esp) and (%edx) don't point to
> # the same memory location.

Correct. You can make segments with different attributes, like
you can make the stack non-executable, etc. However, the base
addresses need to be the same so that DS:[0], ES:[0], and SS:[0]
all point to the same memory location or else the offsets computed
by the 'C' compiler won't work.

You can force an assembler to calculate different offsets. For instance,
you could have the base of DS be one page lower (0x1000) than SS.
Then you could make the assembler calculate, based upon that
difference, (in Intel, TASM, MASM, the ASSUME statement). But
with most 'C' compilers, you are stuck with what you have.

>
> I'm pretty sure I've seen plenty of code like this, which must mean,
> like you just told me, that the C compiler assumes the base address of
> DS and SS are the same.  So, if I want to change segment base addresses
> then I'm up shit creek.
>

Pretty much unless you want to rewrite everything that accesses data
on the stack in assembly!

> Thanks very much for the info!
>

If you wanted to write everything in assembly (shudder), in
principle, you could set up a stack segment that pointed
to entirely different RAM (real RAM) than the data segment.
However, it would mean that you need to rewrite everything
that copies data to/from local data (the stack), etc. Without
that memcpy(), etc., wouldn't work. In fact, the Intel built-in
macros like movsb, movsw, movsl, etc., assume DS:ESI, ES:EDI, for
index (pointer) registers. Note also that there are two seldom-
used segment registers, FS and GS.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


