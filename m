Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266847AbVBFITD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266847AbVBFITD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 03:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267127AbVBFITC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 03:19:02 -0500
Received: from av1-2-sn3.vrr.skanova.net ([81.228.9.106]:54731 "EHLO
	av1-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S266889AbVBFISg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 03:18:36 -0500
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
Cc: laurent.riffard@free.fr, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1 : mount UDF CDRW stuck in D state
References: <4204F91B.5040302@free.fr> <m3vf96r017.fsf@telia.com>
	<m3sm4apig8.fsf@telia.com> <20050205222301.337de629.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 06 Feb 2005 09:18:20 +0100
In-Reply-To: <20050205222301.337de629.akpm@osdl.org>
Message-ID: <m37jlmp0dv.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Peter Osterlund <petero2@telia.com> wrote:
> >
> > Peter Osterlund <petero2@telia.com> writes:
> > 
> > > Laurent Riffard <laurent.riffard@free.fr> writes:
> > > 
> > > > This is kernel 2.6.11-rc3-mm1. I can't mount an UDF-formatted cdrw
> > > > in packet-writing mode. Mount process gets stuck in D state.
> > > > 
> > > > Mounting and writing this media in packet-writing mode works fine
> > > > with kernel 2.6.11-rc2-mm2.
> 
> > Anyway, mount hangs for me too if I use an IDE drive, both with native
> > ide and ide-scsi emulation. It doesn't hang with a USB drive though. I
> > verified that 2.6.11-rc3 does not have this problem. Reverting
> > bk-ide-dev does *not* fix the problem.
> 
> Bah.  sysrq-T output would be helpful.

I was wrong about USB, it doesn't work either. The IDE drive failed
with a non-packet formatted disc, so I didn't bother to check what was
inserted in the USB drive. It turned out it was empty and in that case
the driver doesn't hang.

Anyway, the problem is that the add-struct-request-end_io-callback
patch forgot to update pktcdvd.c. This patch fixes it. It should
probably be merged into the add-struct-request-end_io-callback patch,
because that patch already fixes up other struct request users.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/block/pktcdvd.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/block/pktcdvd.c~pktcdvd-endio-fix drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~pktcdvd-endio-fix	2005-02-06 08:59:16.000000000 +0100
+++ linux-petero/drivers/block/pktcdvd.c	2005-02-06 09:01:22.000000000 +0100
@@ -375,6 +375,7 @@ static int pkt_generic_packet(struct pkt
 	rq->ref_count++;
 	rq->flags |= REQ_NOMERGE;
 	rq->waiting = &wait;
+	rq->end_io = blk_end_sync_rq;
 	elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 1);
 	generic_unplug_device(q);
 	wait_for_completion(&wait);
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
