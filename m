Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754476AbWKHJca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbWKHJca (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 04:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754472AbWKHJca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 04:32:30 -0500
Received: from brick.kernel.dk ([62.242.22.158]:62770 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1754476AbWKHJc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 04:32:29 -0500
Date: Wed, 8 Nov 2006 10:34:43 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: romosan@sycorax.lbl.gov
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: known regressions
Message-ID: <20061108093442.GB19471@kernel.dk>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <20061108085235.GT4729@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108085235.GT4729@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08 2006, Adrian Bunk wrote:
> Subject    : unable to rip cd
> References : http://lkml.org/lkml/2006/10/13/100
> Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
> Status     : unknown

Alex, was/is this repeatable? If so I'd like you to repeat with this
debug patch applied, I cannot reproduce it locally.

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index bddfebd..ad03e19 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1726,8 +1726,10 @@ static ide_startstop_t cdrom_newpc_intr(
 		/*
 		 * write to drive
 		 */
-		if (cdrom_write_check_ireason(drive, len, ireason))
+		if (cdrom_write_check_ireason(drive, len, ireason)) {
+			blk_dump_rq_flags(rq, "cdrom_newpc");
 			return ide_stopped;
+		}
 
 		xferfunc = HWIF(drive)->atapi_output_bytes;
 	} else  {
@@ -1859,8 +1861,10 @@ static ide_startstop_t cdrom_write_intr(
 	}
 
 	/* Check that the drive is expecting to do the same thing we are. */
-	if (cdrom_write_check_ireason(drive, len, ireason))
+	if (cdrom_write_check_ireason(drive, len, ireason)) {
+		blk_dump_rq_flags(rq, "cdrom_pc");
 		return ide_stopped;
+	}
 
 	sectors_to_transfer = len / SECTOR_SIZE;
 

-- 
Jens Axboe

