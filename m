Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbVHQF40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbVHQF40 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 01:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVHQF40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 01:56:26 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:24548 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750867AbVHQF4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 01:56:25 -0400
Date: Tue, 16 Aug 2005 22:56:22 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: George Anzinger <george@mvista.com>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [UPDATE PATCH] push rounding up of relative request to schedule_timeout()
Message-ID: <20050817055622.GB4143@us.ibm.com>
References: <Pine.LNX.4.61.0507232151150.3743@scrub.home> <20050727222914.GB3291@us.ibm.com> <Pine.LNX.4.61.0507310046590.3728@scrub.home> <20050801193522.GA24909@us.ibm.com> <Pine.LNX.4.61.0508031419000.3728@scrub.home> <20050804005147.GC4255@us.ibm.com> <20050804051434.GA4520@us.ibm.com> <42F24643.7080702@mvista.com> <20050816230512.GD2806@us.ibm.com> <4302872F.2050303@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4302872F.2050303@mvista.com>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.2005 [17:39:11 -0700], George Anzinger wrote:
> Nishanth Aravamudan wrote:
> >On 04.08.2005 [09:45:55 -0700], George Anzinger wrote:
> >
> >>Uh... PLEASE tell me you are NOT changing timespec_to_jiffies() (and 
> >>timeval_to_jiffies() to add 1.  This is NOT the right thing to do.  For 
> >>repeating times (see setitimer code) we need the actual time as we KNOW 
> >>where the jiffies edge is in the repeating case.  The +1 is needed ONLY 
> >>for the initial time, not the repeating time.
> >>
> >>
> >>See:
> >>http://marc.theaimsgroup.com/?l=linux-kernel&m=112208357906156&w=2
> >
> >
> >I followed that thread, George, but I think it's a different case with
> >schedule_timeout() [maybe this indicates drivers/other users should
> >maybe be using itimers, but I'll get to that in a sec].
> 
> I think I miss understood back then :).

Ok, no problem. I was just thinking today about all the issues that were
borught up... I really appreciate your feedback.

> >
> >With schedule_timeout(), we are just given a relative jiffies value. We
> >have no context as to which task is requesting the delay, per se,
> >meaning we don't (can't) know from the interface whether this is the
> >first delay in a sequence, or a brand new one, without changing all
> >users to have some sort of control structure. The callers of
> >schedule_timeout() don't even get a pointer to the timer added
> >internally.
> >
> >So, adding 1 to all sleeps seems like it might be reasonable, as looping
> >sleeps probably need to use a different interface. I had worked a bit
> >ago on something like poll_event() with the kernel-janitors group, which
> >would abstract out the repeated sleeps. Basically wait_event() without
> >wait-queues... Maybe we could make such an interface just use itimers?
> >I've attached my old patch for poll_event(), just for reference.
> 
> I think not.  itimers is really pointed at a particular system call and 
> has resources in the task structure to do it.  These would be hard to 
> share...

Ok, I wasn't sure about that -- I'm not too familiar with the itimer
code (maybe I'll take a look at it soon :) )

> >My point, I guess, is that in the schedule_timeout() case, we don't know
> >where the jiffies edge is, as we either expire or receive a wait-queue
> >event/signal, we never mod_timer() the internal timer... So we have to
> >assume that we need to sleep the request. But maybe Roman's idea of
> >sleeping a certain number of jiffy edges is sufficient. I am not yet
> >convinced driver authors want/need such an interface, though, still
> >thinking it over.
> 
> IMNSHO we should not get too parental with kernel only interfaces. 
> Adding 1 is easy enough for the caller and even easier to explain in the 
> instructions (i.e. this call sleeps for X jiffies edges).  This allows 
> the caller to do more if needed and, should he ever just want to sync to 
> the next jiffie he does not have to deal with backing out that +1.

I don't want to be too parental either, but I also am trying to avoid
code duplication. Lots of drivers basically do something like
poll_event() does (or could do with some changes), i.e. looping a
constant amount multiple times, checking something every so often. The
patch was just a thought, though. I will keep evaluating drivers and see
if it's a useful interface to have eventually.

I guess I'm just concerned with making an unintuitive interface. As was
brought up at OLS, drivers are a major source of bugs/buggy code. The
simpler, more useful we can make interfaces, the better, I think. I'm
not claiming you disagree, I just want to make my own motives clear.
While fixing up the schedule_timeout() comment would make it clear what
schedule_timeout() achieves, I'm not sure how useful such an interface
is, if every caller adds 1 :) I need to mull it over, though... Lots to
consider. I also, of course, want to stay flexible for the reasons you
mention (letting the driver adjust the timeout as they expect to).

Thanks,
Nish
