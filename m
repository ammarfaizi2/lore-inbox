Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbUC3C4S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 21:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263515AbUC3C4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 21:56:18 -0500
Received: from holomorphy.com ([207.189.100.168]:20639 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263513AbUC3C4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 21:56:16 -0500
Date: Mon, 29 Mar 2004 18:55:35 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org
Subject: Re: [PATCH] mask ADT: bitmap and bitop tweaks [1/22]
Message-ID: <20040330025535.GD791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org
References: <20040329041249.65d365a1.pj@sgi.com> <1080601576.6742.43.camel@arrakis> <20040329235233.GV791@holomorphy.com> <20040329154330.445e10e2.pj@sgi.com> <20040330020637.GA791@holomorphy.com> <20040329174637.3aa16260.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329174637.3aa16260.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> akpm, this is needed for mainline.

On Mon, Mar 29, 2004 at 05:46:37PM -0800, Paul Jackson wrote:
> How urgent to you consider this fix (masking unused bits in the
> arithmetic (single unsigned long word) cpumask implementation?
> So far as I know, the only way to get high bits set with correct
> invocations is by using cpus_complement(), which I don't see anyone
> doing.
> So I believe that this patch fixes latent bugs, not current bugs.

False. The semantics are currently "don't care" and the ADT fails to
ignore the upper bits in cpumask_arith.h. It's a bug in the ADT code.
Whether callers experience ill effects is irrelevant.


On Mon, Mar 29, 2004 at 05:46:37PM -0800, Paul Jackson wrote:
> And it would be my preference (not surprisingly) to fix this in a way
> that is consistent with my mask ADT proposal (avoid setting unused bits
> on proper calls; don't filter on Boolean/scalar predicate evaluations):
> +#if NR_CPUS % BITS_PER_LONG
> +#define __CPU_VALID_MASK__		(~((1UL<< (NR_CPUS%BITS_PER_LONG) - 1))
> +#else
> +#define __CPU_VALID_MASK__		(~0UL)
> +#endif
> -#define cpus_complement(map)		do { map = ~(map); } while (0)
> +#define cpus_complement(map)		\
> +	do { map = ~(map) & __CPU_VALID_MASK__; } while (0)
> _instead_ of changing the several other macros to follow the
> bitmap convention (let the unused bits remain dont-care, until
> resolving a Boolean or scalar predicate).

You're missing the changes needed for cpus_shift_left() and
cpus_promote() to satisfy zeroed tail postconditions. IIRC the needed
changes to cpus_shift_left() are also missing from your other patches
in the bitmap code. You are also changing the invariants, which should
be the substance of a patch different from any bugfix.


-- wli
