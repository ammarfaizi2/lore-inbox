Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbWEKC0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWEKC0y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 22:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWEKC0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 22:26:54 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:21635 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S965056AbWEKC0y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 22:26:54 -0400
Date: Wed, 10 May 2006 19:29:38 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.16.16
Message-ID: <20060511022938.GF25010@moss.sous-sol.org>
References: <20060511022547.GE25010@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060511022547.GE25010@moss.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index cdd3ce7..b93f75f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .15
+EXTRAVERSION = .16
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/fs/locks.c b/fs/locks.c
index e75ac39..aa7f660 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -432,15 +432,14 @@ static struct lock_manager_operations le
  */
 static int lease_init(struct file *filp, int type, struct file_lock *fl)
  {
+	if (assign_type(fl, type) != 0)
+		return -EINVAL;
+
 	fl->fl_owner = current->files;
 	fl->fl_pid = current->tgid;
 
 	fl->fl_file = filp;
 	fl->fl_flags = FL_LEASE;
-	if (assign_type(fl, type) != 0) {
-		locks_free_lock(fl);
-		return -EINVAL;
-	}
 	fl->fl_start = 0;
 	fl->fl_end = OFFSET_MAX;
 	fl->fl_ops = NULL;
@@ -452,16 +451,19 @@ static int lease_init(struct file *filp,
 static int lease_alloc(struct file *filp, int type, struct file_lock **flp)
 {
 	struct file_lock *fl = locks_alloc_lock();
-	int error;
+	int error = -ENOMEM;
 
 	if (fl == NULL)
-		return -ENOMEM;
+		goto out;
 
 	error = lease_init(filp, type, fl);
-	if (error)
-		return error;
+	if (error) {
+		locks_free_lock(fl);
+		fl = NULL;
+	}
+out:
 	*flp = fl;
-	return 0;
+	return error;
 }
 
 /* Check if two locks overlap each other.
@@ -1337,6 +1339,7 @@ static int __setlease(struct file *filp,
 		goto out;
 
 	if (my_before != NULL) {
+		*flp = *my_before;
 		error = lease->fl_lmops->fl_change(my_before, arg);
 		goto out;
 	}
