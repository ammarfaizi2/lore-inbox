Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbSKWBYX>; Fri, 22 Nov 2002 20:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbSKWBYX>; Fri, 22 Nov 2002 20:24:23 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:50952
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S265424AbSKWBYU>; Fri, 22 Nov 2002 20:24:20 -0500
Date: Fri, 22 Nov 2002 17:17:37 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Manish Lachwani <manish@Zambeel.com>
cc: "'Adam Radford'" <aradford@3WARE.com>,
       "'Rod.VanMeter@nokia.com'" <Rod.VanMeter@nokia.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'alan@lxorguk.ukuu.org.uk'" <alan@lxorguk.ukuu.org.uk>
Subject: RE: Early determinition of bad sectors and correcting them ...
In-Reply-To: <233C89823A37714D95B1A891DE3BCE5202AB199E@xch-a.win.zambeel.com>
Message-ID: <Pine.LNX.4.10.10211221709460.13936-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Manish,

The process of any "media scan" is to perform a single sector exclusive
operations series of "read", "write", "verify_read"

The "read" will cause the device to exercise the ECC read correction if
needed.  Here is where those microsecond timers are needed to profile.
Now that one has the data in a buffer (safe copy w/ or w/o ECC correction),
issue the following with a "write once" and test for error.  If success is
returned, follow with a "verify_read".  Since there is no data transfered
in the final execution of the opcode, the drive performs the sum
computation again the media and the buffer cache on the drive.  The 
non-data transfer means nothing was sent back up the ribbon, obvious.

Out side of JBOD mode I am not free to discuss the subject as it relates
to any 3ware products.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 22 Nov 2002, Manish Lachwani wrote:

