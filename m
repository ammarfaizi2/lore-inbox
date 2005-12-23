Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161091AbVLWW3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161091AbVLWW3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbVLWW2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:28:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:41928 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161084AbVLWW2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:28:42 -0500
Date: Fri, 23 Dec 2005 14:27:50 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, oleg@tv-sign.ru,
       roland@redhat.com, mingo@elte.hu
Subject: [patch 08/11] - fix signal->live leak in copy_process()
Message-ID: <20051223222750.GI18252@kroah.com>
References: <20051109182205.294803000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-signal-live-leak-in-copy_process.patch"
In-Reply-To: <20051223222652.GA18252@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleg Nesterov <oleg@tv-sign.ru>

exit_signal() (called from copy_process's error path) should decrement
->signal->live, otherwise forking process will miss 'group_dead' in
do_exit().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 kernel/signal.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.14.1.orig/kernel/signal.c
+++ linux-2.6.14.1/kernel/signal.c
@@ -406,6 +406,8 @@ void __exit_signal(struct task_struct *t
 
 void exit_signal(struct task_struct *tsk)
 {
+	atomic_dec(&tsk->signal->live);
+
 	write_lock_irq(&tasklist_lock);
 	__exit_signal(tsk);
 	write_unlock_irq(&tasklist_lock);

--
