Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSL2Vvz>; Sun, 29 Dec 2002 16:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbSL2Vvz>; Sun, 29 Dec 2002 16:51:55 -0500
Received: from verein.lst.de ([212.34.181.86]:37899 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261907AbSL2Vvv>;
	Sun, 29 Dec 2002 16:51:51 -0500
Date: Sun, 29 Dec 2002 23:00:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] avoid deprecated module functions in core code
Message-ID: <20021229230011.A12151@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A first start at removing them from kernel/*.c and fs/*.c.

Note that module_put is fine for a NULL argument.


--- 1.119/fs/block_dev.c	Sun Dec 15 18:49:04 2002
+++ edited/fs/block_dev.c	Sun Dec 29 21:50:13 2002
@@ -623,8 +623,7 @@
 		}
 	} else {
 		put_disk(disk);
-		if (owner)
-			__MOD_DEC_USE_COUNT(owner);
+		module_put(owner);
 		if (bdev->bd_contains == bdev) {
 			if (bdev->bd_disk->fops->open) {
 				ret = bdev->bd_disk->fops->open(inode, file);
@@ -651,8 +650,7 @@
 		blkdev_put(bdev->bd_contains, BDEV_RAW);
 	bdev->bd_contains = NULL;
 	put_disk(disk);
-	if (owner)
-		__MOD_DEC_USE_COUNT(owner);
+	module_put(owner);
 out:
 	up(&bdev->bd_sem);
 	unlock_kernel();
@@ -723,9 +721,10 @@
 	}
 	if (!bdev->bd_openers) {
 		struct module *owner = disk->fops->owner;
+
 		put_disk(disk);
-		if (owner)
-			__MOD_DEC_USE_COUNT(owner);
+		module_put(owner);
+
 		bdev->bd_disk = NULL;
 		bdev->bd_inode->i_data.backing_dev_info = &default_backing_dev_info;
 		if (bdev != bdev->bd_contains) {
===== fs/dquot.c 1.52 vs edited =====
--- 1.52/fs/dquot.c	Wed Nov 27 18:11:14 2002
+++ edited/fs/dquot.c	Sun Dec 29 21:33:57 2002
@@ -111,8 +111,7 @@
 
 static void put_quota_format(struct quota_format_type *fmt)
 {
-	if (fmt->qf_owner)
-		__MOD_DEC_USE_COUNT(fmt->qf_owner);
+	module_put(fmt->qf_owner);
 }
 
 /*
===== fs/exec.c 1.58 vs edited =====
--- 1.58/fs/exec.c	Sun Dec 15 06:07:04 2002
+++ edited/fs/exec.c	Sun Dec 29 21:34:51 2002
@@ -102,8 +102,7 @@
 
 static inline void put_binfmt(struct linux_binfmt * fmt)
 {
-	if (fmt->module)
-		__MOD_DEC_USE_COUNT(fmt->module);
+	module_put(fmt->module);
 }
 
 /*
@@ -1111,11 +1110,11 @@
 void set_binfmt(struct linux_binfmt *new)
 {
 	struct linux_binfmt *old = current->binfmt;
-	if (new && new->module)
+	if (new)
 		__MOD_INC_USE_COUNT(new->module);
 	current->binfmt = new;
-	if (old && old->module)
-		__MOD_DEC_USE_COUNT(old->module);
+	if (old)
+		module_put(old->module);
 }
 
 #define CORENAME_MAX_SIZE 64
--- 1.76/kernel/exit.c	Mon Dec  2 08:44:31 2002
+++ edited/kernel/exit.c	Sun Dec 29 21:30:04 2002
@@ -665,8 +665,8 @@
 		disassociate_ctty(1);
 
 	put_exec_domain(tsk->thread_info->exec_domain);
-	if (tsk->binfmt && tsk->binfmt->module)
-		__MOD_DEC_USE_COUNT(tsk->binfmt->module);
+	if (tsk->binfmt)
+		module_put(tsk->binfmt);
 
 	tsk->exit_code = code;
 	exit_notify();
===== kernel/fork.c 1.93 vs edited =====
--- 1.93/kernel/fork.c	Sat Dec 14 12:42:12 2002
+++ edited/kernel/fork.c	Sun Dec 29 21:31:39 2002
@@ -745,8 +745,8 @@
 	
 	get_exec_domain(p->thread_info->exec_domain);
 
-	if (p->binfmt && p->binfmt->module)
-		__MOD_INC_USE_COUNT(p->binfmt->module);
+	if (p->binfmt && !try_module_get(p->binfmt))
+		goto bad_fork_cleanup_put;
 
 #ifdef CONFIG_PREEMPT
 	/*
@@ -958,9 +958,10 @@
 bad_fork_cleanup:
 	if (p->pid > 0)
 		free_pidmap(p->pid);
+	if (p->binfmt)
+		module_put(p->binfmt);
+bad_fork_cleanup_put:
 	put_exec_domain(p->thread_info->exec_domain);
-	if (p->binfmt && p->binfmt->module)
-		__MOD_DEC_USE_COUNT(p->binfmt->module);
 bad_fork_cleanup_count:
 	atomic_dec(&p->user->processes);
 	free_uid(p->user);
===== kernel/intermodule.c 1.1 vs edited =====
--- 1.1/kernel/intermodule.c	Fri Nov  8 23:08:33 2002
+++ edited/kernel/intermodule.c	Sun Dec 29 21:32:41 2002
@@ -166,7 +166,7 @@
 		ime = list_entry(tmp, struct inter_module_entry, list);
 		if (strcmp(ime->im_name, im_name) == 0) {
 			if (ime->owner)
-				__MOD_DEC_USE_COUNT(ime->owner);
+				module_put(ime->owner);
 			spin_unlock(&ime_lock);
 			return;
 		}
