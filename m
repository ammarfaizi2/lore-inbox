Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUJTT5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUJTT5D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270548AbUJTT5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:57:01 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:58121 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268907AbUJTT4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:56:05 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: [PATCH] Make netif_rx_ni preempt-safe
Date: Wed, 20 Oct 2004 22:55:56 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <1098230132.23628.28.camel@krustophenia.net> <1098231737.23628.42.camel@krustophenia.net> <200410201811.44419.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410201811.44419.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410202255.56304.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> #include <linux/netdevice.h>
> 
> int netif_rx_ni_(struct sk_buff *skb)
> {
>     int err;
>     preempt_disable();
>     err = netif_rx(skb);
>     if (softirq_pending(smp_processor_id()))
>         do_softirq();
>     preempt_enable();
>     return err;
> }
> 
> objdump -d:
> 00000000 <netif_rx_ni_>:
>    0:   55                      push   %ebp

BTW, I once got an email which claimed that compilers
optimize code better than humans. Aha... here it is:

On Sunday 11 April 2004 23:58, J. Ryan Earl wrote:
>I doubt you would be capable of generating assembly that would be any
>faster than gcc

Let's take this code as a "random example". Code is not bad per se,
but it can be made smaller _without_ sacrificing speed.

(Before someone says it - I don't buy the arguments like "push(mem)
is microcoded - it is slower, use mov+push(reg)". Yes, it is *maybe*
slower. On your today's CPU. Will it be slower on tomorrow's one?
I doubt it. Specifically, on Athlon it was a VectorPath insn.
On Athlon64 it is a Double => equivalent to mov+push(reg).
But it takes less icache on each and every CPU from 486 upwards.
Doesn't this "optimization" looks silly on Athlon64?)

> objdump -d:
> 00000000 <netif_rx_ni_>:
>    0:   55                      push   %ebp
>    1:   89 e5                   mov    %esp,%ebp
>    3:   56                      push   %esi
>    4:   53                      push   %ebx
>    5:   bb 00 f0 ff ff          mov    $0xfffff000,%ebx
>    a:   21 e3                   and    %esp,%ebx
>    c:   ff 43 14                incl   0x14(%ebx)
>    f:   8b 4d 08                mov    0x8(%ebp),%ecx
>   12:   51                      push   %ecx

	replace: mov+push => push 0x8(%ebp)

>   13:   e8 fc ff ff ff          call   14 <netif_rx_ni_+0x14>
>   18:   89 c6                   mov    %eax,%esi
>   1a:   8b 43 10                mov    0x10(%ebx),%eax
>   1d:   c1 e0 07                shl    $0x7,%eax
>   20:   8b 80 00 00 00 00       mov    0x0(%eax),%eax
>   26:   85 c0                   test   %eax,%eax

	mov+test => cmp 0x0(%eax),0
	(side note: 0x0 is not a 0, it's a reloc...)

>   28:   5a                      pop    %edx
>   29:   75 25                   jne    50 <netif_rx_ni_+0x50>
>   2b:   8b 43 08                mov    0x8(%ebx),%eax
>   2e:   ff 4b 14                decl   0x14(%ebx)
>   31:   a8 08                   test   $0x8,%al

	mov+test => test 0x8(%ebx),$0x8

>   33:   75 09                   jne    3e <netif_rx_ni_+0x3e>
>   35:   8d 65 f8                lea    0xfffffff8(%ebp),%esp
>   38:   5b                      pop    %ebx
>   39:   89 f0                   mov    %esi,%eax
>   3b:   5e                      pop    %esi
>   3c:   5d                      pop    %ebp
>   3d:   c3                      ret
>   3e:   e8 fc ff ff ff          call   3f <netif_rx_ni_+0x3f>
>   43:   eb f0                   jmp    35 <netif_rx_ni_+0x35>
>   45:   8d 74 26 00             lea    0x0(%esi,1),%esi
>   49:   8d bc 27 00 00 00 00    lea    0x0(%edi,1),%edi

	padding is larger that code it aligns! Zero gain in speed,
	11 bytes wasted. >8(

>   50:   e8 fc ff ff ff          call   51 <netif_rx_ni_+0x51>
>   55:   eb d4                   jmp    2b <netif_rx_ni_+0x2b>
--
vda

