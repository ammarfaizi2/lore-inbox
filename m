Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWGGWFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWGGWFn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWGGWFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:05:43 -0400
Received: from smtp.ono.com ([62.42.230.12]:34119 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S932341AbWGGWFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:05:42 -0400
Date: Sat, 8 Jul 2006 00:05:31 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       "Linus Torvalds" <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
Message-ID: <20060708000531.410cd672@werewolf.auna.net>
In-Reply-To: <Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com>
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
X-Mailer: Sylpheed-Claws 2.3.1cvs64 (GTK+ 2.10.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 17:22:31 -0400, "linux-os \(Dick Johnson\)" <linux-os@analogic.com> wrote:

> 
> On Fri, 7 Jul 2006, Linus Torvalds wrote:
> 
> >
> >
> > On Fri, 7 Jul 2006, linux-os (Dick Johnson) wrote:
> >>
> >> Now Linus declares that instead of declaring an object volatile
> >> so that it is actually accessed every time it is referenced, he wants
> >> to use a GNU-ism with assembly that tells the compiler to re-read
> >> __every__ variable existing im memory, instead of just one. Go figure!
> >
> > Actually, it's not just me.
> >
> > Read things like the Intel CPU documentation.
> >
> > IT IS ACTIVELY WRONG to busy-loop on a variable. It will make the CPU
> > potentially over-heat, causing degreaded performance, and you're simply
> > not supposed to do it.
> 
> This is a bait and switch argument. The code was displayed to show
> the compiler output, not an example of good coding practice.
> 

volatile means what it means, is usefull and is right. If it is used
in kernel for other things apart from what it was designed for it is
kernel or programmer responsibility. It does not mention nothing about
locking.

A more real example:

#include <stdint.h>

//volatile
uint32_t spinvar = 1;
uint32_t mtx;

void lock(uint32_t* l)
{   
    *l = 1;
}

void unlock(uint32_t* l)
{
    *l = 0;
}

void spin()
{
    uint32_t local;

    for (;;)
    {
        lock(&mtx);
        local = spinvar;
        unlock(&mtx);
        if (!local)
            break;
    }
}

without the volatile:

spin:
    pushl   %ebp
    movl    spinvar, %eax
    movl    %esp, %ebp
    testl   %eax, %eax
    je  .L7
.L10:
    jmp .L10
.L7:
    movl    $0, mtx
    popl    %ebp
    ret

so the compiler did something like

   local = spinvar;
   if (local)
	for (;;);

(notice the dead lock/unlock inlined code elimination).

With the volatile, the code is correct:

spin:
    pushl   %ebp
    movl    %esp, %ebp
    .p2align 4,,7
.L7:
    movl    spinvar, %eax
    testl   %eax, %eax
    jne .L7
    movl    $0, mtx
    popl    %ebp
    ret

So think about all you inlined spinlocks, mutexes and so on.

And if you do

void lock(volatile uint32_t* l)
...
void unlock(volatile uint32_t* l)
...

the code is even better:

spin:
    pushl   %ebp
    movl    %esp, %ebp
    .p2align 4,,7
.L7:
    movl    $1, mtx    <=========
    movl    spinvar, %eax
    movl    $0, mtx    <=========
    testl   %eax, %eax
    jne .L7
    popl    %ebp
    ret

So volatile just means 'dont trust this does not change even you don't see
why'.

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam01 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Wed
