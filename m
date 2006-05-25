Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbWEYTS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWEYTS6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbWEYTS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:18:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40077 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030360AbWEYTS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:18:57 -0400
Date: Thu, 25 May 2006 20:18:48 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 8/10] dm: add module ref counting
Message-ID: <20060525191848.GZ4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

The reference counting on dm-mod is zero if no mapped devices are
open.  This is incorrect, and can lead to an oops if the module
is unloaded while mapped devices exist.

This patch claims a reference to the module whenever a device is
created, and drops it again when the device is freed.

Devices must be removed before dm-mod is unloaded.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17-rc4/drivers/md/dm.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/md/dm.c	2006-05-23 18:18:25.000000000 +0100
+++ linux-2.6.17-rc4/drivers/md/dm.c	2006-05-23 19:37:14.000000000 +0100
@@ -852,6 +852,9 @@ static struct mapped_device *alloc_dev(u
 		return NULL;
 	}
 
+	if (!try_module_get(THIS_MODULE))
+		goto bad0;
+
 	/* get a minor number for the dev */
 	r = persistent ? specific_minor(md, minor) : next_free_minor(md, &minor);
 	if (r < 0)
@@ -918,6 +921,8 @@ static struct mapped_device *alloc_dev(u
 	blk_cleanup_queue(md->queue);
 	free_minor(minor);
  bad1:
+	module_put(THIS_MODULE);
+ bad0:
 	kfree(md);
 	return NULL;
 }
@@ -941,6 +946,7 @@ static void free_dev(struct mapped_devic
 
 	put_disk(md->disk);
 	blk_cleanup_queue(md->queue);
+	module_put(THIS_MODULE);
 	kfree(md);
 }
 
