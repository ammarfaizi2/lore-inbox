Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276768AbRJBXDh>; Tue, 2 Oct 2001 19:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276770AbRJBXD0>; Tue, 2 Oct 2001 19:03:26 -0400
Received: from kaa.perlsupport.com ([205.245.149.25]:30227 "EHLO
	kaa.perlsupport.com") by vger.kernel.org with ESMTP
	id <S276768AbRJBXDI>; Tue, 2 Oct 2001 19:03:08 -0400
Date: Tue, 2 Oct 2001 16:03:34 -0700
From: Chip Salzenberg <chip@pobox.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        David Mazieres <dm@amsterdam.lcs.mit.edu>
Subject: [PATCH] nfsd 2.4.10: unbloat filehandles for export points
Message-ID: <20011002160334.B1108@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The otherwise excellent nfsd patches in 2.4.10 accidentally inflated
all filehandles for export points to the max size permitted by NFSv3:
64 bytes.  This problem isn't just cosmetic; it also breaks SFS
(http://sfs.fs.net).  Granted, SFS isn't living quite within the law,
but still there's no reason to inflate filehandles.

Thus, this (tested) patch:

--- linux_o/fs/nfsd/nfsfh.c.old	Thu Sep 20 21:02:01 2001
+++ linux/fs/nfsd/nfsfh.c	Tue Oct  2 15:46:47 2001
@@ -732,6 +732,8 @@
 	struct super_block *sb = dentry->d_inode->i_sb;
 	
-	if (dentry == exp->ex_dentry)
+	if (dentry == exp->ex_dentry) {
+		*maxsize = 0;
 		return 0;
+	}
 
 	if (sb->s_op->dentry_to_fh) {

-- 
Chip Salzenberg               - a.k.a. -              <chip@pobox.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech
