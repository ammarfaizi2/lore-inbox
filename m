Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752332AbWCFJUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbWCFJUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752333AbWCFJUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:20:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10869 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1752332AbWCFJUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:20:24 -0500
Date: Mon, 6 Mar 2006 10:19:59 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] bsg, block layer sg
Message-ID: <20060306091959.GZ4329@suse.de>
References: <20060302111945.GG4329@suse.de> <20060304180814.11f459b9.akpm@osdl.org> <20060306085735.GY4329@suse.de> <20060306011355.4df811f6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306011355.4df811f6.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06 2006, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > ...
> > > 
> > > If you expand the two above statements you get:
> > > 
> > > 	spin_lock_irqsave(q->queue_lock, flags);
> > > 	__elv_add_request(q, rq, where, plug);
> > > 	spin_unlock_irqrestore(q->queue_lock, flags);
> > > 	spin_lock_irq(q->queue_lock);
> > > 	__generic_unplug_device(q);
> > > 	spin_unlock_irq(q->queue_lock);
> > > 
> > > which is a bit sad.
> > 
> > Indeed, I'll do the locking manually and use the __ functions.
> 
> blk_execute_rq_nowait() and pkt_generic_packet() also do the above two
> calls.   It might be worth creating a new library function.

Yes it might, there are other call sites like this in the kernel. But
it's basically blk_execute_rq_nowait(). I'll make that change.

> > > > +static int bsg_complete_all_commands(struct bsg_device *bd)
> > > > +{
> > > > +	struct bsg_command *bc;
> > > > +	int ret, tret;
> > > > +
> > > > +	dprintk("%s: entered\n", bd->name);
> > > > +
> > > > +	set_bit(BSG_F_BLOCK, &bd->flags);
> > > > +
> > > > +	/*
> > > > +	 * wait for all commands to complete
> > > > +	 */
> > > > +	ret = 0;
> > > > +	do {
> > > > +		ret = bsg_io_schedule(bd, TASK_UNINTERRUPTIBLE);
> > > > +		/*
> > > > +		 * look for -ENODATA specifically -- we'll sometimes get
> > > > +		 * -ERESTARTSYS when we've taken a signal, but we can't
> > > > +		 * return until we're done freeing the queue, so ignore
> > > > +		 * it.  The signal will get handled when we're done freeing
> > > > +		 * the bsg_device.
> > > > +		 */
> > > > +	} while (ret != -ENODATA);
> > > > +
> > > > +	/*
> > > > +	 * discard done commands
> > > > +	 */
> > > 
> > > Would it be useful to reap the completed commands earlier?  While their
> > > predecessors are still in flight?
> > 
> > Not sure I follow... You mean if someone attempts to queue and fails
> > because we are out of commands, then try and reap some done commands?
> 
> Rather than waiting for all commands to complete then freeing them all
> up, it might be possible to free some of them earlier, while the rest
> are still in flight.  Pipeline the reaping with the I/O completion.  A
> minor saving in cycles and memory, perhaps.   Probably it's not worth
> the complexity - I was just asking ;)

For the example above, it's the final shutdown case just waiting for all
commands to complete. So definitely not worth extra complexity :-)

-- 
Jens Axboe

