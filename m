Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbVHVW2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbVHVW2s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbVHVW2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:28:21 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:17289 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751424AbVHVWZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:25:27 -0400
Subject: Re: [PATCH] fix send_sigqueue() vs thread exit race
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <4309731E.ED621149@tv-sign.ru>
References: <20050818060126.GA13152@elte.hu>
	 <1124495303.23647.579.camel@tglx.tec.linutronix.de>
	 <43076138.C37ED380@tv-sign.ru>
	 <1124617458.23647.643.camel@tglx.tec.linutronix.de>
	 <43085E97.4EC3908B@tv-sign.ru>
	 <1124659468.23647.695.camel@tglx.tec.linutronix.de>
	 <1124661032.23647.698.camel@tglx.tec.linutronix.de>
	 <4309731E.ED621149@tv-sign.ru>
Content-Type: text/plain
Organization: linutronix
Date: Mon, 22 Aug 2005 10:08:47 +0200
Message-Id: <1124698127.23647.716.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-22 at 10:39 +0400, Oleg Nesterov wrote:
> Thomas Gleixner wrote:
> > 
> > @@ -1427,7 +1434,18 @@ send_group_sigqueue(int sig, struct sigq
> >         int ret = 0;
> > 
> >         BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
> > -       read_lock(&tasklist_lock);
> > +retry:
> > +       if (unlikely(p->flags & PF_EXITING))
> > +               return -1;
> > +
> 
> I don't think this is correct. p == ->group_leader, it may
> have been exited and in EXIT_ZOMBIE state. But the thread
> group (process) is live, we should not stop posix timers.

Hmm, true. release_task() is not called in this case, so p->sighand is
still there.

But we can not check for p->sighand == NULL, as sighand is released
after exit_itimers() so we are still deadlock prone. So I think
__exit_sighand() should be called before exit_itimers(). Then we can do 

retry:
	if (unlikely(!p->sighand))
		return -1;

instead of checking for PF_EXITING.

tglx









