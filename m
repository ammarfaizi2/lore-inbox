Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbVHKVbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbVHKVbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbVHKVbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:31:12 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:59917 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750995AbVHKVbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:31:11 -0400
Message-ID: <42FBC43F.5020009@tmr.com>
Date: Thu, 11 Aug 2005 17:33:51 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com
CC: Andrew Morton <akpm@osdl.org>, tony@atomide.com,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       ck@vds.kolivas.org, tuukka.tikkanen@elektrobit.com
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 5
References: <200508031559.24704.kernel@kolivas.org>	<200508060239.41646.kernel@kolivas.org>	<20050806174739.GU4029@stusta.de>	<200508071512.22668.kernel@kolivas.org>	<20050807165833.GA13918@in.ibm.com> <42F905DA.4070308@mvista.com>	<20050810140528.GA20893@in.ibm.com> <42FA81B9.9020801@mvista.com>
In-Reply-To: <42FA81B9.9020801@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
> Srivatsa Vaddagiri wrote:
> 
>> On Tue, Aug 09, 2005 at 12:36:58PM -0700, George Anzinger wrote:
>>
>>> IMNOHO, this is the ONLY way to keep proper time.  As soon as you 
>>> reprogram the PIT you have lost track of the time.
>>
>>
>>
>> George,
>>     Can't TSC (or equivalent) serve as a backup while PIT is disabled,
>> especially considering that we disable PIT only for short duration in 
>> practice (few seconds maybe) _and_ that we don't have HRT support yet?
>>
> I think it really depends on what you want.  If you really want to keep 
> good time, the only rock in town is the one connected to the PIT (and 
> the pmtimer).  The problem is, if you want the jiffie edge to be stable, 
> there is just now way to reprogram the PIT to get it back to where it was.
> 
> In an old version of HRT I did a trick of loading a short count (based 
> on reading the TSC or pmtimer) and then put the LATCH count on top of 
> it.  In a correctly performing PIT, it should count down the short 
> count, interrupt, load the long count and continue from there.  Aside 
> from the machines that had BAD PITs (they reset on the load instead of 
> the expiry of the current count) there were other problems that, in the 
> end, cause loss of time (too fast, too slow, take your pick).  I also 
> found PITs that signaled that they had loaded the count (they set a 
> status bit) prior to actually loading it.  All in all, I find the PIT is 
> just an ugly beast to try to program.  On the other hand, if you want 
> regular interrupts at some fixed period, it will do this forever (give 
> or take a epoch or two;) with out touching anything after the initial 
> program set up.
> 
> In the end, I concluded that, for the community kernel, it is really 
> best to just interrupt the irq line and leave the PIT run.  Then you use 
> the TSC or pmtimer to figure the gross loss of interrupts and leave the 
> PIT interrupt again to define the jiffie edge.  If you have other, more 
> pressing, concerns I suppose you can program the PIT, but don't expect 
> your wall clock to be as stable as it is now.
> 
What are the portability and scaling issues if it were done this way? It 
clearly looks practical on x86 uni, but if we want per-CPU non-tick, I'm 
less sure how it would work.

But when you go to non-x86 hardware, is there always going to be another 
source of wakeup available if the PIT is blocked instead of reset? I 
have to go back and look at how SPARC hardware works, I don't remember 
enough to be useful.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
