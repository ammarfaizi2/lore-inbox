Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262815AbUKTAVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbUKTAVn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbUKTARx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:17:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46480 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262850AbUKTANR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:13:17 -0500
Date: Sat, 20 Nov 2004 00:13:05 GMT
Message-Id: <200411200013.iAK0D5mt006624@sisko.sctweedie.blueyonder.co.uk>
From: Stephen Tweedie <sct@redhat.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 1/3]: ext3: cleanup handling of aborted transactions.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves ext3's error loggin when we encounter an on-disk
corruption.  Previously, a transaction (such as a truncate) which
encountered many corruptions (eg. a single highly-corrupt indirect
block) would emit copious "aborting transaction" errors to the log.

Even worse, encountering an aborted journal can count as such an
error, leading to a flood of spurious "aborting transaction: Journal
has aborted" errors.

With the fix, only emit that message on the first error.  The patch
also restores a missing \n in that printk path.

Signed-off-by: Stephen Tweedie <sct@redhat.com>

--- linux-2.6-ext3/fs/ext3/super.c.=K0000=.orig
+++ linux-2.6-ext3/fs/ext3/super.c
@@ -108,14 +108,19 @@ void ext3_journal_abort_handle(const cha
 	char nbuf[16];
 	const char *errstr = ext3_decode_error(NULL, err, nbuf);
 
-	printk(KERN_ERR "%s: aborting transaction: %s in %s", 
-	       caller, errstr, err_fn);
-
 	if (bh)
 		BUFFER_TRACE(bh, "abort");
-	journal_abort_handle(handle);
+
 	if (!handle->h_err)
 		handle->h_err = err;
+
+	if (is_handle_aborted(handle))
+		return;
+	
+	printk(KERN_ERR "%s: aborting transaction: %s in %s\n", 
+	       caller, errstr, err_fn);
+
+	journal_abort_handle(handle);
 }
 
 /* Deal with the reporting of failure conditions on a filesystem such as
