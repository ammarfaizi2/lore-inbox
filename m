Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWDUMt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWDUMt2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 08:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWDUMt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 08:49:28 -0400
Received: from silver.veritas.com ([143.127.12.111]:8753 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932198AbWDUMt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 08:49:27 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.04,145,1144047600"; 
   d="scan'208"; a="37437518:sNHT25913220"
Date: Fri, 21 Apr 2006 13:49:21 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Pavel Machek <pavel@suse.cz>
cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, Jeff Garzik <jeff@garzik.org>,
       Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ...
In-Reply-To: <20060420134713.GA2360@ucw.cz>
Message-ID: <Pine.LNX.4.64.0604211333050.4891@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com>
 <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com> <20060420134713.GA2360@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Apr 2006 12:49:26.0924 (UTC) FILETIME=[05FB4CC0:01C66542]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2006, Pavel Machek wrote:
> > > 
> > > System suspends ok. Resume ok. but no disk access after that.
> > 
> > Not the same disk model, but I've been having similar trouble on a T43p.
> 
> Could you
> 
> 1) try if mdelay(2000) also helps?
> 
> 2) binary-search on drivers to see which one breaks it?

Thanks for looking into this.  But we already know mdelay(2000) works
around it, and that the failure is "ata1: qc timeout (cmd 0xef)" when
trying to resume the SATA disk (in my case, don't know about Jeff's):
so I'm confused as to what binary search to be doing.  I just tried
backing out the time.c patch I sent originally, and substituting the
patch below, much closer to the heart of the problem: that works too.
This is with ata_piix, by the way; resuming from suspend to RAM.
Do let me know what else to try if you've got an idea.

Hugh

--- 2.6.17-rc2/drivers/scsi/libata-core.c	2006-04-19 09:14:11.000000000 +0100
+++ linux/drivers/scsi/libata-core.c	2006-04-21 13:19:54.000000000 +0100
@@ -4287,6 +4287,7 @@ static int ata_start_drive(struct ata_po
 int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
 {
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
+		mdelay(2000);
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
 		ata_set_mode(ap);
 	}
