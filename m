Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267382AbTAVI0d>; Wed, 22 Jan 2003 03:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbTAVI0d>; Wed, 22 Jan 2003 03:26:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45471 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267382AbTAVI0c>;
	Wed, 22 Jan 2003 03:26:32 -0500
Date: Wed, 22 Jan 2003 09:35:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>, cdwrite@other.debian.org,
       greg@ulima.unil.ch, linux-kernel@vger.kernel.org
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
Message-ID: <20030122083530.GA20780@suse.de>
References: <200301220823.h0M8NG2o022692@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301220823.h0M8NG2o022692@burner.fokus.gmd.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22 2003, Joerg Schilling wrote:
> >From axboe@suse.de Wed Jan 22 09:06:12 2003
> 
> >> >BURN-Free is ON.
> >> >Starting new track at sector: 0
> >> >Track 01:    4 of 4001 MB written (fifo  96%)  16.1x.cdrecord-prodvd: Success. write_g1: scsi sendcmd: no error
> >> >CDB:  2A 00 00 00 08 B8 00 00 1F 00
> >> >status: 0x1 (GOOD STATUS)
> >> >resid: 63488
> >> >cmd finished after 0.008s timeout 100s
> >> 
> >> I can't tell you what happened because the kernel is broken :-(
> >> 
> >> If you fix the kernel, you will get a readble error message,
> 
> >How helpful. How about saying what's broken instead and I'd be happy to
> >fix it.
> 
> I thought it's obvious: It is most likely a problem caused by the broken 
> bit #defines in the Linux kernel for the SCSI status byte. I assume that
> status should be 0x02 instead of 0x01. In addition, I would guess that

Sounds plausible. Patch attached. Anyone care to expand on _why_ these
status bytes are shifted one bit?

===== drivers/ide/ide-cd.c 1.35 vs edited =====
--- 1.35/drivers/ide/ide-cd.c	Thu Nov 21 22:56:59 2002
+++ edited/drivers/ide/ide-cd.c	Wed Jan 22 09:34:28 2003
@@ -706,7 +706,7 @@
 		 * scsi status byte
 		 */
 		if ((rq->flags & REQ_BLOCK_PC) && !rq->errors)
-			rq->errors = CHECK_CONDITION;
+			rq->errors = CHECK_CONDITION << 1;
 
 		/* Check for tray open. */
 		if (sense_key == NOT_READY) {

-- 
Jens Axboe

