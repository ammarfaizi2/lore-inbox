Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbSK0MsG>; Wed, 27 Nov 2002 07:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262450AbSK0MsG>; Wed, 27 Nov 2002 07:48:06 -0500
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:38663 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S262425AbSK0MsE>; Wed, 27 Nov 2002 07:48:04 -0500
Date: Wed, 27 Nov 2002 13:55:20 +0100
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Torben Mathiasen <torben.mathiasen@hp.com>, alan@xorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH-2.5.47-ac6] More IDE updates (BIOS, simplex, etc)
Message-ID: <20021127125520.GF1356@tmathiasen>
References: <20021125134157.GA1187@tmathiasen> <Pine.LNX.4.10.10211252144200.13936-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10211252144200.13936-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.20-pre11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan mentioned some missing locking in the IDE code, I assume thats what this
is about, or does it only affect the taskfile stuff?

I started to write a driver for the Compaq triflex stuff that Alan requested,
hopefully something should come out next week.

Also, with regards to our recent talk on how windows was doing DMA handling,
the link below was brought to my attention. Disabling DMA on cd-rom driver per
default seems somewhat overkill to me.

http://www.microsoft.com/hwdev/tech/storage/IDE-DMA.asp

Cheers,
Torben

On Mon, Nov 25 2002, Andre Hedrick wrote:
> 
> I love it!  I finally got the inital model correct and with the aid and
> trust of Alan to bring me back in the loop, everyone is doing great stuff.
> 
> Is there an interest in closing out the taskfile io model to complete the
> transformation?  If so the following has to be added, and effects PIO
> only.
> 
> Given the new BIO has the ablitity to force and match BIO atomic segments
> with Disk Data Block (atomic segment) it make it much nicer!
> 
> The interrupt race or lost interrupts happens for the following reason and
> only this reason:
> 
> interrupt_servicing:
> check_status:
> map_hi_bios:
> output_ata_data_register:
> 	competiton (here begins the race!)
> 		interrupt: (this can happen almost instantly)
> unmap_hi_bios:
> update_partial_completion_of_original_larger:
> 	return_if_last_data_block_was_transfered_request_complete:
> arm_isr:
> 	jump_to_interrupt:
> 
> 
> The completion of the local atomic segement of data can cause the device
> to pop an interrupt instant, and there is no handler armed to catch it.
> 
> interrupt_servicing:
> check_status:
> arm_isr:
> 	boost_wait_time_worst_case_to_prevent_early_timer_popping:
> map_hi_bios:
> output_ata_data_register:
> 	competiton (here begins the race!)
> 		interrupt: (this can happen almost instantly)
> 			who_cares_but_needs_a_sem_to_block:
> unmap_hi_bios:
> update_partial_completion_of_original_larger:
> 	if_last_data_block_dissarm_handler:
> 		return_if_last_data_block_was_transfered_request_complete:
> 
> 
> Comments?
> 
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> On Mon, 25 Nov 2002, Torben Mathiasen wrote:
> 
> > Hi Alan,
> > 
> > Please apply the attached patch. Its an update on my previos patch with a
> > rewrite of the simplex code. The patch now does the following:
> > 
> > 	# Make simplex detection on a per drive basis and dynamic for use 
> > 	  with hotplug.
> > 	# Make sure we also enforce simplex rules when using hdparm.
> > 	# Make sure we also enforce simplex rules when using BIOS timings.
> > 	# Moves BIOS timings IDE detection into chipset drivers (by providing a
> > 	  library function).
> > 	# Provide the above library function that sets default values for tune
> > 	  parameters. It also handles the special case where user has requested
> > 	  to use BIOS IDE timings. Caller is assumed to support DMA
> > 	  on/off probe using the dma_status register unless a dma_check funtion
> > 	  is provided (note, the tekram driver is somewhat different from all
> > 	  the others, and haven't been updated yet).
> > 	# Makes BIOS IDE timings work for both IDE0 and IDE1 at the same time.
> > 
> > I'm not sure whether you already applied my previous patch, so let me know if
> > you want this on top of that one.
> > 
> > Cheers,
> > Torben
> > 
