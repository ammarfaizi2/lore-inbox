Return-Path: <linux-kernel-owner+w=401wt.eu-S932170AbXAPAlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbXAPAlo (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 19:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbXAPAlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 19:41:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15997 "EHLO virtualhost.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932170AbXAPAln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 19:41:43 -0500
Date: Tue, 16 Jan 2007 11:41:36 +1100
From: Jens Axboe <jens.axboe@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch-mm] Workaround for RAID breakage
Message-ID: <20070116004136.GF4067@kernel.dk>
References: <6bffcb0e0701120533o609489den9ca02f42e4d4839@mail.gmail.com> <20070115071747.GA31267@elte.hu> <1168848513.2941.100.camel@localhost.localdomain> <1168884220.2941.144.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168884220.2941.144.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15 2007, Thomas Gleixner wrote:
> On Mon, 2007-01-15 at 09:08 +0100, Thomas Gleixner wrote:
> > > Thomas saw something similar yesterday and he the partial results that 
> > > git.block (between rc2-mm1 and rc4-mm1) breaks certain disk drivers or 
> > > filesystems drivers. For me it worked fine, so it must be only on some 
> > > combinations. The changes to ll_rw_block.c look quite extensive.
> > 
> > Yes. Jens Axboe confirmed yesterday that the plug changes broke RAID.
> 
> I tracked this down and found two problems:
> 
> - The new plug/unplug code does not check for underruns. That allows the
> plug count (ioc->plugged) to become negative. This gets triggered from
> various places. 
>
> AFAICS this is intentional to avoid checks all over the place, but the
> underflow check is missing. All we need to do is make sure, that in case
> of ioc->plugged == 0 we return early and bug, if there is either a queue
> plugged in or the plugged_list is not empty.
> 
> Jens ?

It should not go negative, that would be a bug elsewhere. So it's
interesting if it does, we should definitely put a WARN_ON() check in
there for that.

> - The raid1 code has no bitmap set in remount r/w. So the
> pending_bio_list gets not processed for quite a time. The workaround is
> to kick mddev->thread, so the list is processed. Not sure about that.
> 
> Neil ?

Super, thanks for that Thomas! I'll merge it in the plug branch.

-- 
Jens Axboe

