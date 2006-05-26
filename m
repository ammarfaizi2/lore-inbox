Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWEZRjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWEZRjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWEZRjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:39:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751200AbWEZRjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:39:07 -0400
Date: Fri, 26 May 2006 10:38:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn, bart@samwel.tk
Subject: Re: [PATCH 27/33] readahead: laptop mode
Message-Id: <20060526103821.45329b4b.akpm@osdl.org>
In-Reply-To: <348469549.18212@ustc.edu.cn>
References: <20060524111246.420010595@localhost.localdomain>
	<348469549.18212@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
>   /*
>  + * Set a new look-ahead mark at @new_index.
>  + * Return 0 if the new mark is successfully set.
>  + */
>  +static inline int renew_lookahead(struct address_space *mapping,
>  +				struct file_ra_state *ra,
>  +				pgoff_t index, pgoff_t new_index)
>  +{
>  +	struct page *page;
>  +
>  +	if (index == ra->lookahead_index &&
>  +			new_index >= ra->readahead_index)
>  +		return 1;
>  +
>  +	page = find_page(mapping, new_index);
>  +	if (!page)
>  +		return 1;
>  +
>  +	__SetPageReadahead(page);
>  +	if (ra->lookahead_index == index)
>  +		ra->lookahead_index = new_index;
>  +
>  +	return 0;
>  +}
>  +

This is a pagecache page and other CPUs can look it up and play with it. 
The __SetPageReadahead() is quite wrong here.

And we don't have a reference on this page, so this code appears to be racy.

You could fix that by taking and dropping a ref on the page, but it'd be
quicker to take tree_lock and do the SetPageReadahead() while holding it.

This function is too large to inline.
