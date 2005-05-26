Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVEZU1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVEZU1l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 16:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVEZU1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:27:40 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:23970 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261653AbVEZU1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:27:30 -0400
Date: Thu, 26 May 2005 13:07:13 -0700
From: Paul Jackson <pj@sgi.com>
To: Simon Derr <Simon.Derr@bull.net>
Cc: akpm@osdl.org, dino@in.ibm.com, torvalds@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4] cpuset exit NULL dereference fix
Message-Id: <20050526130713.2be9bed8.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0505261050480.11050@openx3.frec.bull.fr>
References: <20050526082508.927.67614.sendpatchset@tomahawk.engr.sgi.com>
	<Pine.LNX.4.61.0505261050480.11050@openx3.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon wrote:
> I feel like this 'scaling problem' still exists even with:

Can you back this feeling with numbers, with real measurements?

I'll bet it's not actually a problem for any size system or load you
care about.

I have not yet actually seen any measurements that taking a quick
semaphore in the exit path is a scaling problem.

Until I see such a problem, I am hoping to only take the most simple and
basic precautions to avoid it.


> Maybe adding more per-cpuset data such as a per-cpuset removal_sem

Robin suggests more possibilities along this same line, in his reply.

I don't see where any further locks are needed.  And for some of my
customers configurations, running with the majority of the system in a
single cpuset, per-cpuset locks aren't a big gain over a system wide
semaphore anyway.

We have two issues here:

 1) After the exiting task releases its cpuset (decrements the cpuset
    reference count), we may need the cpusets 'notify_on_release' flag
    and its path in the cpuset filesystem, if the count went to zero,
    in order to perform notify_on_release processing.

    For the benefit of those who haven't memorized the kernel/cpuset.c
    code, notify_on_release processing means calling a usermodehelper
    to invoke the /sbin/cpuset_release_agent command, with the path
    of the just released cpuset as a command line argument.  This /sbin
    script usually just does "rmdir /dev/cpuset/$1", removing the abandoned
    cpuset.

 2) We have two distinct ways of marking a cpuset 'in use'.  The tasks
    that point to a cpuset increment its reference 'count'.  The children
    cpusets of that cpuset put themselves on the 'children' list of that
    cpuset.  

    The problem is that we cannot atomically examine both ways at the
    same time, using the mechanisms in the code now, except by holding
    the global cpuset_sem semaphore.

So far as we know, both of these two issues are only causing us grief in
the exit code (cpuset_exit).  Everywhere else that it might matter, we
are far enough off the beaten code path that grabbing the global
cpuset_sem is no problem.

Perhaps we could solve issue (A) by having the cpuset_exit code bundle
up in local variables whatever information it might need from the
cpuset, before decrementing the count, for possible notify_on_release
processing.  Then if the atomic_dec_and_test hits the zero count,
the cpuset_exit code will be able to process the notify_on_release
requests, without further referencing the cpuset.

Perhaps we can solve issue (B) by having child cpusets _also_ bump the
atomic reference count.  Then when the count hits zero, it will mean
both that there are no more referencing tasks and that there are no
child cpusets.  With this, we can atomically identify when a cpuset is
released, without holding the global cpuset_sem semaphore.


So ... I'm inclined to think that there is really no scaling problem
with this patch as proposed.  But if there really is a scaling problem,
I'd next persue solution steps (A) and (B) above, before attempting
per-cpuset locks.


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
