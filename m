Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161100AbWBYUJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbWBYUJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 15:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWBYUJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 15:09:57 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:18360 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1161100AbWBYUJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 15:09:56 -0500
Message-ID: <4400B8D7.BE68EEDF@tv-sign.ru>
Date: Sat, 25 Feb 2006 23:06:47 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/6] relax sig_needs_tasklist()
References: <43FCEE08.7923E800@tv-sign.ru> <m1r75r1kh9.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@tv-sign.ru> writes:
>
> > handle_stop_signal() does not need tasklist_lock for
> > SIG_KERNEL_STOP_MASK signals anymore.
>
> Small question.
>
> If I read the code correctly the only thing handle_stop_signal needs
> the tasklist_lock for is to protect task->parent, for the
> do_notify_parent_cldstop(...) case.

Yes, exactly.

> If this is correct.  I think I see a path to kill read_lock(&tasklist_lock)
> completely.
>
> - Protect task->parent with the rcu_read_lock && task_lock().
> - Use the rcu forms of list_add/list_del on the tasklist.
> - replace read_lock(&tasklist_lock) with rcu_read_lock().
> - Make tasklist_lock a simple spin lock.
>
> Comments?

I must admit, I am not brave enough to even think about this
now :)

I already thought about protecting ->parent with task_lock(),
but I can't find a reasonable solution.

As for handle_stop_signal(), there is another problem.
do_notify_parent_cldstop takes ->parent's sighand->siglock, so
the caller drops child's. And this is possible only because we
are holding tasklist_lock.

Somehow we need to lock both the parent and the child, and what
if child does ptrace on it's ->real_parent?

Oleg.
