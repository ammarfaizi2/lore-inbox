Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWATVQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWATVQE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWATVQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:16:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48606 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932185AbWATVQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:16:03 -0500
Date: Fri, 20 Jan 2006 21:15:37 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Kevin Corry <kevcorry@us.ibm.com>
Subject: [PATCH 4/9] device-mapper statistics: basic
Message-ID: <20060120211537.GE4724@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Kevin Corry <kevcorry@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Corry <kevcorry@us.ibm.com>

Record basic I/O statistics for mapped devices.

Signed-Off-By: Kevin Corry <kevcorry@us.ibm.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.16-rc1/drivers/md/dm.c
===================================================================
--- linux-2.6.16-rc1.orig/drivers/md/dm.c	2006-01-20 18:41:11.000000000 +0000
+++ linux-2.6.16-rc1/drivers/md/dm.c	2006-01-20 20:17:48.000000000 +0000
@@ -573,10 +573,14 @@ static void __split_bio(struct mapped_de
 static int dm_request(request_queue_t *q, struct bio *bio)
 {
 	int r;
+	int rw = bio_data_dir(bio);
 	struct mapped_device *md = q->queuedata;
 
 	down_read(&md->io_lock);
 
+	disk_stat_inc(dm_disk(md), ios[rw]);
+	disk_stat_add(dm_disk(md), sectors[rw], bio_sectors(bio));
+
 	/*
 	 * If we're suspended we have to queue
 	 * this io for later.
