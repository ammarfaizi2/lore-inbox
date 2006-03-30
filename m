Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWC3ISs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWC3ISs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWC3IRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:17:48 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:46419 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932104AbWC3IRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:17:42 -0500
Message-Id: <20060330081730.601566000@localhost.localdomain>
References: <20060330081605.085383000@localhost.localdomain>
Date: Thu, 30 Mar 2006 16:16:10 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Ram Pai <linuxram@us.ibm.com>, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 5/8] core: use list_move()
Content-Disposition: inline; filename=list-move-core.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the combination of list_del(A) and list_add(A, B)
to list_move(A, B).

CC: Greg Kroah-Hartman <gregkh@suse.de>
CC: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 drivers/base/power/resume.c  |    6 ++----
 drivers/base/power/suspend.c |   13 +++++--------
 fs/dcache.c                  |    3 +--
 fs/libfs.c                   |   10 ++++------
 fs/namespace.c               |    6 ++----
 fs/pnode.c                   |    9 +++------
 fs/sysfs/dir.c               |   10 ++++------
 mm/swap.c                    |    3 +--
 8 files changed, 22 insertions(+), 38 deletions(-)

Index: 2.6-git/fs/dcache.c
===================================================================
--- 2.6-git.orig/fs/dcache.c
+++ 2.6-git/fs/dcache.c
@@ -468,8 +468,7 @@ void shrink_dcache_sb(struct super_block
 		dentry = list_entry(tmp, struct dentry, d_lru);
 		if (dentry->d_sb != sb)
 			continue;
-		list_del(tmp);
-		list_add(tmp, &dentry_unused);
+		list_move(tmp, &dentry_unused);
 	}
 
 	/*
Index: 2.6-git/fs/libfs.c
===================================================================
--- 2.6-git.orig/fs/libfs.c
+++ 2.6-git/fs/libfs.c
@@ -149,10 +149,9 @@ int dcache_readdir(struct file * filp, v
 			/* fallthrough */
 		default:
 			spin_lock(&dcache_lock);
