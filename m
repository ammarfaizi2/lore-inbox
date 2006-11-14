Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933415AbWKNLdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933415AbWKNLdk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 06:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933416AbWKNLdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 06:33:40 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:3734 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S933415AbWKNLdk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 06:33:40 -0500
Message-ID: <4559A99B.6070207@drzeus.cx>
Date: Tue, 14 Nov 2006 12:33:47 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to cleanly shut down a block device
References: <455969F2.80401@drzeus.cx> <20061114075648.GK15031@kernel.dk> <45597B0A.3060409@drzeus.cx> <20061114084519.GL15031@kernel.dk> <45598462.80605@drzeus.cx> <20061114104844.GA15340@flint.arm.linux.org.uk>
In-Reply-To: <20061114104844.GA15340@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Just arrange for the mmc_queue_thread() to empty the queue when
> MMC_QUEUE_EXIT is set, and then exit.  I thought this was something
> that the block layer looked after (Jens must have missed this in his
> original review of the MMC code.)
>   

mmc_queue_thread() will empty the thread when MMC_QUEUE_EXIT is set. The
problem is that we do not set that bit until the last person closes the
device. In order to avoid problems we need to empty the queue before
mmc_blk_remove() exits (after which the card structure is no longer valid).

> The handling of userspace keeping the device open despite the hardware
> having been removed is already in place.
>
>   

Ok, that's one less problem for me to worry about. :)

Jens Axboe wrote:
> What do you mean by "killing off the queue"? As long as the queue can be
> gotten at, it needs to remain valid. That is what the references are
> for.
>   

I do:

del_gendisk();
(wait for queue to become empty, i.e. elv_next_request() == NULL)
blk_cleanup_queue();

and then assume that the request function will no longer be called for
this queue.

Suggested patch:

diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
index f9027c8..5025abe 100644
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -83,7 +83,6 @@ static void mmc_blk_put(struct mmc_blk_d
        md->usage--;
        if (md->usage == 0) {
                put_disk(md->disk);
-               mmc_cleanup_queue(&md->queue);
                kfree(md);
        }
        mutex_unlock(&open_lock);
@@ -553,12 +552,11 @@ static void mmc_blk_remove(struct mmc_ca
        if (md) {
                int devidx;
 
+               /* Stop new requests from getting into the queue */
                del_gendisk(md->disk);
 
-               /*
-                * I think this is needed.
-                */
-               md->disk->queue = NULL;
+               /* Then flush out any already in there */
+               mmc_cleanup_queue(&md->queue);
 
                devidx = md->disk->first_minor >> MMC_SHIFT;
                __clear_bit(devidx, dev_use);

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

