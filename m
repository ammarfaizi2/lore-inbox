Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbWEYF0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWEYF0F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 01:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWEYF0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 01:26:05 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:51870 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965047AbWEYF0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 01:26:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lgmXpDkn6NZkJF8WbxyaeDres5PtlZrdyKa/UvM1CjSsOkg9sfhY3IorirybqHCz11T3z56ZHErxgYszHw3I4pKo3LrCZx+8GFl9LekEVjTtHRFE2Fn7FDR74Ec2KpPcgQSVcv0SquUizVjcnL+E9TRAujUmj0422M1l+hModNA=  ;
Message-ID: <44753FE8.3040002@yahoo.com.au>
Date: Thu, 25 May 2006 15:26:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/33] readahead: context based method
References: <20060524111246.420010595@localhost.localdomain> <348469544.17438@ustc.edu.cn>
In-Reply-To: <348469544.17438@ustc.edu.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:

>
>+/*
>+ * Look back and check history pages to estimate thrashing-threshold.
>+ */
>+static unsigned long query_page_cache_segment(struct address_space *mapping,
>+				struct file_ra_state *ra,
>+				unsigned long *remain, pgoff_t offset,
>+				unsigned long ra_min, unsigned long ra_max)
>+{
>+	pgoff_t index;
>+	unsigned long count;
>+	unsigned long nr_lookback;
>+	struct radix_tree_cache cache;
>+
>+	/*
>+	 * Scan backward and check the near @ra_max pages.
>+	 * The count here determines ra_size.
>+	 */
>+	cond_resched();
>+	read_lock_irq(&mapping->tree_lock);
>+	index = radix_tree_scan_hole_backward(&mapping->page_tree,
>+							offset, ra_max);
>+	read_unlock_irq(&mapping->tree_lock);
>

Why do you drop this lock just to pick it up again a few instructions
down the line? (is ra_cache_hit_ok or cound_cache_hit very big or
unable to be called without the lock?)

>+
>+	*remain = offset - index;
>+
>+	if (offset == ra->readahead_index && ra_cache_hit_ok(ra))
>+		count = *remain;
>+	else if (count_cache_hit(mapping, index + 1, offset) *
>+						readahead_hit_rate >= *remain)
>+		count = *remain;
>+	else
>+		count = ra_min;
>+
>+	/*
>+	 * Unnecessary to count more?
>+	 */
>+	if (count < ra_max)
>+		goto out;
>+
>+	if (unlikely(ra->flags & RA_FLAG_NO_LOOKAHEAD))
>+		goto out;
>+
>+	/*
>+	 * Check the far pages coarsely.
>+	 * The enlarged count here helps increase la_size.
>+	 */
>+	nr_lookback = ra_max * (LOOKAHEAD_RATIO + 1) *
>+						100 / (readahead_ratio | 1);
>+
>+	cond_resched();
>+	radix_tree_cache_init(&cache);
>+	read_lock_irq(&mapping->tree_lock);
>+	for (count += ra_max; count < nr_lookback; count += ra_max) {
>+		struct radix_tree_node *node;
>+		node = radix_tree_cache_lookup_parent(&mapping->page_tree,
>+						&cache, offset - count, 1);
>+		if (!node)
>+			break;
>+	}
>+	read_unlock_irq(&mapping->tree_lock);
>

Yuck. Apart from not being commented, this depends on internal
implementation of radix-tree. This should just be packaged up in some
radix-tree function to do exactly what you want (eg. is there a hole of
N contiguous pages).

And then again you can be rid of the radix-tree cache.

Yes, it increasingly appears that you're using the cache because you're
using the wrong abstractions. Eg. this is basically half implementing
some data-structure internal detail.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
