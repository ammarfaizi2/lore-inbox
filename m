Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWFYPd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWFYPd5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 11:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWFYPd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 11:33:56 -0400
Received: from www.osadl.org ([213.239.205.134]:55206 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751096AbWFYPd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 11:33:56 -0400
Subject: Re: [patch 1/3] Drop tasklist lock in do_sched_setscheduler
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060625005045.GA155@oleg>
References: <20060625005045.GA155@oleg>
Content-Type: text/plain
Date: Sun, 25 Jun 2006 17:35:46 +0200
Message-Id: <1151249747.25491.378.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-25 at 04:50 +0400, Oleg Nesterov wrote:
> Thomas Gleixner wrote:
> >
> > There is no need to hold tasklist_lock across the setscheduler call, when we
> > pin the task structure with get_task_struct(). Interrupts are disabled in 
> > setscheduler anyway and the permission checks do not need interrupts disabled.
> >
> > --- linux-2.6.17-mm.orig/kernel/sched.c	2006-06-22 10:26:11.000000000 +0200
> > +++ linux-2.6.17-mm/kernel/sched.c	2006-06-22 10:26:11.000000000 +0200
> > @@ -4140,8 +4140,10 @@
> >  		read_unlock_irq(&tasklist_lock);
> >  		return -ESRCH;
> >  	}
> > -	retval = sched_setscheduler(p, policy, &lparam);
> > +	get_task_struct(p);
> >  	read_unlock_irq(&tasklist_lock);
> > +	retval = sched_setscheduler(p, policy, &lparam);
> > +	put_task_struct(p);
> >  	return retval;
> >  }
> 
> But we don't need read_lock(tasklist) and get_task_struct(p) at all?
> 
> rcu_read_lock/rcu_read_unlock is enough, no?

Probably yes, did not think about that

	tglx


