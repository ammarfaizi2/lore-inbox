Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030430AbVIVQUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbVIVQUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 12:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbVIVQUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 12:20:10 -0400
Received: from hera.kernel.org ([140.211.167.34]:45794 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030430AbVIVQUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 12:20:08 -0400
Date: Thu, 22 Sep 2005 13:14:20 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Assar <assar@permabit.com>, Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Peter Staubach <staubach@redhat.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: [PATCH] nfs client: handle long symlinks properly
Message-ID: <20050922161420.GC5588@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


commit 87e03738fc15dc3ea4acde3a5dcb5f84b6b6152b
tree be323c0a65d7e380ad04cad1c3a80015a82056dd
parent bb52ef60b5caa8f973523eda15d3c3941f298e63
author Assar <assar@permabit.com> Wed, 14 Sep 2005 16:59:25 -0400
committer Marcelo Tosatti <marcelo@dmt.cnet> Thu, 22 Sep 2005 13:11:18 -0300

    [PATCH] nfs client: handle long symlinks properly

    In 2.4.31, the v2/3 nfs readlink accepts too long symlinks.
    I have tested this by having a server return long symlinks.

diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -571,8 +571,11 @@ nfs_xdr_readlinkres(struct rpc_rqst *req
        strlen = (u32*)kmap(rcvbuf->pages[0]);
        /* Convert length of symlink */
        len = ntohl(*strlen);
-       if (len > rcvbuf->page_len)
-               len = rcvbuf->page_len;
+       if (len >= rcvbuf->page_len - sizeof(u32) || len > NFS2_MAXPATHLEN) {
+               printk(KERN_WARNING "NFS: server returned giant symlink!\n");
+               kunmap(rcvbuf->pages[0]);
+               return -ENAMETOOLONG;
+        }
        *strlen = len;
        /* NULL terminate the string we got */
        string = (char *)(strlen + 1);
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -759,8 +759,11 @@ nfs3_xdr_readlinkres(struct rpc_rqst *re
        strlen = (u32*)kmap(rcvbuf->pages[0]);
        /* Convert length of symlink */
        len = ntohl(*strlen);
-       if (len > rcvbuf->page_len)
-               len = rcvbuf->page_len;
+       if (len >= rcvbuf->page_len - sizeof(u32)) {
+               printk(KERN_WARNING "NFS: server returned giant symlink!\n");
+               kunmap(rcvbuf->pages[0]);
+               return -ENAMETOOLONG;
+        }
        *strlen = len;
        /* NULL terminate the string we got */
        string = (char *)(strlen + 1);

