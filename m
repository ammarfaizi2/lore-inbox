Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbUKSLRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbUKSLRf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 06:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbUKSLRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 06:17:32 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:21256 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261260AbUKSLRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 06:17:17 -0500
Date: Fri, 19 Nov 2004 11:17:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Neil Brown <neilb@cse.unsw.edu.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 nfsd crashing often
Message-ID: <20041119111715.GA3282@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Neil Brown <neilb@cse.unsw.edu.au>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20041118173504.GA24187@cirrus.madduck.net> <16797.31183.853387.514386@cse.unsw.edu.au> <20041119084458.GA1191@cirrus.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119084458.GA1191@cirrus.madduck.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 09:44:58AM +0100, martin f krafft wrote:
> also sprach Neil Brown <neilb@cse.unsw.edu.au> [2004.11.19.0542 +0100]:
> > >   Call Trace:
> > >   [<c0166197>] __lookup_hash+0xa7/0xe0
> > 
> > Looks like i_op->lookup == NULL, and I don't think nfsd could do that.
> > 
> > What filesystem are you using?
> 
> XFS.
> 
> Thanks for following up!

Care to check whether it goes away with the patch below?
(also I'm not sure 2.6.9 has all the relevant xfs and nfsd fixes,
updating to 2.6.10-rc is a good idea)


Index: fs/xfs/xfs_dmapi.c
===================================================================
RCS file: /cvs/linux-2.6-xfs/fs/xfs/xfs_dmapi.c,v
retrieving revision 1.108
diff -u -p -r1.108 xfs_dmapi.c
--- fs/xfs/xfs_dmapi.c	28 Oct 2004 22:43:01 -0000	1.108
+++ fs/xfs/xfs_dmapi.c	18 Nov 2004 13:01:48 -0000
@@ -2666,8 +2666,10 @@ xfs_dm_set_fileattr(
 	}
 
 	VOP_SETATTR(vp, &vat, ATTR_DMI, NULL, error);
-	if (!error)
-		vn_revalidate(vp);	/* update Linux inode flags */
+	if (!error) {
+		vn_revalidate_core(vp, &vat);
+		VUNMODIFY(vp);
+	}
 	return(-error); /* Return negative error to DMAPI */
 }
 
Index: fs/xfs/xfs_vnodeops.c
===================================================================
RCS file: /cvs/linux-2.6-xfs/fs/xfs/xfs_vnodeops.c,v
retrieving revision 1.636
diff -u -p -r1.636 xfs_vnodeops.c
--- fs/xfs/xfs_vnodeops.c	30 Sep 2004 03:40:12 -0000	1.636
+++ fs/xfs/xfs_vnodeops.c	18 Nov 2004 13:01:50 -0000
@@ -909,6 +909,9 @@ xfs_setattr(
 				 mandlock_after);
 	}
 
+	vap->va_mask = XFS_AT_STAT|XFS_AT_XFLAGS;
+	code = xfs_getattr(bdp, vap, ATTR_LAZY, credp);
+
 	xfs_iunlock(ip, lock_flags);
 
 	/*
@@ -929,6 +932,7 @@ xfs_setattr(
 					NULL, DM_RIGHT_NULL, NULL, NULL,
 					0, 0, AT_DELAY_FLAG(flags));
 	}
+
 	return 0;
 
  abort_return:
Index: fs/xfs/linux-2.6/xfs_file.c
===================================================================
RCS file: /cvs/linux-2.6-xfs/fs/xfs/linux-2.6/xfs_file.c,v
retrieving revision 1.109
diff -u -p -r1.109 xfs_file.c
--- fs/xfs/linux-2.6/xfs_file.c	26 Oct 2004 22:56:13 -0000	1.109
+++ fs/xfs/linux-2.6/xfs_file.c	18 Nov 2004 13:01:51 -0000
@@ -409,8 +409,11 @@ linvfs_file_mmap(
 	vma->vm_ops = &linvfs_file_vm_ops;
 
 	VOP_SETATTR(vp, &va, XFS_AT_UPDATIME, NULL, error);
-	if (!error)
-		vn_revalidate(vp);	/* update Linux inode flags */
+	if (!error) {
+		vn_revalidate_core(vp, &va);
+		VUNMODIFY(vp);
+	}
+
 	return 0;
 }
 
Index: fs/xfs/linux-2.6/xfs_ioctl.c
===================================================================
RCS file: /cvs/linux-2.6-xfs/fs/xfs/linux-2.6/xfs_ioctl.c,v
retrieving revision 1.116
diff -u -p -r1.116 xfs_ioctl.c
--- fs/xfs/linux-2.6/xfs_ioctl.c	27 Oct 2004 12:06:24 -0000	1.116
+++ fs/xfs/linux-2.6/xfs_ioctl.c	18 Nov 2004 13:01:51 -0000
@@ -1102,8 +1102,10 @@ xfs_ioc_xattr(
 		va.va_extsize = fa.fsx_extsize;
 
 		VOP_SETATTR(vp, &va, attr_flags, NULL, error);
-		if (!error)
-			vn_revalidate(vp);	/* update Linux inode flags */
+		if (!error) {
+			vn_revalidate_core(vp, &va);
+			VUNMODIFY(vp);
+		}
 		return -error;
 	}
 
@@ -1147,8 +1149,10 @@ xfs_ioc_xattr(
 				xfs_dic2xflags(&ip->i_d, ARCH_NOCONVERT));
 
 		VOP_SETATTR(vp, &va, attr_flags, NULL, error);
-		if (!error)
-			vn_revalidate(vp);	/* update Linux inode flags */
+		if (!error) {
+			vn_revalidate_core(vp, &va);
+			VUNMODIFY(vp);
+		}
 		return -error;
 	}
 
Index: fs/xfs/linux-2.6/xfs_iops.c
===================================================================
RCS file: /cvs/linux-2.6-xfs/fs/xfs/linux-2.6/xfs_iops.c,v
retrieving revision 1.223
diff -u -p -r1.223 xfs_iops.c
--- fs/xfs/linux-2.6/xfs_iops.c	1 Oct 2004 05:55:52 -0000	1.223
+++ fs/xfs/linux-2.6/xfs_iops.c	18 Nov 2004 13:01:51 -0000
@@ -531,11 +531,10 @@ linvfs_setattr(
 		vattr.va_mask |= XFS_AT_CTIME;
 		vattr.va_ctime = attr->ia_ctime;
 	}
+
 	if (ia_valid & ATTR_MODE) {
 		vattr.va_mask |= XFS_AT_MODE;
 		vattr.va_mode = attr->ia_mode;
-		if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
-			inode->i_mode &= ~S_ISGID;
 	}
 
 	if (ia_valid & (ATTR_MTIME_SET | ATTR_ATIME_SET))
@@ -546,10 +545,11 @@ linvfs_setattr(
 #endif
 
 	VOP_SETATTR(vp, &vattr, flags, NULL, error);
-	if (error)
-		return -error;
-	vn_revalidate(vp);
-	return error;
+	if (!error) {
+		vn_revalidate_core(vp, &vattr);
+		VUNMODIFY(vp);
+	}
+	return -error;
 }
 
 STATIC void
