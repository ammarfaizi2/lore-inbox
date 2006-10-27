Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWJ0WAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWJ0WAQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 18:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWJ0WAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 18:00:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:3528 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750743AbWJ0WAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 18:00:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AjGP3/xLI9aAlMzpltgW/7hY8q+N2LZqfhWL3/HxVBSUIng/Vpv34RY7l9xSN7wyrvKhzupp2/hqV+jRJjLG9kIhyVJJ0slRjJyHNvAaYZXjLwyMWosMo0HasJAU96SDJyRmBt9wbOFy2CSJO8TECX+lailt+aOgoPqN6Qw8QPg=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [PATCH] NFS: nfsaclsvc_encode_getaclres() - Fix potential NULL deref and tiny optimization.
Date: Sat, 28 Oct 2006 00:01:48 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruen@suse.de>,
       Neil Brown <neilb@cse.unsw.edu.au>, nfs@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>
References: <200610272316.47089.jesper.juhl@gmail.com> <Pine.LNX.4.64N.0610271443500.31179@attu2.cs.washington.edu>
In-Reply-To: <Pine.LNX.4.64N.0610271443500.31179@attu2.cs.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610280001.49272.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 October 2006 23:46, David Rientjes wrote:
> On Fri, 27 Oct 2006, Jesper Juhl wrote:
> 
> > In fs/nfsd/nfs2acl.c::nfsaclsvc_encode_getaclres() I see a few issues.
> > 
> > 1) At the top of the function we assign to the 'inode' variable by 
> > dereferencing 'dentry', but further down we test 'dentry' for NULL. So, if 
> > 'dentry' (which is really 'resp->fh.fh_dentry') can be NULL, then either 
> > we have a potential NULL pointer deref bug or we have a superflous test.
> > 
> 
> resp->fh.fh_dentry cannot be NULL on nfsaclsvc_encode_getaclres so the 
> early assignment is appropriate for both *dentry and *inode.

I didn't convince myself of that on my first scan of the code, that's why 
I opted to keep the NULL check.

> *inode will  
> need to be checked for NULL in the conditional, however, and return 0 on 
> true.
> 
Right, that agrees with my reading as well.

> > 3) There are two locations in the function where we may return before we 
> > use the value of the variable 'w', but we compute it at the very top of the 
> > function. So in the case where we return early we have wasted a few cycles 
> > computing a value that was never used.
> > 
> 
> w should be an unsigned int.
> 
Makes sense.

Thank you for commenting.

Here's a patch, on top of the previous one, to address you comments.
Feedback welcome.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/nfsd/nfs2acl.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index d89d63f..069d7d0 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -222,14 +222,13 @@ static int nfsaclsvc_encode_getaclres(st
 {
 	struct dentry *dentry = resp->fh.fh_dentry;
 	struct kvec *head = rqstp->rq_res.head;
-	struct inode *inode;
+	struct inode *inode = dentry->d_inode;
 	unsigned int base;
-	int w;
+	unsigned int w;
 	int n;
 
-	if (dentry == NULL || dentry->d_inode == NULL)
+	if (!inode)
 		return 0;
-	inode = dentry->d_inode;
 
 	p = nfs2svc_encode_fattr(rqstp, p, &resp->fh);
 	*p++ = htonl(resp->mask);

