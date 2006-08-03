Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWHCGlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWHCGlx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 02:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWHCGlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 02:41:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:4200 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932314AbWHCGlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 02:41:51 -0400
X-IronPort-AV: i="4.07,206,1151910000"; 
   d="scan'208"; a="101348622:sNHT10649020613"
Date: Wed, 2 Aug 2006 23:36:22 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Akkana Peck <akkana@shallowsky.com>, Mark Fasheh <mark.fasheh@oracle.com>,
       Jesse Barnes <jesse.barnes@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, Chris Wedgwood <cw@f00f.org>,
       jsipek@cs.sunysb.edu, Al Viro <viro@ftp.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>
Subject: [RFC] [PATCH] Relative lazy atime
Message-ID: <20060803063622.GB8631@goober>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Corrected Chris Wedgwood's name and email.)

My friend Akkana followed my advice to use noatime on one of her
machines, but discovered that mutt was unusable because it always
thought that new messages had arrived since the last time it had
checked a folder (mbox format).  I thought this was a bummer, so I
wrote a "relative lazy atime" patch which only updates the atime if
the old atime was less than the ctime or mtime.  This is not the same
as the lazy atime patch of yore[1], which maintained a list of inodes
with dirty atimes and wrote them out on unmount.

Patch below.  Current version (plus test program) is at:

http://infohost.nmt.edu/~val/patches.html#lazyatime

Thanks to everyone who discussed this with me, especially the folks on
#linuxfs on irc.oftc.net.

-VAL

[1] http://www.ussg.iu.edu/hypermail/linux/kernel/0005.0/0284.html

---

Relative lazy atime - only update atime if the old atime was older
than the ctime or mtime.  We are maintaining atime relative to
mtime/ctime.

Not for inclusion (yet).

Written by Val Henson <val_henson@linux.intel.com>

 fs/inode.c            |   16 +++++++++++++++-
 fs/namespace.c        |    5 ++++-
 include/linux/fs.h    |    1 +
 include/linux/mount.h |    1 +
 4 files changed, 21 insertions(+), 2 deletions(-)
diff -Nrup a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	2006-08-02 23:10:56 -07:00
+++ b/fs/inode.c	2006-08-02 23:10:56 -07:00
@@ -1200,10 +1200,24 @@ void touch_atime(struct vfsmount *mnt, s
 		return;
 
 	now = current_fs_time(inode->i_sb);
-	if (!timespec_equal(&inode->i_atime, &now)) {
+	if (timespec_equal(&inode->i_atime, &now))
+		return;
+	/*
+	 * With lazy atime, only update atime if the previous atime is
+	 * earlier than either the ctime or mtime.
+	 */
+	if (!mnt ||
+	    !(mnt->mnt_flags & MNT_LAZYATIME) ||
+	    (timespec_compare(&inode->i_atime, &inode->i_mtime) < 0) ||
+	    (timespec_compare(&inode->i_atime, &inode->i_ctime) < 0)) {
 		inode->i_atime = now;
 		mark_inode_dirty_sync(inode);
 	}
+	/*
+	 * We could update the in-memory atime here if we wanted, but
+	 * that makes it possible for atime to revert if we evict the
+	 * inode from memory.
+	 */
 }
 
 EXPORT_SYMBOL(touch_atime);
diff -Nrup a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c	2006-08-02 23:10:56 -07:00
+++ b/fs/namespace.c	2006-08-02 23:10:56 -07:00
@@ -376,6 +376,7 @@ static int show_vfsmnt(struct seq_file *
 		{ MNT_NOEXEC, ",noexec" },
 		{ MNT_NOATIME, ",noatime" },
 		{ MNT_NODIRATIME, ",nodiratime" },
+		{ MNT_LAZYATIME, ",lazyatime" },
 		{ 0, NULL }
 	};
 	struct proc_fs_info *fs_infop;
@@ -1413,9 +1414,11 @@ long do_mount(char *dev_name, char *dir_
 		mnt_flags |= MNT_NOATIME;
 	if (flags & MS_NODIRATIME)
 		mnt_flags |= MNT_NODIRATIME;
+	if (flags & MS_LAZYATIME)
+		mnt_flags |= MNT_LAZYATIME;
 
 	flags &= ~(MS_NOSUID | MS_NOEXEC | MS_NODEV | MS_ACTIVE |
-		   MS_NOATIME | MS_NODIRATIME);
+		   MS_NOATIME | MS_NODIRATIME | MS_LAZYATIME);
 
 	/* ... and get the mountpoint */
 	retval = path_lookup(dir_name, LOOKUP_FOLLOW, &nd);
diff -Nrup a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	2006-08-02 23:10:56 -07:00
+++ b/include/linux/fs.h	2006-08-02 23:10:56 -07:00
@@ -119,6 +119,7 @@ extern int dir_notify_enable;
 #define MS_PRIVATE	(1<<18)	/* change to private */
 #define MS_SLAVE	(1<<19)	/* change to slave */
 #define MS_SHARED	(1<<20)	/* change to shared */
+#define MS_LAZYATIME	(1<<21)	/* Lazily update on-disk access times. */
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
 
diff -Nrup a/include/linux/mount.h b/include/linux/mount.h
--- a/include/linux/mount.h	2006-08-02 23:10:56 -07:00
+++ b/include/linux/mount.h	2006-08-02 23:10:56 -07:00
@@ -27,6 +27,7 @@ struct namespace;
 #define MNT_NOEXEC	0x04
 #define MNT_NOATIME	0x08
 #define MNT_NODIRATIME	0x10
+#define MNT_LAZYATIME	0x20
 
 #define MNT_SHRINKABLE	0x100
