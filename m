Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161172AbWFVQgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161172AbWFVQgm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030645AbWFVQgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:36:42 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:50662 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030643AbWFVQgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:36:41 -0400
Date: Thu, 22 Jun 2006 09:36:43 -0700
From: Mike Grundy <grundym@us.ibm.com>
To: Jan Glauber <jan.glauber@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH] kprobes for s390 architecture
Message-ID: <20060622163643.GA3329@localhost.localdomain>
Mail-Followup-To: Jan Glauber <jan.glauber@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
References: <20060612131552.GA6647@localhost.localdomain> <1150141217.5495.72.camel@localhost> <20060621042804.GA20300@localhost.localdomain> <1150907920.8295.10.camel@localhost> <20060621173436.GA7834@localhost.localdomain> <1150975716.6496.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150975716.6496.9.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 01:28:36PM +0200, Jan Glauber wrote:
> On Wed, 2006-06-21 at 10:34 -0700, Mike Grundy wrote:
> > On Wed, Jun 21, 2006 at 06:38:40PM +0200, Martin Schwidefsky wrote:
> > > You misunderstood me here. I'm not talking about storing the same piece
> > > of data to memory on each processor. I'm talking about isolating all
> > > other cpus so that the initiating cpu can store the breakpoint to memory
> > > without running into the danger that another cpu is trying to execute it
> > > at the same time. But probably the store should be atomic in regard to
> > > instruction fetching on the other cpus. It is only two bytes and it
> > > should be aligned.
> 
> Preemption disabling is not necessary around smp_call_function(), since
> smp_call_function() takes a spin lock. But smp_call_function() is wrong
> here, it calls the code on all other CPUs but not on our own. Please use
> on_each_cpu() instead.

But on_each_cpu() does:

        preempt_disable();
        ret = smp_call_function(func, info, retry, wait);
        local_irq_disable();
        func(info);
        local_irq_enable();
        preempt_enable();
 
I'm confused. I really don't need to swap the instruction on each cpu. I really
need to make sure each cpu is not fetching that instruction while I change it.
s390 doesn't have a flush_icache_range() (which the other arches use after the 
swap). I thought that the synchronization that smp_call_function() does was the
primary reason for using it here, not repeatedly changing the same area of 
memory.  If you'd prefer I use on_each_cpu() instead of smp_call_function(), 
no problem.  

Thanks
Mike

