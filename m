Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264465AbTDPRcF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 13:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264486AbTDPRcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 13:32:05 -0400
Received: from palrel12.hp.com ([156.153.255.237]:42215 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264465AbTDPRcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 13:32:03 -0400
Date: Wed, 16 Apr 2003 10:43:52 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200304161743.h3GHhqoi017842@napali.hpl.hp.com>
To: torvalds@transmeta.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: fix fs->lock deadlock
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below is needed to avoid a deadlock on fs->lock.  Without
the patch, if __emul_lookup_dentry() returns 0, we fail to reacquire
current->fs->lock and then go ahead to read_unlock() it anyhow.  Bad
for your health.

I believe the bug was introduced by this change set (about 9 weeks ago):

  http://linux.bkbits.net:8080/linux-2.5/diffs/fs/namei.c@1.63.1.2

	--david

===== fs/namei.c 1.69 vs edited =====
--- 1.69/fs/namei.c	Wed Apr  2 22:51:31 2003
+++ edited/fs/namei.c	Wed Apr 16 10:18:40 2003
@@ -847,6 +847,7 @@
 			read_unlock(&current->fs->lock);
 			if (__emul_lookup_dentry(name,nd))
 				return 0;
+			read_lock(&current->fs->lock);
 		}
 		nd->mnt = mntget(current->fs->rootmnt);
 		nd->dentry = dget(current->fs->root);
