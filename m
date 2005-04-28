Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVD1Drx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVD1Drx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 23:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVD1Drx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 23:47:53 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:41230 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261882AbVD1Drn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 23:47:43 -0400
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, skodati@in.ibm.com
Subject: Re: [PATCH] drop_buffers() shouldn't de-ref page->mapping if its NULL
References: <1114645113.26913.662.camel@dyn318077bld.beaverton.ibm.com>
	<1114646015.26913.668.camel@dyn318077bld.beaverton.ibm.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 28 Apr 2005 12:46:33 +0900
In-Reply-To: <1114646015.26913.668.camel@dyn318077bld.beaverton.ibm.com> (Badari Pulavarty's message of "27 Apr 2005 16:53:38 -0700")
Message-ID: <87k6mn5zs6.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> writes:

> Hi,
>
> I answered my own question. It looks like we could have pages
> with buffers without page->mapping. In such cases, we shouldn't
> de-ref page->mapping in drop_buffers(). Here is the trivial
> patch to fix it.
>
> Thanks,
> Badari

[...]

>
> Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
> --- linux-2.6.12-rc2.org/fs/buffer.c	2005-04-27 07:19:44.000000000 -0700
> +++ linux-2.6.12-rc2/fs/buffer.c	2005-04-27 07:20:34.000000000 -0700
> @@ -2917,7 +2917,7 @@ drop_buffers(struct page *page, struct b
>  
>  	bh = head;
>  	do {
> -		if (buffer_write_io_error(bh))
> +		if (buffer_write_io_error(bh) && page->mapping)
>  			set_bit(AS_EIO, &page->mapping->flags);
>  		if (buffer_busy(bh))
>  			goto failed;

On my experience, this happened the bh leak case only.

If you are not sure whether this is valid state or not, I worry this
patch hides real bug.  How about adding the warning, not just remove
de-ref?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
