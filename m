Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272744AbRIGP5L>; Fri, 7 Sep 2001 11:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272743AbRIGP5B>; Fri, 7 Sep 2001 11:57:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3846 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272744AbRIGP4t>; Fri, 7 Sep 2001 11:56:49 -0400
Date: Fri, 7 Sep 2001 08:52:52 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tester <tester@videotron.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Bizzare crashes on IBM Thinkpad A22e.. yenta_socket related
In-Reply-To: <Pine.LNX.4.33.0109041803010.1614-100000@TesterTop.PolyDom>
Message-ID: <Pine.LNX.4.33.0109070847270.10038-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Sep 2001, Tester wrote:
> >
> > What they are doing, however, is to generate a SCI, ie "System Control
> > Interrupt". Which, I bet you five bucks, is routed to the same interrupt
> > that your CardBus controller is on.
>
> Seems like you may have lost five bucks... When ACPI is enabled the sci is
> on IRQ 9, while the CardBus controller is on a IRQ 11 along with
> the Sound card, the ethernet card, the modem and the usb controller. The
> SCI seems to go to irq 9... and be alone there...  The bug does not happen
> when acpi is enabled tho... So I can't confirm...

No, I think I'll keep my 5 bucks, cheap bastard that I am.

The thing is, enabling ACPI will also force the _correct_ routing of the
SCI interrupt (assuming ACPI works - it doesn't on all machines), and thus
it doesn't show up as some random other irq. Which is why you don't get a
lockup.

> > However, the interrupt handler we have is _not_ aware of system
> > control interrupts. So it won't be able to handle them, and the
> > interrupts will go on forever - locking up the machine.
>
> Where would that loop occur?

There won't be any explicit loop - what will happen is that irq12 will
stay active, so we will keep on having irq12 interrupts that the CardBus
interrupt handler doesn't know what to do with - and immediately when the
irq handler returns and acks the interrupt we'll just take the irq again.

Over and over.

		Linus

