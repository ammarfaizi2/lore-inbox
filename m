Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422652AbWASVbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbWASVbo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbWASVbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:31:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16577 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422647AbWASVbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:31:20 -0500
Date: Thu, 19 Jan 2006 15:30:46 -0600
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] dlm: check allocation
Message-ID: <20060119213046.GB31387@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We were assuming the success of an allocation.  Problem noticed
by Stefan Richter <stefanr@s5r6.in-berlin.de>

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/device.c
===================================================================
--- linux.orig/drivers/dlm/device.c
+++ linux/drivers/dlm/device.c
@@ -802,6 +802,8 @@ static int do_user_lock(struct file_info
 		   lockinfo again */
 		if (!li && (kparams->flags & DLM_LKF_PERSISTENT)) {
 			li = allocate_lockinfo(fi, cmd, kparams);
+			if (!li)
+				return -ENOMEM;
 
 			li->li_lksb.sb_lkid = kparams->lkid;
 			li->li_castaddr  = kparams->castaddr;
@@ -914,12 +916,12 @@ static int do_user_unlock(struct file_in
 	li = get_lockinfo(kparams->lkid);
 	if (!li) {
 		li = allocate_lockinfo(fi, cmd, kparams);
+		if (!li)
+			return -ENOMEM;
 		spin_lock(&fi->fi_li_lock);
 		list_add(&li->li_ownerqueue, &fi->fi_li_list);
 		spin_unlock(&fi->fi_li_lock);
 	}
- 	if (!li)
-		return -ENOMEM;
 
 	if (li->li_magic != LOCKINFO_MAGIC)
 		return -EINVAL;
