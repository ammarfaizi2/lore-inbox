Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264246AbRFLIRE>; Tue, 12 Jun 2001 04:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264250AbRFLIQy>; Tue, 12 Jun 2001 04:16:54 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:52498 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S264246AbRFLIQo>; Tue, 12 Jun 2001 04:16:44 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, Jan Kara <jack@suse.cz>, alan@redhat.com
cc: pmenage@ensim.com
Subject: [PATCH] Inode quota allocation loophole (2.4)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 12 Jun 2001 01:13:36 -0700
Message-Id: <E159jIv-0004W5-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently, dquot_initialize() is a no-op if the inode being initialized
isn't a regular file, directory or symlink. This means that calling
DQUOT_ALLOC_INODE() on a named pipe or AF_UNIX socket has no effect (the
same applies to devices, but this is less likely to be a problem as
random users can't create them); as a result a user can exhaust the
filesystem's inodes even when they have a quota limit. This problem is
exploitable in 2.2.19 and 2.4.2, and appears to be present in all kernel
versions that I've looked at.

I presume that the reason for not putting quotas on pipes and sockets is
that it's slightly more efficient not to do so. If that's the case, then
the simplest solution would be to remove the checks in fs/dquot.c (patch
below for 2.4.5 - patch for 2.2 in following email). Are there any
undesirable consequences to pipes, sockets and devices having non-NULL
pointers in i_dquot[]?

Paul


--- linux/fs/dquot.c	Sun May 20 11:32:11 2001
+++ linux.new/fs/dquot.c	Tue Jun 12 00:39:50 2001
@@ -651,8 +651,6 @@
 {
 	int cnt;
 
-        if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)))
-                return 0;
 	if (is_quotafile(inode))
 		return 0;
 	if (type != -1)
@@ -1022,9 +1020,6 @@
 	unsigned int id = 0;
 	short cnt;
 
-	if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode) &&
-            !S_ISLNK(inode->i_mode))
-		return;
 	lock_kernel();
 	/* We don't want to have quotas on quota files - nasty deadlocks possible */
 	if (is_quotafile(inode)) {







