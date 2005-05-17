Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVEQHmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVEQHmX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 03:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVEQHmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 03:42:23 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:38269 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261314AbVEQHhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 03:37:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=p3ahTJjrQNovxDWnhY9oVX05OgD4bdl/N1EjQuHpWCjwmtBQ6HMqV0509UsgNY6ugrGSKLxBdQd1M3QpXKOXc4tJAmm5/DgQf2SFythw2TWxMmAI3tnRp2nCOJN073LwnXx5Hten3QGo2PpziwCrsrfBtwyqY6HVFc1t10cXAFA=
Date: Tue, 17 May 2005 16:37:22 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] block: cfq_dispatch_sort() fixes
Message-ID: <20050517073722.GA16135@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Jens.

 cfq_dispatch_sort() has several problems.  Fixes are trivial and
attached at the end of this mail.

### 1. With the original code, all requests are queued in FIFO order.

 This is caused by updating last_sector in the wrong places.  Please
take a look at the following debug trace.

 The format is "(+|-)[order]block:length" where +/- indicates whether
the request has upper or lower block number compared to the previous
one.  This trace is generated on the completion of
cfq_dispatch_requests().  The result is obtained by running a test
program which has four processes, each of which has ten threads
performing random raw read of 4 blocks.  So, 40 concurrent requests in
4 cfqq's.

DISPATCH sda: +[00]059116623:004 -[01]039648839:004 -[02]007833582:004 +[03]060350240:004 +[04]215373315:004 -[05]044184567:004 -[06]009456539:004
DISPATCH sda: +[00]060539628:004 +[01]066077479:004 -[02]012627473:004 +[03]106674337:004 -[04]022983177:004 +[05]074006895:004 -[06]045607337:004
DISPATCH sda: +[00]110726742:004 -[01]103325223:004 +[02]119208356:004 -[03]116358882:004 +[04]119190932:004 -[05]077346261:004 +[06]120839022:004
DISPATCH sda: +[00]187842057:004 -[01]135154498:004 -[02]096487330:004 +[03]188230022:004 -[04]124680124:004 +[05]138886298:004 -[06]103080140:004
DISPATCH sda: +[00]121458771:004 +[01]134742478:004 +[02]163776853:004 -[03]127477053:004 +[04]138532150:004 -[05]110032967:004 +[06]231990296:004
DISPATCH sda: +[00]156552771:004 -[01]030098360:004 -[02]007061231:004 +[03]162105055:004 -[04]017096174:004 +[05]037192069:004 -[06]019481170:004
DISPATCH sda: +[00]028915348:004 +[01]033111988:004 +[02]116453522:004 -[03]023882723:004 +[04]084965610:004 -[05]039899969:004 +[06]133965105:004
DISPATCH sda: +[00]056256206:004 +[01]170879973:004 -[02]043575907:004 +[03]070010343:004 +[04]139208242:004 +[05]179159843:004 -[06]048055275:004
DISPATCH sda: +[00]110933844:004 +[01]186681332:004 -[02]167009270:004 -[03]119584357:004 -[04]074829432:004 +[05]196270326:004 -[06]174107431:004

 As you can see, no sorting occurs and the disk will seek like crazy.
This won't happen if there's only one active cfq as in such cases,
dispatch queue receives requests in order.  But w/ more than two
cfqq's, each stream is received in order but sorting doesn't occur
among them.


### 2. When sorting, last_sector boundary isn't used as much as it
       should be.

 Let's assume last_sector=5 and the following sequence enters the
queue.
 7 2 9 6 3
 Then, the original code sorts like the following.
 7 2 3 6 9, last_sector=2
 But, it should be
 6 7 9 2 3, last_sector=3


### 3. With sorting fixed, backward seeking optimization becomes bogus.

 Each cfqq allows backward seeking upto cfq_back_max KiB, but when
sorting, this isn't considered.  So, the backward seeking request
which is supposed to come at the front goes to the back, incurring
long seek.


### Benchmark

 Here are benchmark results.  Each process issues 10 random raw
requests concurrently and there are four of them.  They run for 3
minutes and the total number of requests processed is printed.  Each
version is tested for three times and average total is calculated.
The percentage following the average is to show the amount of
improvement over the original version (so, the original version is
100%).

 The test is extereme and exaggerate the effect of dispatch sorting,
but the results are consistent and the fixes shouldn't hurt under more
conventional conditions.

nr_blocks=4 concurrency=10 nr_processes=4 duration=180s

original
------------------------------------------------
nr_succeeded=3433 nr_failed=       0
nr_succeeded=3512 nr_failed=       0
nr_succeeded=3682 nr_failed=       0
nr_succeeded=3583 nr_failed=       0
tot=14210

