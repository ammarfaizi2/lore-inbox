Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUD0SUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUD0SUn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUD0SKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:10:09 -0400
Received: from ns.suse.de ([195.135.220.2]:49133 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264251AbUD0SHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:07:38 -0400
Subject: Re: [PATCH] Return more useful error number when acls are too large
From: Andreas Gruenbacher <agruen@suse.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040427112440.B604510@wobbly.melbourne.sgi.com>
References: <1082973939.3295.16.camel@winden.suse.de>
	 <20040427112440.B604510@wobbly.melbourne.sgi.com>
Content-Type: multipart/mixed; boundary="=-DVLoEMfP8PouRNVgpMx1"
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1083089256.19655.284.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 27 Apr 2004 20:07:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DVLoEMfP8PouRNVgpMx1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-04-27 at 03:24, Nathan Scott wrote:
> hi Andreas,
> 
> On Mon, Apr 26, 2004 at 12:27:58PM +0200, Andreas Gruenbacher wrote:
> > Hello,
> > 
> > could you please add this to mainline? Getting EINVAL when an acl
> > becomes too large is quite confusing.
> > 
> >   	if (acl) {
> >  		if (acl->a_count > EXT2_ACL_MAX_ENTRIES)
> > -			return -EINVAL;
> > +			return -ENOSPC;
> 
> That seems an odd error code to change it to, since its not
> related to the device running out of free space right?  Maybe
> use -E2BIG instead?

I don't see a problem with giving ENOSPC this particular meaning here.
The error number used must be among those defined for NFSv3, so E2BIG
won't do.

> XFS has a similar check (different limit as you know), so is
> also affected by this; could you update XFS at the same time
> with whatever value gets chosen, if its not EINVAL?  Or just
> let me know what gets chosen & I'll fix it up later.

I think this patch is correct for xfs. Nathan, would you mind to
double-check? Thanks.


Index: linux-2.6.6-rc2/fs/xfs/xfs_acl.c
===================================================================
--- linux-2.6.6-rc2.orig/fs/xfs/xfs_acl.c
+++ linux-2.6.6-rc2/fs/xfs/xfs_acl.c
@@ -148,10 +148,7 @@ posix_acl_xattr_to_xfs(
 			return EINVAL;
 		}
 	}
-	if (xfs_acl_invalid(dest))
-		return EINVAL;
-
-	return 0;
+	return xfs_acl_invalid(dest);
 }
 
 /*
@@ -249,10 +246,9 @@ xfs_acl_vget(
 	if (!size) {
 		error = -posix_acl_xattr_size(XFS_ACL_MAX_ENTRIES);
 	} else {
-		if (xfs_acl_invalid(xfs_acl)) {
-			error = EINVAL;
+		error = xfs_acl_invalid(xfs_acl);
+		if (error)
 			goto out;
-		}
 		if (kind == _ACL_TYPE_ACCESS) {
 			vattr_t	va;
 
@@ -590,7 +586,7 @@ xfs_acl_invalid(
 		goto acl_invalid;
 
 	if (aclp->acl_cnt > XFS_ACL_MAX_ENTRIES)
-		goto acl_invalid;
+		return ENOSPC;
 
 	for (i = 0; i < aclp->acl_cnt; i++) {
 		entry = &aclp->acl_entry[i];


Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

--=-DVLoEMfP8PouRNVgpMx1
Content-Disposition: attachment; filename=acl-too-large-2
Content-Type: text/x-patch; name=acl-too-large-2; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6.6-rc2/fs/xfs/xfs_acl.c
===================================================================
--- linux-2.6.6-rc2.orig/fs/xfs/xfs_acl.c
+++ linux-2.6.6-rc2/fs/xfs/xfs_acl.c
@@ -148,10 +148,7 @@ posix_acl_xattr_to_xfs(
 			return EINVAL;
 		}
 	}
-	if (xfs_acl_invalid(dest))
-		return EINVAL;
-
-	return 0;
+	return xfs_acl_invalid(dest);
 }
 
 /*
@@ -249,10 +246,9 @@ xfs_acl_vget(
 	if (!size) {
 		error = -posix_acl_xattr_size(XFS_ACL_MAX_ENTRIES);
 	} else {
-		if (xfs_acl_invalid(xfs_acl)) {
-			error = EINVAL;
+		error = xfs_acl_invalid(xfs_acl);
+		if (error)
 			goto out;
-		}
 		if (kind == _ACL_TYPE_ACCESS) {
 			vattr_t	va;
 
@@ -590,7 +586,7 @@ xfs_acl_invalid(
 		goto acl_invalid;
 
 	if (aclp->acl_cnt > XFS_ACL_MAX_ENTRIES)
-		goto acl_invalid;
+		return ENOSPC;
 
 	for (i = 0; i < aclp->acl_cnt; i++) {
 		entry = &aclp->acl_entry[i];

--=-DVLoEMfP8PouRNVgpMx1--

