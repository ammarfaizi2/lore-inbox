Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVJIQJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVJIQJW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 12:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVJIQJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 12:09:22 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:4753 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750711AbVJIQJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 12:09:22 -0400
Message-ID: <434943A5.BD5440AC@tv-sign.ru>
Date: Sun, 09 Oct 2005 20:21:57 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] coredump_wait() cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch deletes pointless (please correct me if I am wrong)
code from coredump_wait().

1. It does useless mm->core_waiters inc/dec under mm->mmap_sem,
   but any changes to ->core_waiters have no effect until we drop
   ->mmap_sem.

2. It calls yield() for absolutely unknown reason.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.14-rc3/fs/exec.c~	2005-09-21 21:08:33.000000000 +0400
+++ 2.6.14-rc3/fs/exec.c	2005-10-09 23:54:45.000000000 +0400
@@ -1422,19 +1422,16 @@ static void zap_threads (struct mm_struc
 static void coredump_wait(struct mm_struct *mm)
 {
 	DECLARE_COMPLETION(startup_done);
-
-	mm->core_waiters++; /* let other threads block */
-	mm->core_startup_done = &startup_done;
-
-	/* give other threads a chance to run: */
-	yield();
-
-	zap_threads(mm);
-	if (--mm->core_waiters) {
-		up_write(&mm->mmap_sem);
-		wait_for_completion(&startup_done);
-	} else
-		up_write(&mm->mmap_sem);
+	int core_waiters;
+
+	mm->core_startup_done = &startup_done;
+
+	zap_threads(mm);
+	core_waiters = mm->core_waiters;
+	up_write(&mm->mmap_sem);
+
+	if (core_waiters)
+		wait_for_completion(&startup_done);
 	BUG_ON(mm->core_waiters);
 }
