Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWEZHNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWEZHNj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWEZHNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:13:39 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:55968 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751331AbWEZHNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:13:38 -0400
Message-ID: <348627615.10646@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 26 May 2006 15:13:39 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/33] readahead: refactor __do_page_cache_readahead()
Message-ID: <20060526071339.GE5135@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469538.91213@ustc.edu.cn> <20060525093039.21b4246b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525093039.21b4246b.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 09:30:39AM -0700, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> > Add look-ahead support to __do_page_cache_readahead(),
> > which is needed by the adaptive read-ahead logic.
> 
> You'd need to define "look-ahead support" before telling us you've added it ;)
> 
> > @@ -302,6 +303,8 @@ __do_page_cache_readahead(struct address
> >  			break;
> >  		page->index = page_offset;
> >  		list_add(&page->lru, &page_pool);
> > +		if (page_idx == nr_to_read - lookahead_size)
> > +			__SetPageReadahead(page);
> >  		ret++;
> >  	}
> 
> OK.  But the __SetPageFoo() things still give me the creeps.

Hehe, updated to SetPageReadahead().

> OT: look:
> 
> 		read_unlock_irq(&mapping->tree_lock);
> 		page = page_cache_alloc_cold(mapping);
> 		read_lock_irq(&mapping->tree_lock);
> 
> we should have a page allocation function which just allocates a page from
> this CPU's per-cpu-pages magazine, and fails if the magazine is empty:
> 
> 		page = 	alloc_pages_local(mapping_gfp_mask(x)|__GFP_COLD);
> 		if (!page) {
> 			read_unlock_irq(&mapping->tree_lock);
> 			/*
> 			 * This will refill the per-cpu-pages magazine
> 			 */
> 			page = page_cache_alloc_cold(mapping);
> 			read_lock_irq(&mapping->tree_lock);
> 		}

Seems good, except for the alloc_pages_local() not being able to
spread memory among nodes as page_cache_alloc_cold() do.

Wu
