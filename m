Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271255AbTHHGax (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 02:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271262AbTHHGax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 02:30:53 -0400
Received: from dm5-233.slc.aros.net ([66.219.220.233]:30127 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S271255AbTHHGau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 02:30:50 -0400
Message-ID: <3F334396.7030008@aros.net>
Date: Fri, 08 Aug 2003 00:30:46 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Clements <Paul.Clements@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0 NBD driver: remove send/recieve race for request
References: <3F2FE078.6020305@aros.net> <3F300760.8F703814@SteelEye.com> <3F303430.1080908@aros.net> <3F30510A.E918924B@SteelEye.com> <3F30AF81.4070308@aros.net> <3F332ED7.712DFE5D@SteelEye.com>
In-Reply-To: <3F332ED7.712DFE5D@SteelEye.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Clements wrote:

>. . .
>Here's the patch to fix up several race conditions in nbd. It requires
>reverting the already included (but admittedly incomplete)
>nbd-race-fix.patch that's in -mm5.
>
>Andrew, please apply.
>
>Thanks,
>Paul
>
>------------------------------------------------------------------------
>
>--- linux-2.6.0-test2-mm4-PRISTINE/drivers/block/nbd.c	Sun Jul 27 12:58:51 2003
>+++ linux-2.6.0-test2-mm4/drivers/block/nbd.c	Thu Aug  7 18:02:23 2003
>@@ -416,11 +416,19 @@ void nbd_clear_que(struct nbd_device *lo
> 	BUG_ON(lo->magic != LO_MAGIC);
> #endif
> 
>+retry:
> 	do {
> 		req = NULL;
> 		spin_lock(&lo->queue_lock);
> 		if (!list_empty(&lo->queue_head)) {
> 			req = list_entry(lo->queue_head.next, struct request, queuelist);
>+			if (req->ref_count > 1) { /* still in xmit */
>+				spin_unlock(&lo->queue_lock);
>+				printk(KERN_DEBUG "%s: request %p: still in use (%d), waiting...\n",
>+				    lo->disk->disk_name, req, req->ref_count);
>+				schedule_timeout(HZ); /* wait a second */
>
Isn't there something more deterministic than just waiting a second and 
hoping things clear up that you can use here? How about not clearing the 
queue unless lo->sock is NULL and using whatever lock it is now that's 
protecting lo->sock. That way the queue clearing race can be eliminated too.

>+				goto retry;
>+			}
> 			list_del_init(&req->queuelist);
> 		}
> 		spin_unlock(&lo->queue_lock);
>@@ -490,6 +498,7 @@ static void do_nbd_request(request_queue
> 		}
> 
> 		list_add(&req->queuelist, &lo->queue_head);
>+		req->ref_count++; /* make sure req does not get freed */
> 		spin_unlock(&lo->queue_lock);
> 
> 		nbd_send_req(lo, req);
>@@ -499,12 +508,14 @@ static void do_nbd_request(request_queue
> 					lo->disk->disk_name);
> 			spin_lock(&lo->queue_lock);
> 			list_del_init(&req->queuelist);
>+			req->ref_count--;
> 			spin_unlock(&lo->queue_lock);
> 			nbd_end_request(req);
> 			spin_lock_irq(q->queue_lock);
> 			continue;
> 		}
> 
>+		req->ref_count--;
> 		spin_lock_irq(q->queue_lock);
>
Since ref_count isn't atomic, shouldn't ref_count only be changed while 
the queue_lock is held???


