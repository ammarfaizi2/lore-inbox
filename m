Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbUCAWQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 17:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUCAWQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 17:16:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:8608 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261454AbUCAWPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 17:15:33 -0500
Date: Mon, 1 Mar 2004 14:17:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: per-cpu blk_plug_list
Message-Id: <20040301141728.71e49546.akpm@osdl.org>
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB501F2AB4C@scsmsx401.sc.intel.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2AB4C@scsmsx401.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> We were surprised to find global lock in I/O path still exists on 2.6
> kernel.

Well I'm surprised that nobody has complained about it yet ;)

Disks are slow.  100 requests per second, perhaps.  So a single lock is
generally OK until you have a vast number of disks and lots of
contention-prone CPUs.

Yes, we should fix this.

> blk_plug_list/blk_plug_lock manages plug/unplug action.  When you have
> lots of cpu simultaneously submits I/O, there are lots of movement with
> the device queue on and off that global list.  Our measurement showed
> that blk_plug_lock contention prevents linux-2.6.3 kernel to scale pass
> beyond 40 thousand I/O per second in the I/O submit path.

Looking at the guts of your patch:

/*
 * blk_run_queues_cpu - fire all plugged queues on this cpu
 */
#define blk_plug_entry(entry) list_entry((entry), request_queue_t, plug_list)
void blk_run_queues_cpu(int cpu)
{
	struct blk_plug_struct * cur_blk_plug = &blk_plug_array[cpu];
	struct list_head * head = &cur_blk_plug->blk_plug_head;
	spinlock_t *lock = &cur_blk_plug->blk_plug_lock;

	spin_lock_irq(lock);
	while (!list_empty(head)) {
		request_queue_t *q = blk_plug_entry(head->next);
		spin_unlock_irq(lock);
		q->unplug_fn(q);
		spin_lock_irq(lock);
	}
	spin_unlock_irq(lock);
}

void blk_run_queues(void)
{
	int i;

	for_each_cpu(i)
		blk_run_queues_cpu(i);
}

How on earth do you know that when direct-io calls blk_run_queues_cpu(), it
is still running on the cpu which initially plugged the queue(s)?

And your patch might have made the much-more-frequently-called
blk_run_queues() more expensive.

There are minor issues with lack of preemption safety and not using the
percpu data infrastructure, but they can wait.

You haven't told us how many disks are in use?  At 100k IO's per second it
would be 500 to 1000 disks, yes?

I assume you tried it, but does this help?

diff -puN drivers/block/ll_rw_blk.c~a drivers/block/ll_rw_blk.c
--- 25/drivers/block/ll_rw_blk.c~a	Mon Mar  1 13:52:37 2004
+++ 25-akpm/drivers/block/ll_rw_blk.c	Mon Mar  1 13:52:45 2004
@@ -1251,6 +1251,9 @@ void blk_run_queues(void)
 {
 	LIST_HEAD(local_plug_list);
 
+	if (list_empty(&blk_plug_list))
+		return;
+
 	spin_lock_irq(&blk_plug_lock);
 
 	/*

_

