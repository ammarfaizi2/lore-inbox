Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSIZN4X>; Thu, 26 Sep 2002 09:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbSIZN4S>; Thu, 26 Sep 2002 09:56:18 -0400
Received: from pc-62-31-66-34-ed.blueyonder.co.uk ([62.31.66.34]:21891 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261292AbSIZNub>; Thu, 26 Sep 2002 09:50:31 -0400
Date: Thu, 26 Sep 2002 14:55:32 +0100
Message-Id: <200209261355.g8QDtW417002@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 4/7] 2.4.20-pre4/ext3: Sanity check for Intermezzo/ext3 interactions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Andreas Dilger:

Nowhere in journal_start() (or more specifically in start_this_handle()
is any sanity checking on the number of blocks requested for a single
handle done.  If you request more than journal_size/4 blocks for a handle
it will loop endlessly on repeat_locked: trying to "free" enough blocks
to satisfy the request.  The below patch validates the number of blocks
requested is small enough to actually be allocated, otherwise returns
-ENOSPC.

--- linux-2.4-ext3merge/fs/jbd/transaction.c.=K0003=.orig	Thu Sep 26 12:25:37 2002
+++ linux-2.4-ext3merge/fs/jbd/transaction.c	Thu Sep 26 12:25:37 2002
@@ -90,7 +90,14 @@
 	transaction_t *transaction;
 	int needed;
 	int nblocks = handle->h_buffer_credits;
-	
+
+	if (nblocks > journal->j_max_transaction_buffers) {
+		jbd_debug(1, "JBD: %s wants too many credits (%d > %d)\n",
+		       current->comm, nblocks,
+		       journal->j_max_transaction_buffers);
+		return -ENOSPC;
+	}
+
 	jbd_debug(3, "New handle %p going live.\n", handle);
 
 repeat:
