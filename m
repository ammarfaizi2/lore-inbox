Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWBFVIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWBFVIn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWBFVIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:08:43 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:61155 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932372AbWBFVIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:08:41 -0500
Date: Mon, 6 Feb 2006 22:07:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Paul Jackson <pj@sgi.com>, ak@suse.de, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060206210701.GA24446@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602061811.49113.ak@suse.de> <Pine.LNX.4.62.0602061017510.16829@schroedinger.engr.sgi.com> <200602061936.27322.ak@suse.de> <20060206184330.GA22275@elte.hu> <20060206120109.0738d6a2.pj@sgi.com> <20060206200506.GA13466@elte.hu> <Pine.LNX.4.62.0602061221200.18348@schroedinger.engr.sgi.com> <20060206204111.GA20495@elte.hu> <Pine.LNX.4.62.0602061243200.18394@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0602061243200.18394@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Lameter <clameter@engr.sgi.com> wrote:

> On Mon, 6 Feb 2006, Ingo Molnar wrote:
> 
> > it's a feature, not a weird effect! Under the VFS-driven scheme, if two 
> > projects (one 'local' and one 'global') can access the same (presumably 
> > big) file, then the sysadmin has to make up his mind and determine which 
> > policy to use for that file. The file will either be local, or global - 
> > consistently.
> 
> But that local or global allocation policy depends on what task is 
> accessing the data at what time. A simple grep should not result in 
> interleaving. A big application accessing the same data from multiple 
> processes should have interleaving for shared data. Both may not be 
> active at the same time.

the grep faults in the pagecache, and depending on which job is active 
first, the placement of the pages will either be spread out or local, 
depending on the timing of those jobs. How do you expect this to behave 
deterministically?

> > with the per-cpuset policy approach on the other hand it would be 
> > non-deterministic which policy the file gets allocated under: whichever 
> > cpuset first manages to touch that file. That is what i'd call a weird 
> > and undesirable effect. This weirdness comes from the conceptual hickup 
> > of attaching the object-allocation policy to the workload, not to the 
> > file objects of the workload - hence conflicts can arise if two 
> > workloads share file objects.
> 
> Well these weird effects are then at least expected since there was a 
> cpuset set up for applications to activate this effect and the 
> processes running in that cpuset will behave in the weird way we want.

nondeterministic placement of pagecache pages sure looks nasty. In most 
cases i suspect what matters are project-specific data files - which 
will be allocated deterministically because they are mostly private to 
the cpuset. But e.g. /usr files want to be local in most cases, even for 
a 'spread out' cpuset. Why would you want to allocate them globally?

> The mountpoint option means that reading the contents of a file in 
> some filesystems is slower than in others because some files spread 
> their pages all over the system while others are node local. Again if 
> the process is single threaded the node local is always the right 
> approach. These single threaded processes will no longer be able to 
> run with full pagecache speed. Memory will be used in other nodes that 
> may have been reserved for other purposes by the user.

but a single object cannot be allocated both locally and globally!  
(well, it could be, for read-mostly workloads, but lets ignore that 
possibility) So instead of letting chance determine it, it is the most 
natural thing to let the object (or its container) determine which 
strategy to use - not the workload. This avoids the ambiguity at its 
core.

so if two projects want to use the same file in two different ways at 
the same time then there is no solution either under the VFS-based or 
under the cpuset-based approach - but at least the VFS-based method is 
fully predictable, and wont depend on which science department starts 
its simulation job first ...

if two projects want to use the same file in two different ways but not 
at the same time, then again the VFS-based method is better: each 
project, when it starts to run, could/should set the policy of that 
shared data. (which setting of policy would also flush all pagecache 
pages of the affected file[s], flushing any prior incorrect placement of 
pages)

	Ingo
