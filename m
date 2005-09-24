Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbVIXHHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbVIXHHF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 03:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbVIXHHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 03:07:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4947 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751452AbVIXHHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 03:07:03 -0400
Date: Sat, 24 Sep 2005 09:07:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, joshk@triplehelix.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] updated version of Jens' SATA suspend-to-ram patch
Message-ID: <20050924070659.GK22655@suse.de>
References: <20050923163334.GA13567@triplehelix.org> <20050923180711.GH22655@suse.de> <433469DF.1060900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433469DF.1060900@pobox.com>
X-IMAPbase: 1124875140 52
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23 2005, Jeff Garzik wrote:
> >--- linux-2.6.13/drivers/scsi/libata-core.c~	2005-09-01 
> >12:22:19.000000000 +0200
> >+++ linux-2.6.13/drivers/scsi/libata-core.c	2005-09-01 
> >12:24:38.000000000 +0200
> >@@ -3738,8 +3738,8 @@
> > 	unsigned long flags;
> > 	int rc;
> > 
> >-	qc = ata_qc_new_init(ap, dev);
> >-	BUG_ON(qc == NULL);
> >+	while ((qc = ata_qc_new_init(ap, dev)) == NULL)
> >+		msleep(10);
> > 
> > 	qc->tf.command = cmd;
> > 	qc->tf.flags |= ATA_TFLAG_DEVICE;
> 
> Worried now!
> 
> If this patch is needed, something VERY VERY WRONG is going on.  This 
> patch indicates that the queueing state machine has been violated, and 
> something is trying to IGNORE the command synchronization :(

I haven't diagnosed this further and it only ever happened in the SUSE
kernel to my knowledge (no one has reported it to me for the vanilla
kernels + suspend patch).

So lets just keep this patch out of the equation for now, it could be
that other SUSE patches broke something in this area :/

> Further, you cannot always assume that msleep() is valid in that 
> context.  It should be the caller that waits (libata suspend code), not 
> ata_do_simple_cmd() itself.

ata_do_simple_cmd() always blocks anyways, so I don't see the point.
Perhaps rename the function to ata_execute_and_wait_simple_cmd().

-- 
Jens Axboe

