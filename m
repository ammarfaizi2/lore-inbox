Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbUCJUW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 15:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262816AbUCJUVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 15:21:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42715 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262765AbUCJUTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:19:21 -0500
Date: Wed, 10 Mar 2004 21:19:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, kenneth.w.chen@intel.com,
       Andrew Morton <akpm@osdl.org>, thornber@redhat.com
Subject: Re: [PATCH] backing dev unplugging
Message-ID: <20040310201905.GG15087@suse.de>
References: <20040310124507.GU4949@suse.de> <404F7727.8080806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404F7727.8080806@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10 2004, Jeff Garzik wrote:
> Jens Axboe wrote:
> >Hi,
> >
> >Here's a first cut at killing global plugging of block devices to reduce
> >the nasty contention blk_plug_lock caused. This introduceds per-queue
> >plugging, controlled by the backing_dev_info. Observations:
> >
> >- Most uses of blk_run_queues() without a specific context was bogus.
> >  Usually the act of kicking the targets in question should be (and
> >  already are) performed by other activities, such as making the vm
> >  flushing run to free memory.
> >
> >- Some use of blk_run_queues() really just want to kick the final queue
> >  where the bio goes to. I've added bio_sync() (BIO_RW_SYNC) to manage
> >  those, if the queue needs unplugging we'll do it when holding the lock
> >  for the queue already.
> >
> >- The dm bit needs careful examination and checking of Joe. It could be
> >  more clever and maintain plug state of each target, I just added a
> >  dm_table unplug all functionality.
> >
> >Patch is against 2.6.4-rc2-mm1.
> 
> I like it a lot.

Thanks

> Any chance some of these newly-shortened functions can become static 
> inline as well?

Yeah most likely. Remember this is just a first version, there's room
for a little cleanup here and there for sure.

> >@@ -1100,13 +1092,11 @@
> > 	 * don't plug a stopped queue, it must be paired with 
> > 	 blk_start_queue()
> > 	 * which will restart the queueing
> > 	 */
> >-	if (!blk_queue_plugged(q)
> >-	    && !test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
> >-		spin_lock(&blk_plug_lock);
> >-		list_add_tail(&q->plug_list, &blk_plug_list);
> >+	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
> >+		return;
> >+
> >+	if (!test_and_set_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
> > 		mod_timer(&q->unplug_timer, jiffies + q->unplug_delay);
> >-		spin_unlock(&blk_plug_lock);
> >-	}
> > }
> > 
> > EXPORT_SYMBOL(blk_plug_device);
> >@@ -1118,15 +1108,12 @@
> > int blk_remove_plug(request_queue_t *q)
> > {
> > 	WARN_ON(!irqs_disabled());
> >-	if (blk_queue_plugged(q)) {
> >-		spin_lock(&blk_plug_lock);
> >-		list_del_init(&q->plug_list);
> >-		del_timer(&q->unplug_timer);
> >-		spin_unlock(&blk_plug_lock);
> >-		return 1;
> >-	}
> > 
> >-	return 0;
> >+	if (!test_and_clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
> >+		return 0;
> >+
> >+	del_timer(&q->unplug_timer);
> >+	return 1;
> > }
> > 
> > EXPORT_SYMBOL(blk_remove_plug);
> 
> I tend to like
> 
> 	if (test_and_clear_bit())
> 		call_out_of_line_function()
> 
> style for small functions like this, and inline those.

I like to do

	if (expected condition)
		do_stuff

	slow_path

-- 
Jens Axboe

