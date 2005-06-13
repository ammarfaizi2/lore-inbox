Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVFMNUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVFMNUv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 09:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVFMNUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 09:20:51 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:25811 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261339AbVFMNUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 09:20:39 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: <cutaway@bellsouth.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Observations on x86 process.c
Date: Mon, 13 Jun 2005 16:18:09 +0300
User-Agent: KMail/1.5.4
References: <002301c57018$266079b0$2800000a@pc365dualp2>
In-Reply-To: <002301c57018$266079b0$2800000a@pc365dualp2>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506131618.09718.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 June 2005 16:02, cutaway@bellsouth.net wrote:
> A) dump_thread() and dump_task_regs() are in the middle of the file, but
> will be infrequently used. With default 16 byte alignment, this may cause
> bits of them to wind up polluting the L1 on anything with L1 lines > 16
> bytes.  L2 lines could be similarly polluted too of course.
> Moving these two routines to the bottom would probably be a better deal.

What about having a __speed macro:

int very_frequently_user_func() __speed {
...
}

Unconditionally aligning all fns to 16 bytes is a waste of cache
in lieu of 80/20 rule ("80% of execution time is spent in 20% of the code")...

> B) elf_core_copy_regs() macro (which resolves to ELF_CORE_COPY_REGS macro)
> just copies largely similar (but not quite identical) structures with a bit
> of difference in the middle for seg reg handling using a long sequence of "a
> = b" type assignments.  It would seem this could be tweaked a bit with a
> couple of REP MOV's on either side of the seg reg dissimilarity.  Fast crash
> dump handling code isn't as desirable as compact crash dump handling code.

http://lxr.linux.no/source/include/asm-i386/elf.h#L78
75 /* regs is struct pt_regs, pr_reg is elf_gregset_t (which is
76    now struct_user_regs, they are different) */
77 
78 #define ELF_CORE_COPY_REGS(pr_reg, regs)                \
79         pr_reg[0] = regs->ebx;                          \
80         pr_reg[1] = regs->ecx;                          \
81         pr_reg[2] = regs->edx;                          \
82         pr_reg[3] = regs->esi;                          \
83         pr_reg[4] = regs->edi;                          \
84         pr_reg[5] = regs->ebp;                          \
85         pr_reg[6] = regs->eax;                          \
86         pr_reg[7] = regs->xds;                          \
87         pr_reg[8] = regs->xes;                          \
88         savesegment(fs,pr_reg[9]);                      \
89         savesegment(gs,pr_reg[10]);                     \
90         pr_reg[11] = regs->orig_eax;                    \
91         pr_reg[12] = regs->eip;                         \
92         pr_reg[13] = regs->xcs;                         \
93         pr_reg[14] = regs->eflags;                      \
94         pr_reg[15] = regs->esp;                         \
95         pr_reg[16] = regs->xss;

You are basically proposing micro-optimizing it with asm().
It it *that* critical?

> C) dump_task_regs() can be shortened up a tad by zeroing the high words of
> the seg reg vars with a bit of inline that uses a word AND with imm8 zero.
> Right now the compiler is generating 4 MOVZX's and 4 MOV's to clip off the
> trash bits. Again, not being a high performance path, the better compactness
> of (4) AND mem16,imm8 would be more desirable over the 8 MOVZX/MOV
> instructions that get generated now.

What's wrong with 16bit MOVs? Anyway.
You shouldn't tailor code for specific compiler peculiarities
or rewrite code with asm().

If you really want gcc to generate better code - try to come up
with gcc patch so that it notices such optimization opportunities:

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=21329
--
vda

