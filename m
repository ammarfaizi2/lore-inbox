Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313557AbSEEUyR>; Sun, 5 May 2002 16:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSEEUyQ>; Sun, 5 May 2002 16:54:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43017 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313557AbSEEUxr>;
	Sun, 5 May 2002 16:53:47 -0400
Message-ID: <3CD59C66.CADD24A9@zip.com.au>
Date: Sun, 05 May 2002 13:56:06 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 5/10] Allow ext3 pages to be written back by VM pressure
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



When ext3 refiles journalled buffers for writeback, it is better to set the
page dirty as well as the buffer.  So the page will be written out by
VM pressure rather than by kjournald alone.


=====================================

--- 2.5.13/fs/jbd/transaction.c~ext3-mark_buffer_dirty	Sun May  5 13:32:00 2002
+++ 2.5.13-akpm/fs/jbd/transaction.c	Sun May  5 13:32:35 2002
@@ -1548,7 +1548,7 @@ void __journal_unfile_buffer(struct jour
 	__blist_del_buffer(list, jh);
 	jh->b_jlist = BJ_None;
 	if (test_and_clear_bit(BH_JBDDirty, &jh2bh(jh)->b_state))
-		set_buffer_dirty(jh2bh(jh));
+		mark_buffer_dirty(jh2bh(jh));	/* Expose it to the VM */
 }
 
 void journal_unfile_buffer(struct journal_head *jh)


-
