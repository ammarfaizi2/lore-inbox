Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVCYWYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVCYWYF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVCYWWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:22:01 -0500
Received: from mail.dif.dk ([193.138.115.101]:47288 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261846AbVCYWUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:20:34 -0500
Date: Fri, 25 Mar 2005 23:22:29 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] remove redundant NULL pointer checks prior to calling kfree()
 in fs/nfsd/
Message-ID: <Pine.LNX.4.62.0503252319220.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please keep me on CC)


checking for NULL before calling kfree() is redundant and needlessly 
enlarges the kernel image, let's get rid of those checks.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm3-orig/fs/nfsd/export.c	2005-03-21 23:12:41.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/nfsd/export.c	2005-03-25 22:48:11.000000000 +0100
@@ -189,8 +189,7 @@ static int expkey_parse(struct cache_det
  out:
 	if (dom)
 		auth_domain_put(dom);
-	if (buf)
-		kfree(buf);
+	kfree(buf);
 	return err;
 }
 
@@ -426,8 +425,7 @@ static int svc_export_parse(struct cache
 		path_release(&nd);
 	if (dom)
 		auth_domain_put(dom);
-	if (buf)
-		kfree(buf);
+	kfree(buf);
 	return err;
 }
 
--- linux-2.6.12-rc1-mm3-orig/fs/nfsd/nfs4xdr.c	2005-03-25 15:28:59.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/nfsd/nfs4xdr.c	2005-03-25 22:49:53.000000000 +0100
@@ -151,8 +151,7 @@ u32 *read_buf(struct nfsd4_compoundargs 
 	if (nbytes <= sizeof(argp->tmp))
 		p = argp->tmp;
 	else {
-		if (argp->tmpp)
-			kfree(argp->tmpp);
+		kfree(argp->tmpp);
 		p = argp->tmpp = kmalloc(nbytes, GFP_KERNEL);
 		if (!p)
 			return NULL;
@@ -2474,10 +2473,8 @@ void nfsd4_release_compoundargs(struct n
 		kfree(args->ops);
 		args->ops = args->iops;
 	}
-	if (args->tmpp) {
-		kfree(args->tmpp);
-		args->tmpp = NULL;
-	}
+	kfree(args->tmpp);
+	args->tmpp = NULL;
 	while (args->to_free) {
 		struct tmpbuf *tb = args->to_free;
 		args->to_free = tb->next;
--- linux-2.6.12-rc1-mm3-orig/fs/nfsd/nfscache.c	2005-03-21 23:12:41.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/nfsd/nfscache.c	2005-03-25 22:50:14.000000000 +0100
@@ -93,8 +93,7 @@ nfsd_cache_shutdown(void)
 
 	cache_disabled = 1;
 
-	if (hash_list)
-		kfree (hash_list);
+	kfree(hash_list);
 	hash_list = NULL;
 }
 


