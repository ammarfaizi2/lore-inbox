Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVILUl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVILUl3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbVILUl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:41:28 -0400
Received: from [66.228.95.230] ([66.228.95.230]:21635 "EHLO
	postage-due.permabit.com") by vger.kernel.org with ESMTP
	id S932220AbVILUl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:41:27 -0400
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow
References: <78irx6wh6j.fsf@sober-counsel.permabit.com>
	<200509121846.j8CIk5YE025124@turing-police.cc.vt.edu>
	<784q8qrsad.fsf@sober-counsel.permabit.com>
	<200509122001.j8CK1kpW028651@turing-police.cc.vt.edu>
From: Assar <assar@permabit.com>
Date: 12 Sep 2005 16:41:19 -0400
In-Reply-To: <200509122001.j8CK1kpW028651@turing-police.cc.vt.edu>
Message-ID: <788xy2qas0.fsf@sober-counsel.permabit.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Permabit-Spam: SKIPPED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:
> > To my reading, the 2.6.13 code does not copy the 4 bytes of length to
> > rcvbuf.
> 
> Hmm... it still does this:
> 	kaddr[len+rcvbuf->page_base] = '\0';
> which still has a possible off-by-one? (Was that why you have -1 -4?)

The check is different.  2.6.13 is using ">=" instead of ">", so hence
I think that's fine.

> sizeof(actual_var) is even better, as that way it's clear what you're allowing
> space for.

diff -u linux-2.4.31.orig/fs/nfs/nfs2xdr.c linux-2.4.31/fs/nfs/nfs2xdr.c
--- linux-2.4.31.orig/fs/nfs/nfs2xdr.c	2002-11-28 18:53:15.000000000 -0500
+++ linux-2.4.31/fs/nfs/nfs2xdr.c	2005-09-12 16:12:30.000000000 -0400
@@ -571,8 +571,8 @@
 	strlen = (u32*)kmap(rcvbuf->pages[0]);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
-	if (len > rcvbuf->page_len)
-		len = rcvbuf->page_len;
+	if (len > rcvbuf->page_len - sizeof(*strlen) - 1)
+		len = rcvbuf->page_len - sizeof(*strlen) - 1;
 	*strlen = len;
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);
diff -u linux-2.4.31.orig/fs/nfs/nfs3xdr.c linux-2.4.31/fs/nfs/nfs3xdr.c
--- linux-2.4.31.orig/fs/nfs/nfs3xdr.c	2003-11-28 13:26:21.000000000 -0500
+++ linux-2.4.31/fs/nfs/nfs3xdr.c	2005-09-12 16:12:29.000000000 -0400
@@ -759,8 +759,8 @@
 	strlen = (u32*)kmap(rcvbuf->pages[0]);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
-	if (len > rcvbuf->page_len)
-		len = rcvbuf->page_len;
+	if (len > rcvbuf->page_len - sizeof(*strlen) - 1)
+		len = rcvbuf->page_len - sizeof(*strlen) - 1;
 	*strlen = len;
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);
