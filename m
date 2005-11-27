Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVK0Qyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVK0Qyd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 11:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVK0Qyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 11:54:33 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:20401 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751102AbVK0Qyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 11:54:32 -0500
Message-ID: <4389F643.A1842927@tv-sign.ru>
Date: Sun, 27 Nov 2005 21:09:07 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] remove unneeded sig->curr_target recalculation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unneeded sig->curr_target recalculation under
'if (atomic_dec_and_test(&sig->count))' in __exit_signal().

When sig->count == 0 the signal can't be sent to this task and
next_thread(tsk) == tsk anyway.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15-rc2/kernel/signal.c~	2005-11-23 19:17:35.000000000 +0300
+++ 2.6.15-rc2/kernel/signal.c	2005-11-27 22:50:46.000000000 +0300
@@ -355,8 +355,6 @@ void __exit_signal(struct task_struct *t
 	posix_cpu_timers_exit(tsk);
 	if (atomic_dec_and_test(&sig->count)) {
 		posix_cpu_timers_exit_group(tsk);
-		if (tsk == sig->curr_target)
-			sig->curr_target = next_thread(tsk);
 		tsk->signal = NULL;
 		spin_unlock(&sighand->siglock);
 		flush_sigqueue(&sig->shared_pending);
