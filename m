Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVANSQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVANSQB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 13:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVANSQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 13:16:01 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:51941 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261260AbVANSPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:15:04 -0500
Message-ID: <41E80C1F.3070905@dgreaves.com>
Date: Fri, 14 Jan 2005 18:14:55 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Jakob Oestergaard <jakob@unthought.net>, Jan Kasprzak <kas@fi.muni.cz>,
       linux-kernel@vger.kernel.org, kruty@fi.muni.cz
Subject: Re: XFS: inode with st_mode == 0
References: <20041209125918.GO9994@fi.muni.cz> <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org> <20041221184304.GF16913@fi.muni.cz> <20041222084158.GG347@unthought.net> <20041222182344.GB14586@infradead.org>
In-Reply-To: <20041222182344.GB14586@infradead.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig wrote:

>>>	We have applied these two patches to 2.6.10-rc2, but this
>>>does not help. A few minutes ago I've got the "?----------" file
>>>again from my test script. This time it took >4 hours (it was
>>>about an hour or so without this patch).
>>>      
>>>
I'm seeing this problem occasionally too.

I'm running 2.6.10

The patch you provided below can be made to apply but I get:
LD .tmp_vmlinux1
fs/built-in.o(.text+0xa0ed3): In function `linvfs_decode_fh':
: undefined reference to `find_exported_dentry'

I assume that since you say:

> Btw, any chance you could
>try XFS CVS (which is at 2.6.9) + the patch below instead of plain 2.6.9,
>there have been various other fixes in the last months.
>  
>
That not all the changes in XFS CVS have made it to 2.6.10?

Is there a 2.6.10 patch that I could apply? Or do you have any other 
suggestions.

David

>
>Index: fs/xfs/xfs_vfsops.c
>===================================================================
>RCS file: /cvs/linux-2.6-xfs/fs/xfs/xfs_vfsops.c,v
>retrieving revision 1.459
>diff -u -p -r1.459 xfs_vfsops.c
>--- fs/xfs/xfs_vfsops.c	15 Dec 2004 04:56:58 -0000	1.459
>+++ fs/xfs/xfs_vfsops.c	16 Dec 2004 20:47:22 -0000
>@@ -1581,7 +1581,7 @@ xfs_syncsub(
> }
> 
> /*
>- * xfs_vget - called by DMAPI to get vnode from file handle
>+ * xfs_vget - called by DMAPI and NFSD to get vnode from file handle
>  */
> STATIC int
> xfs_vget(
>@@ -1623,7 +1623,7 @@ xfs_vget(
> 		return XFS_ERROR(EIO);
> 	}
> 
>-	if (ip->i_d.di_mode == 0 || (igen && (ip->i_d.di_gen != igen))) {
>+	if (ip->i_d.di_mode == 0 || ip->i_d.di_gen != igen) {
> 		xfs_iput_new(ip, XFS_ILOCK_SHARED);
> 		*vpp = NULL;
> 		return XFS_ERROR(ENOENT);
>Index: fs/xfs/linux-2.6/xfs_super.c
>===================================================================
>RCS file: /cvs/linux-2.6-xfs/fs/xfs/linux-2.6/xfs_super.c,v
>retrieving revision 1.321
>diff -u -p -r1.321 xfs_super.c
>--- fs/xfs/linux-2.6/xfs_super.c	9 Dec 2004 02:41:20 -0000	1.321
>+++ fs/xfs/linux-2.6/xfs_super.c	16 Dec 2004 20:47:23 -0000
>@@ -731,6 +731,39 @@ linvfs_get_dentry(
> 	return result;
> }
> 
>+STATIC struct dentry *
>+linvfs_decode_fh(
>+	struct super_block	*sb,
>+	__u32			*fh,
>+	int			fh_len,
>+	int			fileid_type,
>+	int (*acceptable)(
>+		void		*context,
>+		struct dentry	*de),
>+	void			*context)
>+{
>+	__u32 parent[2];
>+	parent[0] = parent[1] = 0;
>+	
>+	if (fh_len < 2 || fileid_type > 2)
>+		return NULL;
>+	
>+	if (fileid_type == 2 && fh_len > 2) {
>+		if (fh_len == 3) {
>+			printk(KERN_WARNING
>+			       "XFS: detected filehandle without "
>+			       "parent inode generation information.");
>+			return ERR_PTR(-ESTALE);
>+		}
>+			
>+		parent[0] = fh[2];
>+		parent[1] = fh[3];
>+	}
>+	
>+	return find_exported_dentry(sb, fh, parent, acceptable, context);
>+
>+}
>+
> STATIC int
> linvfs_show_options(
> 	struct seq_file		*m,
>@@ -893,6 +926,7 @@ linvfs_get_sb(
> 
> 
> STATIC struct export_operations linvfs_export_ops = {
>+	.decode_fh		= linvfs_decode_fh,
> 	.get_parent		= linvfs_get_parent,
> 	.get_dentry		= linvfs_get_dentry,
> };
>Index: include/linux/fs.h
>===================================================================
>RCS file: /cvs/linux-2.6-xfs/include/linux/fs.h,v
>retrieving revision 1.11
>diff -u -p -r1.11 fs.h
>--- include/linux/fs.h	1 Oct 2004 15:10:15 -0000	1.11
>+++ include/linux/fs.h	16 Dec 2004 20:47:25 -0000
>@@ -1115,6 +1115,10 @@ struct export_operations {
> 
> };
> 
>+extern struct dentry *
>+find_exported_dentry(struct super_block *sb, void *obj, void *parent,
>+		     int (*acceptable)(void *context, struct dentry *de),
>+		     void *context);
> 
> struct file_system_type {
> 	const char *name;
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

