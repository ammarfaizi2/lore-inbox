Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTKZHtt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 02:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTKZHtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 02:49:49 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:49352 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262522AbTKZHtq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 02:49:46 -0500
Date: Wed, 26 Nov 2003 13:25:13 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: [PATCH 2.6.0-test9-mm5] aio-dio-fallback-bio_count-race.patch
Message-ID: <20031126075513.GA3902@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20031112233002.436f5d0c.akpm@osdl.org> <1068761038.1805.35.camel@ibm-c.pdx.osdl.net> <20031117052518.GA11184@in.ibm.com> <1069118109.1842.31.camel@ibm-c.pdx.osdl.net> <1069119433.1842.43.camel@ibm-c.pdx.osdl.net> <20031118115520.GA4291@in.ibm.com> <1069199273.1906.14.camel@ibm-c.pdx.osdl.net> <20031124094249.GA11349@in.ibm.com> <1069804171.1841.23.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069804171.1841.23.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 03:49:31PM -0800, Daniel McNeil wrote:
> Suparna,
> 
> Yes your patch did help.  I originally had CONFIG_DEBUG_SLAB=y which
> was helping me see problems because the the freed dio was getting
> poisoned.  I also tested with CONFIG_DEBUG_PAGEALLOC=y which is
> very good at catching these.

Ah I see - perhaps that explains why neither Janet nor I could
recreate the problem that you were hitting so easily. So we 
should probably try running with CONFIG_DEBUG_SLAB and
CONFIG_DEBUG_PAGEALLOC as well.

> 
> I updated your AIO fallback patch plus your AIO race plus I fixed
> the bio_count decrement fix.  This patch has all three fixes and
> it is working for me.
> 
> I fixed the bio_count race, by changing bio_list_lock into bio_lock
> and using that for all the bio fields.  I changed bio_count and
> bios_in_flight from atomics into int.  They are now proctected by
> the bio_lock.  I fixed the race, by in finished_one_bio() by
> leaving the bio_count at 1 until after the dio_complete()
> and then do the bio_count decrement and wakeup holding the bio_lock.
> 
> Take a look, give it a try, and let me know what you think.

I had been trying a slightly different kind of fix -- appended is
the updated version of the patch I last posted. It uses the bio_list_lock
to protect the dio->waiter field, which finished_one_bio sets back
to NULL after it has issued the wakeup; and the code that waits for
i/o to drain out checks the dio->waiter field instead of bio_count.
This might not seem very obvious given the nomenclature of the 
bio_list_lock, so I was holding back wondering if it could be 
improved. 

Your approach looks clearer in that sense -- its pretty unambiguous
about what lock protects what fields. The only thing that bothers me (and
this is what I was trying to avoid in my patch) is the increased
use of spin_lock_irq 's (overhead of turning interrupts off and on)
instead of simple atomic inc/dec in most places.

Thoughts ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

------------------------------------

Don't access dio fields if its possible that the dio could
already have been freed asynchronously during i/o completion.
The dio->bio_list_lock protects the dio->waiter field as in
the case of synchronous i/o.

--- pure-mm3/fs/direct-io.c	2003-11-24 13:00:33.000000000 +0530
+++ linux-2.6.0-test9-mm3/fs/direct-io.c	2003-11-25 14:08:26.000000000 +0530
@@ -231,8 +231,17 @@
 				aio_complete(dio->iocb, dio->result, 0);
 				kfree(dio);
 			} else {
-				if (dio->waiter)
-					wake_up_process(dio->waiter);
+				struct task_struct *waiter;
+				unsigned long flags;
+
+				spin_lock_irqsave(&dio->bio_list_lock, flags);
+				waiter = dio->waiter;
+				if (waiter) {
+					dio->waiter = NULL;
+					wake_up_process(waiter);
+				}
+				spin_unlock_irqrestore(&dio->bio_list_lock, 
+					flags);
 			}
 		}
 	}
@@ -994,26 +1004,35 @@
 	 * reflect the number of to-be-processed BIOs.
 	 */
 	if (dio->is_async) {
-		if (ret == 0)
-			ret = dio->result;
-		if (ret > 0 && dio->result < dio->size && rw == WRITE) {
+		int should_wait = 0;
+
+		if (dio->result < dio->size && rw == WRITE) {
 			dio->waiter = current;
+			should_wait = 1;
 		}
+		if (ret == 0)
+			ret = dio->result;
 		finished_one_bio(dio);		/* This can free the dio */
 		blk_run_queues();
-		if (dio->waiter) {
+		if (should_wait) {
+			unsigned long flags;
 			/*
 			 * Wait for already issued I/O to drain out and
 			 * release its references to user-space pages
 			 * before returning to fallback on buffered I/O
 			 */
+			spin_lock_irqsave(&dio->bio_list_lock, flags);
 			set_current_state(TASK_UNINTERRUPTIBLE);
-			while (atomic_read(&dio->bio_count)) {
+			while (dio->waiter) {
+				spin_unlock_irqrestore(&dio->bio_list_lock, 
+				flags);
 				io_schedule();
 				set_current_state(TASK_UNINTERRUPTIBLE);
+				spin_lock_irqsave(&dio->bio_list_lock, flags);
 			}
 			set_current_state(TASK_RUNNING);
-			dio->waiter = NULL;
+			spin_unlock_irqrestore(&dio->bio_list_lock, flags);
+			kfree(dio);
 		}
 	} else {
 		finished_one_bio(dio);
