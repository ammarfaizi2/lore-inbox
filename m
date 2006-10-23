Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWJWWSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWJWWSx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 18:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWJWWSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 18:18:53 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:54212 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932160AbWJWWSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 18:18:52 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 8/13] KVM: vcpu execution loop
Date: Tue, 24 Oct 2006 00:18:54 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <453CC390.9080508@qumranet.com> <200610232229.41934.arnd@arndb.de> <453D27F8.8020509@qumranet.com>
In-Reply-To: <453D27F8.8020509@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610240018.55100.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 22:37, Avi Kivity wrote:
> Arnd Bergmann wrote:
> > On Monday 23 October 2006 22:16, Avi Kivity wrote:
> >>> This looks like you should simply put it into a .S file.
> >>
> >> Then I lose all the offsetof constants down the line.  Sure, I could do
> >> the asm-offsets dance but it seems to me like needless obfuscation.
> >
> > Ok, I see.
> >
> > How if you pass &vcpu->regs and &vcpu->cr2 to the functions instead of
> > kvm_vcpu?
>
> I could do that, but I feel that's more brittle.  I might need more (or
> other) fields later on.  It will also cost me more  pushes on the stack
> (no real performance or space impact, just C64-era frugality).

Maybe you could save some more stack usage by doing something like this:

static inline void vmlaunch(struct kvm_vcpu *vcpu)
{
	register unsigned long rax asm("rax");
	register unsigned long rbx asm("rbx");
	register unsigned long rcx asm("rcx");
	register unsigned long rdx asm("rdx");
	register unsigned long rsi asm("rsi");
	register unsigned long rdi asm("rdi");
	register unsigned long rbp asm("rbp");
	register unsigned long r8  asm("r8");
	register unsigned long r9  asm("r9");
	register unsigned long r10 asm("r10");
	register unsigned long r11 asm("r11");
	register unsigned long r12 asm("r12");
	register unsigned long r13 asm("r13");
	register unsigned long r14 asm("r14");
	register unsigned long r15 asm("r15");

	asm ("mov %%cr2, %0" : : "r" (vcpu->cr2));

	rax = vcpu->regs[VCPU_REGS_RAX];
	rbx = vcpu->regs[VCPU_REGS_RBX];
	rcx = vcpu->regs[VCPU_REGS_RCX];
	rdx = vcpu->regs[VCPU_REGS_RDX];
	rsi = vcpu->regs[VCPU_REGS_RSI];
	rdi = vcpu->regs[VCPU_REGS_RDI];
	rbp = vcpu->regs[VCPU_REGS_RBP];
	r8  = vcpu->regs[VCPU_REGS_R8 ];
	r9  = vcpu->regs[VCPU_REGS_R9 ];
	r10 = vcpu->regs[VCPU_REGS_R10];
	r11 = vcpu->regs[VCPU_REGS_R11];
	r12 = vcpu->regs[VCPU_REGS_R12];
	r13 = vcpu->regs[VCPU_REGS_R13];
	r14 = vcpu->regs[VCPU_REGS_R14];
	r15 = vcpu->regs[VCPU_REGS_R15];

	asm ("vmlaunch\n\t" :
		"+r" (rax),
		"+r" (rbx),
		"+r" (rcx),
		"+r" (rdx),
		"+r" (rsi),
		"+r" (rdi),
		"+r" (rbp),
		"+r" (r8),
		"+r" (r9),
		"+r" (r10),
		"+r" (r11),
		"+r" (r12),
		"+r" (r13),
		"+r" (r14),
		"+r" (r15)
	);

	vcpu->regs[VCPU_REGS_RAX] = rax;
	vcpu->regs[VCPU_REGS_RBX] = rbx;
	vcpu->regs[VCPU_REGS_RCX] = rcx;
	vcpu->regs[VCPU_REGS_RDX] = rdx;
	vcpu->regs[VCPU_REGS_RSI] = rsi;
	vcpu->regs[VCPU_REGS_RDI] = rdi;
	vcpu->regs[VCPU_REGS_RBP] = rbp;
	vcpu->regs[VCPU_REGS_R8 ] = r8 ;
	vcpu->regs[VCPU_REGS_R9 ] = r9 ;
	vcpu->regs[VCPU_REGS_R10] = r10;
	vcpu->regs[VCPU_REGS_R11] = r11;
	vcpu->regs[VCPU_REGS_R12] = r12;
	vcpu->regs[VCPU_REGS_R13] = r13;
	vcpu->regs[VCPU_REGS_R14] = r14;
	vcpu->regs[VCPU_REGS_R15] = r15;

	asm ("mov %0, %%cr2" : "=r" (vcpu->cr2));
}

Unfortunately, I couldn't get this to do the right thing with the output
flags. Unless I missed something, your solution is really the best one you
can express in gcc.

	Arnd <><
