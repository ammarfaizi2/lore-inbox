Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262019AbSI3LGd>; Mon, 30 Sep 2002 07:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262022AbSI3LGd>; Mon, 30 Sep 2002 07:06:33 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:3534 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262019AbSI3LG3>;
	Mon, 30 Sep 2002 07:06:29 -0400
Date: Mon, 30 Sep 2002 16:47:38 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.39-mm1 fixes 3/3
Message-ID: <20020930164738.C27121@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020930164314.A27121@in.ibm.com> <20020930164547.B27121@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020930164547.B27121@in.ibm.com>; from dipankar@in.ibm.com on Mon, Sep 30, 2002 at 04:45:47PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The dcache_rcu patch should use the RCU list macros which make sure
of the barrier requirements. Fix against 2.5.39-mm1.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.


--- fs/dcache.c.orig	Mon Sep 30 14:00:40 2002
+++ fs/dcache.c	Mon Sep 30 14:05:33 2002
@@ -869,14 +869,8 @@
 	struct dentry *found = NULL;
 
 	rcu_read_lock();
-	tmp = head->next;
-	for (;;) {
-		struct dentry * dentry;
-		read_barrier_depends();
-	       	dentry = list_entry(tmp, struct dentry, d_hash);
-		if (tmp == head)
-			break;
-		tmp = tmp->next;
+	list_for_each_rcu(tmp, head) {
+		struct dentry * dentry = list_entry(tmp, struct dentry, d_hash);
 		if (dentry->d_name.hash != hash)
 			continue;
 		if (dentry->d_parent != parent)
@@ -999,7 +993,7 @@
 	struct list_head *list = d_hash(entry->d_parent, entry->d_name.hash);
 	spin_lock(&dcache_lock);
 	if (!list_empty(&entry->d_hash) && !d_unhashed(entry)) BUG();
-	list_add(&entry->d_hash, list);
+	list_add_rcu(&entry->d_hash, list);
 	entry->d_vfs_flags &= ~DCACHE_UNHASHED;
 	spin_unlock(&dcache_lock);
 }
