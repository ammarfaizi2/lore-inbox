Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUDNTok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 15:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUDNTok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 15:44:40 -0400
Received: from outmx010.isp.belgacom.be ([195.238.3.233]:16810 "EHLO
	outmx010.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261605AbUDNToh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 15:44:37 -0400
Subject: [PATCH 2.6.5-mm4] vfs_readdir optimizations
From: Fabian Frederick <Fabian.Frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-Uq5r4zg19k5V0yvwwHKk"
Message-Id: <1081972032.5445.30.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 14 Apr 2004 21:47:13 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx010.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Uq5r4zg19k5V0yvwwHKk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

-Remove unuseful gotos
-ENOENT case on DEADDIR

PS : mm5 doesn't appear on kernel.org main page.

Regards,
Fabian


--=-Uq5r4zg19k5V0yvwwHKk
Content-Disposition: attachment; filename=readdir1.diff
Content-Type: text/x-patch; name=readdir1.diff; charset=
Content-Transfer-Encoding: 7bit

diff -Naur orig/fs/readdir.c edited/fs/readdir.c
--- orig/fs/readdir.c	2004-04-04 05:37:06.000000000 +0200
+++ edited/fs/readdir.c	2004-04-12 17:25:36.000000000 +0200
@@ -21,21 +21,16 @@
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	int res = -ENOTDIR;
-	if (!file->f_op || !file->f_op->readdir)
-		goto out;
-
-	res = security_file_permission(file, MAY_READ);
-	if (res)
-		goto out;
-
-	down(&inode->i_sem);
-	res = -ENOENT;
-	if (!IS_DEADDIR(inode)) {
-		res = file->f_op->readdir(file, buf, filler);
-		file_accessed(file);
+	if (file->f_op && file->f_op->readdir){
+		if (!(res = security_file_permission(file, MAY_READ))){
+			down(&inode->i_sem);
+			if (!IS_DEADDIR(inode)) {
+				res = file->f_op->readdir(file, buf, filler);
+				file_accessed(file);
+			}else   res = -ENOENT;
+			up(&inode->i_sem);
+		}
 	}
-	up(&inode->i_sem);
-out:
 	return res;
 }
 

--=-Uq5r4zg19k5V0yvwwHKk--

