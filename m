Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbUC3Gib (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 01:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbUC3Gib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 01:38:31 -0500
Received: from holomorphy.com ([207.189.100.168]:53407 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262235AbUC3GiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 01:38:14 -0500
Date: Mon, 29 Mar 2004 22:38:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, raybry@sgi.com,
       akpm@osdl.org
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-ID: <20040330063805.GI791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, raybry@sgi.com, akpm@osdl.org
References: <20040329041253.5cd281a5.pj@sgi.com> <1080606618.6742.89.camel@arrakis> <20040330012744.GZ791@holomorphy.com> <20040329172725.255e4829.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329172725.255e4829.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Given some of your statements, I wonder sometimes if you actually
>> understand the "don't care" invariant.

On Mon, Mar 29, 2004 at 05:27:25PM -0800, Paul Jackson wrote:
> Always possible.  If you care to point to such confusions, especially in
> this patch series, as Matthew is doing, go right ahead.  Not much I can
> do with "some of your statements".

Okay, let's see if I can give a high-level explanation. There are two
choices of invariants being discussed, with various properties:

(a) zeroed tail invariant
	(i) acts as an "ingress filter" on leftover bits
	(ii) forces leftover bits to a defined state
	(iii) requires leftover bits being set up by (ii) for correctness

(b) don't care invariant
	(i) acts as an "egress filter" on leftover bits
	(ii) leftover bits are in "undefined" states
	(iii) correctness requires (ii)'s bits may never "leak" to callers

These invariants can be changed transparently. Changing them is not a
bugfix of any kind. Cleanups are fine to do. Just separate the bugfixes
from cleanups.


At some point in the past, I wrote:
>> the cpus_raw() renaming has zero semantic effect,

On Mon, Mar 29, 2004 at 05:27:25PM -0800, Paul Jackson wrote:
> Not quite zero, though close.  It provides a pointer to the array of
> unsigned longs, so one _could_ manipulate masks of two or more words via
> that pointer.  The previous promote and coerce just jammed the first
> word in or out of a mask.

That's just as bad, since cpus_addr() does that now.


On Mon, Mar 29, 2004 at 05:27:25PM -0800, Paul Jackson wrote:
> However the main motivation for that change was to make this override a
> bit _less_ abstract.  I presumed that the typical coder using such an
> override was more likely to be comfortable thinking in terms of memory
> words and their addresses, rather than coercion and promotion between
> two data types.  I figured that the closer the call was to how they
> think anyway, the better the chance they had of using it correctly.

As nice as that is, pure renaming for its own sake isn't worthwhile
except in a very limited number of cases, of which this is not one.


At some point in the past, I wrote:
>> the cpus_complement() API change should probably move people to a
>> renamed function

On Mon, Mar 29, 2004 at 05:27:25PM -0800, Paul Jackson wrote:
> Somtimes yes, sometimes no.  In this case, the number of uses of
> complement was vanishingly small.  As in essentially _none_.  There
> is one physids_complement() macro, using bitmap_complement(),
> but that phyids_complement() macro is itself unused.  That's it.
> A staged migration would be excessive in this case.  Just get the
> code 'right' and move on.

Okay, I checked and a staged migration isn't needed given the number
of callers:

./include/asm-x86_64/mpspec.h:215:#define physids_complement(map)              bitmap_complement((map).mask, MAX_APICS)
./include/asm-i386/mpspec.h:56:#define physids_complement(map)                 bitmap_complement((map).mask, MAX_APICS)
./include/asm-i386/mach-es7000/mach_ipi.h:14:   cpus_complement(mask);
./kernel/sched.c:3309:                  cpus_complement(tsk->cpus_allowed);


At some point in the past, I wrote:
>> Actually, why don't you start by asking Ray Bryant, since it was
>> prodding from him about codegen results directly contradicting yours
>> that originally instigated the apparently reviled cpumask_const_t.

On Mon, Mar 29, 2004 at 05:27:25PM -0800, Paul Jackson wrote:
> I have - he has had nothing to add.  After a point, trying to use
> discussions from a year ago to which I wasn't party (and would have
> forgotten if I was) as a guide to this stuff is not helpful.
> I am quite willing to believe that one _could_ write the code so that it
> looked too inefficient.  In the cases that I examined with objdump,
> using gcc 3.2 and above, I was able to get nice results.
> I recommend you examine the generated code yourself, and point out the
> places that are wasting cycles, for the compilers and processors and
> systems that you care about.

I'm concerned rather strictly with external requirements as opposed to
my own preferences. Dependency on specific very recent compiler version
is unlikely to be acceptable for all architectures.


On Mon, Mar 29, 2004 at 05:27:25PM -0800, Paul Jackson wrote:
> And even if there are such places (which likely there are), that still
> doesn't mean that cpumask_const_t is the necessary solution.  Indeed, as
> I have explained with some care and detail in responses last week to
> Matthew's patch set, I consider cpumask_const_t to be an abuse of
> conventional 'C' idioms.  In most cases, we should have enough control
> of the situation to address such inefficiencies in the mask.h wrappers,
> or by making reasonable changes in the invoking code.  It is _not_
> proper to insist that someone be able to pass a large structure on
> the stack by value semantics, without them realizing it or feeling
> the pain.  This is 'C' we are coding, not Python.  Code using this
> stuff may have to be written with an awareness of the possible sizes
> of things, and choose argument passing conventions appropriately.

cpumask_const_t addressed the need for call-by-reference operational
semantics while not incurring the overhead of indirection for smaller
systems. Your assessment of it appears to be off-base, as that kind of
type ambiguity is effectively mandated by the requirements of not
incurring indirection overhead for smaller systems while simultaneously
transparently falling back to call-by-reference semantics for larger ones.

What I'm really trying to point out on this front is that you should
survey/lobby (sub)arch maintainers to get the requirement lifted, not me.


At some point in the past, I wrote:
>> A coherent story out of SGI (e.g. not so many contradictory statements
>> from different people) would probably help and/or would have helped get
>> this right the first time.

On Mon, Mar 29, 2004 at 05:27:25PM -0800, Paul Jackson wrote:
> Efforts to dissect the past to determine who did what wrong when are
> frequently unproductive.  The more productive question to ask is:
>   What can we do to improve the current code?

The past is not the issue. As far as I'm concerned, the codegen
concerns still stand until (sub)arch maintainers decide otherwise.

Compiler-specific operational semantics and compiler version
dependencies are *REALLY* scary from a portability POV and have already
burned the cpumask_t codebase once in the case of the bitmap inlines.


-- wli
