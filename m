Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSGDXuW>; Thu, 4 Jul 2002 19:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315245AbSGDXs5>; Thu, 4 Jul 2002 19:48:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45581 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315214AbSGDXqq>;
	Thu, 4 Jul 2002 19:46:46 -0400
Message-ID: <3D24E05C.4D57A492@zip.com.au>
Date: Thu, 04 Jul 2002 16:55:08 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 22/27] ext3 truncate fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Forward-port of a fix which Stephen has applied to ext3's 2.4 CVS tree.

Fix for a rare problem seen under stress in data=journal mode: if we
have to restart a truncate transaction while traversing the inode's
direct blocks, we need to deal with bh==NULL in ext3_clear_blocks.



 inode.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

--- 2.5.24/fs/ext3/inode.c~ext3-truncate-fix	Thu Jul  4 16:17:31 2002
+++ 2.5.24-akpm/fs/ext3/inode.c	Thu Jul  4 16:17:31 2002
@@ -1632,8 +1632,10 @@ ext3_clear_blocks(handle_t *handle, stru
 		}
 		ext3_mark_inode_dirty(handle, inode);
 		ext3_journal_test_restart(handle, inode);
-		BUFFER_TRACE(bh, "get_write_access");
-		ext3_journal_get_write_access(handle, bh);
+		if (bh) {
+			BUFFER_TRACE(bh, "retaking write access");
+			ext3_journal_get_write_access(handle, bh);
+		}
 	}
 
 	/*

-
