Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291539AbSBMKkD>; Wed, 13 Feb 2002 05:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291541AbSBMKjz>; Wed, 13 Feb 2002 05:39:55 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:40457 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291539AbSBMKjg>; Wed, 13 Feb 2002 05:39:36 -0500
Date: Wed, 13 Feb 2002 11:39:28 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
Message-ID: <20020213113928.A31254@suse.cz>
In-Reply-To: <20020213083000.C30588@suse.cz> <Pine.LNX.4.10.10202122325000.668-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10202122325000.668-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Tue, Feb 12, 2002 at 11:27:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 11:27:42PM -0800, Andre Hedrick wrote:
> On Wed, 13 Feb 2002, Vojtech Pavlik wrote:
> 
> > On Tue, Feb 12, 2002 at 09:52:07PM -0800, Andre Hedrick wrote:
> > 
> > > HELL NO!
> > 
> > Hell why?
> 
> Does Virtual DMA mean anything?

Sure. Virtual-Direct-Marketing-Association, then there is the VDS,
Vitrual-DMA-Services, which is a DOS DMA access specification, then
there is the VDMA on PCI - this is a term used for normal PCI BM DMA
passing through an IOMMU-capable bridge. Then there is Virtual-DMA on
floppy controllers and NE*000's - which allows feeding the data to the
card via PIO when there is no ISA DMA controller available in the
system.

None of this is relevant to IDE on Linux.

Perhaps you mean PIO using SG-lists to put the data into the right
places. But I still don't see a problem with this and the proposed patch.

> Does a function struct for handling IO and MMIO help?

Ugh? What is "function struct"?

> All you two are doing is causing more work for me to build a working
> model.

It's possible - but then that is because we have different development
strategies. Ours is to start with minimum code and if something needs to
be made different, then duplicate and edit that. But only when needed.
Yours seems to be to duplicate everything first, make the changes and
then look at what can be merged.

In theory they both give the same results.

I don't think that happen's in reality. Duplicating first never gets
merged together later, as many tiny differences emerge. Believe me, I
know this - this already happened many times in the kernel and is a huge
amount of work to undo - keep shared code shared.

> But it is clear you must poke and screw things up, so I will continue to
> undo it in my trees until I have it working.

If you think so, sure, you're free to do that.

> > > On Mon, 11 Feb 2002, Pavel Machek wrote:
> > > 
> > > > Hi!
> > > > 
> > > > This is slightly longer but also simple cleanup. It kills code
> > > > duplication and removes unneccessary assignments/casts. Please apply,
> > > > 
> > > > 								Pavel
> > > > 
> > > > --- clean-pre3/drivers/ide/ide-disk.c	Sat Feb  9 23:00:02 2002
> > > > +++ linux-dm-pre3/drivers/ide/ide-disk.c	Sun Feb 10 00:06:31 2002
> > > > @@ -172,6 +167,16 @@
> > > >  		return WIN_NOP;
> > > >  }
> > > >  
> > > > +static void fill_args (ide_task_t *args, struct hd_drive_task_hdr *taskfile, struct hd_drive_hob_hdr *hobfile)
> > > > +{
> > > > +	memcpy(args->tfRegister, taskfile, sizeof(struct hd_drive_task_hdr));
> > > > +	memcpy(args->hobRegister, hobfile, sizeof(struct hd_drive_hob_hdr));
> > > > +	args->command_type	= ide_cmd_type_parser(args);
> > > > +	args->prehandler	= ide_pre_handler_parser(taskfile, hobfile);
> > > > +	args->handler		= ide_handler_parser(taskfile, hobfile);
> > > > +	args->posthandler	= NULL;
> > > > +}
> > > > +
> > > >  static ide_startstop_t chs_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
> > > >  {
> > > >  	struct hd_drive_task_hdr	taskfile;
> > > > @@ -210,16 +215,10 @@
> > > >  	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
> > > >  #endif
> > > >  
> > > > -	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
> > > > -	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
> > > > -	args.command_type	= ide_cmd_type_parser(&args);
> > > > -	args.prehandler		= ide_pre_handler_parser(&taskfile, &hobfile);
> > > > -	args.handler		= ide_handler_parser(&taskfile, &hobfile);
> > > > -	args.posthandler	= NULL;
> > > > -	args.rq			= (struct request *) rq;
> > > > +	fill_args(&args, &taskfile, &hobfile);
> > > > +	args.rq			= rq;
> > > >  	args.block		= block;
> > > > -	rq->special		= NULL;
> > > > -	rq->special		= (ide_task_t *)&args;
> > > > +	rq->special		= &args;
> > > >  
> > > >  	return do_rw_taskfile(drive, &args);
> > > >  }
> > > > @@ -257,16 +255,10 @@
> > > >  	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
> > > >  #endif
> > > >  
> > > > -	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
> > > > -	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
> > > > -	args.command_type	= ide_cmd_type_parser(&args);
> > > > -	args.prehandler		= ide_pre_handler_parser(&taskfile, &hobfile);
> > > > -	args.handler		= ide_handler_parser(&taskfile, &hobfile);
> > > > -	args.posthandler	= NULL;
> > > > -	args.rq			= (struct request *) rq;
> > > > +	fill_args(&args, &taskfile, &hobfile);
> > > > +	args.rq			= rq;
> > > >  	args.block		= block;
> > > > -	rq->special		= NULL;
> > > > -	rq->special		= (ide_task_t *)&args;
> > > > +	rq->special		= &args;
> > > >  
> > > >  	return do_rw_taskfile(drive, &args);
> > > >  }
> > > > @@ -321,16 +313,10 @@
> > > >  	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
> > > >  #endif
> > > >  
> > > > -	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
> > > > -	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
> > > > -	args.command_type	= ide_cmd_type_parser(&args);
> > > > -	args.prehandler		= ide_pre_handler_parser(&taskfile, &hobfile);
> > > > -	args.handler		= ide_handler_parser(&taskfile, &hobfile);
> > > > -	args.posthandler	= NULL;
> > > > -	args.rq			= (struct request *) rq;
> > > > +	fill_args(&args, &taskfile, &hobfile);
> > > > +	args.rq			= rq;
> > > >  	args.block		= block;
> > > > -	rq->special		= NULL;
> > > > -	rq->special		= (ide_task_t *)&args;
> > > > +	rq->special		= &args;
> > > >  
> > > >  	return do_rw_taskfile(drive, &args);
> > > >  }
> > > > 
> > > > -- 
> > > > (about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
> > > > no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > > 
> > > 
> > > Andre Hedrick
> > > Linux Disk Certification Project                Linux ATA Development
> > > 
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > -- 
> > Vojtech Pavlik
> > SuSE Labs
> > 
> 
> Andre Hedrick
> Linux Disk Certification Project                Linux ATA Development

-- 
Vojtech Pavlik
SuSE Labs
