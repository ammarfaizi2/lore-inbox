Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbTKTFrg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 00:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTKTFrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 00:47:36 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:32472 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264268AbTKTFrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 00:47:32 -0500
Date: Thu, 20 Nov 2003 11:17:07 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Patrick Mochel <mochel@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: [PATCH] sysfs_remove_dir Vs dcache_readdir race fix
Message-ID: <20031120054707.GA1724@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sysfs_remove_dir modifies d_subdirs list which results in inconsistency
when there is concurrent dcache_readdir is going on. I think there
is no need for sysfs_remove_dir to modify d_subdirs list and removal
of dentries from d_child list is taken care in the final dput().

The folloing patch fixes this race. The patch is tested by running these two
loops simlutaneously on a SMP box.

#while true; do tree /sys/class/net > /dev/null; done

#while true; do insmod ./dummy.o; rmmod dummy.o; done


o This patch fixes sysfs_remove_dir race with dcache_readdir. There is
  no need for sysfs_remove_dir to modify the d_subdirs list for the directory
  being deleted as it is taken care in the final dput. Modifying this list
  results in inconsistent d_subdirs list and causes infinite loop in 
  concurrently occuring dcache_readdir.


 fs/sysfs/dir.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -puN fs/sysfs/dir.c~sysfs_remove_dir-race-fix fs/sysfs/dir.c
--- linux-2.6.0-test9-bk24/fs/sysfs/dir.c~sysfs_remove_dir-race-fix	2003-11-20 10:36:13.000000000 +0530
+++ linux-2.6.0-test9-bk24-maneesh/fs/sysfs/dir.c	2003-11-20 10:38:32.000000000 +0530
@@ -122,8 +122,8 @@ void sysfs_remove_dir(struct kobject * k
 	node = dentry->d_subdirs.next;
 	while (node != &dentry->d_subdirs) {
 		struct dentry * d = list_entry(node,struct dentry,d_child);
-		list_del_init(node);
 
+		node = node->next;
 		pr_debug(" o %s (%d): ",d->d_name.name,atomic_read(&d->d_count));
 		if (d->d_inode) {
 			d = dget_locked(d);
@@ -139,9 +139,7 @@ void sysfs_remove_dir(struct kobject * k
 			spin_lock(&dcache_lock);
 		}
 		pr_debug(" done\n");
-		node = dentry->d_subdirs.next;
 	}
-	list_del_init(&dentry->d_child);
 	spin_unlock(&dcache_lock);
 	up(&dentry->d_inode->i_sem);
 

_

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
