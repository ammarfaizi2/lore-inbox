Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbTJTTh3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 15:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbTJTTh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 15:37:29 -0400
Received: from smtp7.hy.skanova.net ([195.67.199.140]:49120 "EHLO
	smtp7.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262777AbTJTTh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 15:37:27 -0400
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8, DEBUG_SLAB, oops in as_latter_request()
References: <m2ismlovep.fsf@p4.localdomain>
	<20031019142042.2f41eb68.akpm@osdl.org>
	<3F932B81.2040202@cyberone.com.au>
From: Peter Osterlund <petero2@telia.com>
Date: 20 Oct 2003 21:37:03 +0200
In-Reply-To: <3F932B81.2040202@cyberone.com.au>
Message-ID: <m27k2zpuow.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> writes:

> Andrew Morton wrote:
> 
> >Peter Osterlund <petero2@telia.com> wrote:
> >
> >>I was running 2.6.0-test8 compiled with CONFIG_DEBUG_SLAB=y. When
> >> testing the CDRW packet writing driver, I got an oops in
> >> as_latter_request. (Full oops at the end of this message.) It is
> >> repeatable and happens because arq->rb_node.rb_right is uninitialized.
> >>
> >
> >deadline seems to have the same problem.
> >
> >We may as well squish this with the big hammer?
> >
> 
> Thanks for the report, Peter.
> 
> The request is a special request, so either blk_attempt_remerge should
> never be called on it, or blk_attempt_remerge (or as_latter_request) should
> check for this. Its up to Jens.

I don't think it is a special request. I added this debug hack:

--- linux/drivers/block/as-iosched.c~   2003-10-19 20:33:45.000000000 +0200
+++ linux/drivers/block/as-iosched.c    2003-10-20 21:14:20.000000000 +0200
@@ -1501,9 +1501,18 @@
 static struct request *
 as_latter_request(request_queue_t *q, struct request *rq)
 {
-       struct as_rq *arq = RQ_DATA(rq);
-       struct rb_node *rbnext = rb_next(&arq->rb_node);
-       struct request *ret = NULL;
+       struct as_rq *arq;
+       struct rb_node *rbnext;
+       struct request *ret;
+
+       arq = RQ_DATA(rq);
+       if (arq->rb_node.rb_right == (void*)0x5a5a5a5a) {
+               printk("flags:%lx sector:%ld cmd:%02x %02x %02x %02x\n",
+                      rq->flags, rq->sector,
+                      rq->cmd[0], rq->cmd[1], rq->cmd[2], rq->cmd[3]);
+       }
+       rbnext = rb_next(&arq->rb_node);
+       ret = NULL;
 
        if (rbnext)
                ret = rb_entry_arq(rbnext)->request;

The result was:

        flags:50 sector:186920 cmd:28 00 00 00
        Unable to handle kernel paging request at virtual address 5a5a5a66
         printing eip:
        ...

Note that:

        0x50 == REQ_CMD | REQ_STARTED
        0x28 == GPCMD_READ_10

So this looks like a regular read request to me. I'm not sure if this
means that something else is wrong.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
