Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbUFFJ2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUFFJ2g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 05:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUFFJ2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 05:28:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15272 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263173AbUFFJ2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 05:28:34 -0400
Date: Sun, 6 Jun 2004 11:28:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       der.eremit@email.de
Subject: Re: [OT] Who has record no. of  DriveReady SeekComplete DataRequest errors?
Message-ID: <20040606092825.GD2733@suse.de>
References: <200406060007.10150.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406060007.10150.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06 2004, Con Kolivas wrote:
> Well since 2.6.3 I think I've been getting the record number of 
> 
> hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> hdd: status error: error=0x00
> hdd: drive not ready for command
> hdd: ATAPI reset complete
> 
> errors from my cdrw on hdd; and it's only one drive's worth.
> 
> 
> dmesg -s 32768 | grep DataRequest | wc -l
> 88
> 
> Note the -s 32768 is because my dmesg is so long due to the massive
> number of seekcomplete errors :-)
> 
> Since the cdrw works fine after re-enabling dma I never really
> bothered to do anything about it, but I'm just curious if anyone has a
> higher record ;-)

Interesting, and 2.6.2 works flawlessly? The only change in 2.6.3 wrt
ide-cd is the addition of the != 2kB sector size support from Pascal
Schmidt. A quick guess would be that blocklen isn't set, does this
change anything for you?

===== drivers/ide/ide-cd.c 1.83 vs edited =====
--- 1.83/drivers/ide/ide-cd.c	2004-05-29 19:04:42 +02:00
+++ edited/drivers/ide/ide-cd.c	2004-06-06 11:27:51 +02:00
@@ -2205,6 +2205,8 @@
 		*capacity = 1 + be32_to_cpu(capbuf.lba);
 		*sectors_per_frame =
 			be32_to_cpu(capbuf.blocklen) >> SECTOR_BITS;
+		if (*sectors_per_frame == 0)
+			*sectors_per_frame = SECTORS_PER_FRAME;
 	}
 
 	return stat;

-- 
Jens Axboe

