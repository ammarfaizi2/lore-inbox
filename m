Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbWEYIDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbWEYIDL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 04:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbWEYIDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 04:03:11 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:23762 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S965078AbWEYIDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 04:03:09 -0400
Message-ID: <348544185.07479@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 25 May 2006 16:03:08 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/33] readahead: context based method
Message-ID: <20060525080308.GB4996@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469544.17438@ustc.edu.cn> <44753FE8.3040002@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44753FE8.3040002@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 03:26:00PM +1000, Nick Piggin wrote:
> Wu Fengguang wrote:
> >+	cond_resched();
> >+	read_lock_irq(&mapping->tree_lock);
> >+	index = radix_tree_scan_hole_backward(&mapping->page_tree,
> >+							offset, ra_max);
> >+	read_unlock_irq(&mapping->tree_lock);
> >
> 
> Why do you drop this lock just to pick it up again a few instructions
> down the line? (is ra_cache_hit_ok or cound_cache_hit very big or
> unable to be called without the lock?)

Nice catch, will fix it.

> >+
> >+	*remain = offset - index;
> >+
> >+	if (offset == ra->readahead_index && ra_cache_hit_ok(ra))
> >+		count = *remain;
> >+	else if (count_cache_hit(mapping, index + 1, offset) *
> >+						readahead_hit_rate >= 
> >*remain)
> >+		count = *remain;
> >+	else
> >+		count = ra_min;
> >+
> >+	/*
> >+	 * Unnecessary to count more?
> >+	 */
> >+	if (count < ra_max)
> >+		goto out;
> >+
> >+	if (unlikely(ra->flags & RA_FLAG_NO_LOOKAHEAD))
> >+		goto out;
> >+
> >+	/*
> >+	 * Check the far pages coarsely.
> >+	 * The enlarged count here helps increase la_size.
> >+	 */
> >+	nr_lookback = ra_max * (LOOKAHEAD_RATIO + 1) *
> >+						100 / (readahead_ratio | 1);
> >+
> >+	cond_resched();
> >+	radix_tree_cache_init(&cache);
> >+	read_lock_irq(&mapping->tree_lock);
> >+	for (count += ra_max; count < nr_lookback; count += ra_max) {
> >+		struct radix_tree_node *node;
> >+		node = radix_tree_cache_lookup_parent(&mapping->page_tree,
> >+						&cache, offset - count, 1);
> >+		if (!node)
> >+			break;
> >+	}
> >+	read_unlock_irq(&mapping->tree_lock);
> >
> 
> Yuck. Apart from not being commented, this depends on internal
> implementation of radix-tree. This should just be packaged up in some
> radix-tree function to do exactly what you want (eg. is there a hole of
> N contiguous pages).

Yes, it is ugly.
Maybe we can make it a function named radix_tree_scan_hole_coarse().

> And then again you can be rid of the radix-tree cache.
> 
> Yes, it increasingly appears that you're using the cache because you're
> using the wrong abstractions. Eg. this is basically half implementing
> some data-structure internal detail.

Sorry for not being aware of this problem :)

Wu
