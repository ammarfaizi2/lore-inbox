Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261828AbSJNE4a>; Mon, 14 Oct 2002 00:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbSJNE4a>; Mon, 14 Oct 2002 00:56:30 -0400
Received: from packet.digeo.com ([12.110.80.53]:36521 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261825AbSJNE42>;
	Mon, 14 Oct 2002 00:56:28 -0400
Message-ID: <3DAA4FD6.A18DAFE6@digeo.com>
Date: Sun, 13 Oct 2002 22:02:14 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [patch] remove BKL from inode_setattr
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2002 05:02:14.0899 (UTC) FILETIME=[DCC6FC30:01C2733E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since April 05 of this year we've been holding the BKL across the
vmtruncate call out of inode_setattr().  By accident it seems.

This does not affect unlink().  It affects ftruncate() and open(O_TRUNC).

Given that the drop_inode() path does not take the BKL, I would
suggest that it is safe to assume that the various filesystem's
truncate code is safe without this additional VFS-level lock_kernel(),
and that it can be simply removed.

Sound sane?


--- 2.5.42/fs/attr.c~truncate-bkl	Sun Oct 13 20:04:06 2002
+++ 2.5.42-akpm/fs/attr.c	Sun Oct 13 22:01:15 2002
@@ -67,7 +67,6 @@ int inode_setattr(struct inode * inode, 
 	unsigned int ia_valid = attr->ia_valid;
 	int error = 0;
 	
-	lock_kernel();
 	if (ia_valid & ATTR_SIZE) {
 		error = vmtruncate(inode, attr->ia_size);
 		if (error)
@@ -91,7 +90,6 @@ int inode_setattr(struct inode * inode, 
 	}
 	mark_inode_dirty(inode);
 out:
-	unlock_kernel();
 	return error;
 }
 

.
