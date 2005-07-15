Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263279AbVGOKhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbVGOKhD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbVGOKfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:35:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26515 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263279AbVGOKcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:32:39 -0400
Date: Fri, 15 Jul 2005 18:37:27 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 12/12] dlm: fix device refcount
Message-ID: <20050715103727.GO17316@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="device-refcount.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An extra refcount was being left on devices.

Signed-off-by: Patrick Caulfield <pcaulfie@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/device.c
===================================================================
--- linux.orig/drivers/dlm/device.c
+++ linux/drivers/dlm/device.c
@@ -449,8 +449,8 @@ static int dlm_open(struct inode *inode,
 	spin_lock_init(&f->fi_ast_lock);
 	init_waitqueue_head(&f->fi_wait);
 	f->fi_ls = lsinfo;
-	atomic_set(&f->fi_refcnt, 1);
 	f->fi_flags = 0;
+	get_file_info(f);
 	set_bit(1, &f->fi_flags);
 
 	file->private_data = f;
@@ -602,6 +602,7 @@ static int dlm_close(struct inode *inode
 		}
 	}
 	up(&user_ls_lock);
+	put_file_info(f);
 
 	/* Restore signals */
 	sigprocmask(SIG_SETMASK, &tmpsig, NULL);

--
