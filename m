Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWIFPvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWIFPvZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 11:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWIFPvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 11:51:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44173 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751093AbWIFPvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 11:51:24 -0400
Message-ID: <44FEEE79.30201@RedHat.com>
Date: Wed, 06 Sep 2006 11:51:21 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060726 Red Hat/1.0.3-0.el4.1 SeaMonkey/1.0.3
MIME-Version: 1.0
To: nfsv4@linux-nfs.org
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] NFSv4: rpc_mkpipe creating socket inodes w/out sk buffers.
Content-Type: multipart/mixed;
 boundary="------------000003040302060802090900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000003040302060802090900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

rpc_mkpipe sets the S_IFSOCK mode bit when it creates a
inode but does not create a true socket inode. So when other parts
of the kernel (i.e. the SELinux code in the-mm kernel) use
S_ISSOCK() to see if the inode is a socket, the macro returns true,
but the expected socket inode container structure is really
an rpc_inode container which obviously causes problems...

This patch simply change the S_IFSOCK mode bit to
S_IFIFO which eliminates the problem.

steved.

--------------000003040302060802090900
Content-Type: text/x-patch;
 name="nfs-2.6-rpc-mkpipe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nfs-2.6-rpc-mkpipe.patch"

This patch stop rpc_mkpipe from create S_IFSOCK nodes what don't 
have associated sk buffers attached (which causes SELinux to oops
during NFSv4 mounts). Instead the S_IFIFO mode bit is set which
probably make more sense and seems to work just fine during
my connectathon and fsx testing... 

Signed-off-by: Steve Dickson <steved@redhat.com>
--------------------------------------

--- nfs-2.6/net/sunrpc/rpc_pipe.c.orig	2006-08-24 14:33:43.000000000 -0400
+++ nfs-2.6/net/sunrpc/rpc_pipe.c	2006-09-06 10:31:45.000000000 -0400
@@ -720,7 +720,7 @@ rpc_mkpipe(struct dentry *parent, const 
 	if (IS_ERR(dentry))
 		return dentry;
 	dir = parent->d_inode;
-	inode = rpc_get_inode(dir->i_sb, S_IFSOCK | S_IRUSR | S_IWUSR);
+	inode = rpc_get_inode(dir->i_sb, S_IFIFO | S_IRUSR | S_IWUSR);
 	if (!inode)
 		goto err_dput;
 	inode->i_ino = iunique(dir->i_sb, 100);

--------------000003040302060802090900--
