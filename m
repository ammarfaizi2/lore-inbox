Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWCaAQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWCaAQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWCaAQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:16:55 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:14107 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751115AbWCaAQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:16:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:x-mimeole:thread-index;
        b=smFex68M1HlRVNdYHh/edS5mYQRDExpthxqJxBwwDyJneU7VST0uUqyL6l8mgqU3EbQ5iPFD/M83l89sN7kztBION9SBPE66SWzSqeEPzQg7tBZXJpfxA/rPJo4/0beslasrNrLtJwND7lP8uPVCeI6qCLdZC0v+ka4GASMhH6o=
From: "Hua Zhong" <hzhong@gmail.com>
To: <linux-kernel@vger.kernel.org>, <bart.de.schuymer@pandora.be>
Subject: 
Date: Thu, 30 Mar 2006 16:16:40 -0800
Message-ID: <000501c65458$630b54a0$853d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcZUWGIOedAr94yqRRyc1+Nq1+/Mjw==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In 2.6.15.1 I encountered some IDE crashes when unplugging IDE cables to
emulate disk errors. Below is a patch against 2.6.16 which I think still
applies.

1. The first BUG_ON could trigger when a PREFLUSH IO fails (it would fail
the original barrier request which hasn't been marked REQ_STARTED yet).
2. the rq could have been dequeued already (same as 1).
3. HWGROUP(drive)->rq could be NULL because of the ide_error() several lines
earlier.

Signed off by: Hua Zhong <hzhong@gmail.com>

diff -ur linux-2.6.16.orig/drivers/ide/ide-io.c
linux-2.6.16/drivers/ide/ide-io.c
--- linux-2.6.16.orig/drivers/ide/ide-io.c	2006-03-19
21:53:29.000000000 -0800
+++ linux-2.6.16/drivers/ide/ide-io.c	2006-04-01 00:26:55.411871520 -0800
@@ -60,8 +60,6 @@
 {
 	int ret = 1;
 
-	BUG_ON(!(rq->flags & REQ_STARTED));
-
 	/*
 	 * if failfast is set on a request, override number of sectors and
 	 * complete the whole request right now
@@ -83,7 +81,8 @@
 
 	if (!end_that_request_first(rq, uptodate, nr_sectors)) {
 		add_disk_randomness(rq->rq_disk);
-		blkdev_dequeue_request(rq);
+		if (!list_empty(&rq->queuelist))
+			blkdev_dequeue_request(rq);
 		HWGROUP(drive)->rq = NULL;
 		end_that_request_last(rq, uptodate);
 		ret = 0;
@@ -1277,6 +1276,10 @@
 	 * make sure request is sane
 	 */
 	rq = HWGROUP(drive)->rq;
+
+	if (!rq)
+		goto out;
+
 	HWGROUP(drive)->rq = NULL;
 
 	rq->errors = 0;

