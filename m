Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030881AbWKULem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030881AbWKULem (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 06:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030882AbWKULel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 06:34:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:13103 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030881AbWKULeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 06:34:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TThEqhZc1PaIIHQVu6Iy2mOs8Y5WYhNz3ewmeEAH7cI9exn3OF6ix3qoxLQyiBPBkOTfZhnNfCVGBKc5neFsb/gVLFeTKOwrdAyKCHLcZh6XAVy9C87oNiKcOvnwqas3Xhy2KQ3cI7QUon6SbU5uo9H9wmm3Kuj8990m4q0BQ4Y=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][2/2] NFS3: Calculate 'w' a bit later in nfs3svc_encode_getaclres()
Date: Tue, 21 Nov 2006 12:34:26 +0100
User-Agent: KMail/1.9.5
Cc: Andreas Gruenbacher <agruen@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>,
       nfs@lists.sourceforge.net, David Rientjes <rientjes@cs.washington.edu>,
       Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611211234.26564.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFS3: Calculate 'w' a bit later in nfs3svc_encode_getaclres()
      This is a small performance optimization since we can return before
      needing 'w'. It also saves a few bytes of .text :
      Before:
           text    data     bss     dec     hex filename
           1632     140       0    1772     6ec fs/nfsd/nfs3acl.o
      After:
           text    data     bss     dec     hex filename
           1624     140       0    1764     6e4 fs/nfsd/nfs3acl.o


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
-- 

 fs/nfsd/nfs3acl.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index fcad289..3e3f2de 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -171,19 +171,19 @@ static int nfs3svc_encode_getaclres(stru
 	p = nfs3svc_encode_post_op_attr(rqstp, p, &resp->fh);
 	if (resp->status == 0 && dentry && dentry->d_inode) {
 		struct inode *inode = dentry->d_inode;
-		int w = nfsacl_size(
-			(resp->mask & NFS_ACL)   ? resp->acl_access  : NULL,
-			(resp->mask & NFS_DFACL) ? resp->acl_default : NULL);
 		struct kvec *head = rqstp->rq_res.head;
 		unsigned int base;
 		int n;
+		int w;
 
 		*p++ = htonl(resp->mask);
 		if (!xdr_ressize_check(rqstp, p))
 			return 0;
 		base = (char *)p - (char *)head->iov_base;
 
-		rqstp->rq_res.page_len = w;
+		rqstp->rq_res.page_len = w = nfsacl_size(
+			(resp->mask & NFS_ACL)   ? resp->acl_access  : NULL,
+			(resp->mask & NFS_DFACL) ? resp->acl_default : NULL);
 		while (w > 0) {
 			if (!rqstp->rq_respages[rqstp->rq_resused++])
 				return 0;


