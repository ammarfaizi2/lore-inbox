Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSHAS5A>; Thu, 1 Aug 2002 14:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316674AbSHAS5A>; Thu, 1 Aug 2002 14:57:00 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:7439 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S316614AbSHAS46>; Thu, 1 Aug 2002 14:56:58 -0400
Date: Thu, 1 Aug 2002 21:00:13 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Lars Schmitt <Lars.Schmitt@Physik.Tu-Muenchen.DE>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       <davem@redhat.com>
Subject: Re: Kernel panic on Dual Athlon MP 
In-Reply-To: <200208011224.g71COrW05657@pc02.e18.physik.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0208012031570.20284-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Because of his knowledge about this NIC I've included Dave Miller.

On Thu, 1 Aug 2002, Lars Schmitt wrote:

> Hello,
> 
> We are running a number of dual Athlon MP machines with Tyan Tiger MPX,
> 3ware RAID controllers and 3COM 3C996T GigE. These machines have serious
> stability problems and crash in particular when large file copies from 
> the RAID to the network are initiated.
> 
> I have been trying the following RH kernels:
> 
> - 2.4.9-31 with the bcm5700 driver
> - 2.4.18-3 with the tg3 driver
> 
> The result essentially is the same. It crashes with kernel panic -
> see the message appended below.
> 
Some deeper investigation shows that both drivers suffer from the same 
problem (terminology below is from tg3.c):

hw_idx and sw_idx differ when entering tg3_tx(), but there is no skb in 
the tx_buffer. In case of tg3 this triggers the BUG, part of which you 
find below (the rest had scrolled off the screen); the bcm5700 driver 
does not check this and fails upon pPacket->PacketStatus=0 in 
LM_ServiceTxInterrupt(), pPacket being NULL.

Is it possible that this is a hardware problem, possibly the NIC writing 
bogus values to tp->hw_status? Or is it a locking problem somewhere else? 
I'm not a kernel hacker, so I don't have the full picture. If there's 
information missing I would happily supply it, e.g. if you need the full 
dump of the hardware status or whatever; you would only have to tell me 
how to get this out of the machine.

Now here's the (partial) BUG message (tg3.c, line 1510): {the .LC13 is an
artifact, it's the address of the string "tg3.c" for do_BUG()}

EIP is at tg3_tx [tg3] 0x5e (2.4.18-3smp)
eax: 0000001a  ebx: f7832410  ecx: c02eb840  edx: 00005226
esi: 00000182  edi: 00000000  ebp: f2dc6560  esp: c0307f10
ds: 0018  es: 0018  ss: 0018
Stack: f8a531e4 000005e6 c0306000 00000186 c04e5000 f2dc6560 04000001 0000000b
f8a4c533 f2dc6560 f2dc6560 c04e5000 f8a4c5b4 f2dc6560 f7e2b900 00000000
c010a52e 0000000b f2dc6400 c0307f98 c0307f98 c0356ac0 0000000b 00000000
CallTrace: [<f8a531e4>] .LC13 [tg3] 0x0
[<f8a4c533>] tg3_interrupt_main_work [tg3] 0x53
[<f8a4c5b4>] tg3_interrupt [tg3] 0x44
[<c010a52e>] handle_IRQ_event [kernel] 0x5e
[<c010a734>] do_IRQ [kernel] 0xa4
[<c0106e70>] default_idle [kernel] 0x0
[<c0105000>] stext [kernel] 0x0
[<c0106e70>] default_idle [kernel] 0x0
[<c0105000>] stext [kernel] 0x0
[<c0106e9c>] default_idle [kernel] 0x2c
[<c0106ef4>] cpu_idle [kernel] 0x24
Code: 0f 0b 59 58 c7 03 00 00 00 00 8b 87 90 00 00 00 46 31 db eb
<6>Aieee, killing interrupt handler
In interrupt handler - not syncing

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

