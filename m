Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286297AbSAIMnO>; Wed, 9 Jan 2002 07:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286322AbSAIMm4>; Wed, 9 Jan 2002 07:42:56 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:18955 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S286297AbSAIMmj>;
	Wed, 9 Jan 2002 07:42:39 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: cw@f00f.org
Date: Wed, 9 Jan 2002 13:41:38 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: "APIC error on CPUx" - what does this mean?
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, swsnyder@home.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        macro@ds2.pg.gda.pl
X-mailer: Pegasus Mail v3.40
Message-ID: <E67476B613D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Jan 02 at 18:35, I wrote:
> 
> As spurious IRQ happens during HLT, and IRR is clear at the time
> we are going to ack IRQ, it looks like real spurious IRQ (caused by
> noise?). Or delay between spurious one and real IRQ is really long. 
> I'll try some of your suggestions today night.

Hm, I'm missing something :-( It happens 4.9us after another IRQ
arrives on 8259 master, or ~100us after another IRQ arrives on slave.
Spurious IRQs do not happen when ELCR registers are cleared; unfortunately
Promise cannot live with edge trigerred interrupts.
IRQ1 is keyboard, IRQ5 es1371 and IRQ10 promise. I was able to get
spurious IRQ after either of these IRQs. I was not able to trigger
spurious IRQ from RTC irq, but maybe that I did not tried hard enough.

I have no idea why it happens 5us when IRQ arrives to master, but
100us when IRQ arrives to slave. And to make it even less clean,
when I replaced outb(xx, 0xA1) and outb(xx, 0x21) with outb_p,
spurious IRQ happens 6us when another IRQ arrive to master, but
12us when IRQ arrives to slave... I have no idea why it drops from
100us to 12us. 

I have an idea that with outb() spurious IRQ happens some time 
after Promise deasserts IRQ, while with outb_p() it happens when 
we mask it. Unfortunately stack traces at arrival of spurious 
IRQ (available on request, 120KB uncompressed) do not agree with 
this idea - they always lead to default_idle. It is possible that 
it always arrives in default_idle because of my CPU is so fast 
that even endless stream of IRQs from 8259 arrives always when 
CPU is in default_idle, but I have some doubts that 1GHz is fast 
enough to see such effect.

Time stamps were obtained from TSC register of my 1GHz Athlon.
                                            Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
