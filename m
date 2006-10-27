Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752457AbWJ0VPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbWJ0VPO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 17:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752458AbWJ0VPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 17:15:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:45608 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752457AbWJ0VPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 17:15:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EaVO7gEtCZy14wXscrlbJjm97qvtiSfTVlmn0QNYmt9kd+04eAUUXSmRKTon/9+p2DDBRVGpsWpRnW0tMagK+igb28I68z4O18KoSsPWehNylnlzDBx9X+lXiiKCCPEaZMivTc1Jbh8aeA0Q3ATU1u4Zt0lSpYgLFrpYDJwMeCI=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: nfsaclsvc_encode_getaclres() - Fix potential NULL deref and tiny optimization.
Date: Fri, 27 Oct 2006 23:16:46 +0200
User-Agent: KMail/1.9.4
Cc: Andreas Gruenbacher <agruen@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>,
       nfs@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610272316.47089.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fs/nfsd/nfs2acl.c::nfsaclsvc_encode_getaclres() I see a few issues.

1) At the top of the function we assign to the 'inode' variable by 
dereferencing 'dentry', but further down we test 'dentry' for NULL. So, if 
'dentry' (which is really 'resp->fh.fh_dentry') can be NULL, then either 
we have a potential NULL pointer deref bug or we have a superflous test.

2) In the case of  resp->fh.fh_dentry  != NULL  we have a duplicate 
assignment to 'inode' - just one would do.

3) There are two locations in the function where we may return before we 
use the value of the variable 'w', but we compute it at the very top of the 
function. So in the case where we return early we have wasted a few cycles 
computing a value that was never used.


This patch solves these issues by :

1) Moving the computation of 'w' to just before it is used, after the two 
potential returns.

2) Remove the initial assignment of 'dentry->d_inode' 
(aka resp->fh.fh_dentry->d_inode) to 'inode' so that the assignment only 
happens once and happens after the NULL test.


So we get 3 benefits from this patch : 

1) We avoid a potential NULL pointer deref.

2) We save a few CPU cycles from not computing 'w' in the case of an early 
return as well as saving the assignment to 'inode' in the  dentry == NULL 
case, and there's only a single assignment to 'inode' ever.

3) We save a few bytes of .text in the object file.
    before:
        text    data     bss     dec     hex filename
        2502     204       0    2706     a92 fs/nfsd/nfs2acl.o
    after:
        text    data     bss     dec     hex filename
        2489     204       0    2693     a85 fs/nfsd/nfs2acl.o


Patch is compile tested only since I don't currently have a setup where I 
can meaningfully test it further.

Please comment and/or apply.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/nfsd/nfs2acl.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index e3eca08..d89d63f 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -221,12 +221,10 @@ static int nfsaclsvc_encode_getaclres(st
 		struct nfsd3_getaclres *resp)
 {
 	struct dentry *dentry = resp->fh.fh_dentry;
-	struct inode *inode = dentry->d_inode;
-	int w = nfsacl_size(
-		(resp->mask & NFS_ACL)   ? resp->acl_access  : NULL,
-		(resp->mask & NFS_DFACL) ? resp->acl_default : NULL);
 	struct kvec *head = rqstp->rq_res.head;
+	struct inode *inode;
 	unsigned int base;
+	int w;
 	int n;
 
 	if (dentry == NULL || dentry->d_inode == NULL)
@@ -239,6 +237,9 @@ static int nfsaclsvc_encode_getaclres(st
 		return 0;
 	base = (char *)p - (char *)head->iov_base;
 
+	w = nfsacl_size(
+		(resp->mask & NFS_ACL)   ? resp->acl_access  : NULL,
+		(resp->mask & NFS_DFACL) ? resp->acl_default : NULL);
 	rqstp->rq_res.page_len = w;
 	while (w > 0) {
 		if (!rqstp->rq_respages[rqstp->rq_resused++])


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html


