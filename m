Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbUC3JXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUC3JXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:23:17 -0500
Received: from holomorphy.com ([207.189.100.168]:20384 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263565AbUC3JXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:23:12 -0500
Date: Tue, 30 Mar 2004 01:22:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org
Subject: Re: [PATCH] mask ADT: bitmap and bitop tweaks [1/22]
Message-ID: <20040330092218.GM791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org
References: <20040329041249.65d365a1.pj@sgi.com> <1080601576.6742.43.camel@arrakis> <20040329235233.GV791@holomorphy.com> <20040329154330.445e10e2.pj@sgi.com> <20040330020637.GA791@holomorphy.com> <20040330000029.6cd84d7f.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330000029.6cd84d7f.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> No, the existing standard is to treat the unused bits as "don't cares".

At some point in the past, Paul Jackson wrote:
> ==> Note of course that the above model(s) are efforts to describe
>     the bitmap/bitop code.  The model I provide for my new mask ADT is
>     different - it makes use of the implementation condition above on
>     bitmaps "Zero tails in yield zero tails out", along with an added
>     precondition "Don't pass in masks with nonzero tails" to avoid
>     needing much filtering code.

I think the difference is maybe one or two lines, but it doesn't matter
much. If zeroed tails are what you want, by all means, have them. But
please keep it to one change at a time(e.g. do the standardized
array-in-struct datatype in a different patch). Also, please document
the change of invariants. I didn't realize it would become a point of
confusion and we should avoid repeating this kind of affair.

I think I failed to convey the entire zeroed tail invariant I described.
What I wanted to convey did include the precondition of zeroed tails
for validity and/or satisfying zeroed tail postconditions. I think I
even meant to go as far as saying not having zeroed tails meant undefined
behavior, where I suspect you want general validity and zeroed tails
preserved when present (and actually it would take some effort to barf
on nonzeroed tails for most of the operations).


At some point in the past, Paul Jackson wrote:
> So - would you consent to my bundling the following changes as a single
> patch - that adds to bitmaps the property that "output tails will be
> zero if input tails are zero"?
>   1) Zero unused bits in the *_complement operators.
>   2) Zero unused bits in CPU_MASK_ALL (multiword).

I think the change is small enough and transparent enough in general you
could do the entire invariant conversion for arith and bitmaps as one
patch. But please document it (possibly with kerneldoc) somewhere
nearby to where the API's are implemented. I think a couple of lines of
comments at the top of lib/bitmap.c should be enough if the bitmap
functions don't rely on zeroed tails for correctness. If some do rely
on zeroed tails for correctness, that should be in kerneldoc comments
(e.g. if bitmap_shift_right() needs zeroed tails not to shift in garbage
from upper bits, that's a gotcha that needs to be documented).

Part of what led to this confusion in the first place was the assumption
(likely on my part) that the "don't care" invariant was the most natural
and not documenting it. Zeroed tails are a stronger condition in general
and likely make some small optimizations possible if the bitmap functions
are allowed to produce undefined results for nonzeroed tails (which is an
okay thing to do, just needs to be a separate change for bisection/testing
etc. purposes if by some catastrophe something does break).


-- wli
