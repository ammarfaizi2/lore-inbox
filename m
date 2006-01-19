Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422645AbWASVbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbWASVbV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWASVbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:31:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16833 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422645AbWASVbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:31:20 -0500
Date: Thu, 19 Jan 2006 15:30:50 -0600
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] dlm: fix unlock race
Message-ID: <20060119213050.GC31387@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a race where an attempt to unlock a lock in the completion AST routine
could crash on SMP.

Signed-off-by: Patrick Caulfield <pcaulfie@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/device.c
===================================================================
--- linux.orig/drivers/dlm/device.c
+++ linux/drivers/dlm/device.c
@@ -53,6 +53,7 @@ static rwlock_t lockinfo_lock;
 #define LI_FLAG_COMPLETE   1
 #define LI_FLAG_FIRSTLOCK  2
 #define LI_FLAG_PERSISTENT 3
+#define LI_FLAG_ONLIST     4
 
 /* flags in ls_flags*/
 #define LS_FLAG_DELETED   1
@@ -382,6 +383,7 @@ static void ast_routine(void *param)
 
 			spin_lock(&li->li_file->fi_li_lock);
 			list_del(&li->li_ownerqueue);
+			clear_bit(LI_FLAG_ONLIST, &li->li_flags);
 			spin_unlock(&li->li_file->fi_li_lock);
 			release_lockinfo(li);
 			return;
@@ -889,6 +891,7 @@ static int do_user_lock(struct file_info
 
 		spin_lock(&fi->fi_li_lock);
 		list_add(&li->li_ownerqueue, &fi->fi_li_list);
+		set_bit(LI_FLAG_ONLIST, &li->li_flags);
 		spin_unlock(&fi->fi_li_lock);
 		if (add_lockinfo(li))
 			printk(KERN_WARNING "Add lockinfo failed\n");
@@ -920,6 +923,7 @@ static int do_user_unlock(struct file_in
 			return -ENOMEM;
 		spin_lock(&fi->fi_li_lock);
 		list_add(&li->li_ownerqueue, &fi->fi_li_list);
+		set_bit(LI_FLAG_ONLIST, &li->li_flags);
 		spin_unlock(&fi->fi_li_lock);
 	}
 
@@ -934,6 +938,12 @@ static int do_user_unlock(struct file_in
 	if (kparams->flags & DLM_LKF_CANCEL && li->li_grmode != -1)
 		convert_cancel = 1;
 
+	/* Wait until dlm_lock() has completed */
+	if (!test_bit(LI_FLAG_ONLIST, &li->li_flags)) {
+		down(&li->li_firstlock);
+		up(&li->li_firstlock);
+	}
+
 	/* dlm_unlock() passes a 0 for castaddr which means don't overwrite
 	   the existing li_castaddr as that's the completion routine for
 	   unlocks. dlm_unlock_wait() specifies a new AST routine to be
@@ -949,6 +959,7 @@ static int do_user_unlock(struct file_in
 	if (!status && !convert_cancel) {
 		spin_lock(&fi->fi_li_lock);
 		list_del(&li->li_ownerqueue);
+		clear_bit(LI_FLAG_ONLIST, &li->li_flags);
 		spin_unlock(&fi->fi_li_lock);
 	}
 
