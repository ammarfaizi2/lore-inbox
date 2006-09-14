Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWINO61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWINO61 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWINO61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:58:27 -0400
Received: from mailgw.informatik.uni-stuttgart.de ([129.69.211.42]:14788 "EHLO
	mx3.informatik.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id S1750703AbWINO60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:58:26 -0400
Date: Thu, 14 Sep 2006 16:58:24 +0200 (CEST)
From: Steffen Maier <smaier@users.sourceforge.net>
X-X-Sender: maiersn@nettc.informatik.uni-stuttgart.de
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org, "Marcelo W. Tosatti" <marcelo@kvack.org>,
       Rick Lindsley <ricklind@us.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Chad Talbott <ctalbott@google.com>,
       Jochen Suckfuell <jo-lkml@suckfuell.net>,
       Zlatko Calusic <zlatko.calusic@iskon.hr>
Subject: [PATCH 2.4.33.3] block: fix negative bias of ios_in_flight
 (CONFIG_BLK_STATS) because of unbalanced I/O accounting
In-Reply-To: <20060818081524.GG798@suse.de>
Message-ID: <Pine.LNX.4.64.0609131626330.14525@nettc.informatik.uni-stuttgart.de>
References: <Pine.LNX.4.64.0608171924570.16659@nettc.informatik.uni-stuttgart.de>
 <20060818081524.GG798@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for unbalanced I/O accounting, that caused ios_in_flight 
(CONFIG_BLK_STATS) to become and stay negative, as suggested by Jens 
Axboe.

An added boolean field "io_account" in struct request is assumed to be 
initialized to false on new requests. On starting I/O accounting, true is 
assigned to the field. On ending I/O accounting, accounting is only 
executed if the field has already been assigned true previously. Thus, 
this fixes unbalanced cases where requests such as non-data get enqueued 
without starting to account (ide_do_drive_cmd?) but the end of accounting 
gets executed on finishing the same requests (ide_end_drive_cmd, 
end_that_request_last, req_finished_io).

The precondition of io_account being initialized to false is ensured by

1) ide_init_drive_taskfile / ide_init_drive_cmd memset'ing the whole 
request to zero, for requests that were potentially accounted unbalanced, 
and

2) get_request assigning zero to io_account on allocating a request from 
the free list cache (or slab cache initially), for the majority of 
requests such as those involving data.

Jens preferred this to other discussed solutions and it should fix all 
those unbalanced cases at once without touching each of them individually.

For more details, please see previous posts of this thread 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0608.2/0776.html.

I tested the patch with 2.4.24 and 2.4.33.3 successfully on an UP ia32 
machine with one /dev/hda.

Signed-off-by: Steffen Maier <smaier@users.sourceforge.net>
---

  drivers/block/ll_rw_blk.c  |    6 ++++++
  include/linux/blkdev.h     |    1 +
  3 files changed, 7 insertions(+)

diff -urp linux-2.4.33.3/drivers/block/ll_rw_blk.c linux-2.4.33.3.blkstatfix/drivers/block/ll_rw_blk.c
--- linux-2.4.33.3/drivers/block/ll_rw_blk.c	2006-08-31 19:03:20.000000000 +0200
+++ linux-2.4.33.3.blkstatfix/drivers/block/ll_rw_blk.c	2006-09-13 16:17:24.000000000 +0200
@@ -575,6 +575,7 @@ static struct request *get_request(reque
  		rq->rq_status = RQ_ACTIVE;
  		rq->cmd = rw;
  		rq->special = NULL;
+		rq->io_account = 0;
  		rq->q = q;
  	}

@@ -813,6 +814,7 @@ void req_new_io(struct request *req, int
  	struct hd_struct *hd1, *hd2;

  	locate_hd_struct(req, &hd1, &hd2);
+	req->io_account = 1;
  	if (hd1)
  		account_io_start(hd1, req, merge, sectors);
  	if (hd2)
@@ -823,6 +825,8 @@ void req_merged_io(struct request *req)
  {
  	struct hd_struct *hd1, *hd2;

+	if (unlikely(req->io_account == 0))
+		return;
  	locate_hd_struct(req, &hd1, &hd2);
  	if (hd1)
  		down_ios(hd1);
@@ -834,6 +838,8 @@ void req_finished_io(struct request *req
  {
  	struct hd_struct *hd1, *hd2;

+	if (unlikely(req->io_account == 0))
+		return;
  	locate_hd_struct(req, &hd1, &hd2);
  	if (hd1)
  		account_io_end(hd1, req);
diff -urp linux-2.4.33.3/include/linux/blkdev.h linux-2.4.33.3.blkstatfix/include/linux/blkdev.h
--- linux-2.4.33.3/include/linux/blkdev.h	2006-08-31 19:03:20.000000000 +0200
+++ linux-2.4.33.3.blkstatfix/include/linux/blkdev.h	2006-09-13 16:10:50.000000000 +0200
@@ -46,6 +46,7 @@ struct request {
  	struct buffer_head * bh;
  	struct buffer_head * bhtail;
  	request_queue_t *q;
+	char io_account;
  };

  #include <linux/elevator.h>
