Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUJEWVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUJEWVT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 18:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUJEWVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 18:21:19 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:48610 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266186AbUJEWUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 18:20:48 -0400
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Paul Jackson <pj@sgi.com>, pwil3058@bigpond.net.au, frankeh@watson.ibm.com,
       dipankar@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       LSE Tech <lse-tech@lists.sourceforge.net>, hch@infradead.org,
       steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Simon.Derr@bull.net,
       Andi Kleen <ak@suse.de>, sivanich@sgi.com
In-Reply-To: <834330000.1096847619@[10.10.2.4]>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	 <20040805190500.3c8fb361.pj@sgi.com><247790000.1091762644@[10.10.2.4]>
	 <200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au> <821020000.1096814205@[10.10.2.4]>
	 <20041003083936.7c844ec3.pj@sgi.com> <834330000.1096847619@[10.10.2.4]>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097014749.4065.48.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 05 Oct 2004 15:19:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-03 at 16:53, Martin J. Bligh wrote:
> > Martin wrote:
> >> Matt had proposed having a separate sched_domain tree for each cpuset, which
> >> made a lot of sense, but seemed harder to do in practice because "exclusive"
> >> in cpusets doesn't really mean exclusive at all.
> > 
> > See my comments on this from yesterday on this thread.
> > 
> > I suspect we don't want a distinct sched_domain for each cpuset, but
> > rather a sched_domain for each of several entire subtrees of the cpuset
> > hierarchy, such that every CPU is in exactly one such sched domain, even
> > though it be in several cpusets in that sched_domain.
> 
> Mmmm. The fundamental problem I think we ran across (just whilst pondering,
> not in code) was that some things (eg ... init) are bound to ALL cpus (or
> no cpus, depending how you word it); i.e. they're created before the cpusets
> are, and are a member of the grand-top-level-uber-master-thingummy.
> 
> How do you service such processes? That's what I meant by the exclusive
> domains aren't really exclusive. 
> 
> Perhaps Matt can recall the problems better. I really liked his idea, aside
> from the small problem that it didn't seem to work ;-)

Well that doesn't seem like a fair statement.  It's potentially true,
but it's really hard to say without an implementation! ;)

I think that the idea behind cpusets is really good, essentially
creating isolated areas of CPUs and memory for tasks to run
undisturbed.  I feel that the actual implementation, however, is taking
a wrong approach, because it attempts to use the cpus_allowed mask to
override the scheduler in the general case.  cpus_allowed, in my
estimation, is meant to be used as the exception, not the rule.  If we
wish to change that, we need to make the scheduler more aware of it, so
it can do the right thing(tm) in the presence of numerous tasks with
varying cpus_allowed masks.  The other option is to implement cpusets in
a way that doesn't use cpus_allowed.  That is the option that I am
pursuing.  

My idea is to make sched_domains much more flexible and dynamic.  By
adding locking and reference counting, and simplifying the way in which
sched_domains are created, linked, unlinked and eventually destroyed we
can use sched_domains as the implementation of cpusets.  IA64 already
allows multiple sched_domains trees without a shared top-level domain. 
My proposal is to make this functionality more generally available. 
Extending the "isolated domains" concept a little further will buy us
most (all?) the functionality of "exclusive" cpusets without the need to
use cpus_allowed at all.

I've got some code.  I'm in the midst of pushing it forward to rc3-mm2. 
I'll post an RFC later today or tomorrow when it's cleaned up.

-Matt

