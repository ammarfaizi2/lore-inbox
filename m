Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966336AbWKTSSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966336AbWKTSSn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966334AbWKTSSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:18:43 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:22518 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S966336AbWKTSSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:18:41 -0500
Date: Mon, 20 Nov 2006 13:18:38 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: ltt-dev@shafik.org, linux-kernel@vger.kernel.org
Subject: Debugfs : inotify, multiple calls to debugfs_create_file, remove
Message-ID: <20061120181838.GB7328@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 12:56:52 up 89 days, 15:04,  3 users,  load average: 0.20, 0.31, 0.43
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I just had to add inotify support to my LTTng consumer so I could inform it
of the presence of new CPUs (for CPU hotplug). I noticed that no
notification event was being sent when a debugfs file is created from within
the kernel through debugfs_create. There are probably other notifications
missing, but here is the patch adding the one I care about. Should it be added
in libfs or in debugfs ?

A second problem I noticed is when a caller calls debugfs_create_file more than
once : the result is that the debugfs_remove will fail. I guess the second call
to debugfs_create_file increments the reference counts (there is not fix for
this issue in my patch).

Third problem : a failing call to debugfs_remove keeps the filesystem pinned.
(fixed by calling simple_release_fs in the error path).

The third problem : When a process is in a directory, the call to simple_rmdir
will fail. Debugfs does not use its return value. I noticed that calling
simple_unlink on a directory when simple_rmdir fails removes the directory that
would otherwise be left there. I am not sure if this approach is correct
through.

This patch is against Linux 2.6.18.

Regards,

Mathieu


diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index e8ae304..d88203f 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -23,6 +23,7 @@ #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/namei.h>
 #include <linux/debugfs.h>
+#include <linux/fsnotify.h>
 
 #define DEBUGFS_MAGIC	0x64626720
 
@@ -156,7 +157,8 @@ static int debugfs_create_by_name(const 
 	} else
 		error = PTR_ERR(dentry);
 	mutex_unlock(&parent->d_inode->i_mutex);
-
+	if (!error)
+		fsnotify_create(parent->d_inode, *dentry);
 	return error;
 }
 
@@ -204,7 +206,10 @@ struct dentry *debugfs_create_file(const
 
 	error = debugfs_create_by_name(name, mode, parent, &dentry);
 	if (error) {
+		/* FIXME : a failing call to debugfs_create_file leaves a
+		 * stalled entry after a remove. */
 		dentry = NULL;
+		simple_release_fs(&debugfs_mount, &debugfs_mount_count);
 		goto exit;
 	}
 
@@ -265,6 +270,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_dir);
 void debugfs_remove(struct dentry *dentry)
 {
 	struct dentry *parent;
+	int ret = 0;
 	
 	if (!dentry)
 		return;
@@ -277,8 +283,12 @@ void debugfs_remove(struct dentry *dentr
 	if (debugfs_positive(dentry)) {
 		if (dentry->d_inode) {
 			if (S_ISDIR(dentry->d_inode->i_mode))
-				simple_rmdir(parent->d_inode, dentry);
+				ret = simple_rmdir(parent->d_inode, dentry);
 			else
+				ret = simple_unlink(parent->d_inode, dentry);
+			/* simple_rmdir failed because the directory
+			 * is used. Force deletion. */
+			if (ret)
 				simple_unlink(parent->d_inode, dentry);
 		dput(dentry);
 		}

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
