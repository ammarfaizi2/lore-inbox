Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVC3HOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVC3HOJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 02:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVC3HOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 02:14:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20864 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261778AbVC3HOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 02:14:03 -0500
Date: Wed, 30 Mar 2005 09:13:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] new fifo I/O elevator that really does nothing at all
Message-ID: <20050330071357.GB16636@suse.de>
References: <20050329080559.GD16636@suse.de> <4249D4C7.90808@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4249D4C7.90808@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29 2005, Bill Davidsen wrote:
> Jens Axboe wrote:
> >On Mon, Mar 28 2005, Chen, Kenneth W wrote:
> >
> >>The noop elevator is still too fat for db transaction processing
> >>workload.  Since the db application already merged all blocks before
> >>sending it down, the I/O presented to the elevator are actually not
> >>merge-able anymore. Since I/O are also random, we don't want to sort
> >>them either.  However the noop elevator is still doing a linear search
> >>on the entire list of requests in the queue.  A noop elevator after
> >>all isn't really noop.
> >>
> >>We are proposing a true no-op elevator algorithm, no merge, no
> >>nothing. Just do first in and first out list management for the I/O
> >>request.  The best name I can come up with is "FIFO".  I also piggy
> >>backed the code onto noop-iosched.c.  I can easily pull those code
> >>into a separate file if people object.  Though, I hope Jens is OK with
> >>it.
> >
> >
> >It's not quite ok, because you don't honor the insertion point in
> >fifo_add_request. The only 'fat' part of the noop io scheduler is the
> >merge stuff, the original plan was to move that to a hash table lookup
> >instead like the other io schedulers do. So I would suggest just
> >changing noop to hash the request on the end point for back merges and
> >forget about front merges, since they are rare anyways. Hmm actually,
> >the last merge hint should catch most of the merges at almost zero cost.
> 
> Making the noop faster is clearly a good thing, but some database 
> software may depend on transaction order as provided by a true fifo 
> process. It would be nice to have both.

Just look at the code. It does FIFO for any request that _isn't_
specified as ELEVATOR_INSERT_FRONT - which means any fs request, or any
plain pc request. There is no specific reordering going on.

Drivers expect to be able to add a request back at the head, for eg
retrying it after a QUEUE_BUSY or similar condition.

-- 
Jens Axboe

