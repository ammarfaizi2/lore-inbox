Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWEYQbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWEYQbO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWEYQbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:31:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030251AbWEYQbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:31:13 -0400
Date: Thu, 25 May 2006 09:30:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn
Subject: Re: [PATCH 06/33] readahead: refactor __do_page_cache_readahead()
Message-Id: <20060525093039.21b4246b.akpm@osdl.org>
In-Reply-To: <348469538.91213@ustc.edu.cn>
References: <20060524111246.420010595@localhost.localdomain>
	<348469538.91213@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> Add look-ahead support to __do_page_cache_readahead(),
> which is needed by the adaptive read-ahead logic.

You'd need to define "look-ahead support" before telling us you've added it ;)

> @@ -302,6 +303,8 @@ __do_page_cache_readahead(struct address
>  			break;
>  		page->index = page_offset;
>  		list_add(&page->lru, &page_pool);
> +		if (page_idx == nr_to_read - lookahead_size)
> +			__SetPageReadahead(page);
>  		ret++;
>  	}

OK.  But the __SetPageFoo() things still give me the creeps.


OT: look:

		read_unlock_irq(&mapping->tree_lock);
		page = page_cache_alloc_cold(mapping);
		read_lock_irq(&mapping->tree_lock);

we should have a page allocation function which just allocates a page from
this CPU's per-cpu-pages magazine, and fails if the magazine is empty:

		page = 	alloc_pages_local(mapping_gfp_mask(x)|__GFP_COLD);
		if (!page) {
			read_unlock_irq(&mapping->tree_lock);
			/*
			 * This will refill the per-cpu-pages magazine
			 */
			page = page_cache_alloc_cold(mapping);
			read_lock_irq(&mapping->tree_lock);
		}

