Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVGTWIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVGTWIX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 18:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVGTWIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 18:08:23 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:21253 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261511AbVGTWIW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 18:08:22 -0400
Message-ID: <42DECB21.5020903@stud.feec.vutbr.cz>
Date: Thu, 21 Jul 2005 00:07:29 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Andreas Steinmetz <ast@domdv.de>, Pavel Machek <pavel@suse.cz>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: amd64-agp vs. swsusp
References: <42DD67D9.60201@stud.feec.vutbr.cz> <42DD6AA7.40409@domdv.de> <42DD7011.6080201@stud.feec.vutbr.cz> <200507201115.08733.rjw@sisk.pl>
In-Reply-To: <200507201115.08733.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-0.1 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -0.7 BAYES_10               BODY: Bayesian spam probability is 10 to 20%
                              [score: 0.1772]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Tuesday, 19 of July 2005 23:26, Michal Schmidt wrote:
>>I have rebuilt agpgart and amd64-agp into the kernel and now it has 
>>resumed successfully for the first time. Thank you for the hint!
>>
>>But I still wonder, why that makes a difference.
> 
> 
> Before resume the module is not present.  When it gets loaded from the
> image it probably runs with the assumption that the hardware was initialized
> which is not correct.

It seems that the module doesn't even get a chance to run after resume. 
I've put some printks and udelays into kernel/power/swsusp.c and other 
places and I've found that the spontaneous reset occurs already in 
swsusp_arch_resume(), ie. before the drivers get their resume methods 
called. This is what I have in swsusp_suspend() now:
	...
         save_processor_state();
         if ((error = swsusp_arch_suspend()))
                 printk(KERN_ERR "Error %d suspending\n", error);
         /* Restore control flow magically appears here */
         restore_processor_state();
         printk(KERN_INFO "processor state restored!\n");/*I added this*/
         BUG_ON (nr_copy_pages_check != nr_copy_pages);
         restore_highmem();
         device_power_up();
	...

I'm recording the screen during resuming with a digital camera to see if 
the added printk is displayed before the reset and I am now sure that 
the reset occurs before that. The last thing I see is:

Stopping tasks: --|
Freeing memory... done (0 pages freed)
swsusp: Need to copy 8121 pages

Then on the next frame of the recorded MPEG, the display is already 
beginning to dim as the computer is resetting.

I also tried putting a printk before restore_processor_state(), but I'm 
not sure if it is safe to use printk there.
So I tried putting a loop of 5000 x udelay(1000) there to see if the 
reset would be delayed by 5s. It was not delayed, so I think that the 
reset occurs before restore_processor_state().

Michal
