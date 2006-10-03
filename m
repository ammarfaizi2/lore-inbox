Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWJCOzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWJCOzH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 10:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWJCOzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 10:55:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23733 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964786AbWJCOzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 10:55:05 -0400
Date: Tue, 3 Oct 2006 07:54:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Randy Dunlap <rdunlap@xenotime.net>, akpm <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2
In-Reply-To: <200610031205.24815.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0610030748261.3952@g5.osdl.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
 <Pine.LNX.4.64.0610021932080.3952@g5.osdl.org> <20061002202426.aa3ecb4f.rdunlap@xenotime.net>
 <200610031205.24815.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Oct 2006, Andi Kleen wrote:

>  
> > void mxcsr_feature_mask_init(void)
> > {
> > 	unsigned long mask = 0;
> > 	clts();
> > 	if (cpu_has_fxsr) {
> > 		memset(&current->thread.i387.fxsave, 0, sizeof(struct i387_fxsave_struct));
> > 		asm volatile("fxsave %0" : : "m" (current->thread.i387.fxsave)); 
> > 		mask = current->thread.i387.fxsave.mxcsr_mask;
> > 		if (mask == 0) mask = 0x0000ffbf;
> > 	}
> 
> This just needs an ifdef. I'll fix that thanks.

No, it doesn't need "an ifdef" at all.

There is no #define to even _test_. The fact that FPU math emulation is 
compiled in in _no_ way means that it should statically be used. It just 
means that if the user asks the math coprocessor to not be used, or if no 
such coprocessor exists, we shouldn't do an "fxsave".

The real fix is to clear "fxsr" when the user said "no387". If you don't 
have a math coprocessor, you sure as heck don't have fxsr either.

However, that's apparently not enough, since "nofxsr" was reported to not 
fix it entirely. However, that might well be true due to just handling 
that flag too late, or something.

And THAT is the real bug. Don't try to make it anything else. The bug is 
simply that we use the math coprocessor when we've been told it doesn't 
exist. 

			Linus
