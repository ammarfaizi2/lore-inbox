Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWATQXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWATQXL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWATQXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:23:11 -0500
Received: from mx.pathscale.com ([64.160.42.68]:8578 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751031AbWATQXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:23:10 -0500
Subject: Re: [PATCH 2/6] 2.6.16-rc1 perfmon2 patch for review
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200601201520.k0KFKDG8023120@frankl.hpl.hp.com>
References: <200601201520.k0KFKDG8023120@frankl.hpl.hp.com>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 08:23:09 -0800
Message-Id: <1137774189.28944.47.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 07:20 -0800, Stephane Eranian wrote:

> This a split version of the perfmon. Each chunk was split to fit
> the constraints of lkml on message size. the patch is relative
> to 2.6.16-rc1.

Please keep the generic boilerplate in a [PATCH 0/6] message, and have a
descriptive body before each individual message that describes it, not
the entire patch series.

Also, perfmon.c is a big source file.  It might help reviewers if it got
split into several source files that had different logical functions.

> +#if 0
> +static void pfm_map_show(struct pfm_context *ctx)
> +{

> +}
> +#endif

Why submit dead code?

> +	if (ctx->ctx_cpu != smp_processor_id()) {
> +#ifdef __i386__
> +	/* On IA64 we use smp_call_function_single(), so we
> +	 * should never be called on the wrong CPU.  On other
> +	 * archs, that doesn't exist and we use
> +	 * smp_call_function instead, so silently ignore all
> +	 * CPUs except the one we care about.
> +	 */

This looks grotty.  Can't you add the necessary arch support, instead of
an i386-specific hack with a misleading comment?  The block should at
least be "#ifndef __ia64__" to match the comment.

> +#ifndef __i386__
> +	ret = smp_call_function_single(ctx->ctx_cpu, pfm_syswide_force_stop,
> +				       ctx, 0, 1);
> +#else
> +	ret = smp_call_function(pfm_syswide_force_stop, ctx, 0, 1);
> +#endif
> +	DPRINT(("called CPU%u for cleanup ret=%d\n", ctx->ctx_cpu, ret));
> +}
> +#endif /* CONFIG_SMP */

Same "yeugh" response.

> +#ifdef CONFIG_IA64_PERFMON_COMPAT
> +/*
> + * function providing some help for backward compatiblity with old IA-64
> + * applications.

This should be in a separate source file, whose compilation is
conditional on CONFIG_IA64_PERFMON_COMPAT.

> +	BUG_ON(ctx->ctx_fl_system == 0 && ctx->ctx_task != current);

What's this intended to catch?

> +		DPRINT(("set_id=%u not found\n", set_id));
> +error:
> +		pfm_retflag_set(req->set_flags, PFM_REG_RETFL_EINVAL);
> +		return -EINVAL;
> +found:
> +		if (is_loaded && set == ctx->ctx_active_set)
> +			goto error;

I've seen this style of goto usage in the code a few times, and it's
bizarre.  Why are you jumping backwards to the error exit?  There's
nothing wrong with using a goto to exit, it's just more usual to have a
single section at the end of the function that has both the error and
normal exit paths.

In fact, I see that sometimes you use a backwards goto in the middle to
exit, sometimes there's a single hunk at the end with forwards gotos,
and sometimes routines just return wherever they feel like it.  Please
pick one style and stick with it throughout.

	<b

