Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbVHWS3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVHWS3B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 14:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVHWS3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 14:29:01 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:9955
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932271AbVHWS3A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 14:29:00 -0400
Subject: Re: [PATCH] fix send_sigqueue() vs thread exit race
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <430B4C35.AE7CD179@tv-sign.ru>
References: <20050818060126.GA13152@elte.hu>
	 <1124495303.23647.579.camel@tglx.tec.linutronix.de>
	 <43076138.C37ED380@tv-sign.ru>
	 <1124617458.23647.643.camel@tglx.tec.linutronix.de>
	 <43085E97.4EC3908B@tv-sign.ru>
	 <1124659468.23647.695.camel@tglx.tec.linutronix.de>
	 <1124661032.23647.698.camel@tglx.tec.linutronix.de>
	 <4309731E.ED621149@tv-sign.ru>
	 <1124698127.23647.716.camel@tglx.tec.linutronix.de>
	 <43099235.65BC4757@tv-sign.ru>
	 <1124705208.23647.737.camel@tglx.tec.linutronix.de>
	 <430A012E.1CAF0A2F@tv-sign.ru>
	 <1124791998.23647.789.camel@tglx.tec.linutronix.de>
	 <430B4C35.AE7CD179@tv-sign.ru>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 23 Aug 2005 18:29:17 +0000
Message-Id: <1124821757.31503.34.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-23 at 20:17 +0400, Oleg Nesterov wrote:
> Thomas Gleixner wrote:
> > I still think the last patch I sent is still necessary.
> 
> Thomas, you know that I like this change in __exit_{signal,sighand},
> but i think this change is dangerous, should go in a separate patch,
> and needs a lot of testing. But the decision is up to Ingo and Roland.

Maybe it makes more sense in context of Pauls RCU stuff.

> What do you think about this:
> 
> int try_to_lock_this_beep_tasklist_lock(struct task_struct *group_leader)
> {
> 	while (unlikely(!read_trylock(&tasklist_lock))) {
> 		if (group_leader->flags & PF_EXITING) {
> 			smp_rmb();
> 			if (thread_group_empty(group_leader))
> 				return 0;
> 		}
> 		cpu_relax();
> 	}
> 
> 	return 1;
> }
> 
> No need to re-check after we got tasklist, the signal will be flushed.

Makes sense, though I'm not sure if its safe to call
thread_group_empty() without tasklist lock held. I might be in case of
PF_EXITING, but it needs a comment at least.

> I think it's better to move the locking into the posix_timer_event, btw.

Hmm, not sure. I've seen similar stuff in the AIO patches. I guess this
should be solved safe at one place rather than all around the kernel. 

tglx



