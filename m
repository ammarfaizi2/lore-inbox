Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWFWGAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWFWGAO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 02:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWFWGAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 02:00:14 -0400
Received: from www.osadl.org ([213.239.205.134]:4590 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932333AbWFWGAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 02:00:12 -0400
Subject: Re: [patch 1/3] Drop tasklist lock in do_sched_setscheduler
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <20060622184850.29e26ce6.akpm@osdl.org>
References: <20060622082758.669511000@cruncher.tec.linutronix.de>
	 <20060622082812.492564000@cruncher.tec.linutronix.de>
	 <20060622184850.29e26ce6.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 08:01:39 +0200
Message-Id: <1151042499.25491.211.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 18:48 -0700, Andrew Morton wrote:
> On Thu, 22 Jun 2006 09:08:38 -0000
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > 
> > There is no need to hold tasklist_lock across the setscheduler call, when we
> > pin the task structure with get_task_struct(). Interrupts are disabled in 
> > setscheduler anyway and the permission checks do not need interrupts disabled.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > 
> >  kernel/sched.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > Index: linux-2.6.17-mm/kernel/sched.c
> > ===================================================================
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
> >  
> 
> Is this optimisation actually related to the rt-mutex patches, or to the
> other two patches?

Yes. We neither want interrupt disabled nor holding tasklist lock when
it comes to the lock chain walk. So its a preperatory patch and a
general optimization.

	tglx


