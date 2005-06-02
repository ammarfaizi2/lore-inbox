Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVFBIB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVFBIB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 04:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVFBIA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 04:00:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5831 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261165AbVFBH6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:58:35 -0400
Date: Thu, 2 Jun 2005 16:02:54 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 5/9] dlm: timer can't be global
Message-ID: <20050602080254.GE21570@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="global-recovery-timer.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The dlm_recoverd thread for each lockspace uses a recovery timer, so that
timer must be per-lockspace, not global.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/dlm_internal.h
===================================================================
--- linux.orig/drivers/dlm/dlm_internal.h	2005-06-02 12:28:30.000000000 +0800
+++ linux/drivers/dlm/dlm_internal.h	2005-06-02 13:04:51.696074128 +0800
@@ -477,6 +477,7 @@
 
 	/* recovery related */
 
+	struct timer_list	ls_timer;
 	wait_queue_head_t	ls_wait_member;
 	struct task_struct	*ls_recoverd_task;
 	struct semaphore	ls_recoverd_active;
Index: linux/drivers/dlm/recover.c
===================================================================
--- linux.orig/drivers/dlm/recover.c	2005-06-02 12:28:30.000000000 +0800
+++ linux/drivers/dlm/recover.c	2005-06-02 13:04:00.372876440 +0800
@@ -22,8 +22,6 @@
 #include "lowcomms.h"
 #include "member.h"
 
-static struct timer_list dlm_timer;
-
 
 /*
  * Recovery waiting routines: these functions wait for a particular reply from
@@ -50,7 +48,7 @@
 static void dlm_wait_timer_fn(unsigned long data)
 {
 	struct dlm_ls *ls = (struct dlm_ls *) data;
-	mod_timer(&dlm_timer, jiffies + (dlm_config.recover_timer * HZ));
+	mod_timer(&ls->ls_timer, jiffies + (dlm_config.recover_timer * HZ));
 	wake_up(&ls->ls_wait_general);
 }
 
@@ -58,14 +56,14 @@
 {
 	int error = 0;
 
-	init_timer(&dlm_timer);
-	dlm_timer.function = dlm_wait_timer_fn;
-	dlm_timer.data = (long) ls;
-	dlm_timer.expires = jiffies + (dlm_config.recover_timer * HZ);
-	add_timer(&dlm_timer);
+	init_timer(&ls->ls_timer);
+	ls->ls_timer.function = dlm_wait_timer_fn;
+	ls->ls_timer.data = (long) ls;
+	ls->ls_timer.expires = jiffies + (dlm_config.recover_timer * HZ);
+	add_timer(&ls->ls_timer);
 
 	wait_event(ls->ls_wait_general, testfn(ls) || dlm_recovery_stopped(ls));
-	del_timer_sync(&dlm_timer);
+	del_timer_sync(&ls->ls_timer);
 
 	if (dlm_recovery_stopped(ls))
 		error = -EINTR;

--

