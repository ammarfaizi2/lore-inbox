Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWFFHNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWFFHNG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 03:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWFFHNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 03:13:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22801 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932129AbWFFHNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 03:13:04 -0400
Date: Tue, 6 Jun 2006 09:15:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3 - crash in cfq_queue_empty() after iosched change
Message-ID: <20060606071537.GP4400@suse.de>
References: <200606051442.k55EghgI004703@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606051442.k55EghgI004703@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05 2006, Valdis.Kletnieks@vt.edu wrote:
> I've been hitting this about once every two weeks for a while now,
> probably back to a 2.6.16-rc or so.  It always bites at the same time
> while my laptop was at a point very late in bootup. I finally caught
> one when I had pen, paper, *and* time to chase it a bit rather than
> reboot.  Sorry for the very partial traceback, it's not a good CTS day
> and I didn't have a digital camera handy.
> 
> BUG: Unable to handle kernel NULL pointer dereference at 0x0000005c
> EIP at cfq_queue_empty+0x9/0x15
> call trace:
> 	elv_queue_empty+0x20/0x22
> 	ide_do_request+0xa4/0x788
> 	ide_intr+0x1ec/0x236
> 	handle_IRQ_eent+0x27/0x52
> 	handle_level_IRQ+0xb6
> 	do_IRQ+0x5d/0x78
> 	common_interrupt+0x1a/0x20
> 
> In my .config:
> 
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> CONFIG_DEFAULT_IOSCHED="anticipatory"
> 
> This happened very soon (within a few milliseconds or two) after my /etc/rc.local did:
> 
> echo cfq >| /sys/block/hda/queue/scheduler
> 
> (The next executable statement in /etc/rc.local is this:
> echo noop >| /sys/block/hdb/queue/scheduler  and 'last sysfs file' still
> pointed at /dev/hda).
> 
> It *looks* like the problem is in elevator_switch() in block/elevator.c:
> 
>        while (q->rq.elvpriv) {
>                 blk_remove_plug(q);
>                 q->request_fn(q);
>                 spin_unlock_irq(q->queue_lock);
>                 msleep(10);
>                 spin_lock_irq(q->queue_lock);
>                 elv_drain_elevator(q);
>         }
> 
> this--> spin_unlock_irq(q->queue_lock);
> 
>         /*
>          * unregister old elevator data
>          */
>         elv_unregister_queue(q);
>         old_elevator = q->elevator;
> 
>         /*
>          * attach and start new elevator
>          */
>         if (elevator_attach(q, e))
>                 goto fail;
> 
> should be down here someplace, after elevator_attach(), I suspect?
> Looks like the disk popped an IRQ after we had installed the
> iosched_cfq.ops[] but q->elevator->elevator_data hadn't been
> initialized yet...
> 
> (I'd attach a patch, except I'm not positive I have the diagnosis
> right?)

I think your analysis is pretty good, there's definitely a period there
where we don't want the queueing invoked. Does this help?

diff --git a/block/elevator.c b/block/elevator.c
index 8768a36..429702a 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -806,8 +806,6 @@ static int elevator_switch(request_queue
 		elv_drain_elevator(q);
 	}
 
-	spin_unlock_irq(q->queue_lock);
-
 	/*
 	 * unregister old elevator data
 	 */
@@ -823,6 +821,8 @@ static int elevator_switch(request_queue
 	if (elv_register_queue(q))
 		goto fail_register;
 
+	spin_unlock_irq(q->queue_lock);
+
 	/*
 	 * finally exit old elevator and turn off BYPASS.
 	 */
@@ -831,16 +831,19 @@ static int elevator_switch(request_queue
 	return 1;
 
 fail_register:
+	spin_unlock_irq(q->queue_lock);
 	/*
 	 * switch failed, exit the new io scheduler and reattach the old
 	 * one again (along with re-adding the sysfs dir)
 	 */
 	elevator_exit(e);
 	e = NULL;
+	spin_lock_irq(q->queue_lock);
 fail:
 	q->elevator = old_elevator;
 	elv_register_queue(q);
 	clear_bit(QUEUE_FLAG_ELVSWITCH, &q->queue_flags);
+	spin_unlock_irq(q->queue_lock);
 	if (e)
 		kobject_put(&e->kobj);
 	return 0;

-- 
Jens Axboe

