Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbTIOKVH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 06:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbTIOKVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 06:21:07 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:21475 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262357AbTIOKVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 06:21:00 -0400
Date: Mon, 15 Sep 2003 15:51:28 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: mochel@osdl.org
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: [PATCH 2.6] sysfs_remove_dir
Message-ID: <20030915102127.GA1387@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pat,

sysfs_remove_dir() does not remove the contents of subdirs corresponding
to the attribute groups of a kobject. The following patch fixes this by first
removing the subdir contents and then removing thus emptied subdirs along
with the other attribute files of the kobject and plugs the memory
leakage resulting from orphan dentries.

I tested it by inserting and removing "dummy.o" network module and verifying
that dentires corresponding to "statistics" attribute group are removed.

Please comment.

Thanks
Maneesh



 o sysfs_remove_dir() has to remove the files in the subdirs (corresponding
   to the attribute groups) and then remove such empty subdirs along with the 
   other attribute files for the given kobject. The following patch does this
   assuming that there are/will be no attribute sub-groups.


 fs/sysfs/dir.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff -puN fs/sysfs/dir.c~sysfs_remove_dir-fix fs/sysfs/dir.c
--- linux-2.6.0-test5-mm2/fs/sysfs/dir.c~sysfs_remove_dir-fix	2003-09-15 15:08:45.000000000 +0530
+++ linux-2.6.0-test5-mm2-maneesh/fs/sysfs/dir.c	2003-09-15 15:26:04.000000000 +0530
@@ -119,23 +119,30 @@ void sysfs_remove_dir(struct kobject * k
 {
 	struct list_head * node;
 	struct dentry * dentry = dget(kobj->dentry);
+	struct dentry * parent;
 
 	if (!dentry)
 		return;
 
 	pr_debug("sysfs %s: removing dir\n",dentry->d_name.name);
-	down(&dentry->d_inode->i_sem);
 
+	parent = dentry;
+	down(&parent->d_inode->i_sem);
 	spin_lock(&dcache_lock);
-	node = dentry->d_subdirs.next;
-	while (node != &dentry->d_subdirs) {
-		struct dentry * d = list_entry(node,struct dentry,d_child);
+repeat:
+	node = parent->d_subdirs.next;
+	while (node != &parent->d_subdirs) {
+		struct dentry * d = list_entry(node, struct dentry, d_child);
 		list_del_init(node);
 
 		pr_debug(" o %s (%d): ",d->d_name.name,atomic_read(&d->d_count));
 		if (d->d_inode) {
 			d = dget_locked(d);
 			pr_debug("removing");
+			if (!list_empty(&d->d_subdirs)) {
+				parent = d;
+				goto repeat;
+			}
 
 			/**
 			 * Unlink and unhash.
@@ -147,7 +154,12 @@ void sysfs_remove_dir(struct kobject * k
 			spin_lock(&dcache_lock);
 		}
 		pr_debug(" done\n");
-		node = dentry->d_subdirs.next;
+		node = parent->d_subdirs.next;
+	}
+
+	if (!list_empty(&dentry->d_subdirs)) {
+		parent = dentry;
+		goto repeat;
 	}
 	list_del_init(&dentry->d_child);
 	spin_unlock(&dcache_lock);

_

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
