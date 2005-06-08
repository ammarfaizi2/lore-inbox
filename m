Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVFHRXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVFHRXP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVFHRXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:23:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55532 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261439AbVFHRT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:19:56 -0400
Date: Wed, 08 Jun 2005 13:19:41 -0400 (EDT)
Message-Id: <20050608.131941.41628326.k-ueda@ct.jp.nec.com>
To: linux-kernel@vger.kernel.org
Cc: j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com
Subject: [PATCH] __cfq_get_queue() fix for 2.6.12-rc5
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I resend this e-mail, as it may not be sent properly.
Please excuse me, if you receive same one.


I found a possible bug by which the first get_request() for a process
fails in cfq I/O scheduler.
If it's a bug, please consider to apply the patch for 2.6.12-rc5 below.


When cfq I/O scheduler is selected, get_request() in __make_request()
calls __cfq_get_queue().
__cfq_get_queue() finds an existing queue (struct cfq_queue) of the
current process for the device and returns it.  If it's not found,
__cfq_get_queue() creates and returns a new one if __cfq_get_queue()
is called with __GFP_WAIT flag, or __cfq_get_queue() returns NULL
(this means that get_request() fails) if no __GFP_WAIT flag.

On the other hand, in __make_request(), get_request() is called
without __GFP_WAIT flag at the first time.
Thus, the get_request() fails when there is no existing queue,
typically when it's called for the first I/O request of the process
to the device.

Though it will be followed by get_request_wait() for general case,
__make_request() will just end the I/O with an error (EWOULDBLOCK)
when the request was for read-ahead.

The patch for 2.6.12-rc5 is below:

Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

diff -rup linux-2.6.12-rc5/drivers/block/cfq-iosched.c cfq-fix/drivers/block/cfq-iosched.c
--- linux-2.6.12-rc5/drivers/block/cfq-iosched.c	2005-05-24 23:31:20.000000000 -0400
+++ cfq-fix/drivers/block/cfq-iosched.c	2005-06-06 14:20:49.000000000 -0400
@@ -1202,13 +1202,16 @@ retry:
 		if (new_cfqq) {
 			cfqq = new_cfqq;
 			new_cfqq = NULL;
-		} else if (gfp_mask & __GFP_WAIT) {
+		} else {
 			spin_unlock_irq(cfqd->queue->queue_lock);
 			new_cfqq = kmem_cache_alloc(cfq_pool, gfp_mask);
 			spin_lock_irq(cfqd->queue->queue_lock);
+
+			if (!new_cfqq && !(gfp_mask & __GFP_WAIT))
+				goto out;
+
 			goto retry;
-		} else
-			goto out;
+		}
 
 		memset(cfqq, 0, sizeof(*cfqq));
 
Best regards,
Kiyoshi Ueda

