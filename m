Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278030AbRJOTQy>; Mon, 15 Oct 2001 15:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278040AbRJOTQp>; Mon, 15 Oct 2001 15:16:45 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:53720
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S278030AbRJOTQa>; Mon, 15 Oct 2001 15:16:30 -0400
Date: Mon, 15 Oct 2001 15:16:39 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
cc: alan@redhat.com
Subject: [PATCH] (ac only) quota deadlocks on unmount
Message-ID: <136890000.1003173399@tiny>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everyone,

Alan, you're cc'd as an FYI, don't apply this until you get
verification from someone who knows the quota code ;-)

dqput_blocks can return 0 when dqput might decide to call
commit_dqout.  This is bad because remove_inode_dquot_ref
is called with the inode_lock held, and commit_dquot can
trigger schedules or another attempt on the inode_lock.

This is working for me:

-chris

Index: 0.43/fs/dquot.c
--- 0.43/fs/dquot.c Mon, 15 Oct 2001 03:51:05 -0400
+++ 0.43(w)/fs/dquot.c Mon, 15 Oct 2001 14:12:57 -0400
@@ -1246,6 +1246,8 @@
 {
 	if (dquot->dq_dup_ref && dquot->dq_count - dquot->dq_dup_ref <= 1)
 		return 1;
+	if (dquot->dq_count <= 1 && dquot->dq_flags & DQ_MOD) 
+		return 1; 
 	return 0;
 }
 

