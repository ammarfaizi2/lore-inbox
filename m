Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVAHHpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVAHHpH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVAHHoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:44:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:47237 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261867AbVAHFsS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:18 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <110516326283@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:42 -0800
Message-Id: <1105163262994@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.30, 2004/12/21 22:43:19-08:00, greg@kroah.com

debugfs: add /sys/kernel/debug mount point for people to mount debugfs on.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/debugfs/inode.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletion(-)


diff -Nru a/fs/debugfs/inode.c b/fs/debugfs/inode.c
--- a/fs/debugfs/inode.c	2005-01-07 15:40:16 -08:00
+++ b/fs/debugfs/inode.c	2005-01-07 15:40:16 -08:00
@@ -298,15 +298,28 @@
 }
 EXPORT_SYMBOL_GPL(debugfs_remove);
 
+static decl_subsys(debug, NULL, NULL);
+
 static int __init debugfs_init(void)
 {
-	return register_filesystem(&debug_fs_type);
+	int retval;
+
+	kset_set_kset_s(&debug_subsys, kernel_subsys);
+	retval = subsystem_register(&debug_subsys);
+	if (retval)
+		return retval;
+
+	retval = register_filesystem(&debug_fs_type);
+	if (retval)
+		subsystem_unregister(&debug_subsys);
+	return retval;
 }
 
 static void __exit debugfs_exit(void)
 {
 	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
 	unregister_filesystem(&debug_fs_type);
+	subsystem_unregister(&debug_subsys);
 }
 
 core_initcall(debugfs_init);

