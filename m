Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUDFKni (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 06:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbUDFKni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 06:43:38 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:65271 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262468AbUDFKnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 06:43:35 -0400
Date: Tue, 6 Apr 2004 03:40:55 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, colpatch@us.ibm.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-Id: <20040406034055.1dbe2eac.pj@sgi.com>
In-Reply-To: <1081235999.28514.9.camel@bach>
References: <20040329041253.5cd281a5.pj@sgi.com>
	<1081128401.18831.6.camel@bach>
	<20040405000528.513a4af8.pj@sgi.com>
	<1081150967.20543.23.camel@bach>
	<20040405010839.65bf8f1c.pj@sgi.com>
	<1081227547.15274.153.camel@bach>
	<20040405230601.62c0b84c.pj@sgi.com>
	<1081233543.15274.190.camel@bach>
	<20040405234552.23f810cd.pj@sgi.com>
	<1081235999.28514.9.camel@bach>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty - thank-you very much for your constructive feedback so far.

Seems to me that we are in agreement that slimming down the
internals of cpumask_t is worth proceeding with, but not on possible
changes to the cpumask API seen by the rest of the kernel.

Following your suggestion, I have a new bitmap.c/bitmap.h working in my
workarea, that pulls in the changes I had done before in mask.h, such as
special casing bitmaps of a single word at compile time to use native C
ops.

A sample of the code in my include/linux/bitmap.h:

static inline void bitmap_and(unsigned long *d, const unsigned long *s1,
			const unsigned long *s2, int nbits)
{
	if (nbits <= BITS_PER_LONG)
		d[0] = s1[0] & s2[0];
	else
		_bitmap_and(d, s1, s2, nbits);
}

And in lib/bitmap.c, the routine that was called bitmap_and() is now
called _bitmap_and(), and is (as before) not inlined.

I will continue with the coding to remove the mask ADT header file
include/linux/mask.h from my patch set, recoding cpumask.h (and
Matthew's nodemask.h) directly on top of bitmap/bitops, and defining
cpumask_t as:

    typedef struct { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;

I'd like to table for the moment discussions of changing the cpumask API
seen by the rest of the kernel code.  Some of us like what we have, and
we don't have anything resembling a consensus on something else.  So
unless you want to agree that whatever I said is entirely right <grin>,
we lack the concensus needed to make pervasive cpumask API changes.

The above changes to the innards of cpumask will open the door to the
alternatives being considered (struct vs typedef, full vs partial vs no
extra 'cpumask' api, explicit vs implicit '&' pass by reference).

I acknowledge once again Bill Irwin's notice that this presents some
arch-specific risks.  I've done some reasonable work resolving these for
sparc, i386 and ia64.  But I still need to seek further feedback and
approval/disapproval from the arch maintainers.  My current expectation
is that any remaining arch-specific issues will be narrow enough, and
that the gains from this infrastructure cleanup are broad enough, that
we will be able to resolve the arch-specific issues without compromising
the overall cleanup.  Only time will tell for sure.

For now I expect to preserve the current implicit pass by reference that
(some of) the existing cpumask implementations used, I will preserve all
28 or so cpumask ops with their current signature, and I will likely use
a layer of static inlines to increase type safety.

That is, cpumasks will be bitmap arrays wrapped in a struct, and the ops
on them typically will be bitmap ops wrapped in inlines wrapped in macros.

I agree that there's a whole lot of wrapping going on there ... ;).

Continued feedback welcome.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
