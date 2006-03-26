Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWCZEM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWCZEM2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 23:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWCZEM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 23:12:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:45223 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932094AbWCZEM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 23:12:27 -0500
Date: Sat, 25 Mar 2006 20:10:09 -0800
From: Paul Jackson <pj@sgi.com>
To: vatsa@in.ibm.com
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, mingo@elte.hu,
       suresh.b.siddha@intel.com, hawkes@sgi.com, linux-kernel@vger.kernel.org,
       dino@in.ibm.com
Subject: Re: [PATCH 2.6.16-mm1 1/2] sched_domain: handle kmalloc failure
Message-Id: <20060325201009.df082c88.pj@sgi.com>
In-Reply-To: <20060326033838.GB12227@in.ibm.com>
References: <20060325082730.GA17011@in.ibm.com>
	<20060325180605.6e5bb4b9.akpm@osdl.org>
	<20060326024039.GA2998@in.ibm.com>
	<20060325184441.0f6ba5bc.akpm@osdl.org>
	<44260467.10402@yahoo.com.au>
	<20060326033838.GB12227@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vatsa wrote:
> I think even if memory allocation fails while making a cpuset exclusive,
> we would still want have the cpuset marked exclusive.

Perhaps ...

The cpuset code itself in the kernel doesn't care at all whether the
dynamic sched domain setup succeeds or not.

If the user or app that made the system call (write '1' to
cpu_exclusive) was setting cpu_exclusive to get a sched domain,
they would want to know if it failed.  If they were looking for one
of the other consequences of an exclusive cpuset, then such an error
is possibly confusing noise.

I keep wishing I had made a separate per-cpuset flag to mark a
cpuset as defining a dynamic sched domain.  Had I done that, I would
definitely want to pass back an error in this case.

But even if the user/app isn't interested in this failure case,
probably the 'good kernel citizen' choice is to report it.  The kernel
should report errors to fail to accomplish requested tasks, and not
second guess whether the user actually cares about that error.

And if we do report an error back to userland, then the request to
set cpuset_exclusive needs to fail entirely, not setting it at all.

So ... bottom line ... when and if it becomes convenient to do so,
have the kernel/sched.c:partition_sched_domains() routine return
an error instead of void.  Then sometime later on, I can change the
cpuset code to pick up that error, unravel the cpu_exclusive setting,
and pass back the error.

But take your sweet time doing this -- no hurry here.

And if you decide it isn't worth the code or effort to do this,
I will gladly forget the whole thing.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
