Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030587AbWF0BO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030587AbWF0BO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 21:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030585AbWF0BO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 21:14:26 -0400
Received: from smtp-out.google.com ([216.239.45.12]:44679 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030583AbWF0BOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 21:14:25 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=smR1hsUitfJS0YyK6oyeER0dxrHAX42jUu2ihkQzWLQi7pMpHCstHdaWOFvb4tcBh
	PiB/HMNQ48CZN3HUCwgOg==
Subject: Re: [discuss] Re: [RFC, patch] i386: vgetcpu(), take 2
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200606241042.50139.ak@suse.de>
References: <200606210329_MC3-1-C305-E008@compuserve.com>
	 <200606231442.23073.ak@suse.de>
	 <1151114785.23432.38.camel@galaxy.corp.google.com>
	 <200606241042.50139.ak@suse.de>
Content-Type: text/plain
Organization: Google Inc
Date: Mon, 26 Jun 2006 18:13:38 -0700
Message-Id: <1151370819.19703.89.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 10:42 +0200, Andi Kleen wrote:
> > It just does not sound like a right interface.  Why should an app be
> > giving the last time value that it asked for the same information.  
> 
> First this information comes with a good-before date stamp
> so it's natural. Otherwise the application will never pick
> up when the scheduler decides to schedule it somewhere else,
> which would be bad.
> 

Though the rescheduling can happen any time.  I'm not sure how is tcache
going to track rescheduling deterministically.  In theory there are
always going to be those pathological cases which will be very difficult
to get right (with or without tcache).


> And that came from conversation with application developers.
> 
> A: We want something to get the current node
> me: how fast does it need to be? 
> B: we will cache it anyways.
> 
> Problem is that normally the application can't do a good job
> at doing the cache because it doesn't have a fast way to 
> do time stamping (gettimeofday would be too slow and it's
> the fastest timer available short of having a second thread
> that sleeps and updates a counter) 
> 
> But the vsyscall incidentially knows this because of it
> sharing data with  vgettimeofday(), so it can
> do the job for the application
> 

I think I probably read your patch wrong or an earlier version where
user was sending the tcache down to vsyscall.  Is user sending the
tcache parameter containing the last jiffies down to vsyscall in your
latest patch?  Could you please point me to latest patch.

I think the system call is going to come with caveat that the
information provided by vgetcpu could be stale as the process could have
moved to different CPU before returning information.  

> > User 
> > wants cpu, package and node numbers and those are the three parameters
> > that should be there.  Besides if we are using lsl then the latency part
> > of cpuid is already gone so no need to optimize this any more.
> >

> > Though this will be good interface to export jiffies ;-)
> 
> No - jiffies don't have a defined unit and might even go away
> on a fully tickless kernel.
> 
> If we just exported jiffies you would get lots of HZ dependent
> programs.


I agree and that is why I don't think we should export anything relating
to jiffies to external world (may be my smiley selection wasn't right).
This goes back to my understanding that tcache is user visible.

-rohit

