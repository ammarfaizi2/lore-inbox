Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWDEWxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWDEWxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 18:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWDEWxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 18:53:16 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:44771 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932117AbWDEWxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 18:53:15 -0400
Message-ID: <44344A59.9070007@bigpond.net.au>
Date: Thu, 06 Apr 2006 08:53:13 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
References: <200604031459.51542.a1426z@gawab.com> <200604041627.25359.a1426z@gawab.com> <4432FE8C.7010900@bigpond.net.au> <200604051116.05270.a1426z@gawab.com>
In-Reply-To: <200604051116.05270.a1426z@gawab.com>
Content-Type: text/plain; charset=windows-1256; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 5 Apr 2006 22:53:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Peter Williams wrote:
>> Al Boldi wrote:
>>> Peter Williams wrote:
>>>> Al Boldi wrote:
>>>>>>>> Control parameters for the scheduler can be read/set via files in:
>>>>>>>>
>>>>>>>> /sys/cpusched/<scheduler>/
>>>>> The default values for spa make it really easy to lock up the system.
>>>> Which one of the SPA schedulers and under what conditions?  I've been
>>>> mucking around with these and may have broken something.  If so I'd
>>>> like to fix it.
>>> spa_no_frills, with a malloc-hog less than timeslice.  Setting
>>> promotion_floor to max unlocks the console.
>> OK, you could also try increasing the promotion interval.
> 
> Seems that this will only delay the lock in spa_svr but not inhibit it.

OK. But turning the promotion mechanism off completely (which is what 
setting the floor to the maximum) runs the risk of a runaway high 
priority task locking the whole system up.  IMHO the only SPA scheduler 
where it's safe for the promotion floor to be greater than MAX_RT_PRIO 
is spa_ebs.  So a better solution is highly desirable.

I'd like to fix this problem but don't fully understand what it is. 
What do you mean by a malloc-hog?  Would it possible for you to give me 
an example of how to reproduce the problem?

> 
>> It should be noted that spa_no_frills isn't really expected to behave
>> very well as it's a pure round robin scheduler.
> 
> It's a bare bone scheduler that allows to prioritize procs to the admins 
> desire, instead of leaving the priority management to the scheduler, which 
> may be undesirable for some but not all.

OK.  But it's important to realize that "nice" does not (in general) 
control the "amount of CPU" that tasks get with this scheduler.  It 
merely controls the order in which runnable tasks run i.e. it's a 
"priority based" interpretation of "nice" not an "entitlement based" 
interpretation.  The difference is important.

If you want a "bare bones" scheduler with an "entitlement based" 
interpretation of "nice" use spa_ebs with the maximum bonuses set to 
zero.  In that state spa_ebs is safe for promotion to be completely 
disabled unless you also want to use cpu caps (in which case you'd need 
to set the floor to about 137 to make sure that capped tasks don't get 
completely starved).

> 
>> It's intended purpose is as a basis for more sophisticated schedulers.
> 
> And that's why the same problem exists in the child scheds, i.e. spa_ws, 
> spa_svr, zaphod, but not spa_ebs.

OK.

> 
>> I've been thinking
>> about removing it as a bootable scheduler and only making its children
>> available but I find it useful to compare benchmark and other test
>> results from it with that from the other schedulers to get an idea of
>> the extra costs involved.

Thanks,
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
