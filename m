Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318875AbSH1PlI>; Wed, 28 Aug 2002 11:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318884AbSH1PlH>; Wed, 28 Aug 2002 11:41:07 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:2691 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318875AbSH1PlG>; Wed, 28 Aug 2002 11:41:06 -0400
Date: Wed, 28 Aug 2002 16:45:19 +0100
Message-Id: <200208281545.g7SFjJJ14330@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 3/8] 2.4.20-pre4/ext3: Fix the "dump corrupts filesystems" buffer-cache bug.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since block-dev-in-page-cache was added in 2.4.10, and the aliasing between
buffered devices and getblk() was restored in 2.4.11, getblk() and friends
can be performing IO on a page cache page without the page cache lock
being held.  The page cache IO assumes that the page cache lock is enough
to synchronise things safely, but this breaks if we get aliased IO.

In particular, block_read_full_page() assumes that it is safe to begin IO
on any non-uptodate bh, regardless of the locked status of the bh.  To be
safe, we need to test the uptodate state *after* taking the bh lock.

Already in 2.5.

--- linux-ext3-2.4merge/fs/buffer.c.=K0004=.orig	Tue Aug 27 23:14:15 2002
+++ linux-ext3-2.4merge/fs/buffer.c	Tue Aug 27 23:19:57 2002
@@ -1748,9 +1748,14 @@
 	}
 
 	/* Stage 3: start the IO */
-	for (i = 0; i < nr; i++)
-		submit_bh(READ, arr[i]);
-
+	for (i = 0; i < nr; i++) {
+		struct buffer_head * bh = arr[i];
+		if (buffer_uptodate(bh))
+			end_buffer_io_async(bh, 1);
+		else
+			submit_bh(READ, bh);
+	}
+	
 	return 0;
 }
 
