Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVKEPTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVKEPTE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 10:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVKEPTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 10:19:04 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:51173 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932074AbVKEPTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 10:19:02 -0500
Message-ID: <436CDEAC.A7D56A94@tv-sign.ru>
Date: Sat, 05 Nov 2005 19:32:44 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com, suzannew@cs.pdx.edu
Subject: Re: [PATCH] Fixes for RCU handling of task_struct
References: <20051031020535.GA46@us.ibm.com> <20051031140459.GA5664@elte.hu> <20051031205119.5bd897f3.akpm@osdl.org> <20051103190916.GA13417@us.ibm.com> <436B9D5D.3EB28CD5@tv-sign.ru> <20051104200801.GA16092@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" wrote:
>
> > > -       spin_lock_irqsave(&p->sighand->siglock, flags);
> > > +       spin_lock_irqsave(&sh->siglock, flags);
> >
> > But 'sh' can be NULL, no? Yes, you already checked PF_EXITING, so this is
> > very unlikely, but I think it is still possible in theory. 'sh' was loaded
> > before reading p->flags, but rcu_read_lock() does not imply memory barrier.
>
> 'sh' cannot be NULL, because the caller holds ->it_lock and has checked
> for timer deletion under that lock, and because the exiting process
> quiesces and deletes timers before freeing sighand.
               ^^^^^^^^^^^^^^

Exiting process (thread group) - yes, but exiting thread - no. That is why
send_sigqueue() should check that the target thread is not exiting now. If
we do not take tasklist_lock we can't be sure that ->sighand != NULL. The
caller holds ->it_lock, yes, but this can't help.

Please don't be confused by the 'posix_cpu_timers_exit(tsk)' in __exit_signal()
which is called under sighand->siglock before clearing ->signal/->sighand. This
is completely different, it detaches (but not destroys) cpu-timers, these timers
can have another thread/process as a target for signal sending.

Oleg.
