Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265930AbUFITaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265930AbUFITaE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 15:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265864AbUFIT2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 15:28:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:11944 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265920AbUFIT2R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 15:28:17 -0400
Date: Wed, 9 Jun 2004 12:27:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?SvZybg==?= Engel <joern@wohnheim.fh-wedel.de>
Cc: michael@metaparadigm.com, linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: [STACK] >3k call path in ide
Message-Id: <20040609122721.0695cf96.akpm@osdl.org>
In-Reply-To: <20040609162949.GC29531@wohnheim.fh-wedel.de>
References: <20040609122921.GG21168@wohnheim.fh-wedel.de>
	<40C72B68.1030404@metaparadigm.com>
	<20040609162949.GC29531@wohnheim.fh-wedel.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
>
>  Andrew, what do you thing about the patch below for sync_inodes_sb()?
>  It's stack consumption is reduced from 308 to 64, at the cost of one
>  more function call.

Like this:

--- 25/fs/fs-writeback.c~sync_inodes_sb-stack-reduction	2004-06-09 12:25:57.111389456 -0700
+++ 25-akpm/fs/fs-writeback.c	2004-06-09 12:25:57.115388848 -0700
@@ -433,15 +433,15 @@ restart:
  */
 void sync_inodes_sb(struct super_block *sb, int wait)
 {
-	struct page_state ps;
 	struct writeback_control wbc = {
 		.sync_mode	= wait ? WB_SYNC_ALL : WB_SYNC_HOLD,
 	};
+	unsigned long nr_dirty = read_page_state(nr_dirty);
+	unsigned long nr_unstable = read_page_state(nr_unstable);
 
-	get_page_state(&ps);
-	wbc.nr_to_write = ps.nr_dirty + ps.nr_unstable +
+	wbc.nr_to_write = nr_dirty + nr_unstable +
 			(inodes_stat.nr_inodes - inodes_stat.nr_unused) +
-			ps.nr_dirty + ps.nr_unstable;
+			nr_dirty + nr_unstable;
 	wbc.nr_to_write += wbc.nr_to_write / 2;		/* Bit more for luck */
 	spin_lock(&inode_lock);
 	sync_sb_inodes(sb, &wbc);
_

