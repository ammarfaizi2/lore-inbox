Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbWBYQSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWBYQSu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 11:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964771AbWBYQSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 11:18:50 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62131 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964773AbWBYQSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 11:18:49 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/6] relax sig_needs_tasklist()
References: <43FCEE08.7923E800@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 25 Feb 2006 09:17:22 -0700
In-Reply-To: <43FCEE08.7923E800@tv-sign.ru> (Oleg Nesterov's message of
 "Thu, 23 Feb 2006 02:04:40 +0300")
Message-ID: <m1r75r1kh9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> handle_stop_signal() does not need tasklist_lock for
> SIG_KERNEL_STOP_MASK signals anymore.

Small question.

If I read the code correctly the only thing handle_stop_signal needs
the tasklist_lock for is to protect task->parent, for the
do_notify_parent_cldstop(...) case.

If this is correct.  I think I see a path to kill read_lock(&tasklist_lock)
completely. 

- Protect task->parent with the rcu_read_lock && task_lock().
- Use the rcu forms of list_add/list_del on the tasklist.
- replace read_lock(&tasklist_lock) with rcu_read_lock().
- Make tasklist_lock a simple spin lock.

Comments?

Eric
