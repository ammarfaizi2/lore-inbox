Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752283AbWFLTkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbWFLTkU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 15:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbWFLTkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 15:40:20 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:25636 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1752282AbWFLTkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 15:40:19 -0400
Subject: Re: [PATCH] kprobes for s390 architecture
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Mike Grundy <grundym@us.ibm.com>, jan.glauber@de.ibm.com
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
In-Reply-To: <20060612131552.GA6647@localhost.localdomain>
References: <20060612131552.GA6647@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 12 Jun 2006 21:40:17 +0200
Message-Id: <1150141217.5495.72.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 09:15 -0400, Mike Grundy wrote:
> This patch provides kprobes support for s390 architecture

Looks like a good start. There are some bugs though and I have a few
suggestions:

> diff -urNp linux-2.6.17-rc6/arch/s390/kernel/entry64.S linux-2.6.17-rc6-kp390/arch/s390/kernel/entry64.S
> --- linux-2.6.17-rc6/arch/s390/kernel/entry64.S	2006-06-05 20:57:02.000000000 -0400
> +++ linux-2.6.17-rc6-kp390/arch/s390/kernel/entry64.S	2006-06-12 05:13:05.000000000 -0400
> @@ -478,6 +478,8 @@ pgm_per:
>          clc     __LC_PGM_OLD_PSW(16),__LC_SVC_NEW_PSW
>          je      pgm_svcper
>  # no interesting special case, ignore PER event
> +	tm	__LC_PGM_OLD_PSW+1(%r15),0x01	# kernel per event ?
> +	jz	kernel_per
>  	lmg	%r12,%r15,__LC_SAVE_AREA
>  	lpswe   __LC_PGM_OLD_PSW
>  

If this branch is ever taken it will crash at least the currently
running process. The program check handler will branch to pgm_per after
having done SAVE_ALL_BASE and if the per bit in the psw is set.
SAVE_ALL_SYNC and CRETE_STACK_FRAME have not been called yet and neither
kernel_per nor sysc_singlestep will do it. That means that no stack
frame for the kernel per event has been generated which will crash.

> @@ -497,6 +499,8 @@ pgm_no_vtime2:
>  #endif
>  	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
>  	lg	%r1,__TI_task(%r9)
> +	tm	__LC_PGM_OLD_PSW+1(%r15),0x01	# kernel per event ?
> +	jz	kernel_per
>  	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
>  	mvc	__THREAD_per+__PER_address(8,%r1),__LC_PER_ADDRESS
>  	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID

This branch is ok and is imho the only one we need.

> @@ -531,6 +535,20 @@ pgm_no_vtime3:
>  	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
>  	j	sysc_do_svc
>  
> +#
> +# per was called from kernel, must be kprobes
> +#
> +kernel_per:
> +	lgf     %r3,__LC_PGM_ILC	 # load program interruption code
> +	lghi	%r8,0x7f
> +	ngr	%r8,%r3			 # clear per-event-bit and ilc
> +	j	sysc_singlestep
> +	lhi	%r0,__LC_PGM_OLD_PSW
> +	sth	%r0,SP_TRAP(%r15)	# set trap indication to pgm check
> +	la	%r2,SP_PTREGS(%r15)	# address of register-save area
> +	larl	%r14,sysc_leave		# load adr. of system ret, no work
> +	brcl	15,do_single_step		# branch to do_single_step
> +
>  /*
>   * IO interrupt handler routine
>   */

The code after "j sysc_singlestep" is unreachable. Either you can remove
it or there is a branch missing.


> diff -urNp linux-2.6.17-rc6/arch/s390/kernel/entry.S linux-2.6.17-rc6-kp390/arch/s390/kernel/entry.S
> --- linux-2.6.17-rc6/arch/s390/kernel/entry.S	2006-06-05 20:57:02.000000000 -0400
> +++ linux-2.6.17-rc6-kp390/arch/s390/kernel/entry.S	2006-06-12 05:13:05.000000000 -0400
> @@ -456,6 +456,8 @@ pgm_per:
>  # ok its one of the special cases, now we need to find out which one
>          clc     __LC_PGM_OLD_PSW(8),__LC_SVC_NEW_PSW
>          be      BASED(pgm_svcper)
> +	tm	__LC_PGM_OLD_PSW+1(%r15),0x01	# kernel per event ?
> +	bz	BASED(sysc_singlestep)
>  # no interesting special case, ignore PER event
>          lm      %r12,%r15,__LC_SAVE_AREA
>  	lpsw    0x28

Same as for 64 bit, if the branch is taken it will crash.

