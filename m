Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWDJJi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWDJJi4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 05:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWDJJi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 05:38:56 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:42917 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751037AbWDJJiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 05:38:55 -0400
Date: Mon, 10 Apr 2006 17:35:52 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] coredump: kill ptrace related stuff
Message-ID: <20060410133511.GA85@oleg>
References: <20060406220631.GA240@oleg> <20060410045451.434ED1809D1@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410045451.434ED1809D1@magilla.sf.frob.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09, Roland McGrath wrote:
>
> > With this patch zap_process() sets SIGNAL_GROUP_EXIT while sending
> > SIGKILL to the thread group.
>
> do_coredump has already done this.  So you are addressing the case of other
> thread groups sharing the mm, right?

Yes,

> > This means that a TASK_TRACED task
> >
> > 	1. Will be awakened by signal_wake_up(1)
>
> That should always happen regardless of signal->flags, so yes.
>
> > 	2. Can't sleep again via ptrace_notify()
>
> What makes this be so?  What if it's entering a notification event now?
> What about exit tracing?

It turns out I misread SIGNAL_GROUP_EXIT check in ptrace_stop(),
didn't notice '(->parent->signal != current->signal) ||' before
it.

You are right, this is a problem, I need to think about it.

Do you see any solution which doesn't need tasklist_lock to be
held while traversing global process list?

> > 	3. Can't go to do_signal_stop() after return
> > 	   from ptrace_stop() in get_signal_to_deliver()
>
> This is only true because of the check in get_signal_to_deliver,
> which I've said I think should be taken out for other reasons.

Yes, changelog refers to SIGNAL_GROUP_EXIT check in get_signal_to_deliver.
However, do_signal_stop() returns 0 when it doesn't see SIGNAL_STOP_DEQUEUED,
(which was cleared by SIGNAL_GROUP_EXIT), so I think we don't depend on
SIGNAL_GROUP_EXIT check in get_signal_to_deliver. No?

Btw, I don't understand Andrea's patch (and changelog) too.

Oleg.

