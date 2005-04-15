Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVDOVyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVDOVyv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 17:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVDOVyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 17:54:51 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:32431 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261943AbVDOVye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 17:54:34 -0400
Subject: Re: ACPI/HT or Packet Scheduler BUG?
From: Steven Rostedt <rostedt@goodmis.org>
To: hadi@cyberus.ca
Cc: netdev <netdev@oss.sgi.com>, Tarhon-Onu Victor <mituc@iasi.rdsnet.ro>,
       kuznet@ms2.inr.ac.ru, devik@cdi.cz, linux-kernel@vger.kernel.org
In-Reply-To: <1113601446.17859.36.camel@localhost.localdomain>
References: <Pine.LNX.4.61.0504081225510.27991@blackblue.iasi.rdsnet.ro>
	 <Pine.LNX.4.61.0504121526550.4822@blackblue.iasi.rdsnet.ro>
	 <Pine.LNX.4.61.0504141840420.13546@blackblue.iasi.rdsnet.ro>
	 <1113601029.4294.80.camel@localhost.localdomain>
	 <1113601446.17859.36.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 15 Apr 2005 17:54:12 -0400
Message-Id: <1113602052.4294.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't think the issue is the same. This problem is happening with
Tarhon-Onu Victor.  I'm including his previous two posts from LKML here.
So you can read the whole thing in one letter.  He states that the
problem started in 2.6.10-rc2 and looking at a diff, between rc1 and rc2
the list walk was added in qdisc_destroy.  Take a look at his scripts
and you may see that on a SMP machine, this my have a race condition.

-- Steve

>From April 8th:


        I am not subscribed to this list so please CC me if you post a 
reply, if you need additional info or if you suggest a patch (in which 
I would be very interested).

        Occurrence:
        - the kernels must be compiled with Hyper Threading support (and
the CPU/MB must support it);
        - a (tc) process is reading statistics from the htb tree and
another
tries to delete or deletes the tree.
        The bug will not occur if the system is booted with acpi=off or 
if it's not SMP (HT) capable. I reproduced the bug on
2.6.10-1.770_FCsmp 
(Fedora Core update package) and vanilla 2.6.11, 2.6.11.5, 2.6.11.6, 
2.6.12-rc1 and 2.6.12-rc2 compiled with SMP and ACPI support in order
to 
enable Hyper Threading (with and without preempt, with or without SMT 
support). The compiler I used is GCC version 3.4.2 (from Fedora Core 3).

        Result: almost all the time the system hangs but still can 
execute SysRq commands.

        How I tested
        ~~~~~~~~~~~~
        On a console I was running a script that initializes a htb tree 
on an interface (dummy0) in an endless loop:
        while /bin/true; do . htbdown.dummy0.sh; done
        ...and on another console I run tc -s also in an endless loop:
        while /bin/true; do tc -s class sh dev dummy0; done

        After a while (sometimes after 2 runs of the htbdown.dummy0.sh 
script, sometimes after 20) the system hangs. It still responds to
SysRq 
commands and I was able to see the two tc processes running. Sometimes
I 
still have ping replies from it and one time, just one time in 2 days I 
still was able to log in remotely.
        There are no printk messages, or no other warnings or errors 
printed in the system log or kernel log. It just hangs and it seems
like 
something is wasting all the CPU power: when I still was able to log in 
I noticed that one of the two virtual CPUs was 100% with system 
interrupts and the other was 100% system. I wasn't able to strace any
of 
the two running tc's.
        What I was able to paste with the mouse in my console, to catch 
in a typescript and also the script that initializes the htb tree on 
dummy0 can be found at ftp://blackblue.iasi.rdsnet.ro/pub/various/k/ .
        The test host is a 3.0GHz Intel Prescott and I first noticed
the 
bug on a system with a 2.8GHz Intel Northwood, both having motherboards 
with Intel chipset (865GBF). I am not able to test it in other SMP 
environments (Intel Xeon or Itanium, AMD Opteron, Dual P3, etc), so I'm 
not able to tell if it's an ACPI bug, a SMP bug or a Packet Scheduler 
bug.



>From April 12th:


On Fri, 8 Apr 2005, Tarhon-Onu Victor wrote:

>       I am not subscribed to this list so please CC me if you post a
reply, 
> if you need additional info or if you suggest a patch (in which I
would be 
> very interested).
>
[snip]
> (Intel Xeon or Itanium, AMD Opteron, Dual P3, etc), so I'm not able to
tell 
> if it's an ACPI bug, a SMP bug or a Packet Scheduler bug.

        It seems like this bug is a packed scheduler one and it was 
