Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUENR1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUENR1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUENR1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:27:05 -0400
Received: from florence.buici.com ([206.124.142.26]:8073 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S261857AbUENR06
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:26:58 -0400
Date: Fri, 14 May 2004 10:26:56 -0700
From: Marc Singer <elf@buici.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: rmk@arm.linux.org.uk, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: arm-lh7a40x IDE support in 2.6.6
Message-ID: <20040514172656.GA18884@buici.com>
References: <200405141840.04401.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405141840.04401.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 06:40:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> I was just porting my patches killing <asm/arch/ide.h> for
> ARM to 2.6.6 when noticed that more work is needed now. :-(
> 
> arch/arm/mach-lh7a40x/ide-lpd7a40x.c
> include/asm-arm/arch-lh7a40x/ide.h
> 
> Why it couldn't be done in drivers/ide/arm
> (as discussed on linux-ide)?

Your response took look enough for me to switch to another job.  I
haven't yet returned to dealing with this.

> Code from <asm/ide.h> is inlined into IDE core code in far too
> many interesting places which greatly increasing complexity/insanity
> to anybody trying to understand or change it.
> 
> The rule is simple:
> 	code outside drivers/ide SHOULDN'T need to know about <linux/ide.h>.

I am emulating what has come before.  All of my examples look like
what I did.

> WTF everybody wants to be "smart" and abuses it?
> [ and then people complain why IDE is so ugly ]

Where's the model?

> BTW does it even work as IDE polling code is not merged yet?

Huh?

aThe solution isn't really that complex.  I need two things.  First, I
must override the register-level access routines in order to do a
little hardware workaround cha-cha-cha.  There's nothing I can do to
fix the hardware.  Second, I need to be able to poll the interface
after initiating a command.  IIRC, you said that I missed at least one
place where this needed to be done.

There are also some very important code (hacks) in

  arch/arm/mach-lh7a40x/ide-lpd7a40x.c

to deal with the fact that I didn't want to touch the SELECT_DRIVE
call from the IDE driver.  The problem was that the SELECT_DRIVE call
in ide-iops.c does this:

  void SELECT_DRIVE (ide_drive_t *drive)
  {
	  if (HWIF(drive)->selectproc)
		  HWIF(drive)->selectproc(drive);
	  HWIF(drive)->OUTB(drive->select.all, IDE_SELECT_REG);
  }


instead of this:

  void SELECT_DRIVE (ide_drive_t *drive)
  {
	  if (HWIF(drive)->selectproc)
		  HWIF(drive)->selectproc(drive);
	  else
		  HWIF(drive)->OUTB(drive->select.all, IDE_SELECT_REG);
  }

The OUTB breaks my interface because I don't really have byte-level
access to the resgisters.  So, is selectproc a pre-select procedure or
should it be a substitute?

Anyway, that is what I did in a nutshell.  I plan to get back to this
in a week or so.  Since Russell King already integrated the lh7a40x
code into the kernel, this stuff should be easy to test.

Cheers.

