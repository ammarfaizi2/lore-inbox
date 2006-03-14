Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752344AbWCNSIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbWCNSIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 13:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752343AbWCNSIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 13:08:52 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38088 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751912AbWCNSIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 13:08:52 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       William Irwin <wli@holomorphy.com>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] task: Make task list manipulations RCU safe.
References: <m1bqwgx4za.fsf@ebiederm.dsl.xmission.com>
	<4416FF1F.5DA06CFB@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 14 Mar 2006 11:06:52 -0700
In-Reply-To: <4416FF1F.5DA06CFB@tv-sign.ru> (Oleg Nesterov's message of
 "Tue, 14 Mar 2006 20:36:31 +0300")
Message-ID: <m18xrcnbnn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> Some questions.
>
> first_tgid:
> 	...
> 	for (; pos && pid_alive(pos); pos = next_task(pos))
>
> I think this patch makes this 'pid_alive(pos)' unneeded?

Close.  The problem is that we could have slept with the
count elevated on start before we do rcu_read_lock().

> next_tgid:
> 	rcu_read_lock();
> 	pos = start;
> 	if (pid_alive(start))
> 		pos = next_task(start);
> 	if (pid_alive(pos) && (pos != &init_task)) {
> 		get_task_struct(pos);
> 		goto done;
> 	}
>
> The first 'pid_alive()' check is quite understandable.
> What about the second one? I beleive, now it is unneeded
> as well. The same for first_tid/next_tid.

Agreed.  Since we are guaranteed that ->next will still
be valid we should be able to get this down to a single
pid_alive check.  Although I'm not certain I would want
to return a task that had just died from either of these functions.
But I guess the race is there regardless.

> Also, first_tid() does 'task_lock(leader)' while reading
> ->signal->count. Why? ->signal is protected by ->siglock,
> but we don't need any locks because ->signal is rcu safe.
> Same for proc_task_getattr(), s/task_lock/rcu_read_lock/.

Probably my general paranoia.  I know I didn't quite grok
rcu at the time I wrote that code, and I could have easily
gotten confused about what task_lock protects.  Looks like
I need to generate a patch to cleanup that one.

Eric

