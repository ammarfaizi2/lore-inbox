Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262270AbSJNXzf>; Mon, 14 Oct 2002 19:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262272AbSJNXze>; Mon, 14 Oct 2002 19:55:34 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:2761 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S262270AbSJNXzc>; Mon, 14 Oct 2002 19:55:32 -0400
Subject: [PATCH] Forward port of 2.4 fsync_buffers_list() fix.
From: Tim Wright <timw@splhi.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Oct 2002 17:01:20 -0700
Message-Id: <1034640080.2017.33.camel@kryten.internal.splhi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
there was a bug in fysnc_buffers_list() in 2.4 (fixed in 2.4.19) that
could cause the function to return without having written the current
contents of all the buffers. Obviously, this could be bad for anybody
relying on ordering using O_SYNC or fsync(). If an I/O was already in
flight for a particular bh at the time of the call to
fsync_buffers_list(), ll_rw_block() will not initiate a new I/O even
though the contents may have changed. It is therefore necessary to wait
before the call. Here's a patch against 2.5.42 that applies the same
fix.

Regards,

Tim

--- linux-2.5.42/fs/buffer.c	Mon Oct 14 16:38:53 2002
+++ linux/fs/buffer.c	Mon Oct 14 16:51:54 2002
@@ -812,6 +812,13 @@
 			if (buffer_dirty(bh)) {
 				get_bh(bh);
 				spin_unlock(lock);
+				/*
+				 * Ensure any pending I/O completes so that
+				 * ll_rw_block() actually writes the current
+				 * contents - it is a noop if I/O is still in
+				 * flight on potentially older contents.
+				 */
+				wait_on_buffer(bh);
 				ll_rw_block(WRITE, 1, &bh);
 				brelse(bh);
 				spin_lock(lock);

