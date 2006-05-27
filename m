Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWE0IEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWE0IEh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 04:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWE0IEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 04:04:36 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:64450 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751439AbWE0IEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 04:04:36 -0400
Message-ID: <348717071.10638@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sat, 27 May 2006 16:04:43 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/33] readahead: context based method
Message-ID: <20060527080443.GE4991@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469544.17438@ustc.edu.cn> <20060526102716.7ee590d9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526102716.7ee590d9.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 10:27:16AM -0700, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> > This is the slow code path of adaptive read-ahead.
> > 
> > ...
> >
> > +
> > +/*
> > + * Count/estimate cache hits in range [first_index, last_index].
> > + * The estimation is simple and optimistic.
> > + */
> > +static int count_cache_hit(struct address_space *mapping,
> > +				pgoff_t first_index, pgoff_t last_index)
> > +{
> > +	struct page *page;
> > +	int size = last_index - first_index + 1;
> 
> `size' might overflow.

It does. Fixed the caller:
        @@query_page_cache_segment()
        index = radix_tree_scan_hole_backward(&mapping->page_tree,
-                                                       offset, ra_max);
+                                                       offset - 1, ra_max);
Here (offset >= 1) always holds.

> > +	int count = 0;
> > +	int i;
> > +
> > +	cond_resched();
> > +	read_lock_irq(&mapping->tree_lock);
> > +
> > +	/*
> > +	 * The first page may well is chunk head and has been accessed,
> > +	 * so it is index 0 that makes the estimation optimistic. This
> > +	 * behavior guarantees a readahead when (size < ra_max) and
> > +	 * (readahead_hit_rate >= 16).
> > +	 */
> > +	for (i = 0; i < 16;) {
> > +		page = __find_page(mapping, first_index +
> > +						size * ((i++ * 29) & 15) / 16);
> 
> 29?

It's a prime number. Should be made obvious by the following macro:

#define CACHE_HIT_HASH_KEY      29      /* some prime number */
