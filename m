Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318075AbSIESy2>; Thu, 5 Sep 2002 14:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318099AbSIESy2>; Thu, 5 Sep 2002 14:54:28 -0400
Received: from [195.223.140.120] ([195.223.140.120]:37488 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318075AbSIESy0>; Thu, 5 Sep 2002 14:54:26 -0400
Date: Thu, 5 Sep 2002 20:59:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       lord@sgi.com
Subject: Re: 2.4.20pre5aa1
Message-ID: <20020905185917.GG1657@dualathlon.random>
References: <20020904233528.GA1238@dualathlon.random> <20020905134414.A1784@infradead.org> <20020905165307.GC1254@dualathlon.random> <20020905180904.A8406@infradead.org> <20020905184125.GA1657@dualathlon.random> <20020905194649.A11789@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020905194649.A11789@infradead.org>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 07:46:49PM +0100, Christoph Hellwig wrote:
> On Thu, Sep 05, 2002 at 08:41:25PM +0200, Andrea Arcangeli wrote:
> > maybe I'm overlooking something but after a short read it seems you have
> > no lock in do_truncate->setattr like for all the other fs, so the
> > vmtruncate can run under reads and the i_size can change under you and
> > in turn you must always read it with i_size_read using asm, like all the
> > other fs, if you're not holding the i_sem (and you certainly aren't
> > holding the i_sem that frequently, you don't even for writes). this
> > because i_sem  is the only lock/sem hold by truncate.  Infact I'm unsure
> > how you serialize the i_size writes of truncate against the ones from
> > writes, that seems problematic too, the i_size could get a value past
> > the last block allocated (in turn corrupting the fs). Please double
> > check that I'm wrong, thanks.
> 
> I think we should take the XFS-specific inode lock around vmtruncate.
> Need to double-check with Steve.

this is the function I'm looking at and it's called with xfs specific
inode lock, and I don't see it grabbed either before calling vmtruncate:

+STATIC int
+linvfs_setattr(
+	struct dentry	*dentry,
+	struct iattr	*attr)
+{
+	struct inode	*inode = dentry->d_inode;
+	vnode_t		*vp = LINVFS_GET_VP(inode);
+	vattr_t		vattr;
+	unsigned int	ia_valid = attr->ia_valid;
+	int		error;
+	int		flags = 0;
+
+	memset(&vattr, 0, sizeof(vattr_t));
+	if (ia_valid & ATTR_UID) {
+		vattr.va_mask |= AT_UID;
+		vattr.va_uid = attr->ia_uid;
+	}
+	if (ia_valid & ATTR_GID) {
+		vattr.va_mask |= AT_GID;
+		vattr.va_gid = attr->ia_gid;
+	}
+	if (ia_valid & ATTR_SIZE) {
+		vattr.va_mask |= AT_SIZE;
+		vattr.va_size = attr->ia_size;
+	}
+	if (ia_valid & ATTR_ATIME) {
+		vattr.va_mask |= AT_ATIME;
+		vattr.va_atime.tv_sec = attr->ia_atime;
+		vattr.va_atime.tv_nsec = 0;
+	}
+	if (ia_valid & ATTR_MTIME) {
+		vattr.va_mask |= AT_MTIME;
+		vattr.va_mtime.tv_sec = attr->ia_mtime;
+		vattr.va_mtime.tv_nsec = 0;
+	}
+	if (ia_valid & ATTR_CTIME) {
+		vattr.va_mask |= AT_CTIME;
+		vattr.va_ctime.tv_sec = attr->ia_ctime;
+		vattr.va_ctime.tv_nsec = 0;
+	}
+	if (ia_valid & ATTR_MODE) {
+		vattr.va_mask |= AT_MODE;
+		vattr.va_mode = attr->ia_mode;
+		if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
+			inode->i_mode &= ~S_ISGID;
+	}
+
+	if (ia_valid & (ATTR_MTIME_SET | ATTR_ATIME_SET))
+		flags = ATTR_UTIME;
+
+	VOP_SETATTR(vp, &vattr, flags, NULL, error);
+	if (error)
+		return(-error); /* Positive error up from XFS */
+	if (ia_valid & ATTR_SIZE) {
+		error = vmtruncate(inode, attr->ia_size);
+	}
+
+	if (!error) {
+		vn_revalidate(vp, 0);
+		mark_inode_dirty_sync(inode);
+	}
+	return error;
+}

Andrea
