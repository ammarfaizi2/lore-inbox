Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932668AbVINVCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbVINVCc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 17:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932758AbVINVCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 17:02:32 -0400
Received: from [66.228.95.230] ([66.228.95.230]:58041 "EHLO
	postage-due.permabit.com") by vger.kernel.org with ESMTP
	id S932668AbVINVCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 17:02:31 -0400
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
	<7864t3h1xw.fsf@sober-counsel.permabit.com>
	<432884CE.9060506@redhat.com>
	<78r7brflb0.fsf@sober-counsel.permabit.com>
	<432887C8.2000607@redhat.com>
From: Assar <assar@permabit.com>
Date: 14 Sep 2005 16:59:25 -0400
In-Reply-To: <432887C8.2000607@redhat.com>
Message-ID: <78irx3fjrm.fsf@sober-counsel.permabit.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Permabit-Spam: SKIPPED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Staubach <staubach@redhat.com> writes:
> Understand.  I would recommend that the 2.4 kernel be modified to return
> an error, since we are already modifying the area anyway.

Marcelo: what's your thought?

If you want to go that route, the patch below should do it.

diff -u linux-2.4.31.orig/fs/nfs/nfs2xdr.c linux-2.4.31/fs/nfs/nfs2xdr.c
--- linux-2.4.31.orig/fs/nfs/nfs2xdr.c	2002-11-28 18:53:15.000000000 -0500
+++ linux-2.4.31/fs/nfs/nfs2xdr.c	2005-09-14 16:57:21.000000000 -0400
@@ -571,8 +571,11 @@
 	strlen = (u32*)kmap(rcvbuf->pages[0]);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
-	if (len > rcvbuf->page_len)
-		len = rcvbuf->page_len;
+	if (len >= rcvbuf->page_len - sizeof(u32) || len > NFS2_MAXPATHLEN) {
+		printk(KERN_WARNING "NFS: server returned giant symlink!\n");
+		kunmap(rcvbuf->pages[0]);
+		return -ENAMETOOLONG;
+        }
 	*strlen = len;
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);
diff -u linux-2.4.31.orig/fs/nfs/nfs3xdr.c linux-2.4.31/fs/nfs/nfs3xdr.c
--- linux-2.4.31.orig/fs/nfs/nfs3xdr.c	2003-11-28 13:26:21.000000000 -0500
+++ linux-2.4.31/fs/nfs/nfs3xdr.c	2005-09-14 16:57:37.000000000 -0400
@@ -759,8 +759,11 @@
 	strlen = (u32*)kmap(rcvbuf->pages[0]);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
-	if (len > rcvbuf->page_len)
-		len = rcvbuf->page_len;
+	if (len >= rcvbuf->page_len - sizeof(u32)) {
+		printk(KERN_WARNING "NFS: server returned giant symlink!\n");
+		kunmap(rcvbuf->pages[0]);
+		return -ENAMETOOLONG;
+        }
 	*strlen = len;
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);
