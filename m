Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWAIJ2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWAIJ2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 04:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWAIJ2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 04:28:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44309 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751188AbWAIJ23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 04:28:29 -0500
Date: Mon, 9 Jan 2006 10:30:25 +0100
From: Jens Axboe <axboe@suse.de>
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-kernel@vger.kernel.org, Sebastian <sebastian_ml@gmx.net>
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Message-ID: <20060109093025.GO3389@suse.de>
References: <20060107112443.GA18749@section_eight.mops.rwth-aachen.de> <20060107115340.GW3389@suse.de> <20060107115449.GB20748@section_eight.mops.rwth-aachen.de> <20060107115947.GY3389@suse.de> <20060107140843.GA23699@section_eight.mops.rwth-aachen.de> <20060107142201.GC3389@suse.de> <20060107160622.GA25918@section_eight.mops.rwth-aachen.de> <43BFFE08.70808@wasp.net.au> <20060107180211.GA12209@section_eight.mops.rwth-aachen.de> <43C00C32.9050002@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C00C32.9050002@wasp.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07 2006, Brad Campbell wrote:
> Sebastian wrote:
> >(please, don't forget to me and axboe@suse.de)
> 
> Did I? I'm sorry, I was *sure* I hit reply-to-all.
> 
> >>Yes, but now we need to find out why one interface fails while another 
> >>works.. I have the same problem here using cdrdao when ripping entire 
> >>disk images. I'd love to fix the real issue rather than work around it by 
> >>having userspace use another interface.
> >>I would have thought that both interfaces should return the same data..
> >>
> >>Brad
> >
> >I think cdrdao can use SG_IO if you tell it to. Check their documentation. 
> >Or did I misunderstand what you're saying?
> 
> Slightly.. If I'm not mistaken, we have a piece of software (for arguments 
> sake let's call it cdparanoia). The stock software uses the ATA or ATAPI 
> interface and produces bodged reads, the modified version you have uses 
> SG_IO and produces accurate reads.

It's the cdrom CDROMREADAUDIO vs SG_IO interface, there's not ata/atapi
specific interface.

> What I'm wondering is why the difference, and is there a problem with the 
> ATA/ATAPI interface that leads to this that needs looking into.

Definitely, that's the big question. It could just be that cdparanoia
enables extra error correction/checking, which it can do since it
tailors the SCSI commands to its liking. Where as with CDROMREADAUDIO,
you're basically stuck with whatever is coded into the cdrom layer.

> *or* is it an inherent problem/limitation with that particular interface

Could very well be. Once could use blktrace to see what the commands
submitted to the drives look like and get some data out of that.

Sebastian, care to try one more thing? Patch your kernel with this
little patch and try ripping a known "faulty" track again _not_ using
SG_IO. See if that produces the same faulty results again, or if it
actually works.

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 1539603..2e44d81 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -426,7 +426,7 @@ int register_cdrom(struct cdrom_device_i
 		cdi->exit = cdrom_mrw_exit;
 
 	if (cdi->disk)
-		cdi->cdda_method = CDDA_BPC_FULL;
+		cdi->cdda_method = CDDA_BPC_SINGLE;
 	else
 		cdi->cdda_method = CDDA_OLD;
 

-- 
Jens Axboe

