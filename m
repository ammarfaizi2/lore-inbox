Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263211AbUCTDTd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 22:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbUCTDTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 22:19:33 -0500
Received: from holomorphy.com ([207.189.100.168]:59270 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263211AbUCTDTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 22:19:31 -0500
Date: Fri, 19 Mar 2004 19:18:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-ID: <20040320031843.GY2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
	haveblue@us.ibm.com, hch@infradead.org
References: <1079651064.8149.158.camel@arrakis> <20040318165957.592e49d3.pj@sgi.com> <1079659184.8149.355.camel@arrakis> <20040318175654.435b1639.pj@sgi.com> <1079737351.17841.51.camel@arrakis> <20040319165928.45107621.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319165928.45107621.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Matt Dobson wrote:
>> Sounds like a good idea.  We certainly shouldn't be passing huge masks
>> on the stack, but for small masks like, i dunno, <= 4 ULs (the same
>> optimization Bill's code makes) it's no problem.

On Fri, Mar 19, 2004 at 04:59:28PM -0800, Paul Jackson wrote:
> Don't we have quite a few places with one, two, even three local variables
> of type cpumask_t?  Which live on the stack?  For all mask implementations?
> Grep around for "cpumask_t.*,.*," and many of the lines you see appear to
> be declarations of such local cpumask_t variables.

The stack footprint of cpumasks is a concern in general. I don't have a
good answer to this. The half-answer I anticipate is that the truly
larger systems will configure themselves with deeper stacks. There isn't
truly a good answer to this. It's overhead for the larger systems, and
heap allocation would be overhead for smaller systems. Unfortunately,
our general design criteria require the larger systems to eat the
overhead until something imaginative is come up with to reduce the
overhead with low code impact and no cost to smaller systems. One thing
that would help is more expressiveness in the API; it's not entirely
clear how to better 3-address code, but OTOH, reducing the number of
intermediate operands is conceivable and would alleviate those overheads.


On Fri, Mar 19, 2004 at 04:59:28PM -0800, Paul Jackson wrote:
> And we need to be careful of converting pass by value semantics for small
> cpumasks into pass by reference semantics for large cpumasks, as a hidden
> feature of the implementation.  One could code some cute bugs that way.
> Better, I think, to provide a reasonably rich set of mask ops, so that the
> using code need not have anymore than the essential number of distinctly
> different masks hanging around at once in order to write clear code.

This is one of the areas where I believe I carried out some innovation.
cpumask_const_t allows more aggressive conversion to call-by-reference
in a safe manner as the constancy of the reference makes the difference
purely operational. It falls down only in scenarios where the input
would be modified. Also, when the argument is actually expected to be
modified, direct call by reference can be used. So only in the case
where a temporary copy is truly required are you forced to do it
(apart from getting the function prototype merged), and the fallback of
cpumask_const_t to call by value in the small case makes it cheap for
smaller machines also, by avoiding the indirection.

It may be worth investigating analogues of cpumask_const_t for more
generic bitmask types (though of course I'm not going to insist on a
force fit).


-- wli
