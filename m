Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265810AbUFIQaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbUFIQaQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 12:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265831AbUFIQaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 12:30:16 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:54447 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265810AbUFIQaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 12:30:03 -0400
Date: Wed, 9 Jun 2004 18:29:49 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Michael Clark <michael@metaparadigm.com>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [STACK] >3k call path in ide
Message-ID: <20040609162949.GC29531@wohnheim.fh-wedel.de>
References: <20040609122921.GG21168@wohnheim.fh-wedel.de> <40C72B68.1030404@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40C72B68.1030404@metaparadigm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 June 2004 23:23:20 +0800, Michael Clark wrote:
> 
> Noticed that try_to_free_pages, sync_inodes_sb and wakeup_bdflush features
> in almost all of these traces and although at 284, 308 and 256 respectively
> their not huge but together their neither that small (considering they
> occur all in the same stack trace).
> 
> This is consumed mostly by a struct page_state which is 148 bytes big
> although looking at the code get_page_state(struct page_state *ret)
> only populates the first 6 fields or 24 bytes. get_full_page_state
> which is hardly used updates these other fields.
> 
> Is this a candidate for splitting into 2 structs? 1 containing just the
> first 6 fields needed by the majority of users: try_to_free_pages,
> shrink_all_memory, kswapd, get_dirty_limits, wakeup_bdflush, sync_inodes_sb

Well noticed, although Hugh and Andrew have already exchanged some
patches, see
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0406.1/0134.html

For the moment I consider try_to_free_pages() fixed.

Andrew, what do you thing about the patch below for sync_inodes_sb()?
It's stack consumption is reduced from 308 to 64, at the cost of one
more function call.

Jörn

-- 
Premature optimization is the root of all evil.
-- Donald Knuth

Move a struct page_state into it's own function.  This reduces the stack
consumption for sync_inodes_sb(), as the stack is already partially rolled
back before other functions get called.

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>

 fs-writeback.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

--- linux-2.6.6cow/fs/fs-writeback.c~sync_inodes_sb	2004-06-09 18:19:25.000000000 +0200
+++ linux-2.6.6cow/fs/fs-writeback.c	2004-06-09 18:23:44.000000000 +0200
@@ -396,6 +396,15 @@
 	spin_unlock(&inode_lock);
 }
 
+static long get_nr_to_write(void)
+{
+	struct page_state ps;
+
+	get_page_state(&ps);
+	return ps.nr_dirty + ps.nr_unstable + ps.nr_dirty + ps.nr_unstable +
+			(inodes_stat.nr_inodes - inodes_stat.nr_unused);
+}
+
 /*
  * writeback and wait upon the filesystem's dirty inodes.  The caller will
  * do this in two passes - one to write, and one to wait.  WB_SYNC_HOLD is
@@ -409,7 +418,6 @@
  */
 void sync_inodes_sb(struct super_block *sb, int wait)
 {
-	struct page_state ps;
 	struct writeback_control wbc = {
 		.bdi		= NULL,
 		.sync_mode	= wait ? WB_SYNC_ALL : WB_SYNC_HOLD,
@@ -417,10 +425,7 @@
 		.nr_to_write	= 0,
 	};
 
-	get_page_state(&ps);
-	wbc.nr_to_write = ps.nr_dirty + ps.nr_unstable +
-			(inodes_stat.nr_inodes - inodes_stat.nr_unused) +
-			ps.nr_dirty + ps.nr_unstable;
+	wbc.nr_to_write = get_nr_to_write();
 	wbc.nr_to_write += wbc.nr_to_write / 2;		/* Bit more for luck */
 	spin_lock(&inode_lock);
 	sync_sb_inodes(sb, &wbc);
