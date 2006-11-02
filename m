Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWKBV5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWKBV5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWKBV5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:57:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:41358 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750991AbWKBV5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:57:43 -0500
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix user.* xattr permission check for sticky dirs
Date: Thu, 2 Nov 2006 22:51:21 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Gerard Neil <xyzzy@devferret.org>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>
References: <200611021724.02886.agruen@suse.de> <20061102112741.e1bb88c9.akpm@osdl.org>
In-Reply-To: <20061102112741.e1bb88c9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611022251.21816.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 November 2006 20:27, Andrew Morton wrote:
> On Thu, 2 Nov 2006 17:24:02 +0100
>
> Andreas Gruenbacher <agruen@suse.de> wrote:
> > The user.* extended attributes are only allowed on regular files and
> > directories. Sticky directories further restrict write access to the
> > owner and privileged users. (See the attr(5) man page for an
> > explanation.)
> >
> > The original check in ext2/ext3 when user.* xattrs were merged was more
> > restrictive than intended, and when the xattr permission checks were
> > moved into the VFS, read access to user.* attributes on sticky directores
> > ended up being denied in addition.
>
> Am struggling to understand the impact of this.  I assume this problem was
> introduced on Jan 9 by e0ad7b073eb7317e5afe0385b02dcb1d52a1eedf "move xattr
> permission checks into the VFS"?

Commits e0ad7b073eb7317e5afe0385b02dcb1d52a1eedf and 
c37ef806a3e1c0bca65fd03b7590d56d19625da4 move the following check from 
ext3_xattr_user_set() to xattr_permission(), which is used in vfs_getxattr() 
as well as xfs_setxattr() and vfs_removexattr(), so this added the check to 
the xfs_getxattr() path by accident:

[]	if (!S_ISREG(inode->i_mode) &&
[]	    (!S_ISDIR(inode->i_mode) || inode->i_mode & S_ISVTX))
[]		return -EPERM;

The check itself completely forbids user.* xattrs for sticky directories 
already though, and this conflicts with the xattr(5) manual page as well as 
the xfs code. It looks as if the ckeck was more strict than intended since 
forever. The patch I have sent relaxes the unintended restriction.

> If so, the fix is applicable to 2.6.18, 2.6.19 and of course 2.6.20.

... and further back.

> But to which of those should it be applied?

I don't think we'll need backports; this doesn't address a security problem.

Thanks,
Andreas
