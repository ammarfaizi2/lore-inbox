Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267441AbUBSXkn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 18:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267585AbUBSXkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 18:40:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:31946 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267441AbUBSXkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 18:40:32 -0500
Date: Thu, 19 Feb 2004 15:42:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Gertjan van Wingerde <gwingerde@home.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 and/or SCSI bug?
Message-Id: <20040219154218.70d63704.akpm@osdl.org>
In-Reply-To: <200402192011.40854.gwingerde@home.nl>
References: <200402192011.40854.gwingerde@home.nl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gertjan van Wingerde <gwingerde@home.nl> wrote:
>
> Below is an part of my dmesg output that I captured when all of a sudden one
> of my filesystems became mounted read-only (while some heavy reading/
> writing was being performed to that filesystem).
> 
> Can anyone explain to me what is going on here, and why this is happening 
> to me about every 10 days.

I don't know why this:

>  EXT3-fs error (device sdb8): ext3_free_blocks: bit already cleared for block 1142880
>  Aborting journal on device sdb8.

is occurring.  It indicates that the filesystem metadata is corrupted.  You
should force a fsck to fix it up.  It could be a hardware problem (disk,
cable, controller, power supply, or even main memory).

>  bad: scheduling while atomic!
>  Call Trace:
>   [<c012049e>] schedule+0x68e/0x6a0

This part is caused by a minor bug.



ext3_error() sleeps, so don't call it with the lock held.


---

 25-akpm/fs/ext3/balloc.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN fs/ext3/balloc.c~ext3-schedule-inside-lock-fix fs/ext3/balloc.c
--- 25/fs/ext3/balloc.c~ext3-schedule-inside-lock-fix	Thu Feb 19 15:37:04 2004
+++ 25-akpm/fs/ext3/balloc.c	Thu Feb 19 15:38:16 2004
@@ -239,9 +239,10 @@ do_more:
 		BUFFER_TRACE(bitmap_bh, "clear bit");
 		if (!ext3_clear_bit_atomic(sb_bgl_lock(sbi, block_group),
 						bit + i, bitmap_bh->b_data)) {
-			ext3_error (sb, __FUNCTION__,
-				      "bit already cleared for block %lu", 
-				      block + i);
+			jbd_unlock_bh_state(bitmap_bh);
+			ext3_error(sb, __FUNCTION__,
+				"bit already cleared for block %lu", block + i);
+			jbd_lock_bh_state(bitmap_bh);
 			BUFFER_TRACE(bitmap_bh, "bit already cleared");
 		} else {
 			dquot_freed_blocks++;

_

