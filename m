Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263592AbUESAYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbUESAYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 20:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263602AbUESAYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 20:24:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:58301 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263601AbUESAYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 20:24:46 -0400
Date: Tue, 18 May 2004 17:27:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: invalidate_inode_pages2
Message-Id: <20040518172718.773d32c1.akpm@osdl.org>
In-Reply-To: <20040519001520.GO3044@dualathlon.random>
References: <20040519001520.GO3044@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> Something broke in invalidate_inode_pages2 between 2.4 and 2.6, this
> causes malfunctions with mapped pages in 2.6.

What is the malfunction?

> I guess the below untested one liner should be enough to fix it. The
> only single point of invalidate_inode_pages2, is to invalidate _mapped_
> pages too. Otherwise we could as well use invalidate_inode_pages.
> Clearly the dirty bit doesn't mean invalidate, invalidate primarly means
> clearing the uptodate bitflag.
> 
> --- sles/mm/truncate.c.~1~	2004-05-18 19:24:40.000000000 +0200
> +++ sles/mm/truncate.c	2004-05-19 02:09:28.311781864 +0200
> @@ -260,9 +260,10 @@ void invalidate_inode_pages2(struct addr
>  			if (page->mapping == mapping) {	/* truncate race? */
>  				wait_on_page_writeback(page);
>  				next = page->index + 1;
> -				if (page_mapped(page))
> +				if (page_mapped(page)) {
> +					ClearPageUptodate(page);
>  					clear_page_dirty(page);
> -				else
> +				} else
>  					invalidate_complete_page(mapping, page);
>  			}
>  			unlock_page(page);

It's currently the case that pages which are mapped into process pagetables
are always up to date, which sounds like a good invariant to have.  This
changes that rule.  I dunno if it'll break anything though.

