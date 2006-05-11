Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWEKTTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWEKTTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 15:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWEKTTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 15:19:52 -0400
Received: from proof.pobox.com ([207.106.133.28]:29647 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1750724AbWEKTTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 15:19:51 -0400
Date: Thu, 11 May 2006 14:19:39 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Shaohua Li <shaohua.li@intel.com>,
       linux-kernel@vger.kernel.org, zwane@linuxpower.ca, vatsa@in.ibm.com
Subject: Re: [PATCH 0/10] bulk cpu removal support
Message-ID: <20060511191939.GC10833@localdomain>
References: <1147067137.2760.77.camel@sli10-desk.sh.intel.com> <20060510230606.076271b2.akpm@osdl.org> <20060511095308.A15483@unix-os.sc.intel.com> <20060511171920.GB10833@localdomain> <20060511104030.A15782@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060511104030.A15782@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj wrote:
> On Thu, May 11, 2006 at 12:19:20PM -0500, Nathan Lynch wrote:
> > 
> > But offlining all the cpus in a node is already something that just
> > works.  If the user is all that concerned about not thrashing the
> > tasks running on that node, they would have a workload manager that
> > migrates the tasks off the node before shooting down cpus.  Similar
> > argument applies to interrupt affinity.
> > 
> > I really haven't seen a compelling argument for why this is needed,
> > just a bunch of handwaving so far, sorry.
> 
> Hand waving? Dont think that was intensional though.. i think we are trying
> to address a real problem, if there is a reasonable alternate already
> that we are not aware of, no problemo...

If the motivation for these patches is to minimize disruption of the
workload when offlining a group of cpus, then I think the reasonable
alternative is for the admin (or a script) to migrate sensitive
tasks and interrupts to cpus that are not going to be offlined --
before offlining any cpus.

On the other hand, I'm getting the feeling that the problem you're
really trying to address is that offlining lots of cpus takes a long
time (on the order of a couple seconds per cpu) on your architectures.

So is it one of these two things, or a combination of both, or what?


> 1. Regarding process migration, someone needs to make sure they run
> something like a taskset away from all the cpus that are planned to be
> removed upfront. This needs to be done on all processes on the system.

I guess I don't understand what you're getting at here.  Are you
agreeing with me?  Or are you saying that doing this is a problem?


> 2. For interrrupt migration, today when we take a cpu offline, we pick 
> a random online cpu today.

That's an architecture-specific behavior.  On powerpc, interrupts
bound to a dying cpu have their affinity reset to the default (all cpus).


> So if you have a cpu going offline, and the 
> next logical cpu is also part of the same package, or node, we have
> no smarts today to keep migration away from those "to be offlined"
> cpus.

Yes, and the kernel really shouldn't have to be smart about this.
This is a matter of policy.  The admin knows which cpus are going to
be online.  The admin is free to reassign the irqs before offlining
cpus for optimal behavior.  (Of course, the kernel should still have a
sane fallback behavior, and it does.)

So, I still don't see the benefit of adding this change which works
around the kernel's scheduling behavior etc. when the admin easily has
the ability to mitigate the disruption by taking some preliminary
measures.

