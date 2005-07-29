Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbVG2JR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbVG2JR5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 05:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVG2JR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 05:17:57 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.23]:59477 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S262540AbVG2JRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 05:17:55 -0400
Subject: Re: Add prefetch switch stack hook in scheduler function
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Keith Owens <kaos@ocs.com.au>, David.Mosberger@acm.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <20050729070702.GA3327@elte.hu>
References: <20050728090948.GA24222@elte.hu>
	 <200507281914.j6SJErg31398@unix-os.sc.intel.com>
	 <20050729070447.GA3032@elte.hu>  <20050729070702.GA3327@elte.hu>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 11:17:55 +0200
Message-Id: <1122628675.14892.9.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ---------
> unroll prefetch_range() loops manually.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
>  include/linux/prefetch.h |   31 +++++++++++++++++++++++++++++--
>  1 files changed, 29 insertions(+), 2 deletions(-)
> 
> Index: linux/include/linux/prefetch.h
> ===================================================================
> --- linux.orig/include/linux/prefetch.h
> +++ linux/include/linux/prefetch.h
> @@ -58,11 +58,38 @@ static inline void prefetchw(const void 
>  static inline void prefetch_range(void *addr, size_t len)
>  {
>  #ifdef ARCH_HAS_PREFETCH
> -	char *cp;
> +	char *cp = addr;
>  	char *end = addr + len;
>  
> -	for (cp = addr; cp < end; cp += PREFETCH_STRIDE)
> +	/*
> +	 * Unroll agressively:
> +	 */
> +	if (len <= PREFETCH_STRIDE)
>  		prefetch(cp);
> +	else if (len <= 2*PREFETCH_STRIDE) {
> +		prefetch(cp);
> +		prefetch(cp + PREFETCH_STRIDE);
> +	}
> +	else if (len <= 3*PREFETCH_STRIDE) {
> +		prefetch(cp);
> +		prefetch(cp + PREFETCH_STRIDE);
> +		prefetch(cp + 2*PREFETCH_STRIDE);
> +	}
> +	else if (len <= 4*PREFETCH_STRIDE) {
> +		prefetch(cp);
> +		prefetch(cp + PREFETCH_STRIDE);
> +		prefetch(cp + 2*PREFETCH_STRIDE);
> +		prefetch(cp + 3*PREFETCH_STRIDE);
> +	}
> +	else if (len <= 5*PREFETCH_STRIDE) {
> +		prefetch(cp);
> +		prefetch(cp + PREFETCH_STRIDE);
> +		prefetch(cp + 2*PREFETCH_STRIDE);
> +		prefetch(cp + 3*PREFETCH_STRIDE);
> +		prefetch(cp + 4*PREFETCH_STRIDE);
> +	} else
> +		for (; cp < end; cp += PREFETCH_STRIDE)
> +			prefetch(cp);
>  #endif
>  }
>  

code like that always makes me think of duffs-device
  http://www.lysator.liu.se/c/duffs-device.html

although it might be that the compiler generates better code from the
current incarnation; just my .02 ;-)

regards,

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

