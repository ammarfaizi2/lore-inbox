Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVEZUbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVEZUbO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 16:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVEZUbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:31:13 -0400
Received: from brick.kernel.dk ([62.242.22.158]:10453 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261722AbVEZU31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:29:27 -0400
Date: Thu, 26 May 2005 22:30:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
Message-ID: <20050526203017.GA16768@suse.de>
References: <20050526140058.GR1419@suse.de> <4295F87B.9070106@pobox.com> <20050526170658.GT1419@suse.de> <42962833.4000000@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42962833.4000000@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Thu, May 26 2005, Jeff Garzik wrote:
> >>>+int ata_read_log_page(struct ata_port *ap, unsigned int device, char 
> >>>page,
> >>>+		      char *buffer, unsigned int sectors)
> >>>+{
> >>>+	struct ata_device *dev = &ap->device[device];
> >>>+	DECLARE_COMPLETION(wait);
> >>>+	struct ata_queued_cmd *qc;
> >>>+	unsigned long flags;
> >>>+	u8 status;
> >>>+	int rc;
> >>>+
> >>>+	assert(dev->class == ATA_DEV_ATA);
> >>>+
> >>>+	ata_dev_select(ap, device, 1, 1);
> >>
> >>is this needed?  These types of calls need to be removed, in general, as 
> >>they don't make sense on FIS-based hardware at all.
> >
> >
> >You tell me, this read_log_page() was mainly copy-pasted from the pio
> >driven function above it. I'll try and kill the select when doing error
> >testing.
> >
> >
> >>>+	printk("RLP issue\n");
> >>>+	spin_lock_irqsave(&ap->host_set->lock, flags);
> >>>+	rc = ata_qc_issue(qc);
> >>>+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
> >>>+	printk("RLP issue done\n");
> >>>+
> >>>+	if (rc)
> >>>+		return -EIO;
> >>>+
> >>>+	wait_for_completion(&wait);
> >>>+
> >>>+	printk("RLP wait done\n");
> >>>+
> >>>+	status = ata_chk_status(ap);
> >>>+	if (status & (ATA_ERR | ATA_ABORTED))
> >>>+		return -EIO;
> >>
> >>we need to get rid of this too for AHCI-like devices
> >
> >
> >Can you expand on that?
> 
> (this covers both quoted questions above)
> 
> The PIO function assumes that PCI IDE-like ATA register blocks (command 
> registers, control registers) are available.  The read-log-page function 
> can make no such assumptions.
> 
> dev-select and check-status should both be done by the machinery that 
> occurs once you start things in motion by calling ata_qc_issue().
> 
> Doing things this way is necessary for FIS-based hardware like AHCI or 
> SiI 3124.

I'll get it cleaned up and tested.

> >>For all hardware that uses SActive (all NCQ), the max is 31 not 32.
> >
> >
> >That's not true, the max is 32 counting 0 as a valid tag. So 31 is
> >indeed th max tag value, but 32 is the depth.
> 
> I was talking about depth.  In libata, it's a policy decision to never 
> use more than 31 tags at any given time.
> 
> You can change it from 31 to 32 in SuSE for value-add, if you wish :)
> 
> Note also that error handling occasionally needs a command slot, so the 
> limit may even be 30 (or 31 at most).

Reserving one for error handling makes a lot of sense, that's a good
point. I still don't buy your argument for not using the full 32 slots
in total, though. But in the end I don't suppose it matters a lot, 31 or
30 for queue depth is very much at the end of the spectrum of
diminishing return in difference.

> >The two depths were added because we need to differentiate between the
> >two for issuing new commands. ncq_depth > 0 is fine for issuing a new
> >FPDMA request, where as non-FPDMA commands need both !ncq_depth and
> >!depth.
> 
> You can definitely handle both FPDMA and non-FPDMA with a single 
> variable.  Think harder on this one.  You have flags to work with, you 
> know...

Of course it is possible, but I would rather trade 4-bytes of space to
get clearer code than switching a flag on/off all the time and counting
a single depth. But hey that's trivial detail, compared to what else is
missing. When this becomes the most important point, we can take it up
again :-)

-- 
Jens Axboe

