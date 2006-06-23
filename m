Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWFWIt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWFWIt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 04:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWFWIt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 04:49:56 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:41939 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751119AbWFWItz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 04:49:55 -0400
Subject: Re: [PATCH] kprobes for s390 architecture
From: Jan Glauber <jan.glauber@de.ibm.com>
To: Mike Grundy <grundym@us.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com
In-Reply-To: <20060622163643.GA3329@localhost.localdomain>
References: <20060612131552.GA6647@localhost.localdomain>
	 <1150141217.5495.72.camel@localhost>
	 <20060621042804.GA20300@localhost.localdomain>
	 <1150907920.8295.10.camel@localhost>
	 <20060621173436.GA7834@localhost.localdomain>
	 <1150975716.6496.9.camel@localhost>
	 <20060622163643.GA3329@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 10:50:08 +0200
Message-Id: <1151052608.6155.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 09:36 -0700, Mike Grundy wrote:
> On Thu, Jun 22, 2006 at 01:28:36PM +0200, Jan Glauber wrote:
> > On Wed, 2006-06-21 at 10:34 -0700, Mike Grundy wrote:
> > > On Wed, Jun 21, 2006 at 06:38:40PM +0200, Martin Schwidefsky wrote:
> > > > You misunderstood me here. I'm not talking about storing the same piece
> > > > of data to memory on each processor. I'm talking about isolating all
> > > > other cpus so that the initiating cpu can store the breakpoint to memory
> > > > without running into the danger that another cpu is trying to execute it
> > > > at the same time. But probably the store should be atomic in regard to
> > > > instruction fetching on the other cpus. It is only two bytes and it
> > > > should be aligned.
> > 
> > Preemption disabling is not necessary around smp_call_function(), since
> > smp_call_function() takes a spin lock. But smp_call_function() is wrong
> > here, it calls the code on all other CPUs but not on our own. Please use
> > on_each_cpu() instead.
> 
> But on_each_cpu() does:
> 
>         preempt_disable();
>         ret = smp_call_function(func, info, retry, wait);
>         local_irq_disable();
>         func(info);
>         local_irq_enable();
>         preempt_enable();
>  
> I'm confused. I really don't need to swap the instruction on each cpu. I really
> need to make sure each cpu is not fetching that instruction while I change it.
> s390 doesn't have a flush_icache_range() (which the other arches use after the 
> swap). I thought that the synchronization that smp_call_function() does was the
> primary reason for using it here, not repeatedly changing the same area of 
> memory.  If you'd prefer I use on_each_cpu() instead of smp_call_function(), 
> no problem.  

If I'm not completely off-track you _do_ swap the instruction on all
other CPUs with the smp_call_function(). But since we don't have a
flush_icache_range() interface on s390 we must understand how the
instruction cache works and then we will know whether we need the smp
call at all.

