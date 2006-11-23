Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933066AbWKWHvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933066AbWKWHvv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 02:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933064AbWKWHvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 02:51:50 -0500
Received: from tomts22.bellnexxia.net ([209.226.175.184]:49604 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S933043AbWKWHvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 02:51:50 -0500
Date: Thu, 23 Nov 2006 02:51:48 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Greg KH <greg@kroah.com>
Cc: ltt-dev@shafik.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] DebugFS : inotify create/mkdir support
Message-ID: <20061123075148.GB1703@Krystal>
References: <20061120181838.GB7328@Krystal> <20061122052730.GD20836@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-1850-1164268308-0001-2"
Content-Disposition: inline
In-Reply-To: <20061122052730.GD20836@kroah.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 02:47:30 up 92 days,  4:55,  3 users,  load average: 0.37, 0.27, 0.18
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-1850-1164268308-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Add inotify create and mkdir events to DebugFS.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-1850-1164268308-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch01-debugfs-inotify.diff"

--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/namei.h>
 #include <linux/debugfs.h>
+#include <linux/fsnotify.h>
 
 #define DEBUGFS_MAGIC	0x64626720
 
@@ -87,15 +88,22 @@
 
 	mode = (mode & (S_IRWXUGO | S_ISVTX)) | S_IFDIR;
 	res = debugfs_mknod(dir, dentry, mode, 0);
-	if (!res)
+	if (!res) {
 		dir->i_nlink++;
+		fsnotify_mkdir(dir, dentry);
+	}
 	return res;
 }
 
 static int debugfs_create(struct inode *dir, struct dentry *dentry, int mode)
 {
+	int res;
+
 	mode = (mode & S_IALLUGO) | S_IFREG;
-	return debugfs_mknod(dir, dentry, mode, 0);
+	res = debugfs_mknod(dir, dentry, mode, 0);
+	if (!res)
+		fsnotify_create(dir, dentry);
+	return res;
 }
 
 static inline int debugfs_positive(struct dentry *dentry)

--=_Krystal-1850-1164268308-0001-2--
