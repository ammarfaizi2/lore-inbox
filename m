Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263196AbRE1W00>; Mon, 28 May 2001 18:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263197AbRE1W0Q>; Mon, 28 May 2001 18:26:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1543 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263196AbRE1W0E>;
	Mon, 28 May 2001 18:26:04 -0400
Date: Tue, 29 May 2001 00:26:00 +0200
From: Jens Axboe <axboe@kernel.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [patch]: ide dma timeout retry in pio
Message-ID: <20010529002600.B26871@suse.de>
In-Reply-To: <20010528223733.O9102@suse.de> <Pine.LNX.4.10.10105281501100.366-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10105281501100.366-100000@master.linux-ide.org>; from andre@linux-ide.org on Mon, May 28, 2001 at 03:15:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28 2001, Andre Hedrick wrote:
> > > resorting to PIO would be such a shame, not only because it eats
> > > CPU so badly, but also because it has no checksum like UDMA...
> > 
> > Look at the patch -- we resort to pio for _one_ hunk. That's 8 sectors
> > tops, then back to dma. Hardly a big issue.
> 
> Unless we reissue the entire request from scratch you have no idea what if
> anything is on the platters.  Since one can generally only get control
> over the device with a soft reset, you have to assume that anything and
> everything about that request was lost at the device level and begin
> again.

Look at the patch, that's what it does. For ide dma, it's all or
nothing. So if it times out, no part of the request is ended
ide_dma_timeout_retry does the sanity re-setup of the request for good
measure, and it might be needed in the future when ide dma can do
partial requests (2.5, not now). The request _is_ reissued from scratch.

> <RANT>
> This is why it is so important to change to TFAM, because we carry a copy
> of the setup-seek operations with the request, and not unless we error out
> do we change that content.  Thus is a timeout fault not a error case we
> have all the info to re-issue or copy into a retry queue.  But as we all
> know the proper fix can not be even attempted until 2.5...
> </RANT>

This is bull shit. If IDE didn't muck around with the request so much in
the first place, the info could always be trusted. Even so, we have the
hard_* numbers to go by. So this argument does not hold.

> As I recall, there is a way to reinsert the faulted request, but that

Again, look at the patch. The request is never off the list, so there is
never a reason to reinsert. hwgroup->busy is cleared (and, again for
good measure, hwgroup->rq), so ide_do_request/start_request will get the
same request that we just handled.

> means the request_struct needs fault counter.  If it is truly a DMA error

->errors, it's already there.

> because of re-seeks then the timeout value for that request must be
> expanded.

Yep

-- 
Jens Axboe

