Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbVISTbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbVISTbL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVISTbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:31:11 -0400
Received: from mail.suse.de ([195.135.220.2]:50350 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932540AbVISTbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:31:10 -0400
Date: Mon, 19 Sep 2005 21:31:06 +0200
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, discuss@x86-64.org
Subject: Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced TSCs
Message-ID: <20050919193105.GA12810@verdi.suse.de>
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127157404.3455.209.camel@cog.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 12:16:43PM -0700, john stultz wrote:
> 	This patch should resolve the issue seen in bugme bug #5105, where it
> is assumed that dualcore x86_64 systems have synced TSCs. This is not
> the case, and alternate timesources should be used instead.


I asked AMD some time ago and they told me it was synchronized.
The TSC on K8 is C state invariant, but not P state invariant,
but P states always happen synchronized on dual cores.

So I'm not quite convinced of your explanation yet.

Most likely you workaround some other bug by switching to pmtimer,
Or just changed the timing enough because pmtimer is incredibly
slow.  It would be better to find the other bug.


> 
> For more details, see:
> http://bugzilla.kernel.org/show_bug.cgi?id=5105
> 
> 
> Please consider for inclusion in your tree.

Please don't for now.

-Andi

> 
> thanks
> -john
> 
> diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
> --- a/arch/x86_64/kernel/time.c
> +++ b/arch/x86_64/kernel/time.c
> @@ -959,9 +959,6 @@ static __init int unsynchronized_tsc(voi
>   	   are handled in the OEM check above. */
>   	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>   		return 0;
> - 	/* All in a single socket - should be synchronized */
> - 	if (cpus_weight(cpu_core_map[0]) == num_online_cpus())
> - 		return 0;
>  #endif
>   	/* Assume multi socket systems are not synchronized */
>   	return num_online_cpus() > 1;
> 
> 

-- 
