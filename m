Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319347AbSHVOIY>; Thu, 22 Aug 2002 10:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319350AbSHVOIY>; Thu, 22 Aug 2002 10:08:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27662 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319347AbSHVOIX>;
	Thu, 22 Aug 2002 10:08:23 -0400
Date: Thu, 22 Aug 2002 15:12:32 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Restore an optimisation to locks.c
Message-ID: <20020822151232.V29958@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


akpm reports that this optimisation I removed in 2.4.30 actually has
a noticeable impact.  Please apply:

diff -urpNX dontdiff linux-2.5.31/fs/locks.c linux-2.5.31-willy/fs/locks.c
--- linux-2.5.31/fs/locks.c	2002-08-01 14:16:39.000000000 -0700
+++ linux-2.5.31-willy/fs/locks.c	2002-08-21 08:29:29.000000000 -0700
@@ -1609,6 +1612,14 @@ void locks_remove_posix(struct file *fil
 {
 	struct file_lock lock;
 
+	/*
+	 * If there are no locks held on this file, we don't need to call
+	 * posix_lock_file().  Another process could be setting a lock on this
+	 * file at the same time, but we wouldn't remove that lock anyway.
+	 */
+	if (!filp->f_dentry->d_inode->i_flock)
+		return;
+
 	lock.fl_type = F_UNLCK;
 	lock.fl_flags = FL_POSIX;
 	lock.fl_start = 0;

-- 
Revolutions do not require corporate support.
