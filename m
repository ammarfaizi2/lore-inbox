Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbTIHQBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbTIHQBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:01:45 -0400
Received: from angband.namesys.com ([212.16.7.85]:7879 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262697AbTIHQBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:01:05 -0400
Date: Mon, 8 Sep 2003 19:29:15 +0400
From: Oleg Drokin <green@namesys.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, jdike@addtoit.com
Subject: Fix noop elevator request merging (in current 2.5 bk)
Message-ID: <20030908152915.GA29554@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   This patch is required otherwise in case if elv_try_last_merge returns nonzero, we do not
   initialise *req, and subsequent BUG_ON() in __make_request() will dies because req is NULL
   (or is just uninitialised).
   This stopped my UBD devices to work, that's how I noticed ;)

Bye,
    Oleg

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1228  -> 1.1229 
#	drivers/block/noop-iosched.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/08	green@angband.namesys.com	1.1229
# Fix request merging in noop elevator, preventing a crash in __make_request()
# --------------------------------------------
#
diff -Nru a/drivers/block/noop-iosched.c b/drivers/block/noop-iosched.c
--- a/drivers/block/noop-iosched.c	Mon Sep  8 19:25:35 2003
+++ b/drivers/block/noop-iosched.c	Mon Sep  8 19:25:35 2003
@@ -24,8 +24,10 @@
 	struct request *__rq;
 	int ret;
 
-	if ((ret = elv_try_last_merge(q, bio)))
+	if ((ret = elv_try_last_merge(q, bio))) {
+		*req = q->last_merge;
 		return ret;
+	}
 
 	while ((entry = entry->prev) != &q->queue_head) {
 		__rq = list_entry_rq(entry);
