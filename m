Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbVHVW2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbVHVW2t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbVHVW2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:28:16 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:17289 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751430AbVHVWZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:25:28 -0400
Message-ID: <43099235.65BC4757@tv-sign.ru>
Date: Mon, 22 Aug 2005 12:52:05 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix send_sigqueue() vs thread exit race
References: <20050818060126.GA13152@elte.hu>
		 <1124495303.23647.579.camel@tglx.tec.linutronix.de>
		 <43076138.C37ED380@tv-sign.ru>
		 <1124617458.23647.643.camel@tglx.tec.linutronix.de>
		 <43085E97.4EC3908B@tv-sign.ru>
		 <1124659468.23647.695.camel@tglx.tec.linutronix.de>
		 <1124661032.23647.698.camel@tglx.tec.linutronix.de>
		 <4309731E.ED621149@tv-sign.ru> <1124698127.23647.716.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> 
> But we can not check for p->sighand == NULL, as sighand is released
> after exit_itimers() so we are still deadlock prone. So I think
> __exit_sighand() should be called before exit_itimers(). Then we can do
> 
> retry:
>         if (unlikely(!p->sighand))
>                 return -1;
> 
> instead of checking for PF_EXITING.

I think yes, and this is closely related to your and Paul
"Use RCU to protect tasklist for unicast signals" patches.

We don't need RCU here, but we do need this hypothetical
lock_task_sighand() (and __exit_sighand from __exit_signal
change).

We still need tasklist_lock in send_group_queue for
__group_complete_signal though. I hope Paul will solve
this, it is needed for group_send_info() anyway.

But for the near future I don't see simple and non-intrusive
fix for this deadlock. I am waiting for George to confirm
that the bug exists and we are not crazy :)

Oleg.
