Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755253AbWKMUcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbWKMUcs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755272AbWKMUcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:32:48 -0500
Received: from brick.kernel.dk ([62.242.22.158]:45937 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1755253AbWKMUcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:32:47 -0500
Date: Mon, 13 Nov 2006 21:35:23 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1 (+ide-cd patches) regression: unable to rip cd
Message-ID: <20061113203523.GE15031@kernel.dk>
References: <20061110161355.GB15031@kernel.dk> <87u01717qw.fsf@sycorax.lbl.gov> <20061113200256.GC15031@kernel.dk> <87lkmfcdci.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lkmfcdci.fsf@sycorax.lbl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13 2006, Alex Romosan wrote:
> Jens Axboe <jens.axboe@oracle.com> writes:
> 
> > Great, problem fixed then, patch is already merged upstream so
> > 2.6.19 and next -rc (if any :-) should work. Thanks for your
> > persistent testing.
> 
> i've played with this a little bit more over the weekend. sometimes
> cdparanoia gets stuck trying to read some sector. with your patches i
> can now stop the process and restart it, and without touching the cd
> at all this next time cdparanoia finishes just fine. usually this
> happens after i try to rip a series of tracks so i wonder if some
> error counters don't get reset or something like that. maybe this is
> the expected behaviour, but i don't think i saw cdparanoia get stuck
> on the first track ever, usually it happens after some time.

There is a second error handling patch merged with the first patch as
well, perhaps it'll help you out. Attached here as well.

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index bddfebd..8821494 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -724,7 +724,7 @@ static int cdrom_decode_status(ide_drive
 		 * if we have an error, pass back CHECK_CONDITION as the
 		 * scsi status byte
 		 */
-		if (!rq->errors)
+		if (blk_pc_request(rq) && !rq->errors)
 			rq->errors = SAM_STAT_CHECK_CONDITION;
 
 		/* Check for tray open. */

-- 
Jens Axboe

