Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316933AbSHSByz>; Sun, 18 Aug 2002 21:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317054AbSHSByz>; Sun, 18 Aug 2002 21:54:55 -0400
Received: from dp.samba.org ([66.70.73.150]:48280 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S316933AbSHSByy>;
	Sun, 18 Aug 2002 21:54:54 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15712.20532.996267.734044@argo.ozlabs.ibm.com>
Date: Mon, 19 Aug 2002 11:56:04 +1000 (EST)
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [PATCH] fix bug in yield()
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes yield() actually call schedule.

Without this patch, 2.4.20-pre3 will hang on boot for me, looping in
spawn_ksoftirqd waiting for ksoftirqd to start and calling yield().
ksoftirqd never gets to run, however, because yield never actually
calls schedule.  (Note that sys_sched_yield as a syscall is OK because
the syscall exit path will check current->need_resched and call
schedule).

Paul.

diff -urN linux-2.4/kernel/sched.c pmac/kernel/sched.c
--- linux-2.4/kernel/sched.c	Wed Aug  7 18:10:01 2002
+++ pmac/kernel/sched.c	Mon Aug 19 10:39:39 2002
@@ -1081,6 +1081,7 @@
 {
 	set_current_state(TASK_RUNNING);
 	sys_sched_yield();
+	schedule();
 }
 
 void __cond_resched(void)

