Return-Path: <linux-kernel-owner+w=401wt.eu-S1751535AbWLLRBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbWLLRBT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWLLRBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:01:19 -0500
Received: from palrel13.hp.com ([156.153.255.238]:42533 "EHLO palrel13.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbWLLRBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:01:18 -0500
Date: Tue, 12 Dec 2006 11:01:11 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       chase.maupin@hp.com
Subject: Re: [PATCH 9/12] repost: cciss: add busy_configuring flag
Message-ID: <20061212170111.GA26017@beardog.cca.cpqcorp.net>
References: <20061106202559.GI17847@beardog.cca.cpqcorp.net> <20061106203200.GG19471@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061106203200.GG19471@kernel.dk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 09:32:00PM +0100, Jens Axboe wrote:
> On Mon, Nov 06 2006, Mike Miller (OS Dev) wrote:
> > PATCH 9 of 12
> > 
> > This patch adds a check for busy_configuring to prevent starting a queue
> > on a drive that may be in the midst of updating, configuring, deleting, etc.
> > 
> > This had a test for if the queue was stopped or plugged but that seemed
> > to cause issues.
> > Please consider this for inclusion.
> > 
> > Thanks,
> > mikem
> > 
> > Signed-off-by: Mike Miller <mike.miller@hp.com>
> > 
> > --------------------------------------------------------------------------------
> > 
> > ---
> > 
> >  drivers/block/cciss.c |    5 ++++-
> >  1 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff -puN drivers/block/cciss.c~cciss_busy_conf_for_lx2619-rc4 drivers/block/cciss.c
> > --- linux-2.6/drivers/block/cciss.c~cciss_busy_conf_for_lx2619-rc4	2006-11-06 13:27:53.000000000 -0600
> > +++ linux-2.6-root/drivers/block/cciss.c	2006-11-06 13:27:53.000000000 -0600
> > @@ -1190,8 +1190,11 @@ static void cciss_check_queues(ctlr_info
> >  		/* make sure the disk has been added and the drive is real
> >  		 * because this can be called from the middle of init_one.
> >  		 */
> > -		if (!(h->drv[curr_queue].queue) || !(h->drv[curr_queue].heads))
> > +		if (!(h->drv[curr_queue].queue) ||
> > +		    !(h->drv[curr_queue].heads) ||
> > +		    h->drv[curr_queue].busy_configuring)
> >  			continue;
> > +
> >  		blk_start_queue(h->gendisk[curr_queue]->queue);
> 
> This is racy, because you don't start the queue when you unset
> ->busy_configuring later on. For this to be safe, you need to call
> blk_start_queue() when you set ->busy_configuring to 0.

Jens, please see Chase's reply to your concerns:
> busy_configuring - I do not think this is racy.  This
> flag is used only when we are removing/deleting a disk.  In
> this case the queue is cleaned up and the disk is deleted.
> If we are doing that then there is no queue to start later.
> The check of this flag in the interrupt handler is to prevent
> us from trying to start a queue that is in the middle of
> being deleted.  This flag could be called busy_deleting.
>

Thanks,
mikem, Chase
