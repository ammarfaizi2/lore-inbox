Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVERPvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVERPvL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVERPta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:49:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8585 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262251AbVERPre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:47:34 -0400
Date: Wed, 18 May 2005 11:47:17 -0400
From: Stephen Tweedie <sct@redhat.com>
To: ext2-devel@lists.sourceforge.net, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Stephen Tweedie <sct@redhat.com>
Subject: [PATCH] Avoid console spam with ext3 aborted journal.
Message-ID: <20050518154717.GA31689@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ext3-fix-console-spam.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid console spam with ext3 aborted journal.

ext3 usually reports error conditions that it detects in its environment.
But when its journal gets aborted due to such errors, it can sometimes 
continue to report that condition forever, spamming the console to such 
an extent that the initial first cause of the journal abort can be lost.

When the journal aborts, we put the filesystem into readonly mode.  Most
subsequent filesystem operations will get rejected immediately by checks
for MS_RDONLY either in the filesystem or in the VFS.  But some paths do
not have such checks --- for example, if we continue to write to a file
handle that was opened before the fs went readonly.  (We only check for
the ROFS condition when the file is first opened.)  In these cases, we 
can continue to generate log errors similar to

EXT3-fs error (device $DEV) in start_transaction: Journal has aborted

for each subsequent write.

There is really no point in generating these errors after the initial
error has been fully reported.  Specifically, if we're starting a 
completely new filesystem operation, and the filesystem is *already*
readonly (ie. the ext3 layer has already detected and handled the 
underlying jbd abort), and we see an EROFS error, then there is simply
no point in reporting it again.

Signed-off-by: Stephen Tweedie <sct@redhat.com>

---
commit d08d18bb708d42b2e091c9e09e78a0012ebeb013
tree ed4c2d9e8f2192cf1c769f50f40f64cb1cfb193d
parent 844f68d0f8b098a80ccd6802c38daa7db05e00bd
author Stephen Tweedie <sct@redhat.com> Wed, 18 May 2005 12:54:42 +0100
committer Stephen Tweedie <sct@redhat.com> Wed, 18 May 2005 12:54:42 +0100

 ext3/super.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

Index: fs/ext3/super.c
===================================================================
--- 821049ac4ae8c959b67fab0ef8589007d6c8d048/fs/ext3/super.c  (mode:100644)
+++ ed4c2d9e8f2192cf1c769f50f40f64cb1cfb193d/fs/ext3/super.c  (mode:100644)
@@ -225,8 +225,16 @@
 		       int errno)
 {
 	char nbuf[16];
-	const char *errstr = ext3_decode_error(sb, errno, nbuf);
+	const char *errstr;
+
+	/* Special case: if the error is EROFS, and we're not already
+	 * inside a transaction, then there's really no point in logging
+	 * an error. */
+	if (errno == -EROFS && journal_current_handle() == NULL &&
+	    (sb->s_flags & MS_RDONLY))
+		return;
 
+	errstr = ext3_decode_error(sb, errno, nbuf);
 	printk (KERN_CRIT "EXT3-fs error (device %s) in %s: %s\n",
 		sb->s_id, function, errstr);
 
