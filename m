Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273176AbRI0PAQ>; Thu, 27 Sep 2001 11:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273210AbRI0PAG>; Thu, 27 Sep 2001 11:00:06 -0400
Received: from mail.berlin.de ([195.243.105.33]:49813 "EHLO
	mailoutvl21.berlin.de") by vger.kernel.org with ESMTP
	id <S273204AbRI0O7s>; Thu, 27 Sep 2001 10:59:48 -0400
Message-ID: <3BB33E88.ACD1E426@berlin.de>
Date: Thu, 27 Sep 2001 16:58:16 +0200
From: Norbert Roos <n.roos@berlin.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: System hangs during interruptible_sleep_on_timeout() under 2.4.9
In-Reply-To: <Pine.LNX.4.33.0109261902350.6377-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> are you sure timer interrupts are processed while you are waiting for the
> timeout to expire? I'd suggest to put a:
> 
>         printk("<%d>", irq);
> 
> into arch/i386/kernel/irq.c:do_IRQ().

Until the call of interruptible_sleep_on_timeout(), timer interrupts
were processed. Right after the call no more output is made.

> So you can see what kind of
> interrupt traffic there is while the device initializes and you are
> waiting for it to generate an interrupt.

I use the function only for a short delay (switch on the device's reset,
wait and switch it off again), so the device even does not generate a
PCI interrupt.


In the time inbetween I have traced the problem: Inside the sleep_on()
functions there is the macro SLEEP_ON_HEAD containing the call
wq_write_lock_irqsave(), where the error happens. This is a macro, too,
which at last expands to

__asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */)

(x ist the variable where the IRQ flags are stored)
I'm not familiar with x86 assembler; is it possible that something can
go wrong here?

bye, Norbert
