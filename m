Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUENSoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUENSoz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 14:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUENSoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 14:44:55 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13742 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262052AbUENSoq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 14:44:46 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Marc Singer <elf@buici.com>
Subject: Re: arm-lh7a40x IDE support in 2.6.6
Date: Fri, 14 May 2004 20:45:51 +0200
User-Agent: KMail/1.5.3
Cc: rmk@arm.linux.org.uk, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200405141840.04401.bzolnier@elka.pw.edu.pl> <20040514172656.GA18884@buici.com>
In-Reply-To: <20040514172656.GA18884@buici.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405142045.51875.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 of May 2004 19:26, Marc Singer wrote:
> On Fri, May 14, 2004 at 06:40:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > I was just porting my patches killing <asm/arch/ide.h> for
> > ARM to 2.6.6 when noticed that more work is needed now. :-(
> >
> > arch/arm/mach-lh7a40x/ide-lpd7a40x.c
> > include/asm-arm/arch-lh7a40x/ide.h
> >
> > Why it couldn't be done in drivers/ide/arm
> > (as discussed on linux-ide)?
>
> Your response took look enough for me to switch to another job.  I
> haven't yet returned to dealing with this.

Yes, it took too long.

Anyway, pushing non-working code to mainline is a bad thing
(I can show some proofs for this statement).

> > Code from <asm/ide.h> is inlined into IDE core code in far too
> > many interesting places which greatly increasing complexity/insanity
> > to anybody trying to understand or change it.
> >
> > The rule is simple:
> > 	code outside drivers/ide SHOULDN'T need to know about <linux/ide.h>.
>
> I am emulating what has come before.  All of my examples look like
> what I did.

Please point me to some (working) code outside drivers/ide
which knows i.e. something about 'ide_hwif_t' type.

[ you used 'struct ide_hwif_s' in arch-lh7a40x/ide.h to workaround this 8) ]

> > WTF everybody wants to be "smart" and abuses it?
> > [ and then people complain why IDE is so ugly ]
>
> Where's the model?

drivers/ide/arm/icside.c

My main concerns are:

- ide-lpd7a40x.c should go into drivers/ide/arm/

- you are setting IDE_NO_IRQ in ide_init_hwif_ports() which is used
  in many places in generic IDE code - anybody wanting to understand
  interactions with your code + generic code will have serious
  problems (especially if knows _nothing_ about lpd7a40x)

- hwif->mmio is set to 2 but resource handling is missed

- ide_init_default_hwifs() is OBSOLETE and shouldn't be used

> > BTW does it even work as IDE polling code is not merged yet?
>
> Huh?
>
> aThe solution isn't really that complex.  I need two things.  First, I
> must override the register-level access routines in order to do a
> little hardware workaround cha-cha-cha.  There's nothing I can do to
> fix the hardware.  Second, I need to be able to poll the interface
> after initiating a command.  IIRC, you said that I missed at least one
> place where this needed to be done.

Yes, idea isn't complex but spotting all places needing change is.

> There are also some very important code (hacks) in
>
>   arch/arm/mach-lh7a40x/ide-lpd7a40x.c
>
> to deal with the fact that I didn't want to touch the SELECT_DRIVE
> call from the IDE driver.  The problem was that the SELECT_DRIVE call
> in ide-iops.c does this:
>
>   void SELECT_DRIVE (ide_drive_t *drive)
>   {
> 	  if (HWIF(drive)->selectproc)
> 		  HWIF(drive)->selectproc(drive);
> 	  HWIF(drive)->OUTB(drive->select.all, IDE_SELECT_REG);
>   }
>
>
> instead of this:
>
>   void SELECT_DRIVE (ide_drive_t *drive)
>   {
> 	  if (HWIF(drive)->selectproc)
> 		  HWIF(drive)->selectproc(drive);
> 	  else
> 		  HWIF(drive)->OUTB(drive->select.all, IDE_SELECT_REG);
>   }
>
> The OUTB breaks my interface because I don't really have byte-level
> access to the resgisters.  So, is selectproc a pre-select procedure or
> should it be a substitute?

pre-select but you can change it to be substitute if you need
(just remember to update all users if you decide to do this)

IMO it is better to fix it correctly than to do hacks like this
in lpd7a40x_ide_outb() (which is minor performance hit btw)

> Anyway, that is what I did in a nutshell.  I plan to get back to this
> in a week or so.  Since Russell King already integrated the lh7a40x
> code into the kernel, this stuff should be easy to test.

That's what I'm talking about - it shouldn't have been integrated. :-)

Cheers.

