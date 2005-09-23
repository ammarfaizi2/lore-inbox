Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbVIWSKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVIWSKr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbVIWSKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:10:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23896 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750971AbVIWSKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:10:45 -0400
Date: Fri, 23 Sep 2005 20:07:13 +0200
From: Jens Axboe <axboe@suse.de>
To: joshk@triplehelix.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       jgarzik@pobox.com, torvalds@osdl.org
Subject: Re: [PATCH] updated version of Jens' SATA suspend-to-ram patch
Message-ID: <20050923180711.GH22655@suse.de>
References: <20050923163334.GA13567@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923163334.GA13567@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23 2005, Joshua Kwan wrote:
> Hello,
> 
> I had some time yesterday and decided to help Jens out by rediffing the
> now-infamous SATA suspend-to-ram patch [1] against current git and
> test-building it.
> 
> For posterity,
> 
> This patch adds the ata_scsi_device_resume and ata_scsi_device_suspend
> functions (along with helpers) to put to sleep and wake up Serial ATA
> controllers when entering sleep states, and hooks the functions into
> each SATA controller driver so that suspend-to-RAM is possible.
> 
> Note that this patch is a holdover patch until it is possible to
> generalize this concept for all SCSI devices, which requires more data
> on which devices need to be put to sleep and which don't.

Port looks fine, thanks. The only problem I've seen with the base patch
is that sometimes ata_do_simple_cmd() seems to be invoked right before a
previous command has completed. So I needed this addon to work around
that issue.

From: Jens Axboe <axboe@suse.de>
Subject: Wait for current command to finish in ata_do_simple_cmd()
Patch-mainline: 
References: 114648

A hack to wait a little while for the current command to complete, before
issuing a new one.

Acked-by: 
Signed-off-by: 

--- linux-2.6.13/drivers/scsi/libata-core.c~	2005-09-01 12:22:19.000000000 +0200
+++ linux-2.6.13/drivers/scsi/libata-core.c	2005-09-01 12:24:38.000000000 +0200
@@ -3738,8 +3738,8 @@
 	unsigned long flags;
 	int rc;
 
-	qc = ata_qc_new_init(ap, dev);
-	BUG_ON(qc == NULL);
+	while ((qc = ata_qc_new_init(ap, dev)) == NULL)
+		msleep(10);
 
 	qc->tf.command = cmd;
 	qc->tf.flags |= ATA_TFLAG_DEVICE;


-- 
Jens Axboe

