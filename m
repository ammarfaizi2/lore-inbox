Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752021AbWKBSdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbWKBSdb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 13:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbWKBSdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 13:33:31 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51941 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1752025AbWKBSda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 13:33:30 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: tim.c.chen@linux.intel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1: Slowdown in lmbench's fork
References: <1162485897.10806.72.camel@localhost.localdomain>
Date: Thu, 02 Nov 2006 11:33:18 -0700
In-Reply-To: <1162485897.10806.72.camel@localhost.localdomain> (Tim Chen's
	message of "Thu, 02 Nov 2006 08:44:57 -0800")
Message-ID: <m1d5851yxd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Chen <tim.c.chen@linux.intel.com> writes:

> After introduction of the following patch:
>
> [PATCH] genirq: x86_64 irq: make vector_irq per cpu
> http://kernel.org/git/?
> p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=550f2299ac8ffaba943cf211380d3a8d3fa75301
>
> we see fork benchmark in lmbench-3.0-a7 slowed by 
> 11.5% on a 2 socket woodcrest machine.  Similar change
> is seen also on other SMP Xeon machines.
>
> When running lmbench, we have chosen the lmbench option
> to pin parent and child on different processor cores 
>   
> Overhead of calling sched_setaffinity to place the process 
> on processor is included in lmbench's fork time measurement. 
> The patch may play a role in increasing this.

The only think I can think of is that because data structures
moved around we may be seeing some more cache misses.  If we
were talking normal interrupts taking a little longer I can
see my change having a direct correlation.  But I don't believe
I touched anything in that patch that touched the IPI path.

I did add some things to the per cpu area and expanded it a little
which may be what you are seeing.

That feels like a significant increase in fork times.  I will think
about it and holler if I can think of a productive direction to try.

My only partial guess is that it might be worth adding the per cpu
variables my patch adds without any of the corresponding code changes.
And see if adding variables to the per cpu area is what is causing the
change.

The two tests I can see in this line are:
- to add the percpu vector_irq variable.
- to increase NR_IRQs.

My suspicion is that one of those two changes alone will change
things enough that you see your lmbench slowdown.  If that is the
case then it is probably worth shuffling around the variables in the
per cpu area to get better cache line affinity.

Eric
