Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVCAJ74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVCAJ74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 04:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVCAJ74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 04:59:56 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:2378 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261847AbVCAJ7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 04:59:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=fiO7wkiJCwvQt/3zXNezFYPewbXri8ICiq4sZcvUxiHdSMzWRC2yGMtmO2eroaPquyf4IklTrhJeiFoH73xkdS+xPpl6r0fu0oAq1J/Xj48KCoM35rXX4emekVqL6MYlfYQWBYEABFyBN0jX4J4RI8RqN9sEYPFbQDnilCHZwUE=
Message-ID: <58cb370e05030101592a46c258@mail.gmail.com>
Date: Tue, 1 Mar 2005 10:59:36 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch ide-dev 8/9] make ide_task_ioctl() use REQ_DRIVE_TASKFILE
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050301092914.GA14007@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.GSO.4.58.0502241547400.13534@mion.elka.pw.edu.pl>
	 <200502271731.29448.bzolnier@elka.pw.edu.pl>
	 <422337A1.4060806@gmail.com>
	 <200502281714.55960.bzolnier@elka.pw.edu.pl>
	 <20050301042116.GA9001@htj.dyndns.org>
	 <58cb370e05030100424d98c85c@mail.gmail.com>
	 <20050301092914.GA14007@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2005 18:29:15 +0900, Tejun Heo <htejun@gmail.com> wrote:
