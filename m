Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313596AbSDZDL4>; Thu, 25 Apr 2002 23:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313601AbSDZDL4>; Thu, 25 Apr 2002 23:11:56 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:23282 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S313596AbSDZDLz>; Thu, 25 Apr 2002 23:11:55 -0400
Date: Thu, 25 Apr 2002 20:11:52 -0700
From: Chris Wright <chris@wirex.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.10 BKL not always released in sem_exit()
Message-ID: <20020425201152.A1337@figure1.int.wirex.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The patch below fixes sem_exit() so that the BKL is always released.

thanks,
-chris

===== ipc/sem.c 1.5 vs edited =====
--- 1.5/ipc/sem.c	Tue Apr 23 17:15:25 2002
+++ edited/ipc/sem.c	Thu Apr 25 20:01:02 2002
@@ -1176,8 +1176,10 @@
 	}
 
 	undo_list = current->sysvsem.undo_list;
-	if ((undo_list == NULL) || (atomic_read(&undo_list->refcnt) != 1))
+	if ((undo_list == NULL) || (atomic_read(&undo_list->refcnt) != 1)) {
+		unlock_kernel();
 		return;
+	}
 
 	/* There's no need to hold the semundo list lock, as current
          * is the last task exiting for this undo list.
