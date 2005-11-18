Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVKRDTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVKRDTj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 22:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVKRDTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 22:19:39 -0500
Received: from ozlabs.org ([203.10.76.45]:24724 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751428AbVKRDTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 22:19:38 -0500
Date: Fri, 18 Nov 2005 14:19:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix error handling with put_compat_statfs()
Message-ID: <20051118031924.GB20346@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.

In fs/compat.c, whenever put_compat_statfs() returns an error, the
containing syscall returns -EFAULT.  This is presumably by analogy
with the non-compat case, where any non-zero code from copy_to_user()
should be translated into an EFAULT.  However, put_compat_statfs() is
differnet - it already returns -EFAULT in genuine fault cases, and can
also return -EOVERFLOW.  The same applies for put_compat_statfs64().

This bug can be observed with a statfs() on a hugetlbfs directory.
hugetlbfs, when mounted without limits reports available, free and
total blocks as -1 (itself a bug, another patch coming).  statfs()
will mysteriously return EFAULT although it's parameters are perfectly
valid addresses.

This patch causes the compat versions of statfs() and statfs64() to
correctly propogate the return values from put_compat_statfs() and
put_compat_statfs64().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/fs/compat.c
===================================================================
--- working-2.6.orig/fs/compat.c	2005-11-08 10:57:20.000000000 +1100
+++ working-2.6/fs/compat.c	2005-11-18 14:12:06.000000000 +1100
@@ -168,8 +168,8 @@
 	if (!error) {
 		struct kstatfs tmp;
 		error = vfs_statfs(nd.dentry->d_inode->i_sb, &tmp);
-		if (!error && put_compat_statfs(buf, &tmp))
-			error = -EFAULT;
+		if (!error)
+			error = put_compat_statfs(buf, &tmp);
 		path_release(&nd);
 	}
 	return error;
@@ -186,8 +186,8 @@
 	if (!file)
 		goto out;
 	error = vfs_statfs(file->f_dentry->d_inode->i_sb, &tmp);
-	if (!error && put_compat_statfs(buf, &tmp))
-		error = -EFAULT;
+	if (!error)
+		error = put_compat_statfs(buf, &tmp);
 	fput(file);
 out:
 	return error;
@@ -236,8 +236,8 @@
 	if (!error) {
 		struct kstatfs tmp;
 		error = vfs_statfs(nd.dentry->d_inode->i_sb, &tmp);
-		if (!error && put_compat_statfs64(buf, &tmp))
-			error = -EFAULT;
+		if (!error)
+			error = put_compat_statfs64(buf, &tmp);
 		path_release(&nd);
 	}
 	return error;
@@ -257,8 +257,8 @@
 	if (!file)
 		goto out;
 	error = vfs_statfs(file->f_dentry->d_inode->i_sb, &tmp);
-	if (!error && put_compat_statfs64(buf, &tmp))
-		error = -EFAULT;
+	if (!error)
+		error = put_compat_statfs64(buf, &tmp);
 	fput(file);
 out:
 	return error;


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
