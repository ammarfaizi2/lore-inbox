Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264344AbTEZLYi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 07:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTEZLYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 07:24:38 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:38820 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264344AbTEZLYf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 07:24:35 -0400
Date: Mon, 26 May 2003 13:37:01 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
In-Reply-To: <3ED1F6C6.3050400@pobox.com>
Message-ID: <Pine.SOL.4.30.0305261328300.26499-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 May 2003, Jeff Garzik wrote:

> Bartlomiej Zolnierkiewicz wrote:
> > On Mon, 26 May 2003, Jeff Garzik wrote:
> >
> >
> >>Linus Torvalds wrote:
> >>
> >>>On Mon, 26 May 2003, Jeff Garzik wrote:
> >>>
> >>>
> >>>>Just to echo some comments I said in private, this driver is _not_
> >>>>a replacement for drivers/ide.  This is not, and has never been,
> >>>>the intention.  In fact, I need drivers/ide's continued existence,
> >>>>so that I may have fewer boundaries on future development.
> >>>
> >>>
> >>>Just out of interest, is there any _point_ to this driver? I can
> >>>appreciate the approach, but I'd like to know if it does anything (at all)
> >>>better than the native IDE driver? Faster? Anything?
> >>
> >>
> >>Direction:  SATA is much more suited to SCSI, because otherwise you wind
> >>up re-creating all the queueing and error handling mess that SCSI
> >>already does for you.  The SATA2 host controllers coming out soon do
> >>full host-side TCQ, not the dain-bramaged ATA TCQ bus-release stuff.
> >>Doing SATA2 devel in drivers/ide will essentially be re-creating the
> >>SCSI mid-layer.
> >
> >
> > And now you are recreating ATA in SCSI ;-).
> >
> > Don't get me wrong: I like idea very much, but why you can't
> > share common code between drivers/ide and your ATA-SCSI.
>
> SATA2 is really 100% different from PATA in all respects except for the
> ATA commands themselves being sent down the pipe.  Doing that inside
> drivers/ide really means two driver cores at that point.
>
> Sharing code is definitely an option, though!
> Why do you think I named it "libata"?  :)
>
>
> Another SATA wrinkle:  the phy layer.
>
> SATA, like network cards, has an underlying connection layer.  The host
> connects to the device.  Your link state may be up or down.  This is
> easily mapped to SCSI semantics (initiator connection to target).  Much
> more code if writing from scratch.
>
>
> >>Legacy-free:  Because I don't have to worry about legacy host
> >>controllers, I can ignore limitations drivers/ide cannot.  In
> >>drivers/ide, each host IO (PIO/MMIO) is done via function pointer.  If
> >>your arch has a mach_vec, more function pointers.  Mine does direct
> >>calls to the asm/io.h functions in faster.  So, ATA command submission
> >>is measureably faster.
> >
> >
> > I think it is simply wrong, you should use function pointers.
> > You can have ie. two PCI hosts, one using PIO and one using MMIO.
> >
> > "measureably faster", I doubt.
> > IO operations are REALLY slow when compared to CPU cycles.
>
> You misunderstand.
>
> drivers/ide -- uses function pointers HWIF->outb, etc. inside a static
> taskfile-submit function.  The TF submit functions statically order each
> HWIF->outb() call, and you cannot change that order from the low-level
> driver.
>
> my driver -- uses separate taskfile-submit functions for different hardware.
>
> My method directly uses outb(), writel(), or whatever is necessary.  It
> allows one to use __writel() and barriers to optimize as needed, or to
> support special cache coherency needs.  Further, for SATA and some
> advanced PATA controllers, my method allows one to use a completely
> alien and new taskfile submission method.  For example, building SATA2
> FIS's as an array of u32's, and then queueing that FIS onto a DMA ring.
>   The existing drivers/ide code is nowhere close to that.

Its not that hard, but nevermind.

> Putting it into drivers/ide language, my driver adds a
> HWIF->do_flagged_taskfile hook, and eliminates the HWIF->outb hooks.
> Turns ~13 hook calls into one, from looking at flagged_taskfile.

Okay, I misunderstood.
This is cool, but you are using ie. outb not only in taskfiles.

> And FWIW, I would not state "measureably faster" unless I actually
> benchmarked it.  :)  It's a pittance in the grand scheme of things,
> since you're inevitably limited by device speed, but lower CPU usage is
> something nobody complains about...
>
>
> >>sysfs:  James and co are putting time into getting scsi sysfs right.  I
> >>would rather ride their coattails, and have my driver Just Work with
> >>sysfs and the driver model.
> >
> >
> > No big deal here, ATA will get it too.
>
> Oh agreed.  But scsi is pretty much there now (it's in testing in a BK
> tree), and we're darn close to 2.6.0.
>
>
> >>PIO data transfer is faster and more scheduler-friendly, since it polls
> >>from a kernel thread.
> >
> >
> > CPU polling is faster than IRQs?
>
> Yes, almost always.
>
> The problem with polling is that it chews up CPU if you're not careful,
> starving out other processes.  I'm careful :)

Good.

> >>And for specifically Intel SATA, drivers/ide flat out doesn't work (even
> >>though it claims to).
> >
> >
> > So fix it ;-).
>
> As you can see from the discussion, I think a new driver best serves the
> future of SATA2 as well as today's SATA.  So I'm not gonna bother...  I
> have a driver that works.
>
> If you're interested in working the problem, the result of booting ICH5
> SATA in drivers/ide is a hang at
> 	hdX: attached to ide-disk driver
>
> Nothing happens after that.  sysrq doesn't work, so my assumption was
> that the bus was locked up.
>
>
> >>So, I conclude:  faster, smaller, and better future direction.  IMO, of
> >>course :)
> >
> >
> > And right now ugly and incomplete.
> > IMO, of course ;-).
>
> Incomplete?  Kinda sorta.  SATAPI isn't here yet, so all it needs is
> more fine-grained error handling.  I call it 100% stable now, though.
>
> Ugly?  Compared to drivers/ide?  I actually have a lot of admiration and
> respect for the PATA knowledge embedded in drivers/ide.  But I would
> never call it pretty :)

Silly excuse ;-).

Thanks,
--
Bartlomiej

> 	Jeff

