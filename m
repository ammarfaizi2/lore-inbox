Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVDZMr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVDZMr6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 08:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVDZMr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 08:47:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:12163 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261420AbVDZMrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 08:47:55 -0400
Date: Tue, 26 Apr 2005 05:47:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] __block_write_full_page bug
Message-Id: <20050426054729.24ab6027.akpm@osdl.org>
In-Reply-To: <1114516820.5097.26.camel@npiggin-nld.site>
References: <426C6A63.80408@yahoo.com.au>
	<20050426045039.702d9075.akpm@osdl.org>
	<1114516820.5097.26.camel@npiggin-nld.site>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> On Tue, 2005-04-26 at 04:50 -0700, Andrew Morton wrote:
>  > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>  > >
>  > >  When running
>  > >  	fsstress -v -d $DIR/tmp -n 1000 -p 1000 -l 2
>  > >  on an ext2 filesystem with 1024 byte block size, on SMP i386 with 4096 byte
>  > >  page size over loopback to an image file on a tmpfs filesystem, I would
>  > >  very quickly hit
>  > >  	BUG_ON(!buffer_async_write(bh));
>  > >  in fs/buffer.c:end_buffer_async_write
>  > > 
>  > >  It seems that more than one request would be submitted for a given bh
>  > >  at a time. __block_write_full_page looks like the culprit - with the
>  > >  following patch things are very stable.
>  > 
>  > What's the bug?  I don't see it.
>  > 
> 
>  Ah, the bug is that end_buffer_async_write first does
>  	BUG_ON(!buffer_async_write(bh));
>  then a bit later does
>  	clear_buffer_async_write(bh);
> 
>  That's where it was blowing up for me, because end_buffer_async_write
>  was being run twice for that buffer.
> 
>  Or did you mean *how* is it being run twice? I didn't exactly find
>  the stack traces involved, but I imagine that simply testing
>  buffer_async_write catches other requests in flight - ie. we've
>  lost track of exactly which ones we own.
> 

How can such a thing come about?  Both PageLocked() and PageWriteback() are
supposed to stop new writeback being started against the page.

<looks>

Were you using nobh?  I guess not.  What's to stop the new
mpage_writepage() from trying to write a page which is already under
PageWriteback()?

I don't think we understand this bug yet.
