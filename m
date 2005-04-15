Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVDOVhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVDOVhn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 17:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVDOVhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 17:37:43 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:44427 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261915AbVDOVhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 17:37:31 -0400
Subject: Re: ACPI/HT or Packet Scheduler BUG?
From: Steven Rostedt <rostedt@goodmis.org>
To: Tarhon-Onu Victor <mituc@iasi.rdsnet.ro>
Cc: hadi@cyberus.ca, kuznet@ms2.inr.ac.ru, devik@cdi.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0504141840420.13546@blackblue.iasi.rdsnet.ro>
References: <Pine.LNX.4.61.0504081225510.27991@blackblue.iasi.rdsnet.ro>
	 <Pine.LNX.4.61.0504121526550.4822@blackblue.iasi.rdsnet.ro>
	 <Pine.LNX.4.61.0504141840420.13546@blackblue.iasi.rdsnet.ro>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 15 Apr 2005 17:37:09 -0400
Message-Id: <1113601029.4294.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-14 at 18:46 +0300, Tarhon-Onu Victor wrote:
> On Tue, 12 Apr 2005, Tarhon-Onu Victor wrote:
> 
> > 	So the problem should be looked in that changes to the pkt sched API, 
> > the patch containing only those changes is at
> 
>  	The bug is in this portion of code from net/sched/sch_generic.c, 
> in the qdisc_destroy() function:
> 
> ==
>       list_for_each_entry(cq, &cql, list)
>            list_for_each_entry_safe(q, n, &qdisc->dev->qdisc_list, list)
>                 if (TC_H_MAJ(q->parent) == TC_H_MAJ(cq->handle)) {
>                      if (q->ops->cl_ops == NULL)
>                           list_del_init(&q->list);
>                      else
>                           list_move_tail(&q->list, &cql);
>                 }
>       list_for_each_entry_safe(cq, n, &cql, list)
>            list_del_init(&cq->list);
> ==
> 
>  	...and it happens when q->ops->cl_ops is NULL and 
> list_del_init(&q->list) is executed.
> 
>  	The stuff from include/linux/list.h looks ok, it seems like one 
> of those two iterations (list_for_each_entry() and 
> list_for_each_entry_safe()) enters an endless loop when an element is 
> removed from the list under some circumstances.

There's a comment above qdisc_destroy that says:

/* Under dev->queue_lock and BH! */

I'm not so sure this is the case.  I've included the emails of those
listed as Authors of sch_generic.c and sch_htb.c, hopefully they are the
ones who can help (if not, sorry to bother you).  

The list.h is fine, but if another task goes down this list when it
list_del_init is done, there's a chance that the reading task can get to
the deleted item just as it is being deleted, and has pointed itself to
itself. p->next == p.  This would go into an infinite loop.  

The reason sysrq works is because this doesn't stop interrupts. But put
a local_irq_save around that list and run your test, I bet you won't be
able to do anything, but power off with the big button.

Hope someone can help. I don't know the queue disciplines well enough to
make a proper fix.

-- Steve