nr_succeeded=3560 nr_failed=       0
nr_succeeded=3352 nr_failed=       0
nr_succeeded=3667 nr_failed=       0
nr_succeeded=3623 nr_failed=       0
tot=14202

nr_succeeded=3709 nr_failed=       0
nr_succeeded=3680 nr_failed=       0
nr_succeeded=3087 nr_failed=       0
nr_succeeded=3659 nr_failed=       0
tot=14135

AVG=14182 (100%)

sort fixed
------------------------------------------------
nr_succeeded=3907 nr_failed=       0
nr_succeeded=3806 nr_failed=       0
nr_succeeded=3668 nr_failed=       0
nr_succeeded=3909 nr_failed=       0
tot=15290

nr_succeeded=3807 nr_failed=       0
nr_succeeded=3851 nr_failed=       0
nr_succeeded=3813 nr_failed=       0
nr_succeeded=3732 nr_failed=       0
tot=15203

nr_succeeded=3882 nr_failed=       0
nr_succeeded=3733 nr_failed=       0
nr_succeeded=3909 nr_failed=       0
nr_succeeded=3811 nr_failed=       0
tot=15335

AVG=15276 (107.8%)

sort fixed, sort boundary fixed
------------------------------------------------
nr_succeeded=4462 nr_failed=       0
nr_succeeded=4425 nr_failed=       0
nr_succeeded=4429 nr_failed=       0
nr_succeeded=4427 nr_failed=       0
tot=17743

nr_succeeded=4446 nr_failed=       0
nr_succeeded=4450 nr_failed=       0
nr_succeeded=4488 nr_failed=       0
nr_succeeded=4414 nr_failed=       0
tot=17798

nr_succeeded=4462 nr_failed=       0
nr_succeeded=4472 nr_failed=       0
nr_succeeded=4424 nr_failed=       0
nr_succeeded=4449 nr_failed=       0
tot=17807

AVG=17782 (125.4%)

sector fixed, sort boundary fixed, backward seek
------------------------------------------------
nr_succeeded=4467 nr_failed=       0
nr_succeeded=4433 nr_failed=       0
nr_succeeded=4432 nr_failed=       0
nr_succeeded=4435 nr_failed=       0
tot=17767

nr_succeeded=4480 nr_failed=       0
nr_succeeded=4418 nr_failed=       0
nr_succeeded=4460 nr_failed=       0
nr_succeeded=4461 nr_failed=       0
tot=17819

nr_succeeded=4459 nr_failed=       0
nr_succeeded=4460 nr_failed=       0
nr_succeeded=4471 nr_failed=       0
nr_succeeded=4449 nr_failed=       0
tot=17839

AVG=17808 (125.6%)


### Patch

Index: drivers/block/cfq-iosched.c
===================================================================
--- 588af68788e56f7e0e6132e52c35af4abcdb4c93/drivers/block/cfq-iosched.c  (mode:100644)
+++ 832f30b9fd82e60a88b58868fe1933a3e1d94d03/drivers/block/cfq-iosched.c  (mode:100644)
@@ -742,7 +742,11 @@
 	cfq_remove_merge_hints(q, crq);
 	list_del(&crq->request->queuelist);
 
+	/* Allow backward seek upto cfqd->cfq_back_max KiB. */
 	last = cfqd->last_sector;
+	if (last >= cfqd->cfq_back_max * 2)
+		last -= cfqd->cfq_back_max * 2;
+
 	while ((entry = entry->prev) != head) {
 		__rq = list_entry_rq(entry);
 
@@ -751,15 +755,14 @@
 		if (!blk_fs_request(crq->request))
 			break;
 
+		if (crq->request->sector >= last && __rq->sector < last)
+			continue;
 		if (crq->request->sector > __rq->sector)
 			break;
-		if (__rq->sector > last && crq->request->sector < last) {
-			last = crq->request->sector;
+		if (__rq->sector > last && crq->request->sector < last)
 			break;
-		}
 	}
 
-	cfqd->last_sector = last;
 	crq->in_flight = 1;
 	cfqq->in_flight++;
 	list_add(&crq->request->queuelist, entry);
@@ -813,8 +816,6 @@
 			crq = rb_entry_crq(rb_first(&cfqq->sort_list));
 	}
 
-	cfqd->last_sector = crq->request->sector + crq->request->nr_sectors;
-
 	/*
 	 * finally, insert request into driver list
 	 */
@@ -860,6 +861,11 @@
 		goto restart;
 	}
 
+	if (queued) {
+		struct request *rq = list_entry_rq(q->queue_head.prev);
+		cfqd->last_sector = rq->sector + rq->nr_sectors;
+	}
+
 	return queued;
 }
 
