Return-Path: <linux-kernel-owner+w=401wt.eu-S1752842AbWLOQYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbWLOQYc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbWLOQYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:24:32 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:46841 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbWLOQYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:24:30 -0500
Date: Fri, 15 Dec 2006 10:24:28 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: jsipek@fsl.cs.sunysb.edu, Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "TREVOR S. HIGHLAND" <tshighla@us.ibm.com>
Subject: [PATCH] fsstack: Remove inode copy
Message-ID: <20061215162428.GA3570@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trevor found a file size problem in eCryptfs in recent kernels, and he
tracked it down to an fsstack change.

This was the eCryptfs copy_attr_all:

> -void ecryptfs_copy_attr_all(struct inode *dest, const struct inode *src)
> -{
> -       dest->i_mode = src->i_mode;
> -       dest->i_nlink = src->i_nlink;
> -       dest->i_uid = src->i_uid;
> -       dest->i_gid = src->i_gid;
> -       dest->i_rdev = src->i_rdev;
> -       dest->i_atime = src->i_atime;
> -       dest->i_mtime = src->i_mtime;
> -       dest->i_ctime = src->i_ctime;
> -       dest->i_blkbits = src->i_blkbits;
> -       dest->i_flags = src->i_flags;
> -}

This is the fsstack copy_attr_all:

> +void fsstack_copy_attr_all(struct inode *dest, const struct inode *src,
> +                               int (*get_nlinks)(struct inode *))
> +{
> +       if (!get_nlinks)
> +               dest->i_nlink = src->i_nlink;
> +       else
> +               dest->i_nlink = (*get_nlinks)(dest);
> +
> +       dest->i_mode = src->i_mode;
> +       dest->i_uid = src->i_uid;
> +       dest->i_gid = src->i_gid;
> +       dest->i_rdev = src->i_rdev;
> +       dest->i_atime = src->i_atime;
> +       dest->i_mtime = src->i_mtime;
> +       dest->i_ctime = src->i_ctime;
> +       dest->i_blkbits = src->i_blkbits;
> +       dest->i_flags = src->i_flags;
> +
> +       fsstack_copy_inode_size(dest, src);
> +}

The addition of copy_inode_size breaks eCryptfs, since eCryptfs needs
to interpolate the file sizes (eCryptfs has extra space in the lower
file for the header). The setting of the upper inode size occurs
elsewhere in eCryptfs, and the new copy_attr_all now undoes what
eCryptfs was doing right beforehand.

I see three ways of going forward from here. (1) Something like this
patch needs to go in (assuming it jives with Unionfs), (2) we need to
make a change to the fsstack API for more fine-grained control over
copying attributes (e.g., by also including a callback function for
calculating the right file size, which will require some more work on
both eCryptfs and Unionfs), or (3) the fsstack patch on eCryptfs
(commit 0cc72dc7f050188d8d7344b1dd688cbc68d3cd30 made on Fri Dec 8
02:36:31 2006 -0800) needs to be yanked in 2.6.20.

I think the simplest solution, from eCryptfs' perspective, is to just
remove the inode size copy. Jeff, please let me know if this approach
will work for you, or let me know if you have another idea.

Thanks,
Mike

---

Remove inode size copy in general fsstack attr copy code. Stacked
filesystems may need to interpolate the inode size, since the file
size in the lower file may be different than the file size in the
stacked layer.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/stack.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

97582cdc0c45a37fb75488a96b02995a7b28364d
diff --git a/fs/stack.c b/fs/stack.c
index 5ddbc34..8ffb880 100644
--- a/fs/stack.c
+++ b/fs/stack.c
@@ -34,7 +34,5 @@ void fsstack_copy_attr_all(struct inode 
 	dest->i_ctime = src->i_ctime;
 	dest->i_blkbits = src->i_blkbits;
 	dest->i_flags = src->i_flags;
-
-	fsstack_copy_inode_size(dest, src);
 }
 EXPORT_SYMBOL_GPL(fsstack_copy_attr_all);
-- 
1.3.3

