Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129502AbRBVN5W>; Thu, 22 Feb 2001 08:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129608AbRBVN5N>; Thu, 22 Feb 2001 08:57:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18445 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129502AbRBVN44>;
	Thu, 22 Feb 2001 08:56:56 -0500
Date: Thu, 22 Feb 2001 14:56:42 +0100
From: Jens Axboe <axboe@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: ll_rw_block/submit_bh and request limits
Message-ID: <20010222145642.D17276@suse.de>
In-Reply-To: <Pine.LNX.4.21.0102220707380.1694-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0102220707380.1694-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, Feb 22, 2001 at 07:41:52AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22 2001, Marcelo Tosatti wrote:
> The following piece of code in ll_rw_block() aims to limit the number of
> locked buffers by making processes throttle on IO if the number of on
> flight requests is bigger than a high watermaker. IO will only start
> again if we're under a low watermark.
> 
>                 if (atomic_read(&queued_sectors) >= high_queued_sectors) {
>                         run_task_queue(&tq_disk);
>                         wait_event(blk_buffers_wait,
>                         	atomic_read(&queued_sectors) < low_queued_sectors);
>                 }
> 
> 
> However, if submit_bh() is used to queue IO (which is used by ->readpage()
> for ext2, for example), no throttling happens.
> 
> It looks like ll_rw_block() users (writes, metadata reads) can be starved
> by submit_bh() (data reads). 
> 
> If I'm not missing something, the watermark check should be moved to
> submit_bh(). 

We might as well put it there, the idea was to not lock this one
buffer either but I doubt this would make any different in reality :-)

Linus, could you apply?

--- /opt/kernel/linux-2.4.2/drivers/block/ll_rw_blk.c	Thu Feb 22 14:55:22 2001
+++ drivers/block/ll_rw_blk.c	Thu Feb 22 14:53:07 2001
@@ -957,6 +959,20 @@
 	if (!test_bit(BH_Lock, &bh->b_state))
 		BUG();
 
+	/*
+	 * don't lock any more buffers if we are above the high
+	 * water mark. instead start I/O on the queued stuff.
+	 */
+	if (atomic_read(&queued_sectors) >= high_queued_sectors) {
+		run_task_queue(&tq_disk);
+		if (rw == READA) {
+			bh->b_end_io(bh, test_bit(BH_Uptodate, &bh->b_state));
+			return;
+		}
+		wait_event(blk_buffers_wait,
+			atomic_read(&queued_sectors) < low_queued_sectors);
+	}
+
 	set_bit(BH_Req, &bh->b_state);
 
 	/*
@@ -1057,16 +1073,6 @@
 
 	for (i = 0; i < nr; i++) {
 		struct buffer_head *bh = bhs[i];
-
-		/*
-		 * don't lock any more buffers if we are above the high
-		 * water mark. instead start I/O on the queued stuff.
-		 */
-		if (atomic_read(&queued_sectors) >= high_queued_sectors) {
-			run_task_queue(&tq_disk);
-			wait_event(blk_buffers_wait,
-			 atomic_read(&queued_sectors) < low_queued_sectors);
-		}
 
 		/* Only one thread can actually submit the I/O. */
 		if (test_and_set_bit(BH_Lock, &bh->b_state))

-- 
Jens Axboe

