Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbTJIHJS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 03:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbTJIHJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 03:09:18 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:16915
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261905AbTJIHJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 03:09:03 -0400
Date: Thu, 9 Oct 2003 00:06:04 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: vatsa@in.ibm.com, lkcd-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] Poll-based IDE driver
In-Reply-To: <1065649641.10565.21.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10310082359510.12324-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hardware reset and stomping all over the drive.
Force jam the do_request caller to fail with error_buffer.
All drives have to honor polling or they fail POST on x86.
nIEN is used to signal the HBA to pass the drive interrupt to the host
cpu, other wise delivery does not happen period.
Assume nothing about PIO, because the drive will default to normal state
and the HBA will magically match.
Sleep is not suspend, and these two are confused many times.
Flush, who cares you disable write cache upon entry after the rest.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Wed, 8 Oct 2003, Alan Cox wrote:

> On Mer, 2003-10-08 at 10:43, Srivatsa Vaddagiri wrote:
> > 1. Taking control of the drive
> > 	It is possible that the kernel IDE driver was very _actively_
> > 	using the dump drive when my driver takes over. For ex, there
> > 	may be active DMA requests pending with the drive when 
> > 	my driver takes control ..
> 
> In 2.4 we issue one command at a time in 2.6 we may have several TCQ 
> commands queued. You may need to test if the drive is busy, wait and if
> neccessary reset and recover it. If possible avoid the reset because
> that means the drive will need some reconfiguration (see specs)
> 
> > 	Currently all my drive does to take control of the drive
> > 	is to disable drive interrupts (set nIEN bit). It then
> > 	starts issuing PIO WRITE commands to write data to disk.
> 
> Make sure you disable interrupts before using nIEN. Not all older
> devices honour nIEN so you can get suprises
> 
> > 	Do I need to do anything else in order to take 
> > 	control of the drive?
> > 	
> > 	Do I need to explicitly program the drive for PIO transfer
> > 	mode before I start issuing it PIO write commands?
> 
> The PIO mode on the controller and drive should have been set correctly
> by the base IDE driver at boot time.
> 
> > 2. Power Management
> > 	Tackling Sleep state may involve a drive reset followed by 
> > 	reinitializing drive parameters which will make my driver 
> > 	more complex (as I may have to take care of reset sequence of 
> > 	various chipsets separately). For now, I would like my driver 
> > 	not supporting the sleep state.
> 
> Makes sense. Many drives seem to come out of sleep state themselves
> anyway. 
>  
> > 3. Shutdown sequence
> > 	You mentioned that I need to follow proper shutdown sequence
> > 	when I am done writing to the drive. Apart from 
> > 	flushing (if the drive supports it) is there anything
> > 	more to the shutdown sequence?
> 
> Flush the cache, and place the drive in a suitable standby/sleep state -
> follow the code in ide-disk.c for the way we do it in the main code. 
> 
> > 4. Relinquishing control of the drive
> > 	Currently all I am doing to give control back to
> > 	the kernel IDE driver is to re-enable the drive
> > 	interrupts (clear nIEN). 
> > 		
> > 	Is there anything more I need to be taking care of?
> 
> Hard question. I think that providing you mark the drive busy, wait
> for the IDE layer to complete any pending commands and restore the state
> afterwards it ought to be possible. Would need a lot of thought and more
> time than I have right now to think about it since getting it wrong
> might lose requests and generate very hard to pin down errors.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

