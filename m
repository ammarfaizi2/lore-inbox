Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbUCSXE2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263133AbUCSXE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:04:28 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:10914 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263098AbUCSXDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:03:22 -0500
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, akpm@osdl.org,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>, hch@infradead.org
In-Reply-To: <20040318175654.435b1639.pj@sgi.com>
References: <1079651064.8149.158.camel@arrakis>
	 <20040318165957.592e49d3.pj@sgi.com> <1079659184.8149.355.camel@arrakis>
	 <20040318175654.435b1639.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1079737351.17841.51.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 19 Mar 2004 15:02:32 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 17:56, Paul Jackson wrote:
> > These (cpumask_t/nodemask_t) are nice because they are
> > optimized for edge cases (UP for cpumask_t and Non-NUMA for nodemask_t)
> > as well as for long mask cases (passing by structs reference). 
> 
> When I looked at the assembly code generated on my one lung i386 box for
> native gcc 3.3.2, it looked pretty good (to my untrained eye) using a
> struct of an array of unsigned longs, both for the single unsigned long
> (<= 32 bits) and multiple unsigned long cases.

The code you wrote, or my patch?

> Except for the sparc64 guys and their friends who disparage passing
> structs on the stack, I conjecture that the single implementation of a
> struct of an array of unsigned longs is nearly ideal for all
> architectures.
> 
> ... go ahead ... prove me wrong.  It probably won't be hard ;).

Sounds like a good idea.  We certainly shouldn't be passing huge masks
on the stack, but for small masks like, i dunno, <= 4 ULs (the same
optimization Bill's code makes) it's no problem.

The thing about code specific to node and cpu masks is that we *know*
what the masks we're manipulating are used for, and that lets us do
things like not letting callers set bits other than 0 on UP cpumasks, or
throwing a BUG when they do.  Or optimizing first_node() to be smarter
than just calling find_first_set() on the passed in mask by just
checking whether bit 0 is set.

-Matt

