Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757629AbWKXSpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757629AbWKXSpk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 13:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757643AbWKXSpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 13:45:40 -0500
Received: from tomts5-srv.bellnexxia.net ([209.226.175.25]:53234 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1757628AbWKXSpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 13:45:40 -0500
Date: Fri, 24 Nov 2006 13:45:37 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Greg KH <greg@kroah.com>
Cc: ltt-dev@shafik.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] DebugFS : inotify create/mkdir support, 2.6.19-rc6
Message-ID: <20061124184536.GA8952@Krystal>
References: <20061120181838.GB7328@Krystal> <20061122052730.GD20836@kroah.com> <20061123075148.GB1703@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061123075148.GB1703@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:43:46 up 93 days, 15:51,  4 users,  load average: 0.77, 0.30, 0.23
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Same patch, against 2.6.19-rc6)

Add inotify create and mkdir events to DebugFS.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>


--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -23,6 +23,7 @@ #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/namei.h>
 #include <linux/debugfs.h>
+#include <linux/fsnotify.h>
 
 #define DEBUGFS_MAGIC	0x64626720
 
@@ -86,15 +87,22 @@ static int debugfs_mkdir(struct inode *d
 
 	mode = (mode & (S_IRWXUGO | S_ISVTX)) | S_IFDIR;
 	res = debugfs_mknod(dir, dentry, mode, 0);
-	if (!res)
+	if (!res) {
 		inc_nlink(dir);
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


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
