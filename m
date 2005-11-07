Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbVKGMEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbVKGMEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 07:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbVKGMEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 07:04:13 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:43454 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751353AbVKGMEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 07:04:12 -0500
Message-ID: <436F5402.137182CF@tv-sign.ru>
Date: Mon, 07 Nov 2005 16:17:54 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com, suzannew@cs.pdx.edu
Subject: Re: [PATCH] Fixes for RCU handling of task_struct
References: <20051031020535.GA46@us.ibm.com> <20051031140459.GA5664@elte.hu> <20051031205119.5bd897f3.akpm@osdl.org> <20051103190916.GA13417@us.ibm.com> <436B9D5D.3EB28CD5@tv-sign.ru> <20051104200801.GA16092@us.ibm.com> <436CDEAC.A7D56A94@tv-sign.ru> <20051105232027.GA20178@us.ibm.com> <436DF0A6.342717A6@tv-sign.ru> <20051106225926.GC22876@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" wrote:
> 
> > > +       while (p->group_leader != p)
> > > +               p = p->group_leader;
> >
> > No, this is definitely not right. de_thread() does not change leader->group_leader
> > when non-leader execs, so p->group_leader == p always.
> 
> This was intended for the case where the group leader does pthread_exit,
> which would cause some other thread to assume group leadership.  Or am
> I missing something from that code path?  (Quite likely that I am...)

When group leader exits it goes into TASK_ZOMBIE state (if it is not the
only one thread in the same group). It is still the ->group_leader for all
threads including itself. Only when release_task(last_thread_in_thread_group)
happens, it will notice not yet released group_leader, and release it, see
'repeat:' patch in release_task().

The ->group_leader is changed only when non-leader thread does exec, it kills
other threads and becomes ->group_leader for itself.

So, I think send_group_sigqueue() should do:

	read_lock(tasklist_lock);

	if (!tsk->signal) {
		// Can happen only if de_thread did release_task(tsk)
		// while switching to new leader.
		// We can't figure out the new leader, but it does not
		// matter - we should drop the signal anyway.
		unlock(tasklist);
		return;
	}

Oleg.
