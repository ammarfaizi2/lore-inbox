Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319820AbSINJ44>; Sat, 14 Sep 2002 05:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319827AbSINJ44>; Sat, 14 Sep 2002 05:56:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:3080 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S319820AbSINJ4w>; Sat, 14 Sep 2002 05:56:52 -0400
Date: Sat, 14 Sep 2002 12:01:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix 2.5.34+swsusp data corruption on IDE
Message-ID: <20020914100145.GA816@atrey.karlin.mff.cuni.cz>
References: <20020913211529.GA25502@elf.ucw.cz> <Pine.LNX.4.10.10209131537190.6925-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10209131537190.6925-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I spoke with Jens, and he wants us to hold off until we can settle the
> current issues.  I have one concern about the model, and maybe you can
> explain away the concern.

Jens, where is the problem? This should have absolutely zero impact on
"interesting" code, making only changes to initialization and
suspend/resume...

> Why are we not blocking read/write requests in the mainloop regardless?
> If the request gets to the subdriver, ide-disk, has it not gotten to far
> down the pipes?

All processes capable of generating requests are safely stopped, so no
request should get down to drivers. That's why I simply BUG_ON(), not
block or anything more sophiscated. It should never ever happen.

> Specifically ls120's and zips.
> 
> I understand you are address disk but suspend is more than disk in the
> power management picture.  Can you walk me through your process of sole
> concern with platter media?  Remember microdrvies are platters too, as are
> flash drives, and memory drives.

High levels are stopped, so there are no new requests coming.

What is needed in idedisk_suspend is to make sure that no requests are
"in flight". DMA scribbling over random memory is not good thing.
idedisk_suspend then sends drive to standby to make sure writeback
caches are flushed.

as ls120s and zips... If they are DMA capable, they badly need
support. If not, they should not kill rest of the system during
suspend-to-disk, but still support would be nice.

> > +static int idedisk_suspend(struct device *dev, u32 state, u32 level)
> > +{
> > +	ide_drive_t *drive = dev->driver_data;
> > +
> > +	/* I hope that every freeze operations from the upper levels have
> > +	 * already been done...
> > +	 */
> > +
> > +	BUG_ON(in_interrupt());
> > +
> > +	if (level != SUSPEND_SAVE_STATE)
> > +		return 0;
> > +
> > +	/* wait until all commands are finished */
> > +	/* FIXME: waiting for spinlocks should be done instead. */
> > +	while (HWGROUP(drive)->handler)
> > +		yield();
> > +
> > +	/* set the drive to standby */
> > +	printk(KERN_INFO "suspending: %s ", drive->name);
> > +	if (drive->driver) {
> > +		if (drive->driver->standby)
> > +			drive->driver->standby(drive);
> > +	}
> > +	drive->blocked = 1;
> > +
> > +	return 0;

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
