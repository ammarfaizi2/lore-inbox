Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268890AbUJFIGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268890AbUJFIGp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 04:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269050AbUJFIGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 04:06:45 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:33724 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S268890AbUJFIGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 04:06:38 -0400
Date: Wed, 6 Oct 2004 10:02:58 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Matthew Dobson <colpatch@us.ibm.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Simon.Derr@bull.net,
       Andi Kleen <ak@suse.de>, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
In-Reply-To: <1097014749.4065.48.camel@arrakis>
Message-ID: <Pine.LNX.4.61.0410060952540.19964@openx3.frec.bull.fr>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> 
 <20040805190500.3c8fb361.pj@sgi.com><247790000.1091762644@[10.10.2.4]> 
 <200408061730.06175.efocht@hpce.nec.com> <20040806231013.2b6c44df.pj@sgi.com>
 <411685D6.5040405@watson.ibm.com> <20041001164118.45b75e17.akpm@osdl.org>
 <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com>
 <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au>
 <821020000.1096814205@[10.10.2.4]>  <20041003083936.7c844ec3.pj@sgi.com>
 <834330000.1096847619@[10.10.2.4]> <1097014749.4065.48.camel@arrakis>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2004, Matthew Dobson wrote:

> On Sun, 2004-10-03 at 16:53, Martin J. Bligh wrote:
> > > Martin wrote:
> > >> Matt had proposed having a separate sched_domain tree for each cpuset, which
> > >> made a lot of sense, but seemed harder to do in practice because "exclusive"
> > >> in cpusets doesn't really mean exclusive at all.
> > > 
> > > See my comments on this from yesterday on this thread.
> > > 
> > > I suspect we don't want a distinct sched_domain for each cpuset, but
> > > rather a sched_domain for each of several entire subtrees of the cpuset
> > > hierarchy, such that every CPU is in exactly one such sched domain, even
> > > though it be in several cpusets in that sched_domain.
> > 
> > Mmmm. The fundamental problem I think we ran across (just whilst pondering,
> > not in code) was that some things (eg ... init) are bound to ALL cpus (or
> > no cpus, depending how you word it); i.e. they're created before the cpusets
> > are, and are a member of the grand-top-level-uber-master-thingummy.
> > 
> > How do you service such processes? That's what I meant by the exclusive
> > domains aren't really exclusive. 
> > 
> > Perhaps Matt can recall the problems better. I really liked his idea, aside
> > from the small problem that it didn't seem to work ;-)
> 
> Well that doesn't seem like a fair statement.  It's potentially true,
> but it's really hard to say without an implementation! ;)
> 
> I think that the idea behind cpusets is really good, essentially
> creating isolated areas of CPUs and memory for tasks to run
> undisturbed.  I feel that the actual implementation, however, is taking
> a wrong approach, because it attempts to use the cpus_allowed mask to
> override the scheduler in the general case.  cpus_allowed, in my
> estimation, is meant to be used as the exception, not the rule.  If we
> wish to change that, we need to make the scheduler more aware of it, so
> it can do the right thing(tm) in the presence of numerous tasks with
> varying cpus_allowed masks.  The other option is to implement cpusets in
> a way that doesn't use cpus_allowed.  That is the option that I am
> pursuing.  

I like this idea. 

The current implementation uses cpus_allowed because it is non-intrusive, 
as it does not touch the scheduler at all, and also maybe because it was 
easy to do this way since the cpuset development team seems to lack 
scheduler gurus.

The 'non intrusive' part was also important as long as the cpusets were 
mostly 'on their own', but if now it appears that more cooperation with 
other functions such as CKRM is needed, I suppose a deeper impact on the 
scheduler code might be OK. Especially if we intend to enforce 'real 
exclusive' cpusets or things like that.

So I'm really interested in any design/bits of code that would go in that 
direction.

	Simon.

