Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292800AbSCNPTa>; Thu, 14 Mar 2002 10:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311148AbSCNPTV>; Thu, 14 Mar 2002 10:19:21 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:43242 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292800AbSCNPTR>;
	Thu, 14 Mar 2002 10:19:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: futex and timeouts
Date: Thu, 14 Mar 2002 10:19:48 -0500
X-Mailer: KMail [version 1.3.1]
Cc: matthew@hairy.beasts.org, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
In-Reply-To: <E16lMef-00022r-00@wagner.rustcorp.com.au>
In-Reply-To: <E16lMef-00022r-00@wagner.rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020314151846.EDCBF3FE07@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 March 2002 11:15 pm, Rusty Russell wrote:
> In message <20020313182552.945523FE06@smtp.linux.ibm.com> you write:
> > Ulrich, it seems to me that absolute timeouts are the easiest to do.
> >
> > (a) expand by additional parameter (0) means no timeout desired
> > (b) differentiate the schedule call in futex_down..
> >
> > Question is whether the granularity of jiffies (10ms) is sufficiently
> > small for timeouts.....
>
> 1) You must not export jiffies to userspace.
>
> 2) They are not a time, they are a counter, and they do wrap.
>
> 3) This does not handle the settimeofday case: you need to check in
>    userspace for that anyway.
>
> So, since you need to check if you're trying to sleep for longer than
> (say) 49 days, AND you need to check if you are after the given
> abstime in userspace anyway (settimeofday backwards), you might as
> well convert to relative in userspace.
>
> Sorry,
> Rusty.

3) I think one of us is misunderstanding (its probably me)

What I was proposing was a relative wall clock time, vs application virtual 
time. 

interface would be to always specify in futex how long to wait (relative) and 
not until when to wait (absolute).
What I propose is not to export jiffies (ofcourse not), but either usecs or 
msecs and whether one should state what the minimum wait time is.
Right now we know it can't be less then 10ms (x86) unless we busywait and
above that the granularity will be in 10ms increments.

So from the previous post of code example, one has to add the conversion from
timeout to timeout_jiffies.
Also we need to determine the best API for this. Somebody (Rusty ?) suggest to
pass a pointer to (struct timeval) vs a single counter. Only disadvantage is 
an additional copy_from_user, but it gives much bigger timeouts.

I think its a good idea to add it.
-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
