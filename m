Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261654AbTCGQDR>; Fri, 7 Mar 2003 11:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbTCGQDQ>; Fri, 7 Mar 2003 11:03:16 -0500
Received: from air-2.osdl.org ([65.172.181.6]:6126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261654AbTCGQDP>;
	Fri, 7 Mar 2003 11:03:15 -0500
Date: Fri, 7 Mar 2003 09:49:11 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: David Howells <dhowells@redhat.com>
cc: <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64 sysfs bug
In-Reply-To: <5557.1047035140@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.33.0303070948150.991-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Mar 2003, David Howells wrote:

> 
> Hi, I seem to be getting tripping a bug somewhere with my filesystem now that
> I'm using it with 2.5.64 (no problems of this nature occurred with
> 2.5.63). The problem occurs during rmmod (I don't need to actually mount
> anything):
> 
> 	[root@host135 root]# insmod /tmp/cachefs.ko
> 	[root@host135 root]# rmmod -f cachefs
> 	[root@host135 root]# insmod /tmp/cachefs.ko
> 	[root@host135 root]# rmmod -f cachefs
> 	Segmentation fault
> 	[root@host135 root]# 
> 
> I see this appearing on the console:

Could you try the attached patch, and let me know if it helps? 

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


