Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263425AbUC3B2L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 20:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUC3B2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 20:28:11 -0500
Received: from holomorphy.com ([207.189.100.168]:61854 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263425AbUC3B16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 20:27:58 -0500
Date: Mon, 29 Mar 2004 17:27:44 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Paul Jackson <pj@sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       raybry@sgi.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-ID: <20040330012744.GZ791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Dobson <colpatch@us.ibm.com>, Paul Jackson <pj@sgi.com>,
	LKML <linux-kernel@vger.kernel.org>, raybry@sgi.com,
	Andrew Morton <akpm@osdl.org>
References: <20040329041253.5cd281a5.pj@sgi.com> <1080606618.6742.89.camel@arrakis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080606618.6742.89.camel@arrakis>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 04:12, Paul Jackson wrote:
>>> * The underlying bitmap.c operations such as bitmap_and() and
>>> *   bitmap_or() don't follow this model.  They don't assume
>>> *   the precondition that unused bits are zero, and they do
>>> *   mask off any unused portion of input masks in most cases.
>>> *   However the underlying bitop.h operations, such as set_bit()
>>> *   and clear_bit(), do no sanitizing of their inputs, depending
>>> *   heavily on preconditions.

On Mon, Mar 29, 2004 at 04:30:18PM -0800, Matthew Dobson wrote:
> bitmap_and() & bitmap_or() *do not* mask off the unused input bits. 
> Unless you add that code in a subsequent patch...  This paragraph seems
> a bit unclear.  You're saying that bitmap_and() & bitmap_or() *don't*
> follow the precondition, but *do* mask off unused bits, which I'm not
> seeing.  Then the 'however' is confusing, because you continue with the
> same point about *not* following preconditions.  Maybe something like:

They actually don't need to. The cases where "or" gives rise to the need
to do a fixup pass is only when the second operand is complemented. If
both the inputs satisfy the trailing zero precondition, it's already
guaranteed that bitmap_or()'s result will do likewise as a
postcondition. If _either_ of the inputs to bitmap_and() satisfy the
trailing zero precondition, its result will also satisfy the trailing
zero postcondition.

This is all assuming the trailing zero invariant; the "don't care"
invariant behaves very differently and incurs its checks only at the
time of examinations whose underlying implementations operate on whole
words, like cpus_equal(), cpus_weight(), and cpus_empty().

For the single-word case, something like this is required for mainline:
#if NR_CPUS % BITS_PER_LONG
#define __CPU_VALID_BITS__	(~((1UL << (NR_CPUS % BITS_PER_LONG)) - 1))
#else
#define __CPU_VALID_BITS__	(~0UL)
#endif

#define cpus_equal(x,y)		(!(((x) ^ (y)) & __CPU_VALID_BITS__))
#define cpus_empty(x)		(!((x) & __CPU_VALID_BITS__))
#define cpus_coerce(x)		((unsigned long)(x) & __CPU_VALID_BITS__)
#if BITS_PER_LONG == 32
#define cpus_weight(x)		hweight32((x) & __CPU_VALID_BITS__)
#else
#define cpus_weight(x)		hweight64((x) & __CPU_VALID_BITS__)
#endif

... and all other operations unmodified. In all honesty, the difference
in overhead and/or implementation complexity between the two invariants
is miniscule. I don't care who wants what per se; if you want to change
that invariant, it's not my concern what the invariant is so long as
it's respected and there's a coherent notion of what people want it to
be. Given some of your statements, I wonder sometimes if you actually
understand the "don't care" invariant.

The patch series is a little clunky though. e.g. the cpus_raw()
renaming has zero semantic effect, where the cpus_complement() API
change should probably move people to a renamed function (e.g. dyadic
cpus_not() or some such) so callers can be incrementally converted, it
looks like there are points in the series where various things won't
compile etc. but otherwise innocuous. The really hard questions will
come when those with real concerns about the operational semantics
start coming out of the woodwork. Actually, why don't you start
by asking Ray Bryant, since it was prodding from him about codegen
results directly contradicting yours that originally instigated the
apparently reviled cpumask_const_t. A coherent story out of SGI (e.g.
not so many contradictory statements from different people) would
probably help and/or would have helped get this right the first time.


-- wli
