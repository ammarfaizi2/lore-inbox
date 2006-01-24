Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbWAXPQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWAXPQB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 10:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWAXPQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 10:16:01 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:40931 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1030351AbWAXPP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 10:15:59 -0500
Date: Tue, 24 Jan 2006 07:13:25 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] 2.6.16-rc1 perfmon2 patch for review
Message-ID: <20060124151325.GC7130@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200601201520.k0KFKDG8023120@frankl.hpl.hp.com> <1137774189.28944.47.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137774189.28944.47.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan,

On Fri, Jan 20, 2006 at 08:23:09AM -0800, Bryan O'Sullivan wrote:
> 
> > +	if (ctx->ctx_cpu != smp_processor_id()) {
> > +#ifdef __i386__
> > +	/* On IA64 we use smp_call_function_single(), so we
> > +	 * should never be called on the wrong CPU.  On other
> > +	 * archs, that doesn't exist and we use
> > +	 * smp_call_function instead, so silently ignore all
> > +	 * CPUs except the one we care about.
> > +	 */
> 
> This looks grotty.  Can't you add the necessary arch support, instead of
> an i386-specific hack with a misleading comment?  The block should at
> least be "#ifndef __ia64__" to match the comment.
> 

Well, I am not sure why the smp_call_function_single() is not already
implemented for i386. I can see that the underlying function send_IPI_mask()
is there. It also looks like flush_tlb_others() is also selecting CPUs a subset
of CPUs. I am not a big enough expert on x86 to understand if there are gotchas
to watch for. Yet it would surprise me if this is radically different than on
x86_64 (em64t) which already has the call. Maybe someone can clarify this?

> > +		DPRINT(("set_id=%u not found\n", set_id));
> > +error:
> > +		pfm_retflag_set(req->set_flags, PFM_REG_RETFL_EINVAL);
> > +		return -EINVAL;
> > +found:
> > +		if (is_loaded && set == ctx->ctx_active_set)
> > +			goto error;
> 
> I've seen this style of goto usage in the code a few times, and it's
> bizarre.  Why are you jumping backwards to the error exit?  There's
> nothing wrong with using a goto to exit, it's just more usual to have a
> single section at the end of the function that has both the error and
> normal exit paths.

This is not so pretty, I agree. I rewrote the loop differently now.

-- 

-Stephane
