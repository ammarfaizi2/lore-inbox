Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVBJMtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVBJMtA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 07:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVBJMtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 07:49:00 -0500
Received: from dspnet.fr.eu.org ([62.73.5.179]:47876 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S262114AbVBJMsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 07:48:42 -0500
Date: Thu, 10 Feb 2005 13:48:32 +0100
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>
Cc: nfs@lists.sourceforge.net
Subject: Re: Irix NFS server usual problem [patch, fc3 2.6.10-1,760_FC3]
Message-ID: <20050210124832.GA23320@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
References: <20050207221638.GA18723@dspnet.fr.eu.org> <1107816524.9970.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107816524.9970.8.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 05:48:44PM -0500, Trond Myklebust wrote:
> Have you applied SGI's IRIX patches to your server (the one that makes
> the cookies take 32-bit values)?

Can't.  They're 6.4.  And in any case it's 31-bits values glibc is
limited to, which is the problem with the sgis (they're 32-bits
unsigned).


> Alternatively, you can forward-port the old 2.4.x cookie hack to 2.6.x
> (that should be fairly trivial to do). You can find the patch on
> 
> http://client.linux-nfs.org/Linux-2.4.x/2.4.26/linux-2.4.26-02-seekdir.dif

Made a new version that's less hackish, with an irix32 mount flag to
handle the case.  With that patch, a mount -o irix32 and -32bitclient
on the sgi side everything works as it should.

Specifically, what the irix32 flag does is:
- convert the getdents64 d_off entries from unsigned 32 bits as the
  nfs server sends them to signed 32 bits as glibc wants.  Side
  effect, the directory filp->f_pos is signed 32bits too.  It does not
  touch the cached nfs server replies which are pristine.

- accept _llseek with negative positions and convert them back to
  32-bits unsigned when needed

Using a mount flag ensures no damage is done in mixed environments and
also allows someday glibc to handle 64-bits cookies correctly.

If the patch looks like it's going to be accepted, I'll send the
(trivial) mount changes to whoever the util-linux maintainer is.  And
does someone happens to know who maintains the mount/nfs options man
page?

It may fuzz a little, fc3 has a minor patch in another part of dir.c.

  OG.

Signed-off-by: Olivier Galibert <galibert@pobox.com>

 fs/nfs/dir.c              |   53 +++++++++++++++++++++++++++++++++++++++++-----
 fs/nfs/inode.c            |    1 
 include/linux/nfs_mount.h |    3 +-
 3 files changed, 51 insertions(+), 6 deletions(-)

--- ../save/kernel-2.6.10/linux-2.6.10/fs/nfs/dir.c	2005-02-08 13:49:13.000000000 +0100
+++ linux-2.6.10/fs/nfs/dir.c	2005-02-08 22:27:35.000000000 +0100
@@ -31,6 +31,7 @@
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 #include <linux/namei.h>
+#include <linux/mount.h>
 
 #include "delegation.h"
 
@@ -38,6 +39,7 @@
 /* #define NFS_DEBUG_VERBOSE 1 */
 
 static int nfs_opendir(struct inode *, struct file *);
