Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267122AbSKSTau>; Tue, 19 Nov 2002 14:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267126AbSKSTat>; Tue, 19 Nov 2002 14:30:49 -0500
Received: from air-2.osdl.org ([65.172.181.6]:2483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267122AbSKSTaq>;
	Tue, 19 Nov 2002 14:30:46 -0500
Date: Tue, 19 Nov 2002 11:37:31 -0800
From: Dave Olien <dmo@osdl.org>
To: "T. Weyergraf" <kirk@colinet.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: DAC960, 2.4.19 alpha problems
Message-ID: <20021119113731.A8238@acpi.pdx.osdl.net>
References: <1037710684.11541.8.camel@irongate.swansea.linux.org.uk> <kirk-1021119132330.A0216470@hydra.colinet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <kirk-1021119132330.A0216470@hydra.colinet.de>; from kirk@colinet.de on Tue, Nov 19, 2002 at 01:23:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been tinkering with the DAC960 driver in linux 2.5.
But, I don't have an alpha, so I can only guess about
what's going on in that case.

First, I don't know whether running POST is necessary to make the
board work.  But even if you get past the POST issue, how
would you configure the disks on the controller into
logical drives, with RAID level, etc?  The DAC960 driver
in linux doesn't provide any way to do this (mostly because
Mylex won't provide specifications for implementing this).
So, the only way I know under Linux is to run the
controller's graphical BIOS utility.  Mylex has a global
array manager utility that is somehow supported on Linux.
I think it may work by using some pass-through ioctl commands
to the driver.  But, I dont' have any experience with it.

Beyond that... removing inline declarations should NOT be a problem
for functions in this driver.

The "I/O Adress N/A" report from the driver is correct for
this controller.  The driver looks for an I/O address range only
for some of the older Mylex controller cards.  I believe this is
referring to space in x86 IO space  (using inb/outb
instructions).  The driver never actually references this space.

At the time the driver fails for you, the driver has already
done some interacting with registers on the controller.
It's had to enable interrupts from the device, it's
polled the controller's hardware mailbox waiting for it to be
empty, it's written  a command to the controller's hardware
mailbox, waited for a response, and gotten one.  So I think the
firmware on the controller card is "alive".  But it may still
be waiting for some interaction from the POST BIOS before
it will function.

alpha is little-endian.  So the data passed between driver
and controller should be compatible.  The driver currently
does not do endian-conversions.

There's another possibility.
At what physical address do alpha systems begin their ram?
Some routines that talk with your
controller card (in DAC960.h) have an #ifdef __ia64__.
The ia64 part of the #ifdef does 64-bit writes to the
controller.  The driver ia32 case (ie NOT an ia64)
does only 32-bit writes to the controller.
On ia32, we know that the memory allocated for memory mailboxes
(using __get_free_pages()) will always be below 4-gig.
So a 32-bit write is sufficient.
Is this true on alpha?  if not, then the __ia64__ ifdefs in
DAC960.h need to be modified to do 64-bit writes on alpha
as well.

On Tue, Nov 19, 2002 at 01:23:30PM +0100, T. Weyergraf wrote:
> Hi,
> 
> [....]
>  
> > Does the firmware need to run to make the card work however ? Thats a
> > problem on some other raid cards that prevents them running on non x86
> > platforms
> 
> That is something, I honestly don't know. I've asked on the debian-alpha
> mailing-list first and did not get any explanatory response. I've checked
> the card in a x86-machine ( just to very it's working and to configure
> RAID drives ). In this machine, the card posts a banner, saying it's
> a Mylex and - depending on the BIOS enable/disable setting - posting
> some keypress options to start the build-in firmware.
> That i don't see on my alpha, which does not necessarily mean something.
> 
> The SRM firmware contains a small x86-emulator, being capable to at
> least run the POST-routines of normal PCI cards. AFAIK, this emulator
> works on a lot of cards, but is not capable of doing any screen/terminal
> I/O. For example, if you use Matrox vga cards ( quite common on alphas )
> you get a working grafics device, but yoy won't see any matrox banner
> on the screen. Newer firmware's even support a "run_bios" command,
> that allows to start configuration routines, like the RAID setup.
> Unfortunately, a version of this newer firmware does not exist for
> my machine.
> 
> Mylex OEM'd some earlier DAC-models to DEC for use as a RAID
> controller. These came with their own firmwaer, which allowed ppl
> to setup logical RAID-drives. I can't tell, if the firmware handles any
> other POST stuff.
> 
> The controller comes with a SA-110 processor running it's own firmware.
> I would assume, that the SA-110 handles POST - but that's honestly
> just a wild guess.
> 
> Regards, 
> T.weyergraf
> 
> 
> -- 
> Thomas Weyergraf                                                kirk@colinet.de
> My Favorite IA64 Opcode-guess ( see arch/ia64/lib/memset.S )
> "br.ret.spnt.few" - got back from getting beer, did not spend a lot.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
