Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932714AbVINTm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbVINTm7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbVINTm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:42:58 -0400
Received: from [66.228.95.230] ([66.228.95.230]:55991 "EHLO
	postage-due.permabit.com") by vger.kernel.org with ESMTP
	id S932714AbVINTm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:42:57 -0400
To: Peter Staubach <staubach@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow
References: <78irx6wh6j.fsf@sober-counsel.permabit.com>
	<200509121846.j8CIk5YE025124@turing-police.cc.vt.edu>
	<784q8qrsad.fsf@sober-counsel.permabit.com>
	<200509122001.j8CK1kpW028651@turing-police.cc.vt.edu>
	<788xy2qas0.fsf@sober-counsel.permabit.com>
	<20050913183948.GE14889@dmt.cnet>
	<784q8okdfn.fsf@sober-counsel.permabit.com>
	<20050913193539.GB17222@dmt.cnet>
	<784q8oivp4.fsf@sober-counsel.permabit.com>
	<43287221.8020602@redhat.com>
From: Assar <assar@permabit.com>
Date: 14 Sep 2005 15:41:31 -0400
In-Reply-To: <43287221.8020602@redhat.com>
Message-ID: <7864t3h1xw.fsf@sober-counsel.permabit.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Permabit-Spam: SKIPPED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Staubach <staubach@redhat.com> writes:
> Yes, I think that there is a bug in the boundary checking.  I think that:
> 
>         if (len > rcvbuf->page_len)
> 
> should be
> 
>         if (len >= rcvbuf->page_len - sizeof(u32) || len > 1024)

Thanks for your feedback.  The patch to 2.4.31 that incorporates your
suggsted changes is here:

diff -u linux-2.4.31.orig/fs/nfs/nfs2xdr.c linux-2.4.31/fs/nfs/nfs2xdr.c
--- linux-2.4.31.orig/fs/nfs/nfs2xdr.c	2002-11-28 18:53:15.000000000 -0500
+++ linux-2.4.31/fs/nfs/nfs2xdr.c	2005-09-14 15:33:30.000000000 -0400
@@ -571,8 +571,8 @@
 	strlen = (u32*)kmap(rcvbuf->pages[0]);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
-	if (len > rcvbuf->page_len)
-		len = rcvbuf->page_len;
+	if (len >= rcvbuf->page_len - sizeof(u32) || len > NFS2_MAXPATHLEN)
+		len = rcvbuf->page_len - sizeof(u32) - 1;
 	*strlen = len;
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);
diff -u linux-2.4.31.orig/fs/nfs/nfs3xdr.c linux-2.4.31/fs/nfs/nfs3xdr.c
--- linux-2.4.31.orig/fs/nfs/nfs3xdr.c	2003-11-28 13:26:21.000000000 -0500
+++ linux-2.4.31/fs/nfs/nfs3xdr.c	2005-09-14 15:33:53.000000000 -0400
@@ -759,8 +759,8 @@
 	strlen = (u32*)kmap(rcvbuf->pages[0]);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
-	if (len > rcvbuf->page_len)
-		len = rcvbuf->page_len;
+	if (len >= rcvbuf->page_len - sizeof(u32))
+		len = rcvbuf->page_len - sizeof(u32) - 1;
 	*strlen = len;
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);

> The 2.6 kernel code is also broken, but in a different, but once again,
> similar fashions.

You mean for length > 1024 ?

diff -u linux-2.6.13.orig/fs/nfs/nfs2xdr.c linux-2.6.13/fs/nfs/nfs2xdr.c
--- linux-2.6.13.orig/fs/nfs/nfs2xdr.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13/fs/nfs/nfs2xdr.c	2005-09-14 15:40:13.000000000 -0400
@@ -557,7 +557,7 @@
 		return -nfs_stat_to_errno(status);
 	/* Convert length of symlink */
 	len = ntohl(*p++);
-	if (len >= rcvbuf->page_len || len <= 0) {
+	if (len >= rcvbuf->page_len || len <= 0 || len > NFS2_MAXPATHLEN) {
 		dprintk(KERN_WARNING "nfs: server returned giant symlink!\n");
 		return -ENAMETOOLONG;
 	}
