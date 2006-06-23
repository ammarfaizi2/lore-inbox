Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWFWMm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWFWMm3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 08:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWFWMm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 08:42:29 -0400
Received: from ns2.suse.de ([195.135.220.15]:49604 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751278AbWFWMm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 08:42:29 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, rohitseth@google.com
Subject: Re: [discuss] Re: [RFC, patch] i386: vgetcpu(), take 2
Date: Fri, 23 Jun 2006 14:42:23 +0200
User-Agent: KMail/1.9.3
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <200606210329_MC3-1-C305-E008@compuserve.com> <200606230014.17067.ak@suse.de> <1151017804.14536.98.camel@galaxy.corp.google.com>
In-Reply-To: <1151017804.14536.98.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606231442.23073.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 June 2006 01:10, Rohit Seth wrote:

> > > I agree that we should not overload a single call (though cpu, package
> > > and node numbers do belong in one category IMO).  We can have multiple
> > > calls if that is required as long as there is an efficient mechanism to
> > > provide that information.
> > 
> > The current mechanism doesn't scale to much more calls, but I guess
> > i'll have to do a vDSO sooner or later.
> >  
> > > Why maintain that extra logic in user space when kernel can easily give
> > > that information.
> > 
> > It already does.
> >  
> 
> I'm missing your point here.  How and where?

In /proc/cpuinfo. 

Suresh and others even put a lot of thought into how to present the information
there.

Or did you just refer to the overhead of writing a /proc parser?
 
> > > > I've been pondering to put some more information about that
> > > > in the ELF aux vector, but exporting might work too. I suppose
> > > > exporting would require the vDSO first to give a sane interface.
> > > > 
> > > Can you please tell me what more information you are thinking of putting
> > > in aux vector?
> > 
> > One proposal (not fully fleshed out was) number of siblings / sockets / nodes 
> > I don't think bitmaps would work well there (and if someone really needs
> > those they can read cpuinfo again) 
> > 
> 
> This is exactly the point, why do that expensive /proc operation when
> you can do a quick vsyscall and get all of that information.  I'm not
> sure if Aux is the right direction.

It's already used for this at least (hwcap etc.) 

vDSO might be better too, but I haven't thought too much about it yet

> 
> > This is mostly for OpenMP and tuning of a few functions (e.g. on AMD
> > the memory latencies varies with the number of nodes so some functions
> > can be tuned in different ways based on that) 
> > 
> > > You are absolutely right that the mechanism I'm proposing makes sense
> > > only if we have more fields AND if any of those fields are dynamically
> > > changing.  But this is a generic mechanism that could be extended to
> > > share any user visible information in efficient way.  Once we have this
> > > in place then information like whole cpuinfo, percpu interrupts etc. can
> > > be retrieved easily.
> > 
> > The problem with exposing too much is that it might be a nightmare
> > to guarantee a stable ABI for this. At least it would
> > constrain the kernel internally. Probably less is better here. 
> > 
> 
> There will be (in all probability) requests to include as much as
> possible, 

Yes but that doesn't mean all these requests make sense and should
be actually followed :)


> but I think that should be manageable with sensible API.

Not sure. Leaner interfaces are really better here.

It's one of the lessons I learned from libnuma - i provide a lot of tools,
but nearly all people are perfectly satisfied with the total basics. So
it's better to start small and only add stuff when there is really a clear
use case.


> Okay. I just cooked that example for some monitoring process to find out
> the interrupts /sec on that CPU.  But as you mentioned above sibling,
> sockets, nodes, flags, and even other characteristics like current
> p-state are all important information that will help applications
> sitting in user land (even if some of them will be used only couple of
> times in the life of a process).

Ok you want faster monitoring applications? Some faster way than 
/proc for some stuff probably makes sense - but I don't think shared
mappings are the right way for it.

There's still a lot of other possibilities for this like relayfs 
or binary /proc files 
 
> Side note: I don't want to delay the vgetcpu call into mainline because
> of this discussion
I'll probably delay it after 2.6.18

> (as long as there is no cpuid and tcache in that 
> call).

What do you not like about tcache? 

-Andi

