Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262889AbVA2KcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262889AbVA2KcC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 05:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbVA2KcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 05:32:02 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:35042 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262889AbVA2Kb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 05:31:57 -0500
Message-ID: <41FB7517.418D556A@tv-sign.ru>
Date: Sat, 29 Jan 2005 14:35:51 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ram Pai <linuxram@us.ibm.com>, Steven Pratt <slpratt@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/4] readahead: factor out duplicated code
References: <41FB6F45.848CEFF6@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch introduces make_ahead_window() function for
> simplification of page_cache_readahead.

If you will count this patch acceptable, I'll rediff it against
next mm iteration.

For your convenience here is the code with the patch applied.

int make_ahead_window(mapping, filp, ra, int force)
{
	int block, ret;

	ra->ahead_size = get_next_ra_size(ra);
	ra->ahead_start = ra->start + ra->size;

	block = force || (ra->prev_page >= ra->ahead_start);
	ret = blockable_page_cache_readahead(mapping, filp,
			ra->ahead_start, ra->ahead_size, ra, block);

	if (!ret && !force) {
		ra->ahead_start = 0;
		ra->ahead_size = 0;
	}

	return ret;
}

unsigned long page_cache_readahead(mapping, ra, filp, offset, req_size)
{
	unsigned long max, newsize = req_size;
	int sequential = (offset == ra->prev_page + 1);

	if (offset == ra->prev_page && req_size == 1 && ra->size != 0)
		goto out;

	ra->prev_page = offset;
	max = get_max_readahead(ra);
	newsize = min(req_size, max);

	if (newsize == 0 || (ra->flags & RA_FLAG_INCACHE)) {
		newsize = 1;
		goto out;
	}

	ra->prev_page += newsize - 1;

	if ((ra->size == 0 && offset == 0) ||
	    (ra->size == -1 && sequential)) {
		ra->size = get_init_ra_size(newsize, max);
		ra->start = offset;
		if (!blockable_page_cache_readahead(mapping, filp, offset, ra->size, ra, 1))
			goto out;

		if (req_size >= max)
			make_ahead_window(mapping, filp, ra, 1);

		goto out;
	}

	if (!sequential || (ra->size == 0)) {
		ra_off(ra);
		blockable_page_cache_readahead(mapping, filp, offset, newsize, ra, 1);
		goto out;
	}


	if (ra->ahead_start == 0) {
		if (!make_ahead_window(mapping, filp, ra, 0))
			goto out;
	}

	if (ra->prev_page >= ra->ahead_start) {
		ra->start = ra->ahead_start;
		ra->size = ra->ahead_size;
		make_ahead_window(mapping, filp, ra, 0);
	}
out:
	return newsize;
}
