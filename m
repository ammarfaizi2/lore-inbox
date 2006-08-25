Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422928AbWHYXwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422928AbWHYXwm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 19:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422927AbWHYXwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 19:52:41 -0400
Received: from mga07.intel.com ([143.182.124.22]:21263 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932245AbWHYXwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 19:52:39 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,170,1154934000"; 
   d="scan'208"; a="107787161:sNHT47248768"
Message-Id: <20060825235235.605667000@linux.intel.com>
References: <20060825235215.820563000@linux.intel.com>
User-Agent: quilt/0.45-1
Date: Fri, 25 Aug 2006 16:52:16 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Akkana Peck <akkana@shallowsky.com>, Mark Fasheh <mark.fasheh@oracle.com>,
       Jesse Barnes <jesse.barnes@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, Chris Wedgewood <cw@foof.org>,
       jsipek@cs.sunysb.edu, Al Viro <viro@ftp.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>, Adrian Bunk <bunk@stusta.de>,
       Valerie Henson <val_henson@linux.intel.com>
Subject: [patch 1/1] Relative atime - kernel side
Content-Disposition: inline; filename=relative-atime-kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add "relatime" (relative atime) support.  Relative atime only updates
the atime if the previous atime is older than the mtime or ctime.
Like noatime, but useful for applications like mutt that need to know
when a file has been read since it was last modified.

Signed-off-by: Valerie Henson <val_henson@linux.intel.com>

---
 fs/inode.c            |   11 ++++++++++-
 fs/namespace.c        |    5 ++++-
 include/linux/fs.h    |    1 +
 include/linux/mount.h |    1 +
 4 files changed, 16 insertions(+), 2 deletions(-)

--- linux-2.6.18-rc4-relatime.orig/fs/inode.c
+++ linux-2.6.18-rc4-relatime/fs/inode.c
@@ -1200,7 +1200,16 @@ void touch_atime(struct vfsmount *mnt, s
 		return;
 
 	now = current_fs_time(inode->i_sb);
-	if (!timespec_equal(&inode->i_atime, &now)) {
+	if (timespec_equal(&inode->i_atime, &now))
+		return;
+	/*
+	 * With relative atime, only update atime if the previous
+	 * atime is earlier than either the ctime or mtime.
+	 */
+	if (!mnt ||
+	    !(mnt->mnt_flags & MNT_RELATIME) ||
+	    (timespec_compare(&inode->i_atime, &inode->i_mtime) < 0) ||
+	    (timespec_compare(&inode->i_atime, &inode->i_ctime) < 0)) {
 		inode->i_atime = now;
 		mark_inode_dirty_sync(inode);
 	}
--- linux-2.6.18-rc4-relatime.orig/fs/namespace.c
+++ linux-2.6.18-rc4-relatime/fs/namespace.c
@@ -376,6 +376,7 @@ static int show_vfsmnt(struct seq_file *
 		{ MNT_NOEXEC, ",noexec" },
 		{ MNT_NOATIME, ",noatime" },
 		{ MNT_NODIRATIME, ",nodiratime" },
+		{ MNT_RELATIME, ",relatime" },
 		{ 0, NULL }
 	};
 	struct proc_fs_info *fs_infop;
@@ -1413,9 +1414,11 @@ long do_mount(char *dev_name, char *dir_
 		mnt_flags |= MNT_NOATIME;
 	if (flags & MS_NODIRATIME)
 		mnt_flags |= MNT_NODIRATIME;
+	if (flags & MS_RELATIME)
+		mnt_flags |= MNT_RELATIME;
 
 	flags &= ~(MS_NOSUID | MS_NOEXEC | MS_NODEV | MS_ACTIVE |
-		   MS_NOATIME | MS_NODIRATIME);
+		   MS_NOATIME | MS_NODIRATIME | MS_RELATIME);
 
 	/* ... and get the mountpoint */
 	retval = path_lookup(dir_name, LOOKUP_FOLLOW, &nd);
--- linux-2.6.18-rc4-relatime.orig/include/linux/fs.h
+++ linux-2.6.18-rc4-relatime/include/linux/fs.h
@@ -119,6 +119,7 @@ extern int dir_notify_enable;
 #define MS_PRIVATE	(1<<18)	/* change to private */
 #define MS_SLAVE	(1<<19)	/* change to slave */
 #define MS_SHARED	(1<<20)	/* change to shared */
+#define MS_RELATIME	(1<<21)	/* Update atime relative to mtime/ctime. */
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
 
--- linux-2.6.18-rc4-relatime.orig/include/linux/mount.h
+++ linux-2.6.18-rc4-relatime/include/linux/mount.h
@@ -27,6 +27,7 @@ struct namespace;
 #define MNT_NOEXEC	0x04
 #define MNT_NOATIME	0x08
 #define MNT_NODIRATIME	0x10
+#define MNT_RELATIME	0x20
 
 #define MNT_SHRINKABLE	0x100
 

--
