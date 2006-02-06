Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWBFPxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWBFPxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 10:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWBFPxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 10:53:22 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:37249 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932113AbWBFPxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 10:53:21 -0500
Message-ID: <43E7830E.974EF20C@tv-sign.ru>
Date: Mon, 06 Feb 2006 20:10:38 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix kill_proc_info() vs copy_process() race
References: <43E77D3C.C967A275@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> 
> This means that we can find a task in kill_proc_info()->find_task_by_pid()
> which is not registered as part of thread group yet. Various bad things can
> happen, note that handle_stop_signal(SIGCONT) and __group_complete_signal()
> iterate over threads list. But p->pids[PIDTYPE_TGID] is a copy of current's
> 'struct pid' from dup_task_struct(), and if we don't have CLONE_THREAD here
> we will use completely unreleated (parent's) thread list.
> 
> I think we can solve these problems by enlarging a ->siglock's scope in
> copy_process(), but I don't know how to test this patch.
> 
> NOTE: release_task()->__unhash_process() path is safe, we already have
> ->sighand == NULL while detaching PIDTYPE_PID/PIDTYPE_TGID nonatomically.

Sorry, I was wrong. Without CLONE_THREAD current->sighand.siglock can't help,
we need p->sighand.siglock, I beleive.

Am I correct that the bug exists at least?

Oleg.
