Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbTHaEoQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 00:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbTHaEoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 00:44:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:54493 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262448AbTHaEoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 00:44:14 -0400
Date: Sat, 30 Aug 2003 21:47:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruen@suse.de>
Subject: Re: 2.6.0-test4-mm3.1 oops with ext3 extended attributes on R/O
 filesystem
Message-Id: <20030830214751.5baaab4c.akpm@osdl.org>
In-Reply-To: <200308310412.h7V4Cxd7013786@turing-police.cc.vt.edu>
References: <200308310412.h7V4Cxd7013786@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> Working on installing SELINUX, and I get to the part where all the file labels
>  get added.  Unfortunately, I had some file systems mounted R/O (intentionally,
>  forgot to mount them R/W for this).  The ext3 code upchucked while trying
>  to set extended attributes on the filesystem it couldn't write to.

Thanks.   It's a very straightforward bug; I'll fix it with the below patch.

A wider question is whether we should have got this far into the filesystem
code if the fs is mounted read-only.  A check right up at the VFS
setxattr() level might make sense.

Regardless of that, this fix is needed because journal_start() could fail
for other reasons.


diff -puN fs/ext3/xattr.c~ext3-xattr-oops-fix fs/ext3/xattr.c
--- 25/fs/ext3/xattr.c~ext3-xattr-oops-fix	2003-08-30 21:41:24.000000000 -0700
+++ 25-akpm/fs/ext3/xattr.c	2003-08-30 21:42:41.000000000 -0700
@@ -873,17 +873,22 @@ ext3_xattr_set(struct inode *inode, int 
 	       const void *value, size_t value_len, int flags)
 {
 	handle_t *handle;
-	int error, error2;
+	int error;
 
 	handle = ext3_journal_start(inode, EXT3_DATA_TRANS_BLOCKS);
-	if (IS_ERR(handle))
+	if (IS_ERR(handle)) {
 		error = PTR_ERR(handle);
-	else
+	} else {
+		int error2;
+
 		error = ext3_xattr_set_handle(handle, inode, name_index, name,
 					      value, value_len, flags);
-	error2 = ext3_journal_stop(handle);
+		error2 = ext3_journal_stop(handle);
+		if (error == 0)
+			error = error2;
+	}
 
-	return error ? error : error2;
+	return error;
 }
 
 /*

_