-			if (filp->f_pos == 2) {
-				list_del(q);
-				list_add(q, &dentry->d_subdirs);
-			}
+			if (filp->f_pos == 2)
+				list_move(q, &dentry->d_subdirs);
+
 			for (p=q->next; p != &dentry->d_subdirs; p=p->next) {
 				struct dentry *next;
 				next = list_entry(p, struct dentry, d_u.d_child);
@@ -164,8 +163,7 @@ int dcache_readdir(struct file * filp, v
 					return 0;
 				spin_lock(&dcache_lock);
 				/* next is still alive */
-				list_del(q);
-				list_add(q, p);
+				list_move(q, p);
 				p = q;
 				filp->f_pos++;
 			}
Index: 2.6-git/fs/namespace.c
===================================================================
--- 2.6-git.orig/fs/namespace.c
+++ 2.6-git/fs/namespace.c
@@ -517,10 +517,8 @@ void umount_tree(struct vfsmount *mnt, i
 {
 	struct vfsmount *p;
 
-	for (p = mnt; p; p = next_mnt(p, mnt)) {
-		list_del(&p->mnt_hash);
-		list_add(&p->mnt_hash, kill);
-	}
+	for (p = mnt; p; p = next_mnt(p, mnt))
+		list_move(&p->mnt_hash, kill);
 
 	if (propagate)
 		propagate_umount(kill);
Index: 2.6-git/fs/pnode.c
===================================================================
--- 2.6-git.orig/fs/pnode.c
+++ 2.6-git/fs/pnode.c
@@ -53,8 +53,7 @@ static int do_make_slave(struct vfsmount
 	if (master) {
 		list_for_each_entry(slave_mnt, &mnt->mnt_slave_list, mnt_slave)
 			slave_mnt->mnt_master = master;
-		list_del(&mnt->mnt_slave);
-		list_add(&mnt->mnt_slave, &master->mnt_slave_list);
+		list_move(&mnt->mnt_slave, &master->mnt_slave_list);
 		list_splice(&mnt->mnt_slave_list, master->mnt_slave_list.prev);
 		INIT_LIST_HEAD(&mnt->mnt_slave_list);
 	} else {
@@ -283,10 +282,8 @@ static void __propagate_umount(struct vf
 		 * umount the child only if the child has no
 		 * other children
 		 */
-		if (child && list_empty(&child->mnt_mounts)) {
-			list_del(&child->mnt_hash);
-			list_add_tail(&child->mnt_hash, &mnt->mnt_hash);
-		}
+		if (child && list_empty(&child->mnt_mounts))
+			list_move_tail(&child->mnt_hash, &mnt->mnt_hash);
 	}
 }
 
Index: 2.6-git/fs/sysfs/dir.c
===================================================================
--- 2.6-git.orig/fs/sysfs/dir.c
+++ 2.6-git/fs/sysfs/dir.c
@@ -429,10 +429,9 @@ static int sysfs_readdir(struct file * f
 			i++;
 			/* fallthrough */
 		default:
-			if (filp->f_pos == 2) {
-				list_del(q);
-				list_add(q, &parent_sd->s_children);
-			}
+			if (filp->f_pos == 2)
+				list_move(q, &parent_sd->s_children);
+
 			for (p=q->next; p!= &parent_sd->s_children; p=p->next) {
 				struct sysfs_dirent *next;
 				const char * name;
@@ -454,8 +453,7 @@ static int sysfs_readdir(struct file * f
 						 dt_type(next)) < 0)
 					return 0;
 
-				list_del(q);
-				list_add(q, p);
+				list_move(q, p);
 				p = q;
 				filp->f_pos++;
 			}
Index: 2.6-git/mm/swap.c
===================================================================
--- 2.6-git.orig/mm/swap.c
+++ 2.6-git/mm/swap.c
@@ -86,8 +86,7 @@ int rotate_reclaimable_page(struct page 
 	zone = page_zone(page);
 	spin_lock_irqsave(&zone->lru_lock, flags);
 	if (PageLRU(page) && !PageActive(page)) {
-		list_del(&page->lru);
-		list_add_tail(&page->lru, &zone->inactive_list);
+		list_move_tail(&page->lru, &zone->inactive_list);
 		inc_page_state(pgrotated);
 	}
 	if (!test_clear_page_writeback(page))
Index: 2.6-git/drivers/base/power/resume.c
===================================================================
--- 2.6-git.orig/drivers/base/power/resume.c
+++ 2.6-git/drivers/base/power/resume.c
@@ -49,8 +49,7 @@ void dpm_resume(void)
 		struct device * dev = to_device(entry);
 
 		get_device(dev);
-		list_del_init(entry);
-		list_add_tail(entry, &dpm_active);
+		list_move_tail(entry, &dpm_active);
 
 		up(&dpm_list_sem);
 		if (!dev->power.prev_state.event)
@@ -97,8 +96,7 @@ void dpm_power_up(void)
 		struct device * dev = to_device(entry);
 
 		get_device(dev);
-		list_del_init(entry);
-		list_add_tail(entry, &dpm_active);
+		list_move_tail(entry, &dpm_active);
 		resume_device(dev);
 		put_device(dev);
 	}
Index: 2.6-git/drivers/base/power/suspend.c
===================================================================
--- 2.6-git.orig/drivers/base/power/suspend.c
+++ 2.6-git/drivers/base/power/suspend.c
@@ -101,12 +101,10 @@ int device_suspend(pm_message_t state)
 		/* Check if the device got removed */
 		if (!list_empty(&dev->power.entry)) {
 			/* Move it to the dpm_off or dpm_off_irq list */
-			if (!error) {
-				list_del(&dev->power.entry);
-				list_add(&dev->power.entry, &dpm_off);
-			} else if (error == -EAGAIN) {
-				list_del(&dev->power.entry);
-				list_add(&dev->power.entry, &dpm_off_irq);
+			if (!error)
+				list_move(&dev->power.entry, &dpm_off);
+			else if (error == -EAGAIN) {
+				list_move(&dev->power.entry, &dpm_off_irq);
 				error = 0;
 			}
 		}
@@ -124,8 +122,7 @@ int device_suspend(pm_message_t state)
 		 */
 		while (!list_empty(&dpm_off_irq)) {
 			struct list_head * entry = dpm_off_irq.next;
-			list_del(entry);
-			list_add(entry, &dpm_off);
+			list_move(entry, &dpm_off);
 		}
 		dpm_resume();
 	}

--
