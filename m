Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264923AbUFRBbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbUFRBbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 21:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbUFRBb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 21:31:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:64480 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264920AbUFRBbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 21:31:25 -0400
Subject: [PATCH] ext3 jbd needs to wait for locked buffers
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Message-Id: <1087522329.8002.82.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 17 Jun 2004 21:32:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbd needs to wait for any io to complete on the buffer before
changing the end_io function.  Using set_buffer_locked means that
it can change the end_io function while the page is in the middle of
writeback, and the writeback bit on the page will never get cleared.

Since we set the buffer dirty earlier on, if the page was
previously dirty, pdflush or memory pressure might trigger a
writepage call, which will race with jbd's set_buffer_locked.

Index: linux.t/fs/jbd/commit.c
===================================================================
--- linux.t.orig/fs/jbd/commit.c	2004-06-17 21:01:28.000000000 -0400
+++ linux.t/fs/jbd/commit.c	2004-06-17 21:02:16.000000000 -0400
@@ -504,7 +504,7 @@ write_out_data:
 start_journal_io:
 			for (i = 0; i < bufs; i++) {
 				struct buffer_head *bh = wbuf[i];
-				set_buffer_locked(bh);
+				lock_buffer(bh);
 				clear_buffer_dirty(bh);
 				set_buffer_uptodate(bh);
 				bh->b_end_io = journal_end_buffer_io_sync;


