Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbVHVWi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbVHVWi5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbVHVWi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:38:56 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:32651 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751450AbVHVWiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:38:54 -0400
Message-ID: <4309731E.ED621149@tv-sign.ru>
Date: Mon, 22 Aug 2005 10:39:26 +0400
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
		 <1124659468.23647.695.camel@tglx.tec.linutronix.de> <1124661032.23647.698.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> 
> @@ -1427,7 +1434,18 @@ send_group_sigqueue(int sig, struct sigq
>         int ret = 0;
> 
>         BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
> -       read_lock(&tasklist_lock);
> +retry:
> +       if (unlikely(p->flags & PF_EXITING))
> +               return -1;
> +

I don't think this is correct. p == ->group_leader, it may
have been exited and in EXIT_ZOMBIE state. But the thread
group (process) is live, we should not stop posix timers.

Oleg.
