Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265089AbUENCeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbUENCeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 22:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264976AbUENCeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 22:34:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:50580 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265089AbUENCd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 22:33:59 -0400
Date: Thu, 13 May 2004 19:33:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: hugh@veritas.com, viro@parcelfarce.linux.theplanet.co.uk,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] truncate vs add_to_page_cache race
Message-Id: <20040513193328.11479d3e.akpm@osdl.org>
In-Reply-To: <40A42892.5040802@yahoo.com.au>
References: <40A42892.5040802@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>  I think there is a race between truncate and do_generic_mapping_read.
> 
>  do_generic_mapping_read()
>  {
>  	check i_size -> ok
>  no_cached_page:
>  	allocate a page
>  	add_to_page_cache
>  	readpage
>  }
> 
>  And what can happen is truncate gets to the file after i_size is
>  checked and before the page is added to the page cache.
> 
>  I asked Hugh about this because a quick search showed he was the
>  last one to make a noise about this kind of thing. He wasn't up
>  to speed with the current code, but agreed it looks fishy.
> 
>  OK, I made a debug patch to printk and schedule_timeout in this
>  race window so I can easily truncate the file. When this happens,
>  it turns out that the readpage thinks it is reading a hole and
>  fills the page with zeros -> invalid result?

A zero-filled pagecache page outside i_size is OK.

If someone extends i_size and reads the page, they get zeros.  If they
truncate the file more, it gets dropped.  If they extend i_size then write
to the page, that's OK.  And page reclaim can reclaim it.

