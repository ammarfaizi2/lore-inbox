Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbVBCCqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVBCCqC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 21:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbVBCCn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 21:43:56 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:31180 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262422AbVBCCnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 21:43:16 -0500
Subject: Re: [PATCH 3/4] readahead: factor out duplicated code
From: Ram <linuxram@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Steven Pratt <slpratt@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <41FB7517.418D556A@tv-sign.ru>
References: <41FB6F45.848CEFF6@tv-sign.ru>  <41FB7517.418D556A@tv-sign.ru>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1107398594.5992.134.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 02 Feb 2005 18:43:14 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-29 at 03:35, Oleg Nesterov wrote:
> > This patch introduces make_ahead_window() function for
> > simplification of page_cache_readahead.
> 
> If you will count this patch acceptable, I'll rediff it against
> next mm iteration.
> 
> For your convenience here is the code with the patch applied.
> 
> int make_ahead_window(mapping, filp, ra, int force)
> {
> 	int block, ret;
> 
> 	ra->ahead_size = get_next_ra_size(ra);
> 	ra->ahead_start = ra->start + ra->size;
> 
> 	block = force || (ra->prev_page >= ra->ahead_start);
> 	ret = blockable_page_cache_readahead(mapping, filp,
> 			ra->ahead_start, ra->ahead_size, ra, block);
> 
> 	if (!ret && !force) {

As steve pointed out this should be :
         if ( !ret && ! block ) {

> 		ra->ahead_start = 0;
> 		ra->ahead_size = 0;
> 	}
> 
> 	return ret;
> }
> 
> unsigned long page_cache_readahead(mapping, ra, filp, offset, req_size)
> {
> 	unsigned long max, newsize = req_size;
> 	int sequential = (offset == ra->prev_page + 1);
> 
> 	if (offset == ra->prev_page && req_size == 1 && ra->size != 0)
> 		goto out;
> 	ra->prev_page = offset;
> 	max = get_max_readahead(ra);
> 	newsize = min(req_size, max);
> 
> 	if (newsize == 0 || (ra->flags & RA_FLAG_INCACHE)) {
> 		newsize = 1;

At this point prev_page has to be updated:
              ra->prev_page = offset;

> 		goto out;
> 	}
> 
> 	ra->prev_page += newsize - 1;
> 
> 	if ((ra->size == 0 && offset == 0) ||
> 	    (ra->size == -1 && sequential)) {
> 		ra->size = get_init_ra_size(newsize, max);
> 		ra->start = offset;
> 		if (!blockable_page_cache_readahead(mapping, filp, offset, ra->size, ra, 1))
> 			goto out;
> 
> 		if (req_size >= max)
> 			make_ahead_window(mapping, filp, ra, 1);
> 
> 		goto out;
> 	}
> 
> 	if (!sequential || (ra->size == 0)) {
> 		ra_off(ra);
> 		blockable_page_cache_readahead(mapping, filp, offset, newsize, ra, 1);
> 		goto out;
> 	}
> 
> 
> 	if (ra->ahead_start == 0) {
> 		if (!make_ahead_window(mapping, filp, ra, 0))
> 			goto out;
> 	}
> 
> 	if (ra->prev_page >= ra->ahead_start) {
> 		ra->start = ra->ahead_start;
> 		ra->size = ra->ahead_size;
> 		make_ahead_window(mapping, filp, ra, 0);
> 	}
> out:
> 	return newsize;
> }
Otherwise this code looks much cleaner and correct. Can you send me a
updated patch. I will run it through my test harness.

RP

