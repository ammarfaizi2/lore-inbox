Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318737AbSHAN2z>; Thu, 1 Aug 2002 09:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318739AbSHAN2z>; Thu, 1 Aug 2002 09:28:55 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:2573 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S318737AbSHAN2x>;
	Thu, 1 Aug 2002 09:28:53 -0400
Date: Thu, 1 Aug 2002 15:32:02 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PANIC] APM bug with -rc4 and -rc5
Message-ID: <20020801133202.GA200@pcw.home.local>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva> <20020801121205.GA168@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020801121205.GA168@pcw.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

I've narrowed down the APM problem encountered in -rc5. In fact, it also
affects -rc4, but not -rc3. I'm a bit stumped since the changes are not
too heavy...

The crash happens at the same place with -rc4 and -rc5 : 0xc0120d0c

c0120cec:       fb                      sti
c0120ced:       bb 40 a2 39 c0          mov    $0xc039a240,%ebx
c0120cf2:       f7 c6 01 00 00 00       test   $0x1,%esi
c0120cf8:       74 08                   je     c0120d02 <do_softirq+0x72>
c0120cfa:       53                      push   %ebx
c0120cfb:       8b 03                   mov    (%ebx),%eax
c0120cfd:       ff d0                   call   *%eax
c0120cff:       83 c4 04                add    $0x4,%esp
c0120d02:       83 c3 08                add    $0x8,%ebx
c0120d05:       d1 ee                   shr    %esi
c0120d07:       75 e9                   jne    c0120cf2 <do_softirq+0x62>
c0120d09:       fa                      cli
c0120d0a:       8b b5 80 17 3c c0       mov    0xc03c1780(%ebp),%esi
                      ^^ ^^ ^^ ^^
The processor branches here (2 bytes after  local_irq_disable()) !!

c0120d10:       85 fe                   test   %edi,%esi
c0120d12:       74 0c                   je     c0120d20 <do_softirq+0x90>
c0120d14:       89 f0                   mov    %esi,%eax
c0120d16:       f7 d0                   not    %eax
c0120d18:       21 c7                   and    %eax,%edi
c0120d1a:       eb c6                   jmp    c0120ce2 <do_softirq+0x52>

This code is from do_softirq() in kernel/softirq.c, lines 84-95 :

                local_irq_enable();

                h = softirq_vec;

                do {
                        if (pending & 1)
                                h->action(h);
                        h++;
                        pending >>= 1;
                } while (pending);

                local_irq_disable();

The hand-written traces show that this function was correctly called by
ksoftirqd(), which in turn was called by kernel_thread().

Part of the hand-written oops shows :
EFLAGS=00010057
eax=00000900 ebx=c039a260 ecx=00000000 edx=c0390000
esi=00000000 edi=fffffff7 ebp=00000000 esp=c15b1fc8

Since softirq_vec is c039a240 in my System.map, I can deduce that h->action(h)
has been called 4 times because it's 8 bytes long. <pending> is represented
by %esi here, which is null. So this implies that it's not the call to h->action(h)
which branched to this place. But int this case, I don't see how the CPU
can branch here (a ret prehaps ?). I don't see in what this can be related to
the "apm=power-off" case either.


Alan, I believe you have the same mobo, but with two MPs on it. Although I've
never had any SMP problem with XPs, did you notice anything strange with APM
on 2.4.19-rc[45] ? I will check 2.4.19-rc3-ac5 to see if it hangs too...

Cheers,
Willy

> Marcelo,
> 
> I observe a kernel panic at boot time if I set apm=power-off. OK with apm=off.
> This is on an ASUS A7M266D with two Athlon XP 1800+. Since it works well on
> 2.4.19-pre10, I'm recompiling intermediate versions to check which one brought
> the problem.
> 
> This is rather strange, since the crash occurs in do_softirq, but 2 bytes after
> the beginning of an instruction :
> c0120d09 fa			cli
> c0120d0a 8b b5 80 17 3c c0	mov 0xc03c1780(%ebp),%esi
> 
> The crash occurs at c0120d0c (80 17 3c c0 ...). Seems like a bad pointer
> somewhere.