introduced in 2.6.10-rc2. In the summary of changes from 2.6.10-rc1 to 
2.6.10-rc2 there are a lot of changes announced for the packet 
scheduler.
        I removed all the changes of the packet scheduler files from
the 
incremental patch 2.6.10-rc1 to 2.6.10-rc2, I applied it to 2.6.10-rc1 
and the new 2.6.10-rc2-whithout-sched-changes does not hang.
        So the problem should be looked in that changes to the pkt
sched 
API, the patch containing only those changes is at 
ftp://blackblue.iasi.rdsnet.ro/pub/various/k/patch-2.6.10-sched_changes-from_rc1-to-rc2.gz



On Fri, 2005-04-15 at 17:44 -0400, jamal wrote:
> Didnt see the beginings of this thread - please post on netdev instead
> of lkml network related questions.
> 
> The real cause seems to be an ARP issue from what i saw in the oops
> posted a while back:
> --
> [4294692.342000] Call Trace:
> [4294692.342000]  [<c0104d76>] show_stack+0xa6/0xe0
> [4294692.342000]  [<c0104f2b>] show_registers+0x15b/0x1f0
> [4294692.342000]  [<c01051a1>] die+0x141/0x2d0
> [4294692.342000]  [<c011e13e>] do_page_fault+0x22e/0x6a6
> [4294692.342000]  [<c0104817>] error_code+0x4f/0x54
> [4294692.342000]  [<c04236da>] qdisc_restart+0xba/0x730
> [4294692.342000]  [<c04136fe>] dev_queue_xmit+0x13e/0x640
> [4294692.342000]  [<c0454c4c>] arp_solicit+0xfc/0x210
> [4294692.342000]  [<c041a6ee>] neigh_timer_handler+0x13e/0x320
> [4294692.342000]  [<c0137450>] run_timer_softirq+0x130/0x490
> [4294692.342000]  [<c0131ad2>] __do_softirq+0x42/0xa0
> [4294692.342000]  [<c01066e1>] do_softirq+0x51/0x60
> -----
> 
> Is this the same issue?
> Can you describe how you create this issue; kernel version etc.
> 
> cheers,
> jamal
> 
> On Fri, 2005-15-04 at 17:37 -0400, Steven Rostedt wrote:
> > On Thu, 2005-04-14 at 18:46 +0300, Tarhon-Onu Victor wrote:
> > > On Tue, 12 Apr 2005, Tarhon-Onu Victor wrote:
> > > 
> > > > 	So the problem should be looked in that changes to the pkt sched API, 
> > > > the patch containing only those changes is at
> > > 
> > >  	The bug is in this portion of code from net/sched/sch_generic.c, 
> > > in the qdisc_destroy() function:
> > > 
> > > ==
> > >       list_for_each_entry(cq, &cql, list)
> > >            list_for_each_entry_safe(q, n, &qdisc->dev->qdisc_list, list)
> > >                 if (TC_H_MAJ(q->parent) == TC_H_MAJ(cq->handle)) {
> > >                      if (q->ops->cl_ops == NULL)
> > >                           list_del_init(&q->list);
> > >                      else
> > >                           list_move_tail(&q->list, &cql);
> > >                 }
> > >       list_for_each_entry_safe(cq, n, &cql, list)
> > >            list_del_init(&cq->list);
> > > ==
> > > 
> > >  	...and it happens when q->ops->cl_ops is NULL and 
> > > list_del_init(&q->list) is executed.
> > > 
> > >  	The stuff from include/linux/list.h looks ok, it seems like one 
> > > of those two iterations (list_for_each_entry() and 
> > > list_for_each_entry_safe()) enters an endless loop when an element is 
> > > removed from the list under some circumstances.
> > 
> > There's a comment above qdisc_destroy that says:
> > 
> > /* Under dev->queue_lock and BH! */
> > 
> > I'm not so sure this is the case.  I've included the emails of those
> > listed as Authors of sch_generic.c and sch_htb.c, hopefully they are the
> > ones who can help (if not, sorry to bother you).  
> > 
> > The list.h is fine, but if another task goes down this list when it
> > list_del_init is done, there's a chance that the reading task can get to
> > the deleted item just as it is being deleted, and has pointed itself to
> > itself. p->next == p.  This would go into an infinite loop.  
> > 
> > The reason sysrq works is because this doesn't stop interrupts. But put
> > a local_irq_save around that list and run your test, I bet you won't be
> > able to do anything, but power off with the big button.
> > 
> > Hope someone can help. I don't know the queue disciplines well enough to
> > make a proper fix.
> > 
> > -- Steve
> > 
> > 
> > 
> 

