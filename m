Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWBRQy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWBRQy1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWBRQy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:54:26 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:946 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932073AbWBRQyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:54:25 -0500
Message-ID: <43F76374.EDA3ED9D@tv-sign.ru>
Date: Sat, 18 Feb 2006 21:12:04 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Paul E. McKenney" <paulmck@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] introduce sig_needs_tasklist() helper
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my opinion this patch cleanups the code. Please
say 'nack' if you think differently.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/kernel/signal.c~4_SNT	2006-02-18 23:26:51.000000000 +0300
+++ 2.6.16-rc3/kernel/signal.c	2006-02-18 23:43:23.000000000 +0300
@@ -147,6 +147,9 @@ static kmem_cache_t *sigqueue_cachep;
 #define sig_kernel_stop(sig) \
 		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_STOP_MASK))
 
+#define sig_needs_tasklist(sig) \
+		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_STOP_MASK | M(SIGCONT)))
+
 #define sig_user_defined(t, signr) \
 	(((t)->sighand->action[(signr)-1].sa.sa_handler != SIG_DFL) &&	\
 	 ((t)->sighand->action[(signr)-1].sa.sa_handler != SIG_IGN))
@@ -1202,7 +1205,7 @@ kill_proc_info(int sig, struct siginfo *
 	struct task_struct *p;
 
 	rcu_read_lock();
-	if (unlikely(sig_kernel_stop(sig) || sig == SIGCONT)) {
+	if (unlikely(sig_needs_tasklist(sig))) {
 		read_lock(&tasklist_lock);
 		acquired_tasklist_lock = 1;
 	}
