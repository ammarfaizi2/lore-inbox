Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbTDNKqw (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 06:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbTDNKqw (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 06:46:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61147 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262951AbTDNKqv (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 06:46:51 -0400
Date: Mon, 14 Apr 2003 12:58:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-pre7 ide request races
Message-ID: <20030414105833.GY9776@suse.de>
References: <20030414093418.GQ9776@suse.de> <20030414030751.7bf17b04.akpm@digeo.com> <20030414101747.GR9776@suse.de> <20030414032339.27079dd8.akpm@digeo.com> <20030414102723.GS9776@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030414102723.GS9776@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14 2003, Jens Axboe wrote:
> On Mon, Apr 14 2003, Andrew Morton wrote:
> > Jens Axboe <axboe@suse.de> wrote:
> > >
> > > How would that solve the problem? The request could be gone even before
> > > end_that_request_last() is run, that is the issue.
> > 
> > In that case I didn't understand your description of the bug even the tiniest
> > little bit.
> > 
> > That request is sitting in the kernel stack of some process which is sleeping
> > in wait_for_completion().  Hence it is safe memory until someone runs
> > complete() against the completion struct.
> 
> Sorry you are right, that should fix the problem as well! Your fix is
> probably the better one for 2.4, less intrusive. I'll kill the stack
> requests in 2.5 then.

Marcelo,

Please apply this simpler variant. Thanks!

--- /opt/kernel/linux-2.4.21-pre7/drivers/block/ll_rw_blk.c	2003-04-14 10:48:21.000000000 +0200
+++ drivers/block/ll_rw_blk.c	2003-04-14 12:53:03.000000000 +0200
@@ -1375,11 +1403,12 @@
 
 void end_that_request_last(struct request *req)
 {
-	if (req->waiting != NULL)
-		complete(req->waiting);
-	req_finished_io(req);
+	struct completion *waiting = req->waiting;
 
+	req_finished_io(req);
 	blkdev_release_request(req);
+	if (waiting)
+		complete(waiting);
 }
 
 int __init blk_dev_init(void)

-- 
Jens Axboe

