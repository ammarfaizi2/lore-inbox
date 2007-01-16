Return-Path: <linux-kernel-owner+w=401wt.eu-S932435AbXAPIVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbXAPIVG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 03:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbXAPIVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 03:21:06 -0500
Received: from www.osadl.org ([213.239.205.134]:38308 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932435AbXAPIVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 03:21:05 -0500
Subject: Re: [patch-mm] Workaround for RAID breakage
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20070116004136.GF4067@kernel.dk>
References: <6bffcb0e0701120533o609489den9ca02f42e4d4839@mail.gmail.com>
	 <20070115071747.GA31267@elte.hu>
	 <1168848513.2941.100.camel@localhost.localdomain>
	 <1168884220.2941.144.camel@localhost.localdomain>
	 <20070116004136.GF4067@kernel.dk>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 09:27:18 +0100
Message-Id: <1168936038.2941.182.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-16 at 11:41 +1100, Jens Axboe wrote:
> > AFAICS this is intentional to avoid checks all over the place, but the
> > underflow check is missing. All we need to do is make sure, that in case
> > of ioc->plugged == 0 we return early and bug, if there is either a queue
> > plugged in or the plugged_list is not empty.
> > 
> > Jens ?
> 
> It should not go negative, that would be a bug elsewhere. So it's
> interesting if it does, we should definitely put a WARN_ON() check in
> there for that.

Well. All offenders come via queue_sync_plugs(). queue_sync_plugs()
calls blk_unplug_current().

One path which triggers is blk_sync_queue(). This happens e.g. in the
cleanup of the floppy check. There are other call pathes too.

The other is raid md_super_write(). It is not plugged and calls with the
barrier bit set, which executes the unlikely path in __make_request():

        if (unlikely(bio_barrier(bio))) {
                queue_sync_plugs(q);
                spin_lock_irq(q->queue_lock);
                goto get_rq;
        }

So you either need checks all over the place to avoid calling
blk_unplug_current(), or you prevent the unplug below 0 like I did. The
BUG_ON()s I added should catch any real invalid callers. But it's up to
you.

	tglx


