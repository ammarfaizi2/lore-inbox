Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWFFSGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWFFSGK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 14:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWFFSGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 14:06:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35284 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750844AbWFFSGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 14:06:08 -0400
Message-ID: <4485C3FE.5070504@redhat.com>
Date: Tue, 06 Jun 2006 14:05:50 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>, Neil Brown <neilb@suse.de>
CC: NFS List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] NFS server does not update mtime on setattr request
Content-Type: multipart/mixed;
 boundary="------------090003010804040206090900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090003010804040206090900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Attached aer two patches to address two halves of a problem where NFS does
not update the mtime when an existing file is opened with O_TRUNC.  The
mtime does not get updated when the file is already zero length, although
it should.

On the NFS client side, there was an optimization added which attempted
to avoid an over the wire call if the size of the file was not going to
change.  This would be great, except for the side effect of the mtime
on the file needing to change anyway.  The solution is just to issue the
over the wire call anyway, which, as a side effect, updates the mtime and
ctime fields.

On the NFS server side, there was a change to the routine, inode_setattr(),
which now relies upon the caller to set the ATTR_MTIME and ATTR_CTIME
flags in ia_valid in addition to the ATTR_SIZE.  Previously, this routine
would force these bits on if the size of the file was not changing.  Now,
this routine relies upon the caller to specify all of the fields which need
to be updated.

Comments?

    Thanx...

       ps

Signed-off-by: Peter Staubach <staubach@redhat.com>

--------------090003010804040206090900
Content-Type: text/plain;
 name="nfs_client_mtime.devel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nfs_client_mtime.devel"

--- linux-2.6.16.x86_64/fs/nfs/inode.c.org
+++ linux-2.6.16.x86_64/fs/nfs/inode.c
@@ -947,11 +947,6 @@ nfs_setattr(struct dentry *dentry, struc
 
 	nfs_inc_stats(inode, NFSIOS_VFSSETATTR);
 
-	if (attr->ia_valid & ATTR_SIZE) {
-		if (!S_ISREG(inode->i_mode) || attr->ia_size == i_size_read(inode))
-			attr->ia_valid &= ~ATTR_SIZE;
-	}
-
 	/* Optimization: if the end result is no change, don't RPC */
 	attr->ia_valid &= NFS_VALID_ATTRS;
 	if (attr->ia_valid == 0)

--------------090003010804040206090900
Content-Type: text/plain;
 name="nfs_server_mtime.devel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nfs_server_mtime.devel"

--- linux-2.6.16.x86_64/fs/nfsd/vfs.c.org
+++ linux-2.6.16.x86_64/fs/nfsd/vfs.c
@@ -327,6 +327,11 @@ nfsd_setattr(struct svc_rqst *rqstp, str
 			goto out_nfserr;
 		}
 		DQUOT_INIT(inode);
+		/*
+		 * Make sure that the mtime changes even if the file
+		 * size doesn't actually change.
+		 */
+		iap->ia_valid |= ATTR_MTIME | ATTR_CTIME;
 	}
 
 	imode = inode->i_mode;

--------------090003010804040206090900--
