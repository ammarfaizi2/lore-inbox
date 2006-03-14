Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751545AbWCNRj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWCNRj4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 12:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbWCNRjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 12:39:55 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:29105 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751545AbWCNRjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 12:39:55 -0500
Message-ID: <4416FF1F.5DA06CFB@tv-sign.ru>
Date: Tue, 14 Mar 2006 20:36:31 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       William Irwin <wli@holomorphy.com>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] task: Make task list manipulations RCU safe.
References: <m1bqwgx4za.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some questions.

first_tgid:
	...
	for (; pos && pid_alive(pos); pos = next_task(pos))

I think this patch makes this 'pid_alive(pos)' unneeded?

next_tgid:
	rcu_read_lock();
	pos = start;
	if (pid_alive(start))
		pos = next_task(start);
	if (pid_alive(pos) && (pos != &init_task)) {
		get_task_struct(pos);
		goto done;
	}

The first 'pid_alive()' check is quite understandable.
What about the second one? I beleive, now it is unneeded
as well. The same for first_tid/next_tid.

Also, first_tid() does 'task_lock(leader)' while reading
->signal->count. Why? ->signal is protected by ->siglock,
but we don't need any locks because ->signal is rcu safe.
Same for proc_task_getattr(), s/task_lock/rcu_read_lock/.

Oleg.
