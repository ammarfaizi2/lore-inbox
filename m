Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbTJNMyX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 08:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTJNMyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 08:54:23 -0400
Received: from zero.aec.at ([193.170.194.10]:2575 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262397AbTJNMyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 08:54:09 -0400
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide barrier support, #2
From: Andi Kleen <ak@muc.de>
Date: Tue, 14 Oct 2003 14:53:47 +0200
In-Reply-To: <GurO.7cg.43@gated-at.bofh.it> (Jens Axboe's message of "Tue,
 14 Oct 2003 12:20:20 +0200")
Message-ID: <m3zng4ou90.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <GurO.7cg.43@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

This adds support for XFS for log writes (not for fsync).
Based on the 2.4 XFS patch for write barriers I did some time ago.

It just does a flush, not a barrier. I think that's enough for
log writes because XFS waits until the log write has hit disk.

It doesn't do anything special when the flush fails - just
shuts down the file system as usual. 

diff -u linux/fs/xfs/pagebuf/page_buf.c-o linux-2.6.0test6-work/fs/xfs/pagebuf/page_buf.c
--- linux/fs/xfs/pagebuf/page_buf.c-o	2003-09-28 10:52:55.000000000 +0200
+++ linux/fs/xfs/pagebuf/page_buf.c	2003-10-14 14:48:44.000000000 +0200
@@ -1403,12 +1403,12 @@
 
 submit_io:
 	if (likely(bio->bi_size)) {
-		if (pb->pb_flags & PBF_READ) {
-			submit_bio(READ, bio);
-		} else {
-			submit_bio(WRITE, bio);
-		}
-
+		int cmd = WRITE; 
+		if (pb->pb_flags & PBF_READ)
+			cmd = READ;
+		else if (pb->pb_flags & PBF_FLUSH)
+			cmd = WRITESYNC;
+		submit_bio(cmd, bio);
 		if (size)
 			goto next_chunk;
 	} else {
