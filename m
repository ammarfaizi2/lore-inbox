Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757078AbWKWIWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757078AbWKWIWt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 03:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757286AbWKWIWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 03:22:48 -0500
Received: from tomts16.bellnexxia.net ([209.226.175.4]:63908 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1757078AbWKWIWr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 03:22:47 -0500
Date: Thu, 23 Nov 2006 03:22:44 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Greg KH <greg@kroah.com>
Cc: ltt-dev@shafik.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] libfs : file/directory removal fix, 2.6.18
Message-ID: <20061123082244.GF1703@Krystal>
References: <20061120181838.GB7328@Krystal> <20061122052730.GD20836@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20061122052730.GD20836@kroah.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 03:12:37 up 92 days,  5:20,  3 users,  load average: 0.05, 0.13, 0.17
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix file and directory removal in libfs. Add inotify support for file removal.

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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>


--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -276,6 +276,7 @@ int simple_unlink(struct inode *dir, str
 
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	inode->i_nlink--;
+	d_delete(dentry);
 	dput(dentry);
 	return 0;
 }

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
