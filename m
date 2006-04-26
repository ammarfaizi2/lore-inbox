Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWDZG0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWDZG0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 02:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWDZG0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 02:26:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40108 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750806AbWDZG0K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 02:26:10 -0400
Date: Wed, 26 Apr 2006 07:26:09 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com
Subject: [PATCH] forgotten ->b_data in memcpy() call in ext3/resize.c (oopsable)
Message-ID: <20060426062609.GH27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sbi->s_group_desc is an array of pointers to buffer_head.  memcpy() of
buffer size from address of buffer_head is a bad idea - it will generate
junk in any case, may oops if buffer_head is close to the end of slab
page and next page is not mapped and isn't what was intended there.
IOW, ->b_data is missing in that call.  Fortunately, result doesn't go
into the primary on-disk data structures, so only backup ones get crap
written to them; that had allowed this bug to remain unnoticed until
now.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/ext3/resize.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

e26179ed6fdd952b91a313a275191ae97bcd4d71
diff --git a/fs/ext3/resize.c b/fs/ext3/resize.c
index c5ffa85..8aac533 100644
--- a/fs/ext3/resize.c
+++ b/fs/ext3/resize.c
@@ -213,7 +213,7 @@ static int setup_new_group_blocks(struct
 			goto exit_bh;
 		}
 		lock_buffer(bh);
-		memcpy(gdb->b_data, sbi->s_group_desc[i], bh->b_size);
+		memcpy(gdb->b_data, sbi->s_group_desc[i]->b_data, bh->b_size);
 		set_buffer_uptodate(gdb);
 		unlock_buffer(bh);
 		ext3_journal_dirty_metadata(handle, gdb);
-- 
1.3.0.g0080f

