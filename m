Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbUBDSRW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 13:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbUBDSRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 13:17:22 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:51717 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263491AbUBDSRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 13:17:19 -0500
Date: Wed, 4 Feb 2004 18:17:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Steve Lord <lord@xfs.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-ID: <20040204181709.A21093@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steve Lord <lord@xfs.org>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <bv8qr7$m2v$1@news.cistron.nl> <20040129063009.GD2474@frodo> <bv8qr7$m2v$1@news.cistron.nl> <20040128222521.75a7d74f.akpm@osdl.org> <20040129063009.GD2474@frodo> <20040129232033.GA10541@cistron.nl> <20040204000315.A12127@infradead.org> <401FAC70.8070104@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <401FAC70.8070104@xfs.org>; from lord@xfs.org on Tue, Feb 03, 2004 at 08:13:04AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a new diff, that should get rid of all the warnings except for
O_DIRECT.  I've also addressed the comments from Dave and Steve.

Index: fs/xfs/linux-2.6/xfs_iops.c
===================================================================
RCS file: /cvs/linux-2.6-xfs/fs/xfs/linux-2.6/xfs_iops.c,v
retrieving revision 1.212
diff -u -p -r1.212 xfs_iops.c
--- fs/xfs/linux-2.6/xfs_iops.c	12 Dec 2003 04:17:52 -0000	1.212
+++ fs/xfs/linux-2.6/xfs_iops.c	4 Feb 2004 17:56:34 -0000
@@ -82,9 +82,14 @@ validate_fields(
 
 	va.va_mask = XFS_AT_NLINK|XFS_AT_SIZE|XFS_AT_NBLOCKS;
 	VOP_GETATTR(vp, &va, ATTR_LAZY, NULL, error);
-	ip->i_nlink = va.va_nlink;
-	ip->i_size = va.va_size;
-	ip->i_blocks = va.va_nblocks;
+	if (likely(!error)) {
+		ip->i_nlink = va.va_nlink;
+		ip->i_blocks = va.va_nblocks;
+
+		/* we're under i_sem so i_size can't change under us */
+		if (i_size_read(ip) != va.va_size)
+			i_size_write(ip, va.va_size);
+	}
 }
 
 /*
@@ -536,6 +541,7 @@ linvfs_setattr(
 	if (error)
 		return(-error);	/* Positive error up from XFS */
 	if (ia_valid & ATTR_SIZE) {
+		i_size_write(inode, vattr.va_size);
 		error = vmtruncate(inode, attr->ia_size);
 	}
 
Index: fs/xfs/linux-2.6/xfs_super.c
===================================================================
RCS file: /cvs/linux-2.6-xfs/fs/xfs/linux-2.6/xfs_super.c,v
retrieving revision 1.294
diff -u -p -r1.294 xfs_super.c
--- fs/xfs/linux-2.6/xfs_super.c	21 Jan 2004 16:46:06 -0000	1.294
+++ fs/xfs/linux-2.6/xfs_super.c	4 Feb 2004 17:56:55 -0000
@@ -178,7 +178,7 @@ xfs_revalidate_inode(
 	}
 	inode->i_blksize = PAGE_CACHE_SIZE;
 	inode->i_generation = ip->i_d.di_gen;
-	i_size_write(inode, ip->i_d.di_size);
+	inode->i_size = ip->i_d.di_size;
 	inode->i_blocks =
 		XFS_FSB_TO_BB(mp, ip->i_d.di_nblocks + ip->i_delayed_blks);
 	inode->i_atime.tv_sec	= ip->i_d.di_atime.t_sec;
Index: fs/xfs/linux-2.6/xfs_vnode.c
===================================================================
RCS file: /cvs/linux-2.6-xfs/fs/xfs/linux-2.6/xfs_vnode.c,v
retrieving revision 1.120
diff -u -p -r1.120 xfs_vnode.c
--- fs/xfs/linux-2.6/xfs_vnode.c	20 Oct 2003 02:08:58 -0000	1.120
+++ fs/xfs/linux-2.6/xfs_vnode.c	4 Feb 2004 17:56:55 -0000
@@ -213,7 +213,6 @@ vn_revalidate(
 		inode->i_mtime	    = va.va_mtime;
 		inode->i_ctime	    = va.va_ctime;
 		inode->i_atime	    = va.va_atime;
-		i_size_write(inode, va.va_size);
 		if (va.va_xflags & XFS_XFLAG_IMMUTABLE)
 			inode->i_flags |= S_IMMUTABLE;
 		else
