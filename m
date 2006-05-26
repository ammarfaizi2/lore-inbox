Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWEZRQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWEZRQP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWEZRQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:16:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60345 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751175AbWEZRQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:16:14 -0400
Date: Fri, 26 May 2006 10:15:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn
Subject: Re: [PATCH 15/33] readahead: state based method - routines
Message-Id: <20060526101536.08e7f5be.akpm@osdl.org>
In-Reply-To: <348469543.10865@ustc.edu.cn>
References: <20060524111246.420010595@localhost.localdomain>
	<348469543.10865@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> Define some helpers on struct file_ra_state.
> 
> +/*
> + * The 64bit cache_hits stores three accumulated values and a counter value.
> + * MSB                                                                   LSB
> + * 3333333333333333 : 2222222222222222 : 1111111111111111 : 0000000000000000
> + */
> +static int ra_cache_hit(struct file_ra_state *ra, int nr)
> +{
> +	return (ra->cache_hits >> (nr * 16)) & 0xFFFF;
> +}

So...   why not use four u16s?

> +/*
> + * Submit IO for the read-ahead request in file_ra_state.
> + */
> +static int ra_dispatch(struct file_ra_state *ra,
> +			struct address_space *mapping, struct file *filp)
> +{
> +	enum ra_class ra_class = ra_class_new(ra);
> +	unsigned long ra_size = ra_readahead_size(ra);
> +	unsigned long la_size = ra_lookahead_size(ra);
> +	pgoff_t eof_index = PAGES_BYTE(i_size_read(mapping->host)) + 1;

Sigh.  I guess one gets used to that PAGES_BYTE thing after a while.  If
you're not familiar with it, it obfuscates things.

<hunts around for its definition>

So in fact it's converting a loff_t to a pgoff_t.  Why not call it
convert_loff_t_to_pgoff_t()?  ;)

Something better, anyway.  Something lower-case and an inline-not-a-macro, too.

> +	int actual;
> +
> +	if (unlikely(ra->ra_index >= eof_index))
> +		return 0;
> +
> +	/* Snap to EOF. */
> +	if (ra->readahead_index + ra_size / 2 > eof_index) {

You've had a bit of a think and you've arrived at a design decision
surrounding the arithmetic in here.  It's very very hard to look at this line
of code and to work out why you decided to implement it in this fashion. 
The only way to make such code comprehensible (and hence maintainable) is
to fully comment such things.


