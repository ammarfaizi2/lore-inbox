Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267614AbUG3FuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267614AbUG3FuZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 01:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267619AbUG3FuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 01:50:25 -0400
Received: from users.linvision.com ([62.58.92.114]:40404 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S267614AbUG3Ft7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 01:49:59 -0400
Date: Fri, 30 Jul 2004 07:49:55 +0200
From: Rogier Wolff <Rogier@wolff.net>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OK, anybody have any hints and tips to get an MFM drive working again?
Message-ID: <20040730054955.GA20607@bitwizard.nl>
References: <1091148269.1232.1475.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091148269.1232.1475.camel@cube>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 08:44:29PM -0400, Albert Cahalan wrote:
> > We've tried the modern IDE driver, and the 2.4.20 one,
> > and the "old hd only" driver. 
> >
> > Going "retro": Compiling 2.0.39 gives me: "bus error"
> > while doing make dep. 
> 
> You need the old "xd" driver. It isn't IDE at all.
> You can be pretty sure you need the "xd" driver when:
> 
> a. the drive is 5, 10, or 20 MB

20. Yes, we're sure we have an MFM drive. 
(The KL330 is a 30Mb RLL drive. It requires a different
controller, but would require exactly the same driver
treatment from Linux)

> b. the drive has 3 cables: data, power, and control

Yup. 

> c. the drive is called MFM, RLL, or some other strange thing

Yup. 

> The mkdep bus error is easy to fix. The program is
> relying on an old well-loved Linux behavior that
> turned out to violate the POSIX standard. Linux used
> to give you a free zero page when doing a mmap()
> past the end of a file.
> 
> You might grab the mkdep from a later kernel.

OK. Will do. 

> Anyway, the 2.0.xx kernel is about right. Linux
> didn't get a working "xd" driver until long after
> the hardware was obsolete. The driver wasn't kept
> around for very long, because all the hardware
> was gone... except for your stash, if we assume
> that those drives really work.

Last thing we tried is booting it. It boots! i.e. we've now
verified that the hardware actually works..... But this card
has a jumper where 1-2 means IRQ5, 2-3 means IRQ 7, and
there is no jumper installed. Guess what that means for
the interrupt line it uses.... :-)

> Um, you'll most likely need an i386 to even boot
> with the card installed. Maybe you can boot on a
> somewhat recent machine if you disable IDE from
> the BIOS. Got SCSI? How about a network boot?

We've got two machines up-and-running which seem to be up to the 
task. One is an i386 (WITH coprocessor!!!), only ISA slots, no 
"integrated peripherals". It goes "NFS root" as soon as it's loaded
the kernel off the boot floppy. (We couldn't find any 4Mb SIMMs, 
so it only has 8M ram...)

The other is an Intel Celeron 466, which has one last ISA slot. 
When I disable "integrated IDE controller" (and the floppy for cards
that have a floppy), then I get the same results as on the 386. 
(It loads a boot-prom off the floppy and goes "diskless" one
step earlier: before loading the kernel)

Ah! Shit! During this whole excercise I forgot to lookup the 
source-line-that-generated-the-error! That is usually helpful. 

Look! This is the line that triggers: 

  if ((blockend < block) || (blockend > drive->part[minor&PARTN_MASK].nr_sects)) {

I'll take a guess that if I initialize an MFM drive, nr_sects get
initlialized to "0". Any block I ask for is beyond end-of-disk. 

I'll put a drive->part[0].nr_sects = 63960 in there. 
(That's the number of sectors that the drives would have if they
are RLL formatted and not MFM). Other things will go wrong if I
access a sector beyond the end-of-the-disk. "just don't do that
then"!

And, I've made the beginners mistake of not including the error
messages I got. I apologise.... 

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
