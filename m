Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266003AbUIOMzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUIOMzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 08:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUIOMx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 08:53:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46052 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263626AbUIOMwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:52:32 -0400
Date: Wed, 15 Sep 2004 14:50:57 +0200
From: Jens Axboe <axboe@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
Message-ID: <20040915125056.GD4111@suse.de>
References: <20040913015003.5406abae.akpm@osdl.org> <20040915113635.GO9106@holomorphy.com> <20040915113833.GA4111@suse.de> <20040915122852.GQ9106@holomorphy.com> <20040915124124.GC4111@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915124124.GC4111@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15 2004, Jens Axboe wrote:
> On Wed, Sep 15 2004, William Lee Irwin III wrote:
> > On Mon, Sep 13, 2004 at 01:50:03AM -0700, Andrew Morton wrote:
> > >>> +cfq-iosched-v2.patch
> > >>>  Major revamp of the CFQ IO scheduler
> > 
> > On Wed, Sep 15 2004, William Lee Irwin III wrote:
> > >> While editing some files while booted into 2.6.9-rc1-mm5:
> > >> # ----------- [cut here ] --------- [please bite here ] ---------
> > >> Kernel BUG at cfq_iosched:1359
> > 
> > On Wed, Sep 15, 2004 at 01:38:34PM +0200, Jens Axboe wrote:
> > > Hmm, ->allocated is unbalanced. What is your io setup like (adapter,
> > > etc)?
> > 
> > 2 Maxtor Atlas10K 10Krpm U320 disks attached to some aic7902's. No
> > binary or 3rd-party modules anywhere near the box' fs or even the
> > network the thing is on. lspci output follows.
> 
> Hmm, I can only see this happening if rq->flags has its direction bit
> changed between the allocation time and the time of freeing. I'll look
> over scsi and see if I can find any traces of that, don't see any
> immediately.

Can you try if this works?

--- linux-2.6.9-rc1-mm5/drivers/block/cfq-iosched.c~	2004-09-15 14:50:14.941876065 +0200
+++ linux-2.6.9-rc1-mm5/drivers/block/cfq-iosched.c	2004-09-15 14:51:09.889996813 +0200
@@ -195,6 +195,7 @@
 	unsigned int in_flight : 1;
 	unsigned int accounted : 1;
 	unsigned int is_sync   : 1;
+	unsigned int is_write  : 1;
 };
 
 static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *, unsigned long);
@@ -1353,12 +1354,12 @@
 		if (crq->io_context)
 			put_io_context(crq->io_context->ioc);
 
+		BUG_ON(!cfqq->allocated[crq->is_write]);
+		cfqq->allocated[crq->is_write]--;
+
 		mempool_free(crq, cfqd->crq_pool);
 		rq->elevator_private = NULL;
 
-		BUG_ON(!cfqq->allocated[rw]);
-		cfqq->allocated[rw]--;
-
 		smp_mb();
 		cfq_check_waiters(q, cfqq);
 		cfq_put_queue(cfqq);
@@ -1415,6 +1416,7 @@
 		crq->io_context = cic;
 		crq->service_start = crq->queue_start = 0;
 		crq->in_flight = crq->accounted = crq->is_sync = 0;
+		crq->is_write = rw;
 		rq->elevator_private = crq;
 		cfqq->allocated[rw]++;
 		cfqq->alloc_limit[rw] = 0;

-- 
Jens Axboe

