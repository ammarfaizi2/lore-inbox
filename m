Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVFMO1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVFMO1y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 10:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVFMO1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 10:27:54 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:20178 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261582AbVFMO1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 10:27:05 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: <cutaway@bellsouth.net>
Subject: Re: [RFC] Observations on x86 process.c
Date: Mon, 13 Jun 2005 17:26:50 +0300
User-Agent: KMail/1.5.4
Cc: <linux-kernel@vger.kernel.org>
References: <002301c57018$266079b0$2800000a@pc365dualp2> <200506131618.09718.vda@ilport.com.ua> <000e01c57028$c82dba90$2800000a@pc365dualp2>
In-Reply-To: <000e01c57028$c82dba90$2800000a@pc365dualp2>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506131726.50264.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What about having a __speed macro:
> >
> > int very_frequently_user_func() __speed {
> > ...
> > }
> >
> > Unconditionally aligning all fns to 16 bytes is a waste of cache
> > in lieu of 80/20 rule ("80% of execution time is spent in 20% of the
> code")...
> 
> This was going to be a follow up observation<g>...  the sleep/wake inc/dec
> functions at the top of the file could/should also be relocated.  Going into
> a coma and coming out of one probably aren't happen often enough to
> potentially be burning L1/L2 lines on them.  Probably not very useful to
> have (2) instruction functions being 16 byte aligned either when both would
> comfortably fit in a single line.

I am not affected. I compile my kernels with zero alignment.

Not my itch to scratch.

> > http://lxr.linux.no/source/include/asm-i386/elf.h#L78
> > 75 /* regs is struct pt_regs, pr_reg is elf_gregset_t (which is
> > 76    now struct_user_regs, they are different) */
> > 77
> > 78 #define ELF_CORE_COPY_REGS(pr_reg, regs)                \
> > 79         pr_reg[0] = regs->ebx;                          \
> > 80         pr_reg[1] = regs->ecx;                          \
> > 81         pr_reg[2] = regs->edx;                          \
> > 82         pr_reg[3] = regs->esi;                          \
> > 83         pr_reg[4] = regs->edi;                          \
> > 84         pr_reg[5] = regs->ebp;                          \
> > 85         pr_reg[6] = regs->eax;                          \
> > 86         pr_reg[7] = regs->xds;                          \
> > 87         pr_reg[8] = regs->xes;                          \
> > 88         savesegment(fs,pr_reg[9]);                      \
> > 89         savesegment(gs,pr_reg[10]);                     \
> > 90         pr_reg[11] = regs->orig_eax;                    \
> > 91         pr_reg[12] = regs->eip;                         \
> > 92         pr_reg[13] = regs->xcs;                         \
> > 93         pr_reg[14] = regs->eflags;                      \
> > 94         pr_reg[15] = regs->esp;                         \
> > 95         pr_reg[16] = regs->xss;
> >
> > You are basically proposing micro-optimizing it with asm().
> > It it *that* critical?
> 
> For speed? No.  Speed of crashing isn't important<g>.  Actually, functions
> like these should be taken out of mainline pages completely and relegated to
> a page(s) dedicated to rarely used but necessary routines.  This has more to
> do with cache pollution than anything else.

Do you realize how large linux kernel is? Are you going to optimize all of it
by hand?!

> > You shouldn't tailor code for specific compiler peculiarities
> > or rewrite code with asm().
> >
> > If you really want gcc to generate better code - try to come up
> > with gcc patch so that it notices such optimization opportunities:
> 
> We have no power to "unship" existing compilers in the field, and it seems
> harsh to penalize people using them IMO.  Tuning NOW for everything in the
> field gives advantage NOW.  If GCC ever becomes more intelligent about its
> code gen that's nice, but it doesn't help the several flavors in common use
> floating around right now.

People tend to gradually update their systems. Make gcc better, and it will
pay back with time. If you want that benefit _now_, then use your better gcc
immediately instead of stone age one. Others will take care of themselves.

If you feel like sprinkling tons of asm() over zillions of lines of code instead
- good luck :)
--
vda

