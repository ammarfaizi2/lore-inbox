Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268347AbTCFUwx>; Thu, 6 Mar 2003 15:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268348AbTCFUwv>; Thu, 6 Mar 2003 15:52:51 -0500
Received: from air-2.osdl.org ([65.172.181.6]:32700 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268347AbTCFUwH>;
	Thu, 6 Mar 2003 15:52:07 -0500
Date: Thu, 6 Mar 2003 14:38:30 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Alistair Strachan <alistair@devzero.co.uk>
cc: <linux-kernel@vger.kernel.org>, <thundercloud@devzero.co.uk>,
       <bonganilinux@mweb.co.za>
Subject: Re: [2.5.64-mm1] sysfs oops
In-Reply-To: <200303062026.18224.alistair@devzero.co.uk>
Message-ID: <Pine.LNX.4.33.0303061436030.994-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Alistair Strachan wrote:

> Hi,
> 
> The following was experienced while running Andrew's 2.5.64-mm1 kernel. My 
> dialup (ppp) connection was terminated, and when I attempted to re-establish, 
> pppd would not come up. I found the following oops in dmesg and have provided 
> a decoded version below.
> 
> This doesn't appear to be fixed in mainline, yet. Is it mm specific? dcache?

Argh. A bk merge ate my change!

This has been around for a while, and I merged a patch to fix it. However, 
a leter merge with previous work to split fs/sysfs/inode.c up reverted it 
back to the old code. 

Could you (both) try the following patch and let me know if it fixes it?

Thanks,

	-pat

===== fs/sysfs/dir.c 1.2 vs edited =====
--- 1.2/fs/sysfs/dir.c	Thu Jan 30 17:10:06 2003
+++ edited/fs/sysfs/dir.c	Thu Mar  6 14:34:01 2003
@@ -71,7 +71,7 @@
 
 void sysfs_remove_dir(struct kobject * kobj)
 {
-	struct list_head * node, * next;
+	struct list_head * node;
 	struct dentry * dentry = dget(kobj->dentry);
 	struct dentry * parent;
 
@@ -83,31 +83,28 @@
 	down(&parent->d_inode->i_sem);
 	down(&dentry->d_inode->i_sem);
 
-	list_for_each_safe(node,next,&dentry->d_subdirs) {
-		struct dentry * d = dget(list_entry(node,struct dentry,d_child));
-		/** 
-		 * Make sure dentry is still there 
-		 */
-		pr_debug(" o %s: ",d->d_name.name);
-		if (d->d_inode) {
+	spin_lock(&dcache_lock);
+	node = dentry->d_subdirs.next;
+	while (node != &dentry->d_subdirs) {
+		struct dentry * d = list_entry(node,struct dentry,d_child);
+		list_del_init(node);
 
+		pr_debug(" o %s (%d): ",d->d_name.name,atomic_read(&d->d_count));
+		if (d->d_inode) {
+			d = dget_locked(d);
 			pr_debug("removing");
+
 			/**
 			 * Unlink and unhash.
 			 */
-			simple_unlink(dentry->d_inode,d);
+			spin_unlock(&dcache_lock);
 			d_delete(d);
-
-			/**
-			 * Drop reference from initial sysfs_get_dentry().
-			 */
+			simple_unlink(dentry->d_inode,d);
 			dput(d);
+			spin_lock(&dcache_lock);
 		}
-		pr_debug(" done (%d)\n",atomic_read(&d->d_count));
-		/**
-		 * drop reference from dget() above.
-		 */
-		dput(d);
+		pr_debug(" done\n");
+		node = dentry->d_subdirs.next;
 	}
 
 	up(&dentry->d_inode->i_sem);

