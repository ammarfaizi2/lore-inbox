Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265769AbUFDMhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265769AbUFDMhn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 08:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265775AbUFDMhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 08:37:42 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:34734 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265769AbUFDMhW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 08:37:22 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: DriveReady SeekComplete Error
Date: Fri, 4 Jun 2004 14:40:48 +0200
User-Agent: KMail/1.5.3
Cc: mattia <mattia@nixlab.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <E1BWBjw-0003QZ-1h@andromeda.hostvector.com> <200406041415.36566.bzolnier@elka.pw.edu.pl> <20040604121711.GZ1946@suse.de>
In-Reply-To: <20040604121711.GZ1946@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406041440.48695.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 of June 2004 14:17, Jens Axboe wrote:
> On Fri, Jun 04 2004, Bartlomiej Zolnierkiewicz wrote:
> > On Friday 04 of June 2004 13:56, Jens Axboe wrote:
> > > On Fri, Jun 04 2004, Bartlomiej Zolnierkiewicz wrote:
> > > > On Friday 04 of June 2004 12:22, Jens Axboe wrote:
> > > > > damnit, don't trim the cc list!
> > > > >
> > > > > On Fri, Jun 04 2004, mattia wrote:
> > > > > > I have the following error (kernel 2.6.6):
> > > > > >
> > > > > > Jun  4 08:05:43 blink kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > > > > > Jun  4 08:05:43 blink kernel: hdc: Maxtor 6Y160P0, ATA DISK drive
> > > > > > Jun  4 08:05:43 blink kernel: hdd: Maxtor 6Y120L0, ATA DISK drive
> > > > > > Jun  4 08:05:43 blink kernel: ide1 at 0x170-0x177,0x376 on irq 15
> > > > > > Jun  4 08:05:43 blink kernel: hda: max request size: 128KiB
> > > > > > Jun  4 08:05:43 blink kernel: hda: 78177792 sectors (40027 MB)
> > > > > > w/1819KiB Cache, CHS=65535/16/63, UDMA(100)
> > > > > > Jun  4 08:05:43 blink kernel:  hda: hda1 hda2 hda3
> > > > > > Jun  4 08:05:43 blink kernel: hdc: max request size: 1024KiB
> > > > > > Jun  4 08:05:43 blink kernel: hdc: 320173056 sectors (163928 MB)
> > > > > > w/7936KiB Cache, CHS=19929/255/63, UDMA(100)
> > > > > > Jun  4 08:05:43 blink kernel:  hdc: hdc1
> > > > > > Jun  4 08:05:43 blink kernel: hdd: max request size: 128KiB
> > > > > > Jun  4 08:05:43 blink kernel: hdd: 240121728 sectors (122942 MB)
> > > > > > w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
> > > > > > Jun  4 08:05:43 blink kernel:  hdd: hdd1 hdd2 hdd3
> > > > > > Jun  4 08:05:43 blink kernel: hdd: task_no_data_intr: status=0x51
> > > > > > { DriveReady SeekComplete Error }
> > > > > > Jun  4 08:05:43 blink kernel: hdd: task_no_data_intr: error=0x04
> > > > > > { DriveStatusError }
> > > > > > Jun  4 08:05:43 blink kernel: hdd: Write Cache FAILED Flushing!
> > > > > >
> > > > > >
> > > > > > I found somewhere that's something wrong with that maxtor drive.
> > > > > > However, everything works fine.
> > > > >
> > > > > There's nothing wrong with the drive technically, it's just odd
> > > > > (lba48 without FLUSH_CACHE_EXT). It's really a linux ide bug that's
> > > > > fixed in newer kernels. 2.6.7 will fix your problem.
> > > >
> > > > Wrong.
> > > >
> > > > Bug is a combination of a very minor firmware quirk
> > > > and lack of strict checking in Linux IDE driver.
> > > >
> > > > FLUSH_CACHE_EXT bit is set but it is not supported
> > > > (but it is not a problem because LBA48 is not supported also).
> > >
> > > Ah my bad, I didn't realize this bit was actually set correctly (you
> > > mean (cfs_enable_2 & 0x2400) == 0x2400 is actually true?).
> >
> > Yes but only on unaffected drives. ;-)
> >
> > 0x2000 is FLUSH_CACHE_EXT support
> > 0x0400 is LBA48 support
> >
> > Affected drives have 0x2000 set incorrectly so we have to check also
> > 0x0400. (== 0x2400 is needed because & 0x2400 is true if & 0x2000 OR if &
> > 0x0400).
> >
> > Everything is explained in the patch changelog:
> > | - many Maxtor disks incorrectly claim CACHE FLUSH EXT command support,
> > |   fix it by checking both CACHE FLUSH EXT command and LBA48 support
> > |   (thanks to Eric D. Mudama for help in fixing this)
> >
> > and in the patch itself:
> >
> > +/* some Maxtor disks have bit 13 defined incorrectly so check bit 10 too
> > */ +#define ide_id_has_flush_cache_ext(id)	\
> > +	(((id)->cfs_enable_2 & 0x2400) == 0x2400)
>
> Ok, so I didn't miss anything. Was just wondering because of your
> comment on -mm2.
>
> > > > It is fixed in 2.6.7-rc1 but your IDE barrier patch has this problem
> > > > (just reminding you that it is still not fixed in 2.6.7-rc2-mm2).
> > >
> > > So where's the bug? I don't see it...
> >
> > ide_fill_flush_cmd()
> >
> > +	if (drive->id->cfs_enable_2 & 0x2400)
> > +		rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
>
> Just checked a fresh copy of 2.6.7-rc2-mm2, and it has it correctly:
>
> static void ide_fill_flush_cmd(ide_drive_t *drive, struct request *rq)
> {
>         char *buf = rq->cmd;
>
>         /*
>          * reuse cdb space for ata command
>          */
>         memset(buf, 0, sizeof(rq->cmd));
>
>         rq->flags |= REQ_DRIVE_TASK | REQ_STARTED;
>         rq->buffer = buf;
>         rq->buffer[0] = WIN_FLUSH_CACHE;
>
>         if (ide_id_has_flush_cache_ext(drive->id))
>                 rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
> }
>
> So that's why I didn't follow what you meant, there should be no problem
> here. You are reading disk-barrier-ide.patch, barrier-update.patch is
> applied on top of that.

Hehe, indeed, my bad.

> So we are back to step 1, why is his drive complaining. I'm guessing it

Yep.

> doesn't have write back caching enabled and aborts the flush on those
> grounds - Ed, what is the output of hdparm -i on your booted system?

