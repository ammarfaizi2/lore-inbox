Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267327AbUI0UL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267327AbUI0UL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbUI0UL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:11:29 -0400
Received: from peabody.ximian.com ([130.57.169.10]:38311 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267301AbUI0UIG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:08:06 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Robert Love <rml@ximian.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       akpm@osdl.org, iggy@gentoo.org
In-Reply-To: <1096250524.18505.2.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
Content-Type: multipart/mixed; boundary="=-traPKC3ZgS8J9A+VbgL/"
Date: Mon, 27 Sep 2004 16:06:46 -0400
Message-Id: <1096315606.30503.109.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-traPKC3ZgS8J9A+VbgL/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-09-26 at 22:02 -0400, John McCutchan wrote:

> Announcing the release of inotify 0.10.0. 
> Attached is a patch to 2.6.8.1.

John,

find_inode() can just return an inode directly, so we don't need the
second argument and the double indirection.

FYI, errors can be encoded in pointers via ERR_PTR(), checked via IS_ERR
(), and retrieved via PTR_ERR().

Patch is on top of your patch and all of my previous patches.

	Robert Love


--=-traPKC3ZgS8J9A+VbgL/
Content-Disposition: attachment; filename=inotify-rml-redo-fix_inode-1.patch
Content-Type: text/x-patch; name=inotify-rml-redo-fix_inode-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

fix_inode() bits

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-27 16:04:21.899344440 -0400
+++ linux/drivers/char/inotify.c	2004-09-27 16:03:20.388695480 -0400
@@ -98,24 +98,29 @@
 };
 #define list_to_inotify_kernel_event(pos) list_entry((pos), struct inotify_kernel_event, list)
 
-static int find_inode(const char __user *dirname, struct inode **inode)
+/*
+ * find_inode - resolve a user-given path to a specific inode and iget() it
+ */
+static struct inode * find_inode(const char __user *dirname)
 {
+	struct inode *inode;
 	struct nameidata nd;
 	int error;
 
 	error = __user_walk(dirname, LOOKUP_FOLLOW, &nd);
 	if (error) {
 		iprintk(INOTIFY_DEBUG_INODE, "could not find inode\n");
+		inode = ERR_PTR(error);
 		goto out;
 	}
 
-	*inode = nd.dentry->d_inode;
-	__iget(*inode);
+	inode = nd.dentry->d_inode;
+	__iget(inode);
 	iprintk(INOTIFY_DEBUG_INODE, "ref'd inode\n");
 	inode_ref_count++;
 	path_release(&nd);
 out:
-	return error;
+	return inode;
 }
 
 static void unref_inode(struct inode *inode)
@@ -841,9 +846,11 @@
 	struct inotify_watcher *watcher;
 	err = 0;
 
-	err = find_inode(request->dirname, &inode);
-	if (err)
+	inode = find_inode(request->dirname);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
 		goto exit;
+	}
 
 	if (!S_ISDIR(inode->i_mode))
 		iprintk(INOTIFY_DEBUG_ERRORS, "watching file\n");

--=-traPKC3ZgS8J9A+VbgL/--

