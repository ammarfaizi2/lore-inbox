Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSINUhi>; Sat, 14 Sep 2002 16:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSINUhi>; Sat, 14 Sep 2002 16:37:38 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:10257
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316683AbSINUhg>; Sat, 14 Sep 2002 16:37:36 -0400
Date: Sat, 14 Sep 2002 13:40:18 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix 2.5.34+swsusp data corruption on IDE
In-Reply-To: <20020914100145.GA816@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.10.10209141002020.6925-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Sep 2002, Pavel Machek wrote:

> Hi!
> 
> > I spoke with Jens, and he wants us to hold off until we can settle the
> > current issues.  I have one concern about the model, and maybe you can
> > explain away the concern.
> 
> Jens, where is the problem? This should have absolutely zero impact on
> "interesting" code, making only changes to initialization and
> suspend/resume...

I think we are looking to settle current problems before adding anything
else in the mix.  It will go in somehow, okay.

> > Why are we not blocking read/write requests in the mainloop regardless?
> > If the request gets to the subdriver, ide-disk, has it not gotten to far
> > down the pipes?
> 
> All processes capable of generating requests are safely stopped, so no
> request should get down to drivers. That's why I simply BUG_ON(), not
> block or anything more sophiscated. It should never ever happen.

You have to qualify it to R/W, and that has to be done high than where it
is now.  What you can not block is the command to reset; regardless, if it
is soft or hard.  This is how you wake a device, then you have to clean up
the mess resulting from the reset.

> > Specifically ls120's and zips.
> > 
> > I understand you are address disk but suspend is more than disk in the
> > power management picture.  Can you walk me through your process of sole
> > concern with platter media?  Remember microdrvies are platters too, as are
> > flash drives, and memory drives.
> 
> High levels are stopped, so there are no new requests coming.

Where?

> What is needed in idedisk_suspend is to make sure that no requests are
> "in flight". DMA scribbling over random memory is not good thing.
> idedisk_suspend then sends drive to standby to make sure writeback
> caches are flushed.

Well then you need to block the queue and the hold until the device goes
idle via check-power.  Then Flush-Cache, and repeat the host idle check
until valid.  Otherwise you have no way to insure all data is down.

Do you disagree with this point?

> as ls120s and zips... If they are DMA capable, they badly need
> support. If not, they should not kill rest of the system during
> suspend-to-disk, but still support would be nice.

hdc: ATAPI DVD-ROM DVD-RAM drive, 1024kB Cache, UDMA(33)

RAM is a r/w media.

 Model=MATSHITADVD-RAM LF-D210, FwRev=A106, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:180,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2
 AdvancedPM=no
 Drive Supports : Reserved : ATA-4

hdg: 123264kB, 963/8/32 CHS, 533 kBps, 512 sector size, 720 rpm, DMA

 Model=LS-120 VER5 00 UHD Floppy, FwRev=F523M5A9, SerialNo=9727M9A01951
 Config={ Removeable nonMagnetic }
 RawCHS=963/8/32, TrkSize=49, SectSize=512, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 CurCHS=963/8/32, CurSects=3353542659, LBA=yes, LBAsects=3271557123
 IORDY=yes, tPIO={min:180,w/IORDY:180}, tDMA={min:150,rec:150}
 PIO modes: pio0 pio1 pio2 pio3
 DMA modes: sdma0 sdma1 mdma0 *mdma1
 AdvancedPM=no

Here are two types of media which use DMA and are read/write native.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

> > > +static int idedisk_suspend(struct device *dev, u32 state, u32 level)
> > > +{
> > > +	ide_drive_t *drive = dev->driver_data;
> > > +
> > > +	/* I hope that every freeze operations from the upper levels have
> > > +	 * already been done...
> > > +	 */
> > > +
> > > +	BUG_ON(in_interrupt());
> > > +
> > > +	if (level != SUSPEND_SAVE_STATE)
> > > +		return 0;
> > > +
> > > +	/* wait until all commands are finished */
> > > +	/* FIXME: waiting for spinlocks should be done instead. */
> > > +	while (HWGROUP(drive)->handler)
> > > +		yield();
> > > +
> > > +	/* set the drive to standby */
> > > +	printk(KERN_INFO "suspending: %s ", drive->name);
> > > +	if (drive->driver) {
> > > +		if (drive->driver->standby)
> > > +			drive->driver->standby(drive);
> > > +	}
> > > +	drive->blocked = 1;
> > > +
> > > +	return 0;
> 
> -- 
> Casualities in World Trade Center: ~3k dead inside the building,
> cryptography in U.S.A. and free speech in Czech Republic.
> 

Andre Hedrick
LAD Storage Consulting Group


