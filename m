Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbVIVOPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbVIVOPZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 10:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbVIVOPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 10:15:25 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:5323 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030365AbVIVOPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 10:15:24 -0400
Subject: Re: [RFC/BUG?] ide_cs's removable status
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Mark Lord <liml@rtr.ca>, Richard Purdie <rpurdie@rpsys.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com,
       linux-ide@vger.kernel.org
In-Reply-To: <20050922132941.GA26438@flint.arm.linux.org.uk>
References: <1127319328.8542.57.camel@localhost.localdomain>
	 <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca>
	 <1127327243.18840.34.camel@localhost.localdomain>
	 <20050921192932.GB13246@flint.arm.linux.org.uk>
	 <1127347845.18840.53.camel@localhost.localdomain>
	 <20050922102221.GD16949@flint.arm.linux.org.uk>
	 <1127396382.18840.79.camel@localhost.localdomain>
	 <20050922132941.GA26438@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Sep 2005 15:41:36 +0100
Message-Id: <1127400096.18840.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-22 at 14:29 +0100, Russell King wrote:
> the whole lot isn't garbage, just some parts of it?

Bits.

> I'm wondering if your first adapter is somehow "inteligent" and isn't
> operating the CF card in "PCMCIA" mode.  If this is the case, PCMCIA
> should be more inteligent about it than it currently is - telling IDE
> that the media is replaceable when the interface is registered.

It isn't being intelligent, its being dumb. I've not seen a smart
PCMCIA<->CF convertor. USB ones yes but not PCMCIA.

> There is another concern I have in all this, one which seems to have
> been completely missed.  Yes we do this partition rescanning each time
> a "removable" IDE device is opened, but do we re-read the identity?

Don't think so - and just tested - we don't. Its totally [select an
expletive]ed if I do that. the /proc/ide identify data and the dumped
ident data directly from ide are different.

> > The pcmcia ide floppy (40MB clik! drive if anyone
> > wants to play) I have always shows up as present. It triggers the same
> > hotplug behaviour being complained about as far as I can see and
> > correctly so.
> 
> Not having a clik drive, but "ide floppy" sounds like standard floppy
> behaviour - the "other" class of hotplug where the media is replaceable
> independent of the controller itself, so this is a slightly different
> problem, and one which we handle correctly.

We generate hot plug events when scanning the partition tables each
time. So you'd get the same loops - or am I misunderstanding something
here about what you mean by "correctly" ?

So in fact its not a case of ->removable but that IDE wants to seperate
->removable and ->mightgoaway. That lets us fix the broken cache flush
behaviour with modern media monitoring tools.

ie change idedisk_release to do

    if(drive->mightgoaway||drive->usage==1) ide_cacheflush_p(drive)

then
    if(drive->doorlocking && drive->usage == 1)

Syquests (real removable IDE disk) will have drive->doorlocking = 1 set
PCMCIA will have drive->mightgoaway set so will flush

(and M/O disks are ide-scsi or ide-cd so not affected)

The first change is needed because currently several control apps may
hold the disk open for media change detection, SMART and the like and if
they do so the user perceived "close" - end of a raw I/O access or
umount return will not media flush.

Alan

