Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129326AbRBSQpP>; Mon, 19 Feb 2001 11:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129541AbRBSQoz>; Mon, 19 Feb 2001 11:44:55 -0500
Received: from [62.172.234.2] ([62.172.234.2]:56244 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129436AbRBSQov>; Mon, 19 Feb 2001 11:44:51 -0500
Date: Mon, 19 Feb 2001 16:43:44 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>,
        Christoph Rohland <cr@sap.com>, Tigran Aivazian <tigran@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] IPC id checks off-by-one
Message-ID: <Pine.LNX.4.21.0102191639500.5002-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Five IPC id checks against array size are off-by-one.
Only the last instance, in ipc_lock(), really matters;
but all should be fixed to set the right example.

diff -urN linux-2.4.2-pre4/ipc/msg.c linux/ipc/msg.c
--- linux-2.4.2-pre4/ipc/msg.c	Sat Feb 17 11:14:26 2001
+++ linux/ipc/msg.c	Sun Feb 18 08:20:25 2001
@@ -473,7 +473,7 @@
 		int success_return;
 		if (!buf)
 			return -EFAULT;
-		if(cmd == MSG_STAT && msqid > msg_ids.size)
+		if(cmd == MSG_STAT && msqid >= msg_ids.size)
 			return -EINVAL;
 
 		memset(&tbuf,0,sizeof(tbuf));
diff -urN linux-2.4.2-pre4/ipc/sem.c linux/ipc/sem.c
--- linux-2.4.2-pre4/ipc/sem.c	Sat Feb 17 11:14:27 2001
+++ linux/ipc/sem.c	Sun Feb 18 08:21:37 2001
@@ -467,7 +467,7 @@
 		struct semid64_ds tbuf;
 		int id;
 
-		if(semid > sem_ids.size)
+		if(semid >= sem_ids.size)
 			return -EINVAL;
 
 		memset(&tbuf,0,sizeof(tbuf));
diff -urN linux-2.4.2-pre4/ipc/util.c linux/ipc/util.c
--- linux-2.4.2-pre4/ipc/util.c	Sat Feb 17 11:14:27 2001
+++ linux/ipc/util.c	Sun Feb 18 08:23:06 2001
@@ -185,7 +185,7 @@
 {
 	struct kern_ipc_perm* p;
 	int lid = id % SEQ_MULTIPLIER;
-	if(lid > ids->size)
+	if(lid >= ids->size)
 		BUG();
 	p = ids->entries[lid].p;
 	ids->entries[lid].p = NULL;
diff -urN linux-2.4.2-pre4/ipc/util.h linux/ipc/util.h
--- linux-2.4.2-pre4/ipc/util.h	Thu Jun 22 15:09:45 2000
+++ linux/ipc/util.h	Sun Feb 18 08:25:10 2001
@@ -54,7 +54,7 @@
 {
 	struct kern_ipc_perm* out;
 	int lid = id % SEQ_MULTIPLIER;
-	if(lid > ids->size)
+	if(lid >= ids->size)
 		return NULL;
 
 	out = ids->entries[lid].p;
@@ -69,7 +69,7 @@
 {
 	struct kern_ipc_perm* out;
 	int lid = id % SEQ_MULTIPLIER;
-	if(lid > ids->size)
+	if(lid >= ids->size)
 		return NULL;
 
 	spin_lock(&ids->ary);

