Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937223AbWLEAhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937223AbWLEAhg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 19:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937212AbWLEAhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 19:37:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:8714 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937193AbWLEAhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 19:37:35 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,495,1157353200"; 
   d="scan'208"; a="23021294:sNHT21235887"
Date: Mon, 4 Dec 2006 16:36:20 -0800
From: Valerie Henson <val_henson@linux.intel.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Steven Whitehouse <steve@chygwyn.com>, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Relative atime (was Re: What's in ocfs2.git)
Message-ID: <20061205003619.GC8482@goober>
References: <20061203203149.GC19617@ca-server1.us.oracle.com> <1165229693.3752.629.camel@quoit.chygwyn.com> <20061205001007.GF19617@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205001007.GF19617@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 04:10:07PM -0800, Mark Fasheh wrote:
> Hi Steve,
> 
> On Mon, Dec 04, 2006 at 10:54:53AM +0000, Steven Whitehouse wrote:
> > > In the future, I'd like to see a "relative atime" mode, which functions
> > > in the manner described by Valerie Henson at:
> > > 
> > > http://lkml.org/lkml/2006/8/25/380
> > > 
> > I'd like to second that. [adding Val Henson to the "to"] What (if
> > anything) remains to be done before the relative atime patch is ready to
> > go upstream? I'm happy to help out here if required,
> Last time I looked at them, things seemed to be in pretty good shape - it
> wasn't a very large patch series.

Yep, the relative atime patch is tiny and pretty much done - just
needs some soak time in -mm and a little more review (cc'd Viro and
fsdevel).  Kernel patch against 2.6.18-rc4 appended, patch to mount
following. (Note that my web server suffered a RAID failure and my
patches page is unavailable till the restore finishes.)

-VAL

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
