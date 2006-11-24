Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935005AbWKXSsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935005AbWKXSsX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 13:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935006AbWKXSsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 13:48:23 -0500
Received: from tomts10-srv.bellnexxia.net ([209.226.175.54]:36996 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S935005AbWKXSsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 13:48:21 -0500
Date: Fri, 24 Nov 2006 13:48:19 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Greg KH <greg@kroah.com>
Cc: ltt-dev@shafik.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] DebugFS : file/directory creation error handling, 2.6.19-rc6
Message-ID: <20061124184818.GC8952@Krystal>
References: <20061120181838.GB7328@Krystal> <20061122052730.GD20836@kroah.com> <20061123080009.GD1703@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061123080009.GD1703@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:46:33 up 93 days, 15:54,  4 users,  load average: 0.39, 0.31, 0.24
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix error handling of file and directory creation in DebugFS.

The error path should release the file system because no _remove will be called
for this erroneous creation.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

-- BEGIN --
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -205,13 +205,15 @@ struct dentry *debugfs_create_file(const
 
 	pr_debug("debugfs: creating file '%s'\n",name);
 
-	error = simple_pin_fs(&debug_fs_type, &debugfs_mount, &debugfs_mount_count);
+	error = simple_pin_fs(&debug_fs_type, &debugfs_mount,
+		&debugfs_mount_count);
 	if (error)
 		goto exit;
 
 	error = debugfs_create_by_name(name, mode, parent, &dentry);
 	if (error) {
 		dentry = NULL;
+		simple_release_fs(&debugfs_mount, &debugfs_mount_count);
 		goto exit;
 	}
 
-- END --

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
