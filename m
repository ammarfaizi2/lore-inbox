Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUBIB2Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 20:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbUBIB2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 20:28:25 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:29525 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264538AbUBIB2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 20:28:23 -0500
Date: Mon, 9 Feb 2004 12:26:57 +1100
From: Nathan Scott <nathans@sgi.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@thunk.org>
Subject: Re: [BUG] With size > XATTR_SIZE_MAX, getxattr(2) always returns E2BIG
Message-ID: <20040209012657.GA1466@frodo>
References: <1075812739.21199.11.camel@E136.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075812739.21199.11.camel@E136.suse.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 01:52:19PM +0100, Andreas Gruenbacher wrote:
> Hello,
> 
> here is a fix for the getxattr and listxattr syscall. Explanation in the
> patch. Could you please apply? Thanks.

Our regression tests tripped a couple of problems with this;
here's a patch on top of yours (which is now 2.6.3-rc1).

cheers.

-- 
Nathan


--- /usr/tmp/TmpDir.13927-0/fs/xattr.c_1.2	2004-02-09 11:42:31.000000000 +1100
+++ fs/xattr.c	2004-02-09 11:37:39.747592560 +1100
@@ -139,7 +139,7 @@
 		if (error)
 			goto out;
 		error = d->d_inode->i_op->getxattr(d, kname, kvalue, size);
-		if (error > 0) {
+		if (size && error > 0) {
 			if (copy_to_user(value, kvalue, error))
 				error = -EFAULT;
 		} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
@@ -221,7 +221,7 @@
 		if (error)
 			goto out;
 		error = d->d_inode->i_op->listxattr(d, klist, size);
-		if (error > 0) {
+		if (size && error > 0) {
 			if (copy_to_user(list, klist, error))
 				error = -EFAULT;
 		} else if (error == -ERANGE && size >= XATTR_LIST_MAX) {
