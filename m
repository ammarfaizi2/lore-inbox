Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVGUFew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVGUFew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 01:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVGUFc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 01:32:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26058 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261632AbVGUFbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 01:31:33 -0400
Date: Thu, 21 Jul 2005 07:31:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andreas Steinmetz <ast@domdv.de>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: amd64-agp vs. swsusp
Message-ID: <20050721053126.GB5230@atrey.karlin.mff.cuni.cz>
References: <42DD67D9.60201@stud.feec.vutbr.cz> <42DD6AA7.40409@domdv.de> <42DD7011.6080201@stud.feec.vutbr.cz> <200507201115.08733.rjw@sisk.pl> <42DECB21.5020903@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42DECB21.5020903@stud.feec.vutbr.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>I have rebuilt agpgart and amd64-agp into the kernel and now it has 
> >>resumed successfully for the first time. Thank you for the hint!
> >>
> >>But I still wonder, why that makes a difference.
> >
> >
> >Before resume the module is not present.  When it gets loaded from the
> >image it probably runs with the assumption that the hardware was 
> >initialized
> >which is not correct.
> 
> It seems that the module doesn't even get a chance to run after resume. 
> I've put some printks and udelays into kernel/power/swsusp.c and other 
> places and I've found that the spontaneous reset occurs already in 
> swsusp_arch_resume(), ie. before the drivers get their resume methods 
> called. This is what I have in swsusp_suspend() now:
> 	...
>         save_processor_state();
>         if ((error = swsusp_arch_suspend()))
>                 printk(KERN_ERR "Error %d suspending\n", error);
>         /* Restore control flow magically appears here */
>         restore_processor_state();
>         printk(KERN_INFO "processor state restored!\n");/*I added this*/
>         BUG_ON (nr_copy_pages_check != nr_copy_pages);
>         restore_highmem();
>         device_power_up();
> 	...
> 
> I'm recording the screen during resuming with a digital camera to see if 
> the added printk is displayed before the reset and I am now sure that 
> the reset occurs before that. The last thing I see is:
> 
> Stopping tasks: --|
> Freeing memory... done (0 pages freed)
> swsusp: Need to copy 8121 pages
> 
> Then on the next frame of the recorded MPEG, the display is already 
> beginning to dim as the computer is resetting.
> 
> I also tried putting a printk before restore_processor_state(), but I'm 
> not sure if it is safe to use printk there.
> So I tried putting a loop of 5000 x udelay(1000) there to see if the 
> reset would be delayed by 5s. It was not delayed, so I think that the 
> reset occurs before restore_processor_state().

Long time ago there were i386 problems because we assumed that kernel
is mapped in one big mapping and agp broke that assumption. Copying
pages backwards "fixed" it (and then we done proper fix). It should
not be, but it seems similar to this problem....

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
