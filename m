Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267790AbTAHJsR>; Wed, 8 Jan 2003 04:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267791AbTAHJsR>; Wed, 8 Jan 2003 04:48:17 -0500
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:15109 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267790AbTAHJsM>; Wed, 8 Jan 2003 04:48:12 -0500
Date: Wed, 8 Jan 2003 09:56:23 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/10] dm: rwlock_t -> rw_semaphore (fluff)
Message-ID: <20030108095623.GE2063@reti>
References: <20030108095221.GA2063@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108095221.GA2063@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use a rw_semaphore in dm_target.c rather than a rwlock_t, just to keep
in line with dm.c
--- diff/drivers/md/dm-target.c	2003-01-02 11:16:16.000000000 +0000
+++ source/drivers/md/dm-target.c	2003-01-02 11:26:27.000000000 +0000
@@ -19,7 +19,7 @@
 };
 
 static LIST_HEAD(_targets);
-static rwlock_t _lock = RW_LOCK_UNLOCKED;
+static DECLARE_RWSEM(_lock);
 
 #define DM_MOD_NAME_SIZE 32
 
@@ -42,7 +42,7 @@
 {
 	struct tt_internal *ti;
 
-	read_lock(&_lock);
+	down_read(&_lock);
 
 	ti = __find_target_type(name);
 	if (ti) {
@@ -52,7 +52,7 @@
 			ti->use++;
 	}
 
-	read_unlock(&_lock);
+	up_read(&_lock);
 	return ti;
 }
 
@@ -86,13 +86,13 @@
 {
 	struct tt_internal *ti = (struct tt_internal *) t;
 
-	read_lock(&_lock);
+	down_read(&_lock);
 	if (--ti->use == 0)
 		module_put(ti->tt.module);
 
 	if (ti->use < 0)
 		BUG();
-	read_unlock(&_lock);
+	up_read(&_lock);
 
 	return;
 }
@@ -117,13 +117,13 @@
 	if (!ti)
 		return -ENOMEM;
 
-	write_lock(&_lock);
+	down_write(&_lock);
 	if (__find_target_type(t->name))
 		rv = -EEXIST;
 	else
 		list_add(&ti->list, &_targets);
 
-	write_unlock(&_lock);
+	up_write(&_lock);
 	return rv;
 }
 
@@ -131,21 +131,21 @@
 {
 	struct tt_internal *ti;
 
-	write_lock(&_lock);
+	down_write(&_lock);
 	if (!(ti = __find_target_type(t->name))) {
-		write_unlock(&_lock);
+		up_write(&_lock);
 		return -EINVAL;
 	}
 
 	if (ti->use) {
-		write_unlock(&_lock);
+		up_write(&_lock);
 		return -ETXTBSY;
 	}
 
 	list_del(&ti->list);
 	kfree(ti);
 
-	write_unlock(&_lock);
+	up_write(&_lock);
 	return 0;
 }
 
