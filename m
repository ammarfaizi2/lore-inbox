Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWGGWW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWGGWW0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWGGWW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:22:26 -0400
Received: from relay00.pair.com ([209.68.5.9]:3081 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S932349AbWGGWWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:22:25 -0400
X-pair-Authenticated: 71.197.50.189
Date: Fri, 7 Jul 2006 17:22:22 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
cc: "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <20060708000531.410cd672@werewolf.auna.net>
Message-ID: <Pine.LNX.4.64.0607071718080.23767@turbotaz.ourhouse>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org>
 <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org>
 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu>
 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu>
 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
 <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
 <Pine.LNX.4.64.0607060856080.12404@g5.osdl.org> <Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
 <Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com> <m34pxt8emn.fsf@defiant.localdomain>
 <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com>
 <Pine.LNX.4.64.0607071318570.3869@g5.osdl.org> <Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com>
 <20060708000531.410cd672@werewolf.auna.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1455228556-1152310965=:23767"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1455228556-1152310965=:23767
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 8 Jul 2006, J.A. Magallón wrote:

> #include <stdint.h>
>
> //volatile
> uint32_t spinvar = 1;
> uint32_t mtx;
>
> void lock(uint32_t* l)
> {
>    *l = 1;
> }
>
> void unlock(uint32_t* l)
> {
>    *l = 0;
> }
>
> void spin()
> {
>    uint32_t local;
>
>    for (;;)
>    {
>        lock(&mtx);
>        local = spinvar;
>        unlock(&mtx);
>        if (!local)
>            break;
>    }
> }

This is _totally_ incorrect. Your "lock" functions are broken, because 
they do not introduce syncronization points or locked bus operations. Due 
to this huge failure, the compiler and/or processor is free to re-order 
your loads and stores, resulting in totally unpredictable runtime 
behavior.

> without the volatile:
>
> spin:
>    pushl   %ebp
>    movl    spinvar, %eax
>    movl    %esp, %ebp
>    testl   %eax, %eax
>    je  .L7
> .L10:
>    jmp .L10
> .L7:
>    movl    $0, mtx
>    popl    %ebp
>    ret
>
> so the compiler did something like
>
>   local = spinvar;
>   if (local)
> 	for (;;);
>
> (notice the dead lock/unlock inlined code elimination).

...which indicates that your code is wrong.

> With the volatile, the code is correct:
>
> spin:
>    pushl   %ebp
>    movl    %esp, %ebp
>    .p2align 4,,7
> .L7:
>    movl    spinvar, %eax
>    testl   %eax, %eax
>    jne .L7
>    movl    $0, mtx
>    popl    %ebp
>    ret

Actually, it's not. It's never setting "mtx" to 1, and it's certainly not 
doing any sync or locked ops.

> So think about all you inlined spinlocks, mutexes and so on.

Yes, you got it wrong, and the current code gets it right. (Linus's patch 
of =m to +m, combined with -volatile, is best)

> And if you do
>
> void lock(volatile uint32_t* l)
> ...
> void unlock(volatile uint32_t* l)
> ...
>
> the code is even better:
>
> spin:
>    pushl   %ebp
>    movl    %esp, %ebp
>    .p2align 4,,7
> .L7:
>    movl    $1, mtx    <=========
>    movl    spinvar, %eax
>    movl    $0, mtx    <=========
>    testl   %eax, %eax
>    jne .L7
>    popl    %ebp
>    ret

NO! It's not better. You're still not syncing or locking the bus! If you 
refer to the fact that the "movl $1" has magically appeared, that's 
because you've just PAPERED OVER THE PROBLEM WITH "volatile", which is 
_exactly_ what Linus is telling you NOT TO DO.

> So volatile just means 'dont trust this does not change even you don't see
> why'.
>

No.

Thanks,
Chase
--8323328-1455228556-1152310965=:23767--
