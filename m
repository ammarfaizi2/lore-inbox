Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbUC3I5e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 03:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263531AbUC3I5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 03:57:34 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:62041 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263529AbUC3I53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 03:57:29 -0500
Date: Tue, 30 Mar 2004 00:00:29 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org
Subject: Re: [PATCH] mask ADT: bitmap and bitop tweaks [1/22]
Message-Id: <20040330000029.6cd84d7f.pj@sgi.com>
In-Reply-To: <20040330020637.GA791@holomorphy.com>
References: <20040329041249.65d365a1.pj@sgi.com>
	<1080601576.6742.43.camel@arrakis>
	<20040329235233.GV791@holomorphy.com>
	<20040329154330.445e10e2.pj@sgi.com>
	<20040330020637.GA791@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, the existing standard is to treat the unused bits as "don't cares".
> The difference codewise between the two choices is rather small anyway,

As you have documented in your requested patch to Andrew, the actual
code in 2.6.4 deviated from your intended bitmap model by the details
of cpus_equal(), cpus_empty() and cpus_weight() routines in
cpumask_arith.h.

And 2.6.4 deviates from my bitmap model by a couple of *_complement
implementations and the multi-word CPU_MASK_ALL initializor.

By my model, the CPU_MASK_ALL code for large (multi word mask) systems
is missing the zero'ing of unused bits, in the (rare) case that the
number of valid bits in the mask was not an exact word multiple. And the
*_complement implementations routinely returned masks with the unused
bits set, given input with them not set.

Looking ahead to your next post - I suspect that my model is not the
zeroed tail invariant you describe.  My bitmap model makes no promise to
zero out all input tails.

Rather my bitmap model adds the further implementation condition:

  If input tails are zero, then output tails will be zero.

By your model, the CPU_MASK_ALL code for small (one word mask) systems
has some redundant code, to zero the unused bits.  This CPU_MASK_ALL
could simply be "~0UL", not the more elaborate "(~((cpumask_t)0) >>
(8*sizeof(cpumask_t) - NR_CPUS))".

On further examination, I believe that your model better describes
what has been the design intent for bitmaps.

However my model conforms to yours.  Any correct bitmap implementation
of my model is a correct implementation of yours.  My model simply
adds the above condition on the implementation.

My change to zero out unused bits in the *_complement operators does not
violate your model.   Nor does my change to zero out the unused bits in
the multi-word CPU_MASK_ALL initializor violate your model.  You have
repeatedly emphasized that you don't care about the setting of these
bits.  Surely you don't care if they are zero, just as you don't care
that the one word CPU_MASK_ALL initialization zeros the unused bits.

==> Note of course that the above model(s) are efforts to describe
    the bitmap/bitop code.  The model I provide for my new mask ADT is
    different - it makes use of the implementation condition above on
    bitmaps "Zero tails in yield zero tails out", along with an added
    precondition "Don't pass in masks with nonzero tails" to avoid
    needing much filtering code.

So - would you consent to my bundling the following changes as a single
patch - that adds to bitmaps the property that "output tails will be
zero if input tails are zero"?

  1) Zero unused bits in the *_complement operators.
  2) Zero unused bits in CPU_MASK_ALL (multiword).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
