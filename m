Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267298AbUIUFVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbUIUFVq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 01:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267304AbUIUFVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 01:21:45 -0400
Received: from peabody.ximian.com ([130.57.169.10]:31976 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267298AbUIUFVc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 01:21:32 -0400
Subject: Re: [RFC][PATCH] inotify 0.9.2
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <1095652572.23128.2.camel@vertex>
References: <1095652572.23128.2.camel@vertex>
Content-Type: multipart/mixed; boundary="=-dzLlrf273XNfLHgrCbY7"
Date: Tue, 21 Sep 2004 01:21:31 -0400
Message-Id: <1095744091.2454.56.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dzLlrf273XNfLHgrCbY7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-09-19 at 23:56 -0400, John McCutchan wrote:

> I would appreciate design review, code review and testing.

Hey, John!

Attached patch, against inotify 0.9.2, cleans up the inotify.h header
file a bit.  The patch is a little noisy because I reformat some lines
for readability or coding style concerns, but there are a few important
changes:

	- Use PATH_MAX, the actual maximum path length, not 256, for the
	  size of "filename" in "struct inotify_event"

	- Separate with __KERNEL__ the kernel from the user API

	- Instead of forward declaring the inode, superblock, and
	  dentry structures, include the appropriate header file

Thanks!

	Robert Love


--=-dzLlrf273XNfLHgrCbY7
Content-Disposition: attachment; filename=inotify-cleanup-header-rml-1.patch
Content-Type: text/x-patch; name=inotify-cleanup-header-rml-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Clean up the inotify header

Signed-Off-By: Robert Love <rml@novell.com>

 include/linux/inotify.h |   79 +++++++++++++++++++++++++++++-------------------
 1 files changed, 48 insertions(+), 31 deletions(-)

--- linux-inotify/include/linux/inotify.h	2004-09-21 00:58:03.920388608 -0400
+++ linux/include/linux/inotify.h	2004-09-21 01:15:05.831034576 -0400
@@ -9,66 +9,83 @@
 #ifndef _LINUX_INOTIFY_H
 #define _LINUX_INOTIFY_H
 
-struct inode;
-struct dentry;
-struct super_block;
+#include <linux/limits.h>
 
+/*
+ * struct inotify_event - structure read from the inotify device for each event
+ *
+ * When you are watching a directory, you will receive the filename for events
+ * such as IN_CREATE, IN_DELETE, IN_OPEN, IN_CLOSE, and so on ...
+ *
+ * Note: When reading from the device you must provide a buffer that is a
+ * multiple of sizeof(struct inotify_event)
+ */
 struct inotify_event {
 	int wd;
 	int mask;
-	char filename[256];
-	/* When you are watching a directory you will get the filenames
-	 * for events like IN_CREATE, IN_DELETE, IN_OPEN, IN_CLOSE, etc.. 
-	 */
+	char filename[PATH_MAX];
 };
-/* When reading from the device you must provide a buffer 
- * that is a multiple of the sizeof(inotify_event)
- */
 
+/* the following are legal, implemented events */
 #define IN_ACCESS	0x00000001	/* File was accessed */
 #define IN_MODIFY	0x00000002	/* File was modified */
 #define IN_CREATE	0x00000004	/* File was created */
 #define IN_DELETE	0x00000008	/* File was deleted */
 #define IN_RENAME	0x00000010	/* File was renamed */
-#define IN_ATTRIB	0x00000020	/* File changed attributes */
-#define IN_MOVE		0x00000040	/* File was moved */
-#define IN_UNMOUNT	0x00000080	/* Device file was on, was unmounted */
+#define IN_UNMOUNT	0x00000080	/* Backing filesystem was unmounted */
 #define IN_CLOSE	0x00000100	/* File was closed */
 #define IN_OPEN		0x00000200	/* File was opened */
+
+/* the following are legal, but not yet implemented, events */
+#define IN_ATTRIB	0x00000020	/* File changed attributes */
+#define IN_MOVE		0x00000040	/* File was moved */
+
+/* special flags */
 #define IN_IGNORED	0x00000400	/* File was ignored */
 #define IN_ALL_EVENTS	0xffffffff	/* All the events */
 
-/* ioctl */
-
-/* Fill this and pass it to INOTIFY_WATCH ioctl */
+/*
+ * struct inotify_watch_request - represents a watch request
+ *
+ * Pass to the inotify device via the INOTIFY_WATCH ioctl
+ */
 struct inotify_watch_request {
-	char *dirname; // directory name
-	unsigned long mask; // event mask
+	char *dirname;		/* directory name */
+	unsigned long mask;	/* event mask */
 };
 
-#define INOTIFY_IOCTL_MAGIC 'Q'
-#define INOTIFY_IOCTL_MAXNR 4
+#define INOTIFY_IOCTL_MAGIC	'Q'
+#define INOTIFY_IOCTL_MAXNR	4
 
 #define INOTIFY_WATCH  		_IOR(INOTIFY_IOCTL_MAGIC, 1, struct inotify_watch_request)
 #define INOTIFY_IGNORE 		_IOR(INOTIFY_IOCTL_MAGIC, 2, int)
 #define INOTIFY_STATS		_IOR(INOTIFY_IOCTL_MAGIC, 3, int)
 #define INOTIFY_SETDEBUG	_IOR(INOTIFY_IOCTL_MAGIC, 4, int)
 
-#define INOTIFY_DEBUG_NONE   0x00000000
-#define INOTIFY_DEBUG_ALLOC  0x00000001
-#define INOTIFY_DEBUG_EVENTS 0x00000002
-#define INOTIFY_DEBUG_INODE  0x00000004
-#define INOTIFY_DEBUG_ERRORS 0x00000008
-#define INOTIFY_DEBUG_FILEN  0x00000010
-#define INOTIFY_DEBUG_ALL    0xffffffff
+#define INOTIFY_DEBUG_NONE	0x00000000
+#define INOTIFY_DEBUG_ALLOC	0x00000001
+#define INOTIFY_DEBUG_EVENTS	0x00000002
+#define INOTIFY_DEBUG_INODE	0x00000004
+#define INOTIFY_DEBUG_ERRORS	0x00000008
+#define INOTIFY_DEBUG_FILEN	0x00000010
+#define INOTIFY_DEBUG_ALL	0xffffffff
+
+#ifdef __KERNEL__
+
+#include <linux/dcache.h>
+#include <linux/fs.h>
 
-/* Kernel API */
 /* Adds events to all watchers on inode that are interested in mask */
-void inotify_inode_queue_event (struct inode *inode, unsigned long mask, const char *filename);
+void inotify_inode_queue_event (struct inode *inode, unsigned long mask,
+		const char *filename);
+
 /* Same as above but uses dentry's inode */
-void inotify_dentry_parent_queue_event (struct dentry *dentry, unsigned long mask, const char *filename);
+void inotify_dentry_parent_queue_event (struct dentry *dentry,
+		unsigned long mask, const char *filename);
+
 /* This will remove all watchers from all inodes on the superblock */
 void inotify_super_block_umount (struct super_block *sb);
 
-#endif
+#endif	/* __KERNEL __ */
 
+#endif	/* _LINUX_INOTIFY_H */

--=-dzLlrf273XNfLHgrCbY7--

