Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289290AbSAPB4t>; Tue, 15 Jan 2002 20:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289806AbSAPB4j>; Tue, 15 Jan 2002 20:56:39 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:10001 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289290AbSAPB4a>; Tue, 15 Jan 2002 20:56:30 -0500
Message-ID: <3C44DC7B.D960D15D@zip.com.au>
Date: Tue, 15 Jan 2002 17:50:51 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: block completion races
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

void end_that_request_last(struct request *req)
{
        if (req->waiting != NULL)
                complete(req->waiting);

        blkdev_release_request(req);
}


I think a bug.  Sometimes (eg, cdrom_queue_packet_command())
the request is allocated on a task's kernel stack.  As soon as
we call complete(), that task can wake and release the request
while blkdev_release_request() is diddling it on this CPU.

Do you see any problem with releasing the request before running
complete()?.  Also I think it's best to uninline blkdev_release_request().
It's 104 bytes long, and we have four copies of it in ll_rw_blk.c.  A
patch is here.

Also, there is this code in ide_do_drive_cmd():

        if (action == ide_wait) {
                wait_for_completion(&wait);     /* wait for it to be serviced */
                return rq->errors ? -EIO : 0;   /* return -EIO if errors */
        }

Is it safe to use `rq' here?  It has just been recycled in
end_that_request_last() and we don't own it any more.

I think the simplest approach to this one is to make the error
code a part of the completion structure, so:

struct blkdev_completion {
	struct completion completion;
	int errcode;
};

If you agree, I'll do the patch.



--- linux-2.4.18-pre4/drivers/block/ll_rw_blk.c	Tue Jan 15 15:08:24 2002
+++ linux-akpm/drivers/block/ll_rw_blk.c	Tue Jan 15 17:39:22 2002
@@ -546,7 +546,7 @@ static inline void add_request(request_q
 /*
  * Must be called with io_request_lock held and interrupts disabled
  */
-inline void blkdev_release_request(struct request *req)
+void blkdev_release_request(struct request *req)
 {
 	request_queue_t *q = req->q;
 	int rw = req->cmd;
@@ -1084,10 +1084,11 @@ int end_that_request_first (struct reque
 
 void end_that_request_last(struct request *req)
 {
-	if (req->waiting != NULL)
-		complete(req->waiting);
+	struct completion *waiting = req->waiting;
 
 	blkdev_release_request(req);
+	if (waiting != NULL)
+		complete(waiting);
 }
 
 #define MB(kb)	((kb) << 10)
