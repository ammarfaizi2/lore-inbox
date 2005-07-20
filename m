Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVGTXXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVGTXXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 19:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVGTXXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 19:23:24 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:12765 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261549AbVGTXXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 19:23:23 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: amd64-agp vs. swsusp
Date: Thu, 21 Jul 2005 01:23:15 +0200
User-Agent: KMail/1.8.1
Cc: Andreas Steinmetz <ast@domdv.de>, Pavel Machek <pavel@suse.cz>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
References: <42DD67D9.60201@stud.feec.vutbr.cz> <200507201115.08733.rjw@sisk.pl> <42DECB21.5020903@stud.feec.vutbr.cz>
In-Reply-To: <42DECB21.5020903@stud.feec.vutbr.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507210123.16537.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 21 of July 2005 00:07, Michal Schmidt wrote:
> Rafael J. Wysocki wrote:
> > On Tuesday, 19 of July 2005 23:26, Michal Schmidt wrote:
> >>I have rebuilt agpgart and amd64-agp into the kernel and now it has 
> >>resumed successfully for the first time. Thank you for the hint!
> >>
> >>But I still wonder, why that makes a difference.
> > 
> > 
> > Before resume the module is not present.  When it gets loaded from the
> > image it probably runs with the assumption that the hardware was initialized
> > which is not correct.
> 
> It seems that the module doesn't even get a chance to run after resume. 
> I've put some printks and udelays into kernel/power/swsusp.c and other 
> places and I've found that the spontaneous reset occurs already in 
> swsusp_arch_resume(), ie. before the drivers get their resume methods 
> called. This is what I have in swsusp_suspend() now:
> 	...
>          save_processor_state();
>          if ((error = swsusp_arch_suspend()))
>                  printk(KERN_ERR "Error %d suspending\n", error);
>          /* Restore control flow magically appears here */
>          restore_processor_state();
>          printk(KERN_INFO "processor state restored!\n");/*I added this*/
>          BUG_ON (nr_copy_pages_check != nr_copy_pages);
>          restore_highmem();
>          device_power_up();
> 	...
> 
> I'm recording the screen during resuming with a digital camera to see if 
> the added printk is displayed before the reset and I am now sure that 
> the reset occurs before that. The last thing I see is:
> 
> Stopping tasks: --|
> Freeing memory... done (0 pages freed)
> swsusp: Need to copy 8121 pages

Please note that printk() only places the string in a buffer and it does not
get actually printed before it can be displayed which is probably after your
screen is set up (including the AGP resume, I'd guess). :-)

You may be able to get more from eg. the serial console, but this requires
some tampering with the serial code, AFAIR.

> Then on the next frame of the recorded MPEG, the display is already 
> beginning to dim as the computer is resetting.
> 
> I also tried putting a printk before restore_processor_state(), but I'm 
> not sure if it is safe to use printk there.

Yes, it is, but you may be unable to see the message if the box reboots before
it can be displayed.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
