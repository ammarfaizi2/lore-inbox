Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTGTF42 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 01:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTGTF41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 01:56:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:14287 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262165AbTGTF40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 01:56:26 -0400
Date: Sat, 19 Jul 2003 23:12:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Morris <Starborn@anime-city.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Joshua Kwan <joshk@triplehelix.org>
Subject: Re: 2.6.0-test1-mm2
Message-Id: <20030719231230.4de39ffe.akpm@osdl.org>
In-Reply-To: <200307200647.43410.Starborn@anime-city.co.uk>
References: <20030719174350.7dd8ad59.akpm@osdl.org>
	<20030720024102.GA18576@triplehelix.org>
	<20030720042918.GA19219@triplehelix.org>
	<200307200647.43410.Starborn@anime-city.co.uk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Morris <Starborn@anime-city.co.uk> wrote:
>
> Here's my oops:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000014
> EIP is at journal_dirty_metadata+0x38/0x210

OK, bad bug.  This should fix it.

 fs/ext3/inode.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff -puN fs/ext3/inode.c~ext3_getblk-race-fix-fix fs/ext3/inode.c
--- 25/fs/ext3/inode.c~ext3_getblk-race-fix-fix	2003-07-19 22:59:50.000000000 -0700
+++ 25-akpm/fs/ext3/inode.c	2003-07-19 23:07:42.000000000 -0700
@@ -936,19 +936,17 @@ struct buffer_head *ext3_getblk(handle_t
 			   ext3_get_block instead, so it's not a
 			   problem. */
 			lock_buffer(bh);
-			if (!buffer_uptodate(bh)) {
-				BUFFER_TRACE(bh, "call get_create_access");
-				fatal = ext3_journal_get_create_access(handle, bh);
-				if (!fatal) {
-					memset(bh->b_data, 0,
-							inode->i_sb->s_blocksize);
-					set_buffer_uptodate(bh);
-				}
+			BUFFER_TRACE(bh, "call get_create_access");
+			fatal = ext3_journal_get_create_access(handle, bh);
+			if (!fatal && !buffer_uptodate(bh)) {
+				memset(bh->b_data, 0, inode->i_sb->s_blocksize);
+				set_buffer_uptodate(bh);
 			}
 			unlock_buffer(bh);
 			BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
 			err = ext3_journal_dirty_metadata(handle, bh);
-			if (!fatal) fatal = err;
+			if (!fatal)
+				fatal = err;
 		} else {
 			BUFFER_TRACE(bh, "not a new buffer");
 		}

_

