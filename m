Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVHVW4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVHVW4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVHVW4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:56:54 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:39641 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751439AbVHVW4p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:56:45 -0400
Subject: Re: FW: [RFC] A more general timeout specification
From: john stultz <johnstul@us.ibm.com>
To: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, joe.korty@ccur.com,
       george@mvista.com, inaky.perez-gonzalez@intel.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <17129.35821.291322.504723@sodium.jf.intel.com>
References: <20050518201517.GA16193@tsunami.ccur.com>
	 <17129.35821.291322.504723@sodium.jf.intel.com>
Content-Type: text/plain
Date: Mon, 22 Aug 2005 15:56:37 -0700
Message-Id: <1124751398.22195.130.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 18:52 -0700, Inaky Perez-Gonzalez wrote:
> The main user of this new inteface is to allow system calls to get
> time specified in an absolute form (as most of POSIX states) and thus
> avoid extra time conversion work.
> 
> There was a short thread about it, available at google groups
> (grepping for the subject).
> 
> http://groups-beta.google.com/groups?q=a+more+general+timeout+specification
> 
> Thanks!
> 
> [ for comment only ]
> 
> The fusyn (robust mutexes) project proposes the creation
> of a more general data structure, 'struct timeout', for the
> specification of timeouts in new services.  In this structure,
> the user specifies:
> 
>     a time, in timespec format.
>     the clock the time is specified against (eg, CLOCK_MONOTONIC).
>     whether the time is absolute, or relative to 'now'.
> 
> That is, all combinations of useful timeout attributes become
> possible.
> 
> Also proposed are two new kernel routines for the manipulation
> of timeouts:
> 
> 	timeout_validate()
> 	timeout_sleep()
> 
> timeout_validate() error-checks the syntax of a timeout
> argument and returns either zero or -EINVAL.  By breaking
> timeout_validate() out from timeout_sleep(), it becomes possible
> to error check the timeout 'far away' from the places in the
> code where we would actually do the timeout, as well as being
> able to perform such checks only at those places we know the
> timeout specification is coming from an unsafe source.
> 
> timeout_sleep() puts the caller to sleep until the
> specified end time is in the past, as measured against
> the given clock, or until the caller is awakened by other
> means (such as wake_up_process()).  Like schedule_timeout(),
> TASK_INTERRUPTIBLE or TASK_UNINTERRUPTIBLE must be set ahead
> of time; if TASK_INTERRUPTIBLE is set then signals will also
> break the caller out of the sleep.
> 
> timeout_sleep() returns either 0 (returned early) or -ETIMEDOUT
> (returned due to timeout).  It is up to the caller to resolve,
> in the "returned early" case, why it returned early.
> 
> Timeout_sleep has a return argument, endtime, which is also in
> 'struct timeout' format.  If the input time was relative, then
> it is converted to absolute and returned through this argument.
> This can be used when an early-terminated service must be
> restarted and side effects of the early termination-n-restart
> (such as end time drift) are to be avoided.


Hey Inaky, Joe,

	Sorry for the terribly slow response. I haven't really dealt too much
with the user-space interfaces for the posix clocks and timers, so I'm
no authority on it. Being able to use absolute values does seem very
important to me, as well as avoiding having glibc make the conversion
using gettimeofday() so that part looks good. I'm not completely sold on
why the validate interface is needed, but I didn't hear any objections
from George, so I'd defer to those who deal more with those interfaces.


Sorry for the lack of insight, although since I haven't heard much on
this recently, maybe this will help stir up the debate?

Nish, do you have any comments on this idea?

thanks
-john


