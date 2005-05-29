Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVE2Cyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVE2Cyh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 22:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVE2Cyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 22:54:37 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:10601 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261216AbVE2Cyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 22:54:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=L5/1rv5by9RXIft0cn+JIgRsrrKqM3GAz+s1b+c1wZP0MNYgH9AyqauT2WnGM0TSWmU90h2ZT8961tFAgGz3yUf4vQBSG+l1/NbBujOdYZJeN/kZh52tB75Kmgqk09f0mfECxrAeVf27SHf8KE/r1OHq+ebOP+H4MFB85d4RFO8=
Date: Sun, 29 May 2005 11:54:17 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc5-mm1] CFQ: fix stall on force dispatch
Message-ID: <20050529025416.GA11008@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Jens.
 Hello, Andrew.

 The cfq-cfq-elevator_insert_back-fix.patch contains a bug which is
triggered if force dispatching (back insertion) occurs when the active
cfqq is in idle slice while there exist other requests on other cfqqs.

 In this case, the idle slice timer is removed without invoking the
timer handler, so CFQ itself doesn't run the queue.  Also, as the
queue wasn't empty when the elv_add_request() is invoked, the blk
layer won't kick the queue on return.  This results in queue stall.

 This patch removes the stall by kicking the queue after force
dispatching.

 Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: blk-fixes/drivers/block/cfq-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/cfq-iosched.c	2005-05-29 11:29:51.000000000 +0900
+++ blk-fixes/drivers/block/cfq-iosched.c	2005-05-29 11:29:54.000000000 +0900
@@ -1705,6 +1705,14 @@ cfq_insert_request(request_queue_t *q, s
 			while (cfq_dispatch_requests(q, INT_MAX, 1))
 				;
 			list_add_tail(&rq->queuelist, &q->queue_head);
+			/*
+			 * If we were idling with pending requests on
+			 * inactive cfqqs, force dispatching will
+			 * remove the idle timer and the queue won't
+			 * be kicked by __make_request() afterward.
+			 * Kick it here.
+			 */
+			kblockd_schedule_work(&cfqd->unplug_work);
 			break;
 		case ELEVATOR_INSERT_FRONT:
 			list_add(&rq->queuelist, &q->queue_head);