> @@ -480,6 +482,8 @@ pgm_no_vtime2:
>  	mvc	__THREAD_per+__PER_address(4,%r1),__LC_PER_ADDRESS
>  	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
>  	oi	__TI_flags+3(%r9),_TIF_SINGLE_STEP # set TIF_SINGLE_STEP
> +	tm	__LC_PGM_OLD_PSW+1(%r15),0x01	# kernel per event ?
> +	bz	BASED(sysc_singlestep)
>  	l	%r3,__LC_PGM_ILC	 # load program interruption code
>  	la	%r8,0x7f
>  	nr	%r8,%r3                  # clear per-event-bit and ilc

The 31 bit code branches to sysc_singlestep directly. Why is kernel_per
only needed for 64 bit? I think 31 bit needs kernel_per as well.

> diff -urNp linux-2.6.17-rc6/arch/s390/kernel/kprobes.c linux-2.6.17-rc6-kp390/arch/s390/kernel/kprobes.c
> --- linux-2.6.17-rc6/arch/s390/kernel/kprobes.c	1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.17-rc6-kp390/arch/s390/kernel/kprobes.c	2006-06-12 08:27:27.000000000 -0400
> @@ -0,0 +1,648 @@
> +/*
> + *  Kernel Probes (KProbes)
> + *  arch/s390/kernel/kprobes.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + *
> + * Copyright (C) IBM Corporation, 2002, 2006
> + *
> + * s390 port, used ppc64 as template. Mike Grundy <grundym@us.ibm.com>
> + */
> +
> +#include <linux/config.h>
> +#include <linux/kprobes.h>
> +#include <linux/ptrace.h>
> +#include <linux/preempt.h>
> +#include <asm/cacheflush.h>
> +#include <asm/kdebug.h>
> +#include <asm/sections.h>
> +
> +DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
> +DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> +
> +int __kprobes arch_prepare_kprobe(struct kprobe *p)
> +{
> +	int ret = 0;
> +
> +	/* Make sure the probe isn't going on a difficult instruction */
> +	if (is_prohibited_opcode((kprobe_opcode_t *) p->addr))
> +		ret = -EINVAL;
> +
> +	/* Use the get_insn_slot() facility for correctness */
> +	if (!ret) {
> +		p->ainsn.insn = get_insn_slot();
> +		if (!p->ainsn.insn) {
> +			ret = -ENOMEM;
> +		} else {
> +			/* this should only happen if you got the slot */
> +			memcpy(p->ainsn.insn, p->addr,
> +			       MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
> +			p->ainsn.inst_type =
> +			    get_instruction_type(p->ainsn.insn);
> +		}
> +	}
> +	p->opcode = *p->addr;
> +	return ret;
> +}
> +

Hmm, you are assigning to p->opcode even if the function returns an
error. I have the vague feeling that this is not a good idea. And I
suggest that you use early returns, that way you get rid of two levels
of indention.

> +int __kprobes is_prohibited_opcode(kprobe_opcode_t *instruction)
> +{
> +	__u8 opcode[6];
> +	int ret = 0;
> +
> +	memcpy(opcode, instruction, 6 * sizeof(__u8));
> +
> +	switch (opcode[0]) {
> +	case OPCODE_BASSM:
> +	case OPCODE_BSM:
> +	case OPCODE_DIAG:
> +	case OPCODE_EX:
> +		ret = -EINVAL;
> +		break;
> +	case OPCODE_PR:
> +		if (opcode[1] == OPCODE_PR)
> +			ret = -EINVAL;
> +		break;
> +	case 0xB2:
> +		switch (opcode[1]) {
> +		case OPCODE_BSA:
> +		case OPCODE_BAKR:
> +		case OPCODE_BSG:
> +		case OPCODE_PC:
> +		case OPCODE_PT:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		break;
> +	}
> +	return ret;
> +}
> +

I would write the function like this:

int __kprobes is_prohibited_opcode(kprobe_opcode_t *instruction)
{
        switch (*(__u8 *) instruction) {
        case 0x0c:      /* bassm */
        case 0x0b:      /* bsm   */
        case 0x83:      /* diag  */
        case 0x44:      /* ex    */
                return -EINVAL;
        }
        switch (*(__u16 *) instruction) {
        case 0x0101:    /* pr    */
        case 0xb25a:    /* bsa   */
        case 0xb240:    /* bakr  */
        case 0xb258:    /* bsg   */
        case 0xb218:    /* pc    */
        case 0xb228:    /* pt    */
                return -EINVAL;
        }
        return 0;
}

Remove the OPCODE_xxx #defines. To have one-byte opcode defines for 2, 4
and 6 bytes instructions is quite confusing. The full blown opcode
masking solution as implemented e.g. in the binutils would be overkill.
A "stand-alone" function like the above is preferable because it is
simple and you don't have to look at several files to figure out what it
does.

> +/* get_instruction type will return 0 if only the regular offset adjustments
> + * after out of line singlestep are required. If a register needs to be fixed,
> + * bits 16-23 will contain the register number, bits 24-31 contain the length
> + * of the instruction unit. If fixup is only required when the branch is not
> + * taken, bits 0-16 will all be set.
> + */
> +int __kprobes get_instruction_type(kprobe_opcode_t * instruction)
> +{
> +	__u8 opcode[6];
> +	int ret = 0;
> +
> +	memcpy(opcode, instruction, 6 * sizeof(__u8));

Again that memcpy. Why don't you just cast the instruction pointer to
__u8 and __u16 and deference it? 

The following switch deals with all the instructions that need special
handling. Please get rid of the BALR/BASR/BCR/BCTR/... defines and use
the opcode number directly. Add a comment which instruction it is like
in the new is_prohibited_opcode. All these defines are only used in
get_instruction_type and the opcodes will certainly not change, only new
ones will get added. No point in all those #defines.

> +
> +	switch (opcode[0]) {
> +		/* RR Format - instruction unit length = 2
> +		 *  ________ ____ ____
> +		 * |Op Code | R1 | R2 |
> +		 * |________|_M1_|____|
> +		 * 0         8   12  15
> +		 */
> +	case BALR:	/* PSW addr saved in R1, branch address in R2 */
> +		ret = (opcode[1] & 0xf0) + 2;
> +		/* Special non branching use of BALR */
> +		if ((opcode[1] & 0x0f) == 0)
> +			ret &= FIXUP_NOBRANCH;
> +		break;

((opcode[1] & 0xf0) + 2) & FIXUP_NOBRANCH is always 0. If the target
register is 0 no branch takes place but R1 still needs fixup.
resume_execution will just fixup the psw address in that case. I think
you meant "ret |= FIXUP_NOBRANCH".


> +	case BASR:	/* PSW addr saved in R1, branch address in R2 */
> +		ret = (opcode[1] & 0xf0) + 2;
> +		/* Special non branching use of BASR */
> +		if ((opcode[1] & 0x0f) == 0)
> +			ret &= FIXUP_NOBRANCH;
> +		break;

Same here..

> +	case BCR:	/* M1 is mask val (condition), branch addr in R2 */
> +		ret = FIXUP_NOBRANCH & 2;
> +		break;

..here..

> +	case BCTR:	/* R1 is count down, R2 is branch addr until R1 = 0 */
> +		ret = FIXUP_NOBRANCH & 2;
> +		break;

..here..

> +		/* RX Format - instruction unit length = 4
> +		 *  ________ ____ ____ ____ ____________
> +		 * |Op Code | R1 | X2 | B2 |     D2     |
> +		 * |________|_M1_|____|____|____________|
> +		 * 0         8   12   16   20          31
> +		 */
> +	case BAL:	/* PSW addr saved in R1, branch addr D2(X2,B2) */
> +		ret = (opcode[1] & 0xf0) + 4;
> +		break;
> +	case BAS:	/* PSW addr saved in R1, branch addr D2(X2,B2) */
> +		ret = (opcode[1] & 0xf0) + 4;
> +		break;
> +	case BC:	/* M1 is mask val (condition), branch addr D2(X2,B2) */
> +		ret = FIXUP_NOBRANCH & 4;
> +		break;

..here..

> +	case BCT:	/* R1 is count down, D2(X2,B2) is branch addr */
> +		ret = FIXUP_NOBRANCH & 4;
> +		break;

..here..

> +		/* RI Format - instruction unit length = 4
> +		 *  ________ ____ ____ _________________
> +		 * |Op Code | R1 |OpCd|       I2        |
> +		 * |________|____|____|_________________|
> +		 * 0         8   12   16               31
> +		 */
> +	case 0xA7:	/* first byte (multiple ops have same 1st byte) */
> +		if ((opcode[1] & 0x0f) == BRAS) {
> +			ret = (opcode[1] & 0xf0) + 4;
> +		}
> +		break;
> +		/* RS Format - instruction unit length = 4
> +		 *  ________ ____ ____ ____ ____________
> +		 * |Op Code | R1 | R3 | B2 |     D2     |
> +		 * |________|____|_M3_|____|____________|
> +		 * 0         8   12   16   20          31
> +		 */
> +	case BXH:
> +		ret = FIXUP_NOBRANCH & 4;
> +		break;

..here..

> +	case BXLE:
> +		ret = FIXUP_NOBRANCH & 4;
> +		break;

..here..

> +		/* RIL Format - instruction unit length = 6
> +		 *  ________ ____ ____ _____________/______________
> +		 * |Op Code | R1 |OpCd|            I2              |
> +		 * |________|_M1_|____|_____________/______________|
> +		 * 0         8   12   16                          47
> +		 */
> +	case 0xC0:
> +		if ((opcode[1] & 0x0f) == BRASL) {
> +			ret = (opcode[1] & 0xf0) + 6;
> +		} else if ((opcode[1] & 0x0f) == BRCL) {
> +			ret = FIXUP_NOBRANCH & 6;
> +		}
> +		break;

..here..

> +		/* RSY Format - instruction unit length = 6
> +		 *  ________ ____ ____ ____ __/__ ________ ________
> +		 * |Op Code | R1 | R3 | B2 | DL2 |  DH2   |Op Code |
> +		 * |________|____|_M3_|____|__/__|________|________|
> +		 * 0         8   12   16   20    32       40      47
> +		 */
> +	case 0xEB:
> +		if (opcode[5] == BXHG || opcode[5] == BXLEG) {
> +			ret = FIXUP_NOBRANCH & 6;
> +		}
> +		break;

..here..

> +		/* RXY Format - instruction unit length = 6
> +		 *  ________ ____ ____ ____ __/__ ________ ________
> +		 * |Op Code | R1 | X2 | B2 | DL2 |  DH2   |Op Code |
> +		 * |________|____|____|____|__/__|________|________|
> +		 * 0         8   12   16   20    32       40      47
> +		 */
> +	case 0xE3:
> +		if (opcode[5] == BCTG) {
> +			ret = FIXUP_NOBRANCH & 6;
> +		}
> +		break;

..and here.

> +	default:
> +		break;
> +	}
> +	return ret;
> +}
> +

There are some more instructions missing that need fixup:
"brxh" 0x84??????, "brxle" 0x85??????, "brc" 0xa7?4????,
"brct" 0xa7?6????, "brctg" 0xa7?7????, "bctgr" 0xb946????,
"brxhg" 0xec????????44 and "brxlg" 0xec??????45.

A suggestion: I think the code would be easier to understand if you'd
use three bits for the three actions that are needed after single
stepping the out-of-line instruction:
1) fixup psw.addr to point to the instruction after the breakpoint
   (FIXUP_PSW_NORMAL 0x80000000)
2) fixup psw.addr to point to the instruction after the breakpoint if
the branch has not been taken (FIXUP_PSW_BRANCH 0x40000000)
3) update register with the return address (FIXUP_RETURN_REGISTER).

