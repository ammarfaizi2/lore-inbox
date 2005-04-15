Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVDOWzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVDOWzm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 18:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVDOWzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 18:55:41 -0400
Received: from postel.suug.ch ([195.134.158.23]:32998 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S262100AbVDOWyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 18:54:01 -0400
Date: Sat, 16 Apr 2005 00:54:22 +0200
From: Thomas Graf <tgraf@suug.ch>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: hadi@cyberus.ca, netdev <netdev@oss.sgi.com>,
       Tarhon-Onu Victor <mituc@iasi.rdsnet.ro>, kuznet@ms2.inr.ac.ru,
       devik@cdi.cz, linux-kernel@vger.kernel.org,
       Patrick McHardy <kaber@trash.net>
Subject: Re: ACPI/HT or Packet Scheduler BUG?
Message-ID: <20050415225422.GF4114@postel.suug.ch>
References: <Pine.LNX.4.61.0504081225510.27991@blackblue.iasi.rdsnet.ro> <Pine.LNX.4.61.0504121526550.4822@blackblue.iasi.rdsnet.ro> <Pine.LNX.4.61.0504141840420.13546@blackblue.iasi.rdsnet.ro> <1113601029.4294.80.camel@localhost.localdomain> <1113601446.17859.36.camel@localhost.localdomain> <1113602052.4294.89.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113602052.4294.89.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Rostedt <1113602052.4294.89.camel@localhost.localdomain> 2005-04-15 17:54
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
> I'm not so sure this is the case.

It's not, we should change the comment. qdisc_destroy calls for inner
leaf qdiscs comming from rcu scheduled __qdisc_destroy -> qdisc::destroy()
-> qdisc_destroy() will not have a lock on queue_lock but it shouldn't be
a problem since the qdiscs cannot be found anymore.

Another case were it's not locked is upon a deletion of a class where
the class deletes its inner qdisc, although there is only one case
how this can happen and that's under rtnl semaphore so there is no
way we can have a dumper at the same time.

A wild guess would be that one of the many wrong locking places where
dev->queue_lock is acquired but qdisc_tree_lock is not is the problem.
tc_dump_qdisc assumed that locking on qdisc_tree_lock is enough which
is absolutely right, still most callers to qdisc_destroy only lock
on dev->queue_lock for the modification of the tree, which _was_ fine
before we used list.h since the unlinking was atomic. This is no news
and Patrick's patch in 2.6.10 ought to have fixed this by unlinking
inner leaf qdiscs from dev->qdisc_list and thus preventing them to
be found by anyone during unlocked calls to destroy_qdisc.

So... we might have a unlocked qdisc_destroy call for a qdisc not
properly unlinked from dev->qdisc_list.
