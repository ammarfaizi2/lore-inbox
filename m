Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269273AbUI3N2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269273AbUI3N2c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 09:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269256AbUI3N17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 09:27:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42392 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269270AbUI3NYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 09:24:43 -0400
Date: Thu, 30 Sep 2004 14:24:06 +0100
Message-Id: <200409301324.i8UDO6G3004815@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, "Theodore Ts'o" <tytso@mit.edu>,
       ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 10/10]: ext3 online resize: make group-add asynchronous.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's not much to be gained from making the resize group-add operation
fully synchronous.  It's already atomic by virtue of the journal, and a
resize operation usually doesn't add just one group, but many.  The real
need is to sync things up at the end of the *entire* resize, not after
each individual group-add; and by syncing each group separately, the
whole resize operation is made much, much slower if we're running on a
live filesystem.

Signed-off-by: Stephen Tweedie <sct@redhat.com>

--- linux-2.6.9-rc2-mm4/fs/ext3/resize.c.=K0009=.orig
+++ linux-2.6.9-rc2-mm4/fs/ext3/resize.c
@@ -872,7 +872,6 @@ int ext3_group_add(struct super_block *s
 
 exit_journal:
 	unlock_super(sb);
-	handle->h_sync = 1;
 	if ((err2 = ext3_journal_stop(handle)) && !err)
 		err = err2;
 	if (!err) {
