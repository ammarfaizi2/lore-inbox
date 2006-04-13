Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWDMUgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWDMUgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 16:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWDMUf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 16:35:56 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:37910 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S964973AbWDMUft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 16:35:49 -0400
Date: Thu, 13 Apr 2006 16:35:46 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 07/08] dm: proper module reference counting
Message-ID: <20060413203546.GA3257@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Module reference counting appropriately occurs when the block device is
 opened, but dm devices exist outside of the device actually being opened.

 Currently, in certain situations, unloading the dm-mod module will result
 in an oops. This patch claims a reference to the module when a device
 is created, and drops it when the device is freed.

 This is one possible implementation. Another could be to do an internal
 "dmsetup remove_all" when the module is unloaded. Comments welcome.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
--
 drivers/md/dm.c |    6 ++++++
 1 files changed, 6 insertions(+)

diff -ruNpX ../dontdiff linux-2.6.16-staging1/drivers/md/dm.c linux-2.6.16-staging2/drivers/md/dm.c
--- linux-2.6.16-staging1/drivers/md/dm.c	2006-04-13 16:18:23.000000000 -0400
+++ linux-2.6.16-staging2/drivers/md/dm.c	2006-04-13 16:18:23.000000000 -0400
@@ -796,6 +796,9 @@ static struct mapped_device *alloc_dev(u
 		return NULL;
 	}
 
+	if (!try_module_get(THIS_MODULE))
+		goto bad0;
+
 	/* get a minor number for the dev */
 	r = persistent ? specific_minor(md, minor) : next_free_minor(md, &minor);
 	if (r < 0)
@@ -862,6 +865,8 @@ static struct mapped_device *alloc_dev(u
 	blk_put_queue(md->queue);
 	free_minor(minor);
  bad1:
+	module_put(THIS_MODULE);
+ bad0:
 	kfree(md);
 	return NULL;
 }
@@ -885,6 +890,7 @@ static void free_dev(struct mapped_devic
 
 	put_disk(md->disk);
 	blk_put_queue(md->queue);
+	module_put(THIS_MODULE);
 	kfree(md);
 }
 
