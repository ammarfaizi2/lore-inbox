Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbUCZETj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 23:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263929AbUCZETj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 23:19:39 -0500
Received: from waste.org ([209.173.204.2]:175 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263931AbUCZETh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 23:19:37 -0500
Date: Thu, 25 Mar 2004 22:19:26 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
Message-ID: <20040326041926.GG8366@waste.org>
References: <20040325141923.7080c6f0.akpm@osdl.org> <20040325224726.GB8366@waste.org> <16483.35656.864787.827149@napali.hpl.hp.com> <20040325180014.29e40b65.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325180014.29e40b65.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 06:00:14PM -0800, Andrew Morton wrote:
> 
>  25-akpm/drivers/char/random.c    |   51 ++++++++++++++++++++++++++-------------
>  25-akpm/include/linux/prefetch.h |   11 ++++++++
>  2 files changed, 46 insertions(+), 16 deletions(-)
> 
> diff -puN drivers/char/random.c~urandom-scalability-fix drivers/char/random.c
> +++ 25-akpm/drivers/char/random.c	2004-03-25 17:57:39.795881168 -0800
> @@ -490,12 +490,15 @@ static inline __u32 int_ln_12bits(__u32 
>   **********************************************************************/
>  
>  struct entropy_store {
> +	/* mostly-read data: */
> +	struct poolinfo poolinfo;
> +	__u32		*pool;
> +
> +	/* read-write data: */
> +	spinlock_t lock ____cacheline_aligned;
>  	unsigned	add_ptr;
>  	int		entropy_count;
>  	int		input_rotate;
> -	struct poolinfo poolinfo;
> -	__u32		*pool;
> -	spinlock_t lock;
>  };


Also, I think in general we'd prefer to stick the aligned bit at the
front of the structure rather than at the middle, as we'll avoid extra
padding. The size of cachelines is getting rather obscene on some
modern processors.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
