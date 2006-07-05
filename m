Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWGEXL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWGEXL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 19:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWGEXL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 19:11:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5053 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964787AbWGEXL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 19:11:27 -0400
Date: Wed, 5 Jul 2006 16:11:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
In-Reply-To: <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
References: <20060705025349.eb88b237.akpm@osdl.org> <20060705102633.GA17975@elte.hu>
 <20060705113054.GA30919@elte.hu> <20060705114630.GA3134@elte.hu>
 <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu>
 <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
 <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
 <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Jul 2006, Linus Torvalds wrote:
> > 
> >  c0fb6137:       c7 44 24 08 00 00 00    movl   $0x0,0x8(%esp)
> >  c0fb613e:       00
> >  c0fb613f:       c7 44 24 08 01 00 00    movl   $0x1,0x8(%esp)
> >  c0fb6146:       00
> >  c0fb6147:       c7 43 60 00 00 00 00    movl   $0x0,0x60(%ebx)
> >  c0fb614e:       8b 44 24 08             mov    0x8(%esp),%eax
> >  c0fb6152:       89 43 5c                mov    %eax,0x5c(%ebx)

Btw, this is even worse than usual.

I've seen the "create struct on the stack and copy it" before, but looking 
closer, this is doing something I haven't noticed before: that double 
assignment to the stack is _really_ strange.

I wonder why it first stores a zero to the stack location, and then 
overwrites it with the proper spinlock initialized (one).

As far as I can tell, the spinlock initializer should really end up being 
a perfectly normal "(struct spinlock_t) { 1 }", and I don't see where the 
zero comes from.

It may actually be that we're double penalized because for the lock 
"counter", we use a "volatile unsigned int", and that "0" is from some 
internal gcc "initialize all base structures to zero" to make sure that 
any padding gets zeroed, and then the "volatile" means that gcc ends up 
not optimizing it away, even though it was a totally bogus store that 
didn't even exist in the sources.

I wonder if we should remove the "volatile". There really isn't anything 
_good_ that gcc can do with it, but we've seen gcc code generation do 
stupid things before just because "volatile" seems to just disable even 
proper normal working.

[ Test-case built as time passes ]

Try compiling this example file with "-fomit-frame-pointer -O2 -S" to see 
the effect:

	horrid:
	        subl    $16, %esp
	        movl    $1, 12(%esp)
	        movl    12(%esp), %eax
	        movl    %eax, a1
	        movl    $1, b1
	        addl    $16, %esp
	        ret

	notbad:
	        movl    $1, a2
	        movl    $1, b2
	        ret


I really think that "volatile" in the kernel sources is _always_ a kernel 
bug. It certainly seems to be so in this case.

(But at least with the compiler version I'm using, I'm not seeing that 
extra unnecessary "movl $0" - I have gcc version 4.1.1 here)

Does removing just the "volatile" on the "slock" member shrink the size of 
the kernel noticeably? And do you see an extra "movl $0" in this case with 
your compiler version?

Maybe removing the volatile allows us to keep the initializer the way it 
is (although going by past behaviour, I've seen gcc generate horrible code 
in more complicated settings, so maybe the reason it works well on this 
case without the "volatile" is just that it was simple enough that gcc 
wouldn't mess up?)

		Linus
---
struct duh {
	volatile int i;
};

void horrid(void)
{
	extern struct duh a1;
	extern struct duh b1;

	a1 = (struct duh) { 1 };
	b1.i = 1;
}

struct gaah {
	int i;
};

void notbad(void)
{
	extern struct gaah a2;
	extern struct gaah b2;

	a2 = (struct gaah) { 1 };
	b2.i = 1;
}
