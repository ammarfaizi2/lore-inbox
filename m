Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUBQHSo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 02:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbUBQHSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 02:18:44 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:35058 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261567AbUBQHSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 02:18:40 -0500
Date: Tue, 17 Feb 2004 12:53:14 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] sysfs_remove_dir Vs dcache_readdir
Message-ID: <20040217072314.GA5459@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have re-done the patch fixing the race between sysfs_remove_dir() and
dcache_readdir(). If you recall, sysfs_remove_dir(kobj) manipulates the
->d_subdirs list for the dentry corresponding to the sysfs directory being
removed. It can end up deleting the cursor dentry which is added to the
->d_subdirs list during a concurrent dcache_dir_open() ==> dcache_readdir() for 
the same directory. And as a result dcache_readdir() can loop for ever holding
dcache_lock.

The earlier patch which was included in -mm1 created problems which resulted
in list_del() BUG hits in prune_dcache(). The reason I think is that in the 
main loop in sysfs_remove_dir(), dcache_lock is dropped and re-acquired, and 
this could result in inconsistent ->d_subdirs list and prune_dcache() may try
to delete an already deleted dentry. I have corrected this in the new 
patch as below. 

I could do sysfs_remove_dir() more neatly on sysfs backing store patch set
as there I don't use the ->d_subdirs list. Instead the list of children
sysfs_dirent works out well. But untill sysfs backing store patch is picked
up the existing code suffer from this race. This can be easily tested by
running following two loops on a SMP box

# while true; do insmod drivers/net/dummy.ko; rmmod dummy; done
# while true; do find /sys/class/net > /dev/null; done

Please review the patch below.

Thanks
Manneesh

===============================================================================


o This patch fixes sysfs_remove_dir race with dcache_readdir. There is
  no need for sysfs_remove_dir to modify the d_subdirs list for the directory
  being deleted as it is taken care in the final dput. Modifying this list
  results in inconsistent d_subdirs list and causes infinite loop in 
  concurrently occurring dcache_readdir.

o The main loop is restarted every time, dcache_lock is re-acquired in order
  to maintain consistency.


 fs/sysfs/dir.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff -puN fs/sysfs/dir.c~sysfs_remove_dir-race-fix fs/sysfs/dir.c
--- linux-2.6.3-rc4/fs/sysfs/dir.c~sysfs_remove_dir-race-fix	2004-02-17 11:18:38.000000000 +0530
+++ linux-2.6.3-rc4-maneesh/fs/sysfs/dir.c	2004-02-17 12:21:31.000000000 +0530
@@ -120,13 +120,14 @@ void sysfs_remove_dir(struct kobject * k
 	down(&dentry->d_inode->i_sem);
 
 	spin_lock(&dcache_lock);
+restart:
 	node = dentry->d_subdirs.next;
 	while (node != &dentry->d_subdirs) {
 		struct dentry * d = list_entry(node,struct dentry,d_child);
-		list_del_init(node);
 
+		node = node->next;
 		pr_debug(" o %s (%d): ",d->d_name.name,atomic_read(&d->d_count));
-		if (d->d_inode) {
+		if (!d_unhashed(d) && (d->d_inode)) {
 			d = dget_locked(d);
 			pr_debug("removing");
 
@@ -137,12 +138,12 @@ void sysfs_remove_dir(struct kobject * k
 			d_delete(d);
 			simple_unlink(dentry->d_inode,d);
 			dput(d);
+			pr_debug(" done\n");
 			spin_lock(&dcache_lock);
+			/* re-acquired dcache_lock, need to restart */
+			goto restart;
 		}
-		pr_debug(" done\n");
-		node = dentry->d_subdirs.next;
 	}
-	list_del_init(&dentry->d_child);
 	spin_unlock(&dcache_lock);
 	up(&dentry->d_inode->i_sem);
 

_
