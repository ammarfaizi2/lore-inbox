Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130107AbRATPzG>; Sat, 20 Jan 2001 10:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129982AbRATPy4>; Sat, 20 Jan 2001 10:54:56 -0500
Received: from g6dzj.demon.co.uk ([158.152.227.28]:51751 "EHLO
	statler.ether-net") by vger.kernel.org with ESMTP
	id <S130022AbRATPys>; Sat, 20 Jan 2001 10:54:48 -0500
From: Stephen Kitchener <stephen@g6dzj.demon.co.uk>
Reply-To: stephen@g6dzj.demon.co.uk
Organization: none
Date: Sat, 20 Jan 2001 15:54:22 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Bob Frey <bfrey@turbolinux.com.cn>
In-Reply-To: <01011823245400.01549@statler.ether-net> <20010119094130.A7816@bfrey.dev.cn.tlan>
In-Reply-To: <20010119094130.A7816@bfrey.dev.cn.tlan>
Subject: Re: Scanning problems - machine lockups
MIME-Version: 1.0
Message-Id: <01012015542200.01503@statler.ether-net>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 January 2001 01:41, Bob Frey wrote:
> On Thu, Jan 18, 2001 at 11:24:54PM +0000, Stephen Kitchener wrote:
> > The only thing that might be odd is that the scanner's scsi card and the
> > display card are using the same IRQ, but I thought that IRQ sharing was
> > ok in the new kernels. The display card is an AGP type and the scsi card
> > is pci.
> >
> > As you might have guessed, I am at a loss as to what to do next. Any help
> > appriciated, even suggestions as to how I can track down what I haven't
> > done (yet!)
>
> Sharing interrupts could be the problem. Interrupt sharing is supported
> in the kernel as far as two different drivers being able to register a
> handler for the same interrupt, but not much beyond that. From studying
> the code I don't find any handling of unclaimed or spurious interrupts.
>
> Some drivers (like video cards) do not register a handler for their card's
> interrupt. So when another driver (like the advansys driver) shares an
> interrupt with this card's "unregistered" interrupt there is no one left
> to handle the interrupt. The system will loop taking an interrupt from
> the card. I've observed this using the frame buffer driver. Note: this
> problem is unnoticed if the (video) card does not share an interrupt with
> another driver, because (at least on x86) Linux does not enable the
> PIC IRQ bit for IRQs that do not have registered interrupted handlers.
>
> For Linux I think the right way to handle this is to have each (SA_SHIRQ)
> sharing capable interrupt handler return a TRUE or FALSE value indicating
> whether the interrupt belongs to the driver. In
> kernel/irq.c:handle_IRQ_event() check the return value. If after one pass
> through all of the interrupt (action) handlers no one has claimed the
> inerrupt then log a warning message (spurious interrupt) and clear the
> interrupt. The difficult/painstaking problem is that all SA_SHIRQ drivers
> need to be changed to return a return value to make this work.
>
> Anyway the simplest solution for you is probably if you can is to put
> assign the video card its own interrupt. Putting the two advansys cards
> on the same interrupt is fine. I have used interrupt sharing between
> multiple advansys cards and and ethernet cards without a problem.

Hi Bob and the list,

I eventually succeeded in putting the grahics card onto a different IRQ from 
ether of the SCSI cards. Not without some problems though. The AGP card would 
follow what ever IRQ I assigned the PCI slot nearest it. The mobo is an ASUS 
P2BD btw. The only way I could make the change was to swap the ethernet card 
with the scsi card. The Ethernet card now has the same IRQ as the Graphics 
card.

I would try a PCI graphics card, but I haven't one. Just in case the AGP card 
is getting in the way.

Any, I thought that it had cured the problem, but after a few scans, 
admittedly more than before, the scan head didn't return on the last scan 
that was successfully started.

Trying to scan again, hoping that it would reset the scanner and carry on, 
... nothing, no response from scanner.

So.. could it be the scsi driver (Advansys 3940uw, in the kernel), or a 
broken scanner itself?. Is there a way I can test this, run tests, switch on 
debug etc ? 

Scsi device is set up as follows...

Device Information for AdvanSys SCSI Host 0:
Target IDs Detected: 1, 7, (7=Host Adapter)
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: UMAX     Model: Astra 2400S      Rev: V1.1
  Type:   Scanner                          ANSI SCSI revision: 02
 
EEPROM Settings for AdvanSys SCSI Host 0:
 Serial Number: AA48A919D387
 Host SCSI ID: 7, Host Queue Size: 253, Device Queue Size: 63
 termination: 0 (Automatic), bios_ctrl: ffe7
 Target ID:            0 1 2 3 4 5 6 7 8 9 A B C D E F
 Disconnects:          Y N Y Y Y Y Y Y Y Y Y Y Y Y Y Y
 Command Queuing:      Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y
 Start Motor:          Y N Y Y Y N Y Y Y Y Y Y Y Y Y Y
 Synchronous Transfer: Y N Y Y Y Y Y Y Y Y Y Y Y Y Y Y
 Ultra Transfer:       Y N Y Y Y Y Y Y Y Y Y Y Y Y Y Y
 Wide Transfer:        Y N Y Y Y Y Y Y Y Y Y Y Y Y Y Y

>
> --
> Bob Frey
> bfrey@turbolinux.com.cn
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Stephen Kitchener
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
