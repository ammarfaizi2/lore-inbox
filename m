Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264250AbRFLIUf>; Tue, 12 Jun 2001 04:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264260AbRFLIUZ>; Tue, 12 Jun 2001 04:20:25 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:8211 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S264250AbRFLIUL>; Tue, 12 Jun 2001 04:20:11 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: linux-kernel@vger.kernel.org
cc: pmenage@ensim.com, alan@redhat.com
Subject: [PATCH] Inode quota allocation loophole (2.2)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 12 Jun 2001 01:17:04 -0700
Message-Id: <E159jMG-0004Wb-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the equivalent patch for Linux 2.2 (prepared against 2.2.19) for
the quota loophole described in my previous email.

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
below for 2.2 - patch for 2.4 in my earlier email). Are there any
undesirable consequences to pipes, sockets and devices having non-NULL
pointers in i_dquot[]?

Paul


--- linux/fs/dquot.c	Sun May 20 11:32:11 2001
+++ linux.new/fs/dquot.c	Tue Jun 12 00:39:50 2001
@@ -667,8 +667,6 @@
 {
 	int cnt;
 
-        if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)))
-                return 0;
 	if (is_quotafile(inode))
 		return 0;
 	if (type != -1)
@@ -1082,38 +1078,34 @@
 	unsigned int id = 0;
 	short cnt;
 
-	if (S_ISREG(inode->i_mode) ||
-            S_ISDIR(inode->i_mode) ||
-            S_ISLNK(inode->i_mode)) {
-		/* We don't want to have quotas on quota files - nasty deadlocks possible */
-		if (is_quotafile(inode))
-			return;
-		for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-			if (type != -1 && cnt != type)
+	/* We don't want to have quotas on quota files - nasty deadlocks possible */
+	if (is_quotafile(inode))
+		return;
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
+		if (type != -1 && cnt != type)
+			continue;
+		
+		if (!sb_has_quota_enabled(inode->i_sb, cnt))
+			continue;
+		
+		if (inode->i_dquot[cnt] == NODQUOT) {
+			switch (cnt) {
+			case USRQUOTA:
+				id = inode->i_uid;
+				break;
+			case GRPQUOTA:
+				id = inode->i_gid;
+				break;
+			}
+			dquot = dqget(inode->i_dev, id, cnt);
+			if (dquot == NODQUOT)
 				continue;
-
-			if (!sb_has_quota_enabled(inode->i_sb, cnt))
+			if (inode->i_dquot[cnt] != NODQUOT) {
+				dqput(dquot);
 				continue;
-
-			if (inode->i_dquot[cnt] == NODQUOT) {
-				switch (cnt) {
-					case USRQUOTA:
-						id = inode->i_uid;
-						break;
-					case GRPQUOTA:
-						id = inode->i_gid;
-						break;
-				}
-				dquot = dqget(inode->i_dev, id, cnt);
-				if (dquot == NODQUOT)
-					continue;
-				if (inode->i_dquot[cnt] != NODQUOT) {
-					dqput(dquot);
-					continue;
-				} 
-				inode->i_dquot[cnt] = dquot;
-				inode->i_flags |= S_QUOTA;
-			}
+			} 
+			inode->i_dquot[cnt] = dquot;
+			inode->i_flags |= S_QUOTA;
 		}
 	}
 }


