Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUCKMWP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 07:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUCKMWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 07:22:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4057 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261204AbUCKMWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 07:22:11 -0500
Date: Thu, 11 Mar 2004 13:22:03 +0100
From: Jens Axboe <axboe@suse.de>
To: Christophe Saout <christophe@saout.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       thornber@redhat.com
Subject: Re: [PATCH] backing dev unplugging
Message-ID: <20040311122203.GX6955@suse.de>
References: <20040310124507.GU4949@suse.de> <1079007445.26633.4.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079007445.26633.4.camel@leto.cs.pocnet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11 2004, Christophe Saout wrote:
> Am Mi, den 10.03.2004 schrieb Jens Axboe um 13:45:
> 
> > diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-rc2-mm1/drivers/md/dm-crypt.c linux-2.6.4-rc2-mm1-plug/drivers/md/dm-crypt.c
> > --- /opt/kernel/linux-2.6.4-rc2-mm1/drivers/md/dm-crypt.c	2004-03-09 13:08:48.000000000 +0100
> > +++ linux-2.6.4-rc2-mm1-plug/drivers/md/dm-crypt.c	2004-03-09 15:27:36.000000000 +0100
> > @@ -668,7 +668,7 @@
> >  
> >  		/* out of memory -> run queues */
> >  		if (remaining)
> > -			blk_run_queues();
> > +			blk_congestion_wait(bio_data_dir(clone), HZ/100);
> 
> Why did you change this? It was the way I wanted it.
> 
> If we were out of memory the buffers were allocated from a mempool and I
> want to get it out as soon as possible. If we are OOM the write will
> most likely be the VM trying to free some memory and it would be
> counterproductive to wait. It is not unlikely that we are the only
> writer to that disk so there's a chance that the queue is not congested.

Because it wasn't right, like most of those blk_run_queues(). The vm
should get things going, you basically just want to take a little nap
and retry. The idea with a small wait is to allow io to make some
progress, you gain nothing retrying right away (except wasting CPU
spinning). It might want to be 1 instead of HZ/100, though. I doubt it
would make much difference, since it's an OOM condition.

-- 
Jens Axboe

