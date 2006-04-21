Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWDUUpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWDUUpK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWDUUpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:45:09 -0400
Received: from gold.veritas.com ([143.127.12.110]:45952 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932432AbWDUUpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:45:07 -0400
X-IronPort-AV: i="4.04,146,1144047600"; 
   d="scan'208"; a="58795202:sNHT32315988"
Date: Fri, 21 Apr 2006 21:44:59 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Pavel Machek <pavel@suse.cz>
cc: Arkadiusz Miskiewicz <arekm@maven.pl>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>, Jeff Garzik <jeff@garzik.org>,
       Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ...
In-Reply-To: <20060421163930.GA1648@elf.ucw.cz>
Message-ID: <Pine.LNX.4.64.0604212108010.7531@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com>
 <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com> <20060420134713.GA2360@ucw.cz>
 <Pine.LNX.4.64.0604211333050.4891@blonde.wat.veritas.com>
 <20060421163930.GA1648@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Apr 2006 20:45:07.0161 (UTC) FILETIME=[7949DC90:01C66584]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2006, Pavel Machek wrote:
> 
> Not sure why it needs time. Waiting for disk to spin up?

I don't know, and can't hear, but doubt it (I can't see why
it'd need disk spun up just to do an ata_dev_set_xfermode).

> Will it recover from the timeout?

No, after that wait for 30 seconds, it degenerates into attempting I/O,
getting errors, remounting the root readonly, can't get much further.

> Would sticking ata_set_mode() at the end of timeout routine help?

Well, moving the ata_set_mode after the ata_start_drive does help:
then the ata_start_drive times out and fails, but that does not seem
to matter at all, and the ata_set_mode then succeeds and all is well.
I guess that amounts to what you meant; but all the same, I won't be
alone in preferring to wait 2 seconds than 30 seconds!

But you've made me try a bit harder, and the patch below, waiting for
ATA_BUSY to clear, copying a line used in several other places there,
fixes it in a much more satisfactory way than mdelay(2000).  (I checked
how long it in fact was waiting, saw various waits between 0.8s and 1.3s).

This is a patch I'd not be ashamed to send Jeff Garzik cc linux-ide,
even if we can't name precisely why it's ATA_BUSY then.  But I'll
give it a day or so of real-life suspend/resuming first - Arkadiusz
and I both noticed we're more likely to resume successfully after
a brief suspend, so longer suspends are needed for proper testing.

Hugh

--- 2.6.17-rc2/drivers/scsi/libata-core.c	2006-04-19 09:14:11.000000000 +0100
+++ linux/drivers/scsi/libata-core.c	2006-04-21 20:55:48.000000000 +0100
@@ -4288,6 +4288,7 @@ int ata_device_resume(struct ata_port *a
 {
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
+		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
 		ata_set_mode(ap);
 	}
 	if (!ata_dev_present(dev))
