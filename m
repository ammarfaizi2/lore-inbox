Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbUC3CYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 21:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbUC3CYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 21:24:30 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:54968 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263133AbUC3CY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 21:24:27 -0500
Date: Mon, 29 Mar 2004 17:27:25 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, raybry@sgi.com,
       akpm@osdl.org
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-Id: <20040329172725.255e4829.pj@sgi.com>
In-Reply-To: <20040330012744.GZ791@holomorphy.com>
References: <20040329041253.5cd281a5.pj@sgi.com>
	<1080606618.6742.89.camel@arrakis>
	<20040330012744.GZ791@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Given some of your statements, I wonder sometimes if you actually
> understand the "don't care" invariant.

Always possible.  If you care to point to such confusions, especially in
this patch series, as Matthew is doing, go right ahead.  Not much I can
do with "some of your statements".

> the cpus_raw() renaming has zero semantic effect,

Not quite zero, though close.  It provides a pointer to the array of
unsigned longs, so one _could_ manipulate masks of two or more words via
that pointer.  The previous promote and coerce just jammed the first
word in or out of a mask.

However the main motivation for that change was to make this override a
bit _less_ abstract.  I presumed that the typical coder using such an
override was more likely to be comfortable thinking in terms of memory
words and their addresses, rather than coercion and promotion between
two data types.  I figured that the closer the call was to how they
think anyway, the better the chance they had of using it correctly.

> the cpus_complement() API change should probably move people to a
> renamed function

Somtimes yes, sometimes no.  In this case, the number of uses of
complement was vanishingly small.  As in essentially _none_.  There
is one physids_complement() macro, using bitmap_complement(),
but that phyids_complement() macro is itself unused.  That's it.

A staged migration would be excessive in this case.  Just get the
code 'right' and move on.

> Actually, why don't you start by asking Ray Bryant, since it was
> prodding from him about codegen results directly contradicting yours
> that originally instigated the apparently reviled cpumask_const_t.

I have - he has had nothing to add.  After a point, trying to use
discussions from a year ago to which I wasn't party (and would have
forgotten if I was) as a guide to this stuff is not helpful.

I am quite willing to believe that one _could_ write the code so that it
looked too inefficient.  In the cases that I examined with objdump,
using gcc 3.2 and above, I was able to get nice results.

I recommend you examine the generated code yourself, and point out the
places that are wasting cycles, for the compilers and processors and
systems that you care about.

And even if there are such places (which likely there are), that still
doesn't mean that cpumask_const_t is the necessary solution.  Indeed, as
I have explained with some care and detail in responses last week to
Matthew's patch set, I consider cpumask_const_t to be an abuse of
conventional 'C' idioms.  In most cases, we should have enough control
of the situation to address such inefficiencies in the mask.h wrappers,
or by making reasonable changes in the invoking code.  It is _not_
proper to insist that someone be able to pass a large structure on
the stack by value semantics, without them realizing it or feeling
the pain.  This is 'C' we are coding, not Python.  Code using this
stuff may have to be written with an awareness of the possible sizes
of things, and choose argument passing conventions appropriately.

> A coherent story out of SGI (e.g. not so many contradictory statements
> from different people) would probably help and/or would have helped get
> this right the first time.

Efforts to dissect the past to determine who did what wrong when are
frequently unproductive.  The more productive question to ask is:

  What can we do to improve the current code?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
