Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbUKPOCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbUKPOCn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 09:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbUKPOBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 09:01:40 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:52900 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261742AbUKPOBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 09:01:20 -0500
Date: Tue, 16 Nov 2004 19:27:52 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [patch 1/4] Cleanup file_count usage: Bad usage at some .open, .release
Message-ID: <20041116135752.GB23257@impedimenta.in.ibm.com>
References: <20041116135200.GA23257@impedimenta.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116135200.GA23257@impedimenta.in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch cleans up some obviously wrong usage of struct file.f_count
in ->open() and ->release() routines of some file systems, the use case being
check if f_count is 1 in ->open() and f_count is 0 in ->release().  
This patch cleans up the f_count usage for affs, hfs and hfsplus file systems.

Signed-off-by: Ravikiran Thirumalai <kiran@in.ibm.com>
---

 affs/file.c     |    4 ----
 hfs/inode.c     |    4 ----
 hfsplus/inode.c |    4 ----
 3 files changed, 12 deletions(-)


diff -ruN -X dontdiff linux-2.6.9/fs/affs/file.c f_count-2.6.9/fs/affs/file.c
--- linux-2.6.9/fs/affs/file.c	2004-10-19 03:24:08.000000000 +0530
+++ f_count-2.6.9/fs/affs/file.c	2004-11-09 17:45:19.000000000 +0530
@@ -62,8 +62,6 @@
 static int
 affs_file_open(struct inode *inode, struct file *filp)
 {
-	if (atomic_read(&filp->f_count) != 1)
-		return 0;
 	pr_debug("AFFS: open(%d)\n", AFFS_I(inode)->i_opencnt);
 	AFFS_I(inode)->i_opencnt++;
 	return 0;
@@ -72,8 +70,6 @@
 static int
 affs_file_release(struct inode *inode, struct file *filp)
 {
-	if (atomic_read(&filp->f_count) != 0)
-		return 0;
 	pr_debug("AFFS: release(%d)\n", AFFS_I(inode)->i_opencnt);
 	AFFS_I(inode)->i_opencnt--;
 	if (!AFFS_I(inode)->i_opencnt)
diff -ruN -X dontdiff linux-2.6.9/fs/hfs/inode.c f_count-2.6.9/fs/hfs/inode.c
--- linux-2.6.9/fs/hfs/inode.c	2004-10-19 03:25:29.000000000 +0530
+++ f_count-2.6.9/fs/hfs/inode.c	2004-11-09 17:45:19.000000000 +0530
@@ -524,8 +524,6 @@
 {
 	if (HFS_IS_RSRC(inode))
 		inode = HFS_I(inode)->rsrc_inode;
-	if (atomic_read(&file->f_count) != 1)
-		return 0;
 	atomic_inc(&HFS_I(inode)->opencnt);
 	return 0;
 }
@@ -536,8 +534,6 @@
 
 	if (HFS_IS_RSRC(inode))
 		inode = HFS_I(inode)->rsrc_inode;
-	if (atomic_read(&file->f_count) != 0)
-		return 0;
 	if (atomic_dec_and_test(&HFS_I(inode)->opencnt)) {
 		down(&inode->i_sem);
 		hfs_file_truncate(inode);
diff -ruN -X dontdiff linux-2.6.9/fs/hfsplus/inode.c f_count-2.6.9/fs/hfsplus/inode.c
--- linux-2.6.9/fs/hfsplus/inode.c	2004-10-19 03:23:44.000000000 +0530
+++ f_count-2.6.9/fs/hfsplus/inode.c	2004-11-09 17:45:19.000000000 +0530
@@ -268,8 +268,6 @@
 {
 	if (HFSPLUS_IS_RSRC(inode))
 		inode = HFSPLUS_I(inode).rsrc_inode;
-	if (atomic_read(&file->f_count) != 1)
-		return 0;
 	atomic_inc(&HFSPLUS_I(inode).opencnt);
 	return 0;
 }
@@ -280,8 +278,6 @@
 
 	if (HFSPLUS_IS_RSRC(inode))
 		inode = HFSPLUS_I(inode).rsrc_inode;
-	if (atomic_read(&file->f_count) != 0)
-		return 0;
 	if (atomic_dec_and_test(&HFSPLUS_I(inode).opencnt)) {
 		down(&inode->i_sem);
 		hfsplus_file_truncate(inode);
