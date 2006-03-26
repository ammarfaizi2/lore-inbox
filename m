Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWCZCsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWCZCsa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 21:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWCZCsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 21:48:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46740 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751348AbWCZCs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 21:48:29 -0500
Date: Sat, 25 Mar 2006 18:44:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: nickpiggin@yahoo.com.au, mingo@elte.hu, suresh.b.siddha@intel.com,
       pj@sgi.com, hawkes@sgi.com, linux-kernel@vger.kernel.org,
       dino@in.ibm.com
Subject: Re: [PATCH 2.6.16-mm1 1/2] sched_domain: handle kmalloc failure
Message-Id: <20060325184441.0f6ba5bc.akpm@osdl.org>
In-Reply-To: <20060326024039.GA2998@in.ibm.com>
References: <20060325082730.GA17011@in.ibm.com>
	<20060325180605.6e5bb4b9.akpm@osdl.org>
	<20060326024039.GA2998@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
>
> On Sat, Mar 25, 2006 at 06:06:05PM -0800, Andrew Morton wrote:
> > This is rather ugly, sorry.
> 
> That was about my reaction too when I was going thr'
> build_sched_domains()!
> 
> > So if the kmalloc failed we'll try to limp along without load balancing?
> 
> Not exactly. We will still load balance at lower domains (between
> threads of a CPU & between CPUs of a node) that dont require any memory
> allocation.
> 
> > I think it would be better to free any thus-far allocated memory and to
> > fail the whole thing.
> 
> This would result in absolutely no load balancing (even for domain
> levels which didnt need any memory allocation - like at threads-of-a-cpu
> level). Is that acceptable?
> 
> > Returning void from build_sched_domains was wrong.
> 
> If we decide to return an error, then it has to be percolated all the
> way down (for ex: update_cpu_domains should now have to return an error
> too if partition_sched_domains returns an error)?

Well, when is this code called?  It would be at boot time, in which case
the allocations will succeed (if not, the boot fails) or at cpu/node
hot-add, in which case the appropriate response is to fail to bring up the
new cpu/node.

It's better to send the administrator back to work out why we ran out of
memory than to appear to have brought the new cpu/node online, only to have
it run funny.

I think?

> > build_sched_domains() should be static and __cpuinit, btw.
> 
> Ok ..Will take care of that in the next version of the patch.
> 

umm, it's probably best to not bother.  I think Ashok is looking into all
the memory we're presently wasting on non-cpu_hotplug builds.  There's
quite a lot in there.