>  Hello,
> 
> On Tue, Mar 01, 2005 at 09:42:18AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > Hello,
> >
> > On Tue, 1 Mar 2005 13:21:16 +0900, Tejun Heo <htejun@gmail.com> wrote:
> > >
> > >  So, how do you like the following set of TFLAG's?
> > >
> > > /* struct ata_taskfile flags */
> > >
> > > /* The following six flags are used by IDE driver to control register IO. */
> > > ATA_TFLAG_OUT_LBA48             = (1 <<  0), /* enable 48-bit LBA and HOB out */
> >
> > aggregate ATA_TFLAG_OUT_HOB_LBA{L,M,H}?
> >
> > > ATA_TFLAG_OUT_ADDR              = (1 <<  1), /* enable out to nsect/lba regs */
> >
> > not needed currently, add it {when,if} it is needed
> >
> 
>  Sure, I'll add flags on as-needed basis.  I was trying to show where
> I'm heading.
> 
> > > ATA_TFLAG_OUT_DEVICE            = (1 <<  2), /* enable out to device reg */
> > > ATA_TFLAG_IN_LBA48              = (1 <<  3), /* enable 48-bit LBA and HOB in */
> >
> > aggregate ATA_TFLAG_IN_HOB_LBA_{L,M,H}?
> >
> > > ATA_TFLAG_IN_ADDR               = (1 <<  4), /* enable in from nsect/lba regs */
> >
> > not needed currently, add it {when,if} it is needed
> >
> > > ATA_TFLAG_IN_DEVICE             = (1 <<  5), /* enable in from device reg */
> > >
> > > /* These three aggregate flags are used by libata, as it doesn't
> > >    really need to optimize register INs */
> > > ATA_TFLAG_LBA48                 = (ATA_TFLAG_OUT_LBA48  | ATA_TFLAG_IN_LBA48),
> > > ATA_TFLAG_ISADDR                = (ATA_TFLAG_OUT_ADDR   | ATA_TFLAG_IN_ADDR),
> > > ATA_TFLAG_DEVICE                = (ATA_TFLAG_OUT_DEVICE | ATA_TFLAG_IN_DEVICE),
> > >
> > > ATA_TFLAG_WRITE                 = (1 <<  6), /* data dir */
> > >
> > > /* The rest of TFLAGs are only for implementing ioctl direct drive
> > >    commands in the IDE driver.  DO NOT use in other places. */
> > > ATA_TFLAG_IO_16BIT              = (1 << 11),
> > >
> > > ATA_TFLAG_OUT_FEATURE           = (1 << 12),
> > > ATA_TFLAG_OUT_NSECT             = (1 << 13),
> > > ATA_TFLAG_OUT_LBAL              = (1 << 14),
> > > ATA_TFLAG_OUT_LBAM              = (1 << 15),
> > > ATA_TFLAG_OUT_LBAH              = (1 << 16),
> > > ATA_TFLAG_OUT_HOB_FEATURE       = (1 << 17),
> > > ATA_TFLAG_OUT_HOB_NSECT         = (1 << 18),
> > > ATA_TFLAG_OUT_HOB_LBAL          = (1 << 19),
> > > ATA_TFLAG_OUT_HOB_LBAM          = (1 << 20),
> > > ATA_TFLAG_OUT_HOB_LBAH          = (1 << 21),
> > >
> > > ATA_TFLAG_IN_FEATURE            = (1 << 22),
> > > ATA_TFLAG_IN_NSECT              = (1 << 23),
> > > ATA_TFLAG_IN_LBAL               = (1 << 24),
> > > ATA_TFLAG_IN_LBAM               = (1 << 25),
> > > ATA_TFLAG_IN_LBAH               = (1 << 26),
> > > ATA_TFLAG_IN_HOB_FEATURE        = (1 << 27),
> > > ATA_TFLAG_IN_HOB_NSECT          = (1 << 28),
> > > ATA_TFLAG_IN_HOB_LBAL           = (1 << 29),
> > > ATA_TFLAG_IN_HOB_LBAM           = (1 << 30),
> > > ATA_TFLAG_IN_HOB_LBAH           = (1 << 31),
> >
> > proposed changes will get rid of 4 bits
> >
> > > ATA_TFLAG_OUT_MASK              = 0x007ff000,
> > > ATA_TFLAG_IN_MASK               = 0xffc00000,
> > > ATA_TFLAG_OUT_IN_MASK           = (ATA_TFLAG_OUT_MASK | ATA_TFLAG_IN_MASK),
> > >
> > >  ATA_TFLAG_{OUT|IN}_{LBA48|ADDR|DEVICE} should provide enough
> > > granuality for fs/internal requests without much hassle, and
> > > individual IO/OUT flags will only be used to implement ioctls in
> > > separate IN/OUT functions, something like ide_{load|read}_ioctl_task().
> >
> > They would be later used by IDE driver itself so names
> > like ide_discrete_tf_{load,read}() suits it better IMHO.
> >
> > >  Would using more specific prefix for ioctl flags - like
> > > ATA_TFLAG_IOC_{IN|OUT}_* - be better?
> >
> > Nope, they are not limited to ioctls by design.
> >
> 
>  The reason why I separated the flags into two sets is that if we
> define IO flags as aggregate of separate flags, we'll end up with
> do_rw_taskfile() or something equivalent which handle both normal
> (fs/kernel-internal) and ioctl taskfiles, by design.  From previous
> discussions, I kind of have the impression that you wanna separate the
> fully-flagged taskfile handling from the normal, supposedly simpler,
> taskfile handling.  So, I was aiming for IO control flags with similar
> granuality w/ the current libata implementation.

Yes but it seems that you've assumed that ioctl == flagged taskfile
and fs/internal == normal taskfile which is _not_ what I aim for.

I want fully-flagged taskfile handling like flagged_taskfile() and "hot path"
simpler taskfile handling like do_rw_taskfile() (at least for now - we can
remove "hot path" later) where both can be used for fs/internal/ioctl requests
(depending on the flags).

>  IMHO, handling both in the same path is better.  It would be
> simpler/cleaner and, with simple optimizations, there would be
> virtually no overhead.

We can check this later.

