Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbTDDQxN (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 11:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbTDDQvy (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 11:51:54 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:17943 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263848AbTDDQuD (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 11:50:03 -0500
Message-ID: <3E8DBA79.9030700@RedHat.com>
Date: Fri, 04 Apr 2003 12:01:45 -0500
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nfs-request@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: [NFS] [PATCH] Corrects error patch in nfs_instantiate()
Content-Type: multipart/mixed;
 boundary="------------010700050809030902060509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010700050809030902060509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

In the 2.4.20 kernel, nfs_instantiate() is only calling d_drop() when
the lookup fails. The dentry also need to be removed from the
dirent cache when we can't get an inode.... Also, as Trond
pointed out, ENOMEM should be returned (instead of EACCES)
when we run out of inodes...

SteveD.

--------------010700050809030902060509
Content-Type: text/plain;
 name="linux-2.4.20-nfs-d_drop.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.20-nfs-d_drop.patch"

--- linux-2.4.20/fs/nfs/dir.c.orig	2003-04-04 06:55:20.000000000 -0500
+++ linux-2.4.20/fs/nfs/dir.c	2003-04-04 08:40:53.000000000 -0500
@@ -756,7 +756,7 @@ static int nfs_instantiate(struct dentry
 				struct nfs_fattr *fattr)
 {
 	struct inode *inode;
-	int error = -EACCES;
+	int error = 0;
 
 	if (fhandle->size == 0 || !(fattr->valid & NFS_ATTR_FATTR)) {
 		struct inode *dir = dentry->d_parent->d_inode;
@@ -768,9 +768,12 @@ static int nfs_instantiate(struct dentry
 	if (inode) {
 		d_instantiate(dentry, inode);
 		nfs_renew_times(dentry);
-		error = 0;
+	} else {
+		error = -ENOMEM;
+		goto out_err;
 	}
 	return error;
+
 out_err:
 	d_drop(dentry);
 	return error;

--------------010700050809030902060509--

