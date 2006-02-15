Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945948AbWBOPAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945948AbWBOPAS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945957AbWBOPAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:00:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49938 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1945948AbWBOPAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:00:15 -0500
Date: Wed, 15 Feb 2006 15:59:25 +0100
From: Jens Axboe <axboe@suse.de>
To: Sander <sander@humilis.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc3 kernel BUG at drivers/scsi/sata_mv.c:1018
Message-ID: <20060215145925.GU4203@suse.de>
References: <20060215131653.GA26178@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215131653.GA26178@favonius>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15 2006, Sander wrote:
> Hi Jeff and others,
> 
> I get a kernel BUG message when I try to create a raid1 or raid5 over
> nine 64MB partitions located on nine sata disks (Maxtor Pro 500) on a
> fresh setup. The system locks hard: no sysrq.
> 
> The onboard controller is an nVidia nForce with three disks.
> The six other disks are connected to a Marvell 88SX6081 controller.
> 
> Last night and the first half of today all disks were tested with
> badblocks in write mode, which the system survived just fine (one disk
> out of ten detected as broken, so nine disks left).
> 
> A google search leads me to
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0601.2/0479.html
> 
> and
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0601.2/0626.html
> 
> I had MSI disabled in the .config already, and will try again with debug
> options set.
> 
> In the mean time, is this of any help?
> 
> I can try any patch you throw at me, or any config option, as this
> system is not in production yet.

It's barfing on a barrier write, I bet. The attached patch should fix
it.

---

[PATCH] Add missing FUA write to sata_mv dma command list

Signed-off-by: Jens Axboe <axboe@suse.de>

diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 6fddf17..2770005 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -997,6 +997,7 @@ static void mv_qc_prep(struct ata_queued
 	case ATA_CMD_READ_EXT:
 	case ATA_CMD_WRITE:
 	case ATA_CMD_WRITE_EXT:
+	case ATA_CMD_WRITE_FUA_EXT:
 		mv_crqb_pack_cmd(cw++, tf->hob_nsect, ATA_REG_NSECT, 0);
 		break;
 #ifdef LIBATA_NCQ		/* FIXME: remove this line when NCQ added */

-- 
Jens Axboe

