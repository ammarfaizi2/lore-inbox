Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbUENTrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUENTrj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 15:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUENTrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 15:47:39 -0400
Received: from florence.buici.com ([206.124.142.26]:21641 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262381AbUENTr1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 15:47:27 -0400
Date: Fri, 14 May 2004 12:47:26 -0700
From: Marc Singer <elf@buici.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: rmk@arm.linux.org.uk, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: arm-lh7a40x IDE support in 2.6.6
Message-ID: <20040514194726.GA21194@buici.com>
References: <200405141840.04401.bzolnier@elka.pw.edu.pl> <20040514172656.GA18884@buici.com> <200405142045.51875.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405142045.51875.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 08:45:51PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Friday 14 of May 2004 19:26, Marc Singer wrote:
> > On Fri, May 14, 2004 at 06:40:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > I was just porting my patches killing <asm/arch/ide.h> for
> > > ARM to 2.6.6 when noticed that more work is needed now. :-(
> > >
> > > arch/arm/mach-lh7a40x/ide-lpd7a40x.c
> > > include/asm-arm/arch-lh7a40x/ide.h
> > >
> > > Why it couldn't be done in drivers/ide/arm
> > > (as discussed on linux-ide)?
> >
> > Your response took look enough for me to switch to another job.  I
> > haven't yet returned to dealing with this.
> 
> Yes, it took too long.
> 
> Anyway, pushing non-working code to mainline is a bad thing
> (I can show some proofs for this statement).

Oh, no don't do that!

> > > Code from <asm/ide.h> is inlined into IDE core code in far too
> > > many interesting places which greatly increasing complexity/insanity
> > > to anybody trying to understand or change it.
> > >
> > > The rule is simple:
> > > 	code outside drivers/ide SHOULDN'T need to know about <linux/ide.h>.
> >
> > I am emulating what has come before.  All of my examples look like
> > what I did.
> 
> Please point me to some (working) code outside drivers/ide
> which knows i.e. something about 'ide_hwif_t' type.

My code works fine in 2.6.4.  QED.

> [ you used 'struct ide_hwif_s' in arch-lh7a40x/ide.h to workaround this 8) ]

Copied from elsewhere.  

Listen.  It is not my intention to be clever.  All I want to do is get
things working and to not break other people's code.  I'm certain that
most people are working with the same assumptions.  Aside from some
naive snippets I've see promulgated, the bulk of the kernel work I've
see is sane given limited information.  Certainly, once one
understands a sybsystem completely then the quality rises.  I hope
you'll admit that the IDE code is overly intricate.
  
> > Where's the model?
> 
> drivers/ide/arm/icside.c

Good.  I'll look at it.

> 
> My main concerns are:
> 
> - ide-lpd7a40x.c should go into drivers/ide/arm/

Easy to do.

> - you are setting IDE_NO_IRQ in ide_init_hwif_ports() which is used
>   in many places in generic IDE code - anybody wanting to understand
>   interactions with your code + generic code will have serious
>   problems (especially if knows _nothing_ about lpd7a40x)

I don't know what you mean.  I grep for that constant and found it
nowhere except for ide-io.c and in my code.  It doesn't take much to
find the references.

What is it that you want changed?
 
> - hwif->mmio is set to 2 but resource handling is missed

Can you be more specific?  Did you notice the comment?  I didn't know
what it was for, but I set it because I thought that that was the
right way to go.

Are you talking about reserving the address space?  At the moment,
this is done in the arch setup.  I can certainly move it to the IDE
driver.

> - ide_init_default_hwifs() is OBSOLETE and shouldn't be used

I expect that your model will show me the way.

> > > BTW does it even work as IDE polling code is not merged yet?
> >
> > Huh?
> >
> > aThe solution isn't really that complex.  I need two things.  First, I
> > must override the register-level access routines in order to do a
> > little hardware workaround cha-cha-cha.  There's nothing I can do to
> > fix the hardware.  Second, I need to be able to poll the interface
> > after initiating a command.  IIRC, you said that I missed at least one
> > place where this needed to be done.
> 
> Yes, idea isn't complex but spotting all places needing change is.

That's what you are for.  %^)

> > There are also some very important code (hacks) in
> >
> >   arch/arm/mach-lh7a40x/ide-lpd7a40x.c
> >
> > to deal with the fact that I didn't want to touch the SELECT_DRIVE
> > call from the IDE driver.  The problem was that the SELECT_DRIVE call
> > in ide-iops.c does this:
> >
> >   void SELECT_DRIVE (ide_drive_t *drive)
> >   {
> > 	  if (HWIF(drive)->selectproc)
> > 		  HWIF(drive)->selectproc(drive);
> > 	  HWIF(drive)->OUTB(drive->select.all, IDE_SELECT_REG);
> >   }
> >
> >
> > instead of this:
> >
> >   void SELECT_DRIVE (ide_drive_t *drive)
> >   {
> > 	  if (HWIF(drive)->selectproc)
> > 		  HWIF(drive)->selectproc(drive);
> > 	  else
> > 		  HWIF(drive)->OUTB(drive->select.all, IDE_SELECT_REG);
> >   }
> >
> > The OUTB breaks my interface because I don't really have byte-level
> > access to the resgisters.  So, is selectproc a pre-select procedure or
> > should it be a substitute?
> 
> pre-select but you can change it to be substitute if you need
> (just remember to update all users if you decide to do this)

I'll have to search the kernel to see what uses it.  Maybe the better
way would be to define a new select proc that *is* a substitute.


> IMO it is better to fix it correctly than to do hacks like this
> in lpd7a40x_ide_outb() (which is minor performance hit btw)

Of course.

> > Anyway, that is what I did in a nutshell.  I plan to get back to this
> > in a week or so.  Since Russell King already integrated the lh7a40x
> > code into the kernel, this stuff should be easy to test.
> 
> That's what I'm talking about - it shouldn't have been integrated. :-)

I think we are talking about two things here.  I agree that the
ide-lpd7a400 code should not have been integrated.  However, the rest
of the core code is fine.  It is that core code that is necessary to
make the test possible.

Cheers.
