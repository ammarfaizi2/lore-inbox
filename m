Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVAJSOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVAJSOj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVAJSMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:12:43 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:46755 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262410AbVAJSIg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:08:36 -0500
Subject: [PATCH 4/6] 2.4.19-rc1 nfs revalidate_inode() stack reduction
	patches
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com>
References: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-wM/ubBUb4ST4Qe2S2g2n"
Organization: 
Message-Id: <1105378864.4000.142.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jan 2005 09:41:04 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wM/ubBUb4ST4Qe2S2g2n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-wM/ubBUb4ST4Qe2S2g2n
Content-Disposition: attachment; filename=nfs_revalidate_inode.patch
Content-Type: text/plain; name=nfs_revalidate_inode.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
--- linux-2.4.29-rc1.org/fs/nfs/inode.c	2004-04-14 06:05:40.000000000 -0700
+++ linux-2.4.29-rc1/fs/nfs/inode.c	2005-01-09 23:14:48.000000000 -0800
@@ -881,11 +881,15 @@ int
 __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 {
 	int		 status = -ESTALE;
-	struct nfs_fattr fattr;
+	struct nfs_fattr *fattr;
 
 	dfprintk(PAGECACHE, "NFS: revalidating (%x/%Ld)\n",
 		inode->i_dev, (long long)NFS_FILEID(inode));
 
+	fattr = kmalloc(sizeof(struct nfs_fattr), GFP_KERNEL);
+	if (!fattr)
+		return -ENOMEM;
+
 	lock_kernel();
 	if (!inode || is_bad_inode(inode))
  		goto out_nowait;
@@ -903,7 +907,7 @@ __nfs_revalidate_inode(struct nfs_server
 	}
 	NFS_FLAGS(inode) |= NFS_INO_REVALIDATING;
 
-	status = NFS_PROTO(inode)->getattr(inode, &fattr);
+	status = NFS_PROTO(inode)->getattr(inode, fattr);
 	if (status) {
 		dfprintk(PAGECACHE, "nfs_revalidate_inode: (%x/%Ld) getattr failed, error=%d\n",
 			 inode->i_dev, (long long)NFS_FILEID(inode), status);
@@ -915,7 +919,7 @@ __nfs_revalidate_inode(struct nfs_server
 		goto out;
 	}
 
-	status = nfs_refresh_inode(inode, &fattr);
+	status = nfs_refresh_inode(inode, fattr);
 	if (status) {
 		dfprintk(PAGECACHE, "nfs_revalidate_inode: (%x/%Ld) refresh failed, error=%d\n",
 			 inode->i_dev, (long long)NFS_FILEID(inode), status);
@@ -930,6 +934,7 @@ out:
 	wake_up(&inode->i_wait);
  out_nowait:
 	unlock_kernel();
+	kfree(fattr);
 	return status;
 }
 

--=-wM/ubBUb4ST4Qe2S2g2n--

