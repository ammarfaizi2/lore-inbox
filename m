Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVDOVoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVDOVoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 17:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVDOVoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 17:44:23 -0400
Received: from mx02.cybersurf.com ([209.197.145.105]:9961 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S261921AbVDOVoN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 17:44:13 -0400
Subject: Re: ACPI/HT or Packet Scheduler BUG?
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Steven Rostedt <rostedt@goodmis.org>
Cc: netdev <netdev@oss.sgi.com>, Tarhon-Onu Victor <mituc@iasi.rdsnet.ro>,
       kuznet@ms2.inr.ac.ru, devik@cdi.cz, linux-kernel@vger.kernel.org
In-Reply-To: <1113601029.4294.80.camel@localhost.localdomain>
References: <Pine.LNX.4.61.0504081225510.27991@blackblue.iasi.rdsnet.ro>
	 <Pine.LNX.4.61.0504121526550.4822@blackblue.iasi.rdsnet.ro>
	 <Pine.LNX.4.61.0504141840420.13546@blackblue.iasi.rdsnet.ro>
	 <1113601029.4294.80.camel@localhost.localdomain>
Content-Type: text/plain
Organization: unknown
Date: Fri, 15 Apr 2005 17:44:06 -0400
Message-Id: <1113601446.17859.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Didnt see the beginings of this thread - please post on netdev instead
of lkml network related questions.

The real cause seems to be an ARP issue from what i saw in the oops
posted a while back:
--
[4294692.342000] Call Trace:
[4294692.342000]  [<c0104d76>] show_stack+0xa6/0xe0
[4294692.342000]  [<c0104f2b>] show_registers+0x15b/0x1f0
[4294692.342000]  [<c01051a1>] die+0x141/0x2d0
[4294692.342000]  [<c011e13e>] do_page_fault+0x22e/0x6a6
[4294692.342000]  [<c0104817>] error_code+0x4f/0x54
[4294692.342000]  [<c04236da>] qdisc_restart+0xba/0x730
[4294692.342000]  [<c04136fe>] dev_queue_xmit+0x13e/0x640
[4294692.342000]  [<c0454c4c>] arp_solicit+0xfc/0x210
[4294692.342000]  [<c041a6ee>] neigh_timer_handler+0x13e/0x320
[4294692.342000]  [<c0137450>] run_timer_softirq+0x130/0x490
[4294692.342000]  [<c0131ad2>] __do_softirq+0x42/0xa0
[4294692.342000]  [<c01066e1>] do_softirq+0x51/0x60
-----

Is this the same issue?
Can you describe how you create this issue; kernel version etc.

cheers,
jamal

On Fri, 2005-15-04 at 17:37 -0400, Steven Rostedt wrote:
> On Thu, 2005-04-14 at 18:46 +0300, Tarhon-Onu Victor wrote:
> > On Tue, 12 Apr 2005, Tarhon-Onu Victor wrote:
> > 
> > > 	So the problem should be looked in that changes to the pkt sched API, 
> > > the patch containing only those changes is at
> > 
> >  	The bug is in this portion of code from net/sched/sch_generic.c, 
> > in the qdisc_destroy() function:
> > 
> > ==
> >       list_for_each_entry(cq, &cql, list)
> >            list_for_each_entry_safe(q, n, &qdisc->dev->qdisc_list, list)
> >                 if (TC_H_MAJ(q->parent) == TC_H_MAJ(cq->handle)) {
> >                      if (q->ops->cl_ops == NULL)
> >                           list_del_init(&q->list);
> >                      else
> >                           list_move_tail(&q->list, &cql);
> >                 }
> >       list_for_each_entry_safe(cq, n, &cql, list)
> >            list_del_init(&cq->list);
> > ==
> > 
> >  	...and it happens when q->ops->cl_ops is NULL and 
> > list_del_init(&q->list) is executed.
> > 
> >  	The stuff from include/linux/list.h looks ok, it seems like one 
> > of those two iterations (list_for_each_entry() and 
> > list_for_each_entry_safe()) enters an endless loop when an element is 
> > removed from the list under some circumstances.
> 
> There's a comment above qdisc_destroy that says:
> 
> /* Under dev->queue_lock and BH! */
> 
> I'm not so sure this is the case.  I've included the emails of those
> listed as Authors of sch_generic.c and sch_htb.c, hopefully they are the
> ones who can help (if not, sorry to bother you).  
> 
> The list.h is fine, but if another task goes down this list when it
> list_del_init is done, there's a chance that the reading task can get to
> the deleted item just as it is being deleted, and has pointed itself to
> itself. p->next == p.  This would go into an infinite loop.  
> 
> The reason sysrq works is because this doesn't stop interrupts. But put
> a local_irq_save around that list and run your test, I bet you won't be
> able to do anything, but power off with the big button.
> 
> Hope someone can help. I don't know the queue disciplines well enough to
> make a proper fix.
> 
> -- Steve
> 
> 
> 

