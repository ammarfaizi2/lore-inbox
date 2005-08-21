Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbVHUKa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbVHUKa4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 06:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbVHUKa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 06:30:56 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:50922 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750945AbVHUKaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 06:30:55 -0400
Message-ID: <43085A6E.C7D249F0@tv-sign.ru>
Date: Sun, 21 Aug 2005 14:41:50 +0400
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
		 <43076138.C37ED380@tv-sign.ru> <1124617458.23647.643.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> 
> On Sat, 2005-08-20 at 20:58 +0400, Oleg Nesterov wrote:
> > [PATCH] fix send_sigqueue() vs thread exit race
> >
> > .....
> > -     read_lock(&tasklist_lock);
> > +     read_lock(&tasklist_lock);
> > +
> > +     if (unlikely(p->flags & PF_EXITING)) {
> > +             ret = -1;
> > +             goto out_err;
> > +     }
> > +
> 
> It's still racy. tasklist_lock does not protect anything here.

I hope no, but please clarify if I am wrong.

tasklist_lock protects against release_task()->__exit_sigxxx()
here.


>  arm timer
>  exit

If this is the last thread in thread group, exit_itimers()
will stop and clear ->posix_timers.

If not:

>  timer event
>         timr->it_process references a freed structure
> 

No, create_timer() does get_task_struct(timr->it_process), this
task may be EXIT_DEAD now, but the task_struct itself is valid,
and it's ->flags has PF_EXITING flag.

Oleg.
