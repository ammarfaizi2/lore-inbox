Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbVBCK3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbVBCK3E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbVBCK3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:29:03 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:11731 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S263048AbVBCK2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:28:34 -0500
Message-ID: <42020BD2.D2FF82B7@tv-sign.ru>
Date: Thu, 03 Feb 2005 14:32:34 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Pratt <slpratt@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/4] readahead: factor out duplicated code
References: <41FB6F45.848CEFF6@tv-sign.ru> <42014825.1040400@austin.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Pratt wrote:
>
> >+static int make_ahead_window(struct address_space *mapping, struct file *filp,
> >+		struct file_ra_state *ra, int force)
> >+{
> >+	int block, ret;
> >+
> >+	block = force || (ra->prev_page >= ra->ahead_start);
> >+	ret = blockable_page_cache_readahead(mapping, filp,
> >+			ra->ahead_start, ra->ahead_size, ra, block);
> >+
> >+	if (!ret && !force) {
> >
> This really needs to be
>
>     if (!ret && !block) {
>

Current code:

	block = offset + newsize-1 >= ra->ahead_start;
	if (!blockable_page_cache_readahead(..., block) {
		ra->ahead_start = 0;
		ra->ahead_size = 0;
	}

Patched code:
	make_ahead_window(..., 0); // force == 0

So i think the patch is correct.

> otherwise we can have an aheadwindow which was never populated which
> will cause slow reads which we want to avoid in all cases.

may be, but this patch tries not to change the current behavior.

Oleg.
