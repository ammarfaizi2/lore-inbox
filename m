Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264676AbTE1LFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 07:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbTE1LFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 07:05:20 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:34823 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264676AbTE1LFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 07:05:18 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrew Morton <akpm@digeo.com>, Jens Axboe <axboe@suse.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Wed, 28 May 2003 13:17:59 +0200
User-Agent: KMail/1.5.2
Cc: kernel@kolivas.org, matthias.mueller@rz.uni-karlsruhe.de,
       manish@storadinc.com, andrea@suse.de, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
References: <3ED2DE86.2070406@storadinc.com> <20030528105029.GS845@suse.de> <20030528035939.72a973b0.akpm@digeo.com>
In-Reply-To: <20030528035939.72a973b0.akpm@digeo.com>
MIME-Version: 1.0
Message-Id: <200305281305.44073.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nrJ1+OBUVsgVJg1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_nrJ1+OBUVsgVJg1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 28 May 2003 12:59, Andrew Morton wrote:

Hi Andrew,

> umm, I'd like confirmation of that.
>
> The waitqueue_active() test is wrong because of a missing barrier, but only
> on SMP.  And if it does make a mistake it will surely correct itself when
> the next request is put back. (That's why I left it there...)
> More testing, please.
Does the attached one make sense?

ciao, Marc



--Boundary-00=_nrJ1+OBUVsgVJg1
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="llrwblk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="llrwblk.patch"

--- old/drivers/block/ll_rw_blk.c	2003-05-14 23:11:08.000000000 +0200
+++ new/drivers/block/ll_rw_blk.c	2003-05-28 13:04:34.000000000 +0200
@@ -829,9 +829,10 @@ void blkdev_release_request(struct reque
 	 */
 	if (q) {
 		list_add(&req->queue, &q->rq[rw].free);
-		if (++q->rq[rw].count >= q->batch_requests &&
-				waitqueue_active(&q->wait_for_requests[rw]))
+		if (++q->rq[rw].count >= q->batch_requests) {
+			smp_mb();
 			wake_up(&q->wait_for_requests[rw]);
+		}
 	}
 }
 

--Boundary-00=_nrJ1+OBUVsgVJg1--

