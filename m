Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263920AbTIIDln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 23:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263926AbTIIDln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 23:41:43 -0400
Received: from dyn-ctb-203-221-72-196.webone.com.au ([203.221.72.196]:25604
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263920AbTIIDlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 23:41:37 -0400
Message-ID: <3F5D4BC9.6020708@cyberone.com.au>
Date: Tue, 09 Sep 2003 13:40:57 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Olien <dmo@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Badness in as_completed_request warning
References: <20030908164802.GA13441@osdl.org>
In-Reply-To: <20030908164802.GA13441@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000503030400070006010708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000503030400070006010708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dave,
Can you try 2.6.0-test5 with the following patch please. Thanks


Dave Olien wrote:

>I'm getting a "badness" warning from as_iosched.c, line 917.
>This is on 2.6.0-test4-mm6, running on a 2 cpu x86.
>
>The warning occurs when I run three or more instances of mkfs.ext2, where
>each mkfs is running on its own disk.  If I run four or more mkfs's
>on paritions all on the same disk I don't get this warning.
>The more instances of mkfs I run (each on separate disks), the
>more instances of this warning I receive.
>
>The mkfs's all progress at the same rate. The warnings
>occur as all mkfs's are "writing superblocks and filesystem
>accounting information", near the end of the mkfs.
>
># Badness in as_completed_request at drivers/block/as-iosched.c:917
>
>Call Trace:
> [<c0220d0d>] as_completed_request+0x1ad/0x1b0
> [<c021946f>] elv_completed_request+0x1f/0x30
> [<c021b87c>] __blk_put_request+0x3c/0xc0
> [<c021c83f>] end_that_request_last+0x5f/0xf0
> [<c0234d02>] DAC960_V2_ProcessCompletedCommand+0x172/0xf50
> [<c029712a>] ip_rcv+0x39a/0x520
> [<c011ebf4>] recalc_task_prio+0xb4/0x1f0
> [<c011f64b>] load_balance+0x1bb/0x430
> [<c0235bfd>] DAC960_LP_InterruptHandler+0x6d/0xb0
> [<c010e789>] handle_IRQ_event+0x49/0x80
> [<c010eb00>] do_IRQ+0xa0/0x150
> [<c010abd0>] default_idle+0x0/0x40
> [<c02f2f8c>] common_interrupt+0x18/0x20
> [<c010abd0>] default_idle+0x0/0x40
> [<c010abfd>] default_idle+0x2d/0x40
> [<c010ac96>] cpu_idle+0x46/0x50
> [<c0107000>] rest_init+0x0/0x60
> [<c039092d>] start_kernel+0x18d/0x1c0
> [<c03904a0>] unknown_bootoption+0x0/0x120
>
>
>
>  
>

--------------000503030400070006010708
Content-Type: text/plain;
 name="as-warn-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="as-warn-fix.patch"

 linux-2.6-npiggin/drivers/block/as-iosched.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+)

diff -puN drivers/block/as-iosched.c~as-warn-fix drivers/block/as-iosched.c
--- linux-2.6/drivers/block/as-iosched.c~as-warn-fix	2003-09-09 13:01:04.000000000 +1000
+++ linux-2.6-npiggin/drivers/block/as-iosched.c	2003-09-09 13:21:12.000000000 +1000
@@ -381,8 +381,14 @@ static void as_add_arq_rb(struct as_data
 	arq->rb_key = rq_rb_key(rq);
 
 	/* This can be caused by direct IO */
+#if 0
 	while ((alias = __as_add_arq_rb(ad, arq)))
 		as_move_to_dispatch(ad, alias);
+#endif
+	if ((alias = __as_add_arq_rb(ad, arq))) {
+		list_add_tail(&arq->request->queuelist,
+				&alias->request->queuelist);
+	}
 
 	rb_insert_color(&arq->rb_node, ARQ_RB_ROOT(ad, arq));
 }
@@ -1131,7 +1137,24 @@ static void as_move_to_dispatch(struct a
 	 * take it off the sort and fifo list, add to dispatch queue
 	 */
 	as_remove_queued_request(ad->q, arq->request);
+
+	for (;;) {
+		struct list_head *alias = &arq->request->queuelist;
+
+		if (!list_empty(alias)) {
+			struct request *rq;
+			rq = list_entry_rq(alias->next);
+			list_del(&rq->queuelist);
+			list_add_tail(&rq->queuelist, ad->dispatch);
+
+			if (arq->io_context && arq->io_context->aic)
+				atomic_inc(&arq->io_context->aic->nr_dispatched);
+		} else
+			break;
+	}
+
 	list_add_tail(&arq->request->queuelist, ad->dispatch);
+
 	if (arq->io_context && arq->io_context->aic)
 		atomic_inc(&arq->io_context->aic->nr_dispatched);
 

_

--------------000503030400070006010708--

