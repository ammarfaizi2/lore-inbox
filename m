Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWATUgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWATUgs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWATUgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:36:48 -0500
Received: from ns1.suse.de ([195.135.220.2]:56450 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932175AbWATUgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:36:47 -0500
Date: Fri, 20 Jan 2006 21:36:45 +0100
From: Jan Blunck <jblunck@suse.de>
To: viro@zeniv.linux.org.uk
Cc: dev@sw.ru, linux-kernel@vger.kernel.org
Subject: [PATCH] shrink_dcache_parent() races against shrink_dcache_memory()
Message-ID: <20060120203645.GF24401@hasse.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Kirill Korotaev <dev@sw.ru> discovered a race between shrink_dcache_parent()
and shrink_dcache_memory(). That one is based on dput() is calling
dentry_iput() too early and therefore is giving up the dcache_lock. This leads
to the situation that the parent dentry might be still referenced although all
childs are already dead. This parent is ignore by a concurrent select_parent()
call which might be the reason for busy inode after umount failures.

This is from Kirill's original patch:

CPU 1                    CPU 2
~~~~~                    ~~~~~
umount /dev/sda1
generic_shutdown_super   shrink_dcache_memory
shrink_dcache_parent     prune_one_dentry
select_parent            dput     <<<< child is dead, locks are released,
                                       but parent is still referenced!!! >>>>
skip dentry->parent,
since it's d_count > 0

message: BUSY inodes after umount...
                                  <<< parent is left on dentry_unused list,
                                      referencing freed super block >>>

This patch is introducing dput_locked() which is doing all the dput work
except of freeing up the dentry's inode and memory itself. Therefore, when the
dcache_lock is given up, all the reference counts of the parents are correct.
prune_one_dentry() must also use the dput_locked version and free up the
inodes and the memory of the parents later. Otherwise we have an incorrect
reference count on the parents of the dentry to prune.

Signed-off-by: Jan Blunck <jblunck@suse.de>
---

--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dput-late_iput.diff"

 fs/dcache.c |   76 ++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 22 deletions(-)

Index: linux-2.6/fs/dcache.c
===================================================================
--- linux-2.6.orig/fs/dcache.c
+++ linux-2.6/fs/dcache.c
@@ -143,21 +143,18 @@ static void dentry_iput(struct dentry * 
  * no dcache lock, please.
  */
 
-void dput(struct dentry *dentry)
+static void dput_locked(struct dentry *dentry, struct list_head *list)
 {
 	if (!dentry)
 		return;
 
-repeat:
-	if (atomic_read(&dentry->d_count) == 1)
-		might_sleep();
-	if (!atomic_dec_and_lock(&dentry->d_count, &dcache_lock))
+	if (!atomic_dec_and_test(&dentry->d_count))
 		return;
 
+repeat:
 	spin_lock(&dentry->d_lock);
 	if (atomic_read(&dentry->d_count)) {
 		spin_unlock(&dentry->d_lock);
-		spin_unlock(&dcache_lock);
 		return;
 	}
 
@@ -177,32 +174,54 @@ repeat:
   		dentry_stat.nr_unused++;
   	}
  	spin_unlock(&dentry->d_lock);
-	spin_unlock(&dcache_lock);
 	return;
 
 unhash_it:
 	__d_drop(dentry);
 
 kill_it: {
-		struct dentry *parent;
-
 		/* If dentry was on d_lru list
 		 * delete it from there
 		 */
   		if (!list_empty(&dentry->d_lru)) {
-  			list_del(&dentry->d_lru);
+  			list_del_init(&dentry->d_lru);
   			dentry_stat.nr_unused--;
   		}
   		list_del(&dentry->d_u.d_child);
 		dentry_stat.nr_dentry--;	/* For d_free, below */
-		/*drops the locks, at that point nobody can reach this dentry */
-		dentry_iput(dentry);
-		parent = dentry->d_parent;
-		d_free(dentry);
-		if (dentry == parent)
+		/* at this point nobody can reach this dentry */
+		list_add(&dentry->d_lru, list);
+		spin_unlock(&dentry->d_lock);
+		if (dentry == dentry->d_parent)
 			return;
-		dentry = parent;
-		goto repeat;
+		dentry = dentry->d_parent;
+		if (atomic_dec_and_test(&dentry->d_count))
+			goto repeat;
+		/* out */
+	}
+}
+
+void dput(struct dentry *dentry)
+{
+	LIST_HEAD(free_list);
+
+	if (!dentry)
+		return;
+
+	if (atomic_add_unless(&dentry->d_count, -1, 1))
+		return;
+
+	spin_lock(&dcache_lock);
+	dput_locked(dentry, &free_list);
+	spin_unlock(&dcache_lock);
+
+	if (!list_empty(&free_list)) {
+		struct dentry *dentry, *p;
+		list_for_each_entry_safe(dentry, p, &free_list, d_lru) {
+			list_del(&dentry->d_lru);
+			dentry_iput(dentry);
+			d_free(dentry);
+		}
 	}
 }
 
@@ -364,16 +383,29 @@ restart:
  */
 static inline void prune_one_dentry(struct dentry * dentry)
 {
-	struct dentry * parent;
+	LIST_HEAD(free_list);
 
 	__d_drop(dentry);
 	list_del(&dentry->d_u.d_child);
 	dentry_stat.nr_dentry--;	/* For d_free, below */
-	dentry_iput(dentry);
-	parent = dentry->d_parent;
+
+	/* dput the parent here before we release dcache_lock */
+	if (dentry != dentry->d_parent)
+		dput_locked(dentry->d_parent, &free_list);
+
+	dentry_iput(dentry);		/* drop locks */
 	d_free(dentry);
-	if (parent != dentry)
-		dput(parent);
+
+	if (!list_empty(&free_list)) {
+		struct dentry *tmp, *p;
+
+		list_for_each_entry_safe(tmp, p, &free_list, d_lru) {
+			list_del(&tmp->d_lru);
+			dentry_iput(tmp);
+			d_free(tmp);
+		}
+	}
+
 	spin_lock(&dcache_lock);
 }
 

--0lnxQi9hkpPO77W3--
