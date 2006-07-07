Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWGGWiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWGGWiG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWGGWiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:38:06 -0400
Received: from smtp.ono.com ([62.42.230.12]:42704 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S932360AbWGGWiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:38:04 -0400
Date: Sat, 8 Jul 2006 00:37:49 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Chase Venters <chase.venters@clientec.com>
Cc: "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
Message-ID: <20060708003749.053d8875@werewolf.auna.net>
In-Reply-To: <Pine.LNX.4.64.0607071718080.23767@turbotaz.ourhouse>
References: <20060705114630.GA3134@elte.hu>
	<20060705101059.66a762bf.akpm@osdl.org>
	<20060705193551.GA13070@elte.hu>
	<20060705131824.52fa20ec.akpm@osdl.org>
	<Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
	<20060705204727.GA16615@elte.hu>
	<Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
	<20060705214502.GA27597@elte.hu>
	<Pine.LNX.4.64.0607051458200.12404@g5.osdl.org>
	<Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
	<20060706081639.GA24179@elte.hu>
	<Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
	<Pine.LNX.4.64.0607060856080.12404@g5.osdl.org>
	<Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
	<Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com>
	<m34pxt8emn.fsf@defiant.localdomain>
	<Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com>
	<Pine.LNX.4.64.0607071318570.3869@g5.osdl.org>
	<Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com>
	<20060708000531.410cd672@werewolf.auna.net>
	<Pine.LNX.4.64.0607071718080.23767@turbotaz.ourhouse>
X-Mailer: Sylpheed-Claws 2.3.1cvs68 (GTK+ 2.10.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 17:22:22 -0500 (CDT), Chase Venters <chase.venters@clientec.com> wrote:

> On Sat, 8 Jul 2006, J.A. Magallón wrote:
> 
> > #include <stdint.h>
> >
> > //volatile
> > uint32_t spinvar = 1;
> > uint32_t mtx;
> >
> > void lock(uint32_t* l)
> > {
> >    *l = 1;
> > }
> >
> > void unlock(uint32_t* l)
> > {
> >    *l = 0;
> > }
> >
> > void spin()
> > {
> >    uint32_t local;
> >
> >    for (;;)
> >    {
> >        lock(&mtx);
> >        local = spinvar;
> >        unlock(&mtx);
> >        if (!local)
> >            break;
> >    }
> > }
> 
> This is _totally_ incorrect. Your "lock" functions are broken, because 
> they do not introduce syncronization points or locked bus operations. 

But why should I do that ? I write C, a high level language, and I don't
mind about buses or whatever. I just have to know that a 32 bit store is
atomic in a 32bit arch. There is a nice high level and portable language
feature to say 'reload this variable here'. And it lets the compiler do its
optimization work as it best can asuming it has to reload that variable.
Instead, you prefer to lock all the bus for that.
Kernel developers spent a full release to get rid of
the 'big kernel lock'. Perhaps there is another release needed to get
rid of the 'big memory barrier'.

> Due 
> to this huge failure, the compiler and/or processor is free to re-order 
> your loads and stores, resulting in totally unpredictable runtime 
> behavior.

Nope. If I want it not to reorder, put the volatile in the parameters.
So I just invalidate that variable, not everything.

> 
> > without the volatile:
> >
> > spin:
> >    pushl   %ebp
> >    movl    spinvar, %eax
> >    movl    %esp, %ebp
> >    testl   %eax, %eax
> >    je  .L7
> > .L10:
> >    jmp .L10
> > .L7:
> >    movl    $0, mtx
> >    popl    %ebp
> >    ret
> >
> > so the compiler did something like
> >
> >   local = spinvar;
> >   if (local)
> > 	for (;;);
> >
> > (notice the dead lock/unlock inlined code elimination).
> 
> ...which indicates that your code is wrong.

My code probably is wrong without the volatile, but the compiler did the
right(tm) thing.

> 
> > With the volatile, the code is correct:
> >
> > spin:
> >    pushl   %ebp
> >    movl    %esp, %ebp
> >    .p2align 4,,7
> > .L7:
> >    movl    spinvar, %eax
> >    testl   %eax, %eax
> >    jne .L7
> >    movl    $0, mtx
> >    popl    %ebp
> >    ret
> 
> Actually, it's not. It's never setting "mtx" to 1,

What is correct regarding the code I gave it.
Inlined code is:

    for (;;)
    {
        mtx = 1;
        local = spinvar;
        mtx = 0;
        if (!local)
            break;
    }

I just change mtx and don't use it for anything. So the compiler is free to
optimize out it.
If I don't want the compiler to kill it, I put the volatile.

> and it's certainly not 
> doing any sync or locked ops.
> 
> > So think about all you inlined spinlocks, mutexes and so on.
> 
> Yes, you got it wrong, and the current code gets it right. (Linus's patch 
> of =m to +m, combined with -volatile, is best)

Nope, I did the same thing with a high level and portable way.
Its like the choice between writing inlined SSE assembler or using the
vector and +,-,* builtins in gcc.

> 
> > And if you do
> >
> > void lock(volatile uint32_t* l)
> > ...
> > void unlock(volatile uint32_t* l)
> > ...
> >
> > the code is even better:
> >
> > spin:
> >    pushl   %ebp
> >    movl    %esp, %ebp
> >    .p2align 4,,7
> > .L7:
> >    movl    $1, mtx    <=========
> >    movl    spinvar, %eax
> >    movl    $0, mtx    <=========
> >    testl   %eax, %eax
> >    jne .L7
> >    popl    %ebp
> >    ret
> 
> NO! It's not better. You're still not syncing or locking the bus! If you 
> refer to the fact that the "movl $1" has magically appeared, that's 
> because you've just PAPERED OVER THE PROBLEM WITH "volatile", which is 
> _exactly_ what Linus is telling you NOT TO DO.
> 
> > So volatile just means 'dont trust this does not change even you don't see
> > why'.
> >
> 
> No.
> 
> Thanks,
> Chase


--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam01 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Wed
