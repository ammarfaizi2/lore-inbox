Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287681AbSBGMlj>; Thu, 7 Feb 2002 07:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287676AbSBGMkj>; Thu, 7 Feb 2002 07:40:39 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:13843 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S287710AbSBGMka>; Thu, 7 Feb 2002 07:40:30 -0500
Date: Thu, 7 Feb 2002 13:40:25 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>, vojtech@ucw.cz
Subject: Re: ide cleanup
Message-ID: <20020207124025.GG5247@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020206205332.GA3217@elf.ucw.cz> <Pine.LNX.4.10.10202061928220.8641-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10202061928220.8641-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Since you have not the input or insight to why it was expanded maybe you
> should just leave it alone.  Since I am working on how to fix the
> MUNGE/KLUDGE that was added to make the PIO work, just maybe you may want
> rething the rathole you just created by attempting to compress the code
> before it is finished.  What you doing is BORKING the driver to the point
> where adding in the TCQ will not work.  Next you have screwed the future
> interface for Serial ATA.

I'm pretty sure I did not BORK anything. If I did BORK anything, show
me. If you need modified version, you can always just inline it;
programming with cut-copy-paste is bad, *always*.

Perhaps you should clean the drivers up before continuing
development. What is in drivers/ide is a mess. 

I need driverfs support in drivers/ide, but code is such a pain to
look at that it is neccessary to clean it up first.

Let's take a look:

> >  static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
> >  {
> > -	if (rq->flags & REQ_CMD)
> > -		goto good_command;
> > -
> > -	blk_dump_rq_flags(rq, "do_rw_disk, bad command");
> > -	ide_end_request(0, HWGROUP(drive));
> > -	return ide_stopped;
> > -
> > -good_command:

Goto without reason.

> > -#ifdef CONFIG_BLK_DEV_PDC4030
> >  	if (IS_PDC4030_DRIVE) {
> >  		extern ide_startstop_t promise_rw_disk(ide_drive_t *, struct request *, unsigned long);
> >  		return promise_rw_disk(drive, rq, block);
> >  	}
> > -#endif /* CONFIG_BLK_DEV_PDC4030 */

Completely unneccessary ifdef.

> > +static int get_sectors (ide_drive_t *drive, struct request *rq, task_ioreg_t command)
> > +{
> > +	int sectors = rq->nr_sectors;
> > +
> > +	if (sectors == 256)
> > +		sectors = 0;
> > +	if (command == WIN_MULTWRITE_EXT || command == WIN_MULTWRITE) {
> > +		sectors = drive->mult_count;
> > +		if (sectors > rq->current_nr_sectors)
> > +			sectors = rq->current_nr_sectors;
> > +	}
> > +	return sectors;
> > +}

Get_sectors was included 3 times below. That makes you wonder that
maybe there are small changes there? No, they were not.

> > @@ -186,17 +205,10 @@
> >  	unsigned int head	= (track % drive->head);
> >  	unsigned int cyl	= (track / drive->head);
> >  
> > -	memset(&taskfile, 0, sizeof(task_struct_t));

taskfile was defined as struct hd_drive_task_hdr, above. Very nice way
how to obfuscate code.

> > -	rq->special		= NULL;
> > -	rq->special		= (ide_task_t *)&args;

Two assignments to same variable [yep, these lines are just below each
other], and unneccessary cast as a bonus. [Unneccessary casts are
dangerous: they hide real errors.]

> > -	void		  *hwif;	/* actually (ide_hwif_t *) */
...
> > -	void 		*driver;	/* (ide_driver_t *) */

Two unneccessary pointers. Makes me wonder if original author knew C?
[how old is this code, btw?]

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
