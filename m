Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbWJLFTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWJLFTS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 01:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965279AbWJLFTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 01:19:18 -0400
Received: from sp604003mt.neufgp.fr ([84.96.92.56]:64500 "EHLO smTp.neuf.fr")
	by vger.kernel.org with ESMTP id S965278AbWJLFTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 01:19:18 -0400
Date: Thu, 12 Oct 2006 07:19:20 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] fdtable: Eradicate fdarray overflow.
In-reply-to: <200610111958.03238.vlobanov@speakeasy.net>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-id: <452DD058.7000301@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <200610111958.03238.vlobanov@speakeasy.net>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Lobanov a écrit :
> 
> diff -Npru old/fs/file.c new/fs/file.c
> --- old/fs/file.c	2006-10-10 18:58:21.000000000 -0700
> +++ new/fs/file.c	2006-10-11 19:37:23.000000000 -0700
> @@ -164,9 +164,8 @@ static struct fdtable * alloc_fdtable(un
>  	 * the fdarray into page-sized chunks: starting at a quarter of a page,
>  	 * and growing in powers of two from there on.
>  	 */
> -	nr++;
>  	nr /= (PAGE_SIZE / 4 / sizeof(struct file *));
> -	nr = roundup_pow_of_two(nr);
> +	nr = roundup_pow_of_two(nr + 1);
>  	nr *= (PAGE_SIZE / 4 / sizeof(struct file *));
>  	if (nr > NR_OPEN)
>  		nr = NR_OPEN;

Hi Vadim

I find your PAGE_SIZE/4 minimum allocation quite unjustified.

For architectures with 64K PAGE_SIZE, we endup allocating 16K, for poor tasks 
that happen to touch a not so high (>= 64) file descriptor...

I would vote for a fixed size, like 1024

Eric
