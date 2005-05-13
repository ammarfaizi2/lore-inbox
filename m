Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVEMAno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVEMAno (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 20:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVEMAno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 20:43:44 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:17029 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262179AbVEMAnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 20:43:42 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: george@mvista.com
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Date: Thu, 12 May 2005 17:43:46 -0700
User-Agent: KMail/1.8
Cc: Jesse Barnes <jesse.barnes@intel.com>, vatsa@in.ibm.com,
       Tony Lindgren <tony@atomide.com>, Lee Revell <rlrevell@joe-job.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, schwidefsky@de.ibm.com,
       jdike@addtoit.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <20050507182728.GA29592@in.ibm.com> <200505121435.01011.jesse.barnes@intel.com> <4283D581.9070008@mvista.com>
In-Reply-To: <4283D581.9070008@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505121743.46313.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 12, 2005 3:15 pm, George Anzinger wrote:
> The timers that cause the problem are the ones that only run when the
> task is active.  These are the slice timer, the profile timer
> (ITIMER_PROF), the execution limit timer and the settime timer that
> is relative to execution time (ITIMER_VIRTUAL).

ITIMER_PROF could simply be ignored if the task it corresponds to isn't 
active when it fires, so it wouldn't incur any overhead.  
ITIMER_VIRTUAL sounds like it would uglify things though, and of course 
unused timer slice interrupts would have to be cleared out.

> Again, we can colapse all these to one, but still it needs to be
> setup when the task is switched to and removed when it is switched
> away.

Right, I see what you're saying now.  It's not as simple as I had hoped.

> Timers that run on system time (ITIMER_REAL) stay in the list even
> when the task is inactive.

Right, they'll cause the task they're associated with to become runnable 
again, or get a signal, or whatever.

> I think there is already an IPI to tell another cpu that it has work.
>  That should be enough.  Need to check, however.  From the VST point
> of view, any interrupt wake the cpu from the VST sleep, so it need
> not even target the scheduler..

But in this case you probably want it to, so it can rebalance tasks to 
the CPU that just woke up.

Jesse
