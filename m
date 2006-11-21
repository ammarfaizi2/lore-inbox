Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030886AbWKULe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030886AbWKULe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 06:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030881AbWKULe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 06:34:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:13103 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030882AbWKULeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 06:34:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aR5n9KUliF0ZeYSJ1THBx4oRvUTR8ddSBEUSc7qVCGKy8WJwFD1hMV5oz3z6/D5CbuVMg8xp6MjVYpvbW8DyY4zr8Z6Z9NLqb2IRpObE47tnG4DgHtHPsBWGdn7Ukn7z25d5zd1CzkgmmRUuoJwmMU6vY54LVg+hEwY1CsxJg/g=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][1/2] NFS2: Calculate 'w' a bit later in nfsaclsvc_encode_getaclres()
Date: Tue, 21 Nov 2006 12:34:13 +0100
User-Agent: KMail/1.9.5
Cc: Andreas Gruenbacher <agruen@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>,
       nfs@lists.sourceforge.net, David Rientjes <rientjes@cs.washington.edu>,
       Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611211234.14027.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFS2: Calculate 'w' a bit later in nfsaclsvc_encode_getaclres()
      This is a small performance optimization since we can return before
      needing 'w'. It also saves a few bytes of .text :
      Before:
           text    data     bss     dec     hex filename
           2406     212       0    2618     a3a fs/nfsd/nfs2acl.o
      After:
           text    data     bss     dec     hex filename
           2400     212       0    2612     a34 fs/nfsd/nfs2acl.o


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

 fs/nfsd/nfs2acl.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index e3eca08..edde5dc 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -222,12 +222,10 @@ static int nfsaclsvc_encode_getaclres(st
 {
 	struct dentry *dentry = resp->fh.fh_dentry;
 	struct inode *inode = dentry->d_inode;
-	int w = nfsacl_size(
-		(resp->mask & NFS_ACL)   ? resp->acl_access  : NULL,
-		(resp->mask & NFS_DFACL) ? resp->acl_default : NULL);
 	struct kvec *head = rqstp->rq_res.head;
 	unsigned int base;
 	int n;
+	int w;
 
 	if (dentry == NULL || dentry->d_inode == NULL)
 		return 0;
@@ -239,7 +237,9 @@ static int nfsaclsvc_encode_getaclres(st
 		return 0;
 	base = (char *)p - (char *)head->iov_base;
 
-	rqstp->rq_res.page_len = w;
+	rqstp->rq_res.page_len = w = nfsacl_size(
+		(resp->mask & NFS_ACL)   ? resp->acl_access  : NULL,
+		(resp->mask & NFS_DFACL) ? resp->acl_default : NULL);
 	while (w > 0) {
 		if (!rqstp->rq_respages[rqstp->rq_resused++])
 			return 0;


