Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262903AbVAKWFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbVAKWFB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbVAKWEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:04:33 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:48306 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262903AbVAKWBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:01:37 -0500
Date: Tue, 11 Jan 2005 13:57:53 -0800
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: [RFC] remove usage of block_subsys.rwsem in genhd.c
Message-ID: <20050111215753.GA18663@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In auditing all of the subsystem code that uses the rwsem with the idea
to remove it (pushing it upwards so that the driver core works
properly), I noticed that the block code is using it.

Do you have any complaints about the following patch that gets rid of
using the rwsem, in favor of a normal semaphore?  It also drops the
major_names_lock, as all areas that were using that, are also protected
by the new semaphore.

Patch is against the latest -bk tree.

diffstat:
 drivers/block/genhd.c |   31 ++++++++++++-------------------
 1 files changed, 12 insertions(+), 19 deletions(-)

thanks,

greg k-h

-----

Block: Remove block_subsys.rwsem usage

A new, local semaphore is used, and the major_names_lock spinlock is
dropped, as it is no longer needed with this patch.  The goal is to
remove the subsys.rwsem entirely in the future, hence the need for this
change.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


--- a/drivers/block/genhd.c	2005-01-07 11:18:22 -08:00
+++ b/drivers/block/genhd.c	2005-01-11 12:53:47 -08:00
@@ -19,10 +19,11 @@
 
 static struct subsystem block_subsys;
 
+static DECLARE_MUTEX(block_subsys_sem);
+
 /*
  * Can be deleted altogether. Later.
  *
- * Modified under both block_subsys.rwsem and major_names_lock.
  */
 static struct blk_major_name {
 	struct blk_major_name *next;
@@ -30,8 +31,6 @@ static struct blk_major_name {
 	char name[16];
 } *major_names[MAX_PROBE_HASH];
 
-static spinlock_t major_names_lock = SPIN_LOCK_UNLOCKED;
-
 /* index in the above - for now: assume no multimajor ranges */
 static inline int major_to_index(int major)
 {
@@ -47,13 +46,13 @@ int get_blkdev_list(char *p)
 
 	len = sprintf(p, "\nBlock devices:\n");
 
-	down_read(&block_subsys.rwsem);
+	down(&block_subsys_sem);
 	for (i = 0; i < ARRAY_SIZE(major_names); i++) {
 		for (n = major_names[i]; n; n = n->next)
 			len += sprintf(p+len, "%3d %s\n",
 				       n->major, n->name);
 	}
-	up_read(&block_subsys.rwsem);
+	up(&block_subsys_sem);
 
 	return len;
 }
@@ -63,9 +62,8 @@ int register_blkdev(unsigned int major, 
 {
 	struct blk_major_name **n, *p;
 	int index, ret = 0;
-	unsigned long flags;
 
-	down_write(&block_subsys.rwsem);
+	down(&block_subsys_sem);
 
 	/* temporary */
 	if (major == 0) {
@@ -95,7 +93,6 @@ int register_blkdev(unsigned int major, 
 	p->next = NULL;
 	index = major_to_index(major);
 
-	spin_lock_irqsave(&major_names_lock, flags);
 	for (n = &major_names[index]; *n; n = &(*n)->next) {
 		if ((*n)->major == major)
 			break;
@@ -104,7 +101,6 @@ int register_blkdev(unsigned int major, 
 		*n = p;
 	else
 		ret = -EBUSY;
-	spin_unlock_irqrestore(&major_names_lock, flags);
 
 	if (ret < 0) {
 		printk("register_blkdev: cannot get major %d for %s\n",
@@ -112,7 +108,7 @@ int register_blkdev(unsigned int major, 
 		kfree(p);
 	}
 out:
-	up_write(&block_subsys.rwsem);
+	up(&block_subsys_sem);
 	return ret;
 }
 
@@ -124,11 +120,9 @@ int unregister_blkdev(unsigned int major
 	struct blk_major_name **n;
 	struct blk_major_name *p = NULL;
 	int index = major_to_index(major);
-	unsigned long flags;
 	int ret = 0;
 
-	down_write(&block_subsys.rwsem);
-	spin_lock_irqsave(&major_names_lock, flags);
+	down(&block_subsys_sem);
 	for (n = &major_names[index]; *n; n = &(*n)->next)
 		if ((*n)->major == major)
 			break;
@@ -138,8 +132,7 @@ int unregister_blkdev(unsigned int major
 		p = *n;
 		*n = p->next;
 	}
-	spin_unlock_irqrestore(&major_names_lock, flags);
-	up_write(&block_subsys.rwsem);
+	up(&block_subsys_sem);
 	kfree(p);
 
 	return ret;
@@ -233,7 +226,7 @@ static void *part_start(struct seq_file 
 	struct list_head *p;
 	loff_t l = *pos;
 
-	down_read(&block_subsys.rwsem);
+	down(&block_subsys_sem);
 	list_for_each(p, &block_subsys.kset.list)
 		if (!l--)
 			return list_entry(p, struct gendisk, kobj.entry);
@@ -250,7 +243,7 @@ static void *part_next(struct seq_file *
 
 static void part_stop(struct seq_file *part, void *v)
 {
-	up_read(&block_subsys.rwsem);
+	up(&block_subsys_sem);
 }
 
 static int show_partition(struct seq_file *part, void *v)
@@ -508,7 +501,7 @@ static void *diskstats_start(struct seq_
 	loff_t k = *pos;
 	struct list_head *p;
 
-	down_read(&block_subsys.rwsem);
+	down(&block_subsys_sem);
 	list_for_each(p, &block_subsys.kset.list)
 		if (!k--)
 			return list_entry(p, struct gendisk, kobj.entry);
@@ -525,7 +518,7 @@ static void *diskstats_next(struct seq_f
 
 static void diskstats_stop(struct seq_file *part, void *v)
 {
-	up_read(&block_subsys.rwsem);
+	up(&block_subsys_sem);
 }
 
 static int diskstats_show(struct seq_file *s, void *v)