1) and 2) are mutual exclusive, 3) can be combined with either 1) or 2).
In addition a structure instead of an int for inst_type might improve
readability.

> +void __kprobes arch_arm_kprobe(struct kprobe *p)
> +{
> +	*p->addr = BREAKPOINT_INSTRUCTION;
> +}
> +
> +void __kprobes arch_disarm_kprobe(struct kprobe *p)
> +{
> +	*p->addr = p->opcode;
> +}
> +

I would feel better if the kernel code is changed in a more controlled
manner. Do an smp_call_function to avoid concurrent execution of the
instruction you are changing.

> +void __kprobes arch_remove_kprobe(struct kprobe *p)
> +{
> +	mutex_lock(&kprobe_mutex);
> +	free_insn_slot(p->ainsn.insn);
> +	mutex_unlock(&kprobe_mutex);
> +}
> +
> +static void __kprobes prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
> +{
> +	per_cr_bits kprobe_per_regs[1];
> +
> +	memset(kprobe_per_regs, 0, sizeof(per_cr_bits));
> +	regs->psw.addr = (unsigned long)p->ainsn.insn;
> +
> +	/* Just make sure this gets done */
> +	regs->psw.addr |= PSW_ADDR_AMODE;
> +

Just make sure this gets done... I don't think that comment helps much.
Please collapse the two regs->psw.addr lines into a single one and
remove the comment.

> +	/* Set up the per control reg info, will pass to lctl */
> +	kprobe_per_regs[0].em_instruction_fetch = 1;
> +	kprobe_per_regs[0].starting_addr = regs->psw.addr;
> +	kprobe_per_regs[0].ending_addr = regs->psw.addr + 4;
> +

"ending_addr = regs->psw.addr + 1" is enough, see pop 4-31:
an instruction-fetching event occurs if the first byte of the
instruction is within the storage area designated by control
registers 10 and 11.

> +	/* Set the PER control regs, turns on single step for this address */
> +	__ctl_load(kprobe_per_regs, 9, 11);
> +	regs->psw.mask |= PSW_MASK_PER;
> +	regs->psw.mask &= ~(PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK);
> +}
> +

Why do you disable the interrupts and the machine checks?

> +void __kprobes jprobe_return(void)
> +{
> +	asm volatile (".long 0x00020000");
> +}
> +

0x0002 is a two bytes instruction, any specific reason why you
use .long ?

So much for now. I skipped over a lot of code quite quickly and can't
comment on it yet. Hope I will find some more time tomorrow to review
these parts as well.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


