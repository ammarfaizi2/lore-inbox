Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265808AbUHALVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUHALVr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 07:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbUHALVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 07:21:46 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:25011 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265808AbUHALVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 07:21:24 -0400
Date: Sun, 1 Aug 2004 04:20:53 -0700
From: Paul Jackson <pj@sgi.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matthew Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
Message-Id: <20040801042053.06b33060.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0408010316590.4095@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com>
	<20040731232126.1901760b.pj@sgi.com>
	<Pine.LNX.4.58.0408010316590.4095@montezuma.fsmlabs.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane wrote:
> NR_CPUS was 3, the test case may as well be passing first_cpu or next_cpu
> a value of 0 for the map.

So, if NR_CPUS is 3, and you pass an empty map to any_online_cpu()
on an i386, you get back not 3, as expected, but 32 ??

And this is because find_next_bit(0, 3, 0), for example, returns 32,
correct ??

Well ... no ... I must not be guessing your example right yet.  Because
in the above example, first_cpu(0) will (should ?) return with NR_CPUS,
and the for_each_cpu_mask() inside any_online_cpu() will end there.

Could you give me the rest of the numbers in a specific example?

Please ...

Hmmm ... perhaps you're saying you're passing a non-zero map to
any_online_cpu(), but that the bits set in what you pass aren't
online, which would end up calling find_next_bit().  Yeah - that
must be it.

And indeed the i386 find_next_bit() code can't possibly be honoring a
size < 32, because it doesn't even consider the size value until it has
finished the first word without finding a set bit in the last 32-offset
bits.


> The "bug" in the i386 find_next_bit really
> looks like a feature if you look at the code.

What code, what feature, what bug ...  Please be specific.

Are you referring to the apparent (if I am reading the code for
find_next_bit in arch/i386/lib/bitops.c correctly) behaviour
of this find_next_bit() that it's really only coded for size
some multiple of 32?

If so, then wouldn't whether this is a bug or a feature depend on what
the other arch's do, and what (if there is anyway to know) was intended,
and on what other code is expecting, and on what in the long term
will be the least surprising behaviour, resulting in fewest bugs?

That is, are bitmaps only really supposed to work for integral
multiples of unsigned longs, or are they supposed to honor fractional
long sizes?

A quick look at some other arch's find_next_bit() leads me to suspect
that they _do_ handle fractional long sizes, unlike i386.  And it
was certainly my expectation that they should do so (returning,
for example, 3, not 32, on an empty mask if called with size == 3).
These routines _do_ take a size that is a bit count, and I don't
recall seeing any big hairy warnings that size better be a multiple
of BITS_PER_LONG.

If all this is so, then i386 find_next_bit() is wrong.  Possibly other
some arch's too -- it's not code that I can read easily.

If not, then in addition to fixing cpumask.h, we'd better also consider
whether we need to fix:

    drivers/atm/lanai.c:
		vci = find_next_bit(lp, NUM_VCI, vci + 1);
    include/linux/nodemask.h:
		return find_next_bit(srcp->bits, nbits, n+1);
    kernel/sched.c:
		idx = find_next_bit(array->bitmap, MAX_PRIO, idx);
    lib/idr.c:
		m = find_next_bit(&bm, IDR_SIZE, n);
    mm/mempolicy.c:
		next = find_next_bit(policy->v.nodes, MAX_NUMNODES, 1+nid);
    mm/mempolicy.c:
		nid = find_next_bit(pol->v.nodes, MAX_NUMNODES, nid+1);

Adding Matthew Dobson to this thread - since his new nodemask.h
gets hit with this alot harder than cpumask.h, because it is more
common to have a nodemask that isn't a multiple of a long in size.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
