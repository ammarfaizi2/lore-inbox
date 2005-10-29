Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVJ2PYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVJ2PYM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 11:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVJ2PYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 11:24:12 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:7333 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751195AbVJ2PYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 11:24:12 -0400
Message-ID: <43639744.94BA6AA4@tv-sign.ru>
Date: Sat, 29 Oct 2005 19:37:40 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix signal->live leak in copy_process()
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] fix ->signal->live leak in copy_process()

exit_signal() (called from copy_process's error path) should decrement
->signal->live, otherwise forking process will miss 'group_dead' in
do_exit().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.14/kernel/signal.c~	2005-10-29 01:14:57.000000000 +0400
+++ 2.6.14/kernel/signal.c	2005-10-29 22:40:37.000000000 +0400
@@ -406,6 +406,8 @@ void __exit_signal(struct task_struct *t
 
 void exit_signal(struct task_struct *tsk)
 {
+	atomic_dec(&tsk->signal->live);
+
 	write_lock_irq(&tasklist_lock);
 	__exit_signal(tsk);
 	write_unlock_irq(&tasklist_lock);
