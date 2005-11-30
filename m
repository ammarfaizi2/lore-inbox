Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVK3OZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVK3OZs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 09:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVK3OZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 09:25:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33227 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751120AbVK3OZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 09:25:48 -0500
Message-ID: <438DB65D.8010306@RedHat.com>
Date: Wed, 30 Nov 2005 09:25:33 -0500
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS cache consistancy appears to be broken...
References: <200510281607.j9SG7Tll024133@hera.kernel.org>	 <438D0E80.2020905@RedHat.com> <1133334608.8010.9.camel@lade.trondhjem.org>
In-Reply-To: <1133334608.8010.9.camel@lade.trondhjem.org>
Content-Type: multipart/mixed;
 boundary="------------080008000705060200050501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080008000705060200050501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hey Trond,

Unfortunately this update patch did not correct the problem for me.
So I decided to dig a little deeper since it appears your not
in favor of reverting the original patch... and sure your were
right in the sense there was "something else at work here"....

It was the simple fact that nfsi->cache_change_attribute was not being 
initialized to jiffies when the nfs inode was being allocated. This
meant when nfs_revalidate_mapping() was called with the
NFS_INO_INVALID_DATA bit was on, nfsi->cache_change_attribute
was not being changed, it was actually being set!

This caused the next called to nfs_verify_change_attribute() to
return true instead false, which meant (indirectly) the dentry
was never released and the otw look was not happening even when
it was noticed the mtime of the directory had changed....

The attached patch does fix the problem for me.

steved.



--------------080008000705060200050501
Content-Type: text/x-patch;
 name="linux-2.6.14-nfs-cache-init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.14-nfs-cache-init.patch"

Make sure cache_change_attribute is initialized to jiffies
so when the mtime changes on directory, the directory
will be refreshed.

Signed-off by: Steve Dickson <steved@redhat.com>
---------------------------------------------
--- linux-2.6.14/fs/nfs/inode.c.orig	2005-11-29 20:53:57.000000000 -0500
+++ linux-2.6.14/fs/nfs/inode.c	2005-11-30 08:55:14.000000000 -0500
@@ -2066,6 +2066,7 @@ static struct inode *nfs_alloc_inode(str
 		return NULL;
 	nfsi->flags = 0UL;
 	nfsi->cache_validity = 0UL;
+	nfsi->cache_change_attribute = jiffies;
 #ifdef CONFIG_NFS_V3_ACL
 	nfsi->acl_access = ERR_PTR(-EAGAIN);
 	nfsi->acl_default = ERR_PTR(-EAGAIN);

--------------080008000705060200050501--
