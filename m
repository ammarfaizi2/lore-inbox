Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbTLaAog (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 19:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265904AbTLaAod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 19:44:33 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:19210 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S265879AbTLaAob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 19:44:31 -0500
Message-ID: <3FF21BE1.9070603@cs.wisc.edu>
Date: Tue, 30 Dec 2003 16:44:17 -0800
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Miquel van Smoorenburg <miquels@cistron.nl>, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>,
       Jens Axboe <axboe@suse.de>
Subject: Re: System hangs after echo value > /sys/block/dm-0/queue/nr_requests
References: <20031229130055.GA30647@cistron.nl> <20031230034239.27950054.akpm@osdl.org>
In-Reply-To: <20031230034239.27950054.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020807000803000903020304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020807000803000903020304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

> Where queue_requests_store() does wake_up(&rl->wait[READ]);
> 
> It looks like nobody has called blk_init_queue() for this queue and the
> waitqueue head is uninitialised.
> 

DM, MD, rd and loop use blk_alloc_queue and blk_queue_make_request to 
initialize their queue, because they only use the make_request_fn. The 
attached patch prevents the queue from being registered if only 
blk_alloc_queue was called.

Mike Christie

--------------020807000803000903020304
Content-Type: text/plain;
 name="queue_attr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="queue_attr.patch"

--- linux-2.6.0-orig/drivers/block/ll_rw_blk.c	2003-12-28 23:09:16.000000000 -0800
+++ linux-2.6.0/drivers/block/ll_rw_blk.c	2003-12-30 16:11:00.690504036 -0800
@@ -2902,7 +2902,7 @@ int blk_register_queue(struct gendisk *d
 
 	request_queue_t *q = disk->queue;
 
-	if (!q)
+	if (!q || !q->request_fn)
 		return -ENXIO;
 
 	q->kobj.parent = kobject_get(&disk->kobj);
@@ -2929,7 +2929,7 @@ void blk_unregister_queue(struct gendisk
 {
 	request_queue_t *q = disk->queue;
 
-	if (q) {
+	if (q && q->request_fn) {
 		elv_unregister_queue(q);
 
 		kobject_unregister(&q->kobj);

--------------020807000803000903020304--

