Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317535AbSFRSQo>; Tue, 18 Jun 2002 14:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317536AbSFRSQn>; Tue, 18 Jun 2002 14:16:43 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:14086 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317535AbSFRSQk>;
	Tue, 18 Jun 2002 14:16:40 -0400
Date: Tue, 18 Jun 2002 14:07:51 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.22 : fs/intermezzo/vfs.c
Message-ID: <Pine.LNX.4.44.0206181405200.1977-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch addresses a name change (i_zombie --> i_sem) within 
struct inode, which affects fs/intermezzo/vfs.c Please review for 
inclusion.

Regards,
Frank

--- fs/intermezzo/vfs.c.old	Tue Jun 18 14:02:50 2002
+++ fs/intermezzo/vfs.c	Tue Jun 18 14:02:41 2002
@@ -407,11 +407,11 @@
         mode &= S_IALLUGO;
         mode |= S_IFREG;
 
-        down(&dir->d_inode->i_zombie);
+        down(&dir->d_inode->i_sem);
 	error = presto_reserve_space(fset->fset_cache, PRESTO_REQHIGH); 
 	if (error) {
 		EXIT;
-        	up(&dir->d_inode->i_zombie);
+        	up(&dir->d_inode->i_sem);
 		return error;
 	}
 
@@ -495,7 +495,7 @@
         presto_trans_commit(fset, handle);
  exit_pre_lock:
 	presto_release_space(fset->fset_cache, PRESTO_REQHIGH); 
-        up(&dir->d_inode->i_zombie);
+        up(&dir->d_inode->i_sem);
         return error;
 }
 
@@ -583,11 +583,11 @@
         struct presto_version new_link_ver;
         void *handle;
 
-        down(&dir->d_inode->i_zombie);
+        down(&dir->d_inode->i_sem);
 	error = presto_reserve_space(fset->fset_cache, PRESTO_REQHIGH); 
 	if (error) {
 		EXIT;
-        	up(&dir->d_inode->i_zombie);
+        	up(&dir->d_inode->i_sem);
 		return error;
 	}
         error = -ENOENT;
@@ -662,7 +662,7 @@
         presto_trans_commit(fset, handle);
 exit_lock:
 	presto_release_space(fset->fset_cache, PRESTO_REQHIGH); 
-        up(&dir->d_inode->i_zombie);
+        up(&dir->d_inode->i_sem);
         return error;
 }
 
@@ -728,11 +728,11 @@
         int do_kml = 0, do_expect =0;
 	int linkno = 0;
         ENTRY;
-        down(&dir->d_inode->i_zombie);
+        down(&dir->d_inode->i_sem);
         error = may_delete(dir->d_inode, dentry, 0);
         if (error) {
                 EXIT;
-                up(&dir->d_inode->i_zombie);
+                up(&dir->d_inode->i_sem);
                 return error;
         }
 
@@ -740,14 +740,14 @@
         iops = filter_c2cdiops(fset->fset_cache->cache_filter);
         if (!iops->unlink) {
                 EXIT;
-                up(&dir->d_inode->i_zombie);
+                up(&dir->d_inode->i_sem);
                 return error;
         }
 
 	error = presto_reserve_space(fset->fset_cache, PRESTO_REQLOW); 
 	if (error) {
 		EXIT;
-        	up(&dir->d_inode->i_zombie);
+        	up(&dir->d_inode->i_sem);
 		return error;
 	}
 
@@ -757,7 +757,7 @@
         if ( IS_ERR(handle) ) {
 		presto_release_space(fset->fset_cache, PRESTO_REQLOW); 
                 printk("ERROR: presto_do_unlink: no space for transaction. Tell Peter.\n");
-                up(&dir->d_inode->i_zombie);
+                up(&dir->d_inode->i_sem);
                 return -ENOSPC;
         }
         DQUOT_INIT(dir->d_inode);
@@ -792,7 +792,7 @@
                 goto exit;
         }
 
-        up(&dir->d_inode->i_zombie);
+        up(&dir->d_inode->i_sem);
         if (error) {
                 EXIT;
                 goto exit;
@@ -882,12 +882,12 @@
         void *handle;
 
         ENTRY;
-        down(&dir->d_inode->i_zombie);
+        down(&dir->d_inode->i_sem);
 	/* record + max path len + space to free */ 
 	error = presto_reserve_space(fset->fset_cache, PRESTO_REQHIGH + 4096); 
 	if (error) {
 		EXIT;
-        	up(&dir->d_inode->i_zombie);
+        	up(&dir->d_inode->i_sem);
 		return error;
 	}
 
@@ -965,7 +965,7 @@
         presto_trans_commit(fset, handle);
  exit_lock:
 	presto_release_space(fset->fset_cache, PRESTO_REQHIGH + 4096); 
-        up(&dir->d_inode->i_zombie);
+        up(&dir->d_inode->i_sem);
         return error;
 }
 
