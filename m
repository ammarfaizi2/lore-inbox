Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbUCTBCQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 20:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263193AbUCTBCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 20:02:16 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:13882 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263188AbUCTBCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 20:02:15 -0500
Date: Fri, 19 Mar 2004 16:59:28 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-Id: <20040319165928.45107621.pj@sgi.com>
In-Reply-To: <1079737351.17841.51.camel@arrakis>
References: <1079651064.8149.158.camel@arrakis>
	<20040318165957.592e49d3.pj@sgi.com>
	<1079659184.8149.355.camel@arrakis>
	<20040318175654.435b1639.pj@sgi.com>
	<1079737351.17841.51.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > When I looked at the assembly code generated on my one lung i386 box for
> > native gcc 3.3.2, it looked pretty good (to my untrained eye) using a
> > struct of an array of unsigned longs, both for the single unsigned long
> > (<= 32 bits) and multiple unsigned long cases.
> 
> The code you wrote, or my patch?

The code I wrote and appended yesterday.  Though, as I realize now in my
post of a few minutes ago, there are perhaps 8 places where instead of
calling various bitmap_ops() unconditionally ('and', 'or', ...) it would
be better to peel off the one-word case and inline it.


> Sounds like a good idea.  We certainly shouldn't be passing huge masks
> on the stack, but for small masks like, i dunno, <= 4 ULs (the same
> optimization Bill's code makes) it's no problem.

Don't we have quite a few places with one, two, even three local variables
of type cpumask_t?  Which live on the stack?  For all mask implementations?
Grep around for "cpumask_t.*,.*," and many of the lines you see appear to
be declarations of such local cpumask_t variables.

And we need to be careful of converting pass by value semantics for small
cpumasks into pass by reference semantics for large cpumasks, as a hidden
feature of the implementation.  One could code some cute bugs that way.

Better, I think, to provide a reasonably rich set of mask ops, so that the
using code need not have anymore than the essential number of distinctly
different masks hanging around at once in order to write clear code.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
