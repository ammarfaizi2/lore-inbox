Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291432AbSBMHbP>; Wed, 13 Feb 2002 02:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291434AbSBMHbF>; Wed, 13 Feb 2002 02:31:05 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:54032 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291432AbSBMHax>; Wed, 13 Feb 2002 02:30:53 -0500
Date: Wed, 13 Feb 2002 08:30:00 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
Message-ID: <20020213083000.C30588@suse.cz>
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <Pine.LNX.4.10.10202122151530.32729-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10202122151530.32729-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Tue, Feb 12, 2002 at 09:52:07PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 09:52:07PM -0800, Andre Hedrick wrote:

> HELL NO!

Hell why?

> On Mon, 11 Feb 2002, Pavel Machek wrote:
> 
> > Hi!
> > 
> > This is slightly longer but also simple cleanup. It kills code
> > duplication and removes unneccessary assignments/casts. Please apply,
> > 
> > 								Pavel
> > 
> > --- clean-pre3/drivers/ide/ide-disk.c	Sat Feb  9 23:00:02 2002
> > +++ linux-dm-pre3/drivers/ide/ide-disk.c	Sun Feb 10 00:06:31 2002
> > @@ -172,6 +167,16 @@
> >  		return WIN_NOP;
> >  }
> >  
> > +static void fill_args (ide_task_t *args, struct hd_drive_task_hdr *taskfile, struct hd_drive_hob_hdr *hobfile)
> > +{
> > +	memcpy(args->tfRegister, taskfile, sizeof(struct hd_drive_task_hdr));
> > +	memcpy(args->hobRegister, hobfile, sizeof(struct hd_drive_hob_hdr));
> > +	args->command_type	= ide_cmd_type_parser(args);
> > +	args->prehandler	= ide_pre_handler_parser(taskfile, hobfile);
> > +	args->handler		= ide_handler_parser(taskfile, hobfile);
> > +	args->posthandler	= NULL;
> > +}
> > +
> >  static ide_startstop_t chs_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
> >  {
> >  	struct hd_drive_task_hdr	taskfile;
> > @@ -210,16 +215,10 @@
> >  	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
> >  #endif
> >  
> > -	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
> > -	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
> > -	args.command_type	= ide_cmd_type_parser(&args);
> > -	args.prehandler		= ide_pre_handler_parser(&taskfile, &hobfile);
> > -	args.handler		= ide_handler_parser(&taskfile, &hobfile);
> > -	args.posthandler	= NULL;
> > -	args.rq			= (struct request *) rq;
> > +	fill_args(&args, &taskfile, &hobfile);
> > +	args.rq			= rq;
> >  	args.block		= block;
> > -	rq->special		= NULL;
> > -	rq->special		= (ide_task_t *)&args;
> > +	rq->special		= &args;
> >  
> >  	return do_rw_taskfile(drive, &args);
> >  }
> > @@ -257,16 +255,10 @@
> >  	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
> >  #endif
> >  
> > -	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
> > -	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
> > -	args.command_type	= ide_cmd_type_parser(&args);
> > -	args.prehandler		= ide_pre_handler_parser(&taskfile, &hobfile);
> > -	args.handler		= ide_handler_parser(&taskfile, &hobfile);
> > -	args.posthandler	= NULL;
> > -	args.rq			= (struct request *) rq;
> > +	fill_args(&args, &taskfile, &hobfile);
> > +	args.rq			= rq;
> >  	args.block		= block;
> > -	rq->special		= NULL;
> > -	rq->special		= (ide_task_t *)&args;
> > +	rq->special		= &args;
> >  
> >  	return do_rw_taskfile(drive, &args);
> >  }
> > @@ -321,16 +313,10 @@
> >  	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
> >  #endif
> >  
> > -	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
> > -	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
> > -	args.command_type	= ide_cmd_type_parser(&args);
> > -	args.prehandler		= ide_pre_handler_parser(&taskfile, &hobfile);
> > -	args.handler		= ide_handler_parser(&taskfile, &hobfile);
> > -	args.posthandler	= NULL;
> > -	args.rq			= (struct request *) rq;
> > +	fill_args(&args, &taskfile, &hobfile);
> > +	args.rq			= rq;
> >  	args.block		= block;
> > -	rq->special		= NULL;
> > -	rq->special		= (ide_task_t *)&args;
> > +	rq->special		= &args;
> >  
> >  	return do_rw_taskfile(drive, &args);
> >  }
> > 
> > -- 
> > (about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
> > no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> Andre Hedrick
> Linux Disk Certification Project                Linux ATA Development
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
