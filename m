Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTDNIpv (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 04:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbTDNIpv (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 04:45:51 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:22427 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262868AbTDNIpt (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 04:45:49 -0400
Date: Mon, 14 Apr 2003 14:44:17 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [patch] dentry_stat fix
Message-ID: <20030414144417.A27092@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Andrew,

This patch the corrects the dentry_stat.nr_unused calculation.

In select_parent() and shrink_dcache_anon() we were not doing 
any adjustments to the nr_unused count after manipulating the dentry_unused 
list. Now the nr_unused count is decremented if the dentry is on dentry_unused
list and is removed from there. 

Further in the same routines, we have to adjust the nr_unused count 
again if the dentry is moved to the end of d_lru list for pruning.


Regards,
Maneesh


diff -urN linux-2.5.67-base/fs/dcache.c linux-2.5.67-dentry_stat/fs/dcache.c
--- linux-2.5.67-base/fs/dcache.c	Mon Apr  7 23:00:42 2003
+++ linux-2.5.67-dentry_stat/fs/dcache.c	Fri Apr 11 15:53:53 2003
@@ -538,13 +538,18 @@
 		struct list_head *tmp = next;
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
 		next = tmp->next;
-		list_del_init(&dentry->d_lru);
 
-		/* don't add non zero d_count dentries 
-		 * back to d_lru list
+		if (!list_empty(&dentry->d_lru)) {
+			dentry_stat.nr_unused--;
+			list_del_init(&dentry->d_lru);
+		}
+		/* 
+		 * move only zero ref count dentries to the end 
+		 * of the unused list for prune_dcache
 		 */
 		if (!atomic_read(&dentry->d_count)) {
 			list_add(&dentry->d_lru, dentry_unused.prev);
+			dentry_stat.nr_unused++;
 			found++;
 		}
 		/*
@@ -609,13 +614,18 @@
 		spin_lock(&dcache_lock);
 		hlist_for_each(lp, head) {
 			struct dentry *this = hlist_entry(lp, struct dentry, d_hash);
-			list_del(&this->d_lru);
+			if (!list_empty(&this->d_lru)) {
+				dentry_stat.nr_unused--;
+				list_del(&this->d_lru);
+			}
 
-			/* don't add non zero d_count dentries 
-			 * back to d_lru list
+			/* 
+			 * move only zero ref count dentries to the end 
+			 * of the unused list for prune_dcache
 			 */
 			if (!atomic_read(&this->d_count)) {
 				list_add_tail(&this->d_lru, &dentry_unused);
+				dentry_stat.nr_unused++;
 				found++;
 			}
 		}

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
