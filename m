Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWFXCHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWFXCHL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 22:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWFXCHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 22:07:11 -0400
Received: from smtp-out.google.com ([216.239.45.12]:61043 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750850AbWFXCHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 22:07:08 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=oZkMO9VhaTAgIHWbuME3F1I3AFLh29WwvctOfKrTZbRrr18wzETi+ihnQb0f6DZyz
	Aq7U9RuI0zM/5JD5tNFGg==
Subject: Re: [discuss] Re: [RFC, patch] i386: vgetcpu(), take 2
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200606231442.23073.ak@suse.de>
References: <200606210329_MC3-1-C305-E008@compuserve.com>
	 <200606230014.17067.ak@suse.de>
	 <1151017804.14536.98.camel@galaxy.corp.google.com>
	 <200606231442.23073.ak@suse.de>
Content-Type: text/plain
Organization: Google Inc
Date: Fri, 23 Jun 2006 19:06:25 -0700
Message-Id: <1151114785.23432.38.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-23 at 14:42 +0200, Andi Kleen wrote:
> On Friday 23 June 2006 01:10, Rohit Seth wrote:
> 
> > > > I agree that we should not overload a single call (though cpu, package
> > > > and node numbers do belong in one category IMO).  We can have multiple
> > > > calls if that is required as long as there is an efficient mechanism to
> > > > provide that information.
> > > 
> > > The current mechanism doesn't scale to much more calls, but I guess
> > > i'll have to do a vDSO sooner or later.
> > >  
> > > > Why maintain that extra logic in user space when kernel can easily give
> > > > that information.
> > > 
> > > It already does.
> > >  
> > 
> > I'm missing your point here.  How and where?
> 
> In /proc/cpuinfo. 
> 
> Suresh and others even put a lot of thought into how to present the information
> there.
> 

That part I know very well :)

> Or did you just refer to the overhead of writing a /proc parser?
Yes exactly.

>  
> > > > > I've been pondering to put some more information about that
> > > > > in the ELF aux vector, but exporting might work too. I suppose
> > > > > exporting would require the vDSO first to give a sane interface.
> > > > > 
> > > > Can you please tell me what more information you are thinking of putting
> > > > in aux vector?
> > > 
> > > One proposal (not fully fleshed out was) number of siblings / sockets / nodes 
> > > I don't think bitmaps would work well there (and if someone really needs
> > > those they can read cpuinfo again) 
> > > 
> > 
> > This is exactly the point, why do that expensive /proc operation when
> > you can do a quick vsyscall and get all of that information.  I'm not
> > sure if Aux is the right direction.
> 
> It's already used for this at least (hwcap etc.) 
> 
> vDSO might be better too, but I haven't thought too much about it yet
> 

I like the vDSO interface.

> > 
> > There will be (in all probability) requests to include as much as
> > possible, 
> 
> Yes but that doesn't mean all these requests make sense and should
> be actually followed :)
> 
> 
> > but I think that should be manageable with sensible API.
> 
> Not sure. Leaner interfaces are really better here.
> 

yes. some sample implementation will be good here.  I'll try.

> It's one of the lessons I learned from libnuma - i provide a lot of tools,
> but nearly all people are perfectly satisfied with the total basics. So
> it's better to start small and only add stuff when there is really a clear
> use case.
> 

I'm not sure smaller libnuma would have gone too far at that time.
Though in this case you are starting small by just giving the vgetcpu
system call. And then we are going to look at other exportable data.

> 
> > Okay. I just cooked that example for some monitoring process to find out
> > the interrupts /sec on that CPU.  But as you mentioned above sibling,
> > sockets, nodes, flags, and even other characteristics like current
> > p-state are all important information that will help applications
> > sitting in user land (even if some of them will be used only couple of
> > times in the life of a process).
> 
> Ok you want faster monitoring applications? Some faster way than 
> /proc for some stuff probably makes sense - but I don't think shared
> mappings are the right way for it.
> 
> There's still a lot of other possibilities for this like relayfs 
> or binary /proc files 

/proc et.al just add overhead in retrieving this information. For things
that are easily available in kernel vDSO will help.

>  
> > Side note: I don't want to delay the vgetcpu call into mainline because
> > of this discussion

> I'll probably delay it after 2.6.18
> 

Why?

> > (as long as there is no cpuid and tcache in that 
> > call).
> 
> What do you not like about tcache? 
> 

It just does not sound like a right interface.  Why should an app be
giving the last time value that it asked for the same information.  User
wants cpu, package and node numbers and those are the three parameters
that should be there.  Besides if we are using lsl then the latency part
of cpuid is already gone so no need to optimize this any more.

Though this will be good interface to export jiffies ;-)

-rohit




