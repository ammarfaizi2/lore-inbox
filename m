Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266211AbUBDADZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266212AbUBDADZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:03:25 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:54798 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266211AbUBDADW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:03:22 -0500
Date: Wed, 4 Feb 2004 00:03:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-ID: <20040204000315.A12127@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <bv8qr7$m2v$1@news.cistron.nl> <20040129063009.GD2474@frodo> <bv8qr7$m2v$1@news.cistron.nl> <20040128222521.75a7d74f.akpm@osdl.org> <20040129063009.GD2474@frodo> <20040129232033.GA10541@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040129232033.GA10541@cistron.nl>; from miquels@cistron.nl on Fri, Jan 30, 2004 at 12:20:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, what about this little patch?:


Index: fs/xfs/linux-2.6/xfs_iops.c
===================================================================
RCS file: /cvs/linux-2.6-xfs/fs/xfs/linux-2.6/xfs_iops.c,v
retrieving revision 1.212
diff -u -p -r1.212 xfs_iops.c
--- fs/xfs/linux-2.6/xfs_iops.c	12 Dec 2003 04:17:52 -0000	1.212
+++ fs/xfs/linux-2.6/xfs_iops.c	3 Feb 2004 23:56:17 -0000
@@ -80,11 +80,15 @@ validate_fields(
 	vattr_t		va;
 	int		error;
 
-	va.va_mask = XFS_AT_NLINK|XFS_AT_SIZE|XFS_AT_NBLOCKS;
+	va.va_mask = XFS_AT_NLINK|XFS_AT_SIZE|XFS_AT_NBLOCKS|XFS_AT_SIZE;
 	VOP_GETATTR(vp, &va, ATTR_LAZY, NULL, error);
 	ip->i_nlink = va.va_nlink;
 	ip->i_size = va.va_size;
 	ip->i_blocks = va.va_nblocks;
+
+	/* we're under i_sem so i_size can't change under us */
+	if (i_size_read(ip) != va.va_size)
+		i_size_write(ip, va.va_size);
 }
 
 /*
@@ -186,8 +190,7 @@ linvfs_mknod(
 
 		if (S_ISCHR(mode) || S_ISBLK(mode))
 			ip->i_rdev = rdev;
-		else if (S_ISDIR(mode))
-			validate_fields(ip);
+		validate_fields(ip);
 		d_instantiate(dentry, ip);
 		validate_fields(dir);
 	}
@@ -536,6 +539,7 @@ linvfs_setattr(
 	if (error)
 		return(-error);	/* Positive error up from XFS */
 	if (ia_valid & ATTR_SIZE) {
+		i_size_write(inode, vattr.va_size);
 		error = vmtruncate(inode, attr->ia_size);
 	}
 
Index: fs/xfs/linux-2.6/xfs_vnode.c
===================================================================
RCS file: /cvs/linux-2.6-xfs/fs/xfs/linux-2.6/xfs_vnode.c,v
retrieving revision 1.120
diff -u -p -r1.120 xfs_vnode.c
--- fs/xfs/linux-2.6/xfs_vnode.c	20 Oct 2003 02:08:58 -0000	1.120
+++ fs/xfs/linux-2.6/xfs_vnode.c	3 Feb 2004 23:56:17 -0000
@@ -213,7 +213,6 @@ vn_revalidate(
 		inode->i_mtime	    = va.va_mtime;
 		inode->i_ctime	    = va.va_ctime;
 		inode->i_atime	    = va.va_atime;
-		i_size_write(inode, va.va_size);
 		if (va.va_xflags & XFS_XFLAG_IMMUTABLE)
 			inode->i_flags |= S_IMMUTABLE;
 		else
