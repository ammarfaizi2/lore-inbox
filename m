Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWEZR14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWEZR14 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWEZR14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:27:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32701 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751186AbWEZR1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:27:55 -0400
Date: Fri, 26 May 2006 10:27:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn
Subject: Re: [PATCH 17/33] readahead: context based method
Message-Id: <20060526102716.7ee590d9.akpm@osdl.org>
In-Reply-To: <348469544.17438@ustc.edu.cn>
References: <20060524111246.420010595@localhost.localdomain>
	<348469544.17438@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> This is the slow code path of adaptive read-ahead.
> 
> ...
>
> +
> +/*
> + * Count/estimate cache hits in range [first_index, last_index].
> + * The estimation is simple and optimistic.
> + */
> +static int count_cache_hit(struct address_space *mapping,
> +				pgoff_t first_index, pgoff_t last_index)
> +{
> +	struct page *page;
> +	int size = last_index - first_index + 1;

`size' might overflow.

> +	int count = 0;
> +	int i;
> +
> +	cond_resched();
> +	read_lock_irq(&mapping->tree_lock);
> +
> +	/*
> +	 * The first page may well is chunk head and has been accessed,
> +	 * so it is index 0 that makes the estimation optimistic. This
> +	 * behavior guarantees a readahead when (size < ra_max) and
> +	 * (readahead_hit_rate >= 16).
> +	 */
> +	for (i = 0; i < 16;) {
> +		page = __find_page(mapping, first_index +
> +						size * ((i++ * 29) & 15) / 16);

29?


