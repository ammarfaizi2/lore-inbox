Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbQLKKmJ>; Mon, 11 Dec 2000 05:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129638AbQLKKlt>; Mon, 11 Dec 2000 05:41:49 -0500
Received: from xerxes.thphy.uni-duesseldorf.de ([134.99.64.10]:39821 "EHLO
	xerxes.thphy.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id <S129511AbQLKKls>; Mon, 11 Dec 2000 05:41:48 -0500
Date: Mon, 11 Dec 2000 11:11:19 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] test12-pre8 task queue fix batch
In-Reply-To: <3A34249A.D832DE77@haque.net>
Message-ID: <Pine.LNX.4.10.10012111057390.27792-100000@chaos.thphy.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Dec 2000, Mohammad A. Haque wrote:

> More fixes. Ignore previous.

diff -urw linux-2.4.0-test12.old/drivers/atm/ambassador.c linux-2.4.0-test12/drivers/atm/ambassador.c
--- linux-2.4.0-test12.old/drivers/atm/ambassador.c	Fri Jul  7 00:37:24 2000
+++ linux-2.4.0-test12/drivers/atm/ambassador.c	Sun Dec 10 19:44:09 2000
@@ -2397,7 +2397,7 @@
       
 #ifdef FILL_RX_POOLS_IN_BH
       // initialise bottom half
-      dev->bh.next = 0;
+      INIT_LIST_HEAD(&dev->bh.list);
       dev->bh.sync = 0;
       dev->bh.routine = (void (*)(void *)) fill_rx_pools;
       dev->bh.data = dev;

> (and so on)



I don't think this is the right fix. First of all, if one needed to the
INIT_LIST_HEAD, some new macro should be introduced (INIT_TASK or
something), which takes care of the .list and .sync structures. So when
something was about to change again in the future, you wouldn't have to go
through all the files and fix them again.

But: The INIT_LIST_HEAD is unnecessary and misleading at least, because
tqueue->list is not a list head, it's there to allow for adding the struct
tqueue onto a task_queue. So we have the task_queue, that's the list head
- it needs to be initialized, and that's already done via
DECLARE_TASK_QUEUE. Then we have tasks to be added to the list (struct
tqueue), their .list members don't need to be initialized because they get
set when the task is queued on a task_queue (in queue_task).

So I think the correct fix is just to remove the offending lines.

--Kai


 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
