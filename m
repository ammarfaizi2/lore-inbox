Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbUBICnt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 21:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264565AbUBICnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 21:43:49 -0500
Received: from ns.suse.de ([195.135.220.2]:48001 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264563AbUBICnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 21:43:47 -0500
Subject: Re: [BUG] With size > XATTR_SIZE_MAX, getxattr(2) always returns
	E2BIG
From: Andreas Gruenbacher <agruen@suse.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       "Theodore Ts'o" <tytso@thunk.org>
In-Reply-To: <20040209012657.GA1466@frodo>
References: <1075812739.21199.11.camel@E136.suse.de>
	 <20040209012657.GA1466@frodo>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1076294577.2205.68.camel@nb.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 09 Feb 2004 03:42:58 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-09 at 02:26, Nathan Scott wrote:
> On Tue, Feb 03, 2004 at 01:52:19PM +0100, Andreas Gruenbacher wrote:
> > Hello,
> > 
> > here is a fix for the getxattr and listxattr syscall. Explanation in the
> > patch. Could you please apply? Thanks.
> 
> Our regression tests tripped a couple of problems with this;
> here's a patch on top of yours (which is now 2.6.3-rc1).

Indeed, I got that case wrong. The patch looks correct. Thanks!

I would move the missing test right before the copy_to_user as below,
which is slightly better.


Index: linux-2.6.3-rc1.orig/fs/xattr.c
===================================================================
--- linux-2.6.3-rc1.orig.orig/fs/xattr.c
+++ linux-2.6.3-rc1.orig/fs/xattr.c
@@ -140,7 +140,7 @@ getxattr(struct dentry *d, char __user *
 			goto out;
 		error = d->d_inode->i_op->getxattr(d, kname, kvalue, size);
 		if (error > 0) {
-			if (copy_to_user(value, kvalue, error))
+			if (size && copy_to_user(value, kvalue, error))
 				error = -EFAULT;
 		} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
 			/* The file system tried to returned a value bigger
@@ -222,7 +222,7 @@ listxattr(struct dentry *d, char __user 
 			goto out;
 		error = d->d_inode->i_op->listxattr(d, klist, size);
 		if (error > 0) {
-			if (copy_to_user(list, klist, error))
+			if (size && copy_to_user(list, klist, error))
 				error = -EFAULT;
 		} else if (error == -ERANGE && size >= XATTR_LIST_MAX) {
 			/* The file system tried to returned a list bigger

> cheers.
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

