Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbUATUpT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 15:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbUATUpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 15:45:19 -0500
Received: from gprs214-112.eurotel.cz ([160.218.214.112]:24194 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265780AbUATUpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 15:45:04 -0500
Date: Tue, 20 Jan 2004 21:44:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ncunningham@users.sourceforge.net, Hugang <hugang@soulinfo.com>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
Subject: Re: Help port swsusp to ppc.
Message-ID: <20040120204407.GA9749@elf.ucw.cz>
References: <20040119105237.62a43f65@localhost> <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux> <1074490463.10595.16.camel@gaston> <1074534964.2505.6.camel@laptop-linux> <1074549790.10595.55.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074549790.10595.55.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On Tue, 2004-01-20 at 00:39, Benjamin Herrenschmidt wrote:
> > > I see no reason why this would be needed on ppc, only the last step,
> > > that is the actual CPU state save, should matter.
> > 
> > Besides saving the CPU state, the code copies the original kernel back.
> > It sort of defeats the purpose to remove that code :>
> 
> Ok, you mean copying the memory pages back down ? That should be done
> with hand-made assembly or C code located specifically elsewhere then.
> I do not want to see any kind of this ugly C-generated assembly in
> arch/ppc.

FYI, this is that "ugly C-generated assembly" we are talking about. I
do not think it is so bad.

.text

/* Originally gcc generated, modified by hand */

#include <linux/linkage.h>
#include <asm/segment.h>
#include <asm/page.h>

	.text

ENTRY(do_magic)
	pushl %ebx
	cmpl $0,8(%esp)
	jne .L1450
	call do_magic_suspend_1
	call save_processor_state

	movl %esp, saved_context_esp
	movl %eax, saved_context_eax
	movl %ebx, saved_context_ebx
	movl %ecx, saved_context_ecx
	movl %edx, saved_context_edx
	movl %ebp, saved_context_ebp
	movl %esi, saved_context_esi
	movl %edi, saved_context_edi
	pushfl ; popl saved_context_eflags

	call do_magic_suspend_2
	jmp .L1449
	.p2align 4,,7
.L1450:
	movl $swapper_pg_dir-__PAGE_OFFSET,%ecx
	movl %ecx,%cr3

	call do_magic_resume_1
	movl $0,loop
	cmpl $0,nr_copy_pages
	je .L1453
	.p2align 4,,7
.L1455:
	movl $0,loop2
	.p2align 4,,7
.L1459:
	movl pagedir_nosave,%ecx
	movl loop,%eax
	movl loop2,%edx
	sall $4,%eax
	movl 4(%ecx,%eax),%ebx
	movl (%ecx,%eax),%eax
	movb (%edx,%eax),%al
	movb %al,(%edx,%ebx)
	movl %cr3, %eax;              
	movl %eax, %cr3;  # flush TLB 

	movl loop2,%eax
	leal 1(%eax),%edx
	movl %edx,loop2
	movl %edx,%eax
	cmpl $4095,%eax
	jbe .L1459
	movl loop,%eax
	leal 1(%eax),%edx
	movl %edx,loop
	movl %edx,%eax
	cmpl nr_copy_pages,%eax
	jb .L1455
	.p2align 4,,7
.L1453:
	movl $__USER_DS,%eax

	movw %ax, %ds
	movw %ax, %es
	movl saved_context_esp, %esp
	movl saved_context_ebp, %ebp
	movl saved_context_eax, %eax
	movl saved_context_ebx, %ebx
	movl saved_context_ecx, %ecx
	movl saved_context_edx, %edx
	movl saved_context_esi, %esi
	movl saved_context_edi, %edi
	call restore_processor_state
	pushl saved_context_eflags ; popfl
	call do_magic_resume_2
.L1449:
	popl %ebx
	ret

       .section .data.nosave
loop:
       .quad 0
loop2:
       .quad 0
       .previous


> > It is a well defined interface: a section of memory marked nosave, with
> > variables given the matching attribute. Not my idea, by the way. If you
> > have a problem, you should be taking it up with Pavel or Linus. We
> > should also note that the interface can't be too well defined - there
> > has to be room for development over time.
> 
> Still... That makes assumptions about how it's located and organised
> that plain wrong (c). Please get rid of that, at least I won't let a
> PPC

FYI, there are exactly 6 variables in "nosave" section. Two loop
variables you can see in above code, one spinlock, number of pages to
save, pointer to directory of pages to be copied, and its length.

I could probably move spinlock and length of pgdir out of there...

> > Yes. we device_suspend. Regarding the similarities with kexec, I fully
> > agree. In fact, there is also LKCD to think off. There should be a
> > synergy here.
> 
> device_suspend is, imho, hairy too. We have some semantics that need
> cleanup here, I'll have to talk to Patrick about them. Putting devices
> to an idle state is what you need and what kexec need, and doesn't mean
> putting them to _sleep_. Or maybe we could pass a specific state to

Okay, I can agree that putting them into sleep is not ideal [it
puzzles users, at least]. But it is quite simple and should work
okay. I do not want another round of device_suspend changes in
2.6.X... [Well, perhaps if it was done in right&compatible way (tm),
it would be acceptable...]
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
