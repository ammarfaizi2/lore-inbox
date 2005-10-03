Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbVJCUaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbVJCUaa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 16:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbVJCUaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 16:30:30 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:4838 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932394AbVJCUa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 16:30:29 -0400
Subject: Re: Infinite interrupt loop, INTSTAT = 0
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
In-Reply-To: <20051003134210.GA10641@dspnet.fr.eu.org>
References: <20050928134514.GA19734@dspnet.fr.eu.org>
	 <1127919909.4852.7.camel@mulgrave>
	 <20050928160744.GA37975@dspnet.fr.eu.org>
	 <1127924686.4852.11.camel@mulgrave>
	 <20050928171052.GA45082@dspnet.fr.eu.org>
	 <1127929909.4852.34.camel@mulgrave>
	 <20050928183324.GA51793@dspnet.fr.eu.org>
	 <1128175434.4921.9.camel@mulgrave>
	 <20051003134210.GA10641@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 12:15:44 -0400
Message-Id: <1128356144.4606.11.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-03 at 15:42 +0200, Olivier Galibert wrote:
> Well, retriggering the DV blows:
> 
> Oct  3 15:39:03 m82 kernel:  target1:0:0: Beginning Domain Validation
> Oct  3 15:39:03 m82 kernel:  target1:0:0: asynchronous.
> Oct  3 15:39:03 m82 kernel: scsi1: Returning to Idle Loop
> Oct  3 15:39:13 m82 kernel: scsi1:0:0:0: Attempting to queue an ABORT message:CDB: 0x12 0x0 0x0 0x0 0x62 0x0
> Oct  3 15:39:13 m82 kernel: scsi1: At time of recovery, card was not paused
> Oct  3 15:39:13 m82 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
> Oct  3 15:39:13 m82 kernel: scsi1: Dumping Card State at program address 0x26 Mode 0x22
> Oct  3 15:39:13 m82 kernel: Card was paused

Oh, that's not pretty.  It means that the sequencer (or possibly the
bus) was wedged as it exited domain validation and it won't even recover
if we drop down to fully async.

What type of array is this, by the way?  I don't recognise the vendor.
But anyway, let's proceed on the theory that the array is having a hard
time.  What I need you to do is lower the speed of the array target in
the aic bios.  Unfortunately, the driver won't honour that setting at
the moment:  I'll see if I can work up the code that will do it.  The
attached patch will perform this artificially (for every device on every
aic79xx).

James

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -499,11 +499,13 @@ ahd_linux_target_alloc(struct scsi_targe
 	ahd_compile_devinfo(&devinfo, ahd->our_id, starget->id,
 			    CAM_LUN_WILDCARD, channel,
 			    ROLE_INITIATOR);
-	spi_min_period(starget) = AHD_SYNCRATE_MAX; /* We can do U320 */
+	//spi_min_period(starget) = AHD_SYNCRATE_MAX; /* We can do U320 */
+	spi_min_period(starget) = AHD_SYNCRATE_DT;
 	if ((ahd->bugs & AHD_PACED_NEGTABLE_BUG) != 0)
 		spi_max_offset(starget) = MAX_OFFSET_PACED_BUG;
 	else
 		spi_max_offset(starget) = MAX_OFFSET_PACED;
+	spi_max_offset(starget) = 63;
 	spi_max_width(starget) = ahd->features & AHD_WIDE;
 
 	ahd_set_syncrate(ahd, &devinfo, 0, 0, 0,


