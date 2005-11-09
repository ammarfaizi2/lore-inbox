Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbVKISjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbVKISjF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 13:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbVKISiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 13:38:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:15261 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751493AbVKISh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 13:37:57 -0500
Date: Wed, 9 Nov 2005 10:37:05 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, oleg@tv-sign.ru,
       roland@redhat.com, mingo@elte.hu
Subject: [patch 08/11] - fix signal->live leak in copy_process()
Message-ID: <20051109183705.GI3670@kroah.com>
References: <20051109182205.294803000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-signal-live-leak-in-copy_process.patch"
In-Reply-To: <20051109183614.GA3670@kroah.com>
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
