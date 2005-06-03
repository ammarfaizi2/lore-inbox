Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVFCSzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVFCSzc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 14:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVFCSzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 14:55:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:39313 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261500AbVFCSzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 14:55:21 -0400
Date: Fri, 3 Jun 2005 11:55:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] broken fault_in_pages_readable call in
 generic_file_buffered_write.
Message-Id: <20050603115512.1dc23cab.akpm@osdl.org>
In-Reply-To: <20050603175453.GA4220@localhost.localdomain>
References: <20050603175453.GA4220@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> The stack segment grew from bffa7000-c0000000 to bdf08000-c0000000
> by a perfectly valid writev call. That should not happen.
> 
> This is caused by an invalid size on the fault_in_pages_readable call
> in generic_file_buffered_write. The length of the passed buffer needs
> to be clipped to the maximum size of the current iov.

Gad that code has become opaque - I need to stare at it for half an hour.


> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> diffstat:
>  mm/filemap.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff -urpN linux-2.6/mm/filemap.c linux-2.6-patched/mm/filemap.c
> --- linux-2.6/mm/filemap.c	2005-06-03 16:25:21.000000000 +0200
> +++ linux-2.6-patched/mm/filemap.c	2005-06-03 16:25:38.000000000 +0200
> @@ -1968,6 +1968,7 @@ generic_file_buffered_write(struct kiocb
>  	do {
>  		unsigned long index;
>  		unsigned long offset;
> +		unsigned long maxlen;
>  		size_t copied;
>  
>  		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
> @@ -1982,7 +1983,10 @@ generic_file_buffered_write(struct kiocb
>  		 * same page as we're writing to, without it being marked
>  		 * up-to-date.
>  		 */
> -		fault_in_pages_readable(buf, bytes);
> +		maxlen = cur_iov->iov_len - iov_base;
> +		if (maxlen > bytes)
> +			maxlen = bytes;
> +		fault_in_pages_readable(buf, maxlen);

Can you explain the bug a bit more completely?  AFACIT, `bytes' here was
always in the range 0 ..  PAGE_CACHE_SIZE, so how can it have caused large
amounts of the stack segment to have been faulted in?


> While looking at this I wondered
> about another potential issue, fault_in_pages_readable faults the
> pages of the iov into memory by using __get_user(). Nobody has made
> sure that the page really stays in memory. While it is unlikely that
> it gets removed before generic_file_buffered_write has done its jobs,
> in theory on a virtual system that runs under extreme memory pressure
> it can happen that the page is reclaimed immediatly.  So the race that
> is mentioned in the comment is not really fixed...
> 

yup, that's a "well known" problem and we've never come up with an adequate
solution.  It is possible, rarely, to cause that page to get unmapped in
the window which you identify.  It is much harder to cause the page to
actually be reclaimed.  And it is much harder still to cause a mmap/write
deadlock once the page has been reclaimed.  We've been admiring this
problem on and off for four or five years...
