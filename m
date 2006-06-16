Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWFPO4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWFPO4v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 10:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWFPO4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 10:56:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:37079 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751437AbWFPO4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 10:56:50 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Date: Fri, 16 Jun 2006 16:54:15 +0200
User-Agent: KMail/1.9.3
Cc: Jes Sorensen <jes@sgi.com>, Tony Luck <tony.luck@intel.com>,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       vojtech@suse.cz, linux-ia64@vger.kernel.org
References: <200606140942.31150.ak@suse.de> <200606161317.19296.ak@suse.de> <44929CE6.4@sgi.com>
In-Reply-To: <44929CE6.4@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606161654.15881.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I really don't see the benefit here. malloc already gets pages handed
> down from the kernel which are node local due to them being assigned at
> a first touch basis. I am not sure about glibc's malloc internals, but
> rather rely on a vgetcpu() call, all it really needs to do is to keep
> a thread local pool which will automatically get it's thing locally
> through first touch usage.

That would add too much overhead on small systems. It's better to be 
able to share the pools. vgetcpu allows that.
 
> > Basically it is just for extending the existing already used proven etc.
> > default local policy to sub pages. Also there might be other uses
> > of it too (like per CPU data), although I expect most use of that
> > in user space can be already done using TLS.
> 
> The thread libraries already have their own thread local area which
> should be allocated on the thread's own node if done right, which I
> assume it is.

- The heap for small allocations is shared (although this can be tuned) 
- When another thread does free() you need special handling to keep
the item in the correct free lists
This is one of the tricky bits in the new kernel NUMA slab allocator
too.

> > But cpusets already does this kind of, even though it has a quite
> > bad impact on fast paths.
> >  Also what happens if the affinity mask is modified later?
> > From the high semantics point it is also a little dubious to mesh
> > them together. My feeling is that as a heuristic it is probably
> > dubious.
> 
> If you migrate your app elsewhere, you should migrate the pages with it,
> or not expect things to run with the local effect.

That's too costly to do by default and you have no guarantee that it will amortize.
 
> I don't really see the point in solving something half way when it can
> be done better. Maybe the "serious" databases should open up and let us
> know what the problem is they are hitting.

I see no indication of anything better so far from you. You only offered
static configuration instead which while in some cases is better
doesn't work in the general case.
-Andi
