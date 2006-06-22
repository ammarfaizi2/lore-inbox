Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWFVVGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWFVVGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWFVVGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:06:47 -0400
Received: from smtp-out.google.com ([216.239.45.12]:30867 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964957AbWFVVGq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:06:46 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=uEFwenkVQXa2EnpAHpONTpvEtPS/z36f+dWXp3piF9PHZDqy2mm7fLKfUCmmyXClP
	ZqAOoa07Y3dkd1fOZvzkw==
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200606221008.41873.ak@suse.de>
References: <200606210329_MC3-1-C305-E008@compuserve.com>
	 <200606220129.47546.ak@suse.de>
	 <1150937729.6885.112.camel@galaxy.corp.google.com>
	 <200606221008.41873.ak@suse.de>
Content-Type: text/plain
Organization: Google Inc
Date: Thu, 22 Jun 2006 14:06:27 -0700
Message-Id: <1151010387.14536.39.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 10:08 +0200, Andi Kleen wrote:
> On Thursday 22 June 2006 02:55, Rohit Seth wrote:
> 
> 
> > > - Put base address of user exportable part into GDT
> > > - Access it using that.
> >
> > These are the steps that I'm proposing in vgetcpu:
> >
> > Read the GDT pointer in vgetcpu code path.  This is the base of gdt
> > table.
> > Read descriptor #20 from base.
> > This is the pointer to user visible part of per cpu data structure.
> 
> > Please let me know if I'm missing something here.
> 
> Ok that would probably work, but you would need to export the GDT too.
> 

Would sgdt not be sufficient?  I agree that we will have to end up
giving RO access to user for the gdt page.

> I still don't see why we should do it - limit should be enough.
> 
> > Just a side note, in your vgetcpu patch, would it be better to return
> > the logical CPU number (as printed in /proc/cpuinfo).
> 
> The latest code does that already - i dropped the cpuid code
> completely and replaced it with LSL.
> 

Ah that is good.

> > Also, I think 
> > applications would be interested in knowing the physical package id for
> > cores sharing caches.
> 
> They can always map that themselves using cpuinfo. I would
> prefer to not overload the single call too much.

Yes they can map using /proc/cpuinfo.  But if there is any easier
mechanism then using /proc then that would help.  

I agree that we should not overload a single call (though cpu, package
and node numbers do belong in one category IMO).  We can have multiple
calls if that is required as long as there is an efficient mechanism to
provide that information.

> 
> > > And you can't get at at the base address anyways because they
> > > are ignored in long mode (except for fs/gs). For fs/gs you would
> > > need to save/restore them to reuse them which would be slow.
> > >
> > > You can't also just put them into fs/gs because those are
> > > already reserved for user space.
> >
> > That is the reason I'm not proposing to alter existing fs/gs.
> >
> > > Also I don't know what other information other than cpu/node
> > > would be useful, so just using the 20 bits of limit seems plenty to me.
> >
> > physical id (of the package for exmpale) is another useful field. 
> 
> Ok I see that, but it could be as well done by a small user space
> library that reads cpuinfo once and maps given vgetcpu()
> 

Why maintain that extra logic in user space when kernel can easily give
that information.

> On the other hand I got people complaining who need some more
> topology information (like number of cores/cpus), but /proc/cpuinfo
> is quite slow and adds a lot of overhead to fast starting programs.
> 

This is an excellent point.

> I've been pondering to put some more information about that
> in the ELF aux vector, but exporting might work too. I suppose
> exporting would require the vDSO first to give a sane interface.
> 
Can you please tell me what more information you are thinking of putting
in aux vector?

> > would also like to see number of interrupts serviced by this cpu, page
> > faults  etc.  But I think that is a separate discussion.
> 
> Well, the complex mechanism you're proposing above only makes

complex---no.  But sure that it is not as simple as lsl.

> sense if it is established more fields are needed (and cannot be satisfied
> by reserving a few more segment selectors) I admit I'm not
> quite convinced yet.

You are absolutely right that the mechanism I'm proposing makes sense
only if we have more fields AND if any of those fields are dynamically
changing.  But this is a generic mechanism that could be extended to
share any user visible information in efficient way.  Once we have this
in place then information like whole cpuinfo, percpu interrupts etc. can
be retrieved easily.

-rohit

