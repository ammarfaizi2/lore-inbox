Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317568AbSG2Ron>; Mon, 29 Jul 2002 13:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317570AbSG2Ron>; Mon, 29 Jul 2002 13:44:43 -0400
Received: from viefep13-int.chello.at ([213.46.255.15]:46417 "EHLO
	viefep13-int.chello.at") by vger.kernel.org with ESMTP
	id <S317568AbSG2RoK>; Mon, 29 Jul 2002 13:44:10 -0400
Message-ID: <3D457FA8.DFACC4FF@gmx.at>
Date: Mon, 29 Jul 2002 19:47:20 +0200
From: Christoph Plattner <christoph.plattner@gmx.at>
Organization: private
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [parisc-linux] 3 Serial issues up for discussion (was: Re: Serial 
 core problems on embedded PPC)
References: <20020729040824.GA2351@zax> <20020729100009.A23843@flint.arm.linux.org.uk> <20020729144408.GA11206@opus.bloom.county> <20020729181702.E25451@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ad "setserial API":

Please use /proc/serialdev (or similar), *NOT* a `/dev' entry !!
This is typical `/proc'-FS stuff !
(See SCSI: echo "scsi add-single-device 0 0 4 0" > /proc/scsi/scsi   
!!!)

Christoph P.


Russell King wrote:
> 
> On Mon, Jul 29, 2002 at 07:44:08AM -0700, Tom Rini wrote:
> > On Mon, Jul 29, 2002 at 10:00:10AM +0100, Russell King wrote:
> > > Unless ppc and others are willing to put up with major breakage when I
> > > change asm/serial.h, I don't see this getting cleaned up.  Comments on
> > > this area welcome.
> >
> > Well, what changes do you have in mind?
> 
> Firstly, apologies to Tom for turning this into a general discussion
> mail.  At the request of Tom, this message is also CC:'d to the PPC
> devel lists.
> 
> There's quite a lot in here, so please, when replying edit out stuff
> your not replying to.  Thanks.
> 
> 1. Serial port initialisation
> -----------------------------
> 
> Firstly, one thing to bear in mind here is that, as Alan says "be nice
> to make sure it was much earlier".  I guess Alan's right, so we can get
> oopsen out of the the kernel relatively easily, even when we're using
> framebuffer consoles.
> 
> I'm sure Alan will enlighten us with his specific reasons if required.
> 
> There have been several suggestions around on how to fix this table:
> 
> a. architectures provide a sub-module to 8250.c which contains the
>    per-port details, rather than a table in serial.h.  This would
>    ideally mean removing serial.h completely.  The relevant object
>    would be linked into 8250.c when 8250.c is built as a module.
> 
> b. we create 8250_hub6.c, 8250_generic.c, 8250_multiport.c and friends
>    each containing the parameters for the specific cards and handle it
>    as above.
> 
> c. make it the responsibility of user space to tell the kernel about
>    many serial ports, and leave just the ones necessary for serial
>    console in the kernel.  (see issue 2 below)
> 
> d. we keep serial.h, make it 8250-compatible ports only, and change
>    CONFIG_SERIAL_MULTIPORT and friends to CONFIG_SERIAL_8250_MULTIPORT
>    This is the simplest and least likely to break other code.  On the
>    other hand, we end up hauling the ISA table and struct old_serial_port
>    into 2.6.
> 
> 2. setserial API
> ----------------
> 
> This is actually tied closely into another issue; I'd like to get rid
> of this silly idea where we're able to open serial ports that don't
> exist (ie, their UART is "unknown").  This behaviour appears to be for
> the benefit of setserial to allow it to modify port base addresses and
> interrupt levels, etc.  Removing this facility would require a new API
> for such things.  The best suggestion made so far is to do something
> like:
> 
> # echo "add 0x2e8,3,autoconfig" >/dev/serialctl
> # echo "remove 0x2e8" >/dev/serialctl
> 
> (or s,/dev/serialctl,/proc/tty/driver/serial, which pre-exists)
> 
> where we have "add ioport,irq,flags" and "remove ioport" (note that
> mmio ports aren't covered here since they require ioremap games which
> tends to be card specific!)
> 
> Why make this change?  Well, we have quite a lot of baggage being
> dragged around to support configuration of an open port and being
> able to open a non-existent port.  I'd really like to get rid of
> this excess baggage.
> 
> 3. /dev/ttyS*, /dev/ttySA*, /dev/ttyCL*, /dev/ttyAM*, etc
> ---------------------------------------------------------
> 
> All the above are serial ports of various types.  It has been expressed
> several times that people would like to see all of them appear as
> /dev/ttyS* (indeed, there was an, erm, rather heated discussion about
> it a couple of years ago.)  I'm going to be neutral on this point
> here.
> 
> There are several issues surrounding this:
> 
> a. The serial core.c is very almost capable of handling this abstraction,
>    with one exception - a registered port can only be in one group at
>    one time.  This restriction is brought about because of the way the
>    tty layer handles its tty ports.
> 
>    (Handling dual registrations in two different majors gets _really_
>     messy - eg, you two built-in 16550A ports and two SA1100 ports
>     taking up ttyS0 to ttyS3.  You then add a 16550A PCMCIA modem,
>     which becomes ttyS4.  Oh, and the SA1100 ports are also appearing
>     as ttySA0 and ttySA1.  _really_ messy.  No thanks.)
> 
> b. serial consoles.  Each hardware driver handles its serial consoles
>    by itself, and if you have two or more hardware drivers built in
>    with serial console support, you need to be able to tell them apart
>    with the console= kernel parameter.
> 
>    Again, this could be solvable if we have one "ttyS" view of everything
>    (core.c would then be responsible for registering the console with
>     printk.c and passing the various methods off to the relevant
>     hardware).
> 
> c. People with many serial ports.  We _could_ change the device number
>    allocations such that ttyS gobbles up the ttySA, ttyCL, ttyAM, etc
>    device numbers so we end up with the same number of port slots
>    available for those with many many serial ports in their machines.
> 
> --
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> _______________________________________________
> parisc-linux mailing list
> parisc-linux@lists.parisc-linux.org
> http://lists.parisc-linux.org/mailman/listinfo/parisc-linux

-- 
-------------------------------------------------------
private:	christoph.plattner@gmx.at
company:	christoph.plattner@alcatel.at

