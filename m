Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266016AbRGCV3Z>; Tue, 3 Jul 2001 17:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266019AbRGCV3P>; Tue, 3 Jul 2001 17:29:15 -0400
Received: from jffdns01.or.intel.com ([134.134.248.3]:6613 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S266016AbRGCV3L>; Tue, 3 Jul 2001 17:29:11 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDDF2F@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, jgarzik@mandrakesoft.com
Cc: linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de
Subject: RE: ACPI fundamental locking problems
Date: Tue, 3 Jul 2001 14:28:49 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of this discussion's getting a little X-Files-y.

However, there are some points I'd like to touch on...

> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Well lets take a look at the asm shall we
> 1.	It doesnt have a seperate loop when it fails to take the lock
> 	polling it (See intels own docs on spin locks). You do read your
> 	own publications ?

This goes to the special nature of the Global Lock. If we cannot acquire it,
we set a bit, and the system interrupts when it is released. Please see
acpi_ev_acquire_global_lock().

> 2.	It should be using rep nop  (See your own Intel PIV 
> publications)
> 3.	Should be asm __volatile__ or gcc can move it

You are most likely right about all this stuff. Haven't had the need to fix
it because it's been working fine. Patches accepted.

> I am also somewhat puzzled about contexts here. What happens 
> if you take
> an IRQ during the global lock acquire and want to do ACPI. 
> What happens
> if you make a callback from the ACPI code - eg power 
> management that itself
> needs to call AML code ?

All we do at interrupt level is signal the semaphore that threads needing
the GL have blocked on. They continue execution at non-interrupt level.

> I am assuming the ACPI stuff has no IRQ level execution 
> ability, but are you
> sure ACPI never calls a single code path that can require an 
> ACPI operation
> from a callback - eg the PM layer ? Otherwise how can you be 
> sure there won't
> be any priority inversions between the bios/acpi locking set 
> and the kernel 
> locking set

We're aware of this issue and have coded accordingly. We have run into these
issues (specifically with the Embedded Controller driver) and we fix them
when they crop up.

> Microsoft very early on in debugging Win2K problems ask 
> people to use non
> ACPI settings. 

What is your source for this? They certainly could have said that, but
everything I've heard is that MS was so committed to ACPI, they almost left
APM support out of W2K.

> > Jeff Garzik:
> > The difference with ACPI is that vendors can write code 
> that is executed
> > in the kernel's context (instead of what you can consider the BIOS's
> > context).  That is a whole new can of worms.

(I know I'm replying to Jeff's point in your email, sorry)
1) Vendors can write code that is *interpreted* by the OS.
2) If vendors write a malicious BIOS, it's game over even without ACPI
3) ACPI increases visibility of vendor code. You can disassemble AML. You
can step through it with our debugger.

> For security reasons alone we need to ensure ACPI can be 
> firmly in the off
> position. Executing US written binary code in the Linux 
> kernel will not be
> acceptable to european corporations, non US military bodies and most 
> Governments. They'd hate the US to get prior warning of say protestors
> walking into their top secret menwith hill base playing the 
> mission impossible
> theme tune then chaining themselves to things..

You're kidding.........right?

BTW of course ACPI can be turned off via make menuconfig.

> And we have customers who pointedly don't talk to the BIOS 
> and kill SMI/SMM
> early on...

And from what I understand, Itanium doesn't necessarily have a Global Lock
either. Great, no problem. However, we still need to handle machines that
do.

Regards -- Andy

PS Have I read *all* the Intel pubs? Cover to cover? Um, no. ;-)

