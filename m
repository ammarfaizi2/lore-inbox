Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTH1CZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 22:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTH1CZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 22:25:38 -0400
Received: from [61.34.11.200] ([61.34.11.200]:3796 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S263424AbTH1CZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 22:25:36 -0400
Date: Thu, 28 Aug 2003 11:27:49 +0900
From: Tejun Huh <tejun@aratech.co.kr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] dcache statistics race in 2.4
Message-ID: <20030828022748.GA20792@atj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello,

 In fs/dcache.c, dentry_stat.nr_dentry is not protected by anything
and on a busy SMP machine, after a while, the count goes wild.  I'm
attaching a patch which puts nr_dentry accounting inside dcache_lock.
One spin_lock/unlock pair is added to d_alloc on NULL parent path but
I think NULL parent is used only occasionally when allocating root
dentry so this patch shouldn't cause any performance impact.

 If anything is wrong, please point out.  If there's no comment in a
few days, I'll submit this to Marcelo.

 TIA.

-- 
tejun

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1085  -> 1.1086 
#	         fs/dcache.c	1.24    -> 1.25   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/28	tj@atj.dyndns.org	1.1086
# - dentry_stat.nr_dentry race fix.
# --------------------------------------------
#
diff -Nru a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c	Thu Aug 28 11:07:51 2003
+++ b/fs/dcache.c	Thu Aug 28 11:07:51 2003
@@ -63,7 +63,6 @@
 	if (dname_external(dentry)) 
 		kfree(dentry->d_name.name);
 	kmem_cache_free(dentry_cache, dentry); 
-	dentry_stat.nr_dentry--;
 }
 
 /*
@@ -148,6 +147,7 @@
 kill_it: {
 		struct dentry *parent;
 		list_del(&dentry->d_child);
+		dentry_stat.nr_dentry--;
 		/* drops the lock, at that point nobody can reach this dentry */
 		dentry_iput(dentry);
 		parent = dentry->d_parent;
@@ -297,6 +297,7 @@
 
 	list_del_init(&dentry->d_hash);
 	list_del(&dentry->d_child);
+	dentry_stat.nr_dentry--;
 	dentry_iput(dentry);
 	parent = dentry->d_parent;
 	d_free(dentry);
@@ -625,11 +626,15 @@
 		dentry->d_sb = parent->d_sb;
 		spin_lock(&dcache_lock);
 		list_add(&dentry->d_child, &parent->d_subdirs);
+		dentry_stat.nr_dentry++;
 		spin_unlock(&dcache_lock);
-	} else
+	} else {
 		INIT_LIST_HEAD(&dentry->d_child);
+		spin_lock(&dcache_lock);
+		dentry_stat.nr_dentry++;
+		spin_unlock(&dcache_lock);
+	}
 
-	dentry_stat.nr_dentry++;
 	return dentry;
 }
 
