Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbUC3KUZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 05:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbUC3KUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 05:20:25 -0500
Received: from holomorphy.com ([207.189.100.168]:35232 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263593AbUC3KUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 05:20:22 -0500
Date: Tue, 30 Mar 2004 02:19:52 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, raybry@sgi.com,
       akpm@osdl.org
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-ID: <20040330101952.GN791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, raybry@sgi.com, akpm@osdl.org
References: <20040329041253.5cd281a5.pj@sgi.com> <1080606618.6742.89.camel@arrakis> <20040330012744.GZ791@holomorphy.com> <20040329172725.255e4829.pj@sgi.com> <20040330063805.GI791@holomorphy.com> <20040330004540.0144215d.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330004540.0144215d.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Compiler-specific operational semantics and compiler version
>> dependencies are *REALLY* scary from a portability POV and have already
>> burned the cpumask_t codebase once in the case of the bitmap inlines.

On Tue, Mar 30, 2004 at 12:45:40AM -0800, Paul Jackson wrote:
> Mention of such past difficulties, without any elaboration of details,
> serves only to discourage change.
> If you can provide sufficient details that we can make a useful
> evaluation of whether such concerns are still a show stopper for
> this work, then I welcome your presentation of such.
> If not, then I can do nothing with this observation.  In that case,
> given the clear and substantial simplifications that appear possible,
> I can only push on.

It can't be made specific. It's a rather unfortunate fact of life that
various arches require magic toolchain versions to produce working
kernels. The bits about dragging this around in front of arch maintainers
is to figure out whether the magic toolchain versions required for the
various arches barf on the constructs you're using.


At some point in the past, I wrote:
>> Your assessment of it appears to be off-base, as that kind of
>> type ambiguity is effectively mandated by the requirements of
>> not incurring indirection overhead for smaller systems while
>> simultaneously transparently falling back to call-by-reference
>> semantics for larger ones.

On Tue, Mar 30, 2004 at 12:45:40AM -0800, Paul Jackson wrote:
> I agree that if that's the general requirement, then cpumask_const_t
> is an appropriate answer.
> The only decent example of any such requirement ever being needed that I
> have been able to locate so far came from the sparc architecture.  After
> a useful discussion of this with David Miller, on a subthread of
> Matthew's thread last week (IIRC), this only applied to sparc32 and
> those folks are a ways from providing SMP.  Also, I could not find
> any performance critical paths in the kernel that pass a cpumask_t
> as an argument to a real (non-inline) function.  So all in all, the
> chance that we need this, on an architecture with structure passing
> constraints, is getting pretty small.

I think it's feasible to get the requirement lifted. You just need to
(once again) run it past arch maintainers.


On Tue, Mar 30, 2004 at 12:45:40AM -0800, Paul Jackson wrote:
> And if ever we do, then I would have to recommend we balance the
> 'requirement' for transparent argument type adaption with the
> 'requirement' to keep things simple.  If one call had to pass an
> explicit pointer, or even had to wrap the real function call with a
> macro, that selectively passed a value or a pointer, depending on
> cpumask_t size, then that would be an alternative well worth
> considering, in my view, over the alternative of providing an entire
> parallel set of mask headers that provide this 'const' capability.
> Some requirements are better met with narrowly focused special cases,
> than with fully generalized solutions.

Maybe so. The requirements were actually three competing/conflicting
requirements: one from Ray Bryant/SGI for call-by-reference semantics
available to core API's, one from davem for call-by-value on arithmetic
types in core API's. There was another imposed for zero indirection on
small SMP systems you're probably going to have to work harder to get
an ack on since I don't remember where it came from apart from "on high".
But it sounds like at least one of the requirement competitors may be
backing out here. If Ray or other vaguely independent SGI ppl (yes, this
does need to look like it's more than unilateral) could speak up
regarding the call-by-reference semantics requirement that would lift a
third of it. The unwrapped structures was basically davem and tinyboxen,
and I saw the bit where he lifted the sparc(64) side of that requirement.

As I see it we have:
(a) pester more ppl at SGI to get cpumask_const_t requirements dropped
(b) davem's already backed off cpumask_arith for sparc(32|64) ABI bits
(c) some kind of high-level ack is needed for indirection on tinyboxen
	to kill off the second requirement for cpumask_arith
(d) run this past arch maintainers for acks wrt. compiler versions vs.
	the costructs you're using in inlines

(a) should be very easy for you, (b) is fait accompli, (c) akpm could
chime in on at any moment. One hopeful thing here for you is that it's
a question of asking the right ppl; the code itself is largely a non-
issue, apart from whether higher-level maintainers regard it as
excessive code churn or too cleanup-heavy.

I'll send a private reply about how to get a hold of arch maintainers,
which should take care of (d).

(davem please don't shoot me -- this stuff could break things otherwise
similar to how i386 hit bad codegen in earlier revisions pre-merge)


-- wli
