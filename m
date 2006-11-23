Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757288AbWKWRyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288AbWKWRyv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 12:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757290AbWKWRyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 12:54:51 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:17301 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1757288AbWKWRyu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 12:54:50 -0500
Date: Thu, 23 Nov 2006 12:54:48 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Greg KH <greg@kroah.com>
Cc: ltt-dev@shafik.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] DebugFS : file/directory removal fix, 2.6.18
Message-ID: <20061123175448.GA3633@Krystal>
References: <20061120181838.GB7328@Krystal> <20061122052730.GD20836@kroah.com> <20061123082244.GF1703@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20061123082244.GF1703@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 12:50:15 up 92 days, 14:58,  4 users,  load average: 0.67, 0.44, 0.79
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix file and directory removal in debugfs. Add inotify support for file removal.

The following scenario :
create dir a
create dir a/b

cd a/b (some process goes in cwd a/b)

rmdir a/b
rmdir a

fails due to the fact that "a" appears to be non empty. It is because the "b"
dentry is not deleted from "a" and still in use. The same problem happens if
"b" is a file. d_delete is nice enough to know when it needs to unhash and free
the dentry if nothing else is using it or, if someone is using it, to remove it
from the hash queues and wait for it to be deleted when it has no users.

The nice side-effect of this fix is that it calls the file removal
notification.

I have been told by Al Viro that this fix belongs to DebugFS, not libfs, so
here it is. Please use instead of "[PATCH 5/5] libfs : file/directory removal
fix, 2.6.18" posted earlier.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>


--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -288,6 +288,7 @@ void debugfs_remove(struct dentry *dentr
 	mutex_lock(&parent->d_inode->i_mutex);
 	if (debugfs_positive(dentry)) {
 		if (dentry->d_inode) {
+			dget(dentry);
 			if (S_ISDIR(dentry->d_inode->i_mode)) {
 				ret = simple_rmdir(parent->d_inode, dentry);
 				if (ret)
@@ -297,6 +298,9 @@ void debugfs_remove(struct dentry *dentr
 						dentry->d_name.name);
 			} else
 				simple_unlink(parent->d_inode, dentry);
+			if (!ret)
+				d_delete(dentry);
+			dput(dentry);
 		}
 	}
 	mutex_unlock(&parent->d_inode->i_mutex);



OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
