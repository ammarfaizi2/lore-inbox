Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWCaDAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWCaDAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 22:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWCaDAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 22:00:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44512 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750949AbWCaDAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 22:00:20 -0500
Date: Thu, 30 Mar 2006 18:59:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, axboe@suse.de, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] splice: add support for SPLICE_F_MOVE flag
Message-Id: <20060330185956.54961b7b.akpm@osdl.org>
In-Reply-To: <20060330163544.72e50aab.akpm@osdl.org>
References: <200603302109.k2UL9ET0012970@hera.kernel.org>
	<20060330163544.72e50aab.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
>   static void page_cache_pipe_buf_unmap(struct pipe_inode_info *info,
>  >  				      struct pipe_buffer *buf)
>  >  {
>  > -	unlock_page(buf->page);
>  > +	if (!buf->stolen)
>  > +		unlock_page(buf->page);
>  >  	kunmap(buf->page);
>  >  }
> 
>  There go our chances of ever getting rid of kmap().  Is it not feasible to
>  use atomic kmaps throughout this code?

What are the kmaps for, anyway?  afaict they're doing the
kmap-the-page-while-we-run-some-a_ops thing which ceased being a
requirement 3-4 years ago.

The general approach we should take is that the code which actually
modifies a page's contents is the code which is responsible for kmapping
that page.  Use an atomic kmap, memcpy-or-memset, atomic kunmap.  Just four
or five lines.

If we can do that, pipe_buf_operations.map/unmap can be removed.