+static loff_t nfs_dir_llseek(struct file *, loff_t, int);
 static int nfs_readdir(struct file *, void *, filldir_t);
 static struct dentry *nfs_lookup(struct inode *, struct dentry *, struct nameidata *);
 static int nfs_cached_lookup(struct inode *, struct dentry *,
@@ -54,6 +56,7 @@
 static int nfs_fsync_dir(struct file *, struct dentry *, int);
 
 struct file_operations nfs_dir_operations = {
+	.llseek		= nfs_dir_llseek,
 	.read		= generic_read_dir,
 	.readdir	= nfs_readdir,
 	.open		= nfs_opendir,
@@ -96,6 +99,7 @@
 
 #endif /* CONFIG_NFS_V4 */
 
+
 /*
  * Open file
  */
@@ -112,6 +116,33 @@
 	return res;
 }
 
+
+/*
+ * Allow seeking to negative positions in the irix32 case
+ */
+static loff_t nfs_dir_llseek(struct file *file, loff_t offset, int origin)
+{
+	switch (origin) {
+		case 1:
+			if (offset == 0) {
+				offset = file->f_pos;
+				break;
+			}
+		case 2:
+			return -EINVAL;
+	}
+
+	if (offset < 0 && !(NFS_SB(file->f_vfsmnt->mnt_sb)->flags & NFS_MOUNT_IRIX32))
+		return -EINVAL;
+
+	if (offset != file->f_pos) {
+		file->f_pos = offset;
+		file->f_version = 0;
+	}
+	return (offset <= 0) ? 0 : offset;
+}
+
+
 typedef u32 * (*decode_dirent_t)(u32 *, struct nfs_entry *, int);
 typedef struct {
 	struct file	*file;
@@ -324,7 +355,7 @@
 	unsigned long	fileid;
 	int		loop_count = 0,
 			res;
-
+	int		irix32 = NFS_SB(file->f_vfsmnt->mnt_sb)->flags & NFS_MOUNT_IRIX32;
 	dfprintk(VFS, "NFS: nfs_do_filldir() filling starting @ cookie %Lu\n", (long long)desc->target);
 
 	for(;;) {
@@ -337,11 +368,19 @@
 		if (desc->plus && (entry->fattr->valid & NFS_ATTR_FATTR))
 			d_type = nfs_type_to_d_type(entry->fattr->type);
 
-		res = filldir(dirent, entry->name, entry->len, 
-			      entry->prev_cookie, fileid, d_type);
+		if (!irix32)
+			res = filldir(dirent, entry->name, entry->len, 
+				      entry->prev_cookie, fileid, d_type);
+		else
+			res = filldir(dirent, entry->name, entry->len, 
+				      (s32)entry->prev_cookie, fileid, d_type);
 		if (res < 0)
 			break;
-		file->f_pos = desc->target = entry->cookie;
+		desc->target = entry->cookie;
+		if (!irix32)
+			file->f_pos = entry->cookie;
+		else
+			file->f_pos = (s32)entry->cookie;
 		if (dir_decode(desc) != 0) {
 			desc->page_index ++;
 			break;
@@ -429,6 +468,7 @@
 	struct nfs_fh	 fh;
 	struct nfs_fattr fattr;
 	long		res;
+	int		irix32 = NFS_SB(filp->f_vfsmnt->mnt_sb)->flags & NFS_MOUNT_IRIX32;
 
 	lock_kernel();
 
@@ -447,7 +487,10 @@
 	memset(desc, 0, sizeof(*desc));
 
 	desc->file = filp;
-	desc->target = filp->f_pos;
+	if (!irix32)
+		desc->target = filp->f_pos;
+	else
+		desc->target = (u32)filp->f_pos;
 	desc->decode = NFS_PROTO(inode)->decode_dirent;
 	desc->plus = NFS_USE_READDIRPLUS(inode);
 
diff -ru ../save/kernel-2.6.10/linux-2.6.10/fs/nfs/inode.c linux-2.6.10/fs/nfs/inode.c
--- ../save/kernel-2.6.10/linux-2.6.10/fs/nfs/inode.c	2004-12-24 22:35:24.000000000 +0100
+++ linux-2.6.10/fs/nfs/inode.c	2005-02-08 17:55:30.000000000 +0100
@@ -524,6 +524,7 @@
 		{ NFS_MOUNT_NOAC, ",noac", "" },
 		{ NFS_MOUNT_NONLM, ",nolock", ",lock" },
 		{ NFS_MOUNT_BROKEN_SUID, ",broken_suid", "" },
+		{ NFS_MOUNT_IRIX32, ",irix32", "" },
 		{ 0, NULL, NULL }
 	};
 	struct proc_nfs_info *nfs_infop;
diff -ru ../save/kernel-2.6.10/linux-2.6.10/include/linux/nfs_mount.h linux-2.6.10/include/linux/nfs_mount.h
--- ../save/kernel-2.6.10/linux-2.6.10/include/linux/nfs_mount.h	2004-12-24 22:33:49.000000000 +0100
+++ linux-2.6.10/include/linux/nfs_mount.h	2005-02-08 17:54:22.000000000 +0100
@@ -20,7 +20,7 @@
  * mount-to-kernel version compatibility.  Some of these aren't used yet
  * but here they are anyway.
  */
-#define NFS_MOUNT_VERSION	6
+#define NFS_MOUNT_VERSION	7
 #define NFS_MAX_CONTEXT_LEN	256
 
 struct nfs_mount_data {
@@ -60,6 +60,7 @@
 #define NFS_MOUNT_BROKEN_SUID	0x0400	/* 4 */
 #define NFS_MOUNT_STRICTLOCK	0x1000	/* reserved for NFSv4 */
 #define NFS_MOUNT_SECFLAVOUR	0x2000	/* 5 */
+#define NFS_MOUNT_IRIX32	0x4000	/* 7 */
 #define NFS_MOUNT_FLAGMASK	0xFFFF
 
 #endif
