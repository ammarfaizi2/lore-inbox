Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314929AbSESTcm>; Sun, 19 May 2002 15:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314906AbSESTcl>; Sun, 19 May 2002 15:32:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:516 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314929AbSESTci>;
	Sun, 19 May 2002 15:32:38 -0400
Message-ID: <3CE7FEB0.4507DF32@zip.com.au>
Date: Sun, 19 May 2002 12:36:16 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 2/15] check for dirtying of non-uptodate buffers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



- Add a debug check to catch people who are marking non-uptodate
  buffers as dirty.

  This is either a source of data corruption, or sloppy programming.

- Fix sloppy programming in ext3 ;)



=====================================

--- 2.5.16/fs/buffer.c~buffer-dirty-check	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/fs/buffer.c	Sun May 19 12:03:00 2002
@@ -1056,6 +1056,8 @@ __getblk(struct block_device *bdev, sect
  */
 void mark_buffer_dirty(struct buffer_head *bh)
 {
+	if (!buffer_uptodate(bh))
+		buffer_error();
 	if (!test_set_buffer_dirty(bh))
 		__set_page_dirty_nobuffers(bh->b_page);
 }
--- 2.5.16/fs/jbd/recovery.c~buffer-dirty-check	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/fs/jbd/recovery.c	Sun May 19 11:49:46 2002
@@ -482,9 +482,9 @@ static int do_one_pass(journal_t *journa
 					}
 
 					BUFFER_TRACE(nbh, "marking dirty");
+					set_buffer_uptodate(nbh);
 					mark_buffer_dirty(nbh);
 					BUFFER_TRACE(nbh, "marking uptodate");
-					set_buffer_uptodate(nbh);
 					++info->nr_replays;
 					/* ll_rw_block(WRITE, 1, &nbh); */
 					unlock_buffer(nbh);


-
