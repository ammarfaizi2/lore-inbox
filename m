Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWEZRYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWEZRYY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWEZRYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:24:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25532 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751178AbWEZRYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:24:23 -0400
Date: Fri, 26 May 2006 10:23:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn
Subject: Re: [PATCH 17/33] readahead: context based method
Message-Id: <20060526102343.625a16a8.akpm@osdl.org>
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
> +#define PAGE_REFCNT_0           0
>  +#define PAGE_REFCNT_1           (1 << PG_referenced)
>  +#define PAGE_REFCNT_2           (1 << PG_active)
>  +#define PAGE_REFCNT_3           ((1 << PG_active) | (1 << PG_referenced))
>  +#define PAGE_REFCNT_MASK        PAGE_REFCNT_3
>  +
>  +/*
>  + * STATUS   REFERENCE COUNT
>  + *  __                   0
>  + *  _R       PAGE_REFCNT_1
>  + *  A_       PAGE_REFCNT_2
>  + *  AR       PAGE_REFCNT_3
>  + *
>  + *  A/R: Active / Referenced
>  + */
>  +static inline unsigned long page_refcnt(struct page *page)
>  +{
>  +        return page->flags & PAGE_REFCNT_MASK;
>  +}
>  +

This assumes that PG_referenced < PG_active.  Nobody knows that this
assumption was made and someone might go and reorder the page flags and
subtly break readahead.

We need to either not do it this way, or put a big comment in page-flags.h,
or even redefine PG_active to be PG_referenced+1.

