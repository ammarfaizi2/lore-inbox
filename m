Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbUKVXlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUKVXlo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUKVXjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:39:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:25555 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262453AbUKVXis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:38:48 -0500
Message-ID: <41A278AB.2050608@sgi.com>
Date: Mon, 22 Nov 2004 17:39:23 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, holt@sgi.com,
       Dean Roe <roe@sgi.com>, Brian Sumner <bls@sgi.com>,
       John Hawkes <hawkes@tomahawk.engr.sgi.com>
Subject: Re: [Lse-tech] scalability of signal delivery for Posix Threads
References: <200411222127.iAMLRtN7020062@owlet.beaverton.ibm.com>
In-Reply-To: <200411222127.iAMLRtN7020062@owlet.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley wrote:
> So with CLONE_SIGHAND, we share the handler assignments and which signals
> are blocked, but retain the ability for individual threads to receive
> a signal.  And when all of them receive signals in quick succession,
> we see lock contention because they're sharing the same (effectively)
> global lock to receive all of their (effectively) individual signals
> .. is that correct?
> 

Yes, I think that's whats happening, except that I think the blocked
signal list is per thread as well.  The shared sighand structure just
has the saved arguments from sigaction, as I remember.   (It's confusing:
the set of signals blocked during execution of the signal handler is
part of the sigaction structure and hence is global to the entire
thread group, whilst the set of signals blocked in general is per thread.)

> Are you contending on tasklist_lock, or on siglock?

Definately: siglock.  All of the profiling ticks occur at
unlock_irqrestore(&p->sighand->siglock) in the routines I
mentioned before.  [we don't have NMI profiling on Altix...
so profiling typically can't look inside
of code sections with interrupts suspended.]

> 
>     It seems to me that scalability would be improved if we moved the
>     siglock from the sighand structure to the task_struct.
> 
> Only if you want to keep its current semantics of it being a lock for
> all things signal.  Finer granularity would, it seems at first look,
> afford you the benefits you're looking for.  (But not without the cost of
> a fair amount of work to make sure the new locks are utilized correctly.)
> For the problem you're describing, it sounds like the contention is occuring
> at delivery, so a new lock for pending, blocked, and real_blocked might be
> in order.
> 
> Rick
> 

Yes, I was hoping to keep the current semantics of siglock as the lock for
all things signal, just make it local per thread, and require that all of the
siglocks be held to change the sighand structure.  That seemed like a change I
could manage.  My personal notion was that the slowdown of sigaction()
processing for multi-threaded POSIX programs was not that big of deal because
it doesn't happen very often, and for non-CLONE_SIGHAND threads the additional
cost would be minor.  But if the slowdown in the CLONE_SIGHAND case is not
acceptable then I'm stuck as to how to do this

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
