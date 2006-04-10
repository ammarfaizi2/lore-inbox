Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWDJRnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWDJRnS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 13:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWDJRnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 13:43:17 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:61842 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751161AbWDJRnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 13:43:15 -0400
Date: Tue, 11 Apr 2006 01:40:18 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Michael Kerrisk <mtk-lkml@gmx.net>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix de_thread() vs do_coredump() deadlock
Message-ID: <20060410214018.GA635@oleg>
References: <434E906E.85BD86BF@tv-sign.ru> <20060410013651.4D1791809D1@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410013651.4D1791809D1@magilla.sf.frob.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09, Roland McGrath wrote:
>
>                                                                  Now, the
> coredump case matches the non-coredump fatal signal: the signal is dropped
> on the floor.

A fatal signal is placed to ->shared_pending in any (non tkill) case, so I
think it is not lost (but may be unnoticed for a while).

sig_kernel_coredump() is different. It could be stealed by one of sub-threads
while another one does de_thread(), that is why it could be lost.

What do you think about something like this untested patch instead?
I am far from sure it is correct, I need a sleep ...

Oleg.

--- fs/exec.c~	2006-04-10 22:15:06.000000000 +0400
+++ fs/exec.c	2006-04-11 00:56:52.000000000 +0400
@@ -657,6 +657,7 @@ static int de_thread(struct task_struct 
 	}
 	sig->group_exit_task = NULL;
 	sig->notify_count = 0;
+	recalc_sigpending();
 	spin_unlock_irq(lock);
 
 	/*
@@ -1478,9 +1479,15 @@ int do_coredump(long signr, int exit_cod
 	}
 	mm->dumpable = 0;
 
-	retval = -EAGAIN;
 	spin_lock_irq(&current->sighand->siglock);
-	if (!(current->signal->flags & SIGNAL_GROUP_EXIT)) {
+	if (current->signal->flags & SIGNAL_GROUP_EXIT) {
+		// Re-add the signal. This does not matter
+		// if we are doing do_group_exit().
+		// If it was de_thread(), this signal will be
+		// received again after sys_exec() succeeds.
+		sigaddset(&current->signal->shared_pending.signal, signr);
+		retval = -EAGAIN;
+	} else {
 		current->signal->flags = SIGNAL_GROUP_EXIT;
 		current->signal->group_exit_code = exit_code;
 		current->signal->group_stop_count = 0;

