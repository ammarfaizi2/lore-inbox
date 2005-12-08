Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbVLHQEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVLHQEl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVLHQEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:04:40 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:39131 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751209AbVLHQEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:04:40 -0500
Message-ID: <43985B9D.60506@gentoo.org>
Date: Thu, 08 Dec 2005 16:13:17 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051205)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, sds@tycho.nsa.gov, jmorris@namei.org
Subject: [PATCH] Fix listxattr() for generic security attributes
Content-Type: multipart/mixed;
 boundary="------------030906030802020000090108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030906030802020000090108
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Commit f549d6c18c0e8e6cf1bf0e7a47acc1daf7e2cec1 introduced a generic fallback 
for security xattrs, but appears to include a subtle bug.

Gentoo users with kernels with selinux compiled in, and coreutils compiled 
with acl support, noticed that they could not copy files on tmpfs using 'cp'.

cp (compiled with acl support) copies the file, lists the extended attributes 
on the old file, copies them all to the new file, and then exits. However the 
listxattr() calls were failing with this odd behaviour:

llistxattr("a.out", (nil), 0)           = 17
llistxattr("a.out", 0x7fffff8c6cb0, 17) = -1 ERANGE (Numerical result out of 
range)

I believe this is a simple problem in the logic used to check the buffer 
sizes; if the user sends a buffer the exact size of the data, then its ok :)

This patch solves the problem. Please apply for 2.6.15.
More info can be found at http://bugs.gentoo.org/113138

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--------------030906030802020000090108
Content-Type: text/x-patch;
 name="xattr-security-bounds-check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xattr-security-bounds-check.patch"

--- linux/fs/xattr.c.orig	2005-12-08 11:48:31.000000000 +0000
+++ linux/fs/xattr.c	2005-12-08 11:48:50.000000000 +0000
@@ -243,7 +243,7 @@ listxattr(struct dentry *d, char __user 
 		error = d->d_inode->i_op->listxattr(d, klist, size);
 	} else {
 		error = security_inode_listsecurity(d->d_inode, klist, size);
-		if (size && error >= size)
+		if (size && error > size)
 			error = -ERANGE;
 	}
 	if (error > 0) {

--------------030906030802020000090108--
