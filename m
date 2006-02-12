Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWBLRjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWBLRjy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 12:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWBLRjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 12:39:39 -0500
Received: from verein.lst.de ([213.95.11.210]:59544 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750822AbWBLRjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 12:39:37 -0500
Date: Sun, 12 Feb 2006 18:39:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, schwidefsky@de.ibm.com, linux390@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] dasd: kill dynamic ioctl registration
Message-ID: <20060212173930.GF26035@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there are no more users of the awkward dynamic ioctl hack we
can remove the code to support it.


 dasd_int.h   |   11 ---------
 dasd_ioctl.c |   69 -----------------------------------------------------------
 2 files changed, 80 deletions(-)

Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6.16-rc2-mm1/drivers/s390/block/dasd_int.h
===================================================================
--- linux-2.6.16-rc2-mm1.orig/drivers/s390/block/dasd_int.h	2006-02-11 16:52:56.000000000 +0100
+++ linux-2.6.16-rc2-mm1/drivers/s390/block/dasd_int.h	2006-02-11 16:55:50.000000000 +0100
@@ -68,15 +68,6 @@
  */
 struct dasd_device;
 
-typedef int (*dasd_ioctl_fn_t) (struct block_device *bdev, int no, long args);
-
-struct dasd_ioctl {
-	struct list_head list;
-	struct module *owner;
-	int no;
-	dasd_ioctl_fn_t handler;
-};
-
 typedef enum {
 	dasd_era_fatal = -1,	/* no chance to recover		     */
 	dasd_era_none = 0,	/* don't recover, everything alright */
@@ -522,8 +513,6 @@
 void dasd_destroy_partitions(struct dasd_device *);
 
 /* externals in dasd_ioctl.c */
-int  dasd_ioctl_no_register(struct module *, int, dasd_ioctl_fn_t);
-int  dasd_ioctl_no_unregister(struct module *, int, dasd_ioctl_fn_t);
 int  dasd_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
 long dasd_compat_ioctl(struct file *, unsigned int, unsigned long);
 
Index: linux-2.6.16-rc2-mm1/drivers/s390/block/dasd_ioctl.c
===================================================================
--- linux-2.6.16-rc2-mm1.orig/drivers/s390/block/dasd_ioctl.c	2006-02-11 16:50:25.000000000 +0100
+++ linux-2.6.16-rc2-mm1/drivers/s390/block/dasd_ioctl.c	2006-02-11 16:56:20.000000000 +0100
@@ -24,59 +24,6 @@
 
 #include "dasd_int.h"
 
-/*
- * SECTION: ioctl functions.
- */
-static struct list_head dasd_ioctl_list = LIST_HEAD_INIT(dasd_ioctl_list);
-
-/*
- * Find the ioctl with number no.
- */
-static struct dasd_ioctl *
-dasd_find_ioctl(int no)
-{
-	struct dasd_ioctl *ioctl;
-
-	list_for_each_entry (ioctl, &dasd_ioctl_list, list)
-		if (ioctl->no == no)
-			return ioctl;
-	return NULL;
-}
-
-/*
- * Register ioctl with number no.
- */
-int
-dasd_ioctl_no_register(struct module *owner, int no, dasd_ioctl_fn_t handler)
-{
-	struct dasd_ioctl *new;
-	if (dasd_find_ioctl(no))
-		return -EBUSY;
-	new = kmalloc(sizeof (struct dasd_ioctl), GFP_KERNEL);
-	if (new == NULL)
-		return -ENOMEM;
-	new->owner = owner;
-	new->no = no;
-	new->handler = handler;
-	list_add(&new->list, &dasd_ioctl_list);
-	return 0;
-}
-
-/*
- * Deregister ioctl with number no.
- */
-int
-dasd_ioctl_no_unregister(struct module *owner, int no, dasd_ioctl_fn_t handler)
-{
-	struct dasd_ioctl *old = dasd_find_ioctl(no);
-	if (old == NULL)
-		return -ENOENT;
-	if (old->no != no || old->handler != handler || owner != old->owner)
-		return -EINVAL;
-	list_del(&old->list);
-	kfree(old);
-	return 0;
-}
 
 static int
 dasd_ioctl_api_version(void __user *argp)
@@ -429,8 +376,6 @@
 	struct block_device *bdev = inode->i_bdev;
 	struct dasd_device *device = bdev->bd_disk->private_data;
 	void __user *argp = (void __user *)arg;
-	struct dasd_ioctl *ioctl;
-	int rc;
 
 	if (!device)
                 return -ENODEV;
@@ -477,17 +422,6 @@
 				return rval;
 		}
 
-		/* else resort to the deprecated dynamic ioctl list */
-		list_for_each_entry(ioctl, &dasd_ioctl_list, list) {
-			if (ioctl->no == cmd) {
-				/* Found a matching ioctl. Call it. */
-				if (!try_module_get(ioctl->owner))
-					continue;
-				rc = ioctl->handler(bdev, cmd, arg);
-				module_put(ioctl->owner);
-				return rc;
-			}
-		}
 		return -EINVAL;
 	}
 }
@@ -503,6 +437,3 @@
 
 	return (rval == -EINVAL) ? -ENOIOCTLCMD : rval;
 }
-
-EXPORT_SYMBOL(dasd_ioctl_no_register);
-EXPORT_SYMBOL(dasd_ioctl_no_unregister);
