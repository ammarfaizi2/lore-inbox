Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUCSBUo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 20:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbUCSBUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 20:20:44 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:13543 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261914AbUCSBUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 20:20:41 -0500
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com, hch@infradead.org
In-Reply-To: <20040318165957.592e49d3.pj@sgi.com>
References: <1079651064.8149.158.camel@arrakis>
	 <20040318165957.592e49d3.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1079659184.8149.355.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 18 Mar 2004 17:19:44 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 16:59, Paul Jackson wrote:
> Your nodemask_t reminds me of something I posted to linux-ia64 last
> November 7, 2004, under the subject: "[PATCH preview] Adds nodemask_t
> for use in cpusets (NUMA memory placement)".
> 
> Chris Hellwig responded to it at the time asking why I didn't provide a
> single generic mask ADT, and make cpumask and nodemask instances of
> that.

That is a better idea, if it can be made to work.  My goal is to stop
the proliferation of open-coded references to node details as soon as
possible.  If we we nip this behavior in the bud and convert all users
of cpu/node data to cpumask_t/nodemask_t, we can (more) easily change
the underlying details of how all the cpumask and nodemask functions
work later.  If the users all call our macros, then it's easy to find
them ('grep -r "nodes_and" *' vs searching for every '&' in the kernel
that may or may not be a node or cpu mask) and test them.

> I coded that up, but then got distracted.  The remaining issue for which
> I didn't have a good answer was that my proposal would break the optimum
> handling for sparc64 or other systems that didn't handle passing
> structures on the stack efficiently.
> 
> Bill Irwin was a party to my discussions of that effort, so I presume
> that if he felt it had further merit, he would have mentioned it to
> you, Matthew.

He never mentioned it to me when I queried him for details on his
cpumask_t implementation...

> Could one of you, Bill or Matthew, speak to why this generic mask ADT,
> underlying both cpumask and nodemask, should not be pursued further,
> instead of duplicating the various details of cpumask, after a global
> s/cpu/node/g change?

Nope.  I think it should.  Though it is hard to optimize for generic
masks.  We've got the bitmap_* functions which work nicely for unsigned
long[].  These (cpumask_t/nodemask_t) are nice because they are
optimized for edge cases (UP for cpumask_t and Non-NUMA for nodemask_t)
as well as for long mask cases (passing by structs reference).  It's
hard to make those types of optimizations on generic masks.

> I am attaching the header file include/linux/mask.h for my current
> version of this mask.h, in case someone reading wants more specifics of
> what it is that I am referring to.
> 
> This version almost certainly does _not_ work on big endian 64 systems,
> due to my ignorance of how kernel bitmasks were layed out when I last
> worked on this mask.h header.  Unlike the sparc64 performance issues
> with passing structs on the stack, I would hope that the big/little
> endian issues could be fixed without messing things up too much.
> 
> If this mask.h could actually be made to work, including on sparc64,
> then it would seem to be a much cleaner solution.  With it, we would
> define cpumask_t and nodemask_t as simply:
> 
>   typedef __mask(NR_NODES) nodemask_t;
>   typedef __mask(NR_CPUS) cpumask_t;
> 
> and either use operations such as mask_and() on both, or if one insisted
> on keeping operations that specifically called out cpumask, add some
> 15 trivial defines such as:
> 
>   #define cpumask_and(dst, src1, src2) mask_and(dst, src1, src2)

I'll look it over and see how it looks.  As I said, I'm very much for a
generic mask type if we can do it properly and efficiently.

Cheers!

-Matt

