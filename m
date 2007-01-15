Return-Path: <linux-kernel-owner+w=401wt.eu-S1751146AbXAOVvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbXAOVvV (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 16:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbXAOVvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 16:51:20 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:52442 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbXAOVvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 16:51:19 -0500
Date: Mon, 15 Jan 2007 15:51:17 -0600
To: Jens Axboe <axboe@suse.de>, Chris Wright <chrisw@sous-sol.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Nick Piggin <npiggin@suse.de>, Bino.Sebastian@Emulex.Com,
       James.Smart@Emulex.Com, rlary@us.ibm.com, Laurie.Barry@Emulex.Com,
       strosake@us.ibm.com, vaios.papadimitriou@Emulex.Com
Subject: [PATCH] adjust use of unplug in elevator code
Message-ID: <20070115215117.GD13157@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chris, Jens,
Can you look at this, and push upstream if this looks reasonable
to you? It fixes a bug I've been tripping over.

--linas


A flag was recently added to the elevator code to avoid
performing an unplug when reuests are being re-queued.
The goal of this flag was to avoid a deep recursion that
can occur when re-queueing requests after a SCSI device/host 
reset.  See http://lkml.org/lkml/2006/5/17/254

However, that fix added the flag near the bottom of a case
statement, where an earlier break (in an if statement) could
transport one out of the case, without setting the flag.
This patch sets the flag earlier in the case statement.

I re-discovered the deep recursion recently during testing;
I was told that it was a known problem, and the fix to it was
in the kernel I was testing. Indeed it was ... but it didn't
fix the bug. With the patch below, I no longer see the bug.

Signed-off by: Linas Vepstas <linas@austin.ibm.com>
Cc: Jens Axboe <axboe@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>

----
 block/elevator.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Index: linux-2.6.20-rc4/block/elevator.c
===================================================================
--- linux-2.6.20-rc4.orig/block/elevator.c	2007-01-15 14:16:03.000000000 -0600
+++ linux-2.6.20-rc4/block/elevator.c	2007-01-15 14:20:04.000000000 -0600
@@ -590,6 +590,12 @@ void elv_insert(request_queue_t *q, stru
 		 */
 		rq->cmd_flags |= REQ_SOFTBARRIER;
 
+		/*
+		 * Most requeues happen because of a busy condition,
+		 * don't force unplug of the queue for that case.
+		 */
+		unplug_it = 0;
+
 		if (q->ordseq == 0) {
 			list_add(&rq->queuelist, &q->queue_head);
 			break;
@@ -604,11 +610,6 @@ void elv_insert(request_queue_t *q, stru
 		}
 
 		list_add_tail(&rq->queuelist, pos);
-		/*
-		 * most requeues happen because of a busy condition, don't
-		 * force unplug of the queue for that case.
-		 */
-		unplug_it = 0;
 		break;
 
 	default:
