Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267427AbTAQIbs>; Fri, 17 Jan 2003 03:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267429AbTAQIbs>; Fri, 17 Jan 2003 03:31:48 -0500
Received: from holomorphy.com ([66.224.33.161]:14741 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267427AbTAQIbr>;
	Fri, 17 Jan 2003 03:31:47 -0500
Date: Fri, 17 Jan 2003 00:40:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: remove will_become_orphaned_pgrp()
Message-ID: <20030117084037.GC940@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	akpm@zip.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

will_become_orphaned_pgrp()'s sole use is is_orphaned_pgrp(). Fold its
body into is_orphaned_pgrp(), rename __will_become_orphaned_pgrp(), and
adjust callers. Code shrinkage plus some relief from underscore-itis.


$ diffstat ~/patches/orphan-2.5.59 
 exit.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

===== kernel/exit.c 1.80 vs edited =====
--- 1.80/kernel/exit.c	Mon Jan 13 23:56:41 2003
+++ edited/kernel/exit.c	Fri Jan 17 00:28:18 2003
@@ -156,7 +156,7 @@
  *
  * "I ask you, have you ever known what it is to be an orphan?"
  */
-static int __will_become_orphaned_pgrp(int pgrp, task_t *ignored_task)
+static int will_become_orphaned_pgrp(int pgrp, task_t *ignored_task)
 {
 	struct task_struct *p;
 	struct list_head *l;
@@ -177,22 +177,17 @@
 	return ret;	/* (sighing) "Often!" */
 }
 
-static int will_become_orphaned_pgrp(int pgrp, struct task_struct * ignored_task)
+int is_orphaned_pgrp(int pgrp)
 {
 	int retval;
 
 	read_lock(&tasklist_lock);
-	retval = __will_become_orphaned_pgrp(pgrp, ignored_task);
+	retval = will_become_orphaned_pgrp(pgrp, NULL);
 	read_unlock(&tasklist_lock);
 
 	return retval;
 }
 
-int is_orphaned_pgrp(int pgrp)
-{
-	return will_become_orphaned_pgrp(pgrp, 0);
-}
-
 static inline int has_stopped_jobs(int pgrp)
 {
 	int retval = 0;
@@ -495,7 +490,7 @@
 	    (p->session == father->session)) {
 		int pgrp = p->pgrp;
 
-		if (__will_become_orphaned_pgrp(pgrp, 0) && has_stopped_jobs(pgrp)) {
+		if (will_become_orphaned_pgrp(pgrp, NULL) && has_stopped_jobs(pgrp)) {
 			__kill_pg_info(SIGHUP, (void *)1, pgrp);
 			__kill_pg_info(SIGCONT, (void *)1, pgrp);
 		}
@@ -579,7 +574,7 @@
 	
 	if ((t->pgrp != current->pgrp) &&
 	    (t->session == current->session) &&
-	    __will_become_orphaned_pgrp(current->pgrp, current) &&
+	    will_become_orphaned_pgrp(current->pgrp, current) &&
 	    has_stopped_jobs(current->pgrp)) {
 		__kill_pg_info(SIGHUP, (void *)1, current->pgrp);
 		__kill_pg_info(SIGCONT, (void *)1, current->pgrp);
