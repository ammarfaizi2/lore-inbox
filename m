Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSFUK21>; Fri, 21 Jun 2002 06:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316496AbSFUK20>; Fri, 21 Jun 2002 06:28:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13794 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315746AbSFUK2Z>;
	Fri, 21 Jun 2002 06:28:25 -0400
Date: Fri, 21 Jun 2002 12:28:19 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: hda: error: DMA in progress..
Message-ID: <20020621102819.GG27090@suse.de>
References: <20020621092459.GD27090@suse.de> <3D12FA4D.6060500@evision-ventures.com> <20020621101202.GF27090@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020621101202.GF27090@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21 2002, Jens Axboe wrote:
> > And now we see that it is indeed apparently really interacting with
> > the TCQ code in bad ways. But if I look down from the above code (Just 
> > below in ide.c)
> > 
> > 	if (blk_queue_plugged(&drive->queue)) {
> > 			BUG_ON(!drive->using_tcq);
> > 			break;
> > 		}
> > 
> > It seems like the check which is catching reality right now
> > is bogous in itself. Becouse having DMA running would be
> > only problematic if the queue was still plugged. (Right?)
> > So please just disable the check.
> 
> Not exactly, let me see if I remember the race here... The queue can
> become plugged when we queue one request with the drive (the only on the
> queue at that time), and then try to queue another right after (hence
> only a tcq issue). In that time period, we drop the queue lock, so it's
> indeed possible for the block layer to plug the queue before we reach
> the above code again. The drive can be in two states here, 1) IDE_DMA is
> set because the drive didn't release the bus (or it did, and it already
> reconnected), or 2) drive is disconnected from the bus.

Sorry that's not true (#1), it's _never_ valid for IDE_DMA to be set
here even when using TCQ (less so, if possible, for non-tcq :-). At
least according to the old semantics. That's only the case when using
speculative starts of the dma engine for tcq with release interrupt
enabled, which we don't use on Linux.

-- 
Jens Axboe

