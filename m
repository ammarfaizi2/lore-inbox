Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVDUFae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVDUFae (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 01:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVDUFae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 01:30:34 -0400
Received: from peabody.ximian.com ([130.57.169.10]:21220 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261225AbVDUFaN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 01:30:13 -0400
Subject: Re: [patch] inotify for 2.6.12-rc3.
From: Robert Love <rml@novell.com>
To: linux-kernel@vger.kernel.org
Cc: Misquoted Morton <akpm@osdl.org>, John McCutchan <ttb@tentacle.dhs.org>
In-Reply-To: <1114060434.6913.26.camel@jenny.boston.ximian.com>
References: <1114060434.6913.26.camel@jenny.boston.ximian.com>
Content-Type: text/plain
Date: Thu, 21 Apr 2005 01:31:01 -0400
Message-Id: <1114061461.6913.30.camel@jenny.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-21 at 01:13 -0400, Robert Love wrote:

> Live from linux.conf.au, below is inotify against 2.6.12-rc3.

G'day mates!  By popular request!

Cheers,

	Robert Love


Send an event on xattr change.  Just use the existing metadata change event,
IN_ATTRIB, instead of adding a new event.  While here, do not wrap
dnotify_flush(), no need.

Signed-off-by: Robert Love <rml@novell.com>

 fs/open.c                |    2 +-
 fs/xattr.c               |    5 ++++-
 include/linux/fsnotify.h |   18 ++++++++++--------
 3 files changed, 15 insertions(+), 10 deletions(-)

diff -urN linux-2.6.12-rc3-inotify-0.22-2/fs/open.c linux/fs/open.c
--- linux-2.6.12-rc3-inotify-0.22-2/fs/open.c	2005-04-21 01:13:17.000000000 -0400
+++ linux/fs/open.c	2005-04-21 01:17:27.000000000 -0400
@@ -1000,7 +1000,7 @@
 			retval = err;
 	}
 
-	fsnotify_flush(filp, id);
+	dnotify_flush(filp, id);
 	locks_remove_posix(filp, id);
 	fput(filp);
 	return retval;
diff -urN linux-2.6.12-rc3-inotify-0.22-2/fs/xattr.c linux/fs/xattr.c
--- linux-2.6.12-rc3-inotify-0.22-2/fs/xattr.c	2005-04-21 01:13:17.000000000 -0400
+++ linux/fs/xattr.c	2005-04-21 01:24:24.000000000 -0400
@@ -16,6 +16,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/module.h>
+#include <linux/fsnotify.h>
 #include <asm/uaccess.h>
 
 /*
@@ -57,8 +58,10 @@
 		if (error)
 			goto out;
 		error = d->d_inode->i_op->setxattr(d, kname, kvalue, size, flags);
-		if (!error)
+		if (!error) {
+			fsnotify_xattr(d);
 			security_inode_post_setxattr(d, kname, kvalue, size, flags);
+		}
 out:
 		up(&d->d_inode->i_sem);
 	}
diff -urN linux-2.6.12-rc3-inotify-0.22-2/include/linux/fsnotify.h linux/include/linux/fsnotify.h
--- linux-2.6.12-rc3-inotify-0.22-2/include/linux/fsnotify.h	2005-04-21 01:13:20.000000000 -0400
+++ linux/include/linux/fsnotify.h	2005-04-21 01:23:06.000000000 -0400
@@ -131,6 +131,16 @@
 }
 
 /*
+ * fsnotify_xattr - extended attributes were changed
+ */
+static inline void fsnotify_xattr(struct dentry *dentry)
+{
+	inotify_dentry_parent_queue_event(dentry, IN_ATTRIB, 0,
+					  dentry->d_name.name);
+	inotify_inode_queue_event(dentry->d_inode, IN_ATTRIB, 0, NULL);
+}
+
+/*
  * fsnotify_change - notify_change event.  file was modified and/or metadata
  * was changed.
  */
@@ -177,14 +187,6 @@
 	}
 }
 
-/*
- * fsnotify_flush - flush time!
- */
-static inline void fsnotify_flush(struct file *filp, fl_owner_t id)
-{
-	dnotify_flush(filp, id);
-}
-
 #ifdef CONFIG_INOTIFY	/* inotify helpers */
 
 /*


