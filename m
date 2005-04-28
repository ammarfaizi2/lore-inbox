Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVD1URX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVD1URX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 16:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVD1URX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 16:17:23 -0400
Received: from 146.Red-81-39-128.pooles.rima-tde.net ([81.39.128.146]:36932
	"EHLO genus.hue-bond.info") by vger.kernel.org with ESMTP
	id S262267AbVD1URE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 16:17:04 -0400
Date: Thu, 28 Apr 2005 22:17:02 +0200
From: David Serrano <dserrano5@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Tiny reordering of some fields of task_struct
Message-ID: <20050428201702.GA1992@genus.hue-bond.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Visit http://www.debian.org/
X-MSMail-Priority: High
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(First post & first patch so please be kind O:))

Playing with some things (I'm just beginning with this whole kernel stuff) I
found that there are three filesystem-related members in task_struct that
aren't together:

/* file system info */
	int link_count, total_link_count;
/* ipc stuff */
	struct sysv_sem sysvsem;
/* CPU-specific state of this task */
	struct thread_struct thread;
/* filesystem information */
	struct fs_struct *fs;

[...]

/* journalling filesystem info */
	void *journal_info;

Perhaps there is some reason to have them as they are now but if that's not
the case, this joins them together. It's against 2.6.12-rc3.

Signed-off-by: David Serrano <dserrano5@gmail.com>

--- linux-2.6.12-rc3/include/linux/sched.h.orig	2005-04-28 22:05:05.000000000 +0200
+++ linux-2.6.12-rc3/include/linux/sched.h	2005-04-28 22:05:07.000000000 +0200
@@ -616,14 +616,14 @@ struct task_struct {
 #endif
 	int oomkilladj; /* OOM kill score adjustment (bit shift). */
 	char comm[TASK_COMM_LEN];
-/* file system info */
+/* filesystem information */
 	int link_count, total_link_count;
+	struct fs_struct *fs;
+	void *journal_info;
 /* ipc stuff */
 	struct sysv_sem sysvsem;
 /* CPU-specific state of this task */
 	struct thread_struct thread;
-/* filesystem information */
-	struct fs_struct *fs;
 /* open file information */
 	struct files_struct *files;
 /* namespace */
@@ -654,9 +654,6 @@ struct task_struct {
 /* context-switch lock */
 	spinlock_t switch_lock;
 
-/* journalling filesystem info */
-	void *journal_info;
-
 /* VM state */
 	struct reclaim_state *reclaim_state;
 


-- 
 David Serrano
