Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129119AbRBSQlF>; Mon, 19 Feb 2001 11:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129180AbRBSQk4>; Mon, 19 Feb 2001 11:40:56 -0500
Received: from [62.172.234.2] ([62.172.234.2]:36269 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129119AbRBSQkt>; Mon, 19 Feb 2001 11:40:49 -0500
Date: Mon, 19 Feb 2001 16:39:45 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>,
        Christoph Rohland <cr@sap.com>, Tigran Aivazian <tigran@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sys_semop() EIDRM BUG fix
Message-ID: <Pine.LNX.4.21.0102191634200.5002-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys_semop() is wrong to insist that queue.status be -EIDRM when
sem_lock() fails on awakening.  It is quite normal for update_queue()
to have set status 0, removed process from queue and woken it; but
IPC_RMID come in before that process gets to run (or to lock) -
since process already off queue, its status is not set to -EIDRM.
If we want a safety check here, check removed from queue instead.
Return original status or -EIDRM? Checked other OSes, use -EIDRM.

diff -urN linux-2.4.2-pre4/ipc/sem.c linux/ipc/sem.c
--- linux-2.4.2-pre4/ipc/sem.c	Sat Feb 17 11:14:27 2001
+++ linux/ipc/sem.c	Sun Feb 18 08:21:37 2001
@@ -922,7 +922,7 @@
 
 		tmp = sem_lock(semid);
 		if(tmp==NULL) {
-			if(queue.status != -EIDRM)
+			if(queue.prev != NULL)
 				BUG();
 			current->semsleeping = NULL;
 			error = -EIDRM;

