Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTE2MjR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 08:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbTE2MjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 08:39:16 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38056
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262202AbTE2MjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 08:39:13 -0400
Date: Thu, 29 May 2003 14:52:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Andrew Morton <akpm@digeo.com>, Jens Axboe <axboe@suse.de>,
       kernel@kolivas.org, matthias.mueller@rz.uni-karlsruhe.de,
       manish@storadinc.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030529125255.GH1453@dualathlon.random>
References: <3ED2DE86.2070406@storadinc.com> <20030528105029.GS845@suse.de> <20030528035939.72a973b0.akpm@digeo.com> <200305281305.44073.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305281305.44073.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 01:17:59PM +0200, Marc-Christian Petersen wrote:
> On Wednesday 28 May 2003 12:59, Andrew Morton wrote:
> 
> Hi Andrew,
> 
> > umm, I'd like confirmation of that.
> >
> > The waitqueue_active() test is wrong because of a missing barrier, but only
> > on SMP.  And if it does make a mistake it will surely correct itself when
> > the next request is put back. (That's why I left it there...)
> > More testing, please.
> Does the attached one make sense?

btw, I already fixed this race in my tree:

void blkdev_release_request(struct request *req)
{
	request_queue_t *q = req->q;

	req->rq_status = RQ_INACTIVE;
	req->q = NULL;

	/*
	 * Request may not have originated from ll_rw_blk. if not,
	 * assume it has free buffers and check waiters
	 */
	if (q) {
		list_add(&req->queue, &q->rq.free);
		if (++q->rq.count >= q->batch_requests && !blk_oversized_queue_batch(q)) {
			smp_mb();
			if (waitqueue_active(&q->wait_for_requests))
				wake_up(&q->wait_for_requests);


so if this was this one my tree wouldn't exibith it (and it would
trigger on smp only).

> 
> ciao, Marc
> 
> 




Andrea
