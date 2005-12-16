Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbVLPUHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbVLPUHS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 15:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVLPUHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 15:07:17 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:426 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751335AbVLPUHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 15:07:16 -0500
Date: Fri, 16 Dec 2005 12:06:51 -0800
From: Paul Jackson <pj@sgi.com>
To: paulmck@us.ibm.com
Cc: akpm@osdl.org, dada1@cosmosbay.com, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, Simon.Derr@bull.net, ak@suse.de,
       clameter@sgi.com
Subject: Re: [PATCH 04/04] Cpuset: skip rcu check if task is in root cpuset
Message-Id: <20051216120651.cb57ad2e.pj@sgi.com>
In-Reply-To: <20051216175201.GA24876@us.ibm.com>
References: <20051214084031.21054.13829.sendpatchset@jackhammer.engr.sgi.com>
	<20051214084049.21054.34108.sendpatchset@jackhammer.engr.sgi.com>
	<20051216175201.GA24876@us.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul wrote:
> So I am not convinced that this optimization is worthwhile.

Nice analysis - thanks.

I read from your analysis that, except on alpha, we're down to
so little that it's going to be difficult on PREEMPT kernels to
discern a clear difference, and on non-PREEMPT kernels, the
rcu read lock is a no-op, so definitely not worth trying to
optimize away.

On the ia64 sn2_defconfig kernel (which is CONFIG_PREEMPT and
CONFIG_DEBUG_PREEMPT, and is the one I happen to care most about) I see
one short branch with this optimization, versus two calls, to the
add_preempt_count() and sub_preempt_count() routines, if I don't have
this optimization.  These two *_preempt_count() routines in
kernel/sched.c generate 172 lines of assembly code, containing
several branches, due to the BUG checks.

So in that case (obviously not one of the cases with a huge installed
base ;) this optimization seems well worth it.  One short branch is
cheaper than two subroutine calls to a couple of pages of code.

I can easily accept either way on this one - keeping or removing this
optimization.  And it involves tradeoffs that vary by architecture and
configuration, but that aren't (so far as I know) worth custom per-arch
optimized code.

I'd slightly prefer to leave this optimization in, on the grounds that
it makes a worthwhile (albeit modest) improvement in the cases, and is
only trivially worse (an added short branch) in other cases.

What's your recommendation, Paul?  You have far more experience here than I.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
