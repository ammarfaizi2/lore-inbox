Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312074AbSCXVwR>; Sun, 24 Mar 2002 16:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312077AbSCXVv5>; Sun, 24 Mar 2002 16:51:57 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:7945 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312074AbSCXVvw>; Sun, 24 Mar 2002 16:51:52 -0500
Message-ID: <3C9E4A18.7DDC68AB@zip.com.au>
Date: Sun, 24 Mar 2002 13:50:16 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: [patch] speed up ext3 synchronous mounts
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Again, we don't need to sync indirects as we dirty them because
we run a commit if IS_SYNC(inode) prior to returning to the
caller of write(2).

Writing a 10 meg file in 0.1 meg chunks is sped up by, err,
a factor of fifty.  That's a best case.

--- linux-2.4.18-pre8/fs/ext3/inode.c	Tue Feb  5 00:33:05 2002
+++ linux-akpm/fs/ext3/inode.c	Wed Feb  6 23:40:48 2002
@@ -581,8 +581,6 @@ static int ext3_alloc_branch(handle_t *h
 			
 			parent = nr;
 		}
-		if (IS_SYNC(inode))
-			handle->h_sync = 1;
 	}
 	if (n == num)
 		return 0;


-