> Adam,
> 
> I am referring to the JBOD mode. Btw, is the "media scan" feature and the
> ecc remapping feature in the 3ware driver or firmware?
> 
> Thanks
> Manish
> 
> -----Original Message-----
> From: Adam Radford [mailto:aradford@3WARE.com]
> Sent: Friday, November 22, 2002 4:33 PM
> To: 'Manish Lachwani'; 'Rod.VanMeter@nokia.com';
> 'linux-kernel@vger.kernel.org'; 'alan@lxorguk.ukuu.org.uk'
> Subject: RE: Early determinition of bad sectors and correcting them ...
> 
> 
> Manish,
> 
> In the case of 3ware, If you run the 3ware card in raid mode not jbod,
> sectors causing
> ECC errors will be automatically remapped on the fly.  There is also a
> 'Media Scan'
> feature which will cause bad sectors to be remapped as a background task on
> the
> controller while normal IO is running.  
> 
> -Adam
> 
> -----Original Message-----
> From: Manish Lachwani [mailto:manish@Zambeel.com]
> Sent: Friday, November 22, 2002 4:16 PM
> To: Manish Lachwani; 'Rod.VanMeter@nokia.com';
> 'linux-kernel@vger.kernel.org'; 'alan@lxorguk.ukuu.org.uk'
> Subject: RE: Early determinition of bad sectors and correcting them ...
> 
> 
> Btw, I am reffering to IDE drives and IDE controllers (including controllers
> like 3ware) ...
> 
> Thanks
> -Manish
> 
> -----Original Message-----
> From: Manish Lachwani 
> Sent: Friday, November 22, 2002 4:15 PM
> To: 'Rod.VanMeter@nokia.com'; Manish Lachwani;
> linux-kernel@vger.kernel.org; alan@lxorguk.ukuu.org.uk
> Subject: RE: Early determinition of bad sectors and correcting them ...
> 
> 
> Yes, you are right abt taking different factors into account especially
> queuing before making a decision abt the threshold. However, I was actually
> referring to disks only. 
> 
> I have actually written a scrubber that traverses the disk and if it
> encounters a problem with the medium, it tries to get the sector remapped.
> However, the problem with the scrubber is that it will have to traverse all
> the disks in a subsystem. The amount of time it takes to traverse each disk
> is long depending on the size of the disk. We also have to make sure that
> the scrubber process does not take too much CPU when running. 
> 
> Hence if the scrubber traverses accross the disk, it is possible that a
> problem occurs on a sector that the scrubber passed. Then we will have to
> wait for the scrubber to restart the read. 
> 
> Most of the disks support an operating temperature of 60C. However, if we
> are operating at higher temperatures that result in long reads (due to shaky
> medium at higher temperatures), this facility is good. 
> 
> -----Original Message-----
> From: Rod.VanMeter@nokia.com [mailto:Rod.VanMeter@nokia.com]
> Sent: Friday, November 22, 2002 3:54 PM
> To: manish@zambeel.com; linux-kernel@vger.kernel.org;
> alan@lxorguk.ukuu.org.uk
> Subject: RE: Early determinition of bad sectors and correcting them ...
> 
> 
> I won't comment on the code, but I'll note that there
> are legitimate reasons why a read can take a long time:
> drive spin-up (if it has been spun down), queued commands
> (if the device supports them), slow devices (e.g., some
> removable media), very large commands, the occasional
> thermal recalibration all come to mind immediately.
> 
> It would be great if we had this functionality, and even
> better if we had it for all devices.
> 
> On at least some SCSI devices, it's possible to set a
> parameter in the device that sets a threshold for how
> severe an error to report (ECC errors are not a one-
> dimensional thing).  Unfortunately, it's pretty device
> dependent.  I would be nice, when you care about your
> data, to set the threshold very sensitive.  Then when
> an error occurs, you get notified, and you can retry
> or rewrite the block.
> 
> A slightly different approach is an idle scrubber, that
> reads all of your blocks when the system is idle, looking
> for errors and rewriting as necessary.
> 
> Note that in either case, it doesn't come for free and
> doesn't really guarantee your data; a power loss or
> other problem in the middle of the bad-block-rewrite
> can cause problems, and writes fail more often than
> reads.
> 
> 		--Rod
> 
> > -----Original Message-----
> > From: ext Manish Lachwani [mailto:manish@Zambeel.com]
> > Sent: Friday, November 22, 2002 11:33 AM
> > To: linux-kernel@vger.kernel.org; 'Alan Cox'
> > Cc: Manish Lachwani
> > Subject: Early determinition of bad sectors and correcting them ...
> > 
> > 
> > I had thought abt this earlier and tried to implemented it.
> > 
> > Everytime there is an ECC error (0x40), there is a pending 
> > set of sectors
> > that the drive needs to remap. The drive can map the sectors 
> > as part of its
> > house keeping function or the drive can remap it when an 
> > explicit write is
> > made to that sector. Once an ECC error occurs, the remapping 
> > process is
> > manual or we have to wait till an write operation takes place to that
> > sector. 
> > 
> > If a READ gives an ECC error, the amount of time it takes to 
> > read is usually
> > higher as compared to READ operations accross sectors that 
> > are good. Even
> > for a sector or a region of sectors that are degrading over 
> > time, the READ
> > time is a good indication that the sector is deteriorating. A 
> > write to that
> > sector will fix the problem.
> > 
> > Based on the above, I modified the ide driver to implement this simple
> > change. I created a sysctl entry called 
> > ide_disk_delay_threshold which is
> > initially set to 250 ms. In ide-dma.c, I measure the amount 
> > of time it takes
> > to complete a READ request:
> > 
> > 	drive->service_time = jiffies - drive->service_start;
> > 	if (rq->cmd == READ && (ide_disk_delay_threshold > 0) &&
> >             ( (drive->service_time*10) > ide_disk_delay_threshold) ) {
> >         printk("%s: re-write, ", drive->name);
> >         printk("READ took %d ms \n", drive->service_time*10);
> >         /*
> >          * Set the command to write
> >          */
> >         rq->cmd = WRITE;
> >         return ide_stopped;
> >        }
> > 
> > I have tested the above and I have found that everytime I get 
> > accross an ECC
> > error (0x40), the driver immediately writes to that location 
> > remapping that
> > sector. This way, I get away with the bad sectors. The 
> > threshold 250 ms can
> > be changed depending on the application or requirement. But, 
> > it seems to be
> > a good indicator for early prediction of bad sectors ...
> > 
> > Thanks
> > -Manish
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

