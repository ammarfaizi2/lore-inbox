Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUCZXVW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 18:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUCZXVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 18:21:22 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:38107 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261421AbUCZXVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 18:21:16 -0500
Date: Fri, 26 Mar 2004 15:18:54 -0800
From: Paul Jackson <pj@sgi.com>
To: "David S. Miller" <davem@redhat.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org,
       wli@holomorphy.com
Subject: Re: Sparc64, cpumask_t and struct arguments (was: [PATCH] Introduce
 nodemask_t ADT)
Message-Id: <20040326151854.6c5fd5c3.pj@sgi.com>
In-Reply-To: <20040326145423.74c1ce52.davem@redhat.com>
References: <20040320031843.GY2045@holomorphy.com>
	<20040320000235.5e72040a.pj@sgi.com>
	<20040320111340.GA2045@holomorphy.com>
	<20040322171243.070774e5.pj@sgi.com>
	<20040323020940.GV2045@holomorphy.com>
	<20040322183918.5e0f17c7.pj@sgi.com>
	<20040323031345.GY2045@holomorphy.com>
	<20040322193628.4278db8c.pj@sgi.com>
	<20040323035921.GZ2045@holomorphy.com>
	<20040325012457.51f708c7.pj@sgi.com>
	<20040325101827.GO791@holomorphy.com>
	<20040326143648.5be0e221.pj@sgi.com>
	<20040326145423.74c1ce52.davem@redhat.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  5) The cpu_clear(i, mask) on about line 534 of smp.c confuses me, as it
> >     seems to be changing a local copy of 'mask' that no one will examine
> >     later.  What purpose does it serve?  See this line annotated with
> >     "No affect??" in the changes, below.
> 
> No, mask is the top level mask value, we assign it to local variable
> in order to do this or that operation on it.  Once we've really send
> the XCALL message to the processor, we clear it in 'mask' only then.

Yes - I see where the input argument 'mask' is assigned to 'work_mask',
and then 'work_mask' is manipulated during the loops.

But inside the last loop of cheetah_xcall_deliver(), after 'mask' has
been read the last time to initialize 'work_mask', it is repeatedly
updated with the lines:

					if ((dispatch_stat & check_mask) == 0)
						cpu_clear(i, mask);

Why, why?  Can't these two lines just be _removed_?

What earthly purpose does that 'cpu_clear(i, mask)' have?

That copy of 'mask' will never be used again, at least not that I can see.

There's even a comment a few lines above, seemingly related to this:

			/* Clear out the mask bits for cpus which did not
			 * NACK us.
			 */

But that doesn't address the "why".

And then, if these two lines can be removed for lack of affect, the six
lines just before, that setup 'check_mask', can go too, also for lack of
any remaining affect.

That would be eight lines of dead code, with three lines of commentary.

Sorry - I must be missing something somewhere.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