IRQ7 arrived, previous irq was 10, it happened 103028 ns ago
Master: ISR: 00, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E
IRQ0 arrived after spurious IRQ. It happened 4843934 ns ago
Master: ISR: 01, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 94475 ns ago
Master: ISR: 00, IRR: 84, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 04, IMR: A8, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 1586275 ns ago
Master: ISR: 04, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 5, it happened 4959 ns ago
Master: ISR: 00, IRR: A0, IMR: F8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E
IRQ0 arrived after spurious IRQ. It happened 4830426 ns ago
Master: ISR: 01, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 5, it happened 4959 ns ago
Master: ISR: 00, IRR: A0, IMR: F8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E
IRQ0 arrived after spurious IRQ. It happened 4831445 ns ago
Master: ISR: 01, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 5, it happened 4929 ns ago
Master: ISR: 00, IRR: A0, IMR: F8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E
IRQ0 arrived after spurious IRQ. It happened 4794576 ns ago
Master: ISR: 01, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 5, it happened 5469 ns ago
Master: ISR: 00, IRR: A0, IMR: F8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E
IRQ0 arrived after spurious IRQ. It happened 4795415 ns ago
Master: ISR: 01, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 5, it happened 4929 ns ago
Master: ISR: 00, IRR: A0, IMR: F8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E
IRQ0 arrived after spurious IRQ. It happened 4759656 ns ago
Master: ISR: 01, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 5, it happened 4929 ns ago
Master: ISR: 00, IRR: A0, IMR: F8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E
IRQ0 arrived after spurious IRQ. It happened 4761185 ns ago
Master: ISR: 01, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 94389 ns ago
Master: ISR: 00, IRR: 84, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 04, IMR: A8, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 1609311 ns ago
Master: ISR: 04, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 94607 ns ago
Master: ISR: 00, IRR: 84, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 04, IMR: A8, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 195708 ns ago
Master: ISR: 04, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 101889 ns ago
Master: ISR: 00, IRR: 84, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 04, IMR: A8, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 1555839 ns ago
Master: ISR: 04, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 94419 ns ago
Master: ISR: 00, IRR: 84, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 04, IMR: A8, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 1605751 ns ago
Master: ISR: 04, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 1, it happened 4930 ns ago
Master: ISR: 00, IRR: 80, IMR: DA, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E
IRQ0 arrived after spurious IRQ. It happened 4484164 ns ago
Master: ISR: 01, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 101889 ns ago
Master: ISR: 00, IRR: 84, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 04, IMR: A8, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 1638040 ns ago
Master: ISR: 04, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 101888 ns ago
Master: ISR: 00, IRR: 84, IMR: F8, ELCR: 20
Slave : ISR: 00, IRR: 04, IMR: A8, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 1632361 ns ago
Master: ISR: 04, IRR: 80, IMR: F8, ELCR: 20
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 95015 ns ago
Master: ISR: 00, IRR: 84, IMR: F8, ELCR: 20
Slave : ISR: 00, IRR: 04, IMR: A8, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 1591085 ns ago
Master: ISR: 04, IRR: 80, IMR: F8, ELCR: 20
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 94688 ns ago
Master: ISR: 00, IRR: 84, IMR: F8, ELCR: 20
Slave : ISR: 00, IRR: 04, IMR: A8, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 1591840 ns ago
Master: ISR: 04, IRR: 80, IMR: F8, ELCR: 20
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 94389 ns ago
Master: ISR: 00, IRR: 84, IMR: F8, ELCR: 20
Slave : ISR: 00, IRR: 04, IMR: A8, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 1578193 ns ago
Master: ISR: 04, IRR: 80, IMR: F8, ELCR: 20
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 94444 ns ago
Master: ISR: 00, IRR: 84, IMR: F8, ELCR: 20
Slave : ISR: 00, IRR: 04, IMR: A8, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 1575884 ns ago
Master: ISR: 04, IRR: 80, IMR: F8, ELCR: 20
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 101889 ns ago
Master: ISR: 00, IRR: A4, IMR: F8, ELCR: 00
Slave : ISR: 00, IRR: 04, IMR: A8, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 1606411 ns ago
Master: ISR: 04, IRR: A0, IMR: F8, ELCR: 00
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 103119 ns ago
Master: ISR: 00, IRR: A0, IMR: F8, ELCR: 00
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 3797929 ns ago
Master: ISR: 04, IRR: A0, IMR: F8, ELCR: 00
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 8495 ns ago
Master: ISR: 00, IRR: A0, IMR: F8, ELCR: 00
Slave : ISR: 00, IRR: 00, IMR: AC, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 1899226 ns ago
Master: ISR: 04, IRR: A0, IMR: F8, ELCR: 00
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 94419 ns ago
Master: ISR: 00, IRR: A4, IMR: F8, ELCR: 00
Slave : ISR: 00, IRR: 04, IMR: A8, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 1594701 ns ago
Master: ISR: 04, IRR: A0, IMR: F8, ELCR: 00
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 95105 ns ago
Master: ISR: 00, IRR: A4, IMR: F8, ELCR: 00
Slave : ISR: 00, IRR: 04, IMR: A8, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 1674535 ns ago
Master: ISR: 04, IRR: A0, IMR: F8, ELCR: 00
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 94389 ns ago
Master: ISR: 00, IRR: A4, IMR: F8, ELCR: 00
Slave : ISR: 00, IRR: 04, IMR: A8, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 1597919 ns ago
Master: ISR: 04, IRR: A0, IMR: F8, ELCR: 00
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 101889 ns ago
Master: ISR: 00, IRR: A4, IMR: F8, ELCR: 00
Slave : ISR: 00, IRR: 04, IMR: A8, ELCR: 0E
IRQ10 arrived after spurious IRQ. It happened 1640221 ns ago
Master: ISR: 04, IRR: A0, IMR: F8, ELCR: 00
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 0E

IRQ7 arrived, previous irq was 10, it happened 101888 ns ago
Master: ISR: 00, IRR: A4, IMR: F8, ELCR: 00
Slave : ISR: 00, IRR: 04, IMR: A8, ELCR: 04
IRQ10 arrived after spurious IRQ. It happened 1636792 ns ago
Master: ISR: 04, IRR: A0, IMR: F8, ELCR: 00
Slave : ISR: 04, IRR: 04, IMR: A8, ELCR: 04

IRQ7 arrived, previous irq was 5, it happened 4929 ns ago
Master: ISR: 00, IRR: A0, IMR: F8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0A
IRQ0 arrived after spurious IRQ. It happened 3868746 ns ago
Master: ISR: 01, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0A

IRQ7 arrived, previous irq was 5, it happened 4959 ns ago
Master: ISR: 00, IRR: A0, IMR: F8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0A
IRQ0 arrived after spurious IRQ. It happened 3820746 ns ago
Master: ISR: 01, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0A

IRQ7 arrived, previous irq was 5, it happened 5004 ns ago
Master: ISR: 00, IRR: A0, IMR: F8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0A
IRQ0 arrived after spurious IRQ. It happened 3822035 ns ago
Master: ISR: 01, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0A

IRQ7 arrived, previous irq was 5, it happened 4989 ns ago
Master: ISR: 00, IRR: A0, IMR: F8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0A
IRQ0 arrived after spurious IRQ. It happened 3823625 ns ago
Master: ISR: 01, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0A

IRQ7 arrived, previous irq was 1, it happened 4990 ns ago
Master: ISR: 00, IRR: 80, IMR: DA, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E
IRQ0 arrived after spurious IRQ. It happened 3422855 ns ago
Master: ISR: 01, IRR: 80, IMR: D8, ELCR: 20
Slave : ISR: 00, IRR: 00, IMR: A8, ELCR: 0E
