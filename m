Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262901AbVAQVyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbVAQVyj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbVAQVyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:54:24 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:12448 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262904AbVAQVtS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:49:18 -0500
Cc: greg@kroah.com
Subject: [PATCH] Block: Remove block_subsys.rwsem usage
In-Reply-To: <20050117214412.GA28400@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 13:45:00 -0800
Message-Id: <11059983002081@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2330, 2005/01/14 11:50:41-08:00, greg@kroah.com

[PATCH] Block: Remove block_subsys.rwsem usage

A new, local semaphore is used, and the major_names_lock spinlock is
dropped, as it is no longer needed with this patch.  The goal is to
remove the subsys.rwsem entirely in the future, hence the need for this
change.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/block/genhd.c |   31 ++++++++++++-------------------
 1 files changed, 12 insertions(+), 19 deletions(-)


diff -Nru a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	2005-01-17 13:35:48 -08:00
+++ b/drivers/block/genhd.c	2005-01-17 13:35:48 -08:00
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
@@ -30,8 +31,6 @@
 	char name[16];
 } *major_names[MAX_PROBE_HASH];
 
-static spinlock_t major_names_lock = SPIN_LOCK_UNLOCKED;
-
 /* index in the above - for now: assume no multimajor ranges */
 static inline int major_to_index(int major)
 {
@@ -47,13 +46,13 @@
 
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
@@ -63,9 +62,8 @@
 {
 	struct blk_major_name **n, *p;
 	int index, ret = 0;
-	unsigned long flags;
 
-	down_write(&block_subsys.rwsem);
+	down(&block_subsys_sem);
 
 	/* temporary */
 	if (major == 0) {
@@ -95,7 +93,6 @@
 	p->next = NULL;
 	index = major_to_index(major);
 
-	spin_lock_irqsave(&major_names_lock, flags);
 	for (n = &major_names[index]; *n; n = &(*n)->next) {
 		if ((*n)->major == major)
 			break;
@@ -104,7 +101,6 @@
 		*n = p;
 	else
 		ret = -EBUSY;
-	spin_unlock_irqrestore(&major_names_lock, flags);
 
 	if (ret < 0) {
 		printk("register_blkdev: cannot get major %d for %s\n",
@@ -112,7 +108,7 @@
 		kfree(p);
 	}
 out:
-	up_write(&block_subsys.rwsem);
+	up(&block_subsys_sem);
 	return ret;
 }
 
@@ -124,11 +120,9 @@
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
@@ -138,8 +132,7 @@
 		p = *n;
 		*n = p->next;
 	}
-	spin_unlock_irqrestore(&major_names_lock, flags);
-	up_write(&block_subsys.rwsem);
+	up(&block_subsys_sem);
 	kfree(p);
 
 	return ret;
@@ -233,7 +226,7 @@
 	struct list_head *p;
 	loff_t l = *pos;
 
-	down_read(&block_subsys.rwsem);
+	down(&block_subsys_sem);
 	list_for_each(p, &block_subsys.kset.list)
 		if (!l--)
 			return list_entry(p, struct gendisk, kobj.entry);
@@ -250,7 +243,7 @@
 
 static void part_stop(struct seq_file *part, void *v)
 {
-	up_read(&block_subsys.rwsem);
+	up(&block_subsys_sem);
 }
 
 static int show_partition(struct seq_file *part, void *v)
@@ -508,7 +501,7 @@
 	loff_t k = *pos;
 	struct list_head *p;
 
-	down_read(&block_subsys.rwsem);
+	down(&block_subsys_sem);
 	list_for_each(p, &block_subsys.kset.list)
 		if (!k--)
 			return list_entry(p, struct gendisk, kobj.entry);
@@ -525,7 +518,7 @@
 
 static void diskstats_stop(struct seq_file *part, void *v)
 {
-	up_read(&block_subsys.rwsem);
+	up(&block_subsys_sem);
 }
 
 static int diskstats_show(struct seq_file *s, void *v)

