Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136697AbRASBgE>; Thu, 18 Jan 2001 20:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136650AbRASBfT>; Thu, 18 Jan 2001 20:35:19 -0500
Received: from [210.74.191.34] ([210.74.191.34]:37874 "EHLO
	bfrey.turbolinux.com.cn") by vger.kernel.org with ESMTP
	id <S136312AbRASBe7>; Thu, 18 Jan 2001 20:34:59 -0500
Date: Fri, 19 Jan 2001 09:41:30 +0800
From: Bob Frey <bfrey@turbolinux.com.cn>
To: Stephen Kitchener <stephen@g6dzj.demon.co.uk>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Scanning problems - machine lockups
Message-ID: <20010119094130.A7816@bfrey.dev.cn.tlan>
In-Reply-To: <01011823245400.01549@statler.ether-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0us
In-Reply-To: <01011823245400.01549@statler.ether-net>; from stephen@g6dzj.demon.co.uk on Thu, Jan 18, 2001 at 11:24:54PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 11:24:54PM +0000, Stephen Kitchener wrote:
> The only thing that might be odd is that the scanner's scsi card and the 
> display card are using the same IRQ, but I thought that IRQ sharing was ok in 
> the new kernels. The display card is an AGP type and the scsi card is pci.
>
> As you might have guessed, I am at a loss as to what to do next. Any help 
> appriciated, even suggestions as to how I can track down what I haven't done 
> (yet!)
Sharing interrupts could be the problem. Interrupt sharing is supported
in the kernel as far as two different drivers being able to register a
handler for the same interrupt, but not much beyond that. From studying
the code I don't find any handling of unclaimed or spurious interrupts.

Some drivers (like video cards) do not register a handler for their card's
interrupt. So when another driver (like the advansys driver) shares an
interrupt with this card's "unregistered" interrupt there is no one left
to handle the interrupt. The system will loop taking an interrupt from
the card. I've observed this using the frame buffer driver. Note: this
problem is unnoticed if the (video) card does not share an interrupt with
another driver, because (at least on x86) Linux does not enable the
PIC IRQ bit for IRQs that do not have registered interrupted handlers.

For Linux I think the right way to handle this is to have each (SA_SHIRQ)
sharing capable interrupt handler return a TRUE or FALSE value indicating
whether the interrupt belongs to the driver. In kernel/irq.c:handle_IRQ_event()
check the return value. If after one pass through all of the interrupt
(action) handlers no one has claimed the inerrupt then log a warning message
(spurious interrupt) and clear the interrupt. The difficult/painstaking
problem is that all SA_SHIRQ drivers need to be changed to return a return
value to make this work.

Anyway the simplest solution for you is probably if you can is to put
assign the video card its own interrupt. Putting the two advansys cards
on the same interrupt is fine. I have used interrupt sharing between
multiple advansys cards and and ethernet cards without a problem.

--
Bob Frey
bfrey@turbolinux.com.cn
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
