Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270646AbRIAPAh>; Sat, 1 Sep 2001 11:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270773AbRIAPAR>; Sat, 1 Sep 2001 11:00:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51473 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270646AbRIAPAI>; Sat, 1 Sep 2001 11:00:08 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Bizzare crashes on IBM Thinkpad A22e.. yenta_socket related
Date: Sat, 1 Sep 2001 14:56:55 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9mqsvn$fql$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0108311244070.2899-100000@TesterTop.PolyDom> <Pine.LNX.4.33.0109010022440.1295-100000@TesterTop.PolyDom>
X-Trace: palladium.transmeta.com 999356397 29444 127.0.0.1 (1 Sep 2001 14:59:57 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 1 Sep 2001 14:59:57 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0109010022440.1295-100000@TesterTop.PolyDom>,
Olivier Crete  <Tester@videotron.ca> wrote:
>
>Ok, I've tried removing different parts of the kernel and I have been able
>to find that the instability (repetable freezes) start to appear when the
>yenta_socket.o module is loaded. I dont see the link between this module
>and the events that trigger the freezes... It crashes when I do the
>following things: use any of the non-keyboard buttons (thinkpad buttons
>and volume control), brightness control, etc.. These buttons fn-X
>combination have in common that they do not generate a scancode as shown
>by showkey.

What they are doing, however, is to generate a SCI, ie "System Control
Interrupt". Which, I bet you five bucks, is routed to the same interrupt
that your CardBus controller is on.

So the fact that the system hangs only with the CardBus module loaded
really has nothing to do with the yenta code itself - it's just that
before the yenta module is loaded, the SCI will be entirely ignored.
Once yenta _is_ loaded, however, we have a interrupt handler for the
interrupt and will start accepting it.

However, the interrupt handler we have is _not_ aware of system
control interrupts. So it won't be able to handle them, and the
interrupts will go on forever - locking up the machine.


The problem here is that the SCI really _should_not_ generate a regular
interrupt unless the system is ready to accept it. The SCI can be routed
to a SMI (system management interrupt, which puts the CPU in SMM mode,
at which point the BIOS SMM routines can handle it), _or_ if you have
ACPI enabled, ACPI should be (a) enabling the SCI->regular irq routine
_and_ (b) actually handling the irq.

Do you have ACPI enabled in your kernel?

What are the bootup messages?

		Linus
