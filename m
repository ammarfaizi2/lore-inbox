Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267677AbTA1R5F>; Tue, 28 Jan 2003 12:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267678AbTA1R5F>; Tue, 28 Jan 2003 12:57:05 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:10252
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267677AbTA1R5D>; Tue, 28 Jan 2003 12:57:03 -0500
Date: Tue, 28 Jan 2003 10:01:03 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Ross Biro <rossb@google.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: [2.4.18+] IDE Race Condition
In-Reply-To: <3E36C0FD.1020002@google.com>
Message-ID: <Pine.LNX.4.10.10301280956220.9272-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Well if someone would drop a $16,000->$27,000 USD bus analyzer with
switchable PODS, I could do wonders!  Well I am not sure how to take this
on the chin.  Either "nice try, but you didn't get there" or "nice try, it
is not possible to get there without more tools"; regardless, it needs to
be fixed.  So if you have an answer and a trace to support it ... bring it
on!

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Tue, 28 Jan 2003, Ross Biro wrote:

> 
> Sorry, we are not using sub-microsecond timers, we are just using the 
> latest-greatest-bugiest hard drives and lots of them.  We can see 
> problems like this because we can run on so many machines at once.  Even 
> something that has a small percentage chance of showing up, we can see 
> pretty quick.
> 
> We do have a bus analyzer that can time things down to about 4ns.  That 
> has been invaluable for tracking down some of these issues.
> 
>     Ross
> 
> Andre Hedrick wrote:
> 
> >Ross,
> >
> >How did you create the sub-microsecond timers to profile the device/driver
> >behavior?  I had been working on this for a while but little success.
> >This is one of the key methods to predict device failure.
> >
> >One of the goals of the prebuilder it find slam prebuild commands down the
> >pipes to force breakages and races to show up.
> >
> >So you have a possible solution?
> >
> >Cheers,
> >
> >Andre Hedrick
> >LAD Storage Consulting Group
> >
> >
> >On Tue, 28 Jan 2003, Ross Biro wrote:
> >
> >  
> >
> >>Easy, it happens all the time, there are just no tests in place to see it.
> >>
> >>We are keeping a histogram of how long every IDE DMA transfer takes 
> >>place.  In ide_intr we record the time and set the start time in 
> >>ide_drive_t to 0.  In ide_dma_proc, ide_dma_begin right AFTER activating 
> >>the dma, we store the current value of jiffies in start time in ide_drive_t.
> >>
> >>In both those places we check to make sure that the value of start_time 
> >>is sensible.  In ide_dma_begin, we make sure it's 0 and in ide_dma_intr, 
> >>we make sure its non-zero.  Because of this race condition, we often saw 
> >>DMAs finish before they began.
> >>
> >>In the normal kernel, the only thing I can see that could go wrong would 
> >>be that the printk
> >>
> >>printk("%s: ide_intr: huh? expected NULL handler on exit\n", drive->name);
> >>
> >>in ide_intr  could be triggered.  I've never seen it happen, but I 
> >>believe with enough effort, it could be made to occur.
> >>
> >>    Ross
> >>
> >>
> >>Andre Hedrick wrote:
> >>
> >>    
> >>
> >>>Okay, how do you reproduce it to see the effects?
> >>>
> >>>On Mon, 27 Jan 2003, Ross Biro wrote:
> >>>
> >>> 
> >>>
> >>>      
> >>>
> >>>>The net effect of this race condition and the other one I spotted is 
> >>>>that you may see some interesting messages in your log file and you can 
> >>>>detect the race condition if you look for it hard enough.  I don't 
> >>>>currently see any bad effects.
> >>>>
> >>>>   Ross
> >>>>
> >>>>Ross Biro wrote:
> >>>>
> >>>>   
> >>>>
> >>>>        
> >>>>
> >>>>>There is at least one more IDE race condition in 2.4.18 and 
> >>>>>2.4.21-pre3. Basically the interrupt for the controller being serviced 
> >>>>>is left on while setting up the next command.  I'm not sure how much 
> >>>>>trouble it can cause but it does lead to some interesting stack traces.
> >>>>>
> >>>>>The condition
> >>>>>if (masked_irq && hwif->irq != masked_irq)
> >>>>>in ide_do_request should be replaced with
> >>>>>if (!masked_irq || hwif->irq != masked_irq)
> >>>>>in two places.
> >>>>>
> >>>>>     
> >>>>>
> >>>>>          
> >>>>>
> >>>>-
> >>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >>>>the body of a message to majordomo@vger.kernel.org
> >>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>Please read the FAQ at  http://www.tux.org/lkml/
> >>>>
> >>>>   
> >>>>
> >>>>        
> >>>>
> >>>Andre Hedrick
> >>>LAD Storage Consulting Group
> >>>
> >>> 
> >>>
> >>>      
> >>>
> >
> >  
> >
> 
> 
> 

