Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265971AbRGCTjV>; Tue, 3 Jul 2001 15:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265975AbRGCTjO>; Tue, 3 Jul 2001 15:39:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37642 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265971AbRGCTjA>; Tue, 3 Jul 2001 15:39:00 -0400
Subject: Re: ACPI fundamental locking problems
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Tue, 3 Jul 2001 20:39:06 +0100 (BST)
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org,
        acpi@phobos.fachschaften.tu-muenchen.de
In-Reply-To: <3B421AEA.8809D11C@mandrakesoft.com> from "Jeff Garzik" at Jul 03, 2001 03:20:10 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15HW0o-0008FJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That is the case here. The Global Lock is for synchronizing accesses between
> > the OS (that's us) and the firmware (SMI). Normal spinlocks are for intra-OS
> > locking. Here, we're synchronizing access with the BIOS. It's different.
> 
> I realize what the purpose of the global lock is...
> 
> How is the asm code in ACPI_ACQUIRE_GLOBAL_LOCK specific to interaction
> between OS and SMI?

Well lets take a look at the asm shall we

1.	It doesnt have a seperate loop when it fails to take the lock
	polling it (See intels own docs on spin locks). You do read your
	own publications ?

2.	It should be using rep nop  (See your own Intel PIV publications)

3.	Should be asm __volatile__ or gcc can move it

I am also somewhat puzzled about contexts here. What happens if you take
an IRQ during the global lock acquire and want to do ACPI. What happens
if you make a callback from the ACPI code - eg power management that itself
needs to call AML code ?

I am assuming the ACPI stuff has no IRQ level execution ability, but are you
sure ACPI never calls a single code path that can require an ACPI operation
from a callback - eg the PM layer ? Otherwise how can you be sure there won't
be any priority inversions between the bios/acpi locking set and the kernel 
locking set

> > All this code has been working for as long as I can remember.
> 
> ;-)  Under Windows?  Irrelevant.  Linux uses the hardware totally

Microsoft very early on in debugging Win2K problems ask people to use non
ACPI settings. 

> The difference with ACPI is that vendors can write code that is executed
> in the kernel's context (instead of what you can consider the BIOS's
> context).  That is a whole new can of worms.

For security reasons alone we need to ensure ACPI can be firmly in the off
position. Executing US written binary code in the Linux kernel will not be
acceptable to european corporations, non US military bodies and most 
Governments. They'd hate the US to get prior warning of say protestors
walking into their top secret menwith hill base playing the mission impossible
theme tune then chaining themselves to things..

And if the NSA wants the US goverment to execute binary only chinese bios code
on all their critical systems I am sure people will be happy.

> Look at the Linux boot sequence, which Randy Dunlap documented.  We
> collect as much information as is reasonable from BIOS at startup, so we
> won't have to talk to it again at runtime.

And we have customers who pointedly don't talk to the BIOS and kill SMI/SMM
early on...

