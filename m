Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVFMOJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVFMOJR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 10:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVFMOJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 10:09:17 -0400
Received: from imf20aec.mail.bellsouth.net ([205.152.59.68]:3035 "EHLO
	imf20aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261575AbVFMOIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 10:08:43 -0400
Message-ID: <000e01c57028$c82dba90$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Denis Vlasenko" <vda@ilport.com.ua>
Cc: <linux-kernel@vger.kernel.org>
References: <002301c57018$266079b0$2800000a@pc365dualp2> <200506131618.09718.vda@ilport.com.ua>
Subject: Re: [RFC] Observations on x86 process.c
Date: Mon, 13 Jun 2005 11:01:17 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Denis Vlasenko" <vda@ilport.com.ua>
To: <cutaway@bellsouth.net>; <linux-kernel@vger.kernel.org>
Sent: Monday, June 13, 2005 09:18
Subject: Re: [RFC] Observations on x86 process.c


> On Monday 13 June 2005 16:02, cutaway@bellsouth.net wrote:
> > A) dump_thread() and dump_task_regs() are in the middle of the file, but
> > will be infrequently used. With default 16 byte alignment, this may
cause
> > bits of them to wind up polluting the L1 on anything with L1 lines > 16
> > bytes.  L2 lines could be similarly polluted too of course.
> > Moving these two routines to the bottom would probably be a better deal.
>
> What about having a __speed macro:
>
> int very_frequently_user_func() __speed {
> ...
> }
>
> Unconditionally aligning all fns to 16 bytes is a waste of cache
> in lieu of 80/20 rule ("80% of execution time is spent in 20% of the
code")...

This was going to be a follow up observation<g>...  the sleep/wake inc/dec
functions at the top of the file could/should also be relocated.  Going into
a coma and coming out of one probably aren't happen often enough to
potentially be burning L1/L2 lines on them.  Probably not very useful to
have (2) instruction functions being 16 byte aligned either when both would
comfortably fit in a single line.

>
> > B) elf_core_copy_regs() macro (which resolves to ELF_CORE_COPY_REGS
macro)
> > just copies largely similar (but not quite identical) structures with a
bit
> > of difference in the middle for seg reg handling using a long sequence
of "a
> > = b" type assignments.  It would seem this could be tweaked a bit with a
> > couple of REP MOV's on either side of the seg reg dissimilarity.  Fast
crash
> > dump handling code isn't as desirable as compact crash dump handling
code.
>
> http://lxr.linux.no/source/include/asm-i386/elf.h#L78
> 75 /* regs is struct pt_regs, pr_reg is elf_gregset_t (which is
> 76    now struct_user_regs, they are different) */
> 77
> 78 #define ELF_CORE_COPY_REGS(pr_reg, regs)                \
> 79         pr_reg[0] = regs->ebx;                          \
> 80         pr_reg[1] = regs->ecx;                          \
> 81         pr_reg[2] = regs->edx;                          \
> 82         pr_reg[3] = regs->esi;                          \
> 83         pr_reg[4] = regs->edi;                          \
> 84         pr_reg[5] = regs->ebp;                          \
> 85         pr_reg[6] = regs->eax;                          \
> 86         pr_reg[7] = regs->xds;                          \
> 87         pr_reg[8] = regs->xes;                          \
> 88         savesegment(fs,pr_reg[9]);                      \
> 89         savesegment(gs,pr_reg[10]);                     \
> 90         pr_reg[11] = regs->orig_eax;                    \
> 91         pr_reg[12] = regs->eip;                         \
> 92         pr_reg[13] = regs->xcs;                         \
> 93         pr_reg[14] = regs->eflags;                      \
> 94         pr_reg[15] = regs->esp;                         \
> 95         pr_reg[16] = regs->xss;
>
> You are basically proposing micro-optimizing it with asm().
> It it *that* critical?

For speed? No.  Speed of crashing isn't important<g>.  Actually, functions
like these should be taken out of mainline pages completely and relegated to
a page(s) dedicated to rarely used but necessary routines.  This has more to
do with cache pollution than anything else.

>
> > C) dump_task_regs() can be shortened up a tad by zeroing the high words
of
> > the seg reg vars with a bit of inline that uses a word AND with imm8
zero.
> > Right now the compiler is generating 4 MOVZX's and 4 MOV's to clip off
the
> > trash bits. Again, not being a high performance path, the better
compactness
> > of (4) AND mem16,imm8 would be more desirable over the 8 MOVZX/MOV
> > instructions that get generated now.
>
> What's wrong with 16bit MOVs? Anyway.
> You shouldn't tailor code for specific compiler peculiarities
> or rewrite code with asm().
>
> If you really want gcc to generate better code - try to come up
> with gcc patch so that it notices such optimization opportunities:

We have no power to "unship" existing compilers in the field, and it seems
harsh to penalize people using them IMO.  Tuning NOW for everything in the
field gives advantage NOW.  If GCC ever becomes more intelligent about its
code gen that's nice, but it doesn't help the several flavors in common use
floating around right now.

