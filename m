Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161596AbWJaDqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161596AbWJaDqO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 22:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161597AbWJaDqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 22:46:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25988 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161596AbWJaDqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 22:46:13 -0500
Message-ID: <4546C701.9020707@redhat.com>
Date: Mon, 30 Oct 2006 21:46:09 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC: Evgeniy Dushistov <dushistov@mail.ru>
Subject: [PATCH] fix UFS superblock alignment issues
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ufs2 fails to mount on x86_64, claiming bad magic.  This is because 
ufs_super_block_third's fs_un1 member is padded out by 4 bytes for
8-byte alignment, pushing down the rest of the struct.

Forcing this to be packed solves it.  I took a quick look over
other on-disk structures and didn't immediately find other problems.
I was able to mount & ls a populated ufs2 filesystem w/ this change.

Thanks,
-Eric

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Index: linux-2.6.18/include/linux/ufs_fs.h
===================================================================
--- linux-2.6.18.orig/include/linux/ufs_fs.h
+++ linux-2.6.18/include/linux/ufs_fs.h
@@ -900,7 +900,7 @@ struct ufs_super_block_third {
 			__fs64   fs_csaddr;	/* blk addr of cyl grp summary area */
 			__fs64    fs_pendingblocks;/* blocks in process of being freed */
 			__fs32    fs_pendinginodes;/*inodes in process of being freed */
-		} fs_u2;
+		} __attribute__ ((packed)) fs_u2;
 	} fs_un1;
 	union {
 		struct {


