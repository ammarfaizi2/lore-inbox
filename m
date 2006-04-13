Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWDMSTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWDMSTd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWDMSTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:19:33 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:36504 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932444AbWDMSTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:19:32 -0400
Message-Id: <200604131720.k3DHKOTe004697@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [RFC] PATCH 2/4 - Time virtualization : unshare support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Apr 2006 13:20:20 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add time namespace support to unshare, controlled by CLONE_TIME.

Index: linux-2.6.17-mm-vtime/include/linux/sched.h
===================================================================
--- linux-2.6.17-mm-vtime.orig/include/linux/sched.h	2006-04-13 13:48:32.000000000 -0400
+++ linux-2.6.17-mm-vtime/include/linux/sched.h	2006-04-13 13:49:11.000000000 -0400
@@ -65,6 +65,7 @@ struct bio;
 #define CLONE_UNTRACED		0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
 #define CLONE_CHILD_SETTID	0x01000000	/* set the TID in the child */
 #define CLONE_STOPPED		0x02000000	/* Start in stopped state */
+#define CLONE_TIME		0x04000000	/* Make a new time namespace */
 
 /*
  * List of flags we want to share for kernel threads,
Index: linux-2.6.17-mm-vtime/kernel/fork.c
===================================================================
--- linux-2.6.17-mm-vtime.orig/kernel/fork.c	2006-04-13 13:48:02.000000000 -0400
+++ linux-2.6.17-mm-vtime/kernel/fork.c	2006-04-13 13:49:11.000000000 -0400
@@ -1563,6 +1563,25 @@ static int unshare_semundo(unsigned long
 	return 0;
 }
 
+static int unshare_time(unsigned long unshare_flags, struct time_ns **new)
+{
+	if(unshare_flags & CLONE_TIME){
+		*new = kmalloc(sizeof(struct time_ns), GFP_KERNEL);
+		if(*new == NULL)
+			return -ENOMEM;
+		atomic_set(&(*new)->counter, 1);
+		(*new)->offset = 0;
+	}
+
+	return 0;
+}
+
+static void put_time_ns(struct time_ns *time)
+{
+	if(atomic_sub_and_test(1, &time->counter))
+		kfree(time);
+}
+
 /*
  * unshare allows a process to 'unshare' part of the process
  * context which was originally shared using clone.  copy_*
@@ -1580,6 +1599,7 @@ asmlinkage long sys_unshare(unsigned lon
 	struct mm_struct *mm, *new_mm = NULL, *active_mm = NULL;
 	struct files_struct *fd, *new_fd = NULL;
 	struct sem_undo_list *new_ulist = NULL;
+	struct time_ns *time, *new_time = NULL;
 
 	check_unshare_flags(&unshare_flags);
 
@@ -1603,8 +1623,11 @@ asmlinkage long sys_unshare(unsigned lon
 		goto bad_unshare_cleanup_vm;
 	if ((err = unshare_semundo(unshare_flags, &new_ulist)))
 		goto bad_unshare_cleanup_fd;
+	if ((err = unshare_time(unshare_flags, &new_time)))
+		goto bad_unshare_cleanup_fd;
 
-	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist) {
+	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist ||
+		new_time) {
 
 		task_lock(current);
 
@@ -1641,9 +1664,18 @@ asmlinkage long sys_unshare(unsigned lon
 			new_fd = fd;
 		}
 
+		if(new_time) {
+			time = current->time_ns;
+			current->time_ns = new_time;
+			new_time = time;
+		}
+
 		task_unlock(current);
 	}
 
+	if (new_time)
+		put_time_ns(new_time);
+
 bad_unshare_cleanup_fd:
 	if (new_fd)
 		put_files_struct(new_fd);

