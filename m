Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbUDFGIm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 02:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUDFGIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 02:08:42 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:13525 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263628AbUDFGIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 02:08:39 -0400
Date: Mon, 5 Apr 2004 23:06:01 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, colpatch@us.ibm.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-Id: <20040405230601.62c0b84c.pj@sgi.com>
In-Reply-To: <1081227547.15274.153.camel@bach>
References: <20040329041253.5cd281a5.pj@sgi.com>
	<1081128401.18831.6.camel@bach>
	<20040405000528.513a4af8.pj@sgi.com>
	<1081150967.20543.23.camel@bach>
	<20040405010839.65bf8f1c.pj@sgi.com>
	<1081227547.15274.153.camel@bach>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 [[ I removed Dave Hansen <haveblue@us.ibm.com> from the Cc list - per his Mar 29 request. ]]

> > My mask patch does this., haveblue@us.ibm.com
> 
> Yes, which is why I'm such a fan.

Glad to be of service ...


> > That boils down to a very straightforward question.  Do we ask
> > them to write:
> > 
> > 	cpus_or(s.bits, d1.bits, d2.bits)
> > 
> > or:
> >     ...
> 
> Well, you'd do presumably:
> 	cpus_or(&s, &d1, &d2);

Argh - I was being sloppy.  I meant to write just what we have now:

	cpus_or(d, s1, s2);

 - trivial typo fix - my dst and src were backwards
 - more significant - no ".bits", no "&"

A patch that goes through 300 lines of kernel source code adding one to
three ampersands per line strikes me as ugly and pointless.  Hopefully
it was just my sloppiness that led to such a possibility, not a seriously
proposed change on your part.


> And make cpus_or() an inline so you get typechecking.

Yes - typechecking in this situation is good.


> You'll have covered about 300 of them.  I don't think a complete
> abstraction is actually required or desirable:

I suspect we've hit on our first area of actual disagreement here.

You observe that providing inline wrappers for the 5 most commonly
used cpumask macros would cover 300 of the 420 uses.  The other 23
or so macros are less commonly used.  Sounds about right ...

I prefer to provide all 28 macros.  I don't see a cost, but do see
a gain.

The gain is that someone coding some operations on a cpumask doesn't
have to go fishing around in multiple places to find out what ops
are supported, which ops are in nice "cpus_*" form, and which are
obtained by accessing the underling bitmap/bitop operations.

Doing only 5 of the 28, because the other 23 are less frequently used,
seems to me like a false optimization.  Either provide no cpumask
abstraction, or provide a more-or-less complete one.  Half baked layers
create further overload on my limited brain capacity.

Also eliminating the 23 less frequently used cpumask operations would
generate another ugly and pointless kernel patch, recoding another
120 lines of code (usually arch specific, sometimes touchy, difficult
to get tested, and likely to break someone in ways not obvious at first).

Just to be specific, a typical implementation for such an operator would look like:

    typedef struct { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;

    static inline void cpus_or(cpumask_t d, const cpumask_t s1, const cpumask_t s2)
    {
	bitmap_or(d.bits, s1.bits, s2.bits, NR_CPUS);
    }

It would be used exactly as it is today:

    cpumask_t x, y, z;
    cpus_or(x, y, z);

Other than perhaps changing "cpumask_t foo;" to "struct cpumask foo", I
don't see anything in the 420 lines of code that invokes cpumask
operations that I think would gain from wholesale changes.

So ... tell me again what is to be gained by discarding 23 of the 28
cpumask operators?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
