Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbULVSYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbULVSYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 13:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbULVSYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 13:24:40 -0500
Received: from [213.146.154.40] ([213.146.154.40]:41911 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262008AbULVSXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 13:23:48 -0500
Date: Wed, 22 Dec 2004 18:23:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jakob Oestergaard <jakob@unthought.net>, Jan Kasprzak <kas@fi.muni.cz>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       kruty@fi.muni.cz
Subject: Re: XFS: inode with st_mode == 0
Message-ID: <20041222182344.GB14586@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jakob Oestergaard <jakob@unthought.net>,
	Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org,
	kruty@fi.muni.cz
References: <20041209125918.GO9994@fi.muni.cz> <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org> <20041221184304.GF16913@fi.muni.cz> <20041222084158.GG347@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222084158.GG347@unthought.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 09:41:58AM +0100, Jakob Oestergaard wrote:
> On Tue, Dec 21, 2004 at 07:43:04PM +0100, Jan Kasprzak wrote:
> ...
> > : 
> > : No, the problem I've fixed was related to XFS getting the inode version
> > : number wrong - or at least different than NFSD expects.
> > : 
> > 	We have applied these two patches to 2.6.10-rc2, but this
> > does not help. A few minutes ago I've got the "?----------" file
> > again from my test script. This time it took >4 hours (it was
> > about an hour or so without this patch).
> 
> I run the patch on 2.6.9 - it solved the problem in the common case.
> Before the patch, I was unable to complete a "cvs checkout" of a
> moderately large tree - would end up with undeletable directories and
> lots of other weird things...  After the patch, I can run cvs checkout.
> 
> However, we still see the problem - so the patch does not solve this
> completely, as you have observed as well.
> 
> Our most common situation is that a new file gets created as a symlink
> pointing to itself, instead of as a regular file.
> 
> It also happens regularly, that a command (be it cvs, etags, ld or
> something else) reports EINVAL when attempting to create/write a file.
> 
> So, status on my side is;  things still suck, but they suck less than on
> vanilla 2.6.9

I have a better patch than the one I gave you (attached below).  If you
send me a mail with steps to reproduce your remaining problems I'll put
this very high on my TODO list after christmas.  Btw, any chance you could
try XFS CVS (which is at 2.6.9) + the patch below instead of plain 2.6.9,
there have been various other fixes in the last months.


Index: fs/xfs/xfs_vfsops.c
===================================================================
RCS file: /cvs/linux-2.6-xfs/fs/xfs/xfs_vfsops.c,v
retrieving revision 1.459
diff -u -p -r1.459 xfs_vfsops.c
--- fs/xfs/xfs_vfsops.c	15 Dec 2004 04:56:58 -0000	1.459
+++ fs/xfs/xfs_vfsops.c	16 Dec 2004 20:47:22 -0000
@@ -1581,7 +1581,7 @@ xfs_syncsub(
 }
 
 /*
- * xfs_vget - called by DMAPI to get vnode from file handle
+ * xfs_vget - called by DMAPI and NFSD to get vnode from file handle
  */
 STATIC int
 xfs_vget(
@@ -1623,7 +1623,7 @@ xfs_vget(
 		return XFS_ERROR(EIO);
 	}
 
-	if (ip->i_d.di_mode == 0 || (igen && (ip->i_d.di_gen != igen))) {
+	if (ip->i_d.di_mode == 0 || ip->i_d.di_gen != igen) {
 		xfs_iput_new(ip, XFS_ILOCK_SHARED);
 		*vpp = NULL;
 		return XFS_ERROR(ENOENT);
Index: fs/xfs/linux-2.6/xfs_super.c
===================================================================
RCS file: /cvs/linux-2.6-xfs/fs/xfs/linux-2.6/xfs_super.c,v
retrieving revision 1.321
diff -u -p -r1.321 xfs_super.c
--- fs/xfs/linux-2.6/xfs_super.c	9 Dec 2004 02:41:20 -0000	1.321
+++ fs/xfs/linux-2.6/xfs_super.c	16 Dec 2004 20:47:23 -0000
@@ -731,6 +731,39 @@ linvfs_get_dentry(
 	return result;
 }
 
+STATIC struct dentry *
+linvfs_decode_fh(
+	struct super_block	*sb,
+	__u32			*fh,
+	int			fh_len,
+	int			fileid_type,
+	int (*acceptable)(
+		void		*context,
+		struct dentry	*de),
+	void			*context)
+{
+	__u32 parent[2];
+	parent[0] = parent[1] = 0;
+	
+	if (fh_len < 2 || fileid_type > 2)
+		return NULL;
+	
+	if (fileid_type == 2 && fh_len > 2) {
+		if (fh_len == 3) {
+			printk(KERN_WARNING
+			       "XFS: detected filehandle without "
+			       "parent inode generation information.");
+			return ERR_PTR(-ESTALE);
+		}
+			
+		parent[0] = fh[2];
+		parent[1] = fh[3];
+	}
+	
+	return find_exported_dentry(sb, fh, parent, acceptable, context);
+
+}
+
 STATIC int
 linvfs_show_options(
 	struct seq_file		*m,
@@ -893,6 +926,7 @@ linvfs_get_sb(
 
 
 STATIC struct export_operations linvfs_export_ops = {
+	.decode_fh		= linvfs_decode_fh,
 	.get_parent		= linvfs_get_parent,
 	.get_dentry		= linvfs_get_dentry,
 };
Index: include/linux/fs.h
===================================================================
RCS file: /cvs/linux-2.6-xfs/include/linux/fs.h,v
retrieving revision 1.11
diff -u -p -r1.11 fs.h
--- include/linux/fs.h	1 Oct 2004 15:10:15 -0000	1.11
+++ include/linux/fs.h	16 Dec 2004 20:47:25 -0000
@@ -1115,6 +1115,10 @@ struct export_operations {
 
 };
 
+extern struct dentry *
+find_exported_dentry(struct super_block *sb, void *obj, void *parent,
+		     int (*acceptable)(void *context, struct dentry *de),
+		     void *context);
 
 struct file_system_type {
 	const char *name;
