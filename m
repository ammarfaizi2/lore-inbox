Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVHQAjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVHQAjV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 20:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVHQAjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 20:39:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:10228 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750781AbVHQAjU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 20:39:20 -0400
Message-ID: <4302872F.2050303@mvista.com>
Date: Tue, 16 Aug 2005 17:39:11 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
CC: Roman Zippel <zippel@linux-m68k.org>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [UPDATE PATCH] push rounding up of relative request to schedule_timeout()
References: <Pine.LNX.4.61.0507231911540.3743@scrub.home> <20050723191004.GB4345@us.ibm.com> <Pine.LNX.4.61.0507232151150.3743@scrub.home> <20050727222914.GB3291@us.ibm.com> <Pine.LNX.4.61.0507310046590.3728@scrub.home> <20050801193522.GA24909@us.ibm.com> <Pine.LNX.4.61.0508031419000.3728@scrub.home> <20050804005147.GC4255@us.ibm.com> <20050804051434.GA4520@us.ibm.com> <42F24643.7080702@mvista.com> <20050816230512.GD2806@us.ibm.com>
In-Reply-To: <20050816230512.GD2806@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan wrote:
> On 04.08.2005 [09:45:55 -0700], George Anzinger wrote:
> 
>>Uh... PLEASE tell me you are NOT changing timespec_to_jiffies() (and 
>>timeval_to_jiffies() to add 1.  This is NOT the right thing to do.  For 
>>repeating times (see setitimer code) we need the actual time as we KNOW 
>>where the jiffies edge is in the repeating case.  The +1 is needed ONLY 
>>for the initial time, not the repeating time.
>>
>>
>>See:
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=112208357906156&w=2
> 
> 
> I followed that thread, George, but I think it's a different case with
> schedule_timeout() [maybe this indicates drivers/other users should
> maybe be using itimers, but I'll get to that in a sec].

I think I miss understood back then :).

> 
> With schedule_timeout(), we are just given a relative jiffies value. We
> have no context as to which task is requesting the delay, per se,
> meaning we don't (can't) know from the interface whether this is the
> first delay in a sequence, or a brand new one, without changing all
> users to have some sort of control structure. The callers of
> schedule_timeout() don't even get a pointer to the timer added
> internally.
> 
> So, adding 1 to all sleeps seems like it might be reasonable, as looping
> sleeps probably need to use a different interface. I had worked a bit
> ago on something like poll_event() with the kernel-janitors group, which
> would abstract out the repeated sleeps. Basically wait_event() without
> wait-queues... Maybe we could make such an interface just use itimers?
> I've attached my old patch for poll_event(), just for reference.

I think not.  itimers is really pointed at a particular system call and 
has resources in the task structure to do it.  These would be hard to 
share...
> 
> My point, I guess, is that in the schedule_timeout() case, we don't know
> where the jiffies edge is, as we either expire or receive a wait-queue
> event/signal, we never mod_timer() the internal timer... So we have to
> assume that we need to sleep the request. But maybe Roman's idea of
> sleeping a certain number of jiffy edges is sufficient. I am not yet
> convinced driver authors want/need such an interface, though, still
> thinking it over.

IMNSHO we should not get too parental with kernel only interfaces. 
Adding 1 is easy enough for the caller and even easier to explain in the 
instructions (i.e. this call sleeps for X jiffies edges).  This allows 
the caller to do more if needed and, should he ever just want to sync to 
the next jiffie he does not have to deal with backing out that +1.
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
