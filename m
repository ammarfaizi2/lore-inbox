Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287858AbSBUXb1>; Thu, 21 Feb 2002 18:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSBUXbR>; Thu, 21 Feb 2002 18:31:17 -0500
Received: from 216-42-72-168.ppp.netsville.net ([216.42.72.168]:43655 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S287858AbSBUXa6>; Thu, 21 Feb 2002 18:30:58 -0500
Date: Thu, 21 Feb 2002 18:30:20 -0500
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@zip.com.au>, "Stephen C. Tweedie" <sct@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <799880000.1014334220@tiny>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everyone,

I've changed the write barrier code around a little so the block layer 
isn't forced to fail barrier requests the queue can't handle.

This makes it much easier to add support for ide writeback
flushing to things like ext3 and lvm, where I want to make
the minimal possible changes to make things safe.

The full patch is at:
ftp.suse.com/pub/people/mason/patches/2.4.18/queue-barrier-8.diff

There might be additional spots in ext3 where ordering needs to be 
enforced, I've included the ext3 code below in hopes of getting 
some comments.

The only other change was to make reiserfs use the IDE flushing mode
by default.  It falls back to non-ordered calls on scsi.

-chris

--- linus.23/fs/jbd/commit.c Mon, 28 Jan 2002 09:51:50 -0500
+++ linus.23(w)/fs/jbd/commit.c Thu, 21 Feb 2002 17:11:00 -0500
@@ -595,7 +595,15 @@
                struct buffer_head *bh = jh2bh(descriptor);
                clear_bit(BH_Dirty, &bh->b_state);
                bh->b_end_io = journal_end_buffer_io_sync;
+
+               /* if we're on an ide device, setting BH_Ordered_Flush
+                  will force a write cache flush before and after the
+                  commit block.  Otherwise, it'll do nothing.  */
+
+               set_bit(BH_Ordered_Flush, &bh->b_state);
                submit_bh(WRITE, bh);
+               clear_bit(BH_Ordered_Flush, &bh->b_state);
+
                wait_on_buffer(bh);
                put_bh(bh);             /* One for getblk() */
                journal_unlock_journal_head(descriptor);








