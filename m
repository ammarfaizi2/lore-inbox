Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWGFT4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWGFT4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWGFT4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:56:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25835 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750789AbWGFT4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:56:17 -0400
Date: Thu, 6 Jul 2006 12:56:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <20060706081639.GA24179@elte.hu>
Message-ID: <Pine.LNX.4.64.0607061237300.3869@g5.osdl.org>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org>
 <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org>
 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu>
 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu>
 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
 <20060706081639.GA24179@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jul 2006, Ingo Molnar wrote:
> 
> yeah. I tried this and it indeed slashed 42K off text size (0.2%):
> 
>  text            data    bss     dec             filename
>  20779489        6073834 3075176 29928499        vmlinux.volatile
>  20736884        6073834 3075176 29885894        vmlinux.non-volatile
> 
> i booted the resulting allyesconfig bzImage and everything seems to be 
> working fine. Find patch below.

Ok, the patch itself looks fine, but looking at some of the usage of the 
spinlocks, I worry that the 'volatile' may actually have hidden a real 
bug.

Here's what __raw_spin_lock() looks like on x86:

        alternative_smp(
                __raw_spin_lock_string,
                __raw_spin_lock_string_up,
                "=m" (lock->slock) : : "memory");

where the actual spinlock sequence itself isn't important.

What's important is what we tell the compiler, and the "=m" in particular.

The compiler will validly think that the spinlock assembly wil overwrite 
the "slock" location _WITHOUT_ caring about the old value. 

And that's dangerous, because it means that in theory a sequence like

	spin_lock_init(&lock);
	spin_lock(&lock);

might end up having the compiler optimize away the "unnecessary" 
initialization code because the compiler (correctly, as far as we've told 
it) thinks that the spin_lock() will overwrite the initial value.

And the "volatile" would have hidden that bug, for totally stupid and 
unrelated reasons..

Now, admittedly, the above kind of code is insane, and possibly doesn't 
exist, but still..

So I _think_ that we should change the "=m" to the much more correct "+m" 
at the same time (or before - it's really a bug-fix regardless) as 
removing the "volatile".

It would be interesting to hear whether that actually changes any code 
generation (hopefully it doesn't, but if it does, that in itself is 
interesting).

Btw, grepping for "=m" shows that semaphores may have the same bug, and in 
fact, we seem to have that "volatile" there too (perhaps, in fact, because 
somebody hit the bug and decided to fix it the simple way with "volatile"? 
Who knows, it might even have been me, back before I realized how badly 
gcc messes up volatiles)

Interestingly (or perhaps not), "atomic_add()" and friends (along with the 
local_t stuff that seems to largely have been copied from the atomic code) 
use a combination of "=m" and "m" in the assembler dst/src to avoid the 
bug. They too would probably be better off using "+m".

I think that's because the whole "+m" thing is fairly new (and not well 
documented either).

Appended is my previous test-program extended to show the difference 
between "=m" and "+m"..

For me, I get:

	horrid:
	        subl    $16, %esp
	        movl    $1, 12(%esp)
	        movl    12(%esp), %eax
	        movl    %eax, a1
	        movl    $1, b1
	#APP
	        # overwrite a1
	        # modify b1
	#NO_APP
	        addl    $16, %esp
	        ret

	notbad:
	        movl    $1, b2
	#APP
	        # overwrite a2
	        # modify b2
	#NO_APP
	        ret

which shows that "horrid" (with volatile) generates truly crapola code due 
to the volatile, but that the "overwrite a1" will not optimize away the 
initializer.

And "notbad" has good code, but exactly because it's good code, the 
compiler has also noticed that the "=m" means that the initialization of 
"a2" is unnecessary, and has thus promptly removed it.

(Removing the initializer is _correct_ for that particular source code - 
it's just that with the current x86 spinlock() macros, it would be 
disastrous, and shows that your "just remove volatile" patch is dangerous 
because of our incorrect inline assembly)

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
	asm("# overwrite %0":"=m" (a1.i));
	asm("# modify %0":"+m" (b1.i));
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
	asm("# overwrite %0":"=m" (a2.i));
	asm("# modify %0":"+m" (b2.i));
}
