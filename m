Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUHSVqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUHSVqO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 17:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267436AbUHSVqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 17:46:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:44722 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267435AbUHSVqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 17:46:10 -0400
Date: Thu, 19 Aug 2004 14:49:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: filemap_fdatawait() wait_on_page_writeback_range(mapping, 0,
 -1)?
Message-Id: <20040819144947.7ad18256.akpm@osdl.org>
In-Reply-To: <20040819201729.GC5278@logos.cnet>
References: <20040819201729.GC5278@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> Hi Andrew,
> 
> I dont understand why we do call wait_on_page_writeback_range() with -1 
> as the "end" argument.

"every page in the file".

> -1 sounds pretty stupid at first, it does unnecessary calls to 
> the radix lookup code.

I guess it could cause one extra call into the lookup code.  There's an
additional check in -mm's wait_on_page_writeback_range() which would prevent
that.

> --- a/mm/filemap.c.orig      2004-08-19 14:36:02.000000000 -0300
> +++ b/mm/filemap.c.isize     2004-08-19 18:17:14.000000000 -0300
> @@ -231,7 +231,7 @@
>   */
>  int filemap_fdatawait(struct address_space *mapping)
>  
> -       return wait_on_page_writeback_range(mapping, 0, -1);
> +       return wait_on_page_writeback_range(mapping, 0, i_size_read(mapping->host));
>  }

That would need a >> PAGE_CACHE_SHIFT