@@ -1043,12 +1043,12 @@
         void *handle;
 
         ENTRY;
-        down(&dir->d_inode->i_zombie);
+        down(&dir->d_inode->i_sem);
 	/* one journal record + directory block + room for removals*/ 
 	error = presto_reserve_space(fset->fset_cache, PRESTO_REQHIGH + 4096); 
 	if (error) { 
                 EXIT;
-        	up(&dir->d_inode->i_zombie);
+        	up(&dir->d_inode->i_sem);
                 return error;
         }
 
@@ -1129,7 +1129,7 @@
         presto_trans_commit(fset, handle);
  exit_lock:
 	presto_release_space(fset->fset_cache, PRESTO_REQHIGH + 4096); 
-        up(&dir->d_inode->i_zombie);
+        up(&dir->d_inode->i_sem);
         return error;
 }
 
@@ -1241,7 +1241,7 @@
         do_kml = presto_do_kml(info, dir->d_inode);
         do_expect = presto_do_expect(info, dir->d_inode);
 
-        double_down(&dir->d_inode->i_zombie, &dentry->d_inode->i_zombie);
+        double_down(&dir->d_inode->i_sem, &dentry->d_inode->i_sem);
         d_unhash(dentry);
         if (IS_DEADDIR(dir->d_inode))
                 error = -ENOENT;
@@ -1257,7 +1257,7 @@
 					       ATTR_CTIME | ATTR_MTIME);
 		}
         }
-        double_up(&dir->d_inode->i_zombie, &dentry->d_inode->i_zombie);
+        double_up(&dir->d_inode->i_sem, &dentry->d_inode->i_sem);
         if (!error)
                 d_delete(dentry);
         dput(dentry);
@@ -1343,12 +1343,12 @@
 
         ENTRY;
 
-        down(&dir->d_inode->i_zombie);
+        down(&dir->d_inode->i_sem);
 	/* one KML entry */ 
 	error = presto_reserve_space(fset->fset_cache, PRESTO_REQHIGH); 
 	if (error) {
 		EXIT;
-        	up(&dir->d_inode->i_zombie);
+        	up(&dir->d_inode->i_sem);
 		return error;
 	}
 
@@ -1429,7 +1429,7 @@
         unlock_kernel();
  exit_lock:
 	presto_release_space(fset->fset_cache, PRESTO_REQHIGH); 
-        up(&dir->d_inode->i_zombie);
+        up(&dir->d_inode->i_sem);
         return error;
 }
 
@@ -1624,13 +1624,13 @@
                 goto out_unlock;
         target = new_dentry->d_inode;
         if (target) { /* Hastur! Hastur! Hastur! */
-                triple_down(&old_dir->i_zombie,
-                            &new_dir->i_zombie,
-                            &target->i_zombie);
+                triple_down(&old_dir->i_sem,
+                            &new_dir->i_sem,
+                            &target->i_sem);
                 d_unhash(new_dentry);
         } else
-                double_down(&old_dir->i_zombie,
-                            &new_dir->i_zombie);
+                double_down(&old_dir->i_sem,
+                            &new_dir->i_sem);
         if (IS_DEADDIR(old_dir)||IS_DEADDIR(new_dir))
                 error = -ENOENT;
         else if (d_mountpoint(old_dentry)||d_mountpoint(new_dentry))
@@ -1641,15 +1641,15 @@
         if (target) {
                 if (!error)
                         target->i_flags |= S_DEAD;
-                triple_up(&old_dir->i_zombie,
-                          &new_dir->i_zombie,
-                          &target->i_zombie);
+                triple_up(&old_dir->i_sem,
+                          &new_dir->i_sem,
+                          &target->i_sem);
                 if (d_unhashed(new_dentry))
                         d_rehash(new_dentry);
                 dput(new_dentry);
         } else
-                double_up(&old_dir->i_zombie,
-                          &new_dir->i_zombie);
+                double_up(&old_dir->i_sem,
+                          &new_dir->i_sem);
                 
         if (!error)
                 d_move(old_dentry,new_dentry);
@@ -1689,13 +1689,13 @@
 
         DQUOT_INIT(old_dir);
         DQUOT_INIT(new_dir);
-        double_down(&old_dir->i_zombie, &new_dir->i_zombie);
+        double_down(&old_dir->i_sem, &new_dir->i_sem);
         if (d_mountpoint(old_dentry)||d_mountpoint(new_dentry))
                 error = -EBUSY;
         else
                 error = do_rename(fset, old_parent, old_dentry,
                                          new_parent, new_dentry, info);
-        double_up(&old_dir->i_zombie, &new_dir->i_zombie);
+        double_up(&old_dir->i_sem, &new_dir->i_sem);
         if (error)
                 return error;
         /* The following d_move() should become unconditional */

