Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162244AbWKPCok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162244AbWKPCok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162241AbWKPCoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:44:39 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:30863 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162244AbWKPCoY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:44:24 -0500
Message-Id: <20061116024524.487362000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:40 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Eric Sandeen <sandeen@redhat.com>,
       Evgeniy Dushistov <dushistov@mail.ru>
Subject: [patch 08/30] fix UFS superblock alignment issues
Content-Disposition: inline; filename=fix-ufs-superblock-alignment-issues.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Eric Sandeen <sandeen@redhat.com>

ufs2 fails to mount on x86_64, claiming bad magic.  This is because
ufs_super_block_third's fs_un1 member is padded out by 4 bytes for 8-byte
alignment, pushing down the rest of the struct.

Forcing this to be packed solves it.  I took a quick look over other
on-disk structures and didn't immediately find other problems.  I was able
to mount & ls a populated ufs2 filesystem w/ this change.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Cc: Evgeniy Dushistov <dushistov@mail.ru>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 include/linux/ufs_fs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.2.orig/include/linux/ufs_fs.h
+++ linux-2.6.18.2/include/linux/ufs_fs.h
@@ -900,7 +900,7 @@ struct ufs_super_block_third {
 			__fs64   fs_csaddr;	/* blk addr of cyl grp summary area */
 			__fs64    fs_pendingblocks;/* blocks in process of being freed */
 			__fs32    fs_pendinginodes;/*inodes in process of being freed */
-		} fs_u2;
+		} __attribute__ ((packed)) fs_u2;
 	} fs_un1;
 	union {
 		struct {

--
