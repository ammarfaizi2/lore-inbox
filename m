Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbTAWN6g>; Thu, 23 Jan 2003 08:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbTAWN6g>; Thu, 23 Jan 2003 08:58:36 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:54519 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S265168AbTAWN6f>; Thu, 23 Jan 2003 08:58:35 -0500
Date: Thu, 23 Jan 2003 14:09:12 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Oleg Drokin <green@namesys.com>
cc: linux-kernel@vger.kernel.org, <akpm@digeo.com>
Subject: Re: ext2 FS corruption with 2.5.59.
In-Reply-To: <20030123153832.A860@namesys.com>
Message-ID: <Pine.LNX.4.44.0301231402290.1589-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2003, Oleg Drokin wrote:
> 
>     My test consists of running "fsx -c 1234 testfile", "iozone -a",
>     "dbench 60", "fsstress -p10 -n1000000 -d ." at the same time on the
>     tested FS.
>     fsx usually breaks just when dbench is finished.

It was "dbench 100" which led me to investigate and post patch below
a couple of days ago: worth trying again with this patch applied.
But I'm no expert on ext2, and fear there may be lots more wrong:
does look rather as if nobody has been stressing ext2 for a while.

For almost a year (since 2.5.4) ext2_new_block has tended to set err
0 instead of -ENOSPC or -EIO.  This manifested variously (typically
depends on what's stale in ext2_get_block's chain[4] array): sometimes
__brelse free free buffer backtraces, sometimes release_pages oops,
usually generic_make_request beyond end of device messages, followed
by further ext2 errors.

Hugh

--- 2.5.59/fs/ext2/balloc.c	Tue Dec 24 06:23:03 2002
+++ linux/fs/ext2/balloc.c	Tue Jan 21 20:14:37 2003
@@ -470,10 +470,10 @@
 
 	ext2_debug ("allocating block %d. ", block);
 
+	*err = 0;
 out_release:
 	group_release_blocks(desc, gdp_bh, group_alloc);
 	release_blocks(sb, es_alloc);
-	*err = 0;
 out_unlock:
 	unlock_super (sb);
 	DQUOT_FREE_BLOCK(inode, dq_alloc);

