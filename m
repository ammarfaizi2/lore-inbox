Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBHLWA>; Thu, 8 Feb 2001 06:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbRBHLVu>; Thu, 8 Feb 2001 06:21:50 -0500
Received: from Cantor.suse.de ([213.95.15.193]:50958 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129031AbRBHLVn>;
	Thu, 8 Feb 2001 06:21:43 -0500
Date: Thu, 8 Feb 2001 12:21:28 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ben LaHaise <bcrl@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010208122128.A12921@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.30.0102061225330.15204-100000@today.toronto.redhat.com> <Pine.LNX.4.10.10102060959520.1257-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10102060959520.1257-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Feb 06, 2001 at 10:14:21AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2001 at 10:14:21AM -0800, Linus Torvalds wrote:
> I will claim that you CANNOT merge at higher levels and get good
> performance.
> 
> Sure, you can do read-ahead, and try to get big merges that way at a high
> level. Good for you.
> 
> But you'll have a bitch of a time trying to merge multiple
> threads/processes reading from the same area on disk at roughly the same
> time. Your higher levels won't even _know_ that there is merging to be
> done until the IO requests hit the wall in waiting for the disk.

Hi,

I've tried to experimentally check this statement.

I instrumented a kernel with the following patch. It keeps a counter
for every merge between unrelated requests. An unrelated requests
is defined as the requests getting allocated from different currents.
I did various tests and suprisingly I was not able to trigger a 
single unrelated merge on my IDE system with various IO loads (dbench,
news expire, news sort, kernel compile, swapping ...) 

So either my patch is wrong (if yes, what is wrong?), or they do simply not 
happen in usual IO loads. I know that it has a few holes (like it doesn't 
count unrelated merges that happen from the same process, or if a process 
quits and another one gets its kernel stack and IO of both is merged it'll 
be counted as related merge), but if unrelated merges were relevant there 
should still show up more, no? 

My pet theory is that page and buffer cache filters most unrelated merges
out. I haven't tried to use raw IO to avoid this problem, but I expect that
anything that does raw IO will do some intelligent IO scheduling on its
own anyways.

If anyone is interested: it would be interesting if other people are 
able to trigger unrelated merges in real loads.
Here is a patch. Display statistics using:

(echo print unrelated_merge ; print related_merge ) | gdb vmlinux /proc/kcore


--- linux/drivers/block/ll_rw_blk.c-REQSTAT	Tue Jan 30 13:33:25 2001
+++ linux/drivers/block/ll_rw_blk.c	Thu Feb  8 01:13:57 2001
@@ -31,6 +31,9 @@
 
 #include <linux/module.h>
 
+int unrelated_merge; 
+int related_merge;
+
 /*
  * MAC Floppy IWM hooks
  */
@@ -478,6 +481,7 @@
 		rq->rq_status = RQ_ACTIVE;
 		rq->special = NULL;
 		rq->q = q;
+		rq->originator = current;
 	}
 
 	return rq;
@@ -668,6 +672,11 @@
 	if (!q->merge_requests_fn(q, req, next, max_segments))
 		return;
 
+	if (next->originator != req->originator)
+		unrelated_merge++; 
+	else
+		related_merge++; 
+
 	q->elevator.elevator_merge_req_fn(req, next);
 	req->bhtail->b_reqnext = next->bh;
 	req->bhtail = next->bhtail;
--- linux/include/linux/blkdev.h-REQSTAT	Tue Jan 30 17:17:01 2001
+++ linux/include/linux/blkdev.h	Wed Feb  7 23:33:35 2001
@@ -45,6 +45,8 @@
 	struct buffer_head * bh;
 	struct buffer_head * bhtail;
 	request_queue_t *q;
+
+	struct task_struct *originator;
 };
 
 #include <linux/elevator.h>




-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
