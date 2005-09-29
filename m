Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbVI2GJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVI2GJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 02:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVI2GJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 02:09:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751175AbVI2GJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 02:09:50 -0400
Date: Wed, 28 Sep 2005 23:09:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adam Litke <agl@us.ibm.com>
Cc: agl@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3 htlb-fault] Demand faulting for huge pages
Message-Id: <20050928230917.2be72d69.akpm@osdl.org>
In-Reply-To: <1127939538.26401.36.camel@localhost.localdomain>
References: <1127939141.26401.32.camel@localhost.localdomain>
	<1127939538.26401.36.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Litke <agl@us.ibm.com> wrote:
>
> +static struct page *find_get_huge_page(struct address_space *mapping,
>  +			unsigned long idx)
>  +{
>  +	struct page *page = NULL;
>  +
>  +retry:
>  +	page = find_get_page(mapping, idx);
>  +	if (page)
>  +		goto out;
>  +
>  +	if (hugetlb_get_quota(mapping))
>  +		goto out;
>  +	page = alloc_huge_page();
>  +	if (!page) {
>  +		hugetlb_put_quota(mapping);
>  +		goto out;
>  +	}
>  +
>  +	if (add_to_page_cache(page, mapping, idx, GFP_ATOMIC)) {
>  +		put_page(page);
>  +		hugetlb_put_quota(mapping);
>  +		goto retry;

If add_to_page_cache() fails due to failure in radix_tree_preload(), this
code will lock up.

A lame fix is to check for -ENOMEM and bale.  A better fix would be to use
GFP_KERNEL.

