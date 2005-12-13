Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbVLMIZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbVLMIZT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbVLMIZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:25:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:8836 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932561AbVLMIZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:25:02 -0500
Date: Tue, 13 Dec 2005 00:22:37 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       dsd@gentoo.org
Subject: [patch 08/26] Fix listxattr() for generic security attributes
Message-ID: <20051213082237.GI5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-listxattr-for-generic-security-attributes.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Daniel Drake <dsd@gentoo.org>

Commit f549d6c18c0e8e6cf1bf0e7a47acc1daf7e2cec1 introduced a generic
fallback for security xattrs, but appears to include a subtle bug.

Gentoo users with kernels with selinux compiled in, and coreutils compiled
with acl support, noticed that they could not copy files on tmpfs using
'cp'.

cp (compiled with acl support) copies the file, lists the extended
attributes on the old file, copies them all to the new file, and then
exits.  However the listxattr() calls were failing with this odd behaviour:

llistxattr("a.out", (nil), 0)           = 17
llistxattr("a.out", 0x7fffff8c6cb0, 17) = -1 ERANGE (Numerical result out of
range)

I believe this is a simple problem in the logic used to check the buffer
sizes; if the user sends a buffer the exact size of the data, then its ok
:)

This change solves the problem.
More info can be found at http://bugs.gentoo.org/113138

Signed-off-by: Daniel Drake <dsd@gentoo.org>
Acked-by: James Morris <jmorris@namei.org>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/xattr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.3.orig/fs/xattr.c
+++ linux-2.6.14.3/fs/xattr.c
@@ -243,7 +243,7 @@ listxattr(struct dentry *d, char __user 
 		error = d->d_inode->i_op->listxattr(d, klist, size);
 	} else {
 		error = security_inode_listsecurity(d->d_inode, klist, size);
-		if (size && error >= size)
+		if (size && error > size)
 			error = -ERANGE;
 	}
 	if (error > 0) {

--
