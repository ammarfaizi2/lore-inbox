Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbWEYTTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWEYTTx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWEYTTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:19:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22670 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030365AbWEYTTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:19:52 -0400
Date: Thu, 25 May 2006 20:19:49 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 9/10] dm: fix block device initialisation
Message-ID: <20060525191949.GA4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

In alloc_dev(), we register the device with the block layer and then
continue to initialize the device.  But register_disk() makes
the device available to be opened before we have completed
initialising it.

This patch moves the final bits of the initialization above the disk
registration.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17-rc4/drivers/md/dm.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/md/dm.c	2006-05-23 19:37:14.000000000 +0100
+++ linux-2.6.17-rc4/drivers/md/dm.c	2006-05-23 19:38:01.000000000 +0100
@@ -891,6 +891,10 @@ static struct mapped_device *alloc_dev(u
 	if (!md->disk)
 		goto bad4;
 
+	atomic_set(&md->pending, 0);
+	init_waitqueue_head(&md->wait);
+	init_waitqueue_head(&md->eventq);
+
 	md->disk->major = _major;
 	md->disk->first_minor = minor;
 	md->disk->fops = &dm_blk_dops;
@@ -900,10 +904,6 @@ static struct mapped_device *alloc_dev(u
 	add_disk(md->disk);
 	format_dev_t(md->name, MKDEV(_major, minor));
 
-	atomic_set(&md->pending, 0);
-	init_waitqueue_head(&md->wait);
-	init_waitqueue_head(&md->eventq);
-
 	/* Populate the mapping, nobody knows we exist yet */
 	spin_lock(&_minor_lock);
 	old_md = idr_replace(&_minor_idr, md, minor);
