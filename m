Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbTI3QzO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 12:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbTI3QzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 12:55:14 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:8582 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261601AbTI3QzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 12:55:09 -0400
Date: Tue, 30 Sep 2003 17:54:50 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Dave Jones <davej@redhat.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20030930165450.GF28876@mail.shareable.org>
References: <20030930073814.GA26649@mail.jlokier.co.uk> <20030930132211.GA23333@redhat.com> <20030930133936.GA28876@mail.shareable.org> <20030930135324.GC5507@redhat.com> <20030930144526.GC28876@mail.shareable.org> <20030930150825.GD5507@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930150825.GD5507@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> >    - I don't see anything that prevents a PPro-compiled kernel from booting
> >      on a P5MMX with the F00F erratum.
> 
> Compiled with -m686 - Uses CMOV, won't boot.

Ok, not PPro, but with Processor Family set to K6, CYRIXIII, or any of
the 3 WINCHIP choices, it is compiled with -march=i585 and without F00F.

(Fixing that by adding F00F too all those non-Intel processors, just to
make sure non-F00F kernels crash with a cmov instruction is too subtle
for my taste.)

Anyway, it should complain about lack of cmov not crash :)

> 1. The splitting of X86_FEATURE_XMM into X86_FEATURE_XMM_PREFETCH and
>    X86_FEATURE_3DNOW_PREFETCH doesn't seem to really buy us anything
>    other than complication.

I once suggested turning off XMM entirely when prefetch is broken and
not fixed, but that resulted in a mild toasting, hence the extra
synthetic flag.

It's not really split: XMM_PREFETCH is an additional flag, on top of
XMM, which simply means Linux decided it's safe to use the prefetch
instruction.

The only reason it's a feature flag is because the "alternative" macro
needs one.

> +       /* Prefetch works ok? */
> +#ifndef CONFIG_X86_PREFETCH_FIXUP
> +       if (c->x86_vendor != X86_VENDOR_AMD || c->x86 < 6)
> +#endif
> +       {
> +               if (cpu_has(c, X86_FEATURE_XMM))
> +                       set_bit(X86_FEATURE_XMM_PREFETCH, c->x86_capability);
> +               if (cpu_has(c, X86_FEATURE_3DNOW))
> +                       set_bit(X86_FEATURE_3DNOW_PREFETCH, c->x86_capability);
> +       }
> 
> - If we haven't set CONFIG_X86_PREFETCH_FIXUP (say a P4 kernel), this
>   code path isn't taken, and we end up not doing prefetches on P4's too
>   as you're not setting X86_FEATURE_XMM_PREFETCH anywhere else, and apply_alternatives
>   leaves them as NOPs.
> - Newer C3s are 686's with prefetch, this nobbles them too.

Read the code again.  It does what you think it doesn't do, so to speak.

-- Jamie
