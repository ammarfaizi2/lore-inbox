Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVHTN7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVHTN7t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 09:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbVHTN7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 09:59:49 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:65215 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750741AbVHTN7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 09:59:48 -0400
Message-ID: <430739D4.681DB651@tv-sign.ru>
Date: Sat, 20 Aug 2005 18:10:28 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [PATCH 2.6.13-rc6-rt9]  PI aware dynamic priority adjustment
References: <20050818060126.GA13152@elte.hu> <1124495303.23647.579.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
>
> send_sigqueue is called from posix_timer_fn() and acquires
> tasklist_lock, which makes no sense to me.
>
> send_sigqueue()s (l)onl(e)y user is the posix_timer function
> (posix_timer_fn(), calling posix_timer_event()).
>
> Each posix timer blocks the task from vanishing away by
> get_task_struct(), which is protected by the held tasklist_lock.
>
> The task can neither go away nor the signal handler can change until
> put_task_struct() is called inside release_posix_timer(), which removes
> any chance to do an invalid access to either task or sighand because the
> relevant timer is deleted before the call to put_task_struct(). Also
> this call is protected by tasklist_lock().

Yes, the task_struct can't go away, but if process exited this
task_struct is just chunk of garbage. I think the intent was to
protect against this case.

However, I agree with you, locking the tasklist_lock can't help,
and the code is wrong.

posix_timer_event() first checks that the thread (SIGEV_THREAD_ID
case) does not have PF_EXITING flag, then it calls send_sigqueue()
which locks task list. But if the thread exits in between the kernel
will oops.

posix_timer_event() runs under k_itimer.it_lock, but this does not
help if that thread was not the only one in thread group, in this
case we don't call exit_itimers().

The comment is wrong too. ->sighand can't change, we are clearing
posix timer on exec, and tasklist can't prevent ->sighand from
going away..

Ingo, Roland, George, am I wrong?

Oleg.
