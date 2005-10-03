Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbVJCPrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVJCPrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVJCPrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:47:14 -0400
Received: from mail.dvmed.net ([216.237.124.58]:15516 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932308AbVJCPrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:47:12 -0400
Message-ID: <43415275.4020407@pobox.com>
Date: Mon, 03 Oct 2005 11:47:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukasz Kosewski <lkosewsk@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/3] Add disk hotswap support to libata RESEND #5
References: <355e5e5e05092618018840fc3@mail.gmail.com>	 <433AEAAE.2070003@pobox.com> <355e5e5e0510030730q2b3e295creaec6ebd129999f9@mail.gmail.com>
In-Reply-To: <355e5e5e0510030730q2b3e295creaec6ebd129999f9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Kosewski wrote:
> On 9/28/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>>+     dev->flags &= ~ATA_DFLAG_LBA48;
>>>+
>>
>>probably should just clear out all the flags...
> 
> 
> I'll look into making this cleaner :)  During testing this was the
> only one that was necessary, but I'll do some clean-up foo on this.
> 
> 
>>is ata_chk_err() call in ata_to_sense_error() the only place that needs
>>to talk to the hardware?  If so, maybe we could work around that by
>>making sure it is passed register values, avoiding the need to poke the h/w.
> 
> 
> Yep, it is the only place as far as I can see.  As for passing
> register values, the reason I decided not to do that is because, say,
> a user unplugged his drive because there WAS some kind of error which
> set ATA_ERR.  This would attempt to perform some kind of error check
> which would compound the problem.  However, I agree this is dirty :)
> Should I just check the register values, & ~ATA_ERR, and then pass that in?
> 
> 
>>>+     spin_lock(&ap->host_set->lock);
>>>+     hotplug_todo = ap->plug; // Make sure we don't modify while reading!
>>>+     spin_unlock(&ap->host_set->lock);
>>
>>this lock should always be acquired using spin_lock_irqsave()
> 
> 
> Oops.
> 
> 
>>>+             ata_scsi_handle_unplug(ap);
>>>+
>>>+             // The following flag is necessary on some Seagate drives.
>>>+             ap->flags |= ATA_FLAG_SATA_RESET;
>>
>>we can't unconditionally set this for all controllers
>>
>>For PATA hotplug, which this code will eventually handle, the SATA
>>SControl register doesn't even exist :)
> 
> 
> if (ap & ATA_FLAG_SATA) ap->flags |= ATA_FLAG_SATA_RESET
> ? :)
> 
> 
>>>+             ap->udma_mask = ap->orig_udma_mask;
>>
>>dumb question -- what is this for?
>>
>>for hotplug we'll want to go through the entire probe sequence,
>>configuring pio/dma masks all over again.
> 
> 
> OK I'll admit I may not have looked through the code enough on that
> one, but here's a situation I remember about this:
> Had a drive which supported UDMA 5 max.  Unplugged it, plugged in a
> drive which supported UDMA 6, but libata reported UDMA 5 max.  Since
> the flags aren't reset, and ata_mode_string() works from slowest to
> fastest, this will always happen unless we reset the flags to some
> default value.  So... voila.  Do you have a suggestion for making this
> cleaner?

Well, overall what needs to happen for newly-plugged-in devices is the a 
re-run of the probe sequence.  The flags should certainly be reset to a 
default value, the same value that the device would see had it been 
plugged in when the driver loaded:  ata_bus_probe() call sequence, after 
initialization from ata_host_init().  This may require saving a few 
pieces of data, as you have done, agreed.

	Jeff


