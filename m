Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269017AbUIXVo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269017AbUIXVo3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 17:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269015AbUIXVoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 17:44:01 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:7809 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S269013AbUIXVne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 17:43:34 -0400
Date: Fri, 24 Sep 2004 23:43:30 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
Message-ID: <20040924214330.GD8151@vana.vc.cvut.cz>
References: <3BFF2F87096@vcnet.vc.cvut.cz> <414C662D.5090607@aknet.ru> <20040918165932.GA15570@vana.vc.cvut.cz> <414C8924.1070701@aknet.ru> <20040918203529.GA4447@vana.vc.cvut.cz> <4151C949.1080807@aknet.ru> <20040922200228.GB11017@vana.vc.cvut.cz> <41530326.2050900@aknet.ru> <20040923180607.GA20678@vana.vc.cvut.cz> <4154853F.6070105@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4154853F.6070105@aknet.ru>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 12:36:15AM +0400, Stas Sergeev wrote:
> Hi,
> 
> Petr Vandrovec wrote:
> >In that new patch I set the const to 0xe00, which
> >is 3,5K. Is it still the limitation? I can probably
> >For 4KB stacks 2KB looks better
> OK, done that. Wondering though, for what?
> I don't need 2K myself, I need 24 bytes only.
> So what prevents me to raise the gap to 3.5K
> or somesuch? Why 2K looks better?

You run with ESP decreased by 2KB for some time during
CPL1 stack setup.  As you run in this part at CPL0
with same setup as on CPL1, I think that you should
offer same stack for setup code, and for CPL1 code,
and so each should get 2KB.

> >>+8:	subl $(NMI_STACK_RESERVE-4), %esp; \
> >>+	.rept 5; \
> >Any reason why you left this part of RESTORE_ALL macro?
> The reason is that the previous part of the macro
> can jump to that part. So how can I divide those?

Use real labels instead of numeric local labels.  That way
macro does jne cpl1exit, and you create cpl1exit: label outside
of macro, somewhere in entry.S...
 
> >be moved out, IMHO.  RESTORE_ALL is used twice in entry.S, so you
> >could save one copy.
> Do you mean the NMI return path doesn't need
> the ESP fix at all? Why?

No.  I was attempting to say that RESTORE_ALL is on two
places to save jumps (I cannot think about any other reason),
and so cpl1exit could be shared:

#define RESTORE_ALL \
	movl EFLAGS(%esp),%eax	\
	....			\
	jne 3f			\
	lar OLDSS(%esp),%eax	\
	testl $0x00400000,%eax	\
	jz cpl1exit		\
3:	RESTORE_REGS		\
	add $4,%esp		\
1:	iret			\
.section __ex_table,"a";\
	.align 4;	\
	long 1b,badss;	\
.previous


badss:	sti;		
	movl $(__USER_DS), %edx; 
	movl %edx, %ds; 
	movl %edx, %es;
	pushl $11;
	call do_exit;

cpl1exit:
	RESTORE_REGS
	subl $...,%esp
	...

But your solution with killing RESTORE_ALL completely is also
fine - you just could reorder jumps a bit, so return to kernel
or VM86 is one (not taken) jump shorter than it is with current
version of patch.

> >Though I'm not sure why NMI handler simple
> >does not jump to RESTORE_ALL we already have.
> I can only change that and then un-macro the
> RESTORE_ALL completely. So I did that.
> Additionally I introduced the "short path"
> for the case where we know for sure that we
> are returning to the kernel. And I am not
> setting the exception handler there because
> returning to the kernel if fails, should die()
> anyway. Is this correct?

If you'll first test result of lar, and then
you'll do two independent RESTORE_REGS (second
one actually does not have to restore %ebp
and %eax and you can restore them directly by
move from stack after you are done with trampoline
setup, instead of doing push + pop), you can reuse
RESOTRE_REGS+add $4,%esp+iret return path, including
its exception handling.

> +ENTRY(espfix_trampoline)
> +	popl %esp
> +espfix_past_esp:
> +1:	iret
> +.section .fixup,"ax"
> +2:	sti
> +	movl $(__USER_DS), %edx
> +	movl %edx, %ds
> +	movl %edx, %es
> +	pushl $11
> +	call do_exit
> +.previous

You can reuse fixup code from other iret instance,
just give it real label and reference it from __ex_table
instead of '2b'.

Patch looks fine, though you could speedup it a bit as outlined above.
Now you have to persuade others that this patch should include patch
into the kernel.
								Petr

