Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWJCDXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWJCDXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 23:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWJCDXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 23:23:05 -0400
Received: from xenotime.net ([66.160.160.81]:27013 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932275AbWJCDXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 23:23:02 -0400
Date: Mon, 2 Oct 2006 20:24:26 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2
Message-Id: <20061002202426.aa3ecb4f.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0610021932080.3952@g5.osdl.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	<p73venk2sjw.fsf@verdi.suse.de>
	<9a8748490609191414m6748f2fu521637df29ef9e8e@mail.gmail.com>
	<Pine.LNX.4.64.0609191453310.4388@g5.osdl.org>
	<20061002191638.093fde85.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0610021932080.3952@g5.osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006 19:34:27 -0700 (PDT) Linus Torvalds wrote:

> 
> 
> On Mon, 2 Oct 2006, Randy Dunlap wrote:
> > 
> > I had no trouble reproducing the boot failure (on Pentium-M), then
> > I tried TRACE_RESUME().  Nifty, but not really needed here since
> > earlyprintk worked and contained the fault messages:
> > 
> > [   16.841784] math_emulate: 0060:c01062dd
> > [   16.845579] Kernel panic - not syncing: Math emulation needed in kernel
> > 
> > But CONFIG_MATH_EMULATION=y, so what now?
> 
> The "Math emulation needed in kernel" message means that it was asked to 
> emulate a kernel instruction, and it refuses to do so. The emulation is 
> _not_ meant to be a real FPU, it simply looks like one to user space. A 
> lot of things aren't really emulated (there's no global x87 context, for 
> example: the context is all strictly per-process).
> 
> > Linus mentioned CPU feature bits.  The message log above didn't
> > make me feel good about them.  Sure enough, we are playing with
> > features before reading the feature bits.
> 
> Please look up address c01062dd in the system map (or just using gdb), 
> that will tell you what code _tried_ to use the math coprocessor in kernel 
> space.

Sure, it's in arch/i386/kernel/i387.c::mxcsr_feature_mask_init(),
on the fxsave instruction:

void mxcsr_feature_mask_init(void)
{
	unsigned long mask = 0;
	clts();
	if (cpu_has_fxsr) {
		memset(&current->thread.i387.fxsave, 0, sizeof(struct i387_fxsave_struct));
		asm volatile("fxsave %0" : : "m" (current->thread.i387.fxsave)); 
		mask = current->thread.i387.fxsave.mxcsr_mask;
		if (mask == 0) mask = 0x0000ffbf;
	}

---
~Randy
