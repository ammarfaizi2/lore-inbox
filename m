Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269465AbRHLWNb>; Sun, 12 Aug 2001 18:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269457AbRHLWNW>; Sun, 12 Aug 2001 18:13:22 -0400
Received: from gear.torque.net ([204.138.244.1]:56071 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S269455AbRHLWNI>;
	Sun, 12 Aug 2001 18:13:08 -0400
Message-ID: <3B76FDD3.5BC5B173@torque.net>
Date: Sun, 12 Aug 2001 18:06:11 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT] #2 Support for ~2144 SCSI discs, scsi_debug
In-Reply-To: <200108020642.f726g0L15715@mobilix.ras.ucalgary.ca>
		<3B735FCF.E197DD5B@torque.net>
		<200108100431.f7A4VkG01068@mobilix.ras.ucalgary.ca>
		<3B73D9F0.8BE1B0D1@torque.net> <200108102030.f7AKUfa05113@mobilix.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Douglas Gilbert writes:
> > Richard Gooch wrote:
> > >
> > > Douglas Gilbert writes:
> >
> > > > $ ls -l /devfs/scsi/host46/bus0/target0/lun0/*
> > > > brw-------    1 root     root     114,  16 Dec 31  1969
> > > >                         /devfs/scsi/host46/bus0/target0/lun0/disc
> > > > brw-------    1 root     root     114,  17 Dec 31  1969
> > > >                         /devfs/scsi/host46/bus0/target0/lun0/part1
> > > > brw-------    1 root     root     114,  18 Dec 31  1969
> > > >                         /devfs/scsi/host46/bus0/target0/lun0/part2
> > > > brw-------    1 root     root     114,  19 Dec 31  1969
> > > >                         /devfs/scsi/host46/bus0/target0/lun0/part3
> > > >
> > > > Note the large major device number that devfs is pulling
> > > > from the unused pool. Devfs makes some noise when
> > > > 'rmmod scsi_debug' is executed but otherwise things looked
> > > > ok.
> > >
> > > What was the message?
> >
> > After several seconds of silence, lots of these appeared:
> >  devfs_dealloc_unique_number(): number 128 was already free
> >  devfs_dealloc_unique_number(): number 128 was already free
> 
> I'm not able to debug this for the time being. Could you poke around
> and figure out what's happening? The first thing to check for is to
> see whether block major 128 was even allocated in the first
> place. Check /proc/devices to see (make sure you don't pass devfs=only
> at the boot line).

Richard,
/proc/devices shows the highest major number being used
by sd is 114. So block major 128 is not involved, the 
error message says: "number 128".
 
> Next step is to hack in drivers/scsi/sd.c:sd_alloc_majors() and
> sd_dealloc_majors() and add printk() calls. Is it possible
> sd_dealloc_majors() is being called more than once?

The failure occurs when 'rmmod scsi_debug' is executed.
The sd_dealloc_majors() function is not called during that
period.
 
> Is 128 the only major number that it complains about? Any other
> bitching and moaning?

No just that message 166 times. I have 296 scsi devices in my
test (2 of which are real) and 2+128+166=296 . My guess is the 
failure occurs near devfs_register_partitions() in 
fs/partitions/check.c . Probably best if you load up scsi_debug 
and look at it yourself, I'm moving onto lk 2.4.8

Doug Gilbert

