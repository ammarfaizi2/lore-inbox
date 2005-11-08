Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbVKHHvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbVKHHvv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965389AbVKHHvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:51:51 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:19913 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965145AbVKHHvu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:51:50 -0500
Date: Tue, 8 Nov 2005 09:51:48 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] Cleanup kmem_cache_create()
In-Reply-To: <436FF70D.6040604@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0511080951230.10193@sbz-30.cs.Helsinki.FI>
References: <436FF51D.8080509@us.ibm.com> <436FF70D.6040604@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005, Matthew Dobson wrote:
> @@ -1652,9 +1649,9 @@ kmem_cache_t *kmem_cache_create(const ch
>  		 * gfp() funcs are more friendly towards high-order requests,
>  		 * this should be changed.
>  		 */
> -		do {
> -			unsigned int break_flag = 0;
> -cal_wastage:
> +		unsigned int break_flag = 0;
> +
> +		for ( ; ; cachep->gfporder++) {
>  			cache_estimate(cachep->gfporder, size, align, flags,
>  						&left_over, &cachep->num);
>  			if (break_flag)
> @@ -1662,13 +1659,13 @@ cal_wastage:
>  			if (cachep->gfporder >= MAX_GFP_ORDER)
>  				break;
>  			if (!cachep->num)
> -				goto next;
> -			if (flags & CFLGS_OFF_SLAB &&
> -					cachep->num > offslab_limit) {
> +				continue;
> +			if ((flags & CFLGS_OFF_SLAB) &&
> +			    (cachep->num > offslab_limit)) {
>  				/* This num of objs will cause problems. */
> -				cachep->gfporder--;
> +				cachep->gfporder -= 2;

This is not an improvement IMHO. The use of for construct is non-intuitive
and neither is the above. A suggested cleanup is to keep the loop as is but
extract it to a function of its own.

				Pekka
