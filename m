Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWFPGlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWFPGlF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 02:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWFPGlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 02:41:05 -0400
Received: from ns2.suse.de ([195.135.220.15]:9633 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751065AbWFPGlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 02:41:04 -0400
From: Andi Kleen <ak@suse.de>
To: "Tony Luck" <tony.luck@intel.com>
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Date: Fri, 16 Jun 2006 08:22:23 +0200
User-Agent: KMail/1.9.3
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org, vojtech@suse.cz
References: <200606140942.31150.ak@suse.de> <12c511ca0606151144i140c21e5w90dd948af9b536a4@mail.gmail.com>
In-Reply-To: <12c511ca0606151144i140c21e5w90dd948af9b536a4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606160822.23898.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 June 2006 20:44, Tony Luck wrote:
> On 6/14/06, Andi Kleen <ak@suse.de> wrote:
> > But at a closer look it really makes sense:
> > - The kernel has strong thread affinity and usually keeps a process on the
> > same CPU. So switching CPUs is rare. This makes it an useful optimization.
> 
> Alternatively it means that this will almost always do the right thing, but
> once in a while it won't, your application will happen to have been migrated
> to a different cpu/node at the point it makes the call, and from then on
> this instance will behave oddly (running slowly because it allocates most
> of its memory on the wrong node).  When you try to reproduce the problem,
> the application will work normally.

That's inherent in NUMA. No good way around that.

We have a similar problem with caches because we don't color them. People
have learned to live with it.
 
> > The alternative is usually to bind the process to a specific CPU - then it
> > "know" where it is - but the problem is that this is nasty to use and
> > requires user configuration. The kernel often can make better decisions on
> > where to schedule. And doing it automatically makes it just work.
> 
> Another alternative would be to provide a mechanism for a process
> to bind to the current cpu (whatever cpu that happens to be).  Then
> the kernel gets to make the smart placement decisions, and processes
> that want to be bound somewhere (but don't really care exactly where)
> have a way to meet their need.  Perhaps a cpumask of all zeroes to a
> sched_setaffinity call could be overloaded for this?

I tried something like this a few years ago and it just didn't work
(or rather ran usually slower) The scheduler would select a home node at startup and 
then try to move the process there. 

The problem is that not using a CPU costs you much more than whatever
overhead you get from using non local memory.

So by default filling the CPUs must be the highest priority and memory 
policy cannot interfere with that.
 
-Andi
