Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265041AbUGGPtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265041AbUGGPtL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 11:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUGGPtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 11:49:10 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:56031 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265060AbUGGPsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 11:48:55 -0400
Date: Wed, 7 Jul 2004 10:48:00 -0500
From: Jack Steiner <steiner@sgi.com>
To: davidm@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Reduce TLB flushing during process migration
Message-ID: <20040707154800.GA17818@sgi.com>
References: <20040623143844.GA15670@sgi.com> <20040623143318.07932255.akpm@osdl.org> <16605.1322.355489.223220@napali.hpl.hp.com> <20040702173905.GA18884@sgi.com> <16619.15708.487344.93894@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16619.15708.487344.93894@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 05:01:32PM -0700, David Mosberger wrote:
> >>>>> On Fri, 2 Jul 2004 12:39:05 -0500, Jack Steiner <steiner@sgi.com> said:
> 
>   >> Also, my preference would be for tlb_migrate_finish() to be a true no-op
>   >> (not a call to a no-op function) when compiling for a platform that
>   >> doesn't need this hook.  Could you look into this?
> 
>   Jack> For platforms that dont define their own tlb_migrate_finish,
>   Jack> it is defined as :
> 
>   Jack> #define tlb_migrate_finish(mm) do {} while (0)
> 
>   Jack> I'm not sure if I understood your point above. This is
>   Jack> consistent with other noop definitions (at least some of them)
>   Jack> & should not generate any code.
> 
> Well, then it's not a true no-op.  The other no-ops are all for
> init-type stuff, so they're not at all performance critical.  Even
> when compiling a non-generic kernel, those no-op functions will be
> called.  This is really a limitation in the current machvec-scheme.  I
> think what we need is a way to explicitly declare a no-op callback,
> such that it can be optimized away completely for platforms that don't
> need it.  Perhaps there could be something along the lines of:
> 
> #ifdef CONFIG_IA64_GENERIC
> # define machvec_noop(noop_function)	noop_function
> #else
> # define machvec_noop(noop_function)	/* empty */
> #endif
> 
> Then you could do:
> 
> # define platform_tlb_migrate_finish machvec_noop(machvec_mm_noop)
> 
> I _think_ this should work, provided that callbacks that expand into
> true no-ops never have their address taken.
> 
> (This reminds me: in the no-op dummy routines in machvec.c should be
>  named based on the type-signature they use, since it's possible to
>  share no-op handlers for callbacks with the same type-signature; this
>  is why I called the no-op machvec_mm_noop in the example above rather
>  than machvec_tlb_migrate_finish as was the case in your patch).
> 
> 	--david

Your suggestion looks good. I'll code it over the next few days & verify
that it works.

As far as the tlb_migrate patch is concerned, the change to the way machvec
noop functions are implemented is mostly unrelated to the tlb_migrate
patch. We can apply the patches in 2 ways:

	- change machvec noop functions
	- rework the tlb_migrate patch on top of that change

		OR

	- apply the tlb_migrate patch in it's current form
	- change the machvec noop functions including the tlb_migrate noop

Either works. I'm partial to #2 (easier) but will do either....


Note: calling a noop function after an explicit process migration is untidy but 
is not a measurable performance problem. I agree, however, that
the noop function should be improved. At some point in the future, other
noop functions may be added that ARE performance sensitive. It is good to
have the correct infrastructure implemented.


-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


