Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965204AbVJ1JmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbVJ1JmI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 05:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965205AbVJ1JmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 05:42:08 -0400
Received: from koto.vergenet.net ([210.128.90.7]:54978 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S965204AbVJ1JmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 05:42:07 -0400
Date: Fri, 28 Oct 2005 18:27:46 +0900
From: Horms <horms@verge.net.au>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] [SECURITY, 2.4]  Avoid 'names_cache' memory leak with CONFIG_AUDITSYSCALL
Message-ID: <20051028092745.GL11045@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Cluestick: seven
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is CAN-2005-3181, and a backport of
829841146878e082613a49581ae252c071057c23 from Linus's 2.6 tree to 2.4.

Original Description and Sign-Off:

Avoid 'names_cache' memory leak with CONFIG_AUDITSYSCALL

The nameidata "last.name" is always allocated with "__getname()", and
should always be free'd with "__putname()".

Using "putname()" without the underscores will leak memory, because the
allocation will have been hidden from the AUDITSYSCALL code.

Arguably the real bug is that the AUDITSYSCALL code is really broken,
but in the meantime this fixes the problem people see.

Reported by Robert Derr, patch by Rick Lindsley.

Acked-by: Al Viro <viro@ftp.linux.org.uk>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

My sign off, indicating I think it applies to 2.4:

Signed-off-by: Horms <horms@verge.net.au>

--- from-0001/fs/namei.c
+++ to-work/fs/namei.c	2005-10-11 18:23:56.000000000 +0900
@@ -1198,18 +1198,18 @@ do_link:
 	if (nd->last_type != LAST_NORM)
 		goto exit;
 	if (nd->last.name[nd->last.len]) {
-		putname(nd->last.name);
+		__putname(nd->last.name);
 		goto exit;
 	}
 	error = -ELOOP;
 	if (count++==32) {
-		putname(nd->last.name);
+		__putname(nd->last.name);
 		goto exit;
 	}
 	dir = nd->dentry;
 	down(&dir->d_inode->i_sem);
 	dentry = lookup_hash(&nd->last, nd->dentry);
-	putname(nd->last.name);
+	__putname(nd->last.name);
 	goto do_last;
 }
 

