Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129886AbRBTWmU>; Tue, 20 Feb 2001 17:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129873AbRBTWmK>; Tue, 20 Feb 2001 17:42:10 -0500
Received: from oboe.it.uc3m.es ([163.117.139.101]:26385 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S129294AbRBTWl6>;
	Tue, 20 Feb 2001 17:41:58 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200102202241.f1KMftG31691@oboe.it.uc3m.es>
Subject: plugging in 2.4. Does it work?
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Tue, 20 Feb 2001 23:41:55 +0100 (MET)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More like "how does one get it to work".

Does anyone have a simple recipe for doing plugging right in 2.4?
I'm doing something wrong.

When I disable plugging on my block driver (by registering a no-op
plugging function), the driver works fine.  In particular my end_request
code works fine - it does an if end_that_request_first return;
end_that_request_last on the request to murder. Here it is

 int my_end_request(struct request *req) {
   unsigned long flags; int dequeue = 0;
   spin_lock_irqsave(&io_request_lock, flags);
   if (!req->errors) {
     while (req->nr_sectors > 0) {
       printk( KERN_DEBUG "running end_first on req with %d sectors\n",
              req->nr_sectors);
       if (!end_that_request_first (req, !req->errors, DEVICE_NAME))
         break;
     }
   }
   printk( KERN_DEBUG "running end_first on req with %d sectors\n",
            req->nr_sectors);
   if (!end_that_request_first (req, !req->errors, DEVICE_NAME)) {
     printk( KERN_DEBUG "running end_last on req with %d sectors\n",
              req->nr_sectors);
     end_that_request_last(req);
     dequeue = 1;
   }
   spin_unlock_irqrestore(&io_request_lock, flags);
   return dequeue;
 }

When I allow the kernel to use its default plugging function and
enable read-ahead of 20, I see read requests being aggregated
10-in-one with 1K blocks, but the userspace request hangs, or
the calling process dies! Or worse. Sometimes I get some
recordable logs .. and they show nothing wrong:

Feb 20 10:46:42 barney kernel: running end_first on req with 20 sectors
Feb 20 10:46:42 barney kernel: running end_first on req with 18 sectors
Feb 20 10:46:42 barney kernel: running end_first on req with 16 sectors
Feb 20 10:46:42 barney kernel: running end_first on req with 14 sectors
Feb 20 10:46:42 barney kernel: running end_first on req with 12 sectors
Feb 20 10:46:42 barney kernel: running end_first on req with 10 sectors
Feb 20 10:46:42 barney kernel: running end_first on req with 8 sectors
Feb 20 10:46:42 barney kernel: running end_first on req with 6 sectors
Feb 20 10:46:42 barney kernel: running end_first on req with 4 sectors
Feb 20 10:46:42 barney kernel: running end_first on req with 2 sectors
Feb 20 10:46:42 barney kernel: running end_first on req with 2 sectors
Feb 20 10:46:42 barney kernel: running end_last on req with 2 sectors
Feb 20 10:52:47 barney kernel: running end_first on req with 2 sectors
Feb 20 10:52:47 barney kernel: running end_first on req with 2 sectors
Feb 20 10:52:47 barney kernel: running end_last on req with 2 sectors

But death follows soomer rather than later.

I've discovered that

1) setting read-ahead to 0 disables request agregation by some means of
which I am not aware, and everything goes hunky dory.

2) setting read-ahead to 4 or 8 seems to be safe. I see 4K requests
being formed and treated OK.

3) disabling plugging stops request aggretaion and makes everything
safe.

Any clues? Is the trick just "powers of 2"? how is one supposed to
handle plugging? Where is the canonical example. I can't see any driver
that does it.

Peter

