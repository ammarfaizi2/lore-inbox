Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288963AbSAISoG>; Wed, 9 Jan 2002 13:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287850AbSAISn5>; Wed, 9 Jan 2002 13:43:57 -0500
Received: from rj.SGI.COM ([204.94.215.100]:62178 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S288963AbSAISnn>;
	Wed, 9 Jan 2002 13:43:43 -0500
Subject: ext3 umount oops in 2.5.2-pre10
From: Steve Lord <lord@sgi.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 09 Jan 2002 12:42:40 -0600
Message-Id: <1010601760.29727.138.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It looks like ext3 does not work if you do not use an external
journal device - the journal_bdev field is not initialized and
ext3_put_super goes belly up:


At the very least it needs this:

===========================================================================
Index: linux/fs/ext3/super.c
===========================================================================

--- /usr/tmp/TmpDir.13226-0/linux/fs/ext3/super.c_1.6	Wed Jan  9 12:38:48 2002
+++ linux/fs/ext3/super.c	Wed Jan  9 12:26:00 2002
@@ -429,7 +429,7 @@
 	J_ASSERT(list_empty(&sbi->s_orphan));
 
 	invalidate_bdev(sb->s_bdev, 0);
-	if (sbi->journal_bdev != sb->s_bdev) {
+	if (sbi->journal_bdev && (sbi->journal_bdev != sb->s_bdev)) {
 		/*
 		 * Invalidate the journal device's buffers.  We don't want them
 		 * floating about in memory - the physical journal device may



-- 

Steve

