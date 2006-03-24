Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932609AbWCXL5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbWCXL5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 06:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422708AbWCXL5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 06:57:15 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:22220 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1422724AbWCXL5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 06:57:14 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
Date: Fri, 24 Mar 2006 22:56:59 +1100
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
References: <1143198208.7741.8.camel@homer> <1143198459.7741.14.camel@homer> <1143198964.7741.23.camel@homer>
In-Reply-To: <1143198964.7741.23.camel@homer>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 2549
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200603242256.59795.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 22:16, Mike Galbraith wrote:
> This patch does various interactivity cleanups.

I have trouble with this patch. By your own admission this patch does 4 
different things which one patch shouldn't.

> 1.  Removes the barrier between kernel threads and user tasks wrt
> dynamic priority handling.

This is a bad idea. Subjecting a priority ceiling to kernel threads because 
they spend a long time idle is not the same as a user task that may be an 
idle bomb. Most kernel threads do sleep for extended periods and will always 
end up hitting this ceiling. That could lead to some difficult to understand 
latencies in scheduling of kernel threads, even if they are nice -5 because 
they'll expire very easily.

> 2.  Removes the priority barrier for IO.

Bad again. This caused the biggest detriment on interbench numbers and is by 
far the most palpable interactivity killer in linux. I/O hurts us lots and 
this change will be very noticeable.

> 3.  Treats TASK_INTERACTIVE as a transition point that all tasks must
> stop at prior to being promoted further.

Why? Makes no sense. You end up getting hiccups in the rise of priority of 
tasks instead of it happening smoothly with sleep.

> 4.  Moves division out of the fast path and into scheduler_tick().
> While doing so, tightens timeslice accounting, since it's free, and is
> the flip-side of the reason for having nanosecond sched_clock().

Seems fine.

Cheers,
Con