>  So, here's the second proposal of the flags.
> 
> /* struct ata_taskfile flags */
> 
> /* Individual register IO control flags */
> ATA_TFLAG_OUT_FEATURE           = (1 <<  0),
> ATA_TFLAG_OUT_NSECT             = (1 <<  1),
> ATA_TFLAG_OUT_LBAL              = (1 <<  2),
> ATA_TFLAG_OUT_LBAM              = (1 <<  3),
> ATA_TFLAG_OUT_LBAH              = (1 <<  4),
> ATA_TFLAG_OUT_HOB_FEATURE       = (1 <<  5),
> ATA_TFLAG_OUT_HOB_NSECT         = (1 <<  6),
> ATA_TFLAG_OUT_HOB_LBAL          = (1 <<  7),
> ATA_TFLAG_OUT_HOB_LBAM          = (1 <<  8),
> ATA_TFLAG_OUT_HOB_LBAH          = (1 <<  9),
> ATA_TFLAG_OUT_DEVICE            = (1 << 10),
> 
> ATA_TFLAG_IN_FEATURE            = (1 << 11),
> ATA_TFLAG_IN_NSECT              = (1 << 12),
> ATA_TFLAG_IN_LBAL               = (1 << 13),
> ATA_TFLAG_IN_LBAM               = (1 << 14),
> ATA_TFLAG_IN_LBAH               = (1 << 15),
> ATA_TFLAG_IN_HOB_FEATURE        = (1 << 16),
> ATA_TFLAG_IN_HOB_NSECT          = (1 << 17),
> ATA_TFLAG_IN_HOB_LBAL           = (1 << 18),
> ATA_TFLAG_IN_HOB_LBAM           = (1 << 19),
> ATA_TFLAG_IN_HOB_LBAH           = (1 << 20),
> ATA_TFLAG_IN_DEVICE             = (1 << 21),
> 
> /* The following four aggreate flags are used by IDE to control register IO. */
> ATA_TFLAG_OUT_LBA48             = (ATA_TFLAG_OUT_HOB_FEATURE    |
>                                    ATA_TFLAG_OUT_HOB_NSECT      |
>                                    ATA_TFLAG_OUT_HOB_LBAL       |
>                                    ATA_TFLAG_OUT_HOB_LBAM       |
>                                    ATA_TFLAG_OUT_HOB_LBAH       ),
> ATA_TFLAG_OUT_ADDR              = (ATA_TFLAG_OUT_FEATURE        |
>                                    ATA_TFLAG_OUT_NSECT          |
>                                    ATA_TFLAG_OUT_LBAL           |
>                                    ATA_TFLAG_OUT_LBAM           |
>                                    ATA_TFLAG_OUT_LBAH           ),
> ATA_TFLAG_IN_LBA48              = (ATA_TFLAG_IN_HOB_FEATURE     |
>                                    ATA_TFLAG_IN_HOB_NSECT       |
>                                    ATA_TFLAG_IN_HOB_LBAL        |
>                                    ATA_TFLAG_IN_HOB_LBAM        |
>                                    ATA_TFLAG_IN_HOB_LBAH        ),
> ATA_TFLAG_IN_ADDR               = (ATA_TFLAG_IN_FEATURE         |
>                                    ATA_TFLAG_IN_NSECT           |
>                                    ATA_TFLAG_IN_LBAL            |
>                                    ATA_TFLAG_IN_LBAM            |
>                                    ATA_TFLAG_IN_LBAH            ),
> 
> /* These three aggregate flags are used by libata, as it doesn't
>    really need to optimize register INs */
> ATA_TFLAG_LBA48                 = (ATA_TFLAG_OUT_LBA48  | ATA_TFLAG_IN_LBA48 ),
> ATA_TFLAG_ISADDR                = (ATA_TFLAG_OUT_ADDR   | ATA_TFLAG_IN_ADDR  ),
> ATA_TFLAG_DEVICE                = (ATA_TFLAG_OUT_DEVICE | ATA_TFLAG_IN_DEVICE),
> 
> ATA_TFLAG_WRITE                 = (1 << 22), /* data dir */
> ATA_TFLAG_IO_16BIT              = (1 << 23), /* force 16bit pio (IDE) */

s/pio/PIO/

This version look perfect, at least from IDE driver POV. :-)
 
Thanks,
Bartlomiej
