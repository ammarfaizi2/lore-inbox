Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131531AbQK2Oxz>; Wed, 29 Nov 2000 09:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131546AbQK2Oxq>; Wed, 29 Nov 2000 09:53:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16146 "EHLO virtualhost.dk")
        by vger.kernel.org with ESMTP id <S131531AbQK2Oxi>;
        Wed, 29 Nov 2000 09:53:38 -0500
Date: Wed, 29 Nov 2000 15:23:08 +0100
From: Jens Axboe <axboe@suse.de>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: plug problem in linux-2.4.0-test11
Message-ID: <20001129152308.A28399@suse.de>
In-Reply-To: <C12569A6.00425037.00@d12mta07.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C12569A6.00425037.00@d12mta07.de.ibm.com>; from schwidefsky@de.ibm.com on Wed, Nov 29, 2000 at 12:56:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29 2000, schwidefsky@de.ibm.com wrote:
> request queue to put them on its internal queue. You could argue
> that it shouldn't dequeue request if q->plugged == 1. On the other
> hand why not, before the disk has nothing to do. Anyway the result

I agree with your reasoning, even if the s390 behaviour is a bit
"non-standard" wrt block devices. Linus, could you apply?

--- drivers/block/ll_rw_blk.c~	Wed Nov 29 15:17:33 2000
+++ drivers/block/ll_rw_blk.c	Wed Nov 29 15:18:43 2000
@@ -347,10 +347,9 @@
  */
 static inline void __generic_unplug_device(request_queue_t *q)
 {
-	if (!list_empty(&q->queue_head)) {
-		q->plugged = 0;
+	q->plugged = 0;
+	if (!list_empty(&q->queue_head))
 		q->request_fn(q);
-	}
 }
 
 static void generic_unplug_device(void *data)

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
