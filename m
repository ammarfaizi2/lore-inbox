Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030452AbWFVXKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbWFVXKi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbWFVXKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:10:38 -0400
Received: from smtp-out.google.com ([216.239.45.12]:14268 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030452AbWFVXKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:10:37 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=BeCi0AiYBIwxl/CUGUvhQCkoaychnT9QyzgLqNk+MsjQ1pOdkfy7Rza3or4c+mGdH
	hQ3GWG+4Dc+x9cIhA5+Gw==
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
In-Reply-To: <200606230014.17067.ak@suse.de>
References: <200606210329_MC3-1-C305-E008@compuserve.com>
	 <200606221008.41873.ak@suse.de>
	 <1151010387.14536.39.camel@galaxy.corp.google.com>
	 <200606230014.17067.ak@suse.de>
Content-Type: text/plain
Organization: Google Inc
Date: Thu, 22 Jun 2006 16:10:03 -0700
Message-Id: <1151017804.14536.98.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-23 at 00:14 +0200, Andi Kleen wrote:
> > Would sgdt not be sufficient?  I agree that we will have to end up
> > giving RO access to user for the gdt page.
> 
> I meant exporting the GDT page
> 

Yes indeed.  That shouldn't be an issue though.

> > I agree that we should not overload a single call (though cpu, package
> > and node numbers do belong in one category IMO).  We can have multiple
> > calls if that is required as long as there is an efficient mechanism to
> > provide that information.
> 
> The current mechanism doesn't scale to much more calls, but I guess
> i'll have to do a vDSO sooner or later.
>  
> > Why maintain that extra logic in user space when kernel can easily give
> > that information.
> 
> It already does.
>  

I'm missing your point here.  How and where?

> > > I've been pondering to put some more information about that
> > > in the ELF aux vector, but exporting might work too. I suppose
> > > exporting would require the vDSO first to give a sane interface.
> > > 
> > Can you please tell me what more information you are thinking of putting
> > in aux vector?
> 
> One proposal (not fully fleshed out was) number of siblings / sockets / nodes 
> I don't think bitmaps would work well there (and if someone really needs
> those they can read cpuinfo again) 
> 

This is exactly the point, why do that expensive /proc operation when
you can do a quick vsyscall and get all of that information.  I'm not
sure if Aux is the right direction.

> This is mostly for OpenMP and tuning of a few functions (e.g. on AMD
> the memory latencies varies with the number of nodes so some functions
> can be tuned in different ways based on that) 
> 
> > You are absolutely right that the mechanism I'm proposing makes sense
> > only if we have more fields AND if any of those fields are dynamically
> > changing.  But this is a generic mechanism that could be extended to
> > share any user visible information in efficient way.  Once we have this
> > in place then information like whole cpuinfo, percpu interrupts etc. can
> > be retrieved easily.
> 
> The problem with exposing too much is that it might be a nightmare
> to guarantee a stable ABI for this. At least it would
> constrain the kernel internally. Probably less is better here. 
> 

There will be (in all probability) requests to include as much as
possible, but I think that should be manageable with sensible API.

> Also I'm still not sure why user space should care about interrupts?
> 
Okay. I just cooked that example for some monitoring process to find out
the interrupts /sec on that CPU.  But as you mentioned above sibling,
sockets, nodes, flags, and even other characteristics like current
p-state are all important information that will help applications
sitting in user land (even if some of them will be used only couple of
times in the life of a process).

Side note: I don't want to delay the vgetcpu call into mainline because
of this discussion (as long as there is no cpuid and tcache in that
call).

-rohit

