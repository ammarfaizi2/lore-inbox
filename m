Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423617AbWJaUhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423617AbWJaUhq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423618AbWJaUhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:37:46 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:40938 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423617AbWJaUhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:37:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WwGfG6MbmeCsmO8FUmTJhkRfRc24Qu5jnajpyCfkDq4GAw58SHzwruKTr7PE0AWWE7v9UtYg0rvifCw3SQ4JaYL7rLUe2C3HxbeJVW1mrUCmbDr+SUiJJEXnKkZhf8rS19z7JIOGgN6n7KHtXvvqQn0pPE9v7+MHYiQa4EguO6o=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andreas Gruenbacher <agruen@suse.de>
Subject: Small optimization for nfs3acl.   (was: Re: [PATCH] NFS: nfsaclsvc_encode_getaclres() - Fix potential NULL deref and tiny optimization.)
Date: Tue, 31 Oct 2006 21:39:23 +0100
User-Agent: KMail/1.9.4
Cc: David Rientjes <rientjes@cs.washington.edu>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>, nfs@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
References: <200610272316.47089.jesper.juhl@gmail.com> <200610280001.49272.jesper.juhl@gmail.com> <200610311726.00411.agruen@suse.de>
In-Reply-To: <200610311726.00411.agruen@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610312139.23836.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 October 2006 17:26, Andreas Gruenbacher wrote:
> On Saturday 28 October 2006 00:01, Jesper Juhl wrote:
> > > > 3) There are two locations in the function where we may return before
> > > > we use the value of the variable 'w', but we compute it at the very top
> > > > of the function. So in the case where we return early we have wasted a
> > > > few cycles computing a value that was never used.
> 
> Computing w later in the function is fine.
> 
...
> 
> Please fix this identically in fs/nfsd/nfs2acl.c and fs/nfsd/nfs3acl.c.
> 

Here's a patch for nfs3. Hope it's OK.


Saves a few bytes of .text and avoids calculating 'w' in 
nfs3svc_encode_getaclres() in case we return before it's needed.

   text    data     bss     dec     hex filename
   1688     132       0    1820     71c fs/nfsd/nfs3acl.o


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/nfsd/nfs3acl.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index fcad289..eb1cf22 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -171,11 +171,9 @@ static int nfs3svc_encode_getaclres(stru
 	p = nfs3svc_encode_post_op_attr(rqstp, p, &resp->fh);
 	if (resp->status == 0 && dentry && dentry->d_inode) {
 		struct inode *inode = dentry->d_inode;
-		int w = nfsacl_size(
-			(resp->mask & NFS_ACL)   ? resp->acl_access  : NULL,
-			(resp->mask & NFS_DFACL) ? resp->acl_default : NULL);
 		struct kvec *head = rqstp->rq_res.head;
 		unsigned int base;
+		int w;
 		int n;
 
 		*p++ = htonl(resp->mask);
@@ -183,6 +181,9 @@ static int nfs3svc_encode_getaclres(stru
 			return 0;
 		base = (char *)p - (char *)head->iov_base;
 
+		w = nfsacl_size(
+			(resp->mask & NFS_ACL)   ? resp->acl_access  : NULL,
+			(resp->mask & NFS_DFACL) ? resp->acl_default : NULL);
 		rqstp->rq_res.page_len = w;
 		while (w > 0) {
 			if (!rqstp->rq_respages[rqstp->rq_resused++])



