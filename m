Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbUK2TfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbUK2TfU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUK2Tdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:33:52 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:24760 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261597AbUK2TJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 14:09:44 -0500
Date: Mon, 29 Nov 2004 19:09:18 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Michael Kerrisk <michael.kerrisk@gmx.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Rik van Riel <riel@redhat.com>, Chris Wright <chrisw@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] shmtcl SHM_LOCK perms
Message-ID: <Pine.LNX.4.44.0411291855560.23341-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kerrisk has observed that at present any process can SHM_LOCK
any shm segment of size within process RLIMIT_MEMLOCK, despite having no
permissions on the segment: surprising, though not obviously evil.  And
any process can SHM_UNLOCK any shm segment, despite no permissions on it:
that is surely wrong.

Unless CAP_IPC_LOCK, restrict both SHM_LOCK and SHM_UNLOCK to when the
process euid matches the shm owner or creator: that seems the least
surprising behaviour, which could be relaxed if a need appears later.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.10-rc2-bk13/ipc/shm.c	2004-11-15 16:21:23.000000000 +0000
+++ linux/ipc/shm.c	2004-11-29 18:07:06.398464576 +0000
@@ -511,11 +511,6 @@ asmlinkage long sys_shmctl (int shmid, i
 	case SHM_LOCK:
 	case SHM_UNLOCK:
 	{
-		/* Allow superuser to lock segment in memory */
-		if (!can_do_mlock() && cmd == SHM_LOCK) {
-			err = -EPERM;
-			goto out;
-		}
 		shp = shm_lock(shmid);
 		if(shp==NULL) {
 			err = -EINVAL;
@@ -525,6 +520,16 @@ asmlinkage long sys_shmctl (int shmid, i
 		if(err)
 			goto out_unlock;
 
+		if (!capable(CAP_IPC_LOCK)) {
+			err = -EPERM;
+			if (current->euid != shp->shm_perm.uid &&
+			    current->euid != shp->shm_perm.cuid)
+				goto out_unlock;
+			if (cmd == SHM_LOCK &&
+			    !current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur)
+				goto out_unlock;
+		}
+
 		err = security_shm_shmctl(shp, cmd);
 		if (err)
 			goto out_unlock;

