Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269515AbUJFVHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269515AbUJFVHn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269524AbUJFUz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:55:26 -0400
Received: from peabody.ximian.com ([130.57.169.10]:30440 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269515AbUJFUx0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:53:26 -0400
Subject: Re: [RFC][PATCH] inotify 0.13
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1097095286.9199.2.camel@vertex>
References: <1097095286.9199.2.camel@vertex>
Content-Type: multipart/mixed; boundary="=-lWm40/6nOCtOvdf8hPx7"
Date: Wed, 06 Oct 2004 16:51:52 -0400
Message-Id: <1097095913.4160.13.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lWm40/6nOCtOvdf8hPx7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-10-06 at 16:41 -0400, John McCutchan wrote:

> -add CLOSE_WRITE/CLOSE_NOWRITE events (rml)
> -CLOSE_* events are delivered in all circumstances now (rml)

The __fput() related bits here got dropped.

Attached, against 0.13.

	Robert Love


--=-lWm40/6nOCtOvdf8hPx7
Content-Disposition: attachment; filename=inotify-0.13-rml-missing-fput-bits-1.patch
Content-Type: text/x-patch; name=inotify-0.13-rml-missing-fput-bits-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

add make missing __fput() logic.

Signed-Off-By: Robert Love <rml@novell.com>

 fs/file_table.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff -urN linux-inotify-0.13/fs/file_table.c linux/fs/file_table.c
--- linux-inotify-0.13/fs/file_table.c	2004-10-06 16:47:28.785451776 -0400
+++ linux/fs/file_table.c	2004-10-06 16:49:01.200402568 -0400
@@ -16,6 +16,7 @@
 #include <linux/eventpoll.h>
 #include <linux/mount.h>
 #include <linux/cdev.h>
+#include <linux/inotify.h>
 
 /* sysctl tunables... */
 struct files_stat_struct files_stat = {
@@ -122,8 +123,14 @@
 	struct dentry *dentry = file->f_dentry;
 	struct vfsmount *mnt = file->f_vfsmnt;
 	struct inode *inode = dentry->d_inode;
+	u32 mask;
 
 	might_sleep();
+
+	mask = (file->f_mode & FMODE_WRITE) ? IN_CLOSE_WRITE : IN_CLOSE_NOWRITE;
+	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
+	inotify_inode_queue_event(inode, mask, 0, NULL);
+
 	/*
 	 * The function eventpoll_release() should be the first called
 	 * in the file cleanup chain.

--=-lWm40/6nOCtOvdf8hPx7--

