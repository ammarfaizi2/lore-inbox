Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbUKXRmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUKXRmp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbUKXRhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:37:08 -0500
Received: from zeus.kernel.org ([204.152.189.113]:36033 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262634AbUKXRfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:35:34 -0500
Date: Wed, 24 Nov 2004 14:40:38 +0100
From: Jens Axboe <axboe@suse.de>
To: "Christopher S. Aker" <caker@theshore.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-bk7 - Badness in cfq_put_request at drivers/block/cfq-iosched.c:1402
Message-ID: <20041124134038.GF13847@suse.de>
References: <001301c4d1f6$941d1370$0201a8c0@hawk> <20041124130139.GC13847@suse.de> <20041124132449.GD13847@suse.de> <002e01c4d22a$f426f630$0201a8c0@hawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002e01c4d22a$f426f630$0201a8c0@hawk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24 2004, Christopher S. Aker wrote:
> > On Wed, Nov 24 2004, Jens Axboe wrote:
> > > On Wed, Nov 24 2004, Christopher S. Aker wrote:
> > > > Badness in cfq_put_request at drivers/block/cfq-iosched.c:1402
> > > >  [<c025eed4>] cfq_put_request+0xcc/0x119
> > > >  [<c0252520>] elv_put_request+0x25/0x27
> > > >  [<c02553a5>] __blk_put_request+0x66/0xab
> > > >  [<c0256647>] end_that_request_last+0x6a/0x10b
> > > >  [<c029d836>] scsi_end_request+0xbf/0xe6
> > > >  [<c029db11>] scsi_io_completion+0x117/0x4b6
> > > >  [<c029b2e2>] scsi_delete_timer+0x1a/0x66
> > > >  [<c02a9290>] sd_rw_intr+0x89/0x30f
> > > >  [<c0114472>] rebalance_tick+0xac/0xbb
> > > >  [<c0298e8a>] scsi_finish_command+0x85/0xd9
> > > >  [<c0298d9d>] scsi_softirq+0xb7/0xdd
> > > >  [<c011cba7>] __do_softirq+0xb7/0xc6
> > > >  [<c011cbe3>] do_softirq+0x2d/0x2f
> > > >  [<c01046b6>] do_IRQ+0x1e/0x24
> > > >  [<c0102db2>] common_interrupt+0x1a/0x20
> > > >  [<c01005da>] mwait_idle+0x31/0x48
> > > >  [<c01005a0>] cpu_idle+0x33/0x3c
> > > >  [<c046aa49>] start_kernel+0x175/0x1b1
> > > >  [<c046a4bd>] unknown_bootoption+0x0/0x1ab
> > > 
> > > It's a known issue, just not fixed yet... You can ignore the warning,
> > > cfq recovers the condition.
> > 
> > Is this an SMP machine, btw?
> 
> Yep.

Can you try this simple check to see if it triggers anything?

===== cfq-iosched.c 1.13 vs edited =====
--- 1.13/drivers/block/cfq-iosched.c	2004-10-30 01:35:21 +02:00
+++ edited/cfq-iosched.c	2004-11-24 14:40:13 +01:00
@@ -1389,6 +1389,8 @@
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct cfq_rq *crq = RQ_DATA(rq);
 
+	WARN_ON(!spin_is_locked(q->queue_lock));
+
 	if (crq) {
 		struct cfq_queue *cfqq = crq->cfq_queue;
 

-- 
Jens Axboe

