Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVAYBYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVAYBYP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 20:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVAYBXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 20:23:16 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:58583 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261634AbVAYBUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 20:20:45 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 12/13] ACL umask handling workaround in nfs client
Date: Tue, 25 Jan 2005 02:20:41 +0100
User-Agent: KMail/1.7.1
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203620.108564000@blunzn.suse.de>
In-Reply-To: <20050122203620.108564000@blunzn.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501250220.41618.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this patch has an NFSv2 problem that I haven't tripped over until today. The 
fix is this:

------- 8< -------
Fix NFSv2 null pointer access

With NFSv2 we would try to follow a NULL getacl and setacl function
pointer here. Add the missing checks.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.10/fs/nfs/dir.c
===================================================================
--- linux-2.6.10.orig/fs/nfs/dir.c
+++ linux-2.6.10/fs/nfs/dir.c
@@ -984,6 +984,9 @@ static int nfs_set_default_acl(struct in
 	struct posix_acl *dfacl, *acl;
 	int error = 0;
 
+	if (NFS_PROTO(inode)->version != 3 ||
+	    !NFS_PROTO(dir)->getacl || !NFS_PROTO(inode)->setacls)
+		return 0;
 	dfacl = NFS_PROTO(dir)->getacl(dir, ACL_TYPE_DEFAULT);
 	if (IS_ERR(dfacl)) {
 		error = PTR_ERR(dfacl);


Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH
