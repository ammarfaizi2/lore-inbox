Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314456AbSEPRK6>; Thu, 16 May 2002 13:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314458AbSEPRK5>; Thu, 16 May 2002 13:10:57 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7808 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S314456AbSEPRK4>; Thu, 16 May 2002 13:10:56 -0400
Date: Thu, 16 May 2002 13:11:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ion Badulescu <ionut@cs.columbia.edu>
cc: Bart Trojanowski <bart@jukie.net>, linux-kernel@vger.kernel.org
Subject: Re: Q: x86 interrupt arrival after cli
In-Reply-To: <200205161555.g4GFt0v05623@buggy.badula.org>
Message-ID: <Pine.LNX.3.95.1020516124059.702A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002, Ion Badulescu wrote:

> On Wed, 15 May 2002 20:27:20 -0400, Bart Trojanowski <bart@jukie.net> wrote:
> > [-- text/plain, encoding quoted-printable, 14 lines --]
> > 
> > Quick question for the x86 gurus:
> > 
> > If a hardware interrupt arrives within a spin_lock_irqsave &
> > spin_unlock_irqrestore will the interrupt handler associated with said
> > interrupt be called immediately after the spinlock is released?  
> > 
> > I am interested in any delays, even those less then a jiffie.
> 
> The interrupt will occur when the instruction after the "sti" finishes.
> That's a one assembler instruction delay, i.e. a few clock cycles.
> 
> *Which* interrupt will be serviced first, however, depends on how 
> many interrupt sources you have active and on the IRQ prioritization.
> 
> Ion
> 
Correct. And the priority for the Intel/IBM class machine is:

<--- HIGHEST    -------------------     LOWEST ---->

IRQ0, 1, 8, 9, 10, 11, 12, 13, 14, 15, 3, 4, 5, 6, 7
   |  |  |                             |  |  |  |  |_ printer
   |  |  |                             |  |  |  |____ Floppy
   |  |  |                             |  |  |_______ Fixed disk
   |  |  |                             |  |__________ Serial 0
   |  |  |                             |_____________ Serial 1
   |  |  |
   |  |  |___________ IRQ2->IRQ8 cascade  RTC
   |  |______________ Keyboard
   |_________________ PIT channel 0

IFF the IO-APIC is programmed to emulate the old dual controllers.

Answering; 
"I am interested in any delays, even those less then a jiffie."

Any interrupt request that becomes active during your ISR, that
has a higher priority, will be serviced before your ISR gets
another chance to be serviced.

As far as normal delays are concerned, one can make a simple
interrupt routine that just bumps a counter, that works off
from IRQ7 (the printer port), with a 400MHz machine (obsolete now),
I could do 80,000 interrupts per second without missing any.

This number should scale to your CPU speed quite well. FYI, this
is the lowest priority and everything else was running (network
with all its broadcast junk, etc).

As I recall, if I disconnected the network, and didn't touch the
keyboard, I could do over 150,000 interrupts per second without
missing any.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

