Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWIRXtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWIRXtj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 19:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWIRXtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 19:49:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3543 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030272AbWIRXti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 19:49:38 -0400
Date: Mon, 18 Sep 2006 16:49:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       billm@melbpc.org.au, billm@suburbia.net
Subject: Re: Math-emu kills the kernel on Athlon64 X2
In-Reply-To: <9a8748490609181614r55178f1djab68eb48bd36f7de@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609181642200.4388@g5.osdl.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com> 
 <Pine.LNX.4.64.0609181549200.4388@g5.osdl.org>
 <9a8748490609181614r55178f1djab68eb48bd36f7de@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Sep 2006, Jesper Juhl wrote:
> On 19/09/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > Basically, "no387" doesn't seem to disable any of the fancier FPU
> > features, even though it obviously should. If you ask for math emulation,
> > you'll get emulation faults for _all_ of the modern MMX stuff too (which
> > we don't do).
> > 
> Hmm, I guess that could be the problem. The emulator should disable
> any stuff which it's not able to handle. I've not actually looked very
> much at the emulator code yet, so I didn't realize it didn't disable
> what it couldn't handle, but getting it to do that sounds like a
> sensible first step.

I would guess that we might notice, for example, that the CPU supports 
FXSR (fxsave/fxrestor) through looking at cpuid, and then we have, for 
example:

    arch/i386/kernel/cpu/common.c: cpu_init() ->
	arch/i386/kernel/i387.c: mxcsr_feature_mask_init() ->


        if (cpu_has_fxsr) {
                memset(&current->thread.i387.fxsave, 0, sizeof(struct i387_fxsave_struct));
                asm volatile("fxsave %0" : : "m" (current->thread.i387.fxsave));
		...

ie we will do one of the fancy new instructions from kernel space (very 
early), because this path at no point even bothers to check whether it is 
supposed to even use hw FP at all.

You can try booting with "no387 nofxsr" to get rid of at least _that_ 
particular issue, but there might be other cases like that in the MMX 
code, for example ("nofxsr" should disable both the FXSR and XMM 
capabilities as far as the kernel is concerned).

If that works (or gets you further), we should just make "no387" disable 
FXSR by itself. 

Worth testing, and you can do it without even recompiling the kernel, 
since we already have that kernel command line flag.

		Linus
