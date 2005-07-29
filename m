Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVG2IbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVG2IbO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 04:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVG2IbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 04:31:07 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:10979 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S262462AbVG2IbA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 04:31:00 -0400
Message-ID: <42E9E91B.9050403@cosmosbay.com>
Date: Fri, 29 Jul 2005 10:30:19 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Keith Owens <kaos@ocs.com.au>, David.Mosberger@acm.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
References: <20050728090948.GA24222@elte.hu> <200507281914.j6SJErg31398@unix-os.sc.intel.com> <20050729070447.GA3032@elte.hu> <20050729070702.GA3327@elte.hu>
In-Reply-To: <20050729070702.GA3327@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------070106000105030207090808"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 29 Jul 2005 10:30:17 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070106000105030207090808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Ingo Molnar a écrit :


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
> -

Please test that len is a constant, or else the inlining is too large for the non constant case.

Thank you

--------------070106000105030207090808
Content-Type: text/plain;
 name="prefetch_range"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prefetch_range"

static inline void prefetch_range(void *addr, size_t len)
{
	char *cp;
	char *end = addr + len;

	if (__builtin_constant_p(len) && (len <= 5*PREFETCH_STRIDE)) {
		if (len <= PREFETCH_STRIDE)
	 		prefetch(cp);
		else if (len <= 2*PREFETCH_STRIDE) {
			prefetch(cp);
			prefetch(cp + PREFETCH_STRIDE);
		}
		else if (len <= 3*PREFETCH_STRIDE) {
			prefetch(cp);
			prefetch(cp + PREFETCH_STRIDE);
			prefetch(cp + 2*PREFETCH_STRIDE);
		}
		else if (len <= 4*PREFETCH_STRIDE) {
			prefetch(cp);
			prefetch(cp + PREFETCH_STRIDE);
			prefetch(cp + 2*PREFETCH_STRIDE);
			prefetch(cp + 3*PREFETCH_STRIDE);
		}
		else if (len <= 5*PREFETCH_STRIDE) {
			prefetch(cp);
			prefetch(cp + PREFETCH_STRIDE);
			prefetch(cp + 2*PREFETCH_STRIDE);
			prefetch(cp + 3*PREFETCH_STRIDE);
			prefetch(cp + 4*PREFETCH_STRIDE);
		}
	}
	else
		for (; cp < end; cp += PREFETCH_STRIDE)
			prefetch(cp);
}

--------------070106000105030207090808--
