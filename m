Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269629AbUJLLQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269629AbUJLLQZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 07:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269631AbUJLLQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 07:16:25 -0400
Received: from eik.ii.uib.no ([129.177.16.3]:40885 "EHLO eik.ii.uib.no")
	by vger.kernel.org with ESMTP id S269629AbUJLLQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 07:16:21 -0400
Subject: CFQ v2 high cpu load fix(?)
From: "Ronny V. Vindenes" <s864@ii.uib.no>
To: Jens Axboe <axboe@suse.de>
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-xhaY6LX5/R4C9jYytKBN"
Date: Tue, 12 Oct 2004 13:16:00 +0200
Message-Id: <1097579760.4086.27.camel@tentacle125.gozu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 (2.0.1-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xhaY6LX5/R4C9jYytKBN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

CFQ v2 is much better in a lot of cases, but certain situations trigger
a cpu load so high it starves the rest of the system thus completely
ruining the interactive experience. While casually looking at the
problem, I stumbled upon a patch by Arjan van de Ven sent to lkml on
sept. 1 (Subject: block fixes). Part of it is already included in the
CFQ v2 patches and after applying the rest[1] I'm no longer able to
trigger the problem.

[1] Patch attached against 2.6.9-rc4-ck1 but applies to rc4-mm1 with
some minor fuzz.

-- 
Ronny V. Vindenes <s864@ii.uib.no>

--=-xhaY6LX5/R4C9jYytKBN
Content-Disposition: attachment; filename=block-fix.patch
Content-Type: text/x-patch; name=block-fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- patches/linux-2.6.9-rc4-ck1/drivers/block/ll_rw_blk.c	2004-10-12 12:25:09.798003278 +0200
+++ linux-2.6.9-rc4-ck1/drivers/block/ll_rw_blk.c	2004-10-12 12:25:42.959479479 +0200
@@ -100,7 +100,7 @@
 		nr = q->nr_requests;
 	q->nr_congestion_on = nr;
 
-	nr = q->nr_requests - (q->nr_requests / 8) - 1;
+	nr = q->nr_requests - (q->nr_requests / 8) - (q->nr_requests/16)- 1;
 	if (nr < 1)
 		nr = 1;
 	q->nr_congestion_off = nr;
@@ -1758,8 +1758,10 @@
 {
 	DEFINE_WAIT(wait);
 	struct request *rq;
+	struct io_context *ioc;
 
 	generic_unplug_device(q);
+	ioc = get_io_context(GFP_NOIO);
 	do {
 		struct request_list *rl = &q->rq;
 
@@ -1769,7 +1771,6 @@
 		rq = get_request(q, rw, GFP_NOIO);
 
 		if (!rq) {
-			struct io_context *ioc;
 
 			io_schedule();
 
@@ -1779,12 +1780,11 @@
 			 * up to a big batch of them for a small period time.
 			 * See ioc_batching, ioc_set_batching
 			 */
-			ioc = get_io_context(GFP_NOIO);
 			ioc_set_batching(q, ioc);
-			put_io_context(ioc);
 		}
 		finish_wait(&rl->wait[rw], &wait);
 	} while (!rq);
+	put_io_context(ioc);
 
 	return rq;
 }

--=-xhaY6LX5/R4C9jYytKBN--

