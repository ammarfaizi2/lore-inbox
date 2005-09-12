Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVILN0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVILN0r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 09:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVILN0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 09:26:47 -0400
Received: from [66.228.95.230] ([66.228.95.230]:11237 "EHLO
	postage-due.permabit.com") by vger.kernel.org with ESMTP
	id S1750816AbVILN0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 09:26:47 -0400
To: linux-kernel@vger.kernel.org
Cc: marcelo.tosatti@cyclades.com
Subject: [PATCH] nfs client, kernel 2.4.31: readlink result overflow
From: Assar <assar@permabit.com>
Date: 12 Sep 2005 09:26:28 -0400
Message-ID: <78irx6wh6j.fsf@sober-counsel.permabit.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Permabit-Spam: SKIPPED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.31, the v2/3 nfs readlink accepts too long symlinks.
I have tested this by having a server return long symlinks.
2.6.13 does not to my reading have this problem.

diff -u linux-2.4.31.orig/fs/nfs/nfs2xdr.c linux-2.4.31/fs/nfs/nfs2xdr.c
--- linux-2.4.31.orig/fs/nfs/nfs2xdr.c	2002-11-28 18:53:15.000000000 -0500
+++ linux-2.4.31/fs/nfs/nfs2xdr.c	2005-09-07 17:36:04.000000000 -0400
@@ -571,8 +571,8 @@
 	strlen = (u32*)kmap(rcvbuf->pages[0]);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
-	if (len > rcvbuf->page_len)
-		len = rcvbuf->page_len;
+	if (len > rcvbuf->page_len - 1 - 4)
+		len = rcvbuf->page_len - 1 - 4;
 	*strlen = len;
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);
diff -u linux-2.4.31.orig/fs/nfs/nfs3xdr.c linux-2.4.31/fs/nfs/nfs3xdr.c
--- linux-2.4.31.orig/fs/nfs/nfs3xdr.c	2003-11-28 13:26:21.000000000 -0500
+++ linux-2.4.31/fs/nfs/nfs3xdr.c	2005-09-07 17:53:10.000000000 -0400
@@ -759,8 +759,8 @@
 	strlen = (u32*)kmap(rcvbuf->pages[0]);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
-	if (len > rcvbuf->page_len)
-		len = rcvbuf->page_len;
+	if (len > rcvbuf->page_len - 1 - 4)
+		len = rcvbuf->page_len - 1 - 4;
 	*strlen = len;
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);
