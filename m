Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312937AbSDBVXe>; Tue, 2 Apr 2002 16:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSDBVXX>; Tue, 2 Apr 2002 16:23:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61446 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312937AbSDBVXM>;
	Tue, 2 Apr 2002 16:23:12 -0500
Message-ID: <3CAA2100.C493214@zip.com.au>
Date: Tue, 02 Apr 2002 13:22:08 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [patch] fix ext3 i_blocks accounting
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the "i_blocks went wrong when the disk filled up"
problem.

In ext3_new_block() we increment i_blocks early, so the
quota operation can be performed outside lock_super().
But if the block allocation ends up failing, we forget to
undo the allocation.  

This is not a serious bug, and probably does not warrant
an upgrade for production machines.  Its effects are:

1) errors are generated from e2fsck and

2) users could appear to be over quota when they really aren't.

The patch undoes the accounting operation if the allocation
ends up failing.


--- 2.4.19-pre5/fs/ext3/balloc.c~ext3-i_blocks	Tue Apr  2 13:12:34 2002
+++ 2.4.19-pre5-akpm/fs/ext3/balloc.c	Tue Apr  2 13:15:03 2002
@@ -542,6 +542,7 @@ int ext3_new_block (handle_t *handle, st
 	int i, j, k, tmp, alloctmp;
 	int bitmap_nr;
 	int fatal = 0, err;
+	int performed_allocation = 0;
 	struct super_block * sb;
 	struct ext3_group_desc * gdp;
 	struct ext3_super_block * es;
@@ -644,8 +645,7 @@ int ext3_new_block (handle_t *handle, st
 	}
 
 	/* No space left on the device */
-	unlock_super (sb);
-	return 0;
+	goto out;
 
 search_back:
 	/* 
@@ -694,6 +694,7 @@ got_block:
 	J_ASSERT_BH(bh, !ext3_test_bit(j, bh->b_data));
 	BUFFER_TRACE(bh, "setting bitmap bit");
 	ext3_set_bit(j, bh->b_data);
+	performed_allocation = 1;
 
 #ifdef CONFIG_JBD_DEBUG
 	{
@@ -815,6 +816,11 @@ out:
 		ext3_std_error(sb, fatal);
 	}
 	unlock_super (sb);
+	/*
+	 * Undo the block allocation
+	 */
+	if (!performed_allocation)
+		DQUOT_FREE_BLOCK(inode, 1);
 	return 0;
 	
 }

-
