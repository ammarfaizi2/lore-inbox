Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263381AbTEVXIg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 19:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTEVXIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 19:08:36 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:48109 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263381AbTEVXIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 19:08:34 -0400
Date: Thu, 22 May 2003 16:20:02 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-fs@cwi.nl, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch?] truncate and timestamps
Message-Id: <20030522162002.1d45a056.akpm@digeo.com>
In-Reply-To: <UTC200305221909.h4MJ9h903738.aeb@smtp.cwi.nl>
References: <UTC200305221909.h4MJ9h903738.aeb@smtp.cwi.nl>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 May 2003 23:21:39.0346 (UTC) FILETIME=[E587CF20:01C320B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>
> Investigating why some SuSE init script no longer works, I find:
> The shell command
>     > file
> does not update the time stamp of file in case it existed and had size 0.

oops.  That's due to me "don't call vmtruncate if i_size didn't change"
speedup.  It was a pretty good speedup too.

Does this look sane?


 25-akpm/fs/attr.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff -puN fs/attr.c~a fs/attr.c
--- 25/fs/attr.c~a	Thu May 22 16:16:33 2003
+++ 25-akpm/fs/attr.c	Thu May 22 16:18:13 2003
@@ -68,10 +68,17 @@ int inode_setattr(struct inode * inode, 
 	int error = 0;
 
 	if (ia_valid & ATTR_SIZE) {
-		if (attr->ia_size != inode->i_size)
+		if (attr->ia_size != inode->i_size) {
 			error = vmtruncate(inode, attr->ia_size);
-		if (error || (ia_valid == ATTR_SIZE))
-			goto out;
+			if (error)
+				goto out;
+		} else {
+			/*
+			 * We skipped the truncate but must still update
+			 * timestamps
+			 */
+			ia_valid |= ATTR_MTIME|ATTR_CTIME;
+		}
 	}
 
 	lock_kernel();

_

