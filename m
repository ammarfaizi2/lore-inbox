Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756580AbWKVTCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580AbWKVTCl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756585AbWKVTCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:02:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2466 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1756580AbWKVTCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:02:39 -0500
Date: Wed, 22 Nov 2006 19:02:34 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>,
       Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Subject: [PATCH 06/11] dm: ioctl: add noflush suspend
Message-ID: <20061122190234.GW6993@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, dm-devel@redhat.com,
	Jun'ichi Nomura <j-nomura@ce.jp.nec.com>,
	Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>

This patch provides a dm ioctl option to request noflush suspending.
(See next patch for what this is for.)
As the interface is extended, the version number is incremented.

Other than accepting the new option through the interface, There is no change
to existing behaviour.

Test results:
Confirmed the option is given from user-space correctly.

Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: dm-devel@redhat.com

Index: linux-2.6.19-rc6/drivers/md/dm.h
===================================================================
--- linux-2.6.19-rc6.orig/drivers/md/dm.h	2006-11-22 17:26:58.000000000 +0000
+++ linux-2.6.19-rc6/drivers/md/dm.h	2006-11-22 17:26:59.000000000 +0000
@@ -47,6 +47,7 @@
  * Suspend feature flags
  */
 #define DM_SUSPEND_LOCKFS_FLAG		(1 << 0)
+#define DM_SUSPEND_NOFLUSH_FLAG		(1 << 1)
 
 /*
  * List of devices that a metadevice uses and should open/close.
Index: linux-2.6.19-rc6/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/md/dm-ioctl.c	2006-11-22 17:26:57.000000000 +0000
+++ linux-2.6.19-rc6/drivers/md/dm-ioctl.c	2006-11-22 17:26:59.000000000 +0000
@@ -774,6 +774,8 @@ static int do_suspend(struct dm_ioctl *p
 
 	if (param->flags & DM_SKIP_LOCKFS_FLAG)
 		suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
+	if (param->flags & DM_NOFLUSH_FLAG)
+		suspend_flags |= DM_SUSPEND_NOFLUSH_FLAG;
 
 	if (!dm_suspended(md))
 		r = dm_suspend(md, suspend_flags);
@@ -815,6 +817,8 @@ static int do_resume(struct dm_ioctl *pa
 		/* Suspend if it isn't already suspended */
 		if (param->flags & DM_SKIP_LOCKFS_FLAG)
 			suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
+		if (param->flags & DM_NOFLUSH_FLAG)
+			suspend_flags |= DM_SUSPEND_NOFLUSH_FLAG;
 		if (!dm_suspended(md))
 			dm_suspend(md, suspend_flags);
 
Index: linux-2.6.19-rc6/include/linux/dm-ioctl.h
===================================================================
--- linux-2.6.19-rc6.orig/include/linux/dm-ioctl.h	2006-11-22 17:26:45.000000000 +0000
+++ linux-2.6.19-rc6/include/linux/dm-ioctl.h	2006-11-22 17:26:59.000000000 +0000
@@ -285,9 +285,9 @@ typedef char ioctl_struct[308];
 #define DM_DEV_SET_GEOMETRY	_IOWR(DM_IOCTL, DM_DEV_SET_GEOMETRY_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	10
+#define DM_VERSION_MINOR	11
 #define DM_VERSION_PATCHLEVEL	0
-#define DM_VERSION_EXTRA	"-ioctl (2006-09-14)"
+#define DM_VERSION_EXTRA	"-ioctl (2006-10-12)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
@@ -323,4 +323,9 @@ typedef char ioctl_struct[308];
  */
 #define DM_SKIP_LOCKFS_FLAG	(1 << 10) /* In */
 
+/*
+ * Set this to suspend without flushing queued ios.
+ */
+#define DM_NOFLUSH_FLAG		(1 << 11) /* In */
+
 #endif				/* _LINUX_DM_IOCTL_H */
